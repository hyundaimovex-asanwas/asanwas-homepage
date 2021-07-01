<!--
***********************************************************************
* @source      : vlud020_ED.jsp 				                                                                                     *
* @description :  항목별역량평가현황 PAGE
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
	String ENO_NO  = request.getParameter("ENO_NO");
	String DPT_CD  = request.getParameter("DPT_CD");
    String EVL_FRQ = request.getParameter("EVL_FRQ");
    String HEAD_CD = request.getParameter("HEAD_CD");

    	System.out.println("EVL_YY ="+EVL_YY );
	    System.out.println("ENO_NO ="+ENO_NO );
	    System.out.println("DPT_CD ="+DPT_CD );
	    System.out.println("EVL_FRQ ="+EVL_FRQ);
	    System.out.println("HEAD_CD ="+HEAD_CD);

	/** 외부 XML에서 연간집계현황정보 데이터 조회 SQL 읽음 **/
	String sql = XmlSqlUtils.getSQL("vlu", "VLUD020_SHR_01");

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
	Object[] bind = new Object[] {
			"01",                          // 업무구분
			EVL_YY,                        // 해당년도
			"1",					   // 차수
			"01",
			EVL_YY,                        // 해당년도
			"1",                           // 역량평가
			"1",
			ENO_NO,                      // 사번
			DPT_CD,                        // 부서코드
			""
	};




	AbstractDAO aaa= new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

/** 필드값 세팅 **/
	String 	colStr  = "GUBUN,EVL_YY,EVL_FRQ,ENO_NO,DPT_CD,ENO_NM,GROUP_NM,HEAD_NM,DPT_NM,JOB_NM,PNT_211,PNT_212,PNT_213,PNT_221,PNT_222,PNT_223,PNT_231,PNT_232,PNT_233,PNT_111,PNT_112,PNT_113,PNT_121,PNT_122,PNT_123,PNT_131,PNT_132,PNT_133";
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