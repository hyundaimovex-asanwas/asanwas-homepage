<!--
***********************************************************************
* @source      : saga080_1_ED.jsp
* @description : 급여총괄표
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
	String PIS_YYMM_SHR = request.getParameter("PIS_YYMM_SHR");
	String OCC_CD_SHR 	= request.getParameter("OCC_CD_SHR");
	String DPT_CD_SHR  	= request.getParameter("DPT_CD_SHR");
	String TOTAL_SHR 		= request.getParameter("TOTAL_SHR");


	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("sag", "SAGA080_SHR_02");

	//차액이 0인것 않나온다.
	StringBuffer sb1 = new StringBuffer();
	StringBuffer sb2 = new StringBuffer();
	if (TOTAL_SHR.equals("false")) {
		sb1.append("            SELECT DPT_NM, JOB_NM, ENO_NO, ENO_NM, BEF_AMT, AFT_AMT \n");
		sb1.append("            FROM   (\n");
		sb2.append("                        )\n");
		sb2.append("            WHERE (AFT_AMT - BEF_AMT) <> '0' \n");
	}

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb1.toString(),
			sb2.toString(),
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
//			OCC_CD_SHR,
//			DPT_CD_SHR,
//			PIS_YYMM_SHR.replaceAll("-", ""),
//			PIS_YYMM_SHR.replaceAll("-", ""),
//			PIS_YYMM_SHR.substring(0,4),
//			PIS_YYMM_SHR.substring(5,7),
				OCC_CD_SHR,
				OCC_CD_SHR,
				PIS_YYMM_SHR.replaceAll("-", ""),
				PIS_YYMM_SHR.replaceAll("-", ""),
				DPT_CD_SHR,
				PIS_YYMM_SHR.replaceAll("-", ""),
				PIS_YYMM_SHR.replaceAll("-", ""),
				PIS_YYMM_SHR.substring(0,4),
				PIS_YYMM_SHR.substring(5,7),
	};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "DPT_NM,JOB_NM,ENO_NO,ENO_NM,BEF_AMT,AFT_AMT";
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
