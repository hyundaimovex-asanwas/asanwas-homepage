<!--
***********************************************************************
* @source      : guna100_STEP_ED.jsp
* @description : 개인별근태집계현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      방석호        최초작성.
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

    String eno_no   = request.getParameter("eno_no");
	String sal_gbn  = request.getParameter("sal_gbn");
    String pis_yy    = request.getParameter("pis_yy");
    String pis_mm  = request.getParameter("pis_mm");
    String seq  = request.getParameter("seq");




    /** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_05_PRINT");


  	Object[] bind = null;
  	bind = new Object[] {

  		  pis_yy,
   	  	  pis_mm,
   	  	  eno_no,
   	  	  pis_yy,
   	  	  pis_mm,
   	  	  sal_gbn,
   	  	  seq,
   	  	  pis_yy,
 	  	  pis_mm,
 	  	  pis_yy,
 	  	  pis_mm


  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("소득세계");
    hnwExtQuery.AddField("갑근세계");
    hnwExtQuery.AddField("주민세계");
    hnwExtQuery.AddField("건강보험계");
    hnwExtQuery.AddField("국민연금계");
    hnwExtQuery.AddField("고용보험계");
    hnwExtQuery.AddField("전년도 유보지급금");
    hnwExtQuery.AddField("전년도 유보잔액");
    hnwExtQuery.AddField("당해년도 유보금계");


    hnwExtQuery.SendField(response);


    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("SAV_AMT"));
            hnwExtQuery.AddData(vo.getString("APP_AMT"));
            hnwExtQuery.AddData(vo.getString("INV_AMT"));

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);
%>