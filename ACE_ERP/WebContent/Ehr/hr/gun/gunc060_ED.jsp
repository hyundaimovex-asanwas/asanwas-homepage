<%@page import="java.util.Date"%>
<!--
***********************************************************************
* @source      : gunc060_ED.jsp
* @description : ���ϱٹ���Ȳ��� PAGE
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

	    System.out.println("���� :  "+mm+" /");


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

        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
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

        hnwExtQuery.AddField("�ٹ��ο���");
        hnwExtQuery.AddField("�ٹ��ο�%");
        hnwExtQuery.AddField("�繫����");
        hnwExtQuery.AddField("�繫��%");
        hnwExtQuery.AddField("�ù�����");
        hnwExtQuery.AddField("�ù���%");

        hnwExtQuery.AddField("��ü�ް���");
        hnwExtQuery.AddField("��ü�ް�%");
        hnwExtQuery.AddField("�繫����");
        hnwExtQuery.AddField("�繫��%");
        hnwExtQuery.AddField("�ù�����");
        hnwExtQuery.AddField("�ù���%");

        hnwExtQuery.AddField("�ٹ������û�ο���");
        hnwExtQuery.AddField("�ٹ������û�ο�%");
        hnwExtQuery.AddField("�繫����");
        hnwExtQuery.AddField("�繫��%");
        hnwExtQuery.AddField("�ù�����");
        hnwExtQuery.AddField("�ù���%");

        hnwExtQuery.AddField("�ٹ������");
        hnwExtQuery.AddField("�繫�������");
        hnwExtQuery.AddField("�ù��������");

        hnwExtQuery.AddField("�İ߻���ٹ��ο���");
        hnwExtQuery.AddField("�İ߻���ٹ��ο�%");
        hnwExtQuery.AddField("���޻���ο���");
        hnwExtQuery.AddField("���޻���ο�%");
        hnwExtQuery.AddField("�����û�ο���");
        hnwExtQuery.AddField("�����û�ο�%");
        hnwExtQuery.AddField("�ٹ������");
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