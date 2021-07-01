<!--
***********************************************************************
* @source      : wela030_ED.jsp
* @description : ���ֺ� ���� ��Ȳ
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
<%@page import="common.util.JSPUtil" %>

<%
	String STR_YMD     = request.getParameter("STR_YMD").replaceAll("-", "");
	String END_YMD     = request.getParameter("END_YMD").replaceAll("-", "");
	String DPT_CD      = request.getParameter("DPT_CD").replaceAll("null","");
	String ENO_NO      = request.getParameter("ENO_NO").replaceAll("null","");

	/** �ܺ� XML���� ���ε�� (��ȸ) SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("wel", "WELA030_PRT");

	/** ��ȸ ����(�������)�� ���� ó�� #1 **/
	StringBuffer sb = new StringBuffer();
	if (!STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND MOVE_YMD >= '"+STR_YMD+"' \n");
		sb.append("AND MOVE_YMD <= '"+END_YMD+"' \n");
	} else if (!STR_YMD.equals("") && END_YMD.equals("")) {
		sb.append("AND MOVE_YMD >= '"+STR_YMD+"' \n");
	} else if (STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND MOVE_YMD <= '"+END_YMD+"' \n");
	} else {
		sb.append("");
	}



	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString(),
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** �˻� ���� Mapping(PrepareStatement ) **/
	Object[] bind = new Object[] {
			DPT_CD,
			ENO_NO
	};


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
	String 	colStr  =   "MOVE_YEAR,ORD_NO,ENO_NO,DPT_NM,JOB_NM,ENO_NM,RADR,RADR_CT,RZI_NO,MADR,MADR_CT,MZI_NO,MOVE_YMD,COM_PHN_NO,HOM_PHN_NO,EM_PHN_NO,APP_YMD,APP_CD,ARROW,RAREA,MAREA,MOVE_AMT,RPLACE,MPLACE";
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