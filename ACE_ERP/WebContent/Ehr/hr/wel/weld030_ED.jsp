<!--
***********************************************************************
* @source      : weld030_ED.jsp
* @description : �ܵ���û����Ʈ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/17      �漮ȣ        �����ۼ�.
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
	String STR_YMD	= request.getParameter("STR_YMD");
	String END_YMD	= request.getParameter("END_YMD");
	String CN_CD     = request.getParameter("CN_CD").replaceAll("null","");
	String RSV_GBN	= request.getParameter("RSV_GBN");
	String RST_GBN	= request.getParameter("RST_GBN");
	String SEASON_GBN	= request.getParameter("SEASON_GBN").replaceAll("null","");




	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("wel", "WELD030_SHR");

	/** ��ȸ ����(�������)�� ���� ó�� #1 **/
	StringBuffer sb = new StringBuffer();
	if (!RST_GBN.equals("")) {
		sb.append("AND    A.RST_GBN LIKE '%'||'"+RST_GBN+"'||'%' \n");
	}
	/** ��ȸ ����(�������)�� ���� ó�� #2 **/
	if (!STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND    A.STR_YMD >= '"+STR_YMD.replaceAll("-", "")+"' \n");
		sb.append("AND    A.STR_YMD <= '"+END_YMD.replaceAll("-", "")+"' \n");
	} else if (!STR_YMD.equals("") && END_YMD.equals("")) {
		sb.append("AND    A.STR_YMD >= '"+STR_YMD.replaceAll("-", "")+"' \n");
	} else if (STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND    A.STR_YMD <= '"+END_YMD.replaceAll("-", "")+"' \n");
	}

	/** ��ȸ ����()�� ���� ó�� #3 **/
    //��ü ���ǿ����� ��û�� ����Ǹ� ������
    if(RSV_GBN.equals("13")) {
        sb.append("AND A.RSV_GBN IN ('1', '3')");
    } else {
        sb.append("AND A.RSV_GBN = NVL('"+RSV_GBN+"', A.RSV_GBN)");
    }


	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString()

	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			CN_CD,
			SEASON_GBN
	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/
	String 	colStr  =   "ENO_NO,STR_YMD,CN_CD,CN_NAME,CO_CD,STAY_CNT,ROOM_CNT,RSV_GBN,RSV_NO,RST_GBN,SEASON_GBN,DPT_NM,JOB_NM,ENO_NM,CO_NM,EXT_01,EXT_02,EXT_03,USE_CNT";
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