<!--
***********************************************************************
* @source      : memb080_ED.jsp
* @description : �İ߻�� ������� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/12      ���м�        �����ۼ�.        
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
    String end_ymd = request.getParameter("end_ymd");
    String gubun   = request.getParameter("gubun");
    String str_ymd_val = "";
    String end_ymd_val = "";

    String str_y  = str_ymd.substring(0,4);
    String str_y2 = str_ymd.substring(2,4);
    String str_m  = str_ymd.substring(5,7);
    String str_d  = str_ymd.substring(8,10);
    
    String end_y  = end_ymd.substring(0,4);
    String end_y2 = end_ymd.substring(2,4);
    String end_m  = end_ymd.substring(5,7);
    String end_d  = end_ymd.substring(8,10);
    
    str_ymd_val = str_y + str_m + str_d;
    end_ymd_val = end_y + end_m + end_d;

    String ymd_val = "(" + str_y + "." + str_m + "." + str_d + " ~ " + end_y + "." + end_m + "." + end_d + ")";
    String str_val = "'" + str_y2 + "/" + str_m + "/" + str_d;
    String end_val = "'" + end_y2 + "/" + end_m + "/" + end_d;
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB080_SHR");
    
    str_ymd = str_ymd.replaceAll("-","");
    end_ymd = end_ymd.replaceAll("-","");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        end_ymd, str_ymd, str_ymd, end_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd
            , str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, str_ymd, end_ymd, end_ymd, str_ymd
            , end_ymd, str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("���й�ȣ");
    hnwExtQuery.AddField("���и�1");
    hnwExtQuery.AddField("���и�2");
    hnwExtQuery.AddField("���۴�");
    hnwExtQuery.AddField("�����´�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ի�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ұ�");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�������ȯ");
    hnwExtQuery.AddField("�Ұ�2");
    hnwExtQuery.AddField("�Ⱓ");
    hnwExtQuery.AddField("���۴�ǥ��");
    hnwExtQuery.AddField("�����´�ǥ��");
    hnwExtQuery.AddField("��ǥ��1");
    hnwExtQuery.AddField("��ǥ��2");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_GUBUN    = "";
    String pre_GUBUN_NM = "";
    String pre_COMM_NM  = "";
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            if ( pre_GUBUN.equals(vo.getString("GUBUN")) )  {
                hnwExtQuery.AddData("");
            } else if ( vo.getString("GUBUN").equals("1") ) {     
                hnwExtQuery.AddData("����");
            } else if ( vo.getString("GUBUN").equals("99") ) {
                hnwExtQuery.AddData("������");
            } else if ( vo.getString("GUBUN").equals("0") ) {
                hnwExtQuery.AddData("�ѿ�");
            } else {
                hnwExtQuery.AddData(""); 
            }
            
            if ( vo.getString("GUBUN").equals("1") || vo.getString("GUBUN").equals("9") ) {  
                if ( pre_GUBUN_NM.equals(vo.getString("GUBUN_NM")) )  {
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(vo.getString("COMM_NM"));
                } else {
                    hnwExtQuery.AddData(vo.getString("GUBUN_NM"));
                    hnwExtQuery.AddData(vo.getString("COMM_NM"));
                }
            } else {
                if ( vo.getString("COMM_NM").equals("������������") || vo.getString("COMM_NM").equals("������������") ) {
                    if ( vo.getString("COMM_NM").equals("������������") )
                    {
                        hnwExtQuery.AddData("��������");
                        hnwExtQuery.AddData("����");
                    }
                    if ( vo.getString("COMM_NM").equals("������������") )
                    {
                        hnwExtQuery.AddData("");
                        hnwExtQuery.AddData("����");
                    }
                } else {
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(vo.getString("COMM_NM"));
                }
            }
            hnwExtQuery.AddData(vo.getString("STR_G"));
            hnwExtQuery.AddData(vo.getString("END_G"));
            hnwExtQuery.AddData(vo.getString("DIF"));
            hnwExtQuery.AddData(vo.getString("HIR"));
            hnwExtQuery.AddData(vo.getString("APPIN"));
            hnwExtQuery.AddData(vo.getString("TOT1"));
            hnwExtQuery.AddData(vo.getString("RET"));
            hnwExtQuery.AddData(vo.getString("APPRET"));
            hnwExtQuery.AddData(vo.getString("CHNG"));
            hnwExtQuery.AddData(vo.getString("TOT2"));
            hnwExtQuery.AddData(ymd_val);
            hnwExtQuery.AddData(str_val);
            hnwExtQuery.AddData(end_val);

            if ( pre_COMM_NM.equals("������������") ) {    //ǥ�ص�ǥ �����μ���
                hnwExtQuery.AddData("Y");
            } else if ( vo.getString("GUBUN").equals("99") && !pre_COMM_NM.equals("������������") ) {
                hnwExtQuery.AddData("K");
            } else {
                hnwExtQuery.AddData("N");
            }

            if ( vo.getString("GUBUN").equals("99") && !vo.getString("COMM_NM").equals("������������") && !vo.getString("COMM_NM").equals("������������") ) {
                hnwExtQuery.AddData("Y");
            } else {
                hnwExtQuery.AddData("N");
            }

            hnwExtQuery.SendData(response);

            pre_GUBUN    = vo.getString("GUBUN");
            pre_GUBUN_NM = vo.getString("GUBUN_NM");
            pre_COMM_NM  = vo.getString("COMM_NM"); 
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

            hnwExtQuery.SendData(response);
    }

%>