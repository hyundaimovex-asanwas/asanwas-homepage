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
	String PIS_YY = request.getParameter("PIS_YYMM").substring(0, 4);
	String PIS_MM = request.getParameter("PIS_YYMM").substring(4, 6);
	String DPT_CD = request.getParameter("DPT_CD");

	String PRE_PIS_YY = DateUtil.getAfterDate(PIS_YYMM+"01", 0, -1, 0).substring(0,4);
	String PRE_PIS_MM = DateUtil.getAfterDate(PIS_YYMM+"01", 0, -1, 0).substring(4,6);

	String sql = XmlSqlUtils.getSQL("tax2", "TAXA200_PRT");

//	param binding �ϱ�
	Object[] bind = new Object[] {
	    	PIS_YY,
			PIS_MM,
			PIS_YY,
			PIS_MM,
			PIS_YY,
			PIS_MM,
			PIS_YY,
			PIS_MM,
			PIS_MM,
			PIS_YYMM,
			PIS_YY,
			PIS_MM,

            //SUB1
			PIS_YYMM,

            //SUB3
			PIS_YYMM,

			//SUB4
            PIS_YY,
            PIS_MM,
            PIS_YY,
            PIS_MM,
            PIS_YY,
            PIS_MM,
            PIS_YY,
            PIS_MM,
            PIS_YY,
            PIS_MM,
            //DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����

            PRE_PIS_YY,
            PRE_PIS_YY,
            //DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����

            //PIS_YY,
            //PIS_MM,
            //DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����
            //PIS_YY,
            //DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����
           // PIS_YY,
           // PIS_YY,
           // PIS_MM,

            //PIS_YY,
           // PIS_YY,
            //PIS_MM,
            //DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����

            PIS_MM,
            PRE_PIS_YY,
            PIS_YY,
            PIS_MM,
            PIS_MM,
            //DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����

			//SUB5
			PRE_PIS_YY,
			PRE_PIS_MM,
			PRE_PIS_YY+PRE_PIS_MM,
			PRE_PIS_YY+PRE_PIS_MM,
			//DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����
			PIS_YYMM,

			//SUB6
			PIS_YY,
			PIS_MM,

			//COM
			//DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����

			//ETCPAY_LA
            PIS_YY,
            PIS_MM,

            //ETCPAY_REG
            PRE_PIS_YY,
            PRE_PIS_MM,
            //DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����
            PRE_PIS_YY,
            PRE_PIS_MM,
            PRE_PIS_YY,
            PRE_PIS_MM,
            PRE_PIS_YY,
            PRE_PIS_MM,

			//DPT_CD, //���빮���, ���λ�� ��ȸ�� ���� �ڷ� ����

			DPT_CD,


	};

	AbstractDAO aaa = new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
	extquery hnwExtQuery = new extquery();

	/** �ʵ尪 ���� **/
//	String colStr = "DPT_CD,CNT1,INCM_TAX1,CITI_TAX1,DPT_NM,OFFICE,CNT2,INCM_TAX,CITI_TAX,ETC_CNT,ETC_AMT,MON_RET,AMT_DATE,INTX5,CNT5,ETC_CNT6,ETC_AMT6,REMARK2,REMARK3,OFFICE,TYPE_OWN,TYPE_ONM,REN_YMD,STR_YMD,END_YMD,REN_PER,REN_NAM,REMARK,GBN_CD,COM_NO";
	String colStr = "DPT_CD,CNT1,INCM_TAX1,CITI_TAX1,DPT_NM,OFFICE,CNT2,INCM_TAX,CITI_TAX,ETC_CNT,ETC_AMT,MON_RET,AMT_DATE,ICM_TOT,CNT5,ETC_CNT6,ETC_AMT6,REMARK2,REMARK3,OFFICE,TYPE_OWN,TYPE_ONM,REN_YMD,STR_YMD,END_YMD,REN_PER,REN_NAM,REMARK,GBN_CD,COM_NO,SUB4_CNT";
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
