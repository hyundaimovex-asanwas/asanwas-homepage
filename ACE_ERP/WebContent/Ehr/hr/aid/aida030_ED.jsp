<!--
***********************************************************************
* @source      : aida010_ED.jsp
* @description : ���������� ��û��
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      �漮ȣ        �����ۼ�.
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



	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("aid", "AIDA030_SHR");

	String SPL_YMD_STDT_SHR = request.getParameter("SPL_YMD_STDT_SHR").replaceAll("-", "");
	String SPL_YMD_ENDT_SHR = request.getParameter("SPL_YMD_ENDT_SHR").replaceAll("-", "");
	String CEF_SEC_SHR = request.getParameter("CEF_SEC_SHR"); // ��ȸ����(��,����)
	String OCC_CD_SHR = request.getParameter("OCC_CD_SHR");   // ������
	String JOB_CD_SHR = request.getParameter("JOB_CD_SHR");   // ������
	String DPT_CD_SHR = request.getParameter("DPT_CD_SHR");   // �ҼӺ�
	String AID_CD_SHR = request.getParameter("AID_CD_SHR");   // ��û���뺰
	String ORDER_TYPE = request.getParameter("ORDER_TYPE");   // ��û���뺰

	/** ��ȸ ����(��������)�� ���� ó�� **/
	StringBuffer sb = new StringBuffer();
	if (!SPL_YMD_STDT_SHR.equals("") && !SPL_YMD_ENDT_SHR.equals("")) {
		sb.append("SPL_YMD >= '"+SPL_YMD_STDT_SHR+"' \n");
		sb.append("AND SPL_YMD <= '"+SPL_YMD_ENDT_SHR+"' \n");
	} else if (!SPL_YMD_STDT_SHR.equals("") && SPL_YMD_ENDT_SHR.equals("")) {
		sb.append("SPL_YMD >= '"+SPL_YMD_STDT_SHR+"' \n");
	} else if (SPL_YMD_STDT_SHR.equals("") && !SPL_YMD_ENDT_SHR.equals("")) {
		sb.append("SPL_YMD <= '"+SPL_YMD_ENDT_SHR+"' \n");
	} else {
		sb.append("1=1 \n");
	}

	/** ��ȸ ����(��ȸ����, ����, ����, �Ҽ�, ��û����)�� ���� ó�� **/
	if( CEF_SEC_SHR.equals("1") ){ // �����ݸ� ���� ���� �͸�
		sb.append("AND HLP1_AMT IS NULL AND HLP2_AMT IS NOT NULL \n");
	}
	if( CEF_SEC_SHR.equals("2") ){
		sb.append("AND HLP1_AMT IS NOT NULL AND HLP2_AMT IS NULL \n");
	}
	if( ! OCC_CD_SHR.equals("0") ){ //������
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}
	if( ! JOB_CD_SHR.equals("") ){ //������
		sb.append("AND JOB_CD = '"+JOB_CD_SHR+"' \n");
	}
	if( ! DPT_CD_SHR.equals("") ){ //�ҼӺ�
		sb.append("AND DPT_CD = '"+DPT_CD_SHR+"' \n");
	}
	if( ! AID_CD_SHR.equals("") ){ //��û���뺰
		sb.append("AND AID_CD = '"+AID_CD_SHR+"' \n");
	}

	StringBuffer sb2 = new StringBuffer();
    //0,������  1,������  2,�ҼӺ�,  3.��û���뺰
    if(       ORDER_TYPE.equals("")) {
        sb2.append("A.SPL_YMD");
    } else if(ORDER_TYPE.equals("0")) {
        sb2.append("A.OCC_CD");
    } else if(ORDER_TYPE.equals("1")) {
        sb2.append("SF_GET_COMMSEQ('01', 'A2', A.JOB_CD)");
    } else if(ORDER_TYPE.equals("2")) {
        sb2.append("SF_GET_DPTSEQ('01', 'A4', A.DPT_CD)");
    } else if(ORDER_TYPE.equals("3")) {
        sb2.append("A.AID_CD");
    }



	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString(),
			sb2.toString()

	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                CEF_SEC_SHR,
                CEF_SEC_SHR
        };


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
	String 	colStr  =   "ENO_NM,OCC_NM,DPT_NM,JOB_NM,AID_NM,AID_YMD,HLP1_AMT,HLP2_AMT,SPL_YMD";
	String[] values = colStr.split(",");

	for( int x = 0; x < values.length; x++ ){
		hnwExtQuery.AddField(values[x]);
	}
    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

        	for( int x = 0; x < values.length; x++ ){
                hnwExtQuery.AddData(vo.getString(values[x]));
        	}
            hnwExtQuery.SendData(response);
        }
    }
    else
    {
    	// hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
    	for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
    	}
        hnwExtQuery.SendData(response);

    }
%>