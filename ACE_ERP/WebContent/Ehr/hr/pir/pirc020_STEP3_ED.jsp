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
    String pis_yymm  = request.getParameter("pis_yy") + request.getParameter("pis_mm");
    String seq  = request.getParameter("seq");

    String sql = null;
    StringBuffer sb = new StringBuffer();
    
    /** DynamicSQL�� �����ϴ� �κ� [1] **/
    if (eno_no.equals("2040038")){
		sb.append(" UNION SELECT '���̵帲' AS BNK_NM, '���ѻ���' AS COMM_NM,'����' AS GUBUN, '2014-06-30' AS DUE_YMD, 0 AS PYM_AMT, 120 AS PIN_CNT, 8716500 AS SUM_PYM, 0 AS GMK_AMT, 0 AS GMK_BAK  FROM DUAL  ");
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
            sb.toString()
    };    
    
    sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_03");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
	Object[] bind = null;
  	bind = new Object[] {
  		  pis_yy,
   	  	  pis_mm,
   	  	  sal_gbn,
   	  	  seq,
   	  	  eno_no,
   	      pis_yymm,
   	  	  seq,
   	      sal_gbn,
  		  eno_no,
  		  pis_yymm,
    	  eno_no,
  		  eno_no,
  		  pis_yymm,
  	      eno_no,
		  eno_no,
		  pis_yymm
 	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("������Ծ�");

    hnwExtQuery.AddField("Ƚ��");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("������ܾ�");

    hnwExtQuery.SendField(response);



    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("BNK_NM"));
            hnwExtQuery.AddData(vo.getString("SAV_NM"));
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("DUE_YMD"));
            hnwExtQuery.AddData(vo.getString("CONM_AMT"));

            hnwExtQuery.AddData(vo.getString("SUMP_CNT"));
            hnwExtQuery.AddData(vo.getString("SUM_SAV"));
            hnwExtQuery.AddData(vo.getString("GMK_BAK"));
            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);

%>