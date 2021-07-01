<!--
***********************************************************************
* @source        : saga070_ED.jsp
* @description   : 개인별급여지급현황 PAGE.
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/30      김학수        최초작성.
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
    String PIS_YY = request.getParameter("PIS_YY");
    String ENO_NO = request.getParameter("ENO_NO");
//--------------------------------------------------------------- 사원정보조회
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("sag", "SAGA070_SHR");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        ENO_NO
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

//    System.out.println("voList.size()="+voList.size());

    String OCC_VAL  = "";
    String OCC_CD   = "";
    String ENO_NM   = "";
    String JOB_NM   = "";
    String DPT_NM   = "";
    String HIRG_YMD = "";
    String CET_NO   = "";


    String SAL_GBN_VAL = "";

    if (voList.size() > 0)
    {
        DynamicValueObject vo = (DynamicValueObject)voList.get(0);

        OCC_CD   = vo.getString("OCC_CD");
        OCC_VAL  = vo.getString("OCC_CD") + "  " + vo.getString("OCC_NM");
        ENO_NM   = vo.getString("ENO_NM");
        JOB_NM   = vo.getString("JOB_NM");
        DPT_NM   = vo.getString("DPT_NM");
        HIRG_YMD = vo.getString("HIRG_YMD");
        CET_NO   = vo.getString("CET_NO");
    }
//-----------------------------------------------------------------------------

    String sql2 = XmlSqlUtils.getSQL("sag", "SAGA070_SHR_01");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind2 = new Object[] {
        PIS_YY,
	    ENO_NO
    };

    AbstractDAO aaa2 = new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("지급년도");
    hnwExtQuery.AddField("사원번호");
    hnwExtQuery.AddField("근로구분");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("주민번호");

    hnwExtQuery.AddField("월");
    hnwExtQuery.AddField("구분");
    hnwExtQuery.AddField("합계");
    hnwExtQuery.AddField("기본급");
    hnwExtQuery.AddField("복지수당");
    hnwExtQuery.AddField("기술수당");
    hnwExtQuery.AddField("시간외수당");
    hnwExtQuery.AddField("택배수당");

    hnwExtQuery.AddField("근속수당");
    hnwExtQuery.AddField("운행수당");
    hnwExtQuery.AddField("자기개발비");
    hnwExtQuery.AddField("기타수당");
    hnwExtQuery.AddField("개인연금");
    hnwExtQuery.AddField("자동지급수당");
    hnwExtQuery.AddField("고정지급수당");

    hnwExtQuery.AddField("기타지불액");
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList2.size() > 0)
    {
        for ( int i=0; i<voList2.size(); i++ )
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);

            if ( vo2.getString("SAL_GBN").equals("0") ) {
                SAL_GBN_VAL = "급여";
            } else if ( vo2.getString("SAL_GBN").equals("1") ) {
                SAL_GBN_VAL = "상여";
            } else if ( vo2.getString("SAL_GBN").equals("4") ) {
                SAL_GBN_VAL = "연차";
            }
            hnwExtQuery.AddData("지급년도 : " +PIS_YY);
            hnwExtQuery.AddData("사번 : " +ENO_NO);
            hnwExtQuery.AddData("근로구분 : " +OCC_VAL);
            hnwExtQuery.AddData("성 명 : " +ENO_NM);
            hnwExtQuery.AddData("직위 : " +JOB_NM);
            hnwExtQuery.AddData("소속 : " +DPT_NM);
            hnwExtQuery.AddData("입사일 : " +HIRG_YMD);
            hnwExtQuery.AddData("주민번호 : " +CET_NO);

            hnwExtQuery.AddData(vo2.getString("PIS_MM"));
            hnwExtQuery.AddData(SAL_GBN_VAL);
            hnwExtQuery.AddData(vo2.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo2.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo2.getString("WEL_AMT"));
            hnwExtQuery.AddData(vo2.getString("DUTY_AMT"));
            hnwExtQuery.AddData(vo2.getString("OT_AMT"));
            hnwExtQuery.AddData(vo2.getString("OSE_AMT"));
            hnwExtQuery.AddData(vo2.getString("LSEV_AMT"));
            hnwExtQuery.AddData(vo2.getString("RUN_AMT"));
            hnwExtQuery.AddData(vo2.getString("MH_AMT"));
            hnwExtQuery.AddData(vo2.getString("ETC_AMT"));
            hnwExtQuery.AddData(vo2.getString("PPEN_AMT"));
            hnwExtQuery.AddData(vo2.getString("SGF_AMT"));
            hnwExtQuery.AddData(vo2.getString("TB3_AMT"));
            hnwExtQuery.AddData(vo2.getString("OTH_AMT"));

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

            hnwExtQuery.SendData(response);
    }

%>