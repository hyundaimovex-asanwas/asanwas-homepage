<!--
***********************************************************************
* @source      : pird020_ED_PR01.jsp
* @description : 인사기록표-파견사원 기본정보 조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/15      이승욱        최초작성.
***********************************************************************
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
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%
    String occ_cd   = request.getParameter("OCC_CD");
    String prt_selt = request.getParameter("PRT_SELT");
    String no_shr   = request.getParameter("NO_SHR");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (occ_cd.equals("A")){
        sb1.append("'A'");
    } else if (occ_cd.equals("M")){
        sb1.append("'M'");
    } else if (occ_cd.equals("AM")){
        sb1.append("'A','M'");
    }
    /** DynamicSQL을 적용하는 부분 [2],[3] **/
    if (no_shr.equals("")){
        sb2.append(" AND (P.RET_YMD is NULL OR P.RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("1")){
        sb2.append(" AND P.ENO_NO = '" + no_shr + "'");
    } else if (prt_selt.equals("2")){
        sb2.append(" AND P.DPT_CD = '" + no_shr + "' AND (P.RET_YMD is NULL OR P.RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("3")){
        sb2.append(" AND P.JOB_CD = '" + no_shr + "' AND (P.RET_YMD is NULL OR P.RET_YMD >= SYSDATE)");
    }


    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString(),
            sb2.toString(),
    };

    /** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("pir", "PIRD020_SHR_PR01");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
    Object[] bind = null;

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("HIR_NM");
    hnwExtQuery.AddField("HIR_TAG");
    hnwExtQuery.AddField("HIR_TNM");
    hnwExtQuery.AddField("OK_MAN");
    hnwExtQuery.AddField("HIR_YMD");
    hnwExtQuery.AddField("TERM1_YMD");
    hnwExtQuery.AddField("TERM2_YMD");
    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("DISCOMP_NM");
    hnwExtQuery.AddField("ENO_NM");
    hnwExtQuery.AddField("NAM_CHI");
    hnwExtQuery.AddField("NAM_ENG");
    hnwExtQuery.AddField("E_MAIL");
    hnwExtQuery.AddField("DISJOB_CD");
    hnwExtQuery.AddField("JOB_TAG");
    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("REG_NM");
    hnwExtQuery.AddField("BIR_YMD");
    hnwExtQuery.AddField("BIR_TAG");
    hnwExtQuery.AddField("CET_NO");
    hnwExtQuery.AddField("MF_TAG");
    hnwExtQuery.AddField("PER_ADR");
    hnwExtQuery.AddField("HF_NAM");
    hnwExtQuery.AddField("HFRE_NM");
    hnwExtQuery.AddField("ZIP_NO");
    hnwExtQuery.AddField("PHN_NO");
    hnwExtQuery.AddField("EM_PHN_NO");
    hnwExtQuery.AddField("ADDRESS");
    hnwExtQuery.AddField("PRO_YM");
    hnwExtQuery.AddField("EYE_SIGHT");
    hnwExtQuery.AddField("HEIGHT");
    hnwExtQuery.AddField("WEIGHT");
    hnwExtQuery.AddField("CBLD_NM");
    hnwExtQuery.AddField("BLD_TYP");
    hnwExtQuery.AddField("GUB_NM");
    hnwExtQuery.AddField("MIL_NM");
    hnwExtQuery.AddField("ENL_YMD");
    hnwExtQuery.AddField("MIL_YMD");
    hnwExtQuery.AddField("GRADE_NM");
    hnwExtQuery.AddField("MIL_NO");
    hnwExtQuery.AddField("MBK_NM");
    hnwExtQuery.AddField("HOBBY");
    hnwExtQuery.AddField("SPEC_NM");
    hnwExtQuery.AddField("REL_NM");
    hnwExtQuery.AddField("CLU_NM1");
    hnwExtQuery.AddField("CLU_NM2");
    hnwExtQuery.AddField("CLU_NM3");
    hnwExtQuery.AddField("RET_YMD");
    hnwExtQuery.AddField("RET_NM");
    hnwExtQuery.AddField("LSE_YY");
    hnwExtQuery.AddField("LSE_MM");
    hnwExtQuery.AddField("COC_NAM");
    hnwExtQuery.AddField("SYENO_NM");
    hnwExtQuery.AddField("SY_REG_NM");
    hnwExtQuery.AddField("PRT_YMD");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("HIR_NM"));
            hnwExtQuery.AddData(vo.getString("HIR_TAG"));
            hnwExtQuery.AddData(vo.getString("HIR_TNM"));
            hnwExtQuery.AddData(vo.getString("OK_MAN"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("TERM1_YMD"));
            hnwExtQuery.AddData(vo.getString("TERM2_YMD"));
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("DISCOMP_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("NAM_CHI"));
            hnwExtQuery.AddData(vo.getString("NAM_ENG"));
            hnwExtQuery.AddData(vo.getString("E_MAIL"));
            hnwExtQuery.AddData(vo.getString("DISJOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_TAG"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("REG_NM"));
            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("BIR_TAG"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("MF_TAG"));
            hnwExtQuery.AddData(vo.getString("PER_ADR"));
            hnwExtQuery.AddData(vo.getString("HF_NAM"));
            hnwExtQuery.AddData(vo.getString("HFRE_NM"));
            hnwExtQuery.AddData(vo.getString("ZIP_NO"));
            hnwExtQuery.AddData(vo.getString("PHN_NO"));
            hnwExtQuery.AddData(vo.getString("EM_PHN_NO"));
            hnwExtQuery.AddData(vo.getString("ADDRESS"));
            hnwExtQuery.AddData(vo.getString("PRO_YM"));
            hnwExtQuery.AddData(vo.getString("EYE_SIGHT"));
            hnwExtQuery.AddData(vo.getString("HEIGHT"));
            hnwExtQuery.AddData(vo.getString("WEIGHT"));
            hnwExtQuery.AddData(vo.getString("CBLD_NM"));
            hnwExtQuery.AddData(vo.getString("BLD_TYP"));
            hnwExtQuery.AddData(vo.getString("GUB_NM"));
            hnwExtQuery.AddData(vo.getString("MIL_NM"));
            hnwExtQuery.AddData(vo.getString("ENL_YMD"));
            hnwExtQuery.AddData(vo.getString("MIL_YMD"));
            hnwExtQuery.AddData(vo.getString("GRADE_NM"));
            hnwExtQuery.AddData(vo.getString("MIL_NO"));
            hnwExtQuery.AddData(vo.getString("MBK_NM"));
            hnwExtQuery.AddData(vo.getString("HOBBY"));
            hnwExtQuery.AddData(vo.getString("SPEC_NM"));
            hnwExtQuery.AddData(vo.getString("REL_NM"));
            hnwExtQuery.AddData(vo.getString("CLU_NM1"));
            hnwExtQuery.AddData(vo.getString("CLU_NM2"));
            hnwExtQuery.AddData(vo.getString("CLU_NM3"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_NM"));
            hnwExtQuery.AddData(vo.getString("LSE_YY"));
            hnwExtQuery.AddData(vo.getString("LSE_MM"));
            hnwExtQuery.AddData(vo.getString("COC_NAM"));
            hnwExtQuery.AddData(vo.getString("SYENO_NM"));
            hnwExtQuery.AddData(vo.getString("SY_REG_NM"));
            hnwExtQuery.AddData(vo.getString("PRT_YMD"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);


%>                           
