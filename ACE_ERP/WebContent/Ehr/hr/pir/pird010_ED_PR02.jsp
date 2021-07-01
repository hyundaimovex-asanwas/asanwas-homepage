<!--
***********************************************************************
* @source      : pird010_ED_PR02.jsp
* @description : 인사기록표-건강검진 조회 PAGE
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

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>
<%
    String occ_cd   = request.getParameter("OCC_CD");
    String prt_selt = request.getParameter("PRT_SELT");
    String no_shr   = request.getParameter("NO_SHR");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (occ_cd.equals("A")){
        sb1.append("'%'");
    } else {
    	sb1.append("'"+occ_cd+"'");
    }
    /** DynamicSQL을 적용하는 부분 [2] **/
    if (no_shr.equals("")){
        sb2.append(" AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("1")){
        sb2.append(" AND ENO_NO = '" + no_shr + "'");
    } else if (prt_selt.equals("2")){
        sb2.append(" AND DPT_CD = '" + no_shr + "' AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("3")){
        sb2.append(" AND JOB_CD = '" + no_shr + "' AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
    }


    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString(),
            sb2.toString()
    };

    /** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("pir", "PIRD010_SHR_PR02");
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    Object[] bind = null;

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("PRO_YM");
    hnwExtQuery.AddField("EYE_SIGHT");
    hnwExtQuery.AddField("HEIGHT");
    hnwExtQuery.AddField("WEIGHT");
    hnwExtQuery.AddField("CBLD_NM");
    hnwExtQuery.AddField("BLD_TYP");
    hnwExtQuery.AddField("PRO_YMD");
    hnwExtQuery.AddField("EXM_HSP");
    hnwExtQuery.AddField("DECISION");
    hnwExtQuery.AddField("BLD_PRE");
    hnwExtQuery.AddField("BLD_DAN");
    hnwExtQuery.AddField("PH");
    hnwExtQuery.AddField("SPEC");
    hnwExtQuery.AddField("Q_RANK");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("PRO_YM"));
            hnwExtQuery.AddData(vo.getString("EYE_SIGHT"));
            hnwExtQuery.AddData(vo.getString("HEIGHT"));
            hnwExtQuery.AddData(vo.getString("WEIGHT"));
            hnwExtQuery.AddData(vo.getString("CBLD_NM"));
            hnwExtQuery.AddData(vo.getString("BLD_TYP"));
            hnwExtQuery.AddData(vo.getString("PRO_YMD"));
            hnwExtQuery.AddData(vo.getString("EXM_HSP"));
            hnwExtQuery.AddData(vo.getString("DECISION"));
            hnwExtQuery.AddData(vo.getString("BLD_PRE"));
            hnwExtQuery.AddData(vo.getString("BLD_DAN"));
            hnwExtQuery.AddData(vo.getString("PH"));
            hnwExtQuery.AddData(vo.getString("SPEC"));
            hnwExtQuery.AddData(vo.getString("Q_RANK"));

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);

%>
