<!--
***********************************************************************
* @source      : sag010_ED.jsp
* @description : �޿����̺���Ʈ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/08     �漮ȣ        �����ۼ�.
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
	String APY_YMD_SHR = request.getParameter("APY_YMD_SHR");
	String OCC_CD_SHR 	= request.getParameter("OCC_CD_SHR");
	String JOB_CD_SHR = request.getParameter("JOB_CD_SHR");



	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("sag", "SAGA010_SHR");

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			APY_YMD_SHR.replaceAll("-", ""),
			OCC_CD_SHR,
			JOB_CD_SHR
	};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "APY_YMD,OCC_CD,JOB_CD,HOB_CD,BAS_AMT,DUTY_AMT,OT_AMT,WEL_AMT,OSE_AMT,RUN_AMT,MH_AMT,OCC_NM,JOB_NM";

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
