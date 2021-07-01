<!--
***********************************************************************
* @source      : insa060_ED2.jsp
* @description : 국민연금신고내역서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/08      김학수        최초작성.
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

    String str_ymd = request.getParameter("str_ymd").replaceAll("-", "");
    String end_ymd = request.getParameter("end_ymd").replaceAll("-", "");
    String occ_cd = request.getParameter("occ_cd");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("ins", "INSA060_SHR_02");

    StringBuffer sb = new StringBuffer();

    /** 조회 조건에 따른 처리 **/
    sb.append("AND TO_CHAR(RET_YMD,'YYYYMMDD') >= '"+str_ymd+"' \n");
    sb.append("AND TO_CHAR(RET_YMD,'YYYYMMDD') <= '"+end_ymd+"' \n");

    if( ! occ_cd.equals("0") ){
        sb.append("AND OCC_CD = '"+occ_cd+"' \n");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb.toString()
    };


    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

   /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    String 	colStr  =   "NUM,ENO_NO,ENO_NM,CET_NO,JOB_NM,DPT_NM,RET_YMD,HIR_YMD";
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