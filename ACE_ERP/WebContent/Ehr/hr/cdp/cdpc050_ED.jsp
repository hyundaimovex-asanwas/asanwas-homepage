<!--
***********************************************************************
* @source      : cdpc050_ED.jsp
* @description : 후견인보고서현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/17      김학수        최초작성.
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
    String MNT_GBN  = request.getParameter("MNT_GBN");
    String ENO_NO  = request.getParameter("ENO_NO").replaceAll("null", "");
    String STR_YMD = request.getParameter("STR_YMD").replaceAll("-", "");
    String END_YMD = request.getParameter("END_YMD").replaceAll("-", "");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("cdp", "CDPC050_SHR_PRINT");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    StringBuffer sb = new StringBuffer();


    if(MNT_GBN.equals("P")) {
    	sb.append("AND ENO_NO LIKE '"+ENO_NO+"'||'%'");
    } else if(MNT_GBN.equals("M")) {
    	sb.append("AND MENO_NO LIKE '"+ENO_NO+"'||'%'");
    } else {
    	sb.append("AND (ENO_NO LIKE '"+ENO_NO+"'||'%'");
    	sb.append(" OR  MENO_NO LIKE '"+ENO_NO+"'||'%')");
    }

    Object[] sqlParam = new Object[] {
    		sb.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        STR_YMD,
        END_YMD
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("순번");
    hnwExtQuery.AddField("피후견인사번");
    hnwExtQuery.AddField("피후견인성명");
    hnwExtQuery.AddField("피후견인소속");
    hnwExtQuery.AddField("피후견인직위");
    hnwExtQuery.AddField("후견인사번");
    hnwExtQuery.AddField("후견인성명");
    hnwExtQuery.AddField("후견인소속");
    hnwExtQuery.AddField("후견인직위");
    hnwExtQuery.AddField("후견시작일자");
    hnwExtQuery.AddField("후견종료일자");
    hnwExtQuery.AddField("작성일자");
    hnwExtQuery.AddField("목적");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("MENO_NO"));
            hnwExtQuery.AddData(vo.getString("MENO_NM"));
            hnwExtQuery.AddData(vo.getString("MDPT_NM"));
            hnwExtQuery.AddData(vo.getString("MJOB_NM"));
            hnwExtQuery.AddData(vo.getString("STR_YMD"));
            hnwExtQuery.AddData(vo.getString("END_YMD"));
            hnwExtQuery.AddData(vo.getString("IPT_YMD"));
            hnwExtQuery.AddData(vo.getString("OBJ_TXT"));

            hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>