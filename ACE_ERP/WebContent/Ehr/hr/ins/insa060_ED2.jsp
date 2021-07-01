<!--
***********************************************************************
* @source      : insa060_ED2.jsp
* @description : ���ο��ݽŰ����� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/08      ���м�        �����ۼ�.
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

    String str_ymd = request.getParameter("str_ymd").replaceAll("-", "");
    String end_ymd = request.getParameter("end_ymd").replaceAll("-", "");
    String occ_cd = request.getParameter("occ_cd");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("ins", "INSA060_SHR_02");

    StringBuffer sb = new StringBuffer();

    /** ��ȸ ���ǿ� ���� ó�� **/
    sb.append("AND TO_CHAR(RET_YMD,'YYYYMMDD') >= '"+str_ymd+"' \n");
    sb.append("AND TO_CHAR(RET_YMD,'YYYYMMDD') <= '"+end_ymd+"' \n");

    if( ! occ_cd.equals("0") ){
        sb.append("AND OCC_CD = '"+occ_cd+"' \n");
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
            sb.toString()
    };


    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

   /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    String 	colStr  =   "NUM,ENO_NO,ENO_NM,CET_NO,JOB_NM,DPT_NM,RET_YMD,HIR_YMD";
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