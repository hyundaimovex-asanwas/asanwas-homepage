<!--
***********************************************************************
* @source      : vlud010_ED.jsp 				                                                                                     *
* @description :  ����������Ȳ(vlud010)
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
	String ENO_NO  = request.getParameter("ENO_NO");
	String DPT_CD  = request.getParameter("DPT_CD");
    String HEAD_CD = request.getParameter("HEAD_CD");

	/** �ܺ� XML���� ����������Ȳ���� ������ ��ȸ SQL ���� **/
	String sql = XmlSqlUtils.getSQL("vlu", "VLUD010_SHR_01");

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
	Object[] bind = new Object[] {
			"01",                        // ��������
			EVL_YY,                        // �ش�⵵
			ENO_NO,                      // ���
			DPT_CD,                        // �μ��ڵ�
			HEAD_CD
	};

	  System.out.println("EVL_YY ="+EVL_YY );
	    System.out.println("ENO_NO ="+ENO_NO );
	    System.out.println("DPT_CD ="+DPT_CD );
	    System.out.println("HEAD_CD ="+DPT_CD );

	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** �ʵ尪 ���� **/
	String 	colStr  =   "EVL_YY,ENO_NO,ENO_NM,HEAD_NM,DPT_NM,JOB_NM,FINAL_PNT11,FINAL_GRD11,FINAL_PNT12,FINAL_GRD12,FINAL_PNT13,FINAL_GRD13,FINAL_PNT14,FINAL_GRD14,FINAL_PNT21,FINAL_GRD21,FINAL_PNT22,FINAL_GRD22,FINAL_PNT23,FINAL_GRD23,FINAL_PNT24,FINAL_GRD24";
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