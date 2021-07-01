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
	String STR_MM 	= request.getParameter("STR_MM").replaceAll("-", "");
	String END_MM 	= request.getParameter("END_MM").replaceAll("-", "");
	String DPT_CD = request.getParameter("DPT_CD");
	String ENO_NO = request.getParameter("ENO_NO");

	StringBuffer sb = new StringBuffer();

	if (ENO_NO.length()>0){
		sb.append(" AND A.ENO_NO = '" + ENO_NO + "' \n");
	}

	if (DPT_CD.length()>0){
		sb.append(" AND B.DPT_CD = '" + DPT_CD + "' \n");
	}

	sb.append(" AND  A.APP_YMD BETWEEN '" + STR_MM + "' AND '" + END_MM + "' \n");

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	String sql = XmlSqlUtils.getSQL("mis", "MISB050_SHR");
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** 외부 XML에서 SQL을 읽어 온다 **/

	Object[] bind = new Object[] {
	};
	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "ENO_NO,ENO_NM,CET_NO,STR_YMD,SEQ_NO,OCC_CD,OCC_NM,END_YMD,APP_CD,OLD_APP_CD,APP_NM,HEAD_CD,HEAD_NM,DPT_CD,DPT_NM,TEAM_CD,TEAM_NM,JOB_CD,JOB_NM,HOB_CD,HOB_NM,DUTY_CD,DUTY_NM,SRV_CD,SRV_NM,PART_CD,PART_NM,CHIEF_YN,JCD_CD,JCD_NM,APP_YMD,REMARK";

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
