<!--
***********************************************************************
* @source      : guna220_ED.jsp
* @description : ����������Ȳ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/11/05      ������        �����ۼ�.
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
/*   EZGEN ���Ͽ��� �޴� parameter�� */

    String pis_y = request.getParameter("PIS_YY_SHR");      // ����
    String pis_m = request.getParameter("PIS_MM_SHR");      // ����

    System.out.println("guna220_ED  �⵵ [" + pis_y + "] ���� [" + pis_m + "]");
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_01");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
            pis_y,
			pis_m
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("�ο�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�İ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("���Ĺ���");
    hnwExtQuery.AddField("Ư��");
    hnwExtQuery.AddField("���޹���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ʒ�");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�Ϲ�����");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�������ް�");

    hnwExtQuery.SendField(response);

    // DynamicValueObject voList = DvoUtil.getDynamicValueObject(request, "RESULT");


	String pre_nm = "";
	String nm = "";
    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
/*
	C.DPT_NM AS UP_DPT_NM
	,B.DPT_CD
	,B.DPT_NM
	,A.ATT_A    --�հ�(����)
	,A.ATT_B   	--�հ�(����)
	,A.ATT_C   	--�հ�(����)
	,A.ATT_D   	--�հ�(����)
	,A.ATT_E   	--�հ�(����)
	,A.ATT_F   	--�հ�(����)
	,A.ATT_G   	--�հ�(�Ʒ�)
	,A.ATT_H   	--�հ�(����)
	,A.ATT_I   	    --�հ�(Ư��)
	,A.ATT_J   	--�հ�(����)
	,A.ATT_K   	--�հ�(����)
	,A.ATT_L   	--�հ�(��Ÿ)
	,A.ATT_N   	--�հ�(��������)
	,A.ATT_O   	--�հ�(�İ߱ٹ�)
	,A.ATT_P   	--�հ�(����������)
	,A.ATT_R   	--�հ�(���Ŀ�����)
	,A.ATT_S   	--�հ�(����)
	,A.ATT_U   	--�հ�(��ü����)
	,A.ATT_X   	--�հ�(�������ް�)
	,A.ATW_CNT 	--����ٹ�
	,A.HOL_CNT 	--����
	,A.HOW_CNT 	--���ϱٹ�(��ü�ް�)
*/
				String UPDPT_NM = vo.getString("UPDPT_NM");
				if(pre_nm.equals(UPDPT_NM)){
					hnwExtQuery.AddData("");     //����
				}else{
					hnwExtQuery.AddData(UPDPT_NM);     //����
				}

				hnwExtQuery.AddData(vo.getString("DPT_NM"));     //�μ�
				hnwExtQuery.AddData(vo.getString("CNT"));     //�ο�
				hnwExtQuery.AddData(vo.getString("ATT_C"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_E"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_O"));   	//�հ�(�İ߱ٹ�)
				hnwExtQuery.AddData(vo.getString("ATT_H"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_P"));   	//�հ�(����������)
				hnwExtQuery.AddData(vo.getString("ATT_R"));   	//�հ�(���Ŀ�����)
				hnwExtQuery.AddData(vo.getString("ATT_I"));   	//�հ�(Ư��)
				hnwExtQuery.AddData(vo.getString("ATT_T"));   	//�հ�(��ü����)
				hnwExtQuery.AddData(vo.getString("ATT_F"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_G"));   	//�հ�(�Ʒ�)
				hnwExtQuery.AddData(vo.getString("ATT_AB"));     //�հ�(����+����)
				hnwExtQuery.AddData(vo.getString("ATT_K"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_N"));   	//�հ�(��������)
				hnwExtQuery.AddData(vo.getString("ATT_X"));   	//�հ�(�������ް�)
				pre_nm = UPDPT_NM;

				/*
				hnwExtQuery.AddData(vo.getString("ATT_A"));     //�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_B"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_D"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_J"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATT_L"));   	//�հ�(��Ÿ)
				hnwExtQuery.AddData(vo.getString("ATT_S"));   	//�հ�(����)
				hnwExtQuery.AddData(vo.getString("ATW_CNT")); 	//����ٹ�
				hnwExtQuery.AddData(vo.getString("HOL_CNT")); 	//����
				hnwExtQuery.AddData(vo.getString("HOW_CNT")); 	//���ϱٹ�(��ü�ް�)
				*/

            hnwExtQuery.SendData(response);
		}
    }

%>