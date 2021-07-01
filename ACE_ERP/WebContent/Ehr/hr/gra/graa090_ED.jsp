<!--
***********************************************************************
* @source      : graa090_ED.jsp
* @description : ����±� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/06      ���м�        �����ۼ�.
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
    String REC_YMD_SHR = request.getParameter("REC_YMD_SHR");

    String str_ymd  = "";
    String str_ymd2 = "";
    String end_ymd  = "";

    int rec_y_str     = Integer.parseInt(REC_YMD_SHR)-5;
    String rec_y_str2 = Integer.toString(rec_y_str);

    str_ymd  = REC_YMD_SHR + "0101";
    str_ymd2 = REC_YMD_SHR + "0301";
    end_ymd  = REC_YMD_SHR + "1201";

    int i = 0;

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("gra", "GRAA090_SHR");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
    	  REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ο�");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("����±�");
    hnwExtQuery.AddField("Ư���±�");
    hnwExtQuery.AddField("��1");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ߵ��Ի�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("��Ÿ����");
    hnwExtQuery.AddField("����ҷ�");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("T1"));
            hnwExtQuery.AddData(vo.getString("B_CNT"));
            hnwExtQuery.AddData(vo.getString("C_CNT"));
            hnwExtQuery.AddData(vo.getString("T2"));
            hnwExtQuery.AddData(vo.getString("D_CNT"));
            hnwExtQuery.AddData(vo.getString("E_CNT"));
            hnwExtQuery.AddData(vo.getString("F_CNT"));
            hnwExtQuery.AddData(vo.getString("G_CNT"));
            hnwExtQuery.AddData(vo.getString("H_CNT"));

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

            hnwExtQuery.SendData(response);
    }

%>