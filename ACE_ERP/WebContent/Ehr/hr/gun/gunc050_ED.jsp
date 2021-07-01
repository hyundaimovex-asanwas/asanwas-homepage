<!--
***********************************************************************
* @source      : gunc050_ED.jsp
* @description : 휴일근무현황비교 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/05      김학수        최초작성.
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
    String reg_ymd = request.getParameter("reg_ymd");
    String gubun   = request.getParameter("gubun");
    String ymd_val = request.getParameter("ymd_val");
    if ( reg_ymd == null || reg_ymd.equals("") ) { }
    else {
        String reg_y = reg_ymd.substring(0,4);
        String reg_m = reg_ymd.substring(5,7);
        String reg_d = "";

        String str_ymd = "";
        String end_ymd = "";
        String hol_ymd = "";
        String reg_ymd2 = "";
        String gubun_val = "";

        str_ymd = "'" + reg_y + reg_m + "01'";
        end_ymd = "TO_CHAR(LAST_DAY(TO_DATE(" + str_ymd + ",'YYYYMMDD')),'YYYYMMDD')";
        if ( gubun.equals("1") ) {
            gubun_val = "'1'";
        } else {
            gubun_val = "'1','2','3'";
        }
        hol_ymd  = " HOL_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(" + str_ymd + ",'YYYYMMDD'),-1) ,'YYYYMMDD') AND HOL_YMD <= " + end_ymd;
        reg_ymd2 = " REG_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(" + str_ymd + ",'YYYYMMDD'),-1) ,'YYYYMMDD') AND REG_YMD <= " + end_ymd;


        String sql = XmlSqlUtils.getSQL("gun", "GUNC050_SHR");

        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {
                str_ymd
               ,end_ymd
               ,str_ymd
               ,end_ymd
               ,hol_ymd
               ,reg_ymd2
               ,gubun_val
        };

        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        Object[] bind = new Object[] {

        };

        AbstractDAO aaa= new AbstractDAO("default");

        DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

        extquery hnwExtQuery = new extquery();

        hnwExtQuery.AddField("구분1");
        hnwExtQuery.AddField("구분2");
        hnwExtQuery.AddField("구분3");
        hnwExtQuery.AddField("구분4");
        hnwExtQuery.AddField("계");
        hnwExtQuery.AddField("사무직");
        hnwExtQuery.AddField("택배직");
        hnwExtQuery.AddField("파견사원");

        hnwExtQuery.AddField("근무인원계_A");
        hnwExtQuery.AddField("근무인원%_A");
        hnwExtQuery.AddField("사무직계1_A");
        hnwExtQuery.AddField("사무직%1_A");
        hnwExtQuery.AddField("택배직계1_A");
        hnwExtQuery.AddField("택배직%1_A");

        hnwExtQuery.AddField("대체휴가계_A");
        hnwExtQuery.AddField("대체휴가%_A");
        hnwExtQuery.AddField("사무직계2_A");
        hnwExtQuery.AddField("사무직%2_A");
        hnwExtQuery.AddField("택배직계2_A");
        hnwExtQuery.AddField("택배직%2_A");

        hnwExtQuery.AddField("근무수당신청인원계_A");
        hnwExtQuery.AddField("근무수당신청인원%_A");
        hnwExtQuery.AddField("사무직계3_A");
        hnwExtQuery.AddField("사무직%3_A");
        hnwExtQuery.AddField("택배직계3_A");
        hnwExtQuery.AddField("택배직%_A");

        hnwExtQuery.AddField("근무수당액1_A");
        hnwExtQuery.AddField("사무직수당액_A");
        hnwExtQuery.AddField("택배직수당액_A");



        hnwExtQuery.AddField("근무인원계_B");
        hnwExtQuery.AddField("근무인원증감_B");
        hnwExtQuery.AddField("근무인원%_B");
        hnwExtQuery.AddField("사무직계1_B");
        hnwExtQuery.AddField("사무직증감1_B");
        hnwExtQuery.AddField("사무직%1_B");
        hnwExtQuery.AddField("택배직계1_B");
        hnwExtQuery.AddField("택배직증감1_B");
        hnwExtQuery.AddField("택배직%1_B");

        hnwExtQuery.AddField("대체휴가계_B");
        hnwExtQuery.AddField("대체휴가증감_B");
        hnwExtQuery.AddField("대체휴가%_B");
        hnwExtQuery.AddField("사무직계2_B");
        hnwExtQuery.AddField("사무직증감2_B");
        hnwExtQuery.AddField("사무직%2_B");
        hnwExtQuery.AddField("택배직계2_B");
        hnwExtQuery.AddField("택배직증감2_B");
        hnwExtQuery.AddField("택배직%2_B");

        hnwExtQuery.AddField("근무수당신청인원계_B");
        hnwExtQuery.AddField("근무수당신청인원증감_B");
        hnwExtQuery.AddField("근무수당신청인원%_B");
        hnwExtQuery.AddField("사무직계3_B");
        hnwExtQuery.AddField("사무직증감3_B");
        hnwExtQuery.AddField("사무직%3_B");
        hnwExtQuery.AddField("택배직계3_B");
        hnwExtQuery.AddField("택배직증감3_B");
        hnwExtQuery.AddField("택배직%_B");

        hnwExtQuery.AddField("근무수당액1_B");
        hnwExtQuery.AddField("근무수당액증감1_B");
        hnwExtQuery.AddField("사무직수당액_B");
        hnwExtQuery.AddField("사무직수당액증감_B");
        hnwExtQuery.AddField("택배직수당액_B");
        hnwExtQuery.AddField("택배직수당액증감_B");


        hnwExtQuery.AddField("파견사원근무인원계");
        hnwExtQuery.AddField("파견사원근무인원%");
        hnwExtQuery.AddField("대휴사용인원계");
        hnwExtQuery.AddField("대휴사용인원%");
        hnwExtQuery.AddField("수당신청인원계");
        hnwExtQuery.AddField("수당신청인원%");
        hnwExtQuery.AddField("근무수당액2");
        hnwExtQuery.AddField("비고");
        hnwExtQuery.AddField("구분값");
        hnwExtQuery.AddField("구분값2");
        hnwExtQuery.AddField("날짜");


        hnwExtQuery.SendField(response);

    //    System.out.println("voList.size()="+voList.size());

        String pre_GBN2_TAG   = "";
        String pre_HEAD_NM    = "";
        String pre_GBN_NM     = "";
        String pre_GUBUN_temp = "";
        String pre_GUBUN      = "";
        if ( voList.size() > 0 )
        {
            for ( int i = 0; i < voList.size(); i++ )
            {
                DynamicValueObject vo = (DynamicValueObject)voList.get(i);
                if ( vo.getString("GBN_NM").equals("본사계") ) { }
                else
                {
                    if ( pre_GBN2_TAG.equals(vo.getString("GBN2_TAG")) )  {
                        hnwExtQuery.AddData("");
                    } else if ( vo.getString("GUBUN2").equals("계") ) {
                        hnwExtQuery.AddData("합계");
                    } else {
                        hnwExtQuery.AddData(vo.getString("GBN2_TAG"));
                    }

                    if ( pre_HEAD_NM.equals(vo.getString("HEAD_NM")) )  {
                        hnwExtQuery.AddData("");
                    } else if ( vo.getString("GUBUN3").equals("계") ) {
                        hnwExtQuery.AddData("계");
                    } else {
                        hnwExtQuery.AddData(vo.getString("HEAD_NM"));
                    }

                    if ( pre_GBN_NM.equals(vo.getString("GBN_NM")) || vo.getString("GBN_NM").equals("본사") )  {
                        hnwExtQuery.AddData("");
                        pre_GUBUN_temp = "";
                    } else if ( vo.getString("GUBUN4").equals("계") ) {
                        hnwExtQuery.AddData("계");
                        pre_GUBUN_temp = "계";
                    } else {
                        hnwExtQuery.AddData(vo.getString("GBN_NM"));
                        pre_GUBUN_temp = "";
                    }

                    hnwExtQuery.AddData(vo.getString("DPT_NM"));
                    hnwExtQuery.AddData(vo.getString("P_CNT"));
                    hnwExtQuery.AddData(vo.getString("PA_CNT"));
                    hnwExtQuery.AddData(vo.getString("PM_CNT"));
                    hnwExtQuery.AddData(vo.getString("PP_CNT"));



                    hnwExtQuery.AddData(vo.getString("OCC_CNT_A"));
                    if ( vo.getString("OCC_P_A").equals("0") ) {
                        hnwExtQuery.AddData("");
                    } else {
                        hnwExtQuery.AddData(vo.getString("OCC_P_A"));
                    }
                    hnwExtQuery.AddData(vo.getString("OCC_A_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("OCC_AP_A"));
                    hnwExtQuery.AddData(vo.getString("OCC_M_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("OCC_MP_A"));

                    hnwExtQuery.AddData(vo.getString("REP_Y_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("REP_YP_A"));
                    hnwExtQuery.AddData(vo.getString("REP_YA_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("REP_YAP_A"));
                    hnwExtQuery.AddData(vo.getString("REP_YM_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("REP_YMP_A"));

                    hnwExtQuery.AddData(vo.getString("REP_N_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("REP_NP_A"));
                    hnwExtQuery.AddData(vo.getString("REP_NA_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("REP_NAP_A"));
                    hnwExtQuery.AddData(vo.getString("REP_NM_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("REP_NMP_A"));

                    hnwExtQuery.AddData(vo.getString("AMT_N_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("AMT_NA_CNT_A"));
                    hnwExtQuery.AddData(vo.getString("AMT_NM_CNT_A"));




                    hnwExtQuery.AddData(vo.getString("OCC_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("OCC_DIF"));
                    if ( vo.getString("OCC_P_B").equals("0") ) {
                        hnwExtQuery.AddData("");
                    } else {
                        hnwExtQuery.AddData(vo.getString("OCC_P_B"));
                    }
                    hnwExtQuery.AddData(vo.getString("OCC_A_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("OCC_A_DIF"));
                    hnwExtQuery.AddData(vo.getString("OCC_AP_B"));
                    hnwExtQuery.AddData(vo.getString("OCC_M_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("OCC_M_DIF"));
                    hnwExtQuery.AddData(vo.getString("OCC_MP_B"));

                    hnwExtQuery.AddData(vo.getString("REP_Y_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("REP_Y_DIF"));
                    hnwExtQuery.AddData(vo.getString("REP_YP_B"));
                    hnwExtQuery.AddData(vo.getString("REP_YA_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("REP_YA_DIF"));
                    hnwExtQuery.AddData(vo.getString("REP_YAP_B"));
                    hnwExtQuery.AddData(vo.getString("REP_YM_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("REP_YM_DIF"));
                    hnwExtQuery.AddData(vo.getString("REP_YMP_B"));

                    hnwExtQuery.AddData(vo.getString("REP_N_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("REP_N_DIF"));
                    hnwExtQuery.AddData(vo.getString("REP_NP_B"));
                    hnwExtQuery.AddData(vo.getString("REP_NA_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("REP_NA_DIF"));
                    hnwExtQuery.AddData(vo.getString("REP_NAP_B"));
                    hnwExtQuery.AddData(vo.getString("REP_NM_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("REP_NM_DIF"));
                    hnwExtQuery.AddData(vo.getString("REP_NMP_B"));

                    hnwExtQuery.AddData(vo.getString("AMT_N_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("AMT_N_DIF"));
                    hnwExtQuery.AddData(vo.getString("AMT_NA_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("AMT_NA_DIF"));
                    hnwExtQuery.AddData(vo.getString("AMT_NM_CNT_B"));
                    hnwExtQuery.AddData(vo.getString("AMT_NM_DIF"));



                    hnwExtQuery.AddData(vo.getString("OCC_P_CNT"));
                    hnwExtQuery.AddData(vo.getString("OCC_PP_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_YP_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_YPP"));
                    hnwExtQuery.AddData(vo.getString("REP_NP_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_NPP"));
                    hnwExtQuery.AddData(vo.getString("AMT_NP_CNT"));
                    hnwExtQuery.AddData(vo.getString("ETC"));
                    hnwExtQuery.AddData(vo.getString("GUBUN"));
                    hnwExtQuery.AddData(pre_GUBUN);
                    hnwExtQuery.AddData(ymd_val);

                    hnwExtQuery.SendData(response);

                    pre_GBN2_TAG = vo.getString("GBN2_TAG");
                    pre_HEAD_NM  = vo.getString("HEAD_NM");
                    pre_GBN_NM   = vo.getString("GBN_NM");
                    pre_GUBUN    = pre_GUBUN_temp;
                }
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
                hnwExtQuery.AddData("");

                hnwExtQuery.SendData(response);
        }
    }
%>