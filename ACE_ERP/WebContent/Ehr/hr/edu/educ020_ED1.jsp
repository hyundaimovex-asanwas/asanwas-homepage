<!--
***********************************************************************
* @Source         : educ030_ED1.jsp                                       *
* @Description    : 나의교육이력-년도별교육이력(교육점수현황) PAGE
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

    String eno_no  = request.getParameter("eno_no");
    String str_ymd = request.getParameter("str_ymd");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_01");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {

    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        str_ymd,
  		eno_no

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("점수합계(취득)");
    hnwExtQuery.AddField("점수합계(인정)");
    hnwExtQuery.AddField("사내교육(필수)");
    hnwExtQuery.AddField("사내교육(선택)");
    hnwExtQuery.AddField("사내강의(취득)");
    hnwExtQuery.AddField("사내강의(인정)");
    hnwExtQuery.AddField("사외");
    hnwExtQuery.AddField("예외");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("CPT_PNT_TOT"));
            hnwExtQuery.AddData(vo.getString("APP_POINT"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AA1"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AB1"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AA2"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AB2"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_LCT"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_EXP"));


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

        hnwExtQuery.SendData(response);
    }

%>