<!--
***********************************************************************
* @source      : vlud050_ED.jsp 				                                                                                     *
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

	String APPLY_GBN  = request.getParameter("APPLY_GBN");
	String ENO_NO  = request.getParameter("ENO_NO");
	String DPT_CD  = request.getParameter("DPT_CD");
	String EVL_YY1 = request.getParameter("EVL_YY1");
	String EVL_YY2 = request.getParameter("EVL_YY2");
	String EVL_YY3 = request.getParameter("EVL_YY3");
	String EVL_YY4 = request.getParameter("EVL_YY4");
	String EVL_YY5 = request.getParameter("EVL_YY5");

	/** �ܺ� XML���� ���ں�����Ȳ ������ ��ȸ SQL ���� **/
	String sql = XmlSqlUtils.getSQL("vlu", "VLUD050_PRT");

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
	Object[] bind = new Object[] {
			EVL_YY1,                      // �ش�⵵
			EVL_YY2,                      // �ش�⵵
			EVL_YY3,                      // �ش�⵵
			EVL_YY4,                      // �ش�⵵
			EVL_YY5,                      // �ش�⵵
			DPT_CD,                       // �μ��ڵ�
			ENO_NO,                      // ���
			"01",                      // ��������
			APPLY_GBN                // �ݿ�����
			};


	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** �ʵ尪 ���� **/
	String 	colStr  = "HEAD_SEQ,DPT_SEQ,JOB_SEQ,HOB_SEQ,HIRG_YMD,HEAD_NM,DPT_NM,JOB_NM,ENO_NO,ENO_NM,TOT_APPLY_RATE1,TOT_APPLY_RATE2,TOT_APPLY_RATE3,TOT_APPLY_RATE4,TOT_APPLY_RATE5";
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