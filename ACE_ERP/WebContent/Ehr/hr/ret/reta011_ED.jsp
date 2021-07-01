<!--
***********************************************************************
* @source      : reta010_ED.jsp
* @description : �������߰������û PAGE  (���� ������ ����  ��ȸ)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/04      ���м�        �����ۼ�.
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
    String ENO_NO = request.getParameter("ENO_NO");
    String rownum = request.getParameter("rownum");

    String DPT_NM   = "";
    String JOB_NM   = "";
    String ENO_CD   = "";
    String ENO_NM   = "";
    String HIRG_YMD = "";
    String CET_NO   = "";
    String ADDR1    = "";
    String ADDR2    = "";

    String BASIC_YMD = "";
    String REASON    = "";
    String BASIC_Y  = "";
    String BASIC_M  = "";
    String BASIC_D  = "";

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA010_SHR_EMP_PRINT");
    System.out.println("rownum="+rownum);
    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        ENO_NO
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    if (voList.size() > 0)
    {
        DynamicValueObject vo = (DynamicValueObject)voList.get(0);

        DPT_NM   = vo.getString("DPT_NM");
        JOB_NM   = vo.getString("JOB_NM");
        ENO_CD   = vo.getString("ENO_NO");
        ENO_NM   = vo.getString("ENO_NM");
        HIRG_YMD = vo.getString("HIRG_YMD");
        CET_NO   = vo.getString("CET_NO");
        ADDR1    = vo.getString("ADDR1");
        ADDR2    = vo.getString("ADDR2");
    }
//-------------------------------------------------------------


    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql2 = XmlSqlUtils.getSQL("ret", "RETA010_SHR");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam2 = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind2 = new Object[] {
        ENO_NO
    };

    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);
    BASIC_YMD = "";
	REASON    = "";
	BASIC_Y  = "";
    BASIC_M  = "";
    BASIC_D  = "";
    System.out.println("rownum="+voList2.size());


    if (voList2.size() > 0)
    {
        //DynamicValueObject vo2 = (DynamicValueObject)voList2.get(Integer.parseInt(rownum));
        DynamicValueObject vo2 = (DynamicValueObject)voList2.get(Integer.parseInt(rownum)-1);
        BASIC_YMD = vo2.getString("BASIC_YMD");
        REASON    = vo2.getString("REASON");
	    BASIC_Y  = BASIC_YMD.substring(0,4);
	    BASIC_M  = BASIC_YMD.substring(5,7);
	    BASIC_D  = BASIC_YMD.substring(8,10);
    }


    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("�ֹε�Ϲ�ȣ");
    hnwExtQuery.AddField("�ֹε��");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�߰���������ϳ�");
    hnwExtQuery.AddField("�߰���������Ͽ�");
    hnwExtQuery.AddField("�߰������������");
    hnwExtQuery.AddField("��û����");

    hnwExtQuery.SendField(response);


    hnwExtQuery.AddData(DPT_NM);
    hnwExtQuery.AddData(JOB_NM);
    hnwExtQuery.AddData(ENO_CD);
    hnwExtQuery.AddData(ENO_NM);
    hnwExtQuery.AddData(HIRG_YMD );
    hnwExtQuery.AddData(CET_NO);
    hnwExtQuery.AddData(ADDR1);
    hnwExtQuery.AddData(ADDR2);
    hnwExtQuery.AddData(BASIC_Y);
    hnwExtQuery.AddData(BASIC_M);
    hnwExtQuery.AddData(BASIC_D);
    hnwExtQuery.AddData(REASON);

    hnwExtQuery.SendData(response);
%>
