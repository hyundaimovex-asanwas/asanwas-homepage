<!--
***********************************************************************
* @source      : misb010_ED.jsp
* @description : ��������Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11     �漮ȣ        �����ۼ�.
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
String TOT_YY     = request.getParameter("TOT_YY");
String STR_YM 	  = request.getParameter("STR_YM");
String END_YM     = request.getParameter("END_YM");
String NXT_YY 	  = request.getParameter("NXT_YY");
String NXT_MM     = request.getParameter("NXT_MM");

	String sql = XmlSqlUtils.getSQL("mis", "MISB030_SHR");

	/** �ܺ� XML���� SQL�� �о� �´� **/

	Object[] bind = new Object[] {
			TOT_YY,
			STR_YM,
			END_YM,

			TOT_YY,
			STR_YM,
			END_YM,
			NXT_YY,
			NXT_MM
	};

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "GBN_NM,CNT1,CNT2,CNT3,SUM_PAY1,SUM_PAY2,SUM_PAY3";

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
