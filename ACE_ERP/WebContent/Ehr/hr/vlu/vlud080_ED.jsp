<!--
***********************************************************************
* @source      : vlud070_ED.jsp 				                                                                                     *
* @description :  본부별평가현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/28     방석호        최초작성.
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
String GUBUN  = request.getParameter("GUBUN");
String EVL_YY  = request.getParameter("EVL_YY");
String EVL_GBN  = request.getParameter("EVL_GBN");
String EVL_FRQ  = request.getParameter("EVL_FRQ");



/** 외부 XML에서 평정현황(본부별) 데이터 조회 SQL 읽음 **/
String sql = XmlSqlUtils.getSQL("vlu", "VLUD080_SHR_01");

/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
Object[] bind = new Object[] {
		GUBUN,                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                    // 회차
		GUBUN,                       // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ                    // 회차

};


	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** 필드값 세팅 **/
	String 	colStr  = "OCC_NM,HEAD_SEQ,HEAD_NM,RNUM,S_DPT,S_JOB,S_ENO,A_DPT,A_JOB,A_ENO,C_DPT,C_JOB,C_ENO,D_DPT,D_JOB,D_ENO,S_CNT,A_CNT,B_CNT,C_CNT,D_CNT,GUBUN,EVL_YY,EVL_GBN,EVL_FRQ,OCC_CD";
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