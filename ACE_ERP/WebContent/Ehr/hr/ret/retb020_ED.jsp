<!--
***********************************************************************
* @source      : RETB020_ED.jsp
* @description : �����޿����� ������ �μ�
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
String PIS_MM = request.getParameter("PIS_MM");
String PIS_YY = request.getParameter("PIS_YY");

    String sql = XmlSqlUtils.getSQL("ret", "RETB020_PRT");

    //param binding �ϱ�
    Object[] bind = new Object[] {
    		PIS_YY+PIS_MM, //MAIN
    		PIS_YY+PIS_MM, //MAIN
    		PIS_YY+PIS_MM, //MAIN
    		
    		PIS_YY+PIS_MM, //�����̿���
    		PIS_YY+PIS_MM, //�����̿���
    		PIS_YY+PIS_MM, //�����̿���
    		PIS_YY,        //�����̿���
    		
    		PIS_YY+PIS_MM, //���߼�����
            PIS_YY+PIS_MM, //���߼�����
            PIS_YY+PIS_MM, //���߼�����
    		PIS_YY,//���߼�����
    		PIS_MM,//���߼�����
    		
            PIS_YY+PIS_MM, //�������޾�
            PIS_YY+PIS_MM, //�������޾�
            PIS_YY+PIS_MM, //�������޾�
    		PIS_YY+PIS_MM, //�������޾�
    		
    		PIS_YY+PIS_MM, //������������
            PIS_YY+PIS_MM, //������������
            PIS_YY+PIS_MM, //������������
    		PIS_YY,//������������
    		PIS_MM,//������������
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "RIDX,TYPEGBN,REG_NM,IDX,AMT1,AMT2,AMT3,AMT4,AMT5,AMT6,AMT7";
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