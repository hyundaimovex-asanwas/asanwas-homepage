<!--
***********************************************************************
* @Source         : educ030_ED2.jsp                                       *
* @Description    : ���Ǳ����̷�-�⵵�������̷�(�系�����̷�,��ܱ����̷�) PAGE
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

    String eno_no   = request.getParameter("eno_no");
    String str_ymd  = request.getParameter("str_ymd");
    String edu_flag = request.getParameter("edu_flag");
    String edu_val  = "";
    if ( edu_flag.equals("1") ) {
        edu_val = "'1'";
    } else if ( edu_flag.equals("2") ) {
        edu_val = "'2','3'";
    }
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_02");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        edu_val
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        eno_no, str_ymd,edu_flag
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ð�");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("�������");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("EDU_NM"));
            hnwExtQuery.AddData(vo.getString("SEQ_NO"));
            hnwExtQuery.AddData(vo.getString("LCT_TIME"));
            hnwExtQuery.AddData(vo.getString("EDU_YMD"));
            hnwExtQuery.AddData(vo.getString("SHAPE_NM"));
            hnwExtQuery.AddData(vo.getString("EDU_TAG"));
            hnwExtQuery.AddData(vo.getString("CPT_PNT"));
            hnwExtQuery.AddData(vo.getString("INT_NAM"));
            hnwExtQuery.AddData(vo.getString("PLACE_NM"));

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

        hnwExtQuery.SendData(response);
    }

%>