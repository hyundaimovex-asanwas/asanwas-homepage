<!--
***********************************************************************
* @source      : aida010_ED.jsp
* @description : ���������� ��û��
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      �漮ȣ        �����ۼ�.
* 2007/05/08      ���м�
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

    String REQ_NO  = request.getParameter("REQ_NO");


	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_PRINT");
	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			REQ_NO
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("NO");
    hnwExtQuery.AddField("��û����");
    hnwExtQuery.AddField("�߻���");
    hnwExtQuery.AddField("����ڼ���");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�հ�");

    hnwExtQuery.AddField("��û��ȣ");
    hnwExtQuery.AddField("�߻�����");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("��û��");
    hnwExtQuery.AddField("��û����(select)");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("�ټӳ�");
    hnwExtQuery.AddField("�ټӿ�");
    hnwExtQuery.AddField("�����(select)");
    hnwExtQuery.AddField("���¹�ȣ");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("������ȣ");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("��û������");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("����");


    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;
    int k = 0;
    int row_size = 0;
    row_size = 7 - (voList.size()%7);
    if ( row_size == 7 ) row_size = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("AID_CD"));
            hnwExtQuery.AddData(vo.getString("AID_YMD"));
            hnwExtQuery.AddData(vo.getString("AID_NM"));
            hnwExtQuery.AddData(vo.getString("HLP2_AMT"));
            hnwExtQuery.AddData(vo.getString("HLP1_AMT"));
            hnwExtQuery.AddData(Integer.toString(Integer.parseInt(vo.getString("HLP2_AMT")) + Integer.parseInt(vo.getString("HLP1_AMT"))));

            hnwExtQuery.AddData(vo.getString("REQ_NO"));
            hnwExtQuery.AddData(vo.getString("AID_YMD"));
            hnwExtQuery.AddData(vo.getString("REP_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("AID_CD"));
            hnwExtQuery.AddData(vo.getString("AID_NM"));
            hnwExtQuery.AddData(vo.getString("LSE_YY"));
            hnwExtQuery.AddData(vo.getString("LSE_MM"));
            hnwExtQuery.AddData(vo.getString("ABA_CD"));
            hnwExtQuery.AddData(vo.getString("ACC_NO"));
            hnwExtQuery.AddData(vo.getString("REC_NAM"));
            hnwExtQuery.AddData(vo.getString("WORK_NO1"));
            hnwExtQuery.AddData(vo.getString("HLP1_AMT"));
            hnwExtQuery.AddData(vo.getString("HLP2_AMT"));
            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("ABA_NM"));
            hnwExtQuery.AddData(vo.getString("OCC_CD"));

            hnwExtQuery.SendData(response);
        }

    }


%>