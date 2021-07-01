<!--
***********************************************************************
* @source      : pirh010_ED.jsp
* @description : �зº��ο���Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     �漮ȣ        �����ۼ�.
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

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRD080_SHR");
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    Object[] bind = new Object[] {};

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
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
    	// hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
    	for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
    	}
        hnwExtQuery.SendData(response);

    }
%>