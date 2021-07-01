<!--
***********************************************************************
* @source      : insc010_ED.jsp
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
    String ENO_NO_SHR = request.getParameter("ENO_NO_SHR");
    String PAST_DAY1 = request.getParameter("PAST_DAY1");
    String PAST_DAY2 = request.getParameter("PAST_DAY2");
    String PAST_DAY3 = request.getParameter("PAST_DAY3");
    String PAST_DAY4 = request.getParameter("PAST_DAY4");
	String DATE_TERM = request.getParameter("DATE_TERM").replaceAll("-","").substring(0,8);

    String sql = XmlSqlUtils.getSQL("ins", "INSC010_SHR_ETC_SUM_PRT");

    //param binding 하기
    Object[] bind = new Object[] {
    		DATE_TERM,
    		DATE_TERM,
    		DATE_TERM,
    		PAST_DAY1,
    		ENO_NO_SHR,
    		
    		DATE_TERM,
    		DATE_TERM,
    		DATE_TERM,
    		PAST_DAY2,
    		ENO_NO_SHR,
    		
    		DATE_TERM,
    		DATE_TERM,
    		DATE_TERM,
    		PAST_DAY3,
    		ENO_NO_SHR,
    		
    		DATE_TERM,
    		DATE_TERM,
    		DATE_TERM,
    		PAST_DAY4,
    		ENO_NO_SHR    		
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
    String 	colStr  =   "SAL_CD,AMOUNT";

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
