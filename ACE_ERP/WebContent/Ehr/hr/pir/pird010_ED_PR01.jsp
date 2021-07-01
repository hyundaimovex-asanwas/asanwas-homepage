<!--
***********************************************************************
* @source      : pird010_ED_PR01.jsp
* @description : 인사기록표-기본정보 조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/10      이승욱        최초작성.
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

<%@page import ="com.shift.gef.support.vo.* "%>
<%@page import ="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import ="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%
    String occ_cd   = request.getParameter("OCC_CD");
    String prt_selt = request.getParameter("PRT_SELT");
    String no_shr   = request.getParameter("NO_SHR");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();
    StringBuffer sb3 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (occ_cd.equals("A")){
        sb1.append("'%'");
    } else {
    	sb1.append("'"+occ_cd+"'");
    }
    /** DynamicSQL을 적용하는 부분 [2],[3] **/
    if (no_shr.equals("")){
        sb2.append(" AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
        sb3.append(" AND (P.RET_YMD is NULL OR P.RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("1")){
        sb2.append(" AND ENO_NO = '" + no_shr + "'");
        sb3.append(" AND P.ENO_NO = '" + no_shr + "'");
    } else if (prt_selt.equals("2")){
        sb2.append(" AND DPT_CD = '" + no_shr + "' AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
        sb3.append(" AND P.DPT_CD = '" + no_shr + "' AND (P.RET_YMD is NULL OR P.RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("3")){
        sb2.append(" AND JOB_CD = '" + no_shr + "' AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
        sb3.append(" AND P.JOB_CD = '" + no_shr + "' AND (P.RET_YMD is NULL OR P.RET_YMD >= SYSDATE)");
    }


    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString(),
            sb2.toString(),
            sb1.toString(),
            sb3.toString()
    };

    /** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("pir", "PIRD010_SHR_PR01");
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    Object[] bind = null;

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("HIR_NM");
    hnwExtQuery.AddField("OK_MAN");
    hnwExtQuery.AddField("HIR_YMD");
    hnwExtQuery.AddField("HIRG_YMD");
    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("GROUP_NM");
    hnwExtQuery.AddField("JPR_YMD");
    hnwExtQuery.AddField("REG_NM");
    hnwExtQuery.AddField("ENO_NM");
    hnwExtQuery.AddField("BIR_YMD");
    hnwExtQuery.AddField("BIR_TAG");
    hnwExtQuery.AddField("AGE");
    hnwExtQuery.AddField("NAM_CHI");
    hnwExtQuery.AddField("CET_NO");
    hnwExtQuery.AddField("NAM_ENG");
    hnwExtQuery.AddField("MF_TAG");
    hnwExtQuery.AddField("E_MAIL");
    hnwExtQuery.AddField("PER_ADR");
    hnwExtQuery.AddField("HF_NAM");
    hnwExtQuery.AddField("HFRE_NM");
    hnwExtQuery.AddField("RZI_NO");
    hnwExtQuery.AddField("PHN_NO");
    hnwExtQuery.AddField("EM_PHN_NO");
    hnwExtQuery.AddField("RADDR");
    hnwExtQuery.AddField("GUB_NM");
    hnwExtQuery.AddField("ENL_YMD");
    hnwExtQuery.AddField("MIL_YMD");
    hnwExtQuery.AddField("MIL_NO");
    hnwExtQuery.AddField("MIL_NM");
    hnwExtQuery.AddField("GRADE");
    hnwExtQuery.AddField("MBK_NM");
    hnwExtQuery.AddField("HOBBY");
    hnwExtQuery.AddField("SPEC_NM");
    hnwExtQuery.AddField("REL_NM");
    hnwExtQuery.AddField("CLU_NM1");
    hnwExtQuery.AddField("CLU_NM2");
    hnwExtQuery.AddField("CLU_NM3");
    hnwExtQuery.AddField("RET_YMD");
    hnwExtQuery.AddField("RET_GUB");
    hnwExtQuery.AddField("RTR_AMT");
    hnwExtQuery.AddField("LSE_YY");
    hnwExtQuery.AddField("LSE_MM");
    hnwExtQuery.AddField("RET_NM");
    hnwExtQuery.AddField("COC_NAM");
    hnwExtQuery.AddField("PRT_YMD");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("HIR_NM"));
            hnwExtQuery.AddData(vo.getString("OK_MAN"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HIRG_YMD"));
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("GROUP_NM"));
            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
            hnwExtQuery.AddData(vo.getString("REG_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("BIR_TAG"));
            hnwExtQuery.AddData(vo.getString("AGE"));
            hnwExtQuery.AddData(vo.getString("NAM_CHI"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("NAM_ENG"));
            hnwExtQuery.AddData(vo.getString("MF_TAG"));
            hnwExtQuery.AddData(vo.getString("E_MAIL"));
            hnwExtQuery.AddData(vo.getString("PER_ADR"));
            hnwExtQuery.AddData(vo.getString("HF_NAM"));
            hnwExtQuery.AddData(vo.getString("HFRE_NM"));
            hnwExtQuery.AddData(vo.getString("RZI_NO"));
            hnwExtQuery.AddData(vo.getString("PHN_NO"));
            hnwExtQuery.AddData(vo.getString("EM_PHN_NO"));
            hnwExtQuery.AddData(vo.getString("RADDR"));
            hnwExtQuery.AddData(vo.getString("GUB_NM"));
            hnwExtQuery.AddData(vo.getString("ENL_YMD"));
            hnwExtQuery.AddData(vo.getString("MIL_YMD"));
            hnwExtQuery.AddData(vo.getString("MIL_NO"));
            hnwExtQuery.AddData(vo.getString("MIL_NM"));
            hnwExtQuery.AddData(vo.getString("GRADE"));
            hnwExtQuery.AddData(vo.getString("MBK_NM"));
            hnwExtQuery.AddData(vo.getString("HOBBY"));
            hnwExtQuery.AddData(vo.getString("SPEC_NM"));
            hnwExtQuery.AddData(vo.getString("REL_NM"));
            hnwExtQuery.AddData(vo.getString("CLU_NM1"));
            hnwExtQuery.AddData(vo.getString("CLU_NM2"));
            hnwExtQuery.AddData(vo.getString("CLU_NM3"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_GUB"));
            hnwExtQuery.AddData(vo.getString("RTR_AMT"));
            hnwExtQuery.AddData(vo.getString("LSE_YY"));
            hnwExtQuery.AddData(vo.getString("LSE_MM"));
            hnwExtQuery.AddData(vo.getString("RET_NM"));
            hnwExtQuery.AddData(vo.getString("COC_NAM"));
            hnwExtQuery.AddData(vo.getString("PRT_YMD"));

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);


%>
