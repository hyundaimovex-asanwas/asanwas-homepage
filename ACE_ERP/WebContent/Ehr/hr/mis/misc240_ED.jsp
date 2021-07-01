<!--
***********************************************************************
* @source      : misc240_ED.jsp
* @description : 인원채용계획 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/30      이승욱        최초작성.
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
    String pln_yy   = request.getParameter("PLN_YY"); 

    String sql = null;

    sql = XmlSqlUtils.getSQL("mis", "MISC240_SHR");

      Object[] bind = null;
      bind = new Object[] {
           pln_yy
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("GBN2_TAG");
    hnwExtQuery.AddField("UPDPT_NM");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("JIKGUN_NM");
    hnwExtQuery.AddField("UPDPT_CD");
    hnwExtQuery.AddField("UPSORT_NO");
    hnwExtQuery.AddField("DPT_CD");
    hnwExtQuery.AddField("SORT_NO");
    hnwExtQuery.AddField("JIKGUN_CD");
    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("EMP_CD");
//    hnwExtQuery.AddField("OENO_NO");
    hnwExtQuery.AddField("JOB_CD");
    hnwExtQuery.AddField("MF_TAG");
    hnwExtQuery.AddField("HIR_CNT");
    hnwExtQuery.AddField("YMC_CNT");
    hnwExtQuery.AddField("LEVY_NM");    
    hnwExtQuery.AddField("TSEQ_NO");    
    hnwExtQuery.AddField("M01_CNT");
    hnwExtQuery.AddField("M02_CNT");
    hnwExtQuery.AddField("M03_CNT");
    hnwExtQuery.AddField("M04_CNT");
    hnwExtQuery.AddField("M05_CNT");
    hnwExtQuery.AddField("M06_CNT");
    hnwExtQuery.AddField("M07_CNT");
    hnwExtQuery.AddField("M08_CNT");
    hnwExtQuery.AddField("M09_CNT");
    hnwExtQuery.AddField("M10_CNT");
    hnwExtQuery.AddField("M11_CNT");
    hnwExtQuery.AddField("M12_CNT");
    hnwExtQuery.AddField("TOT_CNT");
    hnwExtQuery.AddField("STR_YM");
    hnwExtQuery.AddField("TSM_CNT");
    hnwExtQuery.AddField("LEVY_TXT");    

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("GBN2_TAG"));
            hnwExtQuery.AddData(vo.getString("UPDPT_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JIKGUN_NM"));
            hnwExtQuery.AddData(vo.getString("UPDPT_CD"));
            hnwExtQuery.AddData(vo.getString("UPSORT_NO"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));
            hnwExtQuery.AddData(vo.getString("JIKGUN_CD"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("EMP_CD"));
//            hnwExtQuery.AddData(vo.getString("OENO_NO"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("MF_TAG"));
            hnwExtQuery.AddData(vo.getString("HIR_CNT"));
            hnwExtQuery.AddData(vo.getString("YMC_CNT"));
            hnwExtQuery.AddData(vo.getString("LEVY_NM"));
            hnwExtQuery.AddData(vo.getString("TSEQ_NO"));
            hnwExtQuery.AddData(vo.getString("M01_CNT"));
            hnwExtQuery.AddData(vo.getString("M02_CNT"));
            hnwExtQuery.AddData(vo.getString("M03_CNT"));
            hnwExtQuery.AddData(vo.getString("M04_CNT"));
            hnwExtQuery.AddData(vo.getString("M05_CNT"));
            hnwExtQuery.AddData(vo.getString("M06_CNT"));
            hnwExtQuery.AddData(vo.getString("M07_CNT"));
            hnwExtQuery.AddData(vo.getString("M08_CNT"));
            hnwExtQuery.AddData(vo.getString("M09_CNT"));
            hnwExtQuery.AddData(vo.getString("M10_CNT"));
            hnwExtQuery.AddData(vo.getString("M11_CNT"));
            hnwExtQuery.AddData(vo.getString("M12_CNT"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("STR_YM"));
            hnwExtQuery.AddData(vo.getString("TSM_CNT"));
            hnwExtQuery.AddData(vo.getString("LEVY_TXT"));            

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
