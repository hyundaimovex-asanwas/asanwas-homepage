<!--
***********************************************************************
* @source      : butc050_ED.jsp
* @description : 파견비지급현황표
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/02/09     권혁수        최초작성.
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
	String CD_GBN  	= request.getParameter("CD_GBN");

	/** 외부 XML에서 SQL을 읽어 온다 **/
	String query = "";
	if("A4".equals(CD_GBN)){
		query = "BUTC050_SHR_02";
	}else if("A2".equals(CD_GBN)){
		query = "BUTC050_SHR_01";
	}else {
		query = "BUTC050_SHR_03";
	}
	String sql =  XmlSqlUtils.getSQL("but", query);

	/** 조회 조건(기간)에 따른 처리 #1 **/
	StringBuffer sb = new StringBuffer();
	if (CD_GBN.equals("A4")) {
		sb.append("A.DPT_CD");
	}else if (CD_GBN.equals("A2")) {
		sb.append("A.JOB_CD");
	}else{
		sb.append(" AND 1 = 1");
		CD_GBN = "1";
	}

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			CD_GBN,
			STR_YMD.replaceAll("-", ""),
			END_YMD.replaceAll("-", ""),
			CD_GBN
	};


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "COMM_NM,APP_CNT,AMOUNT,CD_GBN,REMARK";
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
