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
	String YYYY = request.getParameter("YYYY");
	String MM = request.getParameter("MM");
	String DD = request.getParameter("DD");

    String sql = XmlSqlUtils.getSQL("gun", "GUNA010_02_PRINT");

    String AT = "A.AT" + Integer.parseInt(DD) + "_CD";
    String GT = "G.AT" + Integer.parseInt(DD) + "_CD";

    //param binding 하기
    Object[] sqlParam = new Object[] {
    		AT
           ,GT
           ,GT
           ,AT               
    };
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
    Object[] bind = new Object[] {       		
    		YYYY,
    		MM,    		
    		DPT_CD_SHR,
    		YYYY+MM+DD,
    		YYYY+MM+DD,
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    /** 필드값 세팅 **/
    String 	colStr  =   "GUN_GBN1,GUN_CNT1,GUN_GBN2,GUN_CNT2,GUN_GBN3,GUN_CNT3";

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
