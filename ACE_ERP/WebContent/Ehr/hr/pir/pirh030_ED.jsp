<!--
***********************************************************************
* @source      : pirh030_ED.jsp
* @description : ���޺�,�ټӳ���� �ο���Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     �漮ȣ        �����ۼ�.
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
	String HIR_YMD_SHR	= request.getParameter("HIR_YMD_SHR").replaceAll("-", "");
	String OCC_CD_SHR    	= request.getParameter("OCC_CD_SHR");
	String GBN_CD_SHR		= request.getParameter("GBN_CD_SHR");
	String FLAG_SHR		= request.getParameter("FLAG_SHR");
	String HIR_SHR		= request.getParameter("HIR_SHR");
	String CON_SHR		= request.getParameter("CON_SHR");

System.out.println(FLAG_SHR);
	String	sql = "";
	/** �ܺ� XML���� SQL�� �о� �´� **/
	if( ! FLAG_SHR.equals("HIR") ) {
		 sql = XmlSqlUtils.getSQL("pir", "PIRH030_PRT_01");
	}else{
		 sql = XmlSqlUtils.getSQL("pir", "PIRH030_PRT");
	}
//	String sql = XmlSqlUtils.getSQL("pir", "PIRH030_PRT");


	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {};

	StringBuffer sb = new StringBuffer();

	/** ��ȸ ���ǿ� ���� ó�� **/
	if( ! GBN_CD_SHR.equals("0") ){
		if( GBN_CD_SHR.equals("1") ){
			sb.append("AND GBN_CD  = '1' \n"); // ���� ��
		}else{
			sb.append("AND GBN_CD != '1' \n"); // ����(1) �� �ƴ� ���
		}
	}
	if( ! OCC_CD_SHR.equals("0") ){
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}
	if( ! HIR_YMD_SHR.equals("") ){
		sb.append("AND TO_CHAR("+FLAG_SHR+"_YMD,'YYYYMMDD') <= '"+HIR_YMD_SHR+"' \n");
	}

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString(),	sb.toString(),	sb.toString(),
			sb.toString(),	sb.toString(),	sb.toString(),
			sb.toString(),	sb.toString(),	sb.toString(),
			sb.toString(),	sb.toString(),	sb.toString(),
			sb.toString(),	sb.toString(),	sb.toString(),
			sb.toString(),	sb.toString(),	sb.toString(),
			sb.toString(),	sb.toString(),	sb.toString(),
			sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
	String 	colStr  =   "RN,JOB_NM,HIR_TOT,HIR_AVG,HIR_01,HIR_02,HIR_03,HIR_04,HIR_05,HIR_06,HIR_07,HIR_08,HIR_09,HIR_10,HIR_11,HIR_12,HIR_13,HIR_14,HIR_15,HIR_16,HIR_17,HIR_18,HIR_19,HIR_20,HIR_21";
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