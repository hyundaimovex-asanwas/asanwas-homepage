<!--
***********************************************************************
* @source      : taxa160_ED_2014_3.jsp
* @description : 근로소득원천징수영수증
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
	String ENO_NO = request.getParameter("ENO_NO");
	String PIS_YYMM = request.getParameter("PIS_YYMM");
	String TAX_GBN = request.getParameter("TAX_GBN");

	if (PIS_YYMM.length() > 4)
	{
		PIS_YYMM = PIS_YYMM.substring(0,4);
	}

    String sql = XmlSqlUtils.getSQL("tax2", "TAXB160_PRT_2014_3");

    //param binding 하기
    Object[] bind = new Object[] {
    		ENO_NO,
    		PIS_YYMM,
    		ENO_NO
   };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "REL_CD,TYPE,FAM_NM,CET_NO,BAS_MAN,GOL_70,TRB_MAN,WCT_MAN,ONE_MAN,HIN_SUM,LIN_AMT_NTS,LIN_AMT,MED_AMT_NTS,MED_AMT,EDU_AMT_NTS,EDU_AMT,CARD_AMT_NTS,CARD_AMT,DIR_CARD_AMT_NTS,DIR_CARD_AMT,CASH_AMT_NTS,CASH_AMT,MARKET_AMT_NTS,MARKET_AMT,PUBLIC_AMT_NTS,PUBLIC_AMT,GIBU_AMT_NTS,GIBU_AMT";
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
