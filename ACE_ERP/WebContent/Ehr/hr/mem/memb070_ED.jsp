<!--
***********************************************************************
* @source      : memb010_ED.jsp
* @description : �İ߻�� ������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/12      ���м�        �����ۼ�.        
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
    String str_ymd = request.getParameter("str_ymd");
    String end_ymd = request.getParameter("end_ymd");
    String gubun   = request.getParameter("gubun");
    
    String str_m = str_ymd.substring(5,7);
    String str_d = str_ymd.substring(8,10);
    
    String end_m = end_ymd.substring(5,7);
    String end_d = end_ymd.substring(8,10);

    String md_val = "(" + str_m + "." + str_d + " ~ " + end_m + "." + end_d + ")";
    String where_sql = "";
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB070_SHR");
    
    if ( gubun.equals("1") ) {
        where_sql = " WHERE HIR_YMD >= TO_DATE('" + str_ymd + "','YYYY-MM-DD') AND HIR_YMD <= TO_DATE('" + end_ymd + "','YYYY-MM-DD')";
        where_sql += " OR RHI_YMD >= TO_DATE('" + str_ymd + "','YYYY-MM-DD') AND HIR_YMD <= TO_DATE('" + end_ymd + "','YYYY-MM-DD')";
    } else {
        where_sql = "WHERE RET_YMD >= TO_DATE('" + str_ymd + "','YYYY-MM-DD') AND RET_YMD <= TO_DATE('" + end_ymd + "','YYYY-MM-DD')";
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        where_sql
    };
    
    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�б�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("�İ߾�ü");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("ä�����");
    hnwExtQuery.AddField("�Ⱓ");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(i+1);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_TAG"));
            hnwExtQuery.AddData(vo.getString("AGE"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
            hnwExtQuery.AddData(vo.getString("RHI_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(vo.getString("HIR_TAG"));
            hnwExtQuery.AddData(md_val);

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
          
            hnwExtQuery.SendData(response);
    }

%>