<!--
***********************************************************************
* @source      : saga080_1_ED.jsp
* @description : �޿��Ѱ�ǥ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      �漮ȣ        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
	String PIS_YYMM_SHR = request.getParameter("PIS_YYMM_SHR");
	String OCC_CD_SHR 	= request.getParameter("OCC_CD_SHR");
	String DPT_CD_SHR  	= request.getParameter("DPT_CD_SHR");
	String TOTAL_SHR 		= request.getParameter("TOTAL_SHR");


	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("sag", "SAGA080_SHR_02");

	//������ 0�ΰ� �ʳ��´�.
	StringBuffer sb1 = new StringBuffer();
	StringBuffer sb2 = new StringBuffer();
	if (TOTAL_SHR.equals("false")) {
		sb1.append("            SELECT DPT_NM, JOB_NM, ENO_NO, ENO_NM, BEF_AMT, AFT_AMT \n");
		sb1.append("            FROM   (\n");
		sb2.append("                        )\n");
		sb2.append("            WHERE (AFT_AMT - BEF_AMT) <> '0' \n");
	}

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb1.toString(),
			sb2.toString(),
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
//			OCC_CD_SHR,
//			DPT_CD_SHR,
//			PIS_YYMM_SHR.replaceAll("-", ""),
//			PIS_YYMM_SHR.replaceAll("-", ""),
//			PIS_YYMM_SHR.substring(0,4),
//			PIS_YYMM_SHR.substring(5,7),
				OCC_CD_SHR,
				OCC_CD_SHR,
				PIS_YYMM_SHR.replaceAll("-", ""),
				PIS_YYMM_SHR.replaceAll("-", ""),
				DPT_CD_SHR,
				PIS_YYMM_SHR.replaceAll("-", ""),
				PIS_YYMM_SHR.replaceAll("-", ""),
				PIS_YYMM_SHR.substring(0,4),
				PIS_YYMM_SHR.substring(5,7),
	};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "DPT_NM,JOB_NM,ENO_NO,ENO_NM,BEF_AMT,AFT_AMT";
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
