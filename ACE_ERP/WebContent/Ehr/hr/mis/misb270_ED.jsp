<!--
***********************************************************************
* @source      : misb270_ED.jsp
* @description : 임금내역 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/20      이승욱        최초작성.
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
    String str_ymd   = request.getParameter("STR_YY");
    String cd_gbn    = request.getParameter("CD_GBN");
    String dpt_cd    = request.getParameter("DPT_CD");

    String sql = null;
	StringBuffer sb1 = new StringBuffer();

	/** DynamicSQL을 적용하는 부분 [1] **/
    if (cd_gbn.equals("B2")){
        sb1.append(" AND DPT.UPDPT_CD = '" + dpt_cd + "'");
    } else if (cd_gbn.equals("A4")){
        sb1.append(" AND DPT.DPT_CD = '"   + dpt_cd + "'");
    }

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb1.toString(),
			sb1.toString()
	};

	/** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("mis", "MISB270_SHR");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
      Object[] bind = null;
      bind = new Object[] {
           str_ymd,
           str_ymd
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("OCC_CD");
    hnwExtQuery.AddField("PIS_MM");
    hnwExtQuery.AddField("GUBUN");
    hnwExtQuery.AddField("INWON");
    hnwExtQuery.AddField("SAL_AMT");
    hnwExtQuery.AddField("BON_AMT");
    hnwExtQuery.AddField("MH_AMT");
    hnwExtQuery.AddField("LUN_AMT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("OCC_CD"));
            hnwExtQuery.AddData(vo.getString("PIS_MM"));
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("INWON"));
            hnwExtQuery.AddData(vo.getString("SAL_AMT"));
            hnwExtQuery.AddData(vo.getString("BON_AMT"));
            hnwExtQuery.AddData(vo.getString("MH_AMT"));
            hnwExtQuery.AddData(vo.getString("LUN_AMT"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
