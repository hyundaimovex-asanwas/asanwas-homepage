<!--
***********************************************************************
* @source      : .jsp
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

    String pis_ymd = request.getParameter("PIS_YMD_SHR");      // �����
    String pis_y = request.getParameter("PIS_YY_SHR");       // �⵵
    String pis_m = request.getParameter("PIS_MM_SHR");      // ����
    String pis_d = request.getParameter("PIS_DD_SHR");      // �ϵ�
//System.out.println("guna221_ED ����� [" + pis_ymd + "] �⵵ [" + pis_y + "] ���� [" + pis_m + "] �ϵ� [" + pis_d + "]");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_02");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
			pis_ymd,
            pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);


	/* �Ѱ� ���ϱ� Start */
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql2 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_03");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind2 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd
    };
	AbstractDAO bbb= new AbstractDAO("default");
    DynamicValueObject voList2 = bbb.selectProcessDvo(sql2, bind2);
	DynamicValueObject vo2 = (DynamicValueObject)voList2.get(0);

	/* �Ѱ� ���ϱ� End */
	/* �Ұ�(IT����) ���ϱ� Start */
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql3 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_04");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind3 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			"O",
			"O",
			pis_ymd,
			pis_ymd
    };
	AbstractDAO ccc= new AbstractDAO("default");
    DynamicValueObject voList3 = ccc.selectProcessDvo(sql3, bind3);
	DynamicValueObject vo3 = (DynamicValueObject)voList3.get(0);
	/* �Ұ�(IT����) ���ϱ� End */
	/* �Ұ�(SI�����) ���ϱ� Start */
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql4 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_04");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind4 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			"D",
			"D",
			pis_ymd,
			pis_ymd
    };
	AbstractDAO ddd = new AbstractDAO("default");
    DynamicValueObject voList4 = ddd.selectProcessDvo(sql4, bind4);
	DynamicValueObject vo4 = (DynamicValueObject)voList4.get(0);
	/* �Ұ�(SI�����) ���ϱ� End */
	/* �Ұ�(SI�����) ���ϱ� Start */
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql5 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_04");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind5 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			"C",
			"C",
			pis_ymd,
			pis_ymd
    };
	AbstractDAO eee = new AbstractDAO("default");
    DynamicValueObject voList5 = eee.selectProcessDvo(sql5, bind5);
	DynamicValueObject vo5 = (DynamicValueObject)voList5.get(0);
	/* �Ұ�(SI�����) ���ϱ� End */

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
    hnwExtQuery.AddField("��ü�ް�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ʒ�");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�Ϲ�����");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�������ް�");

    hnwExtQuery.SendField(response);

    // DynamicValueObject voList = DvoUtil.getDynamicValueObject(request, "RESULT");





	HashMap hash = new HashMap();
	Vector list = new Vector();

	//�Ѱ�
	hash.put("UPDPT_NM", vo2.getString("UPDPT_NM"));     //����
	hash.put("DPT_NM",   vo2.getString("DPT_NM"));     //�μ�
	hash.put("CNT",      vo2.getString("CNT"));     //�ο�
	hash.put("ATT_C", vo2.getString("ATT_C"));   	//�հ�(����)
	hash.put("ATT_E", vo2.getString("ATT_E"));   	//�հ�(����)
	hash.put("ATT_O", vo2.getString("ATT_O"));   	//�հ�(�İ߱ٹ�)
	hash.put("ATT_H", vo2.getString("ATT_H"));   	//�հ�(����)
	hash.put("ATT_P", vo2.getString("ATT_P"));   	//�հ�(����������)
	hash.put("ATT_R", vo2.getString("ATT_R"));   	//�հ�(���Ŀ�����)
	hash.put("ATT_I", vo2.getString("ATT_I"));   	//�հ�(Ư��)
	hash.put("ATT_U", vo2.getString("ATT_T"));   	//�հ�(��ü�ް�)
	hash.put("ATT_F", vo2.getString("ATT_F"));   	//�հ�(����)
	hash.put("ATT_G", vo2.getString("ATT_G"));   	//�հ�(�Ʒ�)
	hash.put("ATT_AB", vo2.getString("ATT_AB"));     //�հ�(����+����)
	hash.put("ATT_K", vo2.getString("ATT_K"));   	//�հ�(����)
	hash.put("ATT_N", vo2.getString("ATT_N"));   	//�հ�(��������)
	hash.put("ATT_X", vo2.getString("ATT_X"));   	//�հ�(�������ް�)

	list.add(hash);
	long O_cnt = 0;
	long D_cnt = 0;
	long C_cnt = 0;
	String V_PRE_DPTNM = "";
    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
			hash = new HashMap();
			String DPT_NM = ""+vo.getString("DPT_NM");
			hash.put("UPDPT_NM", vo.getString("UPDPT_NM"));     //����
			hash.put("DPT_NM",   vo.getString("DPT_NM"));     //�μ�
			hash.put("CNT",      vo.getString("CNT"));     //�ο�
			hash.put("ATT_C", vo.getString("ATT_C"));   	//�հ�(����)
			hash.put("ATT_E", vo.getString("ATT_E"));   	//�հ�(����)
			hash.put("ATT_O", vo.getString("ATT_O"));   	//�հ�(�İ߱ٹ�)
			hash.put("ATT_H", vo.getString("ATT_H"));   	//�հ�(����)
			hash.put("ATT_P", vo.getString("ATT_P"));   	//�հ�(����������)
			hash.put("ATT_R", vo.getString("ATT_R"));   	//�հ�(���Ŀ�����)
			hash.put("ATT_I", vo.getString("ATT_I"));   	//�հ�(Ư��)
			hash.put("ATT_U", vo.getString("ATT_U"));   	//�հ�(��ü����)
			hash.put("ATT_F", vo.getString("ATT_F"));   	//�հ�(����)
			hash.put("ATT_G", vo.getString("ATT_G"));   	//�հ�(�Ʒ�)
			hash.put("ATT_AB",vo.getString("ATT_AB"));     //�հ�(����+����)
			hash.put("ATT_K", vo.getString("ATT_K"));   	//�հ�(����)
			hash.put("ATT_N", vo.getString("ATT_N"));   	//�հ�(��������)
			hash.put("ATT_X", vo.getString("ATT_X"));   	//�հ�(�������ް�)
			list.add(hash);
			if("O".equals(vo.getString("UPDPT_CD"))){
				if(!DPT_NM.equals(V_PRE_DPTNM)){
					O_cnt += Long.parseLong(vo.getString("CNT"));
				}
			}
			if("D".equals(vo.getString("UPDPT_CD"))){
				if(!DPT_NM.equals(V_PRE_DPTNM)){
					D_cnt += Long.parseLong(vo.getString("CNT"));
				}
			}
			if("C".equals(vo.getString("UPDPT_CD"))){
				if(!DPT_NM.equals(V_PRE_DPTNM)){
					C_cnt += Long.parseLong(vo.getString("CNT"));
				}
			}
			// IT���񽺺���
			if("O".equals(vo.getString("UPDPT_CD")) && "D".equals(vo.getString("NEXT_UPDPT_CD"))){
				hash = new HashMap();
				hash.put("UPDPT_NM", vo3.getString("UPDPT_NM"));     //����
				hash.put("DPT_NM",   vo3.getString("DPT_NM"));     //�μ�
				hash.put("CNT",      O_cnt+"");//vo3.getString("CNT"));     //�ο�
				hash.put("ATT_C", vo3.getString("ATT_C"));   	//�հ�(����)
				hash.put("ATT_E", vo3.getString("ATT_E"));   	//�հ�(����)
				hash.put("ATT_O", vo3.getString("ATT_O"));   	//�հ�(�İ߱ٹ�)
				hash.put("ATT_H", vo3.getString("ATT_H"));   	//�հ�(����)
				hash.put("ATT_P", vo3.getString("ATT_P"));   	//�հ�(����������)
				hash.put("ATT_R", vo3.getString("ATT_R"));   	//�հ�(���Ŀ�����)
				hash.put("ATT_I", vo3.getString("ATT_I"));   	//�հ�(Ư��)
				hash.put("ATT_U", vo3.getString("ATT_U"));   	//�հ�(��ü����)
				hash.put("ATT_F", vo3.getString("ATT_F"));   	//�հ�(����)
				hash.put("ATT_G", vo3.getString("ATT_G"));   	//�հ�(�Ʒ�)
				hash.put("ATT_AB",vo3.getString("ATT_AB"));     //�հ�(����+����)
				hash.put("ATT_K", vo3.getString("ATT_K"));   	//�հ�(����)
				hash.put("ATT_N", vo3.getString("ATT_N"));   	//�հ�(��������)
				hash.put("ATT_X", vo3.getString("ATT_X"));   	//�հ�(�������ް�)
				list.add(hash);
			}
			// SI�����
			if("D".equals(vo.getString("UPDPT_CD")) && "C".equals(vo.getString("NEXT_UPDPT_CD"))){
				hash = new HashMap();
				hash.put("UPDPT_NM", vo4.getString("UPDPT_NM"));     //����
				hash.put("DPT_NM",   vo4.getString("DPT_NM"));     //�μ�
				hash.put("CNT",      D_cnt+"");//vo4.getString("CNT"));     //�ο�
				hash.put("ATT_C", vo4.getString("ATT_C"));   	//�հ�(����)
				hash.put("ATT_E", vo4.getString("ATT_E"));   	//�հ�(����)
				hash.put("ATT_O", vo4.getString("ATT_O"));   	//�հ�(�İ߱ٹ�)
				hash.put("ATT_H", vo4.getString("ATT_H"));   	//�հ�(����)
				hash.put("ATT_P", vo4.getString("ATT_P"));   	//�հ�(����������)
				hash.put("ATT_R", vo4.getString("ATT_R"));   	//�հ�(���Ŀ�����)
				hash.put("ATT_I", vo4.getString("ATT_I"));   	//�հ�(Ư��)
				hash.put("ATT_U", vo4.getString("ATT_U"));   	//�հ�(��ü����)
				hash.put("ATT_F", vo4.getString("ATT_F"));   	//�հ�(����)
				hash.put("ATT_G", vo4.getString("ATT_G"));   	//�հ�(�Ʒ�)
				hash.put("ATT_AB",vo4.getString("ATT_AB"));     //�հ�(����+����)
				hash.put("ATT_K", vo4.getString("ATT_K"));   	//�հ�(����)
				hash.put("ATT_N", vo4.getString("ATT_N"));   	//�հ�(��������)
				hash.put("ATT_X", vo4.getString("ATT_X"));   	//�հ�(�������ް�)
				list.add(hash);
			}
			// �濵������
			if("C".equals(vo.getString("UPDPT_CD")) && "".equals(vo.getString("NEXT_UPDPT_CD"))){
				hash = new HashMap();
				hash.put("UPDPT_NM", vo5.getString("UPDPT_NM"));     //����
				hash.put("DPT_NM",   vo5.getString("DPT_NM"));     //�μ�
				hash.put("CNT",      C_cnt+"");//vo5.getString("CNT"));     //�ο�
				hash.put("ATT_C", vo5.getString("ATT_C"));   	//�հ�(����)
				hash.put("ATT_E", vo5.getString("ATT_E"));   	//�հ�(����)
				hash.put("ATT_O", vo5.getString("ATT_O"));   	//�հ�(�İ߱ٹ�)
				hash.put("ATT_H", vo5.getString("ATT_H"));   	//�հ�(����)
				hash.put("ATT_P", vo5.getString("ATT_P"));   	//�հ�(����������)
				hash.put("ATT_R", vo5.getString("ATT_R"));   	//�հ�(���Ŀ�����)
				hash.put("ATT_I", vo5.getString("ATT_I"));   	//�հ�(Ư��)
				hash.put("ATT_U", vo5.getString("ATT_U"));   	//�հ�(��ü����)
				hash.put("ATT_F", vo5.getString("ATT_F"));   	//�հ�(����)
				hash.put("ATT_G", vo5.getString("ATT_G"));   	//�հ�(�Ʒ�)
				hash.put("ATT_AB",vo5.getString("ATT_AB"));     //�հ�(����+����)
				hash.put("ATT_K", vo5.getString("ATT_K"));   	//�հ�(����)
				hash.put("ATT_N", vo5.getString("ATT_N"));   	//�հ�(��������)
				hash.put("ATT_X", vo5.getString("ATT_X"));   	//�հ�(�������ް�)
				list.add(hash);
			}
			V_PRE_DPTNM = DPT_NM;
		}
    }
	String pre_updptnm = "";
	String pre_dptnm = "";
	for(int i = 0; i < list.size(); i++){
		HashMap map = (HashMap)list.get(i);
		//�Ѱ�
		String UPDPT_NM = ""+map.get("UPDPT_NM");
		if(pre_updptnm.equals(UPDPT_NM)){
			hnwExtQuery.AddData("");     //����
		}else{
			hnwExtQuery.AddData(UPDPT_NM);     //����
		}
		//�Ұ�
		String DPT_NM = ""+map.get("DPT_NM");
		if(pre_dptnm.equals(DPT_NM)){
			hnwExtQuery.AddData("");     //�μ�
			if(i==0){
				hnwExtQuery.AddData(""+map.get("CNT"));//�ο�
			}else{
				hnwExtQuery.AddData("");     //�ο�
			}
		}else{
			hnwExtQuery.AddData(DPT_NM);     //�μ�
			hnwExtQuery.AddData(""+map.get("CNT"));//�ο�
		}
		//hnwExtQuery.AddData(""+map.get("UPDPT_NM"));     //����
		//hnwExtQuery.AddData(""+map.get("DPT_NM"));     //�μ�
		//hnwExtQuery.AddData(""+map.get("CNT"));     //�ο�
		hnwExtQuery.AddData(""+map.get("ATT_C"));   	//�հ�(����)
		hnwExtQuery.AddData(""+map.get("ATT_E"));   	//�հ�(����)
		hnwExtQuery.AddData(""+map.get("ATT_O"));   	//�հ�(�İ߱ٹ�)
		hnwExtQuery.AddData(""+map.get("ATT_H"));   	//�հ�(����)
		hnwExtQuery.AddData(""+map.get("ATT_P"));   	//�հ�(����������)
		hnwExtQuery.AddData(""+map.get("ATT_R"));   	//�հ�(���Ŀ�����)
		hnwExtQuery.AddData(""+map.get("ATT_I"));   	//�հ�(Ư��)
		hnwExtQuery.AddData(""+map.get("ATT_U"));   	//�հ�(��ü����)
		hnwExtQuery.AddData(""+map.get("ATT_F"));   	//�հ�(����)
		hnwExtQuery.AddData(""+map.get("ATT_G"));   	//�հ�(�Ʒ�)
		hnwExtQuery.AddData(""+map.get("ATT_AB"));     //�հ�(����+����)
		hnwExtQuery.AddData(""+map.get("ATT_K"));   	//�հ�(����)
		hnwExtQuery.AddData(""+map.get("ATT_N"));   	//�հ�(��������)
		hnwExtQuery.AddData(""+map.get("ATT_X"));   	//�հ�(�������ް�)
		pre_updptnm = UPDPT_NM;
		pre_dptnm = DPT_NM;
		hnwExtQuery.SendData(response);

	}

%>