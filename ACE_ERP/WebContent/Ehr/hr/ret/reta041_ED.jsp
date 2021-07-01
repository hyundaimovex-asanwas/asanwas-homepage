<!--
***********************************************************************
* @source      : reta030_ED.jsp
* @description : 퇴직금계산처리(산정 내역 정보를 조회) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      김학수        최초작성.
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
    String ymd       = request.getParameter("ymd");
    String sort_type = request.getParameter("sort_type");
    String occ_cd    = request.getParameter("occ_cd");

    System.out.println(ymd);
    System.out.println(sort_type);
    System.out.println(occ_cd);

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA040_SHR");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        occ_cd, ymd, sort_type
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("직급");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("시작일");
//    hnwExtQuery.AddField("승진일");
    hnwExtQuery.AddField("종료일");
    hnwExtQuery.AddField("퇴직금");
    hnwExtQuery.AddField("연월차수당");
    hnwExtQuery.AddField("고용보험");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("관리번호");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("HIRG_YMD"));
//            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("RTR_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("WRK_NO1"));

            hnwExtQuery.SendData(response);
        }
    }

%>