<!--
***********************************************************************
* @source      : pirh060_ED.jsp
* @description : �зº��ο���Ȳ PAGE
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

	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRH060_PRT");


	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {};

	StringBuffer sb = new StringBuffer();


	/** ��ȸ ���ǿ� ���� ó�� **/
	if( ! HIR_YMD_SHR.equals("") ){
		sb.append("AND HIR_YMD <= '"+HIR_YMD_SHR+"' \n");
	}
	if( ! OCC_CD_SHR.equals("0") ){
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}
	if( ! GBN_CD_SHR.equals("0") ){
		if( GBN_CD_SHR.equals("1") ){
			sb.append("AND GBN_CD  = '1' \n"); // ���� ��
		}else{
			sb.append("AND GBN_CD != '1' \n"); // ����(1) �� �ƴ� ���
		}
	}

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
		sb.toString(),
		sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
	String 	colStr  =   "JOB_SEQ,RN,JOB_NM,GUR_TOT_CNT,GUR_01_CNT,GUR_02_CNT,GUR_03_CNT,GUR_04_CNT,GUR_ETC_CNT,GUR_TOT_PER,GUR_01_PER,GUR_02_PER,GUR_03_PER,GUR_04_PER,GUR_05_PER";
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