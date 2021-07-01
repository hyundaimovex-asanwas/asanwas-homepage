<!--
***********************************************************************
* @source      : buta091_ED.jsp
* @description : 해외출장비품의서
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/08     방석호        최초작성.
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
	String STR_YMD = request.getParameter("STR_YMD");
	String END_YMD 	= request.getParameter("END_YMD");
	String DPT_CD = request.getParameter("DPT_CD");
	String BUT_CITY_CD 	= request.getParameter("BUT_CITY_CD");


	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("but", "BUTA100_PRT");

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			STR_YMD.replaceAll("-", ""),
			END_YMD.replaceAll("-", ""),
			BUT_CITY_CD,
			DPT_CD
	};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "ORD_NO,BUT_FR_YMD,BUT_TO_YMD,BUT_CITY_CD,BUT_OBJ,TRANS_NO,ENO_NO,BUT_NIGHT,BUT_DAY,BUT_CNT,ENO_NM,DPT_NM,JOB_NM,BUT_NM,BUT_AIRFARE,BUT_ISSUE,BUT_EXPENSE,BUT_LODGING";
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
