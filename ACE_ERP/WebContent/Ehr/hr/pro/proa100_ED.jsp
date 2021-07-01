<!--
***********************************************************************
* @source      : proa100_ED.jsp
* @description : ������� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/01      ���м�        �����ۼ�.        
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

    String rec_y       = request.getParameter("REC_YMD_SHR");	
	String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");
    String title_val   = request.getParameter("title_val");
    
    String rec_ymd = rec_y + "0101";
    String rec_ym  = rec_y + "12";
    int rec_y_str  = Integer.parseInt(rec_y)-5;
    String rec_y_str2 = Integer.toString(rec_y_str);

    String col_val1   = "";
    String col_val2   = "";
    String gbn_cd_val = "";

    if ( GBN_CD_SHR.equals("1") ) {
        gbn_cd_val = "";
    } else {
        gbn_cd_val = "AND    EST_CD = 'Y'";
    }
    int i = 0;
    int k = 0;
//--------------------------------���а� ��ȸ--------------------------------------------------------
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql1 = XmlSqlUtils.getSQL("pro", "PROA100_SHR_01");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam1 = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql1 = SqlUtils.replaceQuery(sql1, sqlParam1);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind1 = new Object[] {
            rec_y,
            rec_y
    };

    AbstractDAO aaa1= new AbstractDAO("default");
    DynamicValueObject voList1 = aaa1.selectProcessDvo(sql1, bind1);
    String[] gubun  = new String[voList1.size()];
    for ( i=0; i<voList1.size(); i++ ) 
    {
        DynamicValueObject vo1 = (DynamicValueObject)voList1.get(i);
        gubun[i] = vo1.getString("COMM_NM");
        col_val1 += "                      ,SUM(AA.PMT_CNT_"+(i+1)+")                            PMT_CNT_"+(i+1)+"                      \n";
        col_val1 += "                      ,SUM(AA.PRO_CNT_"+(i+1)+")                            PMT_CNT_"+(i+1)+"                      \n";
        col_val1 += "                      ,ROUND(SUM(AA.PRO_CNT_"+(i+1)+")/SUM(AA.PMT_CNT_"+(i+1)+")*100, 1)       PRO_RAT_"+(i+1)+"   \n";
        col_val2 += "                             , MAX(DECODE(HEAD_SORT,'"+(i+1)+"',PMT_CNT))   PMT_CNT_"+(i+1)+"                      \n";
        col_val2 += "                             , MAX(DECODE(HEAD_SORT,'"+(i+1)+"',PRO_CNT))   PRO_CNT_"+(i+1)+"                      \n";
        col_val2 += "                             , MAX(DECODE(HEAD_SORT,'"+(i+1)+"',PRO_RAT))   PRO_RAT_"+(i+1)+"                      \n";
    }

//-----------------------------------------------------------------------------------------

//--------------------------------���������Ȳ ��ȸ--------------------------------------------------------

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql2 = XmlSqlUtils.getSQL("pro", "PROA100_SHR_02");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam2 = new Object[] {
        col_val1, col_val2, gbn_cd_val
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind2 = new Object[] {
        rec_ymd,
        rec_ymd,
        rec_ym,
        rec_ym,
        rec_y,
        rec_y,
        rec_y,
        rec_y_str2
    };

    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);
//-----------------------------------------------------------------------------------------
    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�ٷα��б��а�");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("������ ���Ĺ�ȣ");
    hnwExtQuery.AddField("����ο�_��");
    hnwExtQuery.AddField("�����ο�_��");
    hnwExtQuery.AddField("������_��");
    for ( i=1; i<=voList1.size(); i++ ) 
    {
        hnwExtQuery.AddField("����ο�_"+i);
        hnwExtQuery.AddField("�����ο�_"+i);
        hnwExtQuery.AddField("������_"+i);
    }
    for ( i=1; i<=voList1.size(); i++ ) 
    {
        hnwExtQuery.AddField("���и�_"+i);
    }
    hnwExtQuery.AddField("����");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList2.size() > 0) 
    {
        for ( i=0; i<voList2.size(); i++ ) 
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);
            hnwExtQuery.AddData(vo2.getString("OCC_CD"));
            hnwExtQuery.AddData(vo2.getString("JOB_NM"));
            hnwExtQuery.AddData(vo2.getString("JOB_NO"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT99"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT99"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT99"));

            hnwExtQuery.AddData(vo2.getString("PMT_CNT_1"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_1"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_1"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_2"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_2"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_2"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_3"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_3"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_3"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_4"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_4"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_4"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_5"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_5"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_5"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_6"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_6"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_6"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_7"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_7"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_7"));

            for ( k=0; k<voList1.size(); k++ ) 
            {
                hnwExtQuery.AddData(gubun[k]);
            }
            hnwExtQuery.AddData(title_val);

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
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        for ( k=0; k<voList1.size(); k++ ) 
        {
            hnwExtQuery.AddData("");
        }
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>