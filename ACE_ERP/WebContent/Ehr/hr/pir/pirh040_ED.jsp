<!--
***********************************************************************
* @source      : idta020_ED.jsp
* @description : �����߱�ó��
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
	String HIR_YMD_SHR     = request.getParameter("HIR_YMD_SHR");
	String OCC_CD_SHR     = request.getParameter("OCC_CD_SHR");
	String GBN_CD_SHR     = request.getParameter("GBN_CD_SHR");
	String FLAG_SHR     = request.getParameter("FLAG_SHR");
	String HIR_SHR_01     = request.getParameter("HIR_SHR_01").replaceAll("-","");
	String HIR_SHR_02     = request.getParameter("HIR_SHR_02").replaceAll("-","");

	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("pir", "PIRH040_PRT");



	StringBuffer sb = new StringBuffer();

	/** ��ȸ ���ǿ� ���� ó�� **/
	if( ! OCC_CD_SHR.equals("0") ){
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}
	if( ! GBN_CD_SHR.equals("0") ){
		if( GBN_CD_SHR.equals("1") ){
			sb.append("AND GBN_CD  = '1' \n"); // ���� ��
		}else{
			sb.append("AND GBN_CD != '1' \n"); // ����(1) �� �ƴ� ���
		}
	}

	String stYMD = "";
	String enYMD = "";
	if( (! HIR_SHR_01.equals("") && ! HIR_SHR_01.equals("0")) && (! HIR_SHR_02.equals("") && ! HIR_SHR_02.equals("0")) ){
		stYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_01)+HIR_YMD_SHR.substring(4);
		enYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_02)+HIR_YMD_SHR.substring(4);
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') <= '"+stYMD.replaceAll("-","")+"' \n");
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') >= '"+enYMD.replaceAll("-","")+"' \n");
	}else if( (! HIR_SHR_01.equals("") && ! HIR_SHR_01.equals("0")) && (HIR_SHR_02.equals("") || HIR_SHR_02.equals("0")) ){
		stYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_01)+HIR_YMD_SHR.substring(4);
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') <= '"+stYMD.replaceAll("-","")+"' \n");
	}else if( (HIR_SHR_01.equals("") || HIR_SHR_01.equals("0")) && ( ! HIR_SHR_02.equals("") && ! HIR_SHR_02.equals("0")) ){
		enYMD = Integer.parseInt(HIR_YMD_SHR.substring(0,4))-Integer.parseInt(HIR_SHR_02)+HIR_YMD_SHR.substring(4);
		sb.append("AND TO_CHAR(A."+FLAG_SHR+"_YMD,'YYYYMMDD') >= '"+enYMD.replaceAll("-","")+"' \n");
	}

	if( FLAG_SHR.equals("HIR") ){
		sb.append("AND HIR_YMD IS NOT NULL \n");
	}else{
		sb.append("AND HIRG_YMD IS NOT NULL \n");
	}

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			HIR_YMD_SHR,
	};

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
		sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);
    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����");
     hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("�̸�");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("������");

    hnwExtQuery.AddField("�����з�");
    hnwExtQuery.AddField("����Ի���");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�ټӳ��");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

           hnwExtQuery.AddData(vo.getString("JOB_NM"));
             hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("GUR_YMD"));

            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
            hnwExtQuery.AddData(vo.getString("DMONTH"));


            hnwExtQuery.SendData(response);
        }
    }
%>