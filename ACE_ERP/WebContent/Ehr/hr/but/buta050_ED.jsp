<!--
***********************************************************************
* @source      : buta050_ED.jsp
* @description : �����������Ȳǥ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/05     �漮ȣ        �����ۼ�.
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
	String STR_YMD = request.getParameter("STR_YMD");
	String END_YMD 	= request.getParameter("END_YMD");
	String CD_GBN  	= request.getParameter("CD_GBN");

	/** �ܺ� XML���� SQL�� �о� �´� **/
	String query = "";
	if("A4".equals(CD_GBN)){
		query = "BUTA050_SHR_02";
	}else if("A2".equals(CD_GBN)){
		query = "BUTA050_SHR_01";
	}else {
		query = "BUTA050_SHR_03";
	}
	String sql =  XmlSqlUtils.getSQL("but", query);

	/** ��ȸ ����(�Ⱓ)�� ���� ó�� #1 **/
	StringBuffer sb = new StringBuffer();
	if (CD_GBN.equals("A4")) {
		sb.append("A.DPT_CD");
	}else if (CD_GBN.equals("A2")) {
		sb.append("A.JOB_CD");
	}else{
		sb.append(" AND 1 = 1");
		CD_GBN = "1";
	}

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			CD_GBN,
			STR_YMD.replaceAll("-", ""),
			END_YMD.replaceAll("-", ""),
			"Y",
			CD_GBN
	};


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "COMM_NM,APP_CNT,AMOUNT,CD_GBN,REMARK";
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
