<!--
***********************************************************************
* @source      : vlud030_ED.jsp 				                                                                                     *
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
String EVL_YY  = request.getParameter("EVL_YY");
String EVL_GBN = request.getParameter("EVL_GBN");
String EVL_FRQ = request.getParameter("EVL_FRQ");
String ENO_NO  = request.getParameter("ENO_NO");
String DPT_CD  = request.getParameter("DPT_CD");

/** 외부 XML에서 평가자별평가현황 데이터 조회 SQL 읽음 **/
String sql = XmlSqlUtils.getSQL("vlu", "VLUD040_SHR_01");

/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
Object[] bind = new Object[] {
		"01",                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                     // 회차
		"01",                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                     // 회차
		ENO_NO,                      // 사번
		DPT_CD                        // 부서코드
};

	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** 필드값 세팅 **/
	String 	colStr  = "GUBUN,EVL_YY,EVL_GBN,EVL_FRQ,COM_AVG,COM_STDDEV,ENO_NO,ENO_NM,CNT,EVL_AVG,EVL_STDDEV,GROUP_NM,HEAD_NM,JOB_NM,DPT_NM";
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