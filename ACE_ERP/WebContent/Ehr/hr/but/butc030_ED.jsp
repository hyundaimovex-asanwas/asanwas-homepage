<!--
***********************************************************************
* @source      : butc030_ED.jsp
* @description : �İ߱ٹ� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/02/09      ������        �����ۼ�.        
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
    String str_ymd    = request.getParameter("str_ymd");
    String end_ymd    = request.getParameter("end_ymd");
    String dpt_cd     = request.getParameter("dpt_cd");
    String job_cd     = request.getParameter("job_cd");
    String ymd_val    = request.getParameter("ymd_val");


    String sql = XmlSqlUtils.getSQL("but", "BUTC030_SHR");

    Object[] bind = new Object[] {
        str_ymd, end_ymd, dpt_cd, job_cd
    };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�İߺ�");
    hnwExtQuery.AddField("�İ���");
    hnwExtQuery.AddField("�İ߸���");
    hnwExtQuery.AddField("ǰ�ǹ�ȣ");

    hnwExtQuery.AddField("���Ⱓ");
    hnwExtQuery.SendField(response);

    //    System.out.println("voList.size()="+voList.size());

    if ( voList.size() > 0 ) 
    {
        for ( int i = 0; i < voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("NAM_KOR"));
            hnwExtQuery.AddData(vo.getString("DIS_FR_YMD"));
            hnwExtQuery.AddData(vo.getString("DIS_TO_YMD"));
            hnwExtQuery.AddData(vo.getString("COST_TOT"));
            hnwExtQuery.AddData(vo.getString("DIS_CITY"));
            hnwExtQuery.AddData(vo.getString("DIS_OBJ"));
            hnwExtQuery.AddData(vo.getString("ORD_NO"));

            hnwExtQuery.AddData(ymd_val);
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
           
            hnwExtQuery.SendData(response);
    }
%>