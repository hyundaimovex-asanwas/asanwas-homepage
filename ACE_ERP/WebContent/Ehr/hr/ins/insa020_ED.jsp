<!--
***********************************************************************
* @source      : insa020_ED.jsp
* @description : ���ο�������ǥ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/31      �漮ȣ        �����ۼ�.
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
	String PIS_YM_SHR		= request.getParameter("PIS_YM_SHR").replaceAll("-", "");
	String OCC_CD_SHR    = request.getParameter("OCC_CD_SHR");


	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("ins", "INSA020_PRT");


	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			//PIS_YM_SHR.substring(0,4),	  // ��
			//PIS_YM_SHR.substring(4),	      // ��
			PIS_YM_SHR.substring(0,4),	  // ��
			PIS_YM_SHR.substring(4)	      // ��
	};

	StringBuffer sb = new StringBuffer();


	/** ��ȸ ���ǿ� ���� ó�� **/
	if( ! OCC_CD_SHR.equals("0") ){
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
		sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
	String 	colStr  =   "JOB_NM,JOB_NM2,GUR_01,GUR_02,GUR_03,GUR_04,GUR_05,GUR_06";
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