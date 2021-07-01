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
    String APY_YMD_SHR  = request.getParameter("APY_YMD_SHR");
    String ENO_NO_SHR = request.getParameter("ENO_NO_SHR");

    String sql = XmlSqlUtils.getSQL("ins", "INSC010_SHR_YEAR_BONUS");

    //param binding 하기
    Object[] bind = new Object[] {
    			APY_YMD_SHR,
    			APY_YMD_SHR,
				ENO_NO_SHR
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	//String 	colStr  =   "WORKING_DATE,PIS_YY,PIS_MM,LAST_DAY,PAST_DAY,BAS_AMT,DUTY_AMT,OT_AMT,WEL_AMT,OSE_AMT,RUN_AMT,MH_AMT,LSEV_AMT,AMOUNT20,AMOUNTLU,AMOUNTTR,NMTR,NM20,NMLU";
    String 	colStr  =   "YEAR_BONUS";

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
