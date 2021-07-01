<%@page import="java.util.Date"%>
<!--
***********************************************************************
* @source      : gunc060_ED.jsp
* @description : 휴일근무현황통계 PAGE
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
<%@page import=" java.text.SimpleDateFormat "   %>
<%@page import=" common.util.JSPUtil "   %>


<%
    String reg_ymd = request.getParameter("reg_ymd");
    String gubun   = request.getParameter("gubun");
    String ymd_val = request.getParameter("ymd_val");




    if ( reg_ymd == null || reg_ymd.equals("") ) { }
    else {
        String reg_y = reg_ymd.substring(0,4);
        String reg_m = reg_ymd.substring(5,7);
        String reg_d = "";

        if ( gubun.equals("0") ) {
            reg_d = reg_ymd.substring(8,10);
        }

        String str_ymd = "";
        String end_ymd = "";
        String hol_ymd = "";
        String reg_ymd2 = "";
        String gubun_val = "";
        String change_tab = "";


		String	format = "yyyyMM";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date sDate;
		sDate = sdf.parse(reg_ymd.substring(0,4)+(Integer.parseInt(reg_ymd.substring(5,7))-1));
		String mm = Integer.toString(sDate.getMonth()+1);
		mm = JSPUtil.getLpad(mm,"0",2);

	    System.out.println("내용 :  "+mm+" /");


        if ( gubun.equals("0") )
        {
            str_ymd = "'" + reg_y + reg_m + reg_d + "'";
            end_ymd = "'" + reg_y + reg_m + reg_d + "'";
            gubun_val = "'1','2','3'";

            change_tab="T_DI_HOLIDAYWORK H";
            hol_ymd  = " HOL_YMD ='" + reg_y + reg_m + reg_d + "'";
            reg_ymd2 = " REG_YMD ='" + reg_y + reg_m + reg_d + "'";
        }
        else
        {
            str_ymd = "'" + reg_y + mm + "10'";
            end_ymd = "'" + reg_y + reg_m + "10'";  //"to_char(last_day(to_date(" + str_ymd + ",'yyyymmdd')),'yyyymmdd')";
            if ( gubun.equals("1") ) {
                gubun_val = "'1'";
            } else {
                gubun_val = "'2','3'";
            }

            change_tab="T_DI_HOLIDAYWORK H , T_DI_APPROVAL K";
            hol_ymd  = " HOL_YMD > " + str_ymd + " AND HOL_YMD <= " + end_ymd + " AND SUBSTR(K.GUN_YMD,1,6)= "+ end_ymd.substring(0,7) + "'" + " AND K.GUN_GBN='R' AND K.SEQ_NO='2' AND K.APP_YN='Y' " ;
            reg_ymd2 = " REG_YMD > " + str_ymd + " AND REG_YMD <= " + end_ymd;
        }

        String sql = XmlSqlUtils.getSQL("gun", "GUNC060_SHR");

        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {
                str_ymd
               ,end_ymd
               ,str_ymd
               ,end_ymd
               ,change_tab
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

        hnwExtQuery.AddField("근무인원계");
        hnwExtQuery.AddField("근무인원%");
        hnwExtQuery.AddField("사무직계");
        hnwExtQuery.AddField("사무직%");
        hnwExtQuery.AddField("택배직계");
        hnwExtQuery.AddField("택배직%");

        hnwExtQuery.AddField("대체휴가계");
        hnwExtQuery.AddField("대체휴가%");
        hnwExtQuery.AddField("사무직계");
        hnwExtQuery.AddField("사무직%");
        hnwExtQuery.AddField("택배직계");
        hnwExtQuery.AddField("택배직%");

        hnwExtQuery.AddField("근무수당신청인원계");
        hnwExtQuery.AddField("근무수당신청인원%");
        hnwExtQuery.AddField("사무직계");
        hnwExtQuery.AddField("사무직%");
        hnwExtQuery.AddField("택배직계");
        hnwExtQuery.AddField("택배직%");

        hnwExtQuery.AddField("근무수당액");
        hnwExtQuery.AddField("사무직수당액");
        hnwExtQuery.AddField("택배직수당액");

        hnwExtQuery.AddField("파견사원근무인원계");
        hnwExtQuery.AddField("파견사원근무인원%");
        hnwExtQuery.AddField("대휴사용인원계");
        hnwExtQuery.AddField("대휴사용인원%");
        hnwExtQuery.AddField("수당신청인원계");
        hnwExtQuery.AddField("수당신청인원%");
        hnwExtQuery.AddField("근무수당액");
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

                    hnwExtQuery.AddData(vo.getString("OCC_CNT"));
                    hnwExtQuery.AddData(vo.getString("OCC_P"));
                    hnwExtQuery.AddData(vo.getString("OCC_A_CNT"));
                    hnwExtQuery.AddData(vo.getString("OCC_AP"));
                    hnwExtQuery.AddData(vo.getString("OCC_M_CNT"));
                    hnwExtQuery.AddData(vo.getString("OCC_MP"));

                    hnwExtQuery.AddData(vo.getString("REP_Y_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_YP"));
                    hnwExtQuery.AddData(vo.getString("REP_YA_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_YAP"));
                    hnwExtQuery.AddData(vo.getString("REP_YM_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_YMP"));

                    hnwExtQuery.AddData(vo.getString("REP_N_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_NP"));
                    hnwExtQuery.AddData(vo.getString("REP_NA_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_NAP"));
                    hnwExtQuery.AddData(vo.getString("REP_NM_CNT"));
                    hnwExtQuery.AddData(vo.getString("REP_NMP"));

                    hnwExtQuery.AddData(vo.getString("AMT_N_CNT"));
                    hnwExtQuery.AddData(vo.getString("AMT_NA_CNT"));
                    hnwExtQuery.AddData(vo.getString("AMT_NM_CNT"));

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

                hnwExtQuery.SendData(response);
        }
    }
%>