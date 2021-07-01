<!--
***********************************************************************
* @source      : pire010_ED.jsp
* @description : 신원보증현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     방석호        최초작성.
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
	String OCC_CD	= request.getParameter("OCC_CD");
	String STR_YM    	= request.getParameter("STR_YM").replaceAll("-", "");
	String END_YM		= request.getParameter("END_YM").replaceAll("-", "");
	String REGI		= request.getParameter("REGI");

    DynamicValueObject voList ;
	if (REGI.equals("N")){
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRE010_SHR_01");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[]{
				STR_YM,
				END_YM,
				OCC_CD
		};

	    AbstractDAO aaa= new AbstractDAO("default");
        voList = aaa.selectProcessDvo(sql, bind);
	}
	else
	{
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRE010_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				OCC_CD
		};
	    AbstractDAO aaa= new AbstractDAO("default");
	    voList = aaa.selectProcessDvo(sql, bind);
	}



    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/


	String 	colStr  =   "ENO_NO,ENO_NM,JOB_NM,DPT_NM,CET_NO,HIR_YMD,ADDRESS,PHN_NO,GUR_NAM,GURR_NM,GURO,GURD_YMD";
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