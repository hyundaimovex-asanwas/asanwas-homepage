<!--
***********************************************************************
* @source      : reta030_ED.jsp
* @description : �����ݰ��ó��(���� ���� ������ ��ȸ) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      ���м�        �����ۼ�.
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

    String eno_no = request.getParameter("eno_no");
    String occ_cd = (request.getParameter("occ_cd")==null)?"A":request.getParameter("occ_cd");
    String TYPE = request.getParameter("TYPE");

    System.out.println("type  ="+TYPE  );


    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA030_SHR_PAY_RET");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
 		eno_no,
 		TYPE
    };
    int i = 0;
    int tot_cnt = 0;
    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
    String[][] arr_temp = new String[5][9];
    if ( occ_cd.equals("A") ) {
        arr_temp[0][0] = "�⺻��";
        arr_temp[0][1] = "��������";
        arr_temp[0][2] = "��������";
        arr_temp[0][3] = "�󿩱�";
        arr_temp[0][4] = "��Ÿ����";
        arr_temp[0][5] = "��Ÿ����";
    }
    for ( i = 0; i < voList.size(); i++ )
    {
        DynamicValueObject vo = (DynamicValueObject)voList.get(i);

        arr_temp[i+1][0] = vo.getString("BAS_AMT");
        arr_temp[i+1][1] = vo.getString("DUTY_AMT");
        arr_temp[i+1][2] = vo.getString("LAW_AMT");
        arr_temp[i+1][3] = vo.getString("BNS_AMT");
        arr_temp[i+1][4] = vo.getString("OTH_AMT");
        arr_temp[i+1][5] = vo.getString("HOL_AMT");
    }

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("COL_1");
    hnwExtQuery.AddField("COL_2");
    hnwExtQuery.AddField("COL_3");
    hnwExtQuery.AddField("COL_4");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for ( i=0; i<6; i++ )
        {
            hnwExtQuery.AddData(arr_temp[0][i]);
            hnwExtQuery.AddData(arr_temp[1][i]);
            hnwExtQuery.AddData(arr_temp[2][i]);
            hnwExtQuery.AddData(arr_temp[3][i]);
            hnwExtQuery.AddData(arr_temp[4][i]);
            
            System.out.println("arr_temp[0]["+i+"]===="+arr_temp[0][i]);
            System.out.println("arr_temp[1]["+i+"]===="+arr_temp[1][i]);
            System.out.println("arr_temp[2]["+i+"]===="+arr_temp[2][i]);
            System.out.println("arr_temp[3]["+i+"]===="+arr_temp[3][i]);
            System.out.println("arr_temp[4]["+i+"]===="+arr_temp[4][i]);

            hnwExtQuery.SendData(response);
        }
    } else {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
    }

%>