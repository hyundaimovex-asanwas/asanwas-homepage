<!--
***********************************************************************
* @source      : ymaa030.jsp
* @description : �����������޳��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/27      ���м�        �����ۼ�.
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
    String PIS_YYMM_SHR  = request.getParameter("PIS_YYMM_SHR");
    String OCC_CD_SHR    = request.getParameter("OCC_CD_SHR");
    String SORT_SHR      = request.getParameter("SORT_SHR");

    String sql = "";

    if ( SORT_SHR.equals("1") ) {
        /** �ܺ� XML���� SQL�� �о� �´� **/
        sql = XmlSqlUtils.getSQL("yma", "YMAA040_SHR");
    } else {
        sql = XmlSqlUtils.getSQL("yma", "YMAA040_SHR_01");
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
            OCC_CD_SHR,
            PIS_YYMM_SHR.replaceAll("-", "").substring(0,4),
            PIS_YYMM_SHR.replaceAll("-", "").substring(4,6),
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����");
    if ( OCC_CD_SHR.equals("1") ) {
        /** �ܺ� XML���� SQL�� �о� �´� **/
    	hnwExtQuery.AddField("�Ҽ�");
    } else {
    	hnwExtQuery.AddField("����");
    }

    hnwExtQuery.AddField("�ο�");
    hnwExtQuery.AddField("����ӱ�");
    hnwExtQuery.AddField("���޾�");
    hnwExtQuery.AddField("���");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//            hnwExtQuery.AddData(i);
            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_CNT"));
            hnwExtQuery.AddData(vo.getString("MNOR_WAG"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
            hnwExtQuery.AddData(vo.getString("REMARK"));

            hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
    }

%>