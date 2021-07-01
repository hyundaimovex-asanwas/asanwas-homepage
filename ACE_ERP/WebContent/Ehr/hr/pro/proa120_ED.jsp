<!--
***********************************************************************
* @source      : proa120_PV.jsp									      *
* @description : 계약직 승진대상자 명단 PAGE	 			          *
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/20      김학수        최초작성.
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
    String rec_ymd = request.getParameter("rec_ymd");

    String rec_ymd_val = rec_ymd.substring(0,4) + "0101";
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("pro", "PROA120_SHR");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {

    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("현부서 발령일");
    hnwExtQuery.AddField("현부서 기간");
    hnwExtQuery.AddField("학교");
    hnwExtQuery.AddField("전공");
    hnwExtQuery.AddField("졸업년도");
    hnwExtQuery.AddField("4차역량평가");
    hnwExtQuery.AddField("4차성과평가-상");
    hnwExtQuery.AddField("4차성과평가-하");
    hnwExtQuery.AddField("3차역량평가");
    hnwExtQuery.AddField("3차성과평가-상");
    hnwExtQuery.AddField("3차성과평가-하");
    hnwExtQuery.AddField("2차역량평가");
    hnwExtQuery.AddField("2차성과평가-상");
    hnwExtQuery.AddField("2차성과평가-하");
    hnwExtQuery.AddField("1차역량평가");
    hnwExtQuery.AddField("1차성과평가-상");
    hnwExtQuery.AddField("1차성과평가-하");
    hnwExtQuery.AddField("포상 및 징계");
    hnwExtQuery.AddField("승진대상");

    hnwExtQuery.SendField(response);

    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("H_DPT_YMD"));
            hnwExtQuery.AddData(vo.getString("H_YMD_VAL"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM2"));
            hnwExtQuery.AddData(vo.getString("GUR_YMD"));
            hnwExtQuery.AddData(vo.getString("GOG_Y41"));
            hnwExtQuery.AddData(vo.getString("GOG_Y42"));
            hnwExtQuery.AddData(vo.getString("GOG_Y43"));
            hnwExtQuery.AddData(vo.getString("GOG_Y31"));
            hnwExtQuery.AddData(vo.getString("GOG_Y32"));
            hnwExtQuery.AddData(vo.getString("GOG_Y33"));
            hnwExtQuery.AddData(vo.getString("GOG_Y21"));
            hnwExtQuery.AddData(vo.getString("GOG_Y22"));
            hnwExtQuery.AddData(vo.getString("GOG_Y23"));
            hnwExtQuery.AddData(vo.getString("GOG_Y11"));
            hnwExtQuery.AddData(vo.getString("GOG_Y12"));
            hnwExtQuery.AddData(vo.getString("GOG_Y13"));
            hnwExtQuery.AddData(vo.getString("SAN_RM"));
            hnwExtQuery.AddData(vo.getString("EST_CD"));

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