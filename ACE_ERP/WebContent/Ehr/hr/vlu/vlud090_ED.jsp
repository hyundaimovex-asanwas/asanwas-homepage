<!--
***********************************************************************
* @source      : vlud070_ED.jsp 				                                                                                     *
* @description :  ���κ�����Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/28     �漮ȣ        �����ۼ�.
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
	String GUBUN    = request.getParameter("GUBUN");
	String EVL_YY1  = request.getParameter("EVL_YY1");
    String EVL_YY2  = request.getParameter("EVL_YY2");
    String ENO_NO   = request.getParameter("ENO_NO");



/** �ܺ� XML���� ���κ��򰡰����Ȳ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUD090_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				GUBUN,                         // ��������
				EVL_YY1,                     // �ش�⵵ (FROM)
				EVL_YY2,                      // �ش�⵵ (TO)
				ENO_NO                       // ���
		};

	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** �ʵ尪 ���� **/
	String 	colStr  = "EVL_YY,FINAL_GRD11,FINAL_GRD12,FINAL_GRD13,FINAL_GRD14,FINAL_GRD21,FINAL_GRD22,FINAL_GRD23,FINAL_GRD24";
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