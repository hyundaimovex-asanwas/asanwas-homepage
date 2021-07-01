<!--
***********************************************************************
* @source      : pirh010_ED.jsp
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
	String PRT_TYPE		= request.getParameter("PRT_TYPE");
	String ENO_NO    		= request.getParameter("ENO_NO");
	String HIRS_YMD_SHR		= request.getParameter("HIRS_YMD_SHR");
	String HIRD_YMD_SHR		= request.getParameter("HIRD_YMD_SHR");
	String DPT_CD_SHR		= request.getParameter("DPT_CD_SHR");


	StringBuffer sb = new StringBuffer();

	if (PRT_TYPE.equals("BUSOR")){
		sb.append("WHERE  dpt_CD = '" + DPT_CD_SHR + "' \n");
	}else if (PRT_TYPE.equals("INDAY")){
		sb.append("WHERE  HIR_YMD BETWEEN '" + HIRS_YMD_SHR + "' AND '" + HIRD_YMD_SHR + "' \n");
	}else{
		sb.append("WHERE  ENO_NO IN ( " + ENO_NO + ")  \n");
	}

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRD080_SHR");
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    Object[] bind = new Object[] {};

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
	String 	colStr  =   "ENO_NO_1,HEAD_NM_1,ENO_NM_1,CET_NO_1,NAM_ENG_1,ENO_NO_2,HEAD_NM_2,ENO_NM_2,CET_NO_2,NAM_ENG_2,ENO_NO_3,HEAD_NM_3,ENO_NM_3,CET_NO_3,NAM_ENG_3";
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