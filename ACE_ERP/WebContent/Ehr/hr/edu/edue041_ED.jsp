<!--
***********************************************************************
* @Source         : educ030_ED.jsp                                    *
* @Description    : 나의교육이력-년도별확정점수 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/19      김학수        최초작성.
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
	String REQ_NO = request.getParameter("REQ_NO");
	String ENO_NO = request.getParameter("ENO_NO");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUE041_PRT");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
    		REQ_NO,
    	//	ENO_NO

    };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "EDU_ENO_NO,EDU_ENO_NM,EDU_CD,EDU_NM,EDU_GBN_CD,MNGER_CD,FIELD_CD,SHAPE_CD,EDU_GBN_NM,MNGER_NM,FIELD_NM,SHAPE_NM,GOAL_TAG,CONTENT_TXT,EFFECT_TAG,OBJ_TAG,CPT_TAG,INT_NAM,FIX_NO,DAY_NO,TIME_NO,COST_AMT,COST_CD,COST_NM,INS_YN,INS_NM,RTN_AMT,PLACE_CD,PLACE_NM,CPT_PNT,SITE_TAG,ENT_TERM,EDU_TERM,ENO_NO,ENO_NM,ENO_DPT_CD,ENO_DPT_NM,ENO_JOB_CD,ENO_JOB_NM,REQ_NO";

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

