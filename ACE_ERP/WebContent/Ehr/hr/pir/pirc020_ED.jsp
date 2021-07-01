<!--
***********************************************************************
* @source      : guna100_ED.jsp
* @description : ���κ�����������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      ���м�        �����ۼ�.
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

    String sql = null;
    sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_01");

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy,
		  pis_mm,
		  sal_gbn,
		  seq,
		  eno_no
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����/ȣ��");
    hnwExtQuery.AddField("���¹�ȣ");
    hnwExtQuery.AddField("�ξ��ڵ�");

    hnwExtQuery.AddField("�⺻��");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�󿩱�");
    hnwExtQuery.AddField("����������");
    hnwExtQuery.AddField("���ο���");

    hnwExtQuery.AddField("�����ٹ�����");
    hnwExtQuery.AddField("�Ĵ�");
    hnwExtQuery.AddField("�����ξ��");
    hnwExtQuery.AddField("��Ÿ����");
    hnwExtQuery.AddField("�ټӼ���");

    hnwExtQuery.AddField("�ڱ��ߺ�");
    hnwExtQuery.AddField("�ⳳ����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�ڰݼ���");
    hnwExtQuery.AddField("���ϰ�������");
    hnwExtQuery.AddField("Ư��������");
    hnwExtQuery.AddField("���ڱ�");
    hnwExtQuery.AddField("������å����");
    hnwExtQuery.AddField("�����ұ�");
    hnwExtQuery.AddField("���ϱٹ�����");
    hnwExtQuery.AddField("���_�����ٹ�����");
    hnwExtQuery.AddField("���_�������");
	hnwExtQuery.AddField("���_������");

    hnwExtQuery.AddField("�����޾�");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�Ǽ��ɾ�");
    hnwExtQuery.AddField("�μ���");

    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("��1");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("�޿�������");
    hnwExtQuery.AddField("��������");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ACC_NO"));
            hnwExtQuery.AddData(vo.getString("BY_CD"));

            hnwExtQuery.AddData(vo.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));
            hnwExtQuery.AddData(vo.getString("LAW_AMT"));
            hnwExtQuery.AddData(vo.getString("BNS_AMT"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT"));
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));

            hnwExtQuery.AddData(vo.getString("ETC_AMT2"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT3"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT4"));
            hnwExtQuery.AddData(vo.getString("OTH_AMT_PRN"));
            hnwExtQuery.AddData(vo.getString("LSEV_AMT"));

     	    hnwExtQuery.AddData(vo.getString("OSE_AMT"));
			hnwExtQuery.AddData(vo.getString("MONEY_AMT"));
			hnwExtQuery.AddData(vo.getString("DRIVE_AMT"));
			hnwExtQuery.AddData(vo.getString("RUN_AMT"));
			hnwExtQuery.AddData(vo.getString("SPECIAL_AMT"));
			hnwExtQuery.AddData(vo.getString("OTH_AMT2"));
			hnwExtQuery.AddData(vo.getString("SCH_AMT"));
			hnwExtQuery.AddData(vo.getString("POSITION_AMT"));
			hnwExtQuery.AddData(vo.getString("RETRO_AMT"));
			hnwExtQuery.AddData(vo.getString("HOL_AMT"));
			hnwExtQuery.AddData(vo.getString("T_NORTH_AMT"));
			hnwExtQuery.AddData(vo.getString("T_SITE_AMT"));
			hnwExtQuery.AddData(vo.getString("T_GOAL_AMT"));


            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));

            hnwExtQuery.AddData(vo.getString("SOU_CNT"));
            hnwExtQuery.AddData(vo.getString("DFM_CNT"));
            hnwExtQuery.AddData(vo.getString("TRB_CNT"));
            hnwExtQuery.AddData(vo.getString("GOL_CNT"));
            hnwExtQuery.AddData(vo.getString("WCT_CNT"));
            hnwExtQuery.AddData(vo.getString("CHI_CNT"));
            hnwExtQuery.AddData(vo.getString("PAY_YMD"));
            hnwExtQuery.AddData(vo.getString("REMARK"));


            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);
%>