<!--
***********************************************************************
* @source      : memb120_ED.jsp
* @description : ��ü�� �İ߻�� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/20      ���м�        �����ۼ�.        
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
    String str_ymd = request.getParameter("str_ymd");
    
    String str_ymd_val = "";
    String str_y       = str_ymd.substring(0,4);
    String str_m       = str_ymd.substring(5,7);
    
    str_ymd_val = str_y + str_m;
    String title_val   = "( " + str_y + ".   " + str_m + ".   ";

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB130_SHR");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val
            , str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val
            ,str_y ,str_m ,str_ymd_val ,str_ymd_val
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("��ü��");
    hnwExtQuery.AddField("�ٹ��μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���Ⱓ");
    hnwExtQuery.AddField("�İߴܰ�");
    hnwExtQuery.AddField("�ݼ������");
    hnwExtQuery.AddField("��Ÿ");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("���ϱٹ�����");
    hnwExtQuery.AddField("�Ⱓ");
    hnwExtQuery.AddField("�ݾ�");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("���а�");
    hnwExtQuery.AddField("���� ��������¥");
    hnwExtQuery.AddField("�Ⱓǥ��");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_DISCOMP = "";
    String pre_DPT     = "";

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if  ( vo.getString("INT").equals("1") ) {
                hnwExtQuery.AddData(vo.getString("DISCOMP_NM"));
                hnwExtQuery.AddData("");
            } else if ( vo.getString("INT").equals("2") ) {
                hnwExtQuery.AddData("");
                hnwExtQuery.AddData("�Ұ�");
            } else if ( vo.getString("INT").equals("3") ) {
                if ( vo.getString("DISCOMP_NM").equals(pre_DISCOMP) ) {
                    hnwExtQuery.AddData("");
                } else {
                    hnwExtQuery.AddData(vo.getString("DISCOMP_NM"));
                }
                if ( vo.getString("DPT_NM").equals(pre_DPT) ) {
                    hnwExtQuery.AddData("");
                } else {
                    hnwExtQuery.AddData(vo.getString("DPT_NM"));
                }
            }
            if  ( vo.getString("INT").equals("1") ) {
                hnwExtQuery.AddData(vo.getString("CNT"));
            } else if ( vo.getString("INT").equals("2") ) {
                hnwExtQuery.AddData(vo.getString("CNT"));
            } else if ( vo.getString("INT").equals("3") ) {
                hnwExtQuery.AddData(vo.getString("ENO_NM"));
            }
            hnwExtQuery.AddData(vo.getString("TERM_YMD"));
            hnwExtQuery.AddData(vo.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo.getString("LSEV_AMT"));
            hnwExtQuery.AddData(vo.getString("WEL_AMT"));
            hnwExtQuery.AddData(vo.getString("TOT"));
            hnwExtQuery.AddData(vo.getString("HOW_AMT"));
            hnwExtQuery.AddData(vo.getString("M_YMD"));
            hnwExtQuery.AddData(vo.getString("TOT2"));
            hnwExtQuery.AddData(vo.getString("ETC"));
            hnwExtQuery.AddData(vo.getString("INT"));
            hnwExtQuery.AddData(vo.getString("LASTDAY"));
            hnwExtQuery.AddData(title_val);

            hnwExtQuery.SendData(response);

            pre_DISCOMP = vo.getString("DISCOMP_NM");
            pre_DPT     = vo.getString("DPT_NM");
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
            
            hnwExtQuery.SendData(response);
    }

%>