<!--
***********************************************************************
* @source      : taxA180_ED.jsp
* @description : 건강보험 개인별 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      방석호        최초작성.
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
String ENO_NO = request.getParameter("ENO_NO");
String PIS_YY = request.getParameter("PIS_YY");
String DPT_CD = request.getParameter("DPT_CD");
String IS_YEAR_AMT = request.getParameter("IS_YEAR_AMT");
String STR_YMD = request.getParameter("STR_YMD");


    String sql = XmlSqlUtils.getSQL("tax2", "TAXB180_2007");

    StringBuffer sb = new StringBuffer();
	if (IS_YEAR_AMT.equals("N")) {
		sb.append("AND SAL_GBN <> '4' ");
	}
	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()

	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


    //param binding 하기
    Object[] bind = new Object[] {
    		PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,
    		PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,
    		PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,
    		PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,
    		PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,PIS_YY,
    		PIS_YY,PIS_YY,
    		ENO_NO,DPT_CD
    	  };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "ENO_NO,SALT_AMT1,SALT_AMT2,SALT_AMT3,SALT_AMT4,SALT_AMT5,SALT_AMT6,SALT_AMT7,SALT_AMT8,SALT_AMT9,SALT_AMT10,SALT_AMT11,SALT_AMT12,INCM_TAX1,INCM_TAX2,INCM_TAX3,INCM_TAX4,INCM_TAX5,INCM_TAX6,INCM_TAX7,INCM_TAX8,INCM_TAX9,INCM_TAX10,INCM_TAX11,INCM_TAX12,PIS_YYMM1,PIS_YYMM2,PIS_YYMM3,PIS_YYMM4,PIS_YYMM5,PIS_YYMM6,PIS_YYMM7,PIS_YYMM8,PIS_YYMM9,PIS_YYMM10,PIS_YYMM11,PIS_YYMM12,AMT_DATE1,AMT_DATE2,AMT_DATE3,AMT_DATE4,AMT_DATE5,AMT_DATE6,AMT_DATE7,AMT_DATE8,AMT_DATE9,AMT_DATE10,AMT_DATE11,AMT_DATE12,COMP_NM,PRESIDENT_NM,TAX_NO,CORP_NO,ADDRESS,TEL_NO,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,TAX_OFFICE,ENO_NM,CADDRESS,CC1,CC2,CC3,CC4,CC5,CC6,CC7,CC8,CC9,CC10,CC11,CC12,CC13,CC14,CET_NO";
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
       	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
       	for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
       	}
           hnwExtQuery.SendData(response);

       }

%>
