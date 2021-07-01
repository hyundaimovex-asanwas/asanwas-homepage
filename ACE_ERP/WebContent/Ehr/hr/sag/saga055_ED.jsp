<!--
***********************************************************************
* @source         : saga055_ED.jsp 				                                                                                     *
* @description   : �󿩴��� PAGE.
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/07      ���м�        �����ۼ�.
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

    String pis_ym = request.getParameter("pis_ym");
    String dpt_cd = request.getParameter("dpt_cd");
    String gbn_cd = request.getParameter("gbn_cd");


   // gbn_cd = "0";
    pis_ym = pis_ym.replaceAll("-","");
    String sql = "";
    String pis_y = request.getParameter("PIS_YY_SHR");      // ����
    String pis_m = request.getParameter("PIS_MM_SHR");      // ����
    /** �ܺ� XML���� SQL�� �о� �´� **/
    //sql = XmlSqlUtils.getSQL("sag", "SAGA050_SHR");
    System.out.println("�⵵ ED����:[" + pis_y + "]");
    System.out.println("  �� ED����:[" + pis_m + "]");
    System.out.println("dpt_cd ED����:"+dpt_cd);
    System.out.println("gbn_cd ED����:"+gbn_cd);

    if ( gbn_cd.equals("0") ) {
        /** �ܺ� XML���� SQL�� �о� �´� **/
         sql = XmlSqlUtils.getSQL("sag", "SAGA055_SHR");
         System.out.println("����0 [" + gbn_cd + "]");
         System.out.println(sql);
     } else if ( gbn_cd.equals("1") ) {
         sql = XmlSqlUtils.getSQL("sag", "SAGA055_SHR_01");
         System.out.println("����1 [" + gbn_cd + "]");
         System.out.println(sql);
     } else {
         sql = XmlSqlUtils.getSQL("sag", "SAGA055_SHR_02");
         System.out.println("����2 [" + gbn_cd + "]");
         System.out.println(sql);
     }



    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        pis_y, pis_m, dpt_cd
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
   // hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�̸�");
    hnwExtQuery.AddField("����");

	//�����޾�
    hnwExtQuery.AddField("�޿����޾�(A)");
    hnwExtQuery.AddField("�޿�������(B)");
    hnwExtQuery.AddField("�������޾�(C=A-B)");
    hnwExtQuery.AddField("�����޾�(E=C-D)");
	//�����޾�(A)
    hnwExtQuery.AddField("�⺻��");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("��Ÿ����");
    hnwExtQuery.AddField("��Ÿ����1");
    hnwExtQuery.AddField("�Ĵ�");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�󿩱�");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("��Ÿ����2");
	//�󿩰�����(B)
    hnwExtQuery.AddField("�ҵ漼");
    hnwExtQuery.AddField("�ֹμ�");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�ǰ�����");
    hnwExtQuery.AddField("��뺸��");
    hnwExtQuery.AddField("����ȸ��");
    hnwExtQuery.AddField("����纸��");
    hnwExtQuery.AddField("���ο��ݰ���");
    hnwExtQuery.AddField("��Ÿ����1");
    hnwExtQuery.AddField("��Ÿ����2");
    hnwExtQuery.AddField("��ȸ������(D)");

    hnwExtQuery.SendField(response);

    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//			hnwExtQuery.AddData(vo.getString("GUBUN"));		    // �����ܱ���
			hnwExtQuery.AddData(vo.getString("DPT_NM"));		// �μ�
            hnwExtQuery.AddData(vo.getString("ENO_NO"));		// ���
            hnwExtQuery.AddData(vo.getString("ENO_NM"));		// �̸�
            hnwExtQuery.AddData(vo.getString("JOB_NM"));		// ����
			//�����޾�
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));		// �����޾�(A)
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));		// �󿩰�����(B)
            hnwExtQuery.AddData(vo.getString("RL_AMT"));		// �������޾�(C=A-B)
            hnwExtQuery.AddData(vo.getString("NET_PAY_AMT"));	// �����޾�(E=C-D)
			//�����޾�(A)
            hnwExtQuery.AddData(vo.getString("NET_BAS_AMT"));	// �⺻��
            hnwExtQuery.AddData(vo.getString("LAW_AMT"));		// ��������
            hnwExtQuery.AddData(vo.getString("ETC_AMT"));		// ��Ÿ����
            hnwExtQuery.AddData(vo.getString("OTH_AMT"));		// ��Ÿ����1
            hnwExtQuery.AddData(vo.getString("LUN_AMT"));		// �Ĵ�
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));		// ��������
            hnwExtQuery.AddData(vo.getString("BNS_AMT"));		// �󿩱�
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));		// ���ο���
            hnwExtQuery.AddData(vo.getString("HOL_AMT"));	// ��Ÿ����2
			//�󿩰�����(B)
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));		// �ҵ漼
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));		// �ֹμ�
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));		// ���ο���
            hnwExtQuery.AddData(vo.getString("ETC_AMT_JN"));	// ��������
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));		// �ǰ�����
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));		// ��뺸��
            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));		// ����ȸ��
            hnwExtQuery.AddData(vo.getString("OLD_AMT"));		// ����纸��
            hnwExtQuery.AddData(vo.getString("PPED_AMT"));		// ���ο���
            hnwExtQuery.AddData(vo.getString("OTHD_AMT"));		// ��Ÿ����1
            hnwExtQuery.AddData(vo.getString("OTHD_AMT2"));		// ��Ÿ����2
            hnwExtQuery.AddData(vo.getString("CONT_AMT"));		// ��ȸ������(D)

			hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
		//�����޾�
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
		//�����޾�(A)
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
		//�󿩰�����(B)
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>