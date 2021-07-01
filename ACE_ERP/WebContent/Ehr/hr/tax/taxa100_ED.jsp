<!--
***********************************************************************
* @source      : taxa100_ED.jsp                                                *
* @description : �������μ���������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/05      ���м�        �����ۼ�.
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
    String STR_YM  = request.getParameter("STR_YM");
    String END_YM  = request.getParameter("END_YM");
    String OCC_CD1  = request.getParameter("OCC_CD1");
    String OCC_CD2  = request.getParameter("OCC_CD2");
    String SAL_GBN = request.getParameter("SAL_GBN");
    String SEQ     = request.getParameter("SEQ");
    String LUN_AMT = request.getParameter("LUN_AMT");
    String Query = "";
    /** �ܺ� XML���� SQL�� �о� �´� **/
    if ( SEQ.equals("10") ) {
        Query = XmlSqlUtils.getSQL("tax", "TAXA100_SHR1");
    } else if ( SEQ.equals("20") ) {
        Query = XmlSqlUtils.getSQL("tax", "TAXA100_SHR2");
    } else {
        Query = XmlSqlUtils.getSQL("tax", "TAXA100_SHR3");
    }

    //param binding �ϱ�
    Object[] bind = new Object[] {
            OCC_CD1,
            OCC_CD2,
        SAL_GBN,
        STR_YM.replaceAll("-", ""),
        END_YM.replaceAll("-", "")
    };

//    Log.debug.println("ORDER_TYPE:"+orderType);



    //DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ�
    Object[] sqlParam = new Object[] {

    };

    //[1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ�
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����/�μ�");
    hnwExtQuery.AddField("�ο�");
    hnwExtQuery.AddField("�޿���");
    hnwExtQuery.AddField("�����װ�");
    hnwExtQuery.AddField("�������޾�");
    hnwExtQuery.AddField("����������");
    hnwExtQuery.AddField("���ټ�");
    hnwExtQuery.AddField("�ֹμ�");
    hnwExtQuery.AddField("����ȸ��");
    hnwExtQuery.AddField("�ǰ������");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("��뺸��");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("�ݰ����ڱ�");
    hnwExtQuery.AddField("���ڻ�ȯ��");
    hnwExtQuery.AddField("�����ޱ�");
    hnwExtQuery.AddField("��Ÿ������");
    hnwExtQuery.AddField("�߽Ĵ�");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPTJOB_NM"));
            hnwExtQuery.AddData(vo.getString("CNT"));
            if ( LUN_AMT.equals("Y") ) {
            	hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            } else {
                hnwExtQuery.AddData(Integer.toString(Integer.parseInt(vo.getString("SALT_AMT")) - Integer.parseInt(vo.getString("LUN_AMT"))));
            }
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
            hnwExtQuery.AddData(vo.getString("STAX_DED"));
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));
            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("SAV_AMT"));
            hnwExtQuery.AddData(vo.getString("INV_AMT"));
            hnwExtQuery.AddData(vo.getString("LON_RPY"));
            hnwExtQuery.AddData(vo.getString("ADV_AMT"));
            hnwExtQuery.AddData(vo.getString("ECT"));
            hnwExtQuery.AddData(vo.getString("LUN_AMT"));
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
        hnwExtQuery.SendData(response);
    }

%>