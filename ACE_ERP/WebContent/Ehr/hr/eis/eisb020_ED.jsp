<!--
***********************************************************************
* @source      : eisb020_ED.jsp
* @description : 연도별직위별인건비현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/06      이승욱        최초작성.
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
    String pis_yy_fr   = request.getParameter("PIS_YY_FR");
    String pis_yy_to   = request.getParameter("PIS_YY_TO");

    String sql = null;
    sql = XmlSqlUtils.getSQL("eis", "EISB020_SHR");

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy_fr,
		  pis_yy_to
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("PIS_YY");
    hnwExtQuery.AddField("TOT_SAL");
	hnwExtQuery.AddField("AMT_A");
	hnwExtQuery.AddField("AMT_B");
    hnwExtQuery.AddField("AMT_C");
    hnwExtQuery.AddField("AMT_2");
    hnwExtQuery.AddField("AMT_3"); 
    hnwExtQuery.AddField("AMT_4");
    hnwExtQuery.AddField("AMT_5");
    hnwExtQuery.AddField("AMT_ETC"); 
    hnwExtQuery.AddField("AMT_M"); 

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("PIS_YY"));
            hnwExtQuery.AddData(vo.getString("TOT_SAL"));
            hnwExtQuery.AddData(vo.getString("AMT_A"));
            hnwExtQuery.AddData(vo.getString("AMT_B"));
            hnwExtQuery.AddData(vo.getString("AMT_C"));
            hnwExtQuery.AddData(vo.getString("AMT_2"));
            hnwExtQuery.AddData(vo.getString("AMT_3"));
            hnwExtQuery.AddData(vo.getString("AMT_4"));
            hnwExtQuery.AddData(vo.getString("AMT_5"));
            hnwExtQuery.AddData(vo.getString("AMT_ETC"));
            hnwExtQuery.AddData(vo.getString("AMT_M"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

