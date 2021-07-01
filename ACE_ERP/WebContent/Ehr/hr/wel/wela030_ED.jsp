<!--
***********************************************************************
* @source      : wela030_ED.jsp
* @description : 이주비 지급 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>
<%@page import="common.util.JSPUtil" %>

<%
	String STR_YMD     = request.getParameter("STR_YMD").replaceAll("-", "");
	String END_YMD     = request.getParameter("END_YMD").replaceAll("-", "");
	String DPT_CD      = request.getParameter("DPT_CD").replaceAll("null","");
	String ENO_NO      = request.getParameter("ENO_NO").replaceAll("null","");

	/** 외부 XML에서 지인등록 (조회) SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("wel", "WELA030_PRT");

	/** 조회 조건(등록일자)에 따른 처리 #1 **/
	StringBuffer sb = new StringBuffer();
	if (!STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND MOVE_YMD >= '"+STR_YMD+"' \n");
		sb.append("AND MOVE_YMD <= '"+END_YMD+"' \n");
	} else if (!STR_YMD.equals("") && END_YMD.equals("")) {
		sb.append("AND MOVE_YMD >= '"+STR_YMD+"' \n");
	} else if (STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND MOVE_YMD <= '"+END_YMD+"' \n");
	} else {
		sb.append("");
	}



	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString(),
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** 검색 조건 Mapping(PrepareStatement ) **/
	Object[] bind = new Object[] {
			DPT_CD,
			ENO_NO
	};


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
	String 	colStr  =   "MOVE_YEAR,ORD_NO,ENO_NO,DPT_NM,JOB_NM,ENO_NM,RADR,RADR_CT,RZI_NO,MADR,MADR_CT,MZI_NO,MOVE_YMD,COM_PHN_NO,HOM_PHN_NO,EM_PHN_NO,APP_YMD,APP_CD,ARROW,RAREA,MAREA,MOVE_AMT,RPLACE,MPLACE";
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