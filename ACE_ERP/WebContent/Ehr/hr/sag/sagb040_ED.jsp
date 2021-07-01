<!--
***********************************************************************
* @source      : saga080_2_ED.jsp
* @description : ���κ� ��������/���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      �漮ȣ        �����ۼ�.
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
	String GBN = request.getParameter("GBN");
	String ENO_NO 	= request.getParameter("ENO_NO");
	String SAL_CD  	= request.getParameter("SAL_CD");
	String END_YN 		= request.getParameter("END_YN");


	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("sag", "SAGB040_SHR");

	/** ��ȸ ����(�����ȣ/�޿��׸�)�� ���� ó�� #1 **/
	StringBuffer sb = new StringBuffer();
	if (GBN.equals("ENO_NO")) {
		sb.append("AND A.ENO_NO LIKE '%"+ENO_NO+"%'");
	}else if (GBN.equals("SAL_CD")) {
		sb.append("AND A.SAL_CD LIKE '%"+SAL_CD+"%'");
	}

	/** ��ȸ ����(�����ȣ/�޿��׸�)�� ���� ó�� #1 **/
	StringBuffer sb1 = new StringBuffer();
	if (END_YN.equals("Y")) {
		sb1.append("AND    A.END_YMD < TO_CHAR(TO_DATE(SYSDATE),'YYYYMMDD')");
	}else if (END_YN.equals("N")) {
		sb1.append("AND    ( A.END_YMD >= TO_CHAR(TO_DATE(SYSDATE),'YYYY-MM-DD') OR A.END_YMD IS NULL )");
	}

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString(),
			sb1.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {

	};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "NO , NO2 , ENO_NO,OCC_CD,SAL_CD,AD_TAG,AMOUNT,SAL_GBN,STR_YMD,END_YMD,ENO_NM,DPT_CD,DPT_NM,JOB_CD,JOB_NM,SAL_NM,AD_TAG_NM,SAL_CONTENT,OCC_NM";
   	String[] values = colStr.split(",");
   	for( int x = 0; x < values.length; x++ ){
   		hnwExtQuery.AddField(values[x]);
   	}
    hnwExtQuery.SendField(response);

//////////,,,,,,,,,,,,,,,";
    int i = 0;
    int k = 0;
    String pre_dpt_nm = "";

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if ( pre_dpt_nm.equals(vo.getString("ENO_NO")) ) {

                    hnwExtQuery.AddData(Integer.toString(k));
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(vo.getString("ENO_NO"));

            } else {
                k = k + 1;
                hnwExtQuery.AddData(Integer.toString(k));
                hnwExtQuery.AddData(Integer.toString(k));
                hnwExtQuery.AddData(vo.getString("ENO_NO"));
            }
            hnwExtQuery.AddData(vo.getString("OCC_CD"));
            hnwExtQuery.AddData(vo.getString("SAL_CD"));
            hnwExtQuery.AddData(vo.getString("AD_TAG"));
            hnwExtQuery.AddData(vo.getString("AMOUNT"));
            hnwExtQuery.AddData(vo.getString("SAL_GBN"));
            hnwExtQuery.AddData(vo.getString("STR_YMD"));
            hnwExtQuery.AddData(vo.getString("END_YMD"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("SAL_NM"));
            hnwExtQuery.AddData(vo.getString("AD_TAG_NM"));
            hnwExtQuery.AddData(vo.getString("SAL_CONTENT"));
            hnwExtQuery.AddData(vo.getString("OCC_NM"));

            hnwExtQuery.SendData(response);

            pre_dpt_nm = vo.getString("ENO_NO");
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
        hnwExtQuery.SendData(response);
    }
    ///////////

    /*
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
	*/


%>
