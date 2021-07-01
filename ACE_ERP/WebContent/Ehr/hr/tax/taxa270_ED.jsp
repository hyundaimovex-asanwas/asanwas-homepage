<!--
***********************************************************************
* @source      : taxa270_ED.jsp
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
	String STR_YMD_SHR     = request.getParameter("STR_YMD_SHR").replaceAll("-", "");
	String END_YMD_SHR     = request.getParameter("END_YMD_SHR").replaceAll("-", "");
	String CEF_RSN_SHR     = request.getParameter("CEF_RSN_SHR");
	String HIR_NM     = request.getParameter("HIR_NM");
	String RET_NM     = request.getParameter("RET_NM");
	String EXP_NM     = request.getParameter("EXP_NM");
	String CAR_NM     = request.getParameter("CAR_NM");

    String sql = null;
    sql = XmlSqlUtils.getSQL("tax", "TAXA270_SHR");
  	System.out.println(sql);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {};

	/** 조회 조건(사용일자)에 따른 처리 **/
	StringBuffer sb = new StringBuffer();
	if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
		sb.append("AND A.SPL_YMD >= '"+STR_YMD_SHR+"' \n");
		sb.append("AND A.SPL_YMD <= '"+END_YMD_SHR+"' \n");
	} else if (!STR_YMD_SHR.equals("") && END_YMD_SHR.equals("")) {
		sb.append("AND A.SPL_YMD >= '"+STR_YMD_SHR+"' \n");
	} else if (STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
		sb.append("AND A.SPL_YMD <= '"+END_YMD_SHR+"' \n");
	}


	// 용도
	if( !CEF_RSN_SHR.equals("0")){
		sb.append("AND A.CEF_RSN = '"+CEF_RSN_SHR+"' \n");
	}

	int num = 0;
	String con = " AND( ";
	if( !HIR_NM.equals("") ){
		con += "A.CEF_SEC = '"+HIR_NM+"'";
		num++;
	}
	if( !RET_NM.equals("") ){
		if( num > 0){ con += " OR "; }
		con += "A.CEF_SEC = '"+RET_NM+"'";
		num++;
	}
	if( !EXP_NM.equals("") ){
		if( num > 0){ con += " OR "; }
		con += "A.CEF_SEC = '"+EXP_NM+"'";
		num++;
	}
	if( !CAR_NM.equals("") ){
		if( num > 0){ con += " OR "; }
		con += "A.CEF_SEC = '"+CAR_NM+"'";
		num++;
	}
	con += ")";

	if( num > 0){
		sb.append(con+" \n");
	}

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
		sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("발급번호");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("이름");

    hnwExtQuery.AddField("증명서종류");
    hnwExtQuery.AddField("용도");
    hnwExtQuery.AddField("매수");
    hnwExtQuery.AddField("발급일");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("CEF_NO"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));

            hnwExtQuery.AddData(vo.getString("CEF_SEC"));
            hnwExtQuery.AddData(vo.getString("CEF_RSN"));
            hnwExtQuery.AddData(vo.getString("CEF_CNT"));
            hnwExtQuery.AddData(vo.getString("SPL_YMD"));

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);
%>