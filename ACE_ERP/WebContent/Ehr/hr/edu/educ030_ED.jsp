<!--
***********************************************************************
* @Source         : educ030_ED.jsp                                       *
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

    String eno_no = request.getParameter("eno_no");
	String STR_YMD = request.getParameter("STR_YMD");
	String END_YMD = request.getParameter("END_YMD");


    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUC030_SHR");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    StringBuffer sb = new StringBuffer();


    if(!STR_YMD.equals(""))
        sb.append("AND F.EDU_YY >= '"+STR_YMD+"'");
    if(!END_YMD.equals(""))
        sb.append("AND F.EDU_YY <= '"+END_YMD+"'");

    Object[] sqlParam = new Object[] {
    		sb.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        eno_no

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("순");
    hnwExtQuery.AddField("년도");
    hnwExtQuery.AddField("목표학점");
    hnwExtQuery.AddField("인정학점");
    hnwExtQuery.AddField("총이수학점");
    hnwExtQuery.AddField("취득학점(필수)");
    hnwExtQuery.AddField("취득학점(선택)");
    hnwExtQuery.AddField("강의학점");
    hnwExtQuery.AddField("예외학점");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("EDU_YY"));
            hnwExtQuery.AddData(vo.getString("JOB_POINT"));
            hnwExtQuery.AddData(vo.getString("APP_POINT"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_TOT"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AA"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AB"));
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
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>