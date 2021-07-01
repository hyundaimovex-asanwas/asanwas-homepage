<!--
***********************************************************************
* @source         : saga040_ED.jsp 				                                                                                     *
* @description   : �޻�������Ȳ PAGE.
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


    String sql = "";
    String pis_y       = request.getParameter("PIS_YY_SHR");      // ����
    String pis_m       = request.getParameter("PIS_MM_SHR");      // ����
    String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");
    String SAL_GBN_SHR = request.getParameter("SAL_GBN_SHR");

    System.out.println("request ���� GBN_CD_SHR  = " + request.getParameter("GBN_CD_SHR") + " ==> " +  GBN_CD_SHR);
    System.out.println("request ���� SAL_GBN_SHR = " + request.getParameter("SAL_GBN_SHR") + " ==> " +  SAL_GBN_SHR);

    /** �ܺ� XML���� SQL�� �о� �´� **/
    sql = XmlSqlUtils.getSQL("sag", "SAGA040_SHR");

	/** ��/����  ���п� ���� ó�� **/
	StringBuffer sb = new StringBuffer();
	/** GBN_CD_SHR ="1"; **/
    if ( GBN_CD_SHR.equals("0") ) {
		 sb.append("AND A.DPT_CD NOT IN ('H2', 'H3', 'H4', 'H5', 'H6')");
      //   System.out.println("saga040_ED ����0 ���� [" + GBN_CD_SHR + "]");
      //   System.out.println(sql);
     } else if ( GBN_CD_SHR.equals("1") ) {
    	 sb.append("AND A.DPT_CD  IN ('H2', 'H3', 'H4', 'H5', 'H6')");
      //   System.out.println("saga040_ED ����1 �ؿ� [" + GBN_CD_SHR + "]");
      //   System.out.println(sql);
     } else {
    	 sb.append("AND 2=2");
      //   System.out.println("saga040_ED ����2 ��ü [" + GBN_CD_SHR + "]");
      //   System.out.println(sql);
     }


	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        pis_y, pis_m, SAL_GBN_SHR
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�⺻��");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�󿩱�");
    hnwExtQuery.AddField("��Ÿ����");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("��Ÿ����1");
    hnwExtQuery.AddField("��Ÿ����2");
    hnwExtQuery.AddField("�Ĵ�");
    hnwExtQuery.AddField("���޾װ�");
    hnwExtQuery.AddField("�ҵ漼");
    hnwExtQuery.AddField("�ֹμ�");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("�ǰ�����");
    hnwExtQuery.AddField("��뺸��");
    hnwExtQuery.AddField("����纸��");
    hnwExtQuery.AddField("����ȸ��");
    hnwExtQuery.AddField("���ο��ݰ���");
    hnwExtQuery.AddField("��Ÿ����1");
    hnwExtQuery.AddField("��Ÿ����2");
    hnwExtQuery.AddField("�����װ�");
    hnwExtQuery.AddField("�������޾�");
    hnwExtQuery.AddField("��ȸ������");
    hnwExtQuery.AddField("�����޾�");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("BAS_AMT"));		// �⺻��
            hnwExtQuery.AddData(vo.getString("LAW_AMT"));		// ��������
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));		// ��������
            hnwExtQuery.AddData(vo.getString("BNS_AMT"));		// �󿩱�
            hnwExtQuery.AddData(vo.getString("ETC_AMT"));		// ��Ÿ����(�����)
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));		// ���ο���
            hnwExtQuery.AddData(vo.getString("OTH_AMT"));		// ��Ÿ����  (���ڱ�, �̻�뿬��, �����ޱ޿�, ���������, ����)
            hnwExtQuery.AddData(vo.getString("HOL_AMT"));		// ��Ÿ����2 (���ϱٹ�����)
            hnwExtQuery.AddData(vo.getString("LUN_AMT"));		// �Ĵ�
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));		// ���޾װ�
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));		// �ҵ漼
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));		// �ֹμ�
            hnwExtQuery.AddData(vo.getString("ETC_AMT_JN"));	// ��������
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));		// ���ο���
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));		// �ǰ�����
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));		// ��뺸��
            hnwExtQuery.AddData(vo.getString("OLD_AMT"));		// ����纸��
            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));		// ����ȸ��
            hnwExtQuery.AddData(vo.getString("PPED_AMT"));		// ���ο���
            hnwExtQuery.AddData(vo.getString("OTHD_AMT"));	// ��Ÿ����1 (��ȣȸ��, ����� �ٷμҵ漼 ����, ���Ǳ� �� ���Ǳ� �޿�����, �޿� �ݳ�, �޿� ����, ���ڱ�, �������̼�)
            hnwExtQuery.AddData(vo.getString("ETC_AMT2"));	// ��Ÿ����2 (�����ε� ������
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));	// �����װ�
            hnwExtQuery.AddData(vo.getString("RL_AMT"));	// �������޾�
            hnwExtQuery.AddData(vo.getString("CONT_AMT"));	// ��ȸ������
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));	// �����޾�

			hnwExtQuery.SendData(response);
        }
    } else {
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
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>