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
String GUBUN  = request.getParameter("GUBUN");
String EVL_YY  = request.getParameter("EVL_YY");
String EVL_GBN  = request.getParameter("EVL_GBN");
String EVL_FRQ  = request.getParameter("EVL_FRQ");



/** �ܺ� XML���� ������Ȳ(���κ�) ������ ��ȸ SQL ���� **/
String sql = XmlSqlUtils.getSQL("vlu", "VLUD080_SHR_01");

/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
Object[] bind = new Object[] {
		GUBUN,                        // ��������
		EVL_YY,                        // �ش�⵵
		EVL_GBN,                     // ����/��������
		EVL_FRQ,                    // ȸ��
		GUBUN,                       // ��������
		EVL_YY,                        // �ش�⵵
		EVL_GBN,                     // ����/��������
		EVL_FRQ                    // ȸ��

};


	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** �ʵ尪 ���� **/
	String 	colStr  = "OCC_NM,HEAD_SEQ,HEAD_NM,RNUM,S_DPT,S_JOB,S_ENO,A_DPT,A_JOB,A_ENO,C_DPT,C_JOB,C_ENO,D_DPT,D_JOB,D_ENO,S_CNT,A_CNT,B_CNT,C_CNT,D_CNT,GUBUN,EVL_YY,EVL_GBN,EVL_FRQ,OCC_CD";
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