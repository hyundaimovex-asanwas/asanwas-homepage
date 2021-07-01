<!--
***********************************************************************
* @source      : lawa030_ED.jsp
* @description : 채권회수 진행현황명세서
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
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String HEAD_CD_SHR     	= request.getParameter("HEAD_CD_SHR");
	String BOND_GBN_SHR   = request.getParameter("BOND_GBN_SHR");
	String EVENT_NM_SHR   = request.getParameter("EVENT_NM_SHR");
	String ORD_YMD_STR_SHR   = request.getParameter("ORD_YMD_STR_SHR");
	String ORD_YMD_END_SHR   = request.getParameter("ORD_YMD_END_SHR");
	String SESSION_ENONO     = box.get("SESSION_ENONO");


	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("law", "LAWA030_SHR_PRT");


	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			SESSION_ENONO,
			SESSION_ENONO,
			SESSION_ENONO
	};

    AbstractDAO aaa= new AbstractDAO("default");

	  System.out.println("7777 "+SESSION_ENONO+" 77");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


    /** 필드값 세팅 **/

   	String 	colStr  =   "ENO_NO,ORD_NO,EVENT_NM,HEAD_CD,DPT_CD,DPT_NM,HEAD_NM,BOND_GBN_NM,SORT_NO,ORD_YMD,BOND_GBN,BOND_AMT,BOND_AC_AMT,GUAR_LST,HIS_CONT1,HIS_AMT1,HIS_CONT2,HIS_AMT2,COST_AMT,REMARK,LAW_GBN";

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

    hnwExtQuery.EndData(response);
%>