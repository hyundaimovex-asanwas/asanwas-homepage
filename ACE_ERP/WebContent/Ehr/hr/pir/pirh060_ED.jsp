<!--
***********************************************************************
* @source      : pirh060_ED.jsp
* @description : 학력별인원현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     방석호        최초작성.
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
	String HIR_YMD_SHR	= request.getParameter("HIR_YMD_SHR").replaceAll("-", "");
	String OCC_CD_SHR    	= request.getParameter("OCC_CD_SHR");
	String GBN_CD_SHR		= request.getParameter("GBN_CD_SHR");

	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRH060_PRT");


	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {};

	StringBuffer sb = new StringBuffer();


	/** 조회 조건에 따른 처리 **/
	if( ! HIR_YMD_SHR.equals("") ){
		sb.append("AND HIR_YMD <= '"+HIR_YMD_SHR+"' \n");
	}
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

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
		sb.toString(),
		sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
	String 	colStr  =   "JOB_SEQ,RN,JOB_NM,GUR_TOT_CNT,GUR_01_CNT,GUR_02_CNT,GUR_03_CNT,GUR_04_CNT,GUR_ETC_CNT,GUR_TOT_PER,GUR_01_PER,GUR_02_PER,GUR_03_PER,GUR_04_PER,GUR_05_PER";
	String[] values = colStr.split(",");
	for( int x = 0; x < values.length; x++ ){
		hnwExtQuery.AddField(values[x]);
	}
    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

        	for( int x = 0; x < values.length; x++ ){
                hnwExtQuery.AddData(vo.getString(values[x]));
        	}
            hnwExtQuery.SendData(response);
        }
    }
    else
    {
    	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
    	for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
    	}
        hnwExtQuery.SendData(response);

    }
%>