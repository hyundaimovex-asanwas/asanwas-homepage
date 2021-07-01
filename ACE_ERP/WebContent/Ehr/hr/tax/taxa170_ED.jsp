<!--
***********************************************************************
* @source      : taxb030_ED.jsp
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
String ENO_NO = request.getParameter("ENO_NO");
String PRO_YM = request.getParameter("PRO_YM");
String SEQ    = request.getParameter("SEQ");


    String sql = XmlSqlUtils.getSQL("tax2", "TAXB030_PRT");

    //param binding 하기
    Object[] bind = new Object[] {
    		PRO_YM,
    		ENO_NO,
    		SEQ
    	  };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "ENO_NO,OCC_CD,PRO_YM,GBN_CD,SMS_CD,SEQ,SA_UP,OCOUNT,REG_GBN,GSF_YMD,GST_YMD,NAM_KOR,SED_CD,CET_NO,ZIP_NO,ADDRESS,AGY_AMT,ASD_AMT,ADC_AMT,TOT_AMT,HIR_YMD,RET_YMD,LSE_MM,FHIR_YMD,FRET_YMD,FLSE_MM,CLSE_MM,LSE_YY,RET_AMT,RMGR_AMT,RTTAX_AMT,YTTAX_AMT,YTAX_AMT,TAX_AMT,RHGR_DED,ICM_TAX,DBW_TAX,DJM_TAX,DGG_TAX,FICM_TAX,FDBW_TAX,FDGG_TAX,FTOT_TAX,PDT_YMD,UPC_YMD,RPT_YM,TAX_YM,IPT_MAN,IPT_YMD,UPT_MAN,UPT_YMD,ICM_SUB,DBW_SUB,DJM_SUB,SUB_TOT,AVG_AMT";
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
