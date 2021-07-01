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
    String pis_yymm  = request.getParameter("pis_yy") + request.getParameter("pis_mm");
    String seq  = request.getParameter("seq");

    String sql = null;
    StringBuffer sb = new StringBuffer();
    
    /** DynamicSQL을 적용하는 부분 [1] **/
    if (eno_no.equals("2040038")){
		sb.append(" UNION SELECT '하이드림' AS BNK_NM, '대한생명' AS COMM_NM,'저축' AS GUBUN, '2014-06-30' AS DUE_YMD, 0 AS PYM_AMT, 120 AS PIN_CNT, 8716500 AS SUM_PYM, 0 AS GMK_AMT, 0 AS GMK_BAK  FROM DUAL  ");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb.toString()
    };    
    
    sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_03");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
	Object[] bind = null;
  	bind = new Object[] {
  		  pis_yy,
   	  	  pis_mm,
   	  	  sal_gbn,
   	  	  seq,
   	  	  eno_no,
   	      pis_yymm,
   	  	  seq,
   	      sal_gbn,
  		  eno_no,
  		  pis_yymm,
    	  eno_no,
  		  eno_no,
  		  pis_yymm,
  	      eno_no,
		  eno_no,
		  pis_yymm
 	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("저축종류");
    hnwExtQuery.AddField("은행");
    hnwExtQuery.AddField("구분");
    hnwExtQuery.AddField("만기일");
    hnwExtQuery.AddField("당월불입액");

    hnwExtQuery.AddField("횟수");
    hnwExtQuery.AddField("누계액");
    hnwExtQuery.AddField("대출금잔액");

    hnwExtQuery.SendField(response);



    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("BNK_NM"));
            hnwExtQuery.AddData(vo.getString("SAV_NM"));
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("DUE_YMD"));
            hnwExtQuery.AddData(vo.getString("CONM_AMT"));

            hnwExtQuery.AddData(vo.getString("SUMP_CNT"));
            hnwExtQuery.AddData(vo.getString("SUM_SAV"));
            hnwExtQuery.AddData(vo.getString("GMK_BAK"));
            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);

%>