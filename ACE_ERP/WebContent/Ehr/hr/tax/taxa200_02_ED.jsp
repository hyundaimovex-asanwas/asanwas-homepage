<!--
***********************************************************************
* @source      : taxa130_ED.jsp
* @description : �ٷμҵ��õ¡��������
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      �漮ȣ        �����ۼ�.
***********************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr"
	import="javax.naming.*,elsoft.extquery.*"%>
<%@page import="com.shift.gef.support.vo.*"%>
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject"%>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="common.util.DateUtil"%>

<%
	String PIS_YYMM = request.getParameter("PIS_YYMM");
	String DPT_CD = request.getParameter("DPT_CD");

	String sql = XmlSqlUtils.getSQL("tax2", "TAXA200_02_PRT");
	
	//param binding �ϱ�
	Object[] bind = new Object[] {			
			DPT_CD
	};

	AbstractDAO aaa = new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

	/** �ʵ尪 ���� **/
	String colStr = "DPT_CD,DPT_NM,REMARK2,REMARK3,OFFICE,TYPE_OWN,TYPE_ONM,REN_YMD,STR_YMD,END_YMD,REN_PER,REN_NAM,REMARK,GBN_CD,COM_NO";
	String[] values = colStr.split(",");
	for (int x = 0; x < values.length; x++) {
		hnwExtQuery.AddField(values[x]);
	}

	hnwExtQuery.SendField(response);

	if (voList.size() > 0) {
		for (int i = 0; i < voList.size(); i++) {
			DynamicValueObject vo = (DynamicValueObject) voList.get(i);

			for (int x = 0; x < values.length; x++) {
		hnwExtQuery.AddData(vo.getString(values[x]));
			}
			hnwExtQuery.SendData(response);
		}
	} else {
		// hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
		for (int x = 0; x < values.length; x++) {
			hnwExtQuery.AddData("");
		}
		hnwExtQuery.SendData(response);

	}
%>
