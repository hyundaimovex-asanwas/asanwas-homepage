<!--
***********************************************************************
* @source      : .jsp
* @description : ���ڱݽ�û�� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/12/28      ������        �����ۼ�.
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

    String print_no = request.getParameter("PRINT_NO");      // �����ȣ
	//print_no = "2009O20001";

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_02");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
            print_no
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("�ڳ༺��");
    hnwExtQuery.AddField("�ֹε�Ϲ�ȣ");
    hnwExtQuery.AddField("�б�");
    hnwExtQuery.AddField("�г�");
    hnwExtQuery.AddField("�������ڱ�");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0) 
    {
        for (int i=0; i<voList.size(); i++) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
			hnwExtQuery.AddData(vo.getString("UPDPT_NM"));     //����
			hnwExtQuery.AddData(vo.getString("DPT_NM"));		//�μ�
			hnwExtQuery.AddData(vo.getString("JOB_NM"));   	//����
			hnwExtQuery.AddData(vo.getString("ENO_NM"));   	//����
			hnwExtQuery.AddData(vo.getString("MF_TAG_NM"));   	//��
			hnwExtQuery.AddData(vo.getString("SEL_NM"));   	//����
			hnwExtQuery.AddData(vo.getString("BIR_YMD"));   	//�ֹε�Ϲ�ȣ
			hnwExtQuery.AddData(vo.getString("SCH_NM"));   	//�б�
			hnwExtQuery.AddData(vo.getString("FSCH_NM"));   	//�г�
			hnwExtQuery.AddData(vo.getString("TOT_AMT"));   	//�������ڱ�
            hnwExtQuery.SendData(response);				
		}
    }

%>