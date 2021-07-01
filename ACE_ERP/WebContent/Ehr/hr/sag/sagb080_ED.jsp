<!--
***********************************************************************
* @source      : sagb080_ED.jsp
* @description : 철야당직비현황 PAGE 			 			          *
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
    String PIS_YM = request.getParameter("PIS_YM");
    String DPT_CD = request.getParameter("DPT_CD");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("sag", "SAGB080_SHR");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {

    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        PIS_YM.substring(0, 4), PIS_YM.substring(5, 7), DPT_CD
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("No2");
    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("일수");
    hnwExtQuery.AddField("당직수당");
    hnwExtQuery.AddField("비고");

    hnwExtQuery.SendField(response);

    int i = 0;
    int k = 0;
    String pre_dpt_nm = "";

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if ( pre_dpt_nm.equals(vo.getString("DPT_NM")) ) {

                    hnwExtQuery.AddData(Integer.toString(k));
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(vo.getString("DPT_NM"));

            } else {
                k = k + 1;
                hnwExtQuery.AddData(Integer.toString(k));
                hnwExtQuery.AddData(Integer.toString(k));
                hnwExtQuery.AddData(vo.getString("DPT_NM"));
            }
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("DUTY_CNT"));
            hnwExtQuery.AddData(Integer.toString(Integer.parseInt(vo.getString("DUTY_AMT"))));
            hnwExtQuery.AddData(vo.getString("REMARK"));

            hnwExtQuery.SendData(response);

            pre_dpt_nm = vo.getString("DPT_NM");
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

        hnwExtQuery.SendData(response);
    }

%>