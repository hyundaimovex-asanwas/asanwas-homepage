<!--
***********************************************************************
* @source      : taxa131_3_ED.jsp
* @description : �ֹμ�Ư��¡������(��)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      �漮ȣ        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

	String PIS_YY = request.getParameter("PIS_YYMM").substring(0,4);
	String PIS_MM = request.getParameter("PIS_YYMM").substring(4,6);
	String DPT_CD = request.getParameter("DPT_CD");



		String sql = XmlSqlUtils.getSQL("tax2", "TAXA131_PRT3");
		  Object[] bind = new Object[]{
				PIS_YY,
	    		PIS_MM,
	    		DPT_CD,
	    };
			AbstractDAO aaa= new AbstractDAO("default");
		    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
		    extquery hnwExtQuery = new extquery();

		    /** �ʵ尪 ���� **/
		   	String 	colStr  =   "GBN,ENO_NO,INCM_TAX,CITI_TAX,BIGO,DPT_NM,ENO_NM";
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
