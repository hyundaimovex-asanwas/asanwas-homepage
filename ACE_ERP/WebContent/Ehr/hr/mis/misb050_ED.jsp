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
	String STR_MM 	= request.getParameter("STR_MM").replaceAll("-", "");
	String END_MM 	= request.getParameter("END_MM").replaceAll("-", "");
	String DPT_CD = request.getParameter("DPT_CD");
	String ENO_NO = request.getParameter("ENO_NO");

	StringBuffer sb = new StringBuffer();

	if (ENO_NO.length()>0){
		sb.append(" AND A.ENO_NO = '" + ENO_NO + "' \n");
	}

	if (DPT_CD.length()>0){
		sb.append(" AND B.DPT_CD = '" + DPT_CD + "' \n");
	}

	sb.append(" AND  A.APP_YMD BETWEEN '" + STR_MM + "' AND '" + END_MM + "' \n");

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	String sql = XmlSqlUtils.getSQL("mis", "MISB050_SHR");
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** �ܺ� XML���� SQL�� �о� �´� **/

	Object[] bind = new Object[] {
	};
	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "ENO_NO,ENO_NM,CET_NO,STR_YMD,SEQ_NO,OCC_CD,OCC_NM,END_YMD,APP_CD,OLD_APP_CD,APP_NM,HEAD_CD,HEAD_NM,DPT_CD,DPT_NM,TEAM_CD,TEAM_NM,JOB_CD,JOB_NM,HOB_CD,HOB_NM,DUTY_CD,DUTY_NM,SRV_CD,SRV_NM,PART_CD,PART_NM,CHIEF_YN,JCD_CD,JCD_NM,APP_YMD,REMARK";

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
