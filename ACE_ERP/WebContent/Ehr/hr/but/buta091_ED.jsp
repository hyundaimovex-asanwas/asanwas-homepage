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
	String ORD_NO = request.getParameter("ORD_NO");
	String BASIC_YMD 	= request.getParameter("BASIC_YMD");

	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("but", "BUTA091_PRT");

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			ORD_NO,
			ORD_NO,
			ORD_NO
			};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/

   	String 	colStr  =   "ORD_NO,SEQ,DPT_NM,JOB_NM,JOB_CD,ENO_NO,ENO_NM,BUT_NIGHT,BUT_DAY,BUT_OFFER,BUT_AIRFARE,BUT_ISSUE,BUT_CITY_CD,BUT_EXPENSE_FOR,BUT_LODGING_FOR,BUT_CNT_FOR,BAS_EXPENSE,BAS_LODGING,BAS_EXPENSE_OFFER,BUT_FR_YMD,BUT_TO_YMD,BUT_CITY_GUGAN,BUT_CITY_NM,BUT_OBJ,J_NAME,UPT_NM,CNT_FORSUM,BUT_PERIOD";
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
