<!--
***********************************************************************
* @source      : crua010_person_ED.jsp
* @description : �ο���Ȳ(����)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/24      �漮ȣ        �����ۼ�.
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

	String REGNO     = request.getParameter("REGNO");
	String PASSTAG     = request.getParameter("PASSTAG");


    String sql = null;
    sql = XmlSqlUtils.getSQL("cru", "CRUA010_FAMILY");

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			REGNO
	};

	 AbstractDAO aaa= new AbstractDAO("default");

     DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

     extquery hnwExtQuery = new extquery();


	/** �ʵ尪 ���� **/
		String 	colStr  =   "REG_NO,	SEQ_NO,	REG_ENO_NM,FREL,FENO_NM,FAGE,FSCH,FJOB,	FJOBNM,FJOBPST, LIVEIN";
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