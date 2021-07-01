<!--
***********************************************************************
* @source      : misb010_ED.jsp
* @description : 이직율현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11     방석호        최초작성.
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
String TOT_YY     = request.getParameter("TOT_YY");
String STR_YM 	  = request.getParameter("STR_YM");
String END_YM     = request.getParameter("END_YM");
String NXT_YY 	  = request.getParameter("NXT_YY");
String NXT_MM     = request.getParameter("NXT_MM");

	String sql = XmlSqlUtils.getSQL("mis", "MISB030_SHR");

	/** 외부 XML에서 SQL을 읽어 온다 **/

	Object[] bind = new Object[] {
			TOT_YY,
			STR_YM,
			END_YM,

			TOT_YY,
			STR_YM,
			END_YM,
			NXT_YY,
			NXT_MM
	};

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "GBN_NM,CNT1,CNT2,CNT3,SUM_PAY1,SUM_PAY2,SUM_PAY3";

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
