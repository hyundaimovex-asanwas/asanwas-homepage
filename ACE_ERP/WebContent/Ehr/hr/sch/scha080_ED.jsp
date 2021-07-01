<!--
***********************************************************************
* @source      : scha080_ED.jsp
* @description : ���ڱ� ���� ��Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/13      �漮ȣ        �����ۼ�.
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

	String SORT_GBN     = request.getParameter("SORT_GBN");
	String STR_YM     = request.getParameter("STR_YM");
	String END_YM     = request.getParameter("END_YM");
	String OCC_CD     = request.getParameter("OCC_CD");



	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("sch", "SCHA080_SHR");

	/** ��ȸ ����(��������)�� ���� ó�� **/
	StringBuffer sb = new StringBuffer();
	if ( SORT_GBN.equals("1") ) {
		sb.append("ORDER BY  B.JOB_SEQ\n");
	}else if ( SORT_GBN.equals("2") ){
		sb.append("ORDER BY  A.FSCH_CD\n");
	}else if ( SORT_GBN.equals("3") ){
		sb.append("ORDER BY  A.PIS_YY, A.PIS_MM\n");
	}else{
		sb.append("");
	}
	 System.out.println(SORT_GBN);
	 System.out.println(sb.toString());
	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			"01",
			OCC_CD,
			STR_YM.replaceAll("-", ""),
			END_YM.replaceAll("-", ""),
	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** �ʵ尪 ���� **/

	String 	colStr  = "" ;

    if ( SORT_GBN.equals("1") ) {
		colStr  =   "JOB_SEQ,ENO_NO,ENO_NM,HIR_YMD,JOB_NM,DPT_NM,SEL_NM,FSCH_CD,FSCH_NM,RET_AMT,EDU_AMT,END_AMT,SCO_AMT,OTH_AMT,TOT_AMT,GUBUN,PIS_YM,SORTING";
    }else if ( SORT_GBN.equals("2") ){
    	colStr  =   "GUBUN,JOB_SEQ,ENO_NO,ENO_NM,HIR_YMD,JOB_NM,DPT_NM,SEL_NM,FSCH_CD,FSCH_NM,RET_AMT,EDU_AMT,END_AMT,SCO_AMT,OTH_AMT,TOT_AMT,PIS_YM,SORTING";
    }else if ( SORT_GBN.equals("3") ){
    	colStr  =   "PIS_YM,JOB_SEQ,ENO_NO,ENO_NM,HIR_YMD,JOB_NM,DPT_NM,SEL_NM,FSCH_CD,FSCH_NM,RET_AMT,EDU_AMT,END_AMT,SCO_AMT,OTH_AMT,TOT_AMT,GUBUN,SORTING";
    }
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