<!--
***********************************************************************
* @Source         : educ030_ED.jsp                                       *
* @Description    : ���Ǳ����̷�-�⵵��Ȯ������ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/19      ���м�        �����ۼ�.
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

    String eno_no = request.getParameter("eno_no");
	String STR_YMD = request.getParameter("STR_YMD");
	String END_YMD = request.getParameter("END_YMD");


    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUC030_SHR");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    StringBuffer sb = new StringBuffer();


    if(!STR_YMD.equals(""))
        sb.append("AND F.EDU_YY >= '"+STR_YMD+"'");
    if(!END_YMD.equals(""))
        sb.append("AND F.EDU_YY <= '"+END_YMD+"'");

    Object[] sqlParam = new Object[] {
    		sb.toString()
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        eno_no

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("�⵵");
    hnwExtQuery.AddField("��ǥ����");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("���̼�����");
    hnwExtQuery.AddField("�������(�ʼ�)");
    hnwExtQuery.AddField("�������(����)");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("��������");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("EDU_YY"));
            hnwExtQuery.AddData(vo.getString("JOB_POINT"));
            hnwExtQuery.AddData(vo.getString("APP_POINT"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_TOT"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AA"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_AB"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_LCT"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT_EXP"));

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