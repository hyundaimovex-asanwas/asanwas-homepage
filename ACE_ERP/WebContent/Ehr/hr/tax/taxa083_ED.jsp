<!--
***********************************************************************
* @source      : taxb010_ED.jsp
* @description : 건강보험 개인별 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      방석호        최초작성.
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
	String PIS_YY = request.getParameter("PIS_YY");

	if (PIS_YY.length() > 4)
	{
		PIS_YY = PIS_YY.substring(0,4);
	}
	String PIS_MM = request.getParameter("PIS_MM");
	String ENO_NO = request.getParameter("ENO_NO");
	String DPT_CD = request.getParameter("DPT_CD");


	String sql = XmlSqlUtils.getSQL("tax2", "TAXB083_PRT");

    //param binding 하기
    Object[] bind = new Object[] {
    	PIS_YY,
   		PIS_YY,
   		PIS_YY,
  		PIS_YY,
  		PIS_YY,
  		ENO_NO,
  		PIS_YY,
  		PIS_MM,
  		ENO_NO,
  		DPT_CD
 	 };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "ENO_NM,ADDRESS,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,CET_NO,STR_YMD,END_YMD,CHICNT_MUNGU";
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
       	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
       	for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
       	}
        	hnwExtQuery.SendData(response);

       }

%>
