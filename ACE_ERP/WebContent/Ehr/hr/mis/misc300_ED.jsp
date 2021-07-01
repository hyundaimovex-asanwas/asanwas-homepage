<!--
***********************************************************************
* @source      : misc300_ED.jsp
* @description : 업무별예산(항세목별) 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/28      이승욱        최초작성.
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
    String item_cd  = request.getParameter("ITEM_CD");
    String occ_cd   = request.getParameter("OCC_CD");
    String cur_yy   = request.getParameter("CUR_YY");
    String pln_yy   = request.getParameter("PLN_YY");

    String sql = null;

    sql = XmlSqlUtils.getSQL("mis", "MISC300_SHR_02");

      Object[] bind = null;
      bind = new Object[] {
            item_cd, occ_cd, item_cd, pln_yy, occ_cd, pln_yy, item_cd, pln_yy, occ_cd, pln_yy, item_cd, occ_cd, cur_yy, occ_cd, cur_yy, pln_yy, item_cd, occ_cd, cur_yy, pln_yy, item_cd, occ_cd, cur_yy, pln_yy, item_cd, occ_cd, cur_yy, pln_yy, item_cd, pln_yy, cur_yy, pln_yy, occ_cd, item_cd, item_cd, occ_cd, cur_yy, pln_yy, item_cd, item_cd, item_cd, item_cd, item_cd, item_cd, pln_yy, occ_cd, cur_yy, item_cd, pln_yy, occ_cd, cur_yy, item_cd, pln_yy, item_cd, cur_yy, occ_cd, cur_yy, item_cd, pln_yy, cur_yy, occ_cd, cur_yy, item_cd
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("BEF_SUM");
    hnwExtQuery.AddField("BEF1_SUM");
    hnwExtQuery.AddField("BEF2_SUM");
    hnwExtQuery.AddField("BEF3_SUM");
    hnwExtQuery.AddField("AFT_SUM");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ITEM_NM"));
            hnwExtQuery.AddData(vo.getString("BEF_SUM"));
            hnwExtQuery.AddData(vo.getString("BEF1_SUM"));
            hnwExtQuery.AddData(vo.getString("BEF2_SUM"));
            hnwExtQuery.AddData(vo.getString("BEF3_SUM"));
            hnwExtQuery.AddData(vo.getString("AFT_SUM"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
