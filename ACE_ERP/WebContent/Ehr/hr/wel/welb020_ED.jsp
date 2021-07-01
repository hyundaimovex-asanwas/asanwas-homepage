<!--
***********************************************************************
* @source      : welb020_ED.jsp
* @description : 휴대폰보조비관리
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/17      방석호        최초작성.
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

<%
	String PIS_YY     = request.getParameter("PIS_YY");
	String PIS_MM     = request.getParameter("PIS_MM");
	String DPT_CD     = request.getParameter("DPT_CD");

	/** 외부 XML에서 지인등록 (조회) SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("wel", "WELB020_SHR");

	/** 검색 조건 Mapping(PrepareStatement ) **/
	Object[] bind = new Object[] {
			PIS_YY,
			PIS_MM,
			DPT_CD,
			//PIS_YY,
			//PIS_MM,
			//PIS_YY,
			//PIS_MM,
			//PIS_YY,
			//PIS_MM,
		};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
	String 	colStr  =   "DPT_CD,PIS_YM,PIS_YY,PIS_MM,ENO_NO,ENO_NM,JOB_CD,DPT_NM,JOB_NM,PHN_NO,TOTAL,KR_USE_AMT,FR_USE_AMT,REMARK,ABA_NM,ACC_NO";
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