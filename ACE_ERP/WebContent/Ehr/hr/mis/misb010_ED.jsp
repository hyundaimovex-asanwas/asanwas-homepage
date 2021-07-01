<!--
***********************************************************************
* @source      : misb010_ED.jsp
* @description : 이직율현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11     방석호        최초작성.
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
	String GBN_SHR = request.getParameter("GBN_SHR");

	String sql = null;


	/** 외부 XML에서 SQL을 읽어 온다 **/
	if (GBN_SHR.equals("0"))
	{
		sql =XmlSqlUtils.getSQL("mis", "MISB010_SHR_01");	}
	else
	{
		sql =XmlSqlUtils.getSQL("mis", "MISB010_SHR_02");
	}

	Object[] bind = new Object[] {
			STR_YMD.replaceAll("-", ""),
			END_YMD.replaceAll("-", ""),
	};
	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "GUBUN,OCC_CD,JOB_CD,GBN_CD,TITLE_NM,SEQ,CNT1,MCNT1,CNT2,MCNT2";

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
