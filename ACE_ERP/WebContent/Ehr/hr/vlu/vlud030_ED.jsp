<!--
***********************************************************************
* @source      : vlud030_ED.jsp 				                                                                                     *
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
	String EVL_YY  = request.getParameter("EVL_YY");
	String EVL_GBN  = request.getParameter("EVL_GBN");
	String EVL_FRQ  = request.getParameter("EVL_FRQ");
	String HEAD_CD  = request.getParameter("HEAD_CD");

	/** �ܺ� XML���� ����������Ȳ���� ������ ��ȸ SQL ���� **/
	String sql = XmlSqlUtils.getSQL("vlu", "VLUD030_SHR_01");

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
	Object[] bind = new Object[] {
			"01",                         // ��������
			EVL_YY,                    // �ش�⵵
			EVL_GBN,                     // ����/��������
			EVL_FRQ,                     // ȸ��
			HEAD_CD                      // �μ��ڵ�
	};


	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** �ʵ尪 ���� **/
	String 	colStr  = "GUBUN,EVL_YY,EVL_GBN,EVL_FRQ,DPT_CD,GROUP_CD,HEAD_NM,DPT_NM,GROUP_NM,TOT_CNT,FINAL_GRD_S,FINAL_GRD_A,FINAL_GRD_B,FINAL_GRD_C,FINAL_GRD_D";
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