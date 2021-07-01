<!--
***********************************************************************
* @source      : RETB020_ED.jsp
* @description : 퇴직급여충당금 명세서 인쇄
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
String PIS_MM = request.getParameter("PIS_MM");
String PIS_YY = request.getParameter("PIS_YY");

    String sql = XmlSqlUtils.getSQL("ret", "RETB020_PRT");

    //param binding 하기
    Object[] bind = new Object[] {
    		PIS_YY+PIS_MM, //MAIN
    		PIS_YY+PIS_MM, //MAIN
    		PIS_YY+PIS_MM, //MAIN
    		
    		PIS_YY+PIS_MM, //전년이월금
    		PIS_YY+PIS_MM, //전년이월금
    		PIS_YY+PIS_MM, //전년이월금
    		PIS_YY,        //전년이월금
    		
    		PIS_YY+PIS_MM, //기중설정액
            PIS_YY+PIS_MM, //기중설정액
            PIS_YY+PIS_MM, //기중설정액
    		PIS_YY,//기중설정액
    		PIS_MM,//기중설정액
    		
            PIS_YY+PIS_MM, //기중지급액
            PIS_YY+PIS_MM, //기중지급액
            PIS_YY+PIS_MM, //기중지급액
    		PIS_YY+PIS_MM, //기중지급액
    		
    		PIS_YY+PIS_MM, //전월누계충당금
            PIS_YY+PIS_MM, //전월누계충당금
            PIS_YY+PIS_MM, //전월누계충당금
    		PIS_YY,//전월누계충당금
    		PIS_MM,//전월누계충당금
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
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
       	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
       	for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
       	}
           hnwExtQuery.SendData(response);

       }

%>
