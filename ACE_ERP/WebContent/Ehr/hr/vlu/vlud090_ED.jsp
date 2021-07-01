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
	String GUBUN    = request.getParameter("GUBUN");
	String EVL_YY1  = request.getParameter("EVL_YY1");
    String EVL_YY2  = request.getParameter("EVL_YY2");
    String ENO_NO   = request.getParameter("ENO_NO");



/** 외부 XML에서 개인별평가결과현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUD090_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				GUBUN,                         // 업무구분
				EVL_YY1,                     // 해당년도 (FROM)
				EVL_YY2,                      // 해당년도 (TO)
				ENO_NO                       // 사번
		};

	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** 필드값 세팅 **/
	String 	colStr  = "EVL_YY,FINAL_GRD11,FINAL_GRD12,FINAL_GRD13,FINAL_GRD14,FINAL_GRD21,FINAL_GRD22,FINAL_GRD23,FINAL_GRD24";
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