<!--
***********************************************************************
* @source      : insc020_ED.jsp
* @description : �ֱ�5�Ⱓ����߻���Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/15     �漮ȣ        �����ۼ�.
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
String STR_YMD = request.getParameter("STR_YMD").replaceAll("-","");


String sql = XmlSqlUtils.getSQL("ins", "INSC020_PRT");

	Object[] bind = new Object[] {
			STR_YMD,
			STR_YMD
	};
	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "SAN_YEAR,REQ_NO,ENO_NO,ENO_NM,DPT_CD,DPT_NM,JOB_CD,JOB_NM,CET_NO,HIRG_YMD,SAN_YMD,SAN_NAM,SAN_REM,HDC_GRA,HDC_CD,HDC_NM,MED_AMT,HDC_AMT,SUR_AMT,SHR_YMD,TMR_DD,TMR_NM,SAL_AMT,AVG_AMT,DAY_AMT,REC_AMT,REMARK";

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
