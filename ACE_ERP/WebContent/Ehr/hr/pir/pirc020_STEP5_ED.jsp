<!--
***********************************************************************
* @source      : guna100_STEP_ED.jsp
* @description : ���κ�����������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      �漮ȣ        �����ۼ�.
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




    /** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_05_PRINT");


  	Object[] bind = null;
  	bind = new Object[] {

  		  pis_yy,
   	  	  pis_mm,
   	  	  eno_no,
   	  	  pis_yy,
   	  	  pis_mm,
   	  	  sal_gbn,
   	  	  seq,
   	  	  pis_yy,
 	  	  pis_mm,
 	  	  pis_yy,
 	  	  pis_mm


  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�ҵ漼��");
    hnwExtQuery.AddField("���ټ���");
    hnwExtQuery.AddField("�ֹμ���");
    hnwExtQuery.AddField("�ǰ������");
    hnwExtQuery.AddField("���ο��ݰ�");
    hnwExtQuery.AddField("��뺸���");
    hnwExtQuery.AddField("���⵵ �������ޱ�");
    hnwExtQuery.AddField("���⵵ �����ܾ�");
    hnwExtQuery.AddField("���س⵵ �����ݰ�");


    hnwExtQuery.SendField(response);


    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("SAV_AMT"));
            hnwExtQuery.AddData(vo.getString("APP_AMT"));
            hnwExtQuery.AddData(vo.getString("INV_AMT"));

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);
%>