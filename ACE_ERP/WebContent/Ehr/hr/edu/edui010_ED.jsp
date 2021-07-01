<!--
***********************************************************************
* @source      : edui010_ED.jsp
* @description : ������Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     �漮ȣ        �����ۼ�.
* 2007/05/09     ���м�        ����.
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
	String STR_YMD_SHR	= request.getParameter("STR_YMD_SHR").replaceAll("-", "");
	String END_YMD_SHR  = request.getParameter("END_YMD_SHR").replaceAll("-", "");
	
    String OCC_CD_SHR   = request.getParameter("OCC_CD_SHR");

	String GBN_CD       = request.getParameter("GBN_CD");
	String DPT_CD_SHR   = request.getParameter("DPT_CD_SHR");
    String EDU_CD_SHR   = request.getParameter("EDU_CD_SHR");
    String JOB_CD_SHR   = request.getParameter("JOB_CD_SHR");

    String sort1 = "";
    String sort2 = "";

	/** ��ȸ ���ǿ� ���� ó�� **/


    if ( !EDU_CD_SHR.equals("") ) {
	    sort1 = "AND A.SBJ_CD = '"+ EDU_CD_SHR + "'";
    }


	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("edu", "EDUI010_SHR");
        

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			STR_YMD_SHR,
			END_YMD_SHR,
            OCC_CD_SHR,
            DPT_CD_SHR,
            JOB_CD_SHR,
            
	};

	StringBuffer sb = new StringBuffer();

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
        sort1
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�����Ⱓ");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("����ó");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("���Ῡ��");
    hnwExtQuery.AddField("�̼�����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("���");

    hnwExtQuery.SendField(response);

    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("YMD_VAL"));
            hnwExtQuery.AddData(vo.getString("PLACE_CD"));
            hnwExtQuery.AddData(vo.getString("INT_NAM"));
            hnwExtQuery.AddData(vo.getString("EDU_NM"));
            hnwExtQuery.AddData(vo.getString("EDU_TAG"));
            hnwExtQuery.AddData(vo.getString("CPT_NO"));
            hnwExtQuery.AddData(vo.getString("APP_VAL"));
            hnwExtQuery.AddData(vo.getString("EDU_AMT"));
            hnwExtQuery.AddData(vo.getString("REMARK"));

            hnwExtQuery.SendData(response);
        }
    }
        hnwExtQuery.EndData(response);

%>
