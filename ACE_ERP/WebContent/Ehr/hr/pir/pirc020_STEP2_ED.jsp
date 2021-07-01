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
    sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_02");

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

    hnwExtQuery.AddField("���ټ�");
    hnwExtQuery.AddField("�ֹμ�");
    hnwExtQuery.AddField("�ǰ������");
    hnwExtQuery.AddField("����纸��");

    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("��뺸��");

    hnwExtQuery.AddField("����ȸ��");
    hnwExtQuery.AddField("���ο��ݰ���");
    hnwExtQuery.AddField("�����ȯ��");
    hnwExtQuery.AddField("�����ȯ����");
    hnwExtQuery.AddField("��Ÿ������");
    hnwExtQuery.AddField("��������");

    hnwExtQuery.AddField("������ȸ��");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�⿬��");
    hnwExtQuery.AddField("����ī��");

    hnwExtQuery.AddField("����ǰ�����");
    hnwExtQuery.AddField("�����ֹκ���");

    hnwExtQuery.AddField("��������ҵ漼");
    hnwExtQuery.AddField("���������ֹμ�");
    
    hnwExtQuery.AddField("���������Ư��");
    hnwExtQuery.AddField("1������");
    
    hnwExtQuery.AddField("�޿�����");
    hnwExtQuery.AddField("��ٹ���");    
    
    hnwExtQuery.AddField("�����޾�");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�Ǽ��ɾ�");


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

            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("OLD_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));

            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));
            hnwExtQuery.AddData(vo.getString("PPED_AMT"));
            hnwExtQuery.AddData(vo.getString("LON_RPY"));
            hnwExtQuery.AddData(vo.getString("LON_INT"));
            hnwExtQuery.AddData(vo.getString("OTHD_AMT_PRN"));
            hnwExtQuery.AddData(vo.getString("LAB_AMT"));

            hnwExtQuery.AddData(vo.getString("WOM_AMT"));
            hnwExtQuery.AddData(vo.getString("SAV_AMT"));
            hnwExtQuery.AddData(vo.getString("APP_AMT"));
            hnwExtQuery.AddData(vo.getString("WEL_POINT"));
            hnwExtQuery.AddData(vo.getString("DRE_INTX"));
            hnwExtQuery.AddData(vo.getString("DRE_CTTX"));
            
            hnwExtQuery.AddData(vo.getString("YC_INT"));
            hnwExtQuery.AddData(vo.getString("YC_CTT"));            
            
            hnwExtQuery.AddData(vo.getString("ETC_AMT_A6"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT_AF"));                 
            hnwExtQuery.AddData(vo.getString("ITXD_AMT"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT_A5"));        
            
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));

            //System.out.println("------------>"+hnwExtQuery.get_column_cnt());


            hnwExtQuery.SendData(response);
        }
    }

    hnwExtQuery.EndData(response);
%>