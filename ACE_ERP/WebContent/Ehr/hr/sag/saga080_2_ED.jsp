<!--
***********************************************************************
* @source      : saga080_2_ED.jsp
* @description : 급여총괄표
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
	String PIS_YYMM_SHR = request.getParameter("PIS_YYMM_SHR");
	String OCC_CD_SHR 	= request.getParameter("OCC_CD_SHR");
	String DPT_CD_SHR  	= request.getParameter("DPT_CD_SHR");
	String TOTAL_SHR 		= request.getParameter("TOTAL_SHR");
	String GUBUN  				= request.getParameter("GUBUN");
	String CD_GBN_SHR  	= request.getParameter("CD_GBN_SHR");
	String sql ="";

	//소속별
 	if (CD_GBN_SHR.equals("1")){
		/** 외부 XML에서 SQL을 읽어 온다 **/
		sql = XmlSqlUtils.getSQL("sag", "SAGA080_SHR_04");
 	}
 	else
 	{
		/** 외부 XML에서 SQL을 읽어 온다 **/
		sql = XmlSqlUtils.getSQL("sag", "SAGA080_SHR_03");
 	}
 	Object[]  bind = new Object[] {
			OCC_CD_SHR,
			OCC_CD_SHR,
			PIS_YYMM_SHR.replaceAll("-", ""),
			PIS_YYMM_SHR.replaceAll("-", ""),
			OCC_CD_SHR,
			PIS_YYMM_SHR.substring(0,4),
			PIS_YYMM_SHR.substring(5,7),
	};


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "COMM_NM,BEF_PERSONS,BEF_AMT,AFT_PERSONS,AFT_AMT";
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
