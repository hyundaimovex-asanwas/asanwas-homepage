<!--
***********************************************************************
* @source      : gunc050_ED.jsp
* @description : ���ϱٹ���Ȳ�� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/05      ���м�        �����ۼ�.
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

        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {
                str_ymd
               ,end_ymd
               ,str_ymd
               ,end_ymd
               ,hol_ymd
               ,reg_ymd2
               ,gubun_val
        };

        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        Object[] bind = new Object[] {

        };

        AbstractDAO aaa= new AbstractDAO("default");

        DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

        extquery hnwExtQuery = new extquery();

        hnwExtQuery.AddField("����1");
        hnwExtQuery.AddField("����2");
        hnwExtQuery.AddField("����3");
        hnwExtQuery.AddField("����4");
        hnwExtQuery.AddField("��");
        hnwExtQuery.AddField("�繫��");
        hnwExtQuery.AddField("�ù���");
        hnwExtQuery.AddField("�İ߻��");

        hnwExtQuery.AddField("�ٹ��ο���_A");
        hnwExtQuery.AddField("�ٹ��ο�%_A");
        hnwExtQuery.AddField("�繫����1_A");
        hnwExtQuery.AddField("�繫��%1_A");
        hnwExtQuery.AddField("�ù�����1_A");
        hnwExtQuery.AddField("�ù���%1_A");

        hnwExtQuery.AddField("��ü�ް���_A");
        hnwExtQuery.AddField("��ü�ް�%_A");
        hnwExtQuery.AddField("�繫����2_A");
        hnwExtQuery.AddField("�繫��%2_A");
        hnwExtQuery.AddField("�ù�����2_A");
        hnwExtQuery.AddField("�ù���%2_A");

        hnwExtQuery.AddField("�ٹ������û�ο���_A");
        hnwExtQuery.AddField("�ٹ������û�ο�%_A");
        hnwExtQuery.AddField("�繫����3_A");
        hnwExtQuery.AddField("�繫��%3_A");
        hnwExtQuery.AddField("�ù�����3_A");
        hnwExtQuery.AddField("�ù���%_A");

        hnwExtQuery.AddField("�ٹ������1_A");
        hnwExtQuery.AddField("�繫�������_A");
        hnwExtQuery.AddField("�ù��������_A");



        hnwExtQuery.AddField("�ٹ��ο���_B");
        hnwExtQuery.AddField("�ٹ��ο�����_B");
        hnwExtQuery.AddField("�ٹ��ο�%_B");
        hnwExtQuery.AddField("�繫����1_B");
        hnwExtQuery.AddField("�繫������1_B");
        hnwExtQuery.AddField("�繫��%1_B");
        hnwExtQuery.AddField("�ù�����1_B");
        hnwExtQuery.AddField("�ù�������1_B");
        hnwExtQuery.AddField("�ù���%1_B");

        hnwExtQuery.AddField("��ü�ް���_B");
        hnwExtQuery.AddField("��ü�ް�����_B");
        hnwExtQuery.AddField("��ü�ް�%_B");
        hnwExtQuery.AddField("�繫����2_B");
        hnwExtQuery.AddField("�繫������2_B");
        hnwExtQuery.AddField("�繫��%2_B");
        hnwExtQuery.AddField("�ù�����2_B");
        hnwExtQuery.AddField("�ù�������2_B");
        hnwExtQuery.AddField("�ù���%2_B");

        hnwExtQuery.AddField("�ٹ������û�ο���_B");
        hnwExtQuery.AddField("�ٹ������û�ο�����_B");
        hnwExtQuery.AddField("�ٹ������û�ο�%_B");
        hnwExtQuery.AddField("�繫����3_B");
        hnwExtQuery.AddField("�繫������3_B");
        hnwExtQuery.AddField("�繫��%3_B");
        hnwExtQuery.AddField("�ù�����3_B");
        hnwExtQuery.AddField("�ù�������3_B");
        hnwExtQuery.AddField("�ù���%_B");

        hnwExtQuery.AddField("�ٹ������1_B");
        hnwExtQuery.AddField("�ٹ����������1_B");
        hnwExtQuery.AddField("�繫�������_B");
        hnwExtQuery.AddField("�繫�����������_B");
        hnwExtQuery.AddField("�ù��������_B");
        hnwExtQuery.AddField("�ù������������_B");


        hnwExtQuery.AddField("�İ߻���ٹ��ο���");
        hnwExtQuery.AddField("�İ߻���ٹ��ο�%");
        hnwExtQuery.AddField("���޻���ο���");
        hnwExtQuery.AddField("���޻���ο�%");
        hnwExtQuery.AddField("�����û�ο���");
        hnwExtQuery.AddField("�����û�ο�%");
        hnwExtQuery.AddField("�ٹ������2");
        hnwExtQuery.AddField("���");
        hnwExtQuery.AddField("���а�");
        hnwExtQuery.AddField("���а�2");
        hnwExtQuery.AddField("��¥");


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
                if ( vo.getString("GBN_NM").equals("�����") ) { }
                else
                {
                    if ( pre_GBN2_TAG.equals(vo.getString("GBN2_TAG")) )  {
                        hnwExtQuery.AddData("");
                    } else if ( vo.getString("GUBUN2").equals("��") ) {
                        hnwExtQuery.AddData("�հ�");
                    } else {
                        hnwExtQuery.AddData(vo.getString("GBN2_TAG"));
                    }

                    if ( pre_HEAD_NM.equals(vo.getString("HEAD_NM")) )  {
                        hnwExtQuery.AddData("");
                    } else if ( vo.getString("GUBUN3").equals("��") ) {
                        hnwExtQuery.AddData("��");
                    } else {
                        hnwExtQuery.AddData(vo.getString("HEAD_NM"));
                    }

                    if ( pre_GBN_NM.equals(vo.getString("GBN_NM")) || vo.getString("GBN_NM").equals("����") )  {
                        hnwExtQuery.AddData("");
                        pre_GUBUN_temp = "";
                    } else if ( vo.getString("GUBUN4").equals("��") ) {
                        hnwExtQuery.AddData("��");
                        pre_GUBUN_temp = "��";
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