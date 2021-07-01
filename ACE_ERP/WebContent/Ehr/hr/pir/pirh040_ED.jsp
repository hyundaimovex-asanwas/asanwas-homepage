<!--
***********************************************************************
* @source      : idta020_ED.jsp
* @description : 증명서발급처리
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
	String HIR_YMD_SHR     = request.getParameter("HIR_YMD_SHR");
	String OCC_CD_SHR     = request.getParameter("OCC_CD_SHR");
	String GBN_CD_SHR     = request.getParameter("GBN_CD_SHR");
	String FLAG_SHR     = request.getParameter("FLAG_SHR");
	String HIR_SHR_01     = request.getParameter("HIR_SHR_01").replaceAll("-","");
	String HIR_SHR_02     = request.getParameter("HIR_SHR_02").replaceAll("-","");

	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRH040_PRT");



	StringBuffer sb = new StringBuffer();

	/** 조회 조건에 따른 처리 **/
	if( ! OCC_CD_SHR.equals("0") ){
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}
	if( ! GBN_CD_SHR.equals("0") ){
		if( GBN_CD_SHR.equals("1") ){
			sb.append("AND GBN_CD  = '1' \n"); // 본사 만
		}else{
			sb.append("AND GBN_CD != '1' \n"); // 본사(1) 가 아닌 모두
		}
	}

	String stYMD = "";
	String enYMD = "";
	if( (! HIR_SHR_01.equals("") && ! HIR_SHR_01.equals("0")) && (! HIR_SHR_02.equals("") && ! HIR_SHR_02.equals("0")) ){
		stYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_01)+HIR_YMD_SHR.substring(4);
		enYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_02)+HIR_YMD_SHR.substring(4);
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') <= '"+stYMD.replaceAll("-","")+"' \n");
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') >= '"+enYMD.replaceAll("-","")+"' \n");
	}else if( (! HIR_SHR_01.equals("") && ! HIR_SHR_01.equals("0")) && (HIR_SHR_02.equals("") || HIR_SHR_02.equals("0")) ){
		stYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_01)+HIR_YMD_SHR.substring(4);
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') <= '"+stYMD.replaceAll("-","")+"' \n");
	}else if( (HIR_SHR_01.equals("") || HIR_SHR_01.equals("0")) && ( ! HIR_SHR_02.equals("") && ! HIR_SHR_02.equals("0")) ){
		enYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_02)+HIR_YMD_SHR.substring(4);
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') >= '"+enYMD.replaceAll("-","")+"' \n");
	}

	if( FLAG_SHR.equals("HIR") ){
		sb.append("AND HIR_YMD IS NOT NULL \n");
	}else{
		sb.append("AND HIRG_YMD IS NOT NULL \n");
	}

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			HIR_YMD_SHR,
	};

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
		sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);
    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("직위");
     hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("이름");
    hnwExtQuery.AddField("생년월일");
    hnwExtQuery.AddField("졸업일");

    hnwExtQuery.AddField("최종학력");
    hnwExtQuery.AddField("당사입사일");
    hnwExtQuery.AddField("승진일");
    hnwExtQuery.AddField("근속년월");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

           hnwExtQuery.AddData(vo.getString("JOB_NM"));
             hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("GUR_YMD"));

            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
            hnwExtQuery.AddData(vo.getString("DMONTH"));


            hnwExtQuery.SendData(response);
        }
    }
%>