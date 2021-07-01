<!--
***********************************************************************
* @source      : memb080_ED.jsp
* @description : �μ��� ��,��� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/18      ���м�        �����ۼ�.        
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
    String str_m_val   = "";
    String end_m_val   = "";
    String str_d_val   = "";
    String end_d_val   = "";

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


    str_m_val = str_ymd.substring(5,6);
    end_m_val = str_ymd.substring(5,6);
    str_d_val = str_ymd.substring(8,9);
    end_d_val = str_ymd.substring(8,9);
    if ( str_m_val.equals("0") ) {
        str_m_val = str_ymd.substring(6,7);
    } else {
        str_m_val = str_ymd.substring(5,7);
    }
    if ( end_m_val.equals("0") ) {
        end_m_val = end_ymd.substring(6,7);
    } else {
        end_m_val = end_ymd.substring(5,7);
    }

    if ( str_d_val.equals("0") ) {
        str_d_val = str_ymd.substring(9,10);
    } else {
        str_d_val = str_ymd.substring(8,10);
    }
    if ( end_d_val.equals("0") ) {
        end_d_val = end_ymd.substring(9,10);
    } else {
        end_d_val = end_ymd.substring(8,10);
    }

    String ymd_val1 = "�� �� �� �� �� �� (" + str_y2 + "." + str_m_val + "." + str_d_val + " ~ " + end_y2 + "." + end_m_val + "." + end_d_val + ")";
    String ymd_val2 = "��     ��     �� ("  + end_y2 + "." + end_m_val + "." + end_d_val + "����)";

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB100_SHR");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        end_ymd_val, str_ymd_val, end_ymd_val, str_ymd_val, end_ymd_val, str_ymd_val, end_ymd_val, str_ymd_val, end_ymd_val
            , str_ymd_val, end_ymd_val, str_ymd_val, end_ymd_val, end_ymd_val, end_ymd_val, end_ymd_val, end_ymd_val
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("���и�1");
    hnwExtQuery.AddField("���и�2");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("�Ի�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���Ұ�");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�������ȯ");
    hnwExtQuery.AddField("���Ұ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("������������");
    hnwExtQuery.AddField("������������");
    hnwExtQuery.AddField("�������繫");
    hnwExtQuery.AddField("TM");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("B/L");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���а�1");
    hnwExtQuery.AddField("�ο���������title");
    hnwExtQuery.AddField("���ο�title");
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_GUBUN_NM = "";
    String pre_COMM_NM  = "";
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            if ( pre_GUBUN_NM.equals(vo.getString("GUBUN_NM")) || vo.getString("INT1").equals("2")  ) {
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(vo.getString("GUBUN_NM"));
            }
            
            if ( pre_COMM_NM.equals(vo.getString("COMM_NM")) || vo.getString("INT1").equals("3") ) {     
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(vo.getString("COMM_NM"));
            }
/*   
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
*/
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("HIR"));
            hnwExtQuery.AddData(vo.getString("APPIN"));
            hnwExtQuery.AddData(vo.getString("TOT1"));
            hnwExtQuery.AddData(vo.getString("RET"));
            hnwExtQuery.AddData(vo.getString("APPRET"));
            hnwExtQuery.AddData(vo.getString("CHNG"));
            hnwExtQuery.AddData(vo.getString("TOT2"));
            hnwExtQuery.AddData(vo.getString("TOT3"));
            hnwExtQuery.AddData(vo.getString("THIS_TOT"));
            hnwExtQuery.AddData(vo.getString("1_GBN"));
            hnwExtQuery.AddData(vo.getString("2_GBN"));
            hnwExtQuery.AddData(vo.getString("3_GBN"));
            hnwExtQuery.AddData(vo.getString("4_GBN"));
            hnwExtQuery.AddData(vo.getString("5_GBN"));
            hnwExtQuery.AddData(vo.getString("6_GBN"));
            hnwExtQuery.AddData(vo.getString("7_GBN"));
            hnwExtQuery.AddData(vo.getString("INT1"));
            hnwExtQuery.AddData(ymd_val1);
            hnwExtQuery.AddData(ymd_val2);

//            hnwExtQuery.AddData(ymd_val);
//            hnwExtQuery.AddData(str_val);
//            hnwExtQuery.AddData(end_val);
/*
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
*/
            pre_GUBUN_NM = vo.getString("GUBUN_NM");
            pre_COMM_NM  = vo.getString("COMM_NM");
 
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
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
    }

%>