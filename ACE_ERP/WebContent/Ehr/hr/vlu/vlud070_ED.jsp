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
String HEAD_CD  = request.getParameter("HEAD_CD");


/** 외부 XML에서 평정현황(본부별) 데이터 조회 SQL 읽음 **/
String sql = XmlSqlUtils.getSQL("vlu", "VLUD070_SHR_01");

/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
Object[] bind = new Object[] {
		GUBUN,                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                    // 회차
		GUBUN,                       // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                    // 회차
		GUBUN,                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                     // 회차
		GUBUN,                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                     // 회차
		HEAD_CD,
		GUBUN,                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                     // 회차
		GUBUN,                       // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                     // 회차
		GUBUN,                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                     // 회차
		GUBUN,                        // 업무구분
		EVL_YY,                        // 해당년도
		EVL_GBN,                     // 역량/성과구분
		EVL_FRQ,                      // 회차
		HEAD_CD
};


	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** 필드값 세팅 **/
	String 	colStr  = "TYPE,IDX,OCC_NM,GROUP_NM,GRD_NM,TOT_CNT,S_CNT,S_PERS,A_CNT,A_PERS,B_CNT,B_PERS,C_CNT,C_PERS,D_CNT,D_PERS";
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