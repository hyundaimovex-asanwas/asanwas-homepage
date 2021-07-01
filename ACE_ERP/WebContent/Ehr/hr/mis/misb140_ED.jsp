<!--
***********************************************************************
* @source      : misb140_ED.jsp
* @description : 사업체근로실태조사
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
String STR_YMD2 	= STR_YMD.replaceAll("-", "");

String STR_YY = STR_YMD2.substring(0,4);
String STR_MM = STR_YMD2.substring(4,6);


String sql = XmlSqlUtils.getSQL("mis", "MISB140_SHR");

	Object[] bind = new Object[] {
			STR_YMD,
			STR_YMD,
			STR_YY,
			STR_MM,
			STR_YMD,
			STR_YY,
			STR_MM,
			STR_YMD
	};
	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "GUBUN,ENO_NO,JOB_SEQ,ENO_NO_1,OCC_NM,JOB_NM,DPT_NM,ENO_NM,MF_NM,WED_NM,BIR_YMD,HIR_YMD,EDGR_NM,NSO_NM,BAS_AMT,DUTY_AMT,WEL_AMT,OSE_AMT,RUN_AMT,MH_AMT,LSEV_AMT,TB3_AMT,SGF_AMT,OTH_AMT,OT_AMT,SALT_AMT,SANG_AMT,SUB1,SUB2,SUB3,GUNCNT,ATW_CNT,HOW_CNT,SUM_CNT";

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
