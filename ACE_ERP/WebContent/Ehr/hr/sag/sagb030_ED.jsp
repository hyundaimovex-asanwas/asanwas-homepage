<!--
***********************************************************************
* @source      : sagb030_ED.jsp
* @description : �������ҹװ���
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
	String PIS_YM = request.getParameter("PIS_YM");
	String OCC_CD 	= request.getParameter("OCC_CD");
	String SAL_GBN  	= request.getParameter("SAL_GBN");
	String BON_NUM 		= request.getParameter("BON_NUM");
	String SAL_CD 	= request.getParameter("SAL_CD");
	String AD_TAG  	= request.getParameter("AD_TAG");
	String IPT_MAN 		= request.getParameter("IPT_MAN");

	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("sag", "SAGB030_SHR");

	/** ��ȸ ����(���/��)�� ���� ó�� #1 **/
	StringBuffer sb = new StringBuffer();

		sb.append("SELECT A.ENO_NO, A.SAL_CD, A.AMOUNT, A.REMARK,");
		sb.append("                   B.ENO_NM, B.DPT_NM, B.JOB_NM, \n");
		sb.append("                   B.DPT_CD, B.JOB_CD, SF_GET_COMMNAME('01', 'U4', A.SAL_CD) AS SAL_CONTENT\n");
		sb.append("            FROM   T_CP_CHANGE A,\n");
		sb.append("                   VI_T_CM_PERSON2 B\n");
		sb.append("            WHERE  A.PIS_YY = '"+PIS_YM.substring(0, 4)+"'\n");
		sb.append("            AND    A.PIS_MM = '"+PIS_YM.substring(5, 7)+"'\n");
		sb.append("            AND    A.OCC_CD LIKE '%"+OCC_CD+"%'\n");
		sb.append("            AND    A.SAL_GBN = '"+SAL_GBN+"'\n");
		sb.append("            AND    A.BON_NUM = '"+BON_NUM+"'\n");
		sb.append("            AND    A.SAL_CD LIKE '%"+SAL_CD+"%'\n");
		sb.append("            AND    A.AD_TAG LIKE '%"+AD_TAG+"%'\n");
		sb.append("            AND    A.IPT_MAN LIKE '%"+IPT_MAN+"%'\n");
		sb.append("            AND    A.ENO_NO = B.ENO_NO\n");
		sb.append("            ORDER BY B.HEAD_SEQ, B.DPT_SEQ, B.JOB_SEQ, B.HOB_SEQ DESC, B.HIRG_YMD, A.ENO_NO, A.SEQ\n");

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb.toString()
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
   	String 	colStr  =   "NO , NO2 , ENO_NO,DPT_NM,DPT_CD,SAL_CD,AMOUNT,REMARK,ENO_NM,JOB_NM,JOB_CD,SAL_CONTENT";
   	String[] values = colStr.split(",");
   	for( int x = 0; x < values.length; x++ ){
   		hnwExtQuery.AddField(values[x]);
   	}
    hnwExtQuery.SendField(response);

    ////////////////////
 //
 //   if (voList.size() > 0)
 //   {
 //       for (int i=0; i<voList.size(); i++)
 //       {
 //           DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//
  //      	for( int x = 0; x < values.length; x++ ){
    //            hnwExtQuery.AddData(vo.getString(values[x]));
      //  	}
       //     hnwExtQuery.SendData(response);
       // }
//    }
//    else
//    {
//    	// hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
  //  	for( int x = 0; x < values.length; x++ ){
//            hnwExtQuery.AddData("");
 //   	}
  //      hnwExtQuery.SendData(response);

//    }
 
    //////////NO , NO2 , ENO_NO,DPT_NM,DPT_CD,SAL_CD,AMOUNT,REMARK,ENO_NM,JOB_NM,JOB_CD,SAL_CONTENT
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
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("SAL_CD"));
            hnwExtQuery.AddData(vo.getString("AMOUNT"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("SAL_CONTENT"));

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

        hnwExtQuery.SendData(response);
    }
    ///////////

%>
