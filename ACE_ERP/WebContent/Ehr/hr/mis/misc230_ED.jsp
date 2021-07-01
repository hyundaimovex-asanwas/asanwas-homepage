<!--
***********************************************************************
* @source      : misc230_ED.jsp
* @description : 사업계획(인원) 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/27      이승욱        최초작성.
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

    sql = XmlSqlUtils.getSQL("mis", "MISC230_SHR_PRINT2");

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
    hnwExtQuery.AddField("JOB_CD");
    hnwExtQuery.AddField("JOB_NM");
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
    hnwExtQuery.AddField("SJ_HCNT");
    hnwExtQuery.AddField("SJ_PCNT");
    hnwExtQuery.AddField("JM_HCNT");
    hnwExtQuery.AddField("JM_PCNT");
    hnwExtQuery.AddField("SM_HCNT");
    hnwExtQuery.AddField("SM_PCNT");
    hnwExtQuery.AddField("SB_HCNT");
    hnwExtQuery.AddField("SB_PCNT");
    hnwExtQuery.AddField("BJ_HCNT");
    hnwExtQuery.AddField("BJ_PCNT");
    hnwExtQuery.AddField("BD_HCNT");
    hnwExtQuery.AddField("BD_PCNT");
    hnwExtQuery.AddField("CJ_HCNT");
    hnwExtQuery.AddField("CJ_PCNT");
    hnwExtQuery.AddField("GJ_HCNT");
    hnwExtQuery.AddField("GJ_PCNT");
    hnwExtQuery.AddField("DR_HCNT");
    hnwExtQuery.AddField("DR_PCNT");
    hnwExtQuery.AddField("S4M_HCNT");
    hnwExtQuery.AddField("S4M_PCNT");
    hnwExtQuery.AddField("S4F_HCNT");
    hnwExtQuery.AddField("S4F_PCNT");
    hnwExtQuery.AddField("S5M_HCNT");
    hnwExtQuery.AddField("S5M_PCNT");
    hnwExtQuery.AddField("S5F_HCNT");
    hnwExtQuery.AddField("S5F_PCNT");
    hnwExtQuery.AddField("JJ_HCNT");
    hnwExtQuery.AddField("JJ_PCNT");
    hnwExtQuery.AddField("GG_HCNT");
    hnwExtQuery.AddField("GG_PCNT");    
    hnwExtQuery.AddField("SA_HSOCNT");
    hnwExtQuery.AddField("SA_PSOCNT");
    hnwExtQuery.AddField("JK_HCNT");
    hnwExtQuery.AddField("JK_PCNT");
    hnwExtQuery.AddField("VJ_HCNT");
    hnwExtQuery.AddField("VJ_PCNT");
    hnwExtQuery.AddField("JI_HCNT");
    hnwExtQuery.AddField("JI_PCNT");
    hnwExtQuery.AddField("YU_HCNT");
    hnwExtQuery.AddField("YU_PCNT");
    hnwExtQuery.AddField("GY_HCNT");
    hnwExtQuery.AddField("GY_PCNT");
    hnwExtQuery.AddField("TT_HCNT");
    hnwExtQuery.AddField("TT_PCNT");
    hnwExtQuery.AddField("PG_HCNT");
    hnwExtQuery.AddField("PG_PCNT");
    hnwExtQuery.AddField("P_CNT");
    hnwExtQuery.AddField("H_CNT");    
    hnwExtQuery.AddField("YEAR_PCNT");
    hnwExtQuery.AddField("YEAR_HCNT");
    hnwExtQuery.AddField("TOT_PCNT");
    hnwExtQuery.AddField("TOT_HCNT");
    hnwExtQuery.AddField("INC_PCNT");
    hnwExtQuery.AddField("INC_HCNT");
    

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
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
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
            hnwExtQuery.AddData(vo.getString("SJ_HCNT"));
            hnwExtQuery.AddData(vo.getString("SJ_PCNT"));
            hnwExtQuery.AddData(vo.getString("JM_HCNT"));
            hnwExtQuery.AddData(vo.getString("JM_PCNT"));
            hnwExtQuery.AddData(vo.getString("SM_HCNT"));
            hnwExtQuery.AddData(vo.getString("SM_PCNT"));
            hnwExtQuery.AddData(vo.getString("SB_HCNT"));
            hnwExtQuery.AddData(vo.getString("SB_PCNT"));
            hnwExtQuery.AddData(vo.getString("BJ_HCNT"));
            hnwExtQuery.AddData(vo.getString("BJ_PCNT"));
            hnwExtQuery.AddData(vo.getString("BD_HCNT"));
            hnwExtQuery.AddData(vo.getString("BD_PCNT"));
            hnwExtQuery.AddData(vo.getString("CJ_HCNT"));
            hnwExtQuery.AddData(vo.getString("CJ_PCNT"));
            hnwExtQuery.AddData(vo.getString("GJ_HCNT"));
            hnwExtQuery.AddData(vo.getString("GJ_PCNT"));
            hnwExtQuery.AddData(vo.getString("DR_HCNT"));
            hnwExtQuery.AddData(vo.getString("DR_PCNT"));
            hnwExtQuery.AddData(vo.getString("S4M_HCNT"));
            hnwExtQuery.AddData(vo.getString("S4M_PCNT"));
            hnwExtQuery.AddData(vo.getString("S4F_HCNT"));
            hnwExtQuery.AddData(vo.getString("S4F_PCNT"));
            hnwExtQuery.AddData(vo.getString("S5M_HCNT"));
            hnwExtQuery.AddData(vo.getString("S5M_PCNT"));
            hnwExtQuery.AddData(vo.getString("S5F_HCNT"));
            hnwExtQuery.AddData(vo.getString("S5F_PCNT"));
            hnwExtQuery.AddData(vo.getString("JJ_HCNT"));
            hnwExtQuery.AddData(vo.getString("JJ_PCNT"));
            hnwExtQuery.AddData(vo.getString("GG_HCNT"));
            hnwExtQuery.AddData(vo.getString("GG_PCNT"));    
            hnwExtQuery.AddData(vo.getString("SA_HSOCNT"));
            hnwExtQuery.AddData(vo.getString("SA_PSOCNT"));
            hnwExtQuery.AddData(vo.getString("JK_HCNT"));
            hnwExtQuery.AddData(vo.getString("JK_PCNT"));
            hnwExtQuery.AddData(vo.getString("VJ_HCNT"));
            hnwExtQuery.AddData(vo.getString("VJ_PCNT"));
            hnwExtQuery.AddData(vo.getString("JI_HCNT"));
            hnwExtQuery.AddData(vo.getString("JI_PCNT"));
            hnwExtQuery.AddData(vo.getString("YU_HCNT"));
            hnwExtQuery.AddData(vo.getString("YU_PCNT"));
            hnwExtQuery.AddData(vo.getString("GY_HCNT"));
            hnwExtQuery.AddData(vo.getString("GY_PCNT"));
            hnwExtQuery.AddData(vo.getString("TT_HCNT"));
            hnwExtQuery.AddData(vo.getString("TT_PCNT"));
            hnwExtQuery.AddData(vo.getString("PG_HCNT"));
            hnwExtQuery.AddData(vo.getString("PG_PCNT"));
            hnwExtQuery.AddData(vo.getString("P_CNT"));
            hnwExtQuery.AddData(vo.getString("H_CNT"));    
            hnwExtQuery.AddData(vo.getString("YEAR_PCNT"));
            hnwExtQuery.AddData(vo.getString("YEAR_HCNT"));
            hnwExtQuery.AddData(vo.getString("TOT_PCNT"));
            hnwExtQuery.AddData(vo.getString("TOT_HCNT"));
            hnwExtQuery.AddData(vo.getString("INC_PCNT"));
            hnwExtQuery.AddData(vo.getString("INC_HCNT"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
