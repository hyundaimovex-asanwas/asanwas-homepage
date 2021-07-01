<!--
***********************************************************************
* @source      : aida010_ED.jsp
* @description : 공조부조금 신청서
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      방석호        최초작성.
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



	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("aid", "AIDA030_SHR");

	String SPL_YMD_STDT_SHR = request.getParameter("SPL_YMD_STDT_SHR").replaceAll("-", "");
	String SPL_YMD_ENDT_SHR = request.getParameter("SPL_YMD_ENDT_SHR").replaceAll("-", "");
	String CEF_SEC_SHR = request.getParameter("CEF_SEC_SHR"); // 조회조건(경,공조)
	String OCC_CD_SHR = request.getParameter("OCC_CD_SHR");   // 직종별
	String JOB_CD_SHR = request.getParameter("JOB_CD_SHR");   // 직위별
	String DPT_CD_SHR = request.getParameter("DPT_CD_SHR");   // 소속별
	String AID_CD_SHR = request.getParameter("AID_CD_SHR");   // 신청내용별
	String ORDER_TYPE = request.getParameter("ORDER_TYPE");   // 신청내용별

	/** 조회 조건(지급일자)에 따른 처리 **/
	StringBuffer sb = new StringBuffer();
	if (!SPL_YMD_STDT_SHR.equals("") && !SPL_YMD_ENDT_SHR.equals("")) {
		sb.append("SPL_YMD >= '"+SPL_YMD_STDT_SHR+"' \n");
		sb.append("AND SPL_YMD <= '"+SPL_YMD_ENDT_SHR+"' \n");
	} else if (!SPL_YMD_STDT_SHR.equals("") && SPL_YMD_ENDT_SHR.equals("")) {
		sb.append("SPL_YMD >= '"+SPL_YMD_STDT_SHR+"' \n");
	} else if (SPL_YMD_STDT_SHR.equals("") && !SPL_YMD_ENDT_SHR.equals("")) {
		sb.append("SPL_YMD <= '"+SPL_YMD_ENDT_SHR+"' \n");
	} else {
		sb.append("1=1 \n");
	}

	/** 조회 조건(조회조건, 직종, 직위, 소속, 신청내용)에 따른 처리 **/
	if( CEF_SEC_SHR.equals("1") ){ // 경조금만 지급 받은 것만
		sb.append("AND HLP1_AMT IS NULL AND HLP2_AMT IS NOT NULL \n");
	}
	if( CEF_SEC_SHR.equals("2") ){
		sb.append("AND HLP1_AMT IS NOT NULL AND HLP2_AMT IS NULL \n");
	}
	if( ! OCC_CD_SHR.equals("0") ){ //직종별
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}
	if( ! JOB_CD_SHR.equals("") ){ //직위별
		sb.append("AND JOB_CD = '"+JOB_CD_SHR+"' \n");
	}
	if( ! DPT_CD_SHR.equals("") ){ //소속별
		sb.append("AND DPT_CD = '"+DPT_CD_SHR+"' \n");
	}
	if( ! AID_CD_SHR.equals("") ){ //신청내용별
		sb.append("AND AID_CD = '"+AID_CD_SHR+"' \n");
	}

	StringBuffer sb2 = new StringBuffer();
    //0,직종별  1,직위별  2,소속별,  3.신청내용별
    if(       ORDER_TYPE.equals("")) {
        sb2.append("A.SPL_YMD");
    } else if(ORDER_TYPE.equals("0")) {
        sb2.append("A.OCC_CD");
    } else if(ORDER_TYPE.equals("1")) {
        sb2.append("SF_GET_COMMSEQ('01', 'A2', A.JOB_CD)");
    } else if(ORDER_TYPE.equals("2")) {
        sb2.append("SF_GET_DPTSEQ('01', 'A4', A.DPT_CD)");
    } else if(ORDER_TYPE.equals("3")) {
        sb2.append("A.AID_CD");
    }



	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString(),
			sb2.toString()

	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                CEF_SEC_SHR,
                CEF_SEC_SHR
        };


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
	String 	colStr  =   "ENO_NM,OCC_NM,DPT_NM,JOB_NM,AID_NM,AID_YMD,HLP1_AMT,HLP2_AMT,SPL_YMD";
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