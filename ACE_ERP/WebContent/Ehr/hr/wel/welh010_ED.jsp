<%@page import="javax.jms.Session"%>
<!--
***********************************************************************
* @source      : welh010_ED.jsp
* @description : ����������,�߽ĺ�,����� ��Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      �漮ȣ        �����ۼ�.
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
<%@page import ="com.gauce.GauceDataSet "%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO.*"   %>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>

<%
	String PIS_YY_SHR		= request.getParameter("PIS_YY_SHR");
	String PIS_MM_SHR		= request.getParameter("PIS_MM_SHR");
	String GBN_CD_SHR		= request.getParameter("GBN_CD_SHR").replaceAll("null","");
	String JOB_CD_SHR		= request.getParameter("JOB_CD_SHR");
	String DPT_CD_SHR		= request.getParameter("DPT_CD_SHR");
	String ENO_NO_SHR			= request.getParameter("ENO_NO_SHR").replaceAll("null","");


	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("wel", "WELH010_SHR");

	/** ��ȸ ����(��������)�� ���� ó�� **/
	StringBuffer sb = new StringBuffer();


	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {

	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			PIS_YY_SHR,
			PIS_MM_SHR,
			GBN_CD_SHR,
			JOB_CD_SHR,
			DPT_CD_SHR,
			ENO_NO_SHR
	};

	  AbstractDAO aaa= new AbstractDAO("default");

	    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	    extquery hnwExtQuery = new extquery();


	/** �ʵ尪 ���� **/
		String 	colStr  =   "DPT_NM,JOB_SEQ, PIS_YY,PIS_MM,ENO_NO,OCC_CD,DPT_CD,JOB_CD,CAR_AMT,TRA_AMT,LUN_AMT,DEL_AMT,SUM_AMT,TOT_AMT,NO_TAX,ENO_NM,JOB_NM,HOB_CD,DEL1_AMT,DEL2_AMT";
		String[] values = colStr.split(",");
		for( int x = 0; x < values.length; x++ ){
			hnwExtQuery.AddField(values[x]);
		}
	    hnwExtQuery.SendField(response);

	    if (voList.size() > 0)
	    {
	        for (int i=0; i<voList.size(); i++)
	        {
	            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

	        	for( int x = 0; x < values.length; x++ ){
	                hnwExtQuery.AddData(vo.getString(values[x]));
	        	}
	            hnwExtQuery.SendData(response);
	        }
	    }
	    else
	    {
	    	// hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
	    	for( int x = 0; x < values.length; x++ ){
	            hnwExtQuery.AddData("");
	    	}
	        hnwExtQuery.SendData(response);

	    }


%>