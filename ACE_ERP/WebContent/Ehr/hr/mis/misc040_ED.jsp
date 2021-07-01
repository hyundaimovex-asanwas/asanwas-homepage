<!--
***********************************************************************
* @source      : misc040_ED.jsp
* @description : 인원충원계획현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/01      이승욱        최초작성.
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
    String pis_yy   = request.getParameter("PIS_YY");
    String dpt_cd   = request.getParameter("DPT_CD");
    String hirs_ym  = request.getParameter("HIRS_YM");
    String hire_ym  = request.getParameter("HIRE_YM");
    String job_cd   = request.getParameter("JOB_CD");

    String sql = null;

    sql = XmlSqlUtils.getSQL("mis", "MISC040_SHR_02");
    
    Object[] bind = null;
      bind = new Object[] {
                   pis_yy,
                   dpt_cd,
                   hirs_ym,
                   hire_ym,
                   job_cd
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("PIS_YY");
    hnwExtQuery.AddField("DPT_CD");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("TENO_NO");
    hnwExtQuery.AddField("TENO_NM");
    hnwExtQuery.AddField("TOCC_NM");
    hnwExtQuery.AddField("TJOB_NM");
    hnwExtQuery.AddField("JOB_CD");
    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("JOB_GBN");
    hnwExtQuery.AddField("HIR_YM");
    hnwExtQuery.AddField("HEAD_CD");
    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("LEVY_CD");
    hnwExtQuery.AddField("LEVY_NM");
    hnwExtQuery.AddField("JIKMU_CD");
    hnwExtQuery.AddField("JIKMU_NM");
    hnwExtQuery.AddField("OCC_CD");
    hnwExtQuery.AddField("OCC_NM");
    hnwExtQuery.AddField("MF_TAG");
    hnwExtQuery.AddField("MF_TNM");
    hnwExtQuery.AddField("LEVY_TXT");
    hnwExtQuery.AddField("REMARK");
    hnwExtQuery.AddField("OENO_NO");
    hnwExtQuery.AddField("OENO_NM");
    hnwExtQuery.AddField("NDPT_CD");
    hnwExtQuery.AddField("NDPT_NM");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("PIS_YY"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("TENO_NO"));
            hnwExtQuery.AddData(vo.getString("TENO_NM"));
            hnwExtQuery.AddData(vo.getString("TOCC_NM"));
            hnwExtQuery.AddData(vo.getString("TJOB_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_GBN"));
            hnwExtQuery.AddData(vo.getString("HIR_YM"));
            hnwExtQuery.AddData(vo.getString("HEAD_CD"));
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("LEVY_CD"));
            hnwExtQuery.AddData(vo.getString("LEVY_NM"));
            hnwExtQuery.AddData(vo.getString("JIKMU_CD"));
            hnwExtQuery.AddData(vo.getString("JIKMU_NM"));
            hnwExtQuery.AddData(vo.getString("OCC_CD"));
            hnwExtQuery.AddData(vo.getString("OCC_NM"));
            hnwExtQuery.AddData(vo.getString("MF_TAG"));
            hnwExtQuery.AddData(vo.getString("MF_TNM"));
            hnwExtQuery.AddData(vo.getString("LEVY_TXT"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(vo.getString("OENO_NO"));
            hnwExtQuery.AddData(vo.getString("OENO_NM"));
            hnwExtQuery.AddData(vo.getString("NDPT_CD"));
            hnwExtQuery.AddData(vo.getString("NDPT_NM"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
