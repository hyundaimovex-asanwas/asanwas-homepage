<!--
***********************************************************************
* @source      : misb162_ED.jsp
* @description : 본부별인원현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/15     방석호        최초작성.
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
String STR_YMD 	= request.getParameter("STR_YMD");


String sql = XmlSqlUtils.getSQL("mis", "MISB162_SHR");


	Object[] bind = new Object[] {
			STR_YMD,
			STR_YMD,
			STR_YMD,


	};
	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "COM_GBN,HEAD_NM,IDX,HEAD_SEQ,DPT_NM,DPT_SEQ,HEAD_CD,DPT_CD,GRP_ID,CNT_A2,CNT_A4,CNT_A5,CNT_AB,CNT_A6,CNT_1C,CNT_1D,CNT_1E,CNT_2T,CNT_3T,CNT_4M,CNT_4W,CNT_5M,CNT_5W,CNT_7B,CNT_Z1,CNT_JJ,CNT_BJ,CNT_JY,CNT_E1,CNT_PP";

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
