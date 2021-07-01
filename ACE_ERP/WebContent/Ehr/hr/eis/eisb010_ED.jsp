<!--
***********************************************************************
* @source      : eisb010_ED.jsp
* @description : 연도별인건비현황 조회PAGE
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
    sql = XmlSqlUtils.getSQL("eis", "EISB010_SHR");

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy_fr,
		  pis_yy_to
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

	hnwExtQuery.AddField("PIS_YY");

    hnwExtQuery.AddField("TOG_SAL");
	hnwExtQuery.AddField("TOS_SAL");
	hnwExtQuery.AddField("TOT_SAL");
	hnwExtQuery.AddField("ENO_AVR");
    hnwExtQuery.AddField("SAG_SAL");
    hnwExtQuery.AddField("SAS_SAL");
    hnwExtQuery.AddField("SAT_SAL");
    hnwExtQuery.AddField("SAT_AVR");

    hnwExtQuery.AddField("TAG_SAL");
    hnwExtQuery.AddField("TAS_SAL");
    hnwExtQuery.AddField("TAT_SAL");
    hnwExtQuery.AddField("TAT_AVR");

    hnwExtQuery.AddField("BEFOREAMT");

    //hnwExtQuery.AddField("ENO_NO");
    //hnwExtQuery.AddField("SAE_NO");
    //hnwExtQuery.AddField("TAE_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("PIS_YY"));

            hnwExtQuery.AddData(vo.getString("TOG_SAL"));
            hnwExtQuery.AddData(vo.getString("TOS_SAL"));
            hnwExtQuery.AddData(vo.getString("TOT_SAL"));
            hnwExtQuery.AddData(vo.getString("ENO_AVR"));

            hnwExtQuery.AddData(vo.getString("SAG_SAL"));
            hnwExtQuery.AddData(vo.getString("SAS_SAL"));
            hnwExtQuery.AddData(vo.getString("SAT_SAL"));
            hnwExtQuery.AddData(vo.getString("SAT_AVR"));

            hnwExtQuery.AddData(vo.getString("TAG_SAL"));
            hnwExtQuery.AddData(vo.getString("TAS_SAL"));
            hnwExtQuery.AddData(vo.getString("TAT_SAL"));
            hnwExtQuery.AddData(vo.getString("TAT_AVR"));

            hnwExtQuery.AddData(vo.getString("BEFOREAMT"));

//            hnwExtQuery.AddData(vo.getString("ENO_NO"));
//            hnwExtQuery.AddData(vo.getString("SAE_NO"));
//            hnwExtQuery.AddData(vo.getString("TAE_NO"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>

