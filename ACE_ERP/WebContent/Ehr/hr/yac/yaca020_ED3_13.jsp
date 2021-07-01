<!--
***********************************************************************
* @source      : yaca020_ED3.jsp
* @description : 소득공제신고서
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2013/01/08      이동훈        최초작성.
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
String ENO_NO = request.getParameter("ENO_NO");
String PIS_YYMM = request.getParameter("PIS_YYMM");
if (PIS_YYMM.length() > 4)
{
	PIS_YYMM = PIS_YYMM.substring(0,4);
}

    String sql = XmlSqlUtils.getSQL("yac", "YACA020_PRT_2013_03");
    
    //param binding 하기
    Object[] bind = new Object[] {		
    		ENO_NO,
    		PIS_YYMM,    		
    		PIS_YYMM,
    		ENO_NO,
    	  };

    AbstractDAO aaa= new AbstractDAO("default");
    
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
 
   	String 	colStr  =   "PIS_YY,ENO_NO,LF1_AMT,ANN_AMT,LFA_SUM_AMT,LHO_AMT,LHR_AMT,LHP_AMT,LHQ_AMT,LLL_SUM_AMT,VEN_AMT,VEN2_AMT,VEN_SUM_AMT,CARD_AMT,DIR_CARD_AMT,CASH_AMT,MARKET_AMT,PUBLIC_AMT,CCG_SUM_AMT,GIBUGO,ENO_NM,JAS_NM,JAO_NO,JAA_SUM_AMT,JALN_SUM_AMT,TODAY";   


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
