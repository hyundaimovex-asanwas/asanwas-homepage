<!--
***********************************************************************
* @source      : yaca030_ED.jsp
* @description : �Ƿ�����޸��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/10      ���м�        �����ۼ�.
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
    String pis_yy = request.getParameter("pis_yy");
    String eno_no = request.getParameter("eno_no");

//  --------------------------------ȸ������ ��ȸ--------------------------------------------------------
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql3 = XmlSqlUtils.getSQL("yac", "YACA040_SHR_03");

    String COMP_NM = "";
    String TAX_NO  = "";
    String C_ADDR  = "";
    String TEL_NO  = "";

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam3 = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql3 = SqlUtils.replaceQuery(sql3, sqlParam3);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind3 = new Object[] {
    };

    AbstractDAO aaa3= new AbstractDAO("default");
    DynamicValueObject voList3 = aaa3.selectProcessDvo(sql3, bind3);

    if (voList3.size() > 0)
    {
        DynamicValueObject vo3 = (DynamicValueObject)voList3.get(0);
        COMP_NM = vo3.getString("COMP_NM");
        TAX_NO  = vo3.getString("TAX_NO");
        C_ADDR    = vo3.getString("ADDR");
        TEL_NO  = vo3.getString("TEL_NO");
    }

//-----------------------------------------------------------------------------------------

//--------------------------------������� ��ȸ--------------------------------------------------------
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql1 = XmlSqlUtils.getSQL("yac", "YACA030_SHR_02");

    String eno_nm = "";
    String addr   = "";
    String cet_no = "";

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam1 = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql1 = SqlUtils.replaceQuery(sql1, sqlParam1);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind1 = new Object[] {
        eno_no
    };

    AbstractDAO aaa1= new AbstractDAO("default");
    DynamicValueObject voList1 = aaa1.selectProcessDvo(sql1, bind1);
    String[] gubun  = new String[voList1.size()];

    if (voList1.size() > 0)
    {
        DynamicValueObject vo1 = (DynamicValueObject)voList1.get(0);
        eno_nm = vo1.getString("ENO_NM");
        cet_no = vo1.getString("CET_NO");
        addr   = vo1.getString("ADDR");
    }

//-----------------------------------------------------------------------------------------

//--------------------------------�Ƿ��������� ��ȸ--------------------------------------------------------

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql2 = XmlSqlUtils.getSQL("yac", "YACA030_SHR");

    String gbn_tag = "";

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam2 = new Object[] {

    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind2 = new Object[] {
        pis_yy, eno_no
    };

    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);
//-----------------------------------------------------------------------------------------

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ֹε�Ϲ�ȣ");
    hnwExtQuery.AddField("�ּ�");
    hnwExtQuery.AddField("����ڵ�Ϲ�ȣ");
    hnwExtQuery.AddField("��ȣ");
    hnwExtQuery.AddField("ī��Ǽ�");
    hnwExtQuery.AddField("���ݰǼ�");
    hnwExtQuery.AddField("�Ǽ�");
    hnwExtQuery.AddField("ī��ݾ�");
    hnwExtQuery.AddField("���ݱݾ�");
    hnwExtQuery.AddField("�ݾ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����� �ֹε�Ϲ�ȣ");
    hnwExtQuery.AddField("���� �� �ش翩��");
    hnwExtQuery.AddField("ȸ���ȣ");
    hnwExtQuery.AddField("ȸ�����ڵ�Ϲ�ȣ");
    hnwExtQuery.AddField("ȸ���ּ�");
    hnwExtQuery.AddField("ȸ����ȭ��ȣ");
    hnwExtQuery.AddField("�Ƿ������ڵ�");

    hnwExtQuery.SendField(response);

    //System.out.println("voList.size()="+voList2.size());
    int i = 0;
    int k = 0;
    int row_size = 0;
    row_size = 10 - (voList2.size()%10) + (voList2.size()/10);

    if (voList2.size() > 0)
    {
        for ( i=0; i<voList2.size(); i++ )
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);

            if ( vo2.getString("GBN_TAG").equals("A") || vo2.getString("GBN_TAG").equals("B") || vo2.getString("REL_CD").equals("0") ) {
                gbn_tag = "��";
            } else {
                gbn_tag = "X";
            }

            hnwExtQuery.AddData(eno_nm);
            hnwExtQuery.AddData(cet_no);
            hnwExtQuery.AddData(addr);
            hnwExtQuery.AddData(vo2.getString("COM_NO"));
            hnwExtQuery.AddData(vo2.getString("COM_NM"));
            hnwExtQuery.AddData(vo2.getString("CARD_CNT"));
            hnwExtQuery.AddData(vo2.getString("CASH_CNT"));
            hnwExtQuery.AddData(vo2.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo2.getString("CARD_AMT"));
            hnwExtQuery.AddData(vo2.getString("CASH_AMT"));
            hnwExtQuery.AddData(vo2.getString("SUM_AMT"));
            hnwExtQuery.AddData(vo2.getString("REL_CD"));
            hnwExtQuery.AddData(vo2.getString("CET_NO"));

            hnwExtQuery.AddData(gbn_tag);

            hnwExtQuery.AddData(COMP_NM);
            hnwExtQuery.AddData(TAX_NO);
            hnwExtQuery.AddData(C_ADDR);
            hnwExtQuery.AddData(TEL_NO);
            hnwExtQuery.AddData(vo2.getString("MED_CD"));

            hnwExtQuery.SendData(response);
        }

        for ( k=0; k<row_size; k++ )
        {
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

    } else {
        for ( k=0; k<10; k++ )
        {
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