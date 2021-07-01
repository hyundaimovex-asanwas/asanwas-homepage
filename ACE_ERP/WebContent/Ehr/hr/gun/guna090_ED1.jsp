<!--
***********************************************************************
* @source      : guna090_ED1.jsp
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
	String OCC_CD_SHR     	= request.getParameter("OCC_CD_SHR");
	String PIS_YMD_SHR     	= request.getParameter("PIS_YMD_SHR");

	String AT = "AT" + Integer.parseInt(PIS_YMD_SHR.substring(6,8)) + "_CD";
	String OCC_CD = "";

    String sql = XmlSqlUtils.getSQL("gun", "GUNA090_SHR_PRINT");

    if(OCC_CD_SHR.equals("A")){
    	OCC_CD = "                        AND    A.OCC_CD = 'A' \n";
    }else if(OCC_CD_SHR.equals("M")){
    	OCC_CD = "                        AND    A.OCC_CD = 'M' \n";
    }else{
    	OCC_CD = "";
    }



    //param binding 하기
    Object[] sqlParam = new Object[] {

    		OCC_CD,
    		AT,
    		AT,
    		AT,
    		AT,

    		AT,
    		AT,
    		AT,
    		AT,
    		AT,

    		AT,
    		AT,
    		AT,
    		AT,
    		AT,

    		AT,
    		AT,
    		AT,
    		AT,
    		AT,

    		AT,
    		AT,
    		AT,
    		AT,
    		AT,
    		AT,

    		AT,
    		AT,
    		AT,
    		OCC_CD,

    };

    sql = SqlUtils.replaceQuery(sql, sqlParam);

    //param binding 하기
    Object[] bind = new Object[] {
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,

    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,

    		PIS_YMD_SHR,
    		PIS_YMD_SHR,

    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
       		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,
    		PIS_YMD_SHR,

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
    String 	colStr = "GBN2_TAG,SEQ,DPT_CD,DPT_NM,ENO_CNT,SA_CNT,E,UT,FG,Q,PRV,H,ZS,I,AB,LJK,C";

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
