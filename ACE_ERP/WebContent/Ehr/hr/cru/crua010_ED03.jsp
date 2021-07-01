<!--
*************************************************************************
* @source           : crua010 ED03.jsp
* @description      : �Ի������� ��»��� ��ȸ
*************************************************************************
* DATE                 AUTHOR                DESCRIPTION
*------------------------------------------------------------------------
* 2008/09/08           �����                �����ۼ�.
*************************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.core.exception.CException"%>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import="com.shift.gef.gauce.utility.TrBox"%>
<%@page import="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String REG_NO     = request.getParameter("REG_NO");
    String GBN_TAG    = request.getParameter("GBN_TAG");
    String STR_YMD    = request.getParameter("STR_END_YMD");
    String MONTHS     = request.getParameter("MONTHS");
    String CMP_NAM    = request.getParameter("CMP_NAM");
    String CHG_JOB = request.getParameter("CHG_JOB");
    String JOB_CD  = request.getParameter("JOB_CD");
    String RET_REASON    = request.getParameter("RET_REASON");
    String CAREER_RECORD = request.getParameter("CAREER_RECORD");
    String EDU_TITLE  = request.getParameter("EDU_TITLE");

    String sql = null;
    sql = XmlSqlUtils.getSQL("cru", "CRUA010_PRO3");


    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

    Object[] bind = new Object[] {
    		REG_NO
    };


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("REG_NO");
    hnwExtQuery.AddField("GBN_TAG");
    hnwExtQuery.AddField("STR_END_YMD");
    hnwExtQuery.AddField("MONTHS");
    hnwExtQuery.AddField("CMP_NAM");
    hnwExtQuery.AddField("CHG_JOB");
    hnwExtQuery.AddField("JOB_CD");
    hnwExtQuery.AddField("RET_REASON");
    hnwExtQuery.AddField("CAREER_RECORD");
    hnwExtQuery.AddField("EDU_TITLE");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REG_NO"));
            hnwExtQuery.AddData(vo.getString("GBN_TAG"));
            hnwExtQuery.AddData(vo.getString("STR_END_YMD"));
            hnwExtQuery.AddData(vo.getString("MONTHS"));
            hnwExtQuery.AddData(vo.getString("CMP_NAM"));
            hnwExtQuery.AddData(vo.getString("CHG_JOB"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("RET_REASON"));
            hnwExtQuery.AddData(vo.getString("CAREER_RECORD"));
            hnwExtQuery.AddData(vo.getString("EDU_TITLE"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);
%>
