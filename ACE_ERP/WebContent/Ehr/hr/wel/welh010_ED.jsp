<%@page import="javax.jms.Session"%>
<!--
***********************************************************************
* @source      : welh010_ED.jsp
* @description : 차량유지비,중식비,교통비 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      방석호        최초작성.
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
<%@page import ="com.gauce.GauceDataSet "%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO.*"   %>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>

<%
	String PIS_YY_SHR		= request.getParameter("PIS_YY_SHR");
	String PIS_MM_SHR		= request.getParameter("PIS_MM_SHR");
	String GBN_CD_SHR		= request.getParameter("GBN_CD_SHR").replaceAll("null","");
	String JOB_CD_SHR		= request.getParameter("JOB_CD_SHR");
	String DPT_CD_SHR		= request.getParameter("DPT_CD_SHR");
	String ENO_NO_SHR			= request.getParameter("ENO_NO_SHR").replaceAll("null","");


	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("wel", "WELH010_SHR");

	/** 조회 조건(지급일자)에 따른 처리 **/
	StringBuffer sb = new StringBuffer();


	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {

	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			PIS_YY_SHR,
			PIS_MM_SHR,
			GBN_CD_SHR,
			JOB_CD_SHR,
			DPT_CD_SHR,
			ENO_NO_SHR
	};

	  AbstractDAO aaa= new AbstractDAO("default");

	    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	    extquery hnwExtQuery = new extquery();


	/** 필드값 세팅 **/
		String 	colStr  =   "DPT_NM,JOB_SEQ, PIS_YY,PIS_MM,ENO_NO,OCC_CD,DPT_CD,JOB_CD,CAR_AMT,TRA_AMT,LUN_AMT,DEL_AMT,SUM_AMT,TOT_AMT,NO_TAX,ENO_NM,JOB_NM,HOB_CD,DEL1_AMT,DEL2_AMT";
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