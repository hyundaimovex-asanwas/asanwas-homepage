<!--
***********************************************************************
* @source      : reta010_ED.jsp
* @description : 퇴직금중간정산신청 PAGE  (선택 직원의 정보  조회)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/04      김학수        최초작성.
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
    String ENO_NO = request.getParameter("ENO_NO");
    String rownum = request.getParameter("rownum");

    String DPT_NM   = "";
    String JOB_NM   = "";
    String ENO_CD   = "";
    String ENO_NM   = "";
    String HIRG_YMD = "";
    String CET_NO   = "";
    String ADDR1    = "";
    String ADDR2    = "";

    String BASIC_YMD = "";
    String REASON    = "";
    String BASIC_Y  = "";
    String BASIC_M  = "";
    String BASIC_D  = "";

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA010_SHR_EMP_PRINT");
    System.out.println("rownum="+rownum);
    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        ENO_NO
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    if (voList.size() > 0)
    {
        DynamicValueObject vo = (DynamicValueObject)voList.get(0);

        DPT_NM   = vo.getString("DPT_NM");
        JOB_NM   = vo.getString("JOB_NM");
        ENO_CD   = vo.getString("ENO_NO");
        ENO_NM   = vo.getString("ENO_NM");
        HIRG_YMD = vo.getString("HIRG_YMD");
        CET_NO   = vo.getString("CET_NO");
        ADDR1    = vo.getString("ADDR1");
        ADDR2    = vo.getString("ADDR2");
    }
//-------------------------------------------------------------


    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql2 = XmlSqlUtils.getSQL("ret", "RETA010_SHR");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam2 = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind2 = new Object[] {
        ENO_NO
    };

    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);
    BASIC_YMD = "";
	REASON    = "";
	BASIC_Y  = "";
    BASIC_M  = "";
    BASIC_D  = "";
    System.out.println("rownum="+voList2.size());


    if (voList2.size() > 0)
    {
        //DynamicValueObject vo2 = (DynamicValueObject)voList2.get(Integer.parseInt(rownum));
        DynamicValueObject vo2 = (DynamicValueObject)voList2.get(Integer.parseInt(rownum)-1);
        BASIC_YMD = vo2.getString("BASIC_YMD");
        REASON    = vo2.getString("REASON");
	    BASIC_Y  = BASIC_YMD.substring(0,4);
	    BASIC_M  = BASIC_YMD.substring(5,7);
	    BASIC_D  = BASIC_YMD.substring(8,10);
    }


    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("주민등록");
    hnwExtQuery.AddField("거주지");
    hnwExtQuery.AddField("중간정산기준일년");
    hnwExtQuery.AddField("중간정산기준일월");
    hnwExtQuery.AddField("중간정산기준일일");
    hnwExtQuery.AddField("신청사유");

    hnwExtQuery.SendField(response);


    hnwExtQuery.AddData(DPT_NM);
    hnwExtQuery.AddData(JOB_NM);
    hnwExtQuery.AddData(ENO_CD);
    hnwExtQuery.AddData(ENO_NM);
    hnwExtQuery.AddData(HIRG_YMD );
    hnwExtQuery.AddData(CET_NO);
    hnwExtQuery.AddData(ADDR1);
    hnwExtQuery.AddData(ADDR2);
    hnwExtQuery.AddData(BASIC_Y);
    hnwExtQuery.AddData(BASIC_M);
    hnwExtQuery.AddData(BASIC_D);
    hnwExtQuery.AddData(REASON);

    hnwExtQuery.SendData(response);
%>
