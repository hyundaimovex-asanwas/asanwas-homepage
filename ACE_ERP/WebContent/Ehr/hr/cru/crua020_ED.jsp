<!--
***********************************************************************
* @source      : crua020_ED.jsp
* @description : �ο���
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      �漮ȣ        �����ۼ�.
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

	String REGYY     = request.getParameter("REGYY");
	String REGCH     = request.getParameter("REGCH");
	String REGSTR     = request.getParameter("REGSTR");
	String REGEND     = request.getParameter("REGEND");
	String SCHOOL     = request.getParameter("SCHOOL");
	String SPLITFLAG     = request.getParameter("SPLITFLAG");
	String PASSTAG     = request.getParameter("PASSTAG");


    String sql = null;
    sql = XmlSqlUtils.getSQL("cru", "CRUA020_PRT");
  	System.out.println(REGSTR);

	/** ��ȸ ����(��������)�� ���� ó�� **/
	StringBuffer sb = new StringBuffer();
	if ( !REGSTR.equals("") && !REGEND.equals("")) {
		sb.append("AND    A.REG_NO >= '"+REGSTR+"' \n");
		sb.append("AND    A.REG_NO <= '"+REGEND+"' \n");
	}else if ( !REGSTR.equals("") && REGEND.equals("") ){
		sb.append("AND    A.REG_NO >= '"+REGSTR+"' \n");
	}else if ( REGSTR.equals("") && !REGEND.equals("") ){
		sb.append("AND    A.REG_NO <= '"+REGEND+"' \n");
	}else{
		sb.append("");
	}

	StringBuffer sb2 = new StringBuffer();
	if ( SCHOOL.equals("1") ) {
		sb2.append("");
	}else if ( SCHOOL.equals("2") ){
		sb2.append("AND    ( C.UNAME1 IS NOT NULL OR C.GSNAME1 IS NOT NULL ) \n");
	}else if ( SCHOOL.equals("3") ){
		sb2.append("AND    ( C.UNAME1 IS NULL AND C.GSNAME1 IS NULL ) \n");
	}else{
		sb2.append("");
	}

	StringBuffer sb3 = new StringBuffer();
	if ( PASSTAG.equals("1") ) {
		sb3.append("");
	}else if ( PASSTAG.equals("2") ){
		sb3.append("AND    A.PASSTAG1 = 'Y' \n");
	}else if ( PASSTAG.equals("3") ){
		sb3.append("AND    A.PASSTAG2 = 'Y' \n");
	}else if ( PASSTAG.equals("4") ){
		sb3.append("AND    A.PASSTAG3 = 'Y' \n");
	}else if ( PASSTAG.equals("5") ){
		sb3.append("AND    A.PASSTAG4 = 'Y' \n");
	}

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString(),
			sb2.toString(),
			sb3.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			REGYY,
			REGCH,
			SPLITFLAG
	};

	 AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("REG_NO");
    hnwExtQuery.AddField("ENO_NM");
    hnwExtQuery.AddField("SEXGU");
    hnwExtQuery.AddField("BIRYMD");
    hnwExtQuery.AddField("ACPSTAT");

    hnwExtQuery.AddField("TOEICTOFEL");
    hnwExtQuery.AddField("SCH_YMD");
    hnwExtQuery.AddField("SCH_NM");
    hnwExtQuery.AddField("SCH_MAJOR");
    hnwExtQuery.AddField("SCH_GRDYN");

    hnwExtQuery.AddField("AVE");
    hnwExtQuery.AddField("TXT_WANT1");
    hnwExtQuery.AddField("TXT_WANT2");
    hnwExtQuery.AddField("TXT_WANT3");
    hnwExtQuery.AddField("LICENCE");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REG_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("SEXGU"));
            hnwExtQuery.AddData(vo.getString("BIRYMD"));
            hnwExtQuery.AddData(vo.getString("ACPSTAT"));

            hnwExtQuery.AddData(vo.getString("TOEICTOFEL"));
            hnwExtQuery.AddData(vo.getString("SCH_YMD"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("SCH_MAJOR"));

            hnwExtQuery.AddData(vo.getString("SCH_GRDYN"));
            hnwExtQuery.AddData(vo.getString("AVE"));
            hnwExtQuery.AddData(vo.getString("TXT_WANT1"));
            hnwExtQuery.AddData(vo.getString("TXT_WANT2"));
            hnwExtQuery.AddData(vo.getString("TXT_WANT3"));
            hnwExtQuery.AddData(vo.getString("LICENCE"));


            hnwExtQuery.SendData(response);
        }
    }
    else
    {
    	// hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
         for (int i=0;i<15;i++)
    	{
        	 hnwExtQuery.AddData("");

    	}
    	 hnwExtQuery.SendData(response);

    }
%>