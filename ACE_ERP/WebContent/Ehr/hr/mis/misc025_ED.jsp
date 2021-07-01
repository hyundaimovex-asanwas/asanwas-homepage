<!--
***********************************************************************
* @source      : misc025_ED.jsp
* @description : 부서별 인원 충원계획 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/23      이승욱        최초작성.
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
    String str_yy   = request.getParameter("STR_YY");
    String dpt_cd   = request.getParameter("DPT_CD");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (!dpt_cd.equals("")){
        sb1.append(" AND P.DPT_CD = '"  + dpt_cd + "'");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString()
    };

    sql = XmlSqlUtils.getSQL("mis", "MISC025_SHR");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
    Object[] bind = null;
      bind = new Object[] {
           str_yy, str_yy, str_yy, str_yy
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("DPT_CD");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("H_CNT");
    hnwExtQuery.AddField("P_CNT");
    hnwExtQuery.AddField("LEVY_CD");
    hnwExtQuery.AddField("LEVY_TXT");
    hnwExtQuery.AddField("JOB_CD");
    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("HIR_YM");
    hnwExtQuery.AddField("JIKMU_CD");
    hnwExtQuery.AddField("JIKMU_NM");
    hnwExtQuery.AddField("REMARK");
    hnwExtQuery.AddField("SORT_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("H_CNT"));
            hnwExtQuery.AddData(vo.getString("P_CNT"));
            hnwExtQuery.AddData(vo.getString("LEVY_CD"));
            hnwExtQuery.AddData(vo.getString("LEVY_TXT"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("HIR_YM"));
            hnwExtQuery.AddData(vo.getString("JIKMU_CD"));
            hnwExtQuery.AddData(vo.getString("JIKMU_NM"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
