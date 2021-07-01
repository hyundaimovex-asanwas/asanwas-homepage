<!--
***********************************************************************
* @source      : insb020_ED2.jsp
* @description : 건강보험신고내역서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/09      김학수        최초작성.
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
    String occ_cd  = request.getParameter("occ_cd");
    String str_ymd = request.getParameter("str_ymd");
    String end_ymd = request.getParameter("end_ymd");

    if ( occ_cd.equals("0") ) {
        occ_cd = "";
    }
    String sql = null;

    sql = XmlSqlUtils.getSQL("ins", "INSB020_SHR_02");

    //param binding 하기
    Object[] bind = new Object[] {
             str_ymd
            ,end_ymd
            ,occ_cd
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "OCC_CD,OCC_NM,DPT_CD,DPT_NM,JOB_CD,JOB_NM,ENO_NO,HIU_NO,ENO_NM,CET_NO,ZIP_NO,ADDRESS,PHN_NO,RET_YMD,RET_NM,RET_CD";
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