<!--
***********************************************************************
* @source        : bona040_PV.jsp 				                                                                                     *
* @description   : �����޻�������Ȳ PAGE.    
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/01      ���м�        �����ۼ�.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="oracle.jdbc.driver.OracleTypes"%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>
<%@page import ="com.gauce.GauceDataSet"%>

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
    String SORT_SHR     = request.getParameter("SORT_SHR");

    String sql = "";
    String p_sql = "";

        if ( SORT_SHR.equals("1") ) {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR");
        } else if ( SORT_SHR.equals("2") ) {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR_01");
        } else if ( SORT_SHR.equals("3") ) {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR_02");
        } else {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR_03");
        }

        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {
        };

        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
                OCC_CD_SHR,
                STR_YYMM_SHR.replaceAll("-", ""),
                END_YYMM_SHR.replaceAll("-", ""),
        };

        AbstractDAO aaa= new AbstractDAO("default");
        DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

        extquery hnwExtQuery = new extquery();

        hnwExtQuery.AddField("����");
        hnwExtQuery.AddField("����");
        hnwExtQuery.AddField("�ο�");
        hnwExtQuery.AddField("�޿�");
        hnwExtQuery.AddField("���ο���");
        hnwExtQuery.AddField("��Ÿ");
        hnwExtQuery.AddField("��");
        hnwExtQuery.AddField("�ݾ�");
        hnwExtQuery.AddField("������");

        hnwExtQuery.SendField(response);

    //    System.out.println("voList.size()="+voList.size());
        int i = 0;

        if (voList.size() > 0) 
        {
            for ( i=0; i<voList.size(); i++ ) 
            {
                DynamicValueObject vo = (DynamicValueObject)voList.get(i);

                hnwExtQuery.AddData(vo.getString("PIS_YYMM"));
                hnwExtQuery.AddData(vo.getString("COMM_NM"));
                hnwExtQuery.AddData(vo.getString("ENO_CNT"));
                hnwExtQuery.AddData(vo.getString("PAY_AMT"));
                hnwExtQuery.AddData(vo.getString("PPEN_AMT"));
                hnwExtQuery.AddData(vo.getString("OTH_AMT"));
                hnwExtQuery.AddData(vo.getString("SUM_AMT"));
                hnwExtQuery.AddData(vo.getString("BON_AMT"));
                hnwExtQuery.AddData(vo.getString("PAY_PCT"));

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

            hnwExtQuery.SendData(response);
        }



%>