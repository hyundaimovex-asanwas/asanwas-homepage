<!--
***********************************************************************
* @source      : RETa020_ED.jsp
* @description : 퇴직급여신청내역 인쇄
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
	String PIS_SDAY = request.getParameter("PIS_SDAY");
	String PIS_EDAY = request.getParameter("PIS_EDAY");
	String DPT_CD = request.getParameter("DPT_CD");
	String APP_YN = request.getParameter("APP_YN");

    String sql = XmlSqlUtils.getSQL("ret", "RETA020_PRT");

    //param binding 하기
    Object[] bind = new Object[] {
    		PIS_SDAY,
    		PIS_EDAY,
    		DPT_CD,
    		APP_YN
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "DPT_NM,ENO_NO,ENO_NM,OCC_CD,OCC_NM,JOB_NM,HIRG_YMD,RAM_YMD,SEQ_NO,STR_YMD,BASIC_YMD,APP_YN,APP_YMD,APP_PAY,REASON,IS_PROC,ICM_TAX,DBW_TAX,DJM_TAX,IPT_YMD,CITIB,CTMMDA,HANEXP,UCKSDM,WMMDA,WOMMDA,CHBMP,A1,NPER,A3,BPER,NPAY,BPAY,SANG,NAMT,BAMT,SAMT,SPER,CHBMP_NM,CITIB_NM,CTMMDA_NM,HANEXP_NM,UCKSDM_NM,WMMDA_NM,WOMMDA_NM,TNAMT,TBAMT";

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
