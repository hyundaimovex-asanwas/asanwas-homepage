<!--
***********************************************************************
* @source      : eisb030_ED.jsp
* @description : 사업부별직위별인건비현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/09      이승욱        최초작성.
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
    String pis_yy   = request.getParameter("PIS_YY");
    String pis_mm   = request.getParameter("PIS_MM");

    String sql = null;
    sql = XmlSqlUtils.getSQL("eis", "EISB030_SHR");

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy, pis_yy, pis_mm,
		  pis_yy, pis_mm,
		  pis_yy, pis_mm,
		  pis_yy, pis_mm
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("HDPT_NM");
    hnwExtQuery.AddField("HDPT_CD");
    hnwExtQuery.AddField("DPT_CD");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("PLAN_ET");
    hnwExtQuery.AddField("CNT_ET");
    hnwExtQuery.AddField("PLAN_ST");
    hnwExtQuery.AddField("SUM_ST");
    hnwExtQuery.AddField("RATE_TOT");
    hnwExtQuery.AddField("PLAN_EA");
    hnwExtQuery.AddField("CNT_EA");
    hnwExtQuery.AddField("PLAN_SA");
    hnwExtQuery.AddField("SUM_SA");
    hnwExtQuery.AddField("RATE_A");
    hnwExtQuery.AddField("PLAN_EB");
    hnwExtQuery.AddField("CNT_EB");
    hnwExtQuery.AddField("PLAN_SB");
    hnwExtQuery.AddField("SUM_SB");
    hnwExtQuery.AddField("RATE_B");
    hnwExtQuery.AddField("PLAN_EC");
    hnwExtQuery.AddField("CNT_EC");
    hnwExtQuery.AddField("PLAN_SC");
    hnwExtQuery.AddField("SUM_SC");
    hnwExtQuery.AddField("RATE_C");
    hnwExtQuery.AddField("PLAN_E2");
    hnwExtQuery.AddField("CNT_E2");
    hnwExtQuery.AddField("PLAN_S2");
    hnwExtQuery.AddField("SUM_S2");
    hnwExtQuery.AddField("RATE_2");
    hnwExtQuery.AddField("PLAN_E3");
    hnwExtQuery.AddField("CNT_E3");
    hnwExtQuery.AddField("PLAN_S3");
    hnwExtQuery.AddField("SUM_S3");
    hnwExtQuery.AddField("RATE_3");
    hnwExtQuery.AddField("PLAN_E4");
    hnwExtQuery.AddField("CNT_E4");
    hnwExtQuery.AddField("PLAN_S4");
    hnwExtQuery.AddField("SUM_S4");
    hnwExtQuery.AddField("RATE_4");
    hnwExtQuery.AddField("PLAN_E5");
    hnwExtQuery.AddField("CNT_E5");
    hnwExtQuery.AddField("PLAN_S5");
    hnwExtQuery.AddField("SUM_S5");
    hnwExtQuery.AddField("RATE_5");
    hnwExtQuery.AddField("PLAN_EE");
    hnwExtQuery.AddField("CNT_EE");
    hnwExtQuery.AddField("PLAN_SE");
    hnwExtQuery.AddField("SUM_SE");
    hnwExtQuery.AddField("RATE_ETC");
    
    hnwExtQuery.AddField("PLAN_M");
    hnwExtQuery.AddField("CNT_M");
    hnwExtQuery.AddField("PLAN_SM");
    hnwExtQuery.AddField("SUM_SM");
    hnwExtQuery.AddField("RATE_M");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("HDPT_NM"));
            hnwExtQuery.AddData(vo.getString("HDPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("PLAN_ET"));
            hnwExtQuery.AddData(vo.getString("CNT_ET"));
            hnwExtQuery.AddData(vo.getString("PLAN_ST"));
            hnwExtQuery.AddData(vo.getString("SUM_ST"));
            hnwExtQuery.AddData(vo.getString("RATE_TOT"));
            hnwExtQuery.AddData(vo.getString("PLAN_EA"));
            hnwExtQuery.AddData(vo.getString("CNT_EA"));
            hnwExtQuery.AddData(vo.getString("PLAN_SA"));
            hnwExtQuery.AddData(vo.getString("SUM_SA"));
            hnwExtQuery.AddData(vo.getString("RATE_A"));
            hnwExtQuery.AddData(vo.getString("PLAN_EB"));
            hnwExtQuery.AddData(vo.getString("CNT_EB"));
            hnwExtQuery.AddData(vo.getString("PLAN_SB"));
            hnwExtQuery.AddData(vo.getString("SUM_SB"));
            hnwExtQuery.AddData(vo.getString("RATE_B"));
            hnwExtQuery.AddData(vo.getString("PLAN_EC"));
            hnwExtQuery.AddData(vo.getString("CNT_EC"));
            hnwExtQuery.AddData(vo.getString("PLAN_SC"));
            hnwExtQuery.AddData(vo.getString("SUM_SC"));
            hnwExtQuery.AddData(vo.getString("RATE_C"));
            hnwExtQuery.AddData(vo.getString("PLAN_E2"));
            hnwExtQuery.AddData(vo.getString("CNT_E2"));
            hnwExtQuery.AddData(vo.getString("PLAN_S2"));
            hnwExtQuery.AddData(vo.getString("SUM_S2"));
            hnwExtQuery.AddData(vo.getString("RATE_2"));
            hnwExtQuery.AddData(vo.getString("PLAN_E3"));
            hnwExtQuery.AddData(vo.getString("CNT_E3"));
            hnwExtQuery.AddData(vo.getString("PLAN_S3"));
            hnwExtQuery.AddData(vo.getString("SUM_S3"));
            hnwExtQuery.AddData(vo.getString("RATE_3"));
            hnwExtQuery.AddData(vo.getString("PLAN_E4"));
            hnwExtQuery.AddData(vo.getString("CNT_E4"));
            hnwExtQuery.AddData(vo.getString("PLAN_S4"));
            hnwExtQuery.AddData(vo.getString("SUM_S4"));
            hnwExtQuery.AddData(vo.getString("RATE_4"));
            hnwExtQuery.AddData(vo.getString("PLAN_E5"));
            hnwExtQuery.AddData(vo.getString("CNT_E5"));
            hnwExtQuery.AddData(vo.getString("PLAN_S5"));
            hnwExtQuery.AddData(vo.getString("SUM_S5"));
            hnwExtQuery.AddData(vo.getString("RATE_5"));
            hnwExtQuery.AddData(vo.getString("PLAN_EE"));
            hnwExtQuery.AddData(vo.getString("CNT_EE"));
            hnwExtQuery.AddData(vo.getString("PLAN_SE"));
            hnwExtQuery.AddData(vo.getString("SUM_SE"));
            hnwExtQuery.AddData(vo.getString("RATE_ETC"));
            
            hnwExtQuery.AddData(vo.getString("PLAN_M"));
            hnwExtQuery.AddData(vo.getString("CNT_M"));
            hnwExtQuery.AddData(vo.getString("PLAN_SM"));
            hnwExtQuery.AddData(vo.getString("SUM_SM"));
            hnwExtQuery.AddData(vo.getString("RATE_M"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

