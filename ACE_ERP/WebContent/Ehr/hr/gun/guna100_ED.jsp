<!--
***********************************************************************
* @source      : guna100_ED.jsp
* @description : 개인별근태집계현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      김학수        최초작성.
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

    String eno_no     = request.getParameter("eno_no");
	String pis_yy     = request.getParameter("pis_yy");
    String pis_mm_str = request.getParameter("pis_mm_str");
    String pis_mm_end = request.getParameter("pis_mm_end");

    int i = 0;
    String sql = XmlSqlUtils.getSQL("gun", "GUNA100_SHR");

    Object[] bind = new Object[] {
            pis_yy,            // 해당년
            pis_mm_str,	       // 해당월(시작)
            pis_mm_end,		   // 해당월(종료)
            eno_no,            // 사번
            pis_yy,            // 해당년
            pis_yy,            // 해당년
            pis_yy,            // 해당년
            pis_yy,            // 해당년
            pis_yy,            // 해당년
            pis_mm_str,	       // 해당월(시작)
            pis_mm_end,		   // 해당월(종료)
            eno_no,            // 사번
    };
    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("년월");
    hnwExtQuery.AddField("1");
    hnwExtQuery.AddField("2");
    hnwExtQuery.AddField("3");
    hnwExtQuery.AddField("4");
    hnwExtQuery.AddField("5");
    hnwExtQuery.AddField("6");
    hnwExtQuery.AddField("7");
    hnwExtQuery.AddField("8");
    hnwExtQuery.AddField("9");
    hnwExtQuery.AddField("10");
    hnwExtQuery.AddField("11");
    hnwExtQuery.AddField("12");
    hnwExtQuery.AddField("13");
    hnwExtQuery.AddField("14");
    hnwExtQuery.AddField("15");
    hnwExtQuery.AddField("16");
    hnwExtQuery.AddField("17");
    hnwExtQuery.AddField("18");
    hnwExtQuery.AddField("19");
    hnwExtQuery.AddField("20");
    hnwExtQuery.AddField("21");
    hnwExtQuery.AddField("22");
    hnwExtQuery.AddField("23");
    hnwExtQuery.AddField("24");
    hnwExtQuery.AddField("25");
    hnwExtQuery.AddField("26");
    hnwExtQuery.AddField("27");
    hnwExtQuery.AddField("28");
    hnwExtQuery.AddField("29");
    hnwExtQuery.AddField("30");
    hnwExtQuery.AddField("31");

    hnwExtQuery.AddField("A");
    hnwExtQuery.AddField("B");
    hnwExtQuery.AddField("C");
    hnwExtQuery.AddField("D");
    hnwExtQuery.AddField("E");
    hnwExtQuery.AddField("F");
    hnwExtQuery.AddField("G");
    hnwExtQuery.AddField("T");
    hnwExtQuery.AddField("I");
    hnwExtQuery.AddField("J");
    hnwExtQuery.AddField("K");
    hnwExtQuery.AddField("L");
    hnwExtQuery.AddField("H");
    hnwExtQuery.AddField("P");
    hnwExtQuery.AddField("R");
    hnwExtQuery.AddField("Y");
    hnwExtQuery.AddField("W");
    hnwExtQuery.AddField("U");
    hnwExtQuery.AddField("Z");
    hnwExtQuery.AddField("S");
    hnwExtQuery.AddField("Q");
    hnwExtQuery.AddField("V");
    hnwExtQuery.AddField("근로구분코드");
    hnwExtQuery.AddField("근로구분명");
    hnwExtQuery.AddField("부서명");
    hnwExtQuery.AddField("직위명");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("PIS_YYMM"));
            hnwExtQuery.AddData(vo.getString("AT1_CD"));
            hnwExtQuery.AddData(vo.getString("AT2_CD"));
            hnwExtQuery.AddData(vo.getString("AT3_CD"));
            hnwExtQuery.AddData(vo.getString("AT4_CD"));
            hnwExtQuery.AddData(vo.getString("AT5_CD"));
            hnwExtQuery.AddData(vo.getString("AT6_CD"));
            hnwExtQuery.AddData(vo.getString("AT7_CD"));
            hnwExtQuery.AddData(vo.getString("AT8_CD"));
            hnwExtQuery.AddData(vo.getString("AT9_CD"));
            hnwExtQuery.AddData(vo.getString("AT10_CD"));
            hnwExtQuery.AddData(vo.getString("AT11_CD"));
            hnwExtQuery.AddData(vo.getString("AT12_CD"));
            hnwExtQuery.AddData(vo.getString("AT13_CD"));
            hnwExtQuery.AddData(vo.getString("AT14_CD"));
            hnwExtQuery.AddData(vo.getString("AT15_CD"));
            hnwExtQuery.AddData(vo.getString("AT16_CD"));
            hnwExtQuery.AddData(vo.getString("AT17_CD"));
            hnwExtQuery.AddData(vo.getString("AT18_CD"));
            hnwExtQuery.AddData(vo.getString("AT19_CD"));
            hnwExtQuery.AddData(vo.getString("AT20_CD"));
            hnwExtQuery.AddData(vo.getString("AT21_CD"));
            hnwExtQuery.AddData(vo.getString("AT22_CD"));
            hnwExtQuery.AddData(vo.getString("AT23_CD"));
            hnwExtQuery.AddData(vo.getString("AT24_CD"));
            hnwExtQuery.AddData(vo.getString("AT25_CD"));
            hnwExtQuery.AddData(vo.getString("AT26_CD"));
            hnwExtQuery.AddData(vo.getString("AT27_CD"));
            hnwExtQuery.AddData(vo.getString("AT28_CD"));
            hnwExtQuery.AddData(vo.getString("AT29_CD"));
            hnwExtQuery.AddData(vo.getString("AT30_CD"));
            hnwExtQuery.AddData(vo.getString("AT31_CD"));

            hnwExtQuery.AddData(vo.getString("ATT_A"));
            hnwExtQuery.AddData(vo.getString("ATT_B"));
            hnwExtQuery.AddData(vo.getString("ATT_C"));
            hnwExtQuery.AddData(vo.getString("ATT_D"));
            hnwExtQuery.AddData(vo.getString("ATT_E"));
            hnwExtQuery.AddData(vo.getString("ATT_F"));
            hnwExtQuery.AddData(vo.getString("ATT_G"));
            hnwExtQuery.AddData(vo.getString("ATT_T"));
            hnwExtQuery.AddData(vo.getString("ATT_I"));
            hnwExtQuery.AddData(vo.getString("ATT_J"));
            hnwExtQuery.AddData(vo.getString("ATT_K"));
            hnwExtQuery.AddData(vo.getString("ATT_L"));
            hnwExtQuery.AddData(vo.getString("ATT_H"));
            hnwExtQuery.AddData(vo.getString("ATT_P"));
            hnwExtQuery.AddData(vo.getString("ATT_R"));
            hnwExtQuery.AddData(vo.getString("ATT_Y"));
            hnwExtQuery.AddData(vo.getString("ATT_W"));
            hnwExtQuery.AddData(vo.getString("ATT_U"));
            hnwExtQuery.AddData(vo.getString("ATT_Z"));
            hnwExtQuery.AddData(vo.getString("ATT_S"));
            hnwExtQuery.AddData(vo.getString("ATT_Q"));
            hnwExtQuery.AddData(vo.getString("ATT_V"));
            hnwExtQuery.AddData(vo.getString("OCC_CD"));
            hnwExtQuery.AddData(vo.getString("OCC_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));

            hnwExtQuery.SendData(response);

        }
    }

%>