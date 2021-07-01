<!--
***********************************************************************
* @source         : saga060_ED.jsp 				                                                                                     *
* @description   : �޻�������Ȳ PAGE.
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/24      ���м�        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String STR_YYMM_SHR = request.getParameter("STR_YYMM_SHR");
    String END_YYMM_SHR = request.getParameter("END_YYMM_SHR");
    String OCC_CD_SHR   = request.getParameter("OCC_CD_SHR");
    String SAL_GBN_SHR  = request.getParameter("SAL_GBN_SHR");
    String SEQ_SHR      = request.getParameter("SEQ_SHR");
    String SORT_SHR     = request.getParameter("SORT_SHR");

    String sql = "";

    if ( SORT_SHR.equals("1") ) {
       /** �ܺ� XML���� SQL�� �о� �´� **/
        sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR");
    } else if ( SORT_SHR.equals("2") ) {
        sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_01");
    } else {
        sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_02");
    }

    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();
    if ( !SAL_GBN_SHR.equals("") ) {
        sb1.append("AND (B.SEQ LIKE '"+SEQ_SHR+"') \n");//�Ϸù�ȣ
        sb2.append("AND (B.SAL_GBN LIKE '"+SAL_GBN_SHR+"') \n");//�޻󿩱���
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        sb1.toString(),
        sb2.toString()
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        OCC_CD_SHR, STR_YYMM_SHR.replaceAll("-", ""), END_YYMM_SHR.replaceAll("-", "")
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
   
    hnwExtQuery.AddField("����/�μ�");
    hnwExtQuery.AddField("�ο�");
    hnwExtQuery.AddField("�⺻��");
    hnwExtQuery.AddField("��å����");
    hnwExtQuery.AddField("�ð��ܼ���");
    
    hnwExtQuery.AddField("��������,�������");
    hnwExtQuery.AddField("�ڱⰳ�ߺ�,�ù����");
    hnwExtQuery.AddField("�߱ټ���,����/�۾�����");
    hnwExtQuery.AddField("�������,�ڱⰳ�ߺ�");    
    hnwExtQuery.AddField("�ټӼ���");
    hnwExtQuery.AddField("�ڵ�����");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("��Ÿ���Ҿ�");
    hnwExtQuery.AddField("�޿���");    
    hnwExtQuery.AddField("�ǰ�����");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("��뺸��");
    hnwExtQuery.AddField("���ο���");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("PERSONS_NUM"));
            hnwExtQuery.AddData(vo.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));            
            hnwExtQuery.AddData(vo.getString("OT_AMT"));   
            
            hnwExtQuery.AddData(vo.getString("WEL_AMT"));
            hnwExtQuery.AddData(vo.getString("OSE_AMT"));
            hnwExtQuery.AddData(vo.getString("RUN_AMT"));    
            hnwExtQuery.AddData(vo.getString("MH_AMT"));                
            hnwExtQuery.AddData(vo.getString("LSEV_AMT"));
            hnwExtQuery.AddData(vo.getString("TB3_AMT"));
            hnwExtQuery.AddData(vo.getString("SGF_AMT"));            
            hnwExtQuery.AddData(vo.getString("OTH_AMT"));
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));            
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));


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

        hnwExtQuery.SendData(response);
    }

%>