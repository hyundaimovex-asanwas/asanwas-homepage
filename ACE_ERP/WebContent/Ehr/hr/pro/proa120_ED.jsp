<!--
***********************************************************************
* @source      : proa120_PV.jsp									      *
* @description : ����� ��������� ��� PAGE	 			          *
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/20      ���м�        �����ۼ�.
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
    String rec_ymd = request.getParameter("rec_ymd");

    String rec_ymd_val = rec_ymd.substring(0,4) + "0101";
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("pro", "PROA120_SHR");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {

    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd_val, rec_ymd

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("���μ� �߷���");
    hnwExtQuery.AddField("���μ� �Ⱓ");
    hnwExtQuery.AddField("�б�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�����⵵");
    hnwExtQuery.AddField("4��������");
    hnwExtQuery.AddField("4��������-��");
    hnwExtQuery.AddField("4��������-��");
    hnwExtQuery.AddField("3��������");
    hnwExtQuery.AddField("3��������-��");
    hnwExtQuery.AddField("3��������-��");
    hnwExtQuery.AddField("2��������");
    hnwExtQuery.AddField("2��������-��");
    hnwExtQuery.AddField("2��������-��");
    hnwExtQuery.AddField("1��������");
    hnwExtQuery.AddField("1��������-��");
    hnwExtQuery.AddField("1��������-��");
    hnwExtQuery.AddField("���� �� ¡��");
    hnwExtQuery.AddField("�������");

    hnwExtQuery.SendField(response);

    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("H_DPT_YMD"));
            hnwExtQuery.AddData(vo.getString("H_YMD_VAL"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM2"));
            hnwExtQuery.AddData(vo.getString("GUR_YMD"));
            hnwExtQuery.AddData(vo.getString("GOG_Y41"));
            hnwExtQuery.AddData(vo.getString("GOG_Y42"));
            hnwExtQuery.AddData(vo.getString("GOG_Y43"));
            hnwExtQuery.AddData(vo.getString("GOG_Y31"));
            hnwExtQuery.AddData(vo.getString("GOG_Y32"));
            hnwExtQuery.AddData(vo.getString("GOG_Y33"));
            hnwExtQuery.AddData(vo.getString("GOG_Y21"));
            hnwExtQuery.AddData(vo.getString("GOG_Y22"));
            hnwExtQuery.AddData(vo.getString("GOG_Y23"));
            hnwExtQuery.AddData(vo.getString("GOG_Y11"));
            hnwExtQuery.AddData(vo.getString("GOG_Y12"));
            hnwExtQuery.AddData(vo.getString("GOG_Y13"));
            hnwExtQuery.AddData(vo.getString("SAN_RM"));
            hnwExtQuery.AddData(vo.getString("EST_CD"));

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

        hnwExtQuery.SendData(response);
    }

%>