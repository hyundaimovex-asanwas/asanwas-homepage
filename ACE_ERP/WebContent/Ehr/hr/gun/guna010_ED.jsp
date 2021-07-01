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
	String DPT_CD_SHR     	= request.getParameter("DPT_CD_SHR");	
	String GUN_YMD_SHR     	= request.getParameter("GUN_YMD_SHR").replaceAll("-","");	
	String OCC_CD_SHR    	= request.getParameter("OCC_CD_SHR");
	
	String YYYY = request.getParameter("YYYY");
	String MM = request.getParameter("MM");
	String DD = request.getParameter("DD");
	
    String sql = XmlSqlUtils.getSQL("gun", "GUNA010_01_PRINT");
    
    String AT = "AT" + Integer.parseInt(DD) + "_CD";
    //param binding 하기
    Object[] sqlParam = new Object[] {
    		AT
           ,AT
           ,AT
    };
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    

    //param binding 하기
    Object[] bind = new Object[] {    			
    		GUN_YMD_SHR,
    		YYYY,
    		MM,
    		YYYY,
    		MM,
    		YYYY+MM+DD,
    		YYYY+MM+DD,
    		DPT_CD_SHR,
    		OCC_CD_SHR,
    		DPT_CD_SHR,
    		OCC_CD_SHR,
    		GUN_YMD_SHR,
    		GUN_YMD_SHR,
    		YYYY,
    		MM,
    		YYYY,
    		DPT_CD_SHR,
    		YYYY,
    		YYYY,
    		YYYY,
    		MM,
    		DD,
    		YYYY,
    		GUN_YMD_SHR,
    		GUN_YMD_SHR,
    		GUN_YMD_SHR,
    		GUN_YMD_SHR,
    		YYYY,
    		MM
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
    String 	colStr  =   "GUN_YMD,ENO_NO,PIS_YY,PIS_MM,REMARK,DTL_STS,JOB_NM,ENO_NM,JOB_SEQ,MF_TAG,GUN_GBN,GUN_GBN_CP,DPT_CNT,ATT_Z,ATT_Z_USE,ATT_S,ATT_S_USE,ATT_Q,ATT_Q_USE,ATT_Q_USE_DTL,YRP_CNT,YRP_USE,HOL_YMD,HALF_YMD,PLAN_YN,BUT_YN,OBUT_YN,ACC_YN,HIRG_YMD";

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
