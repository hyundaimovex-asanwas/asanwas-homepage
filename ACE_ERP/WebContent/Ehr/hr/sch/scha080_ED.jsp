<!--
***********************************************************************
* @source      : scha080_ED.jsp
* @description : 학자금 지급 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/13      방석호        최초작성.
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



	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("sch", "SCHA080_SHR");

	/** 조회 조건(지급일자)에 따른 처리 **/
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
	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			"01",
			OCC_CD,
			STR_YM.replaceAll("-", ""),
			END_YM.replaceAll("-", ""),
	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/

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
    	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
    	for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
    	}
        hnwExtQuery.SendData(response);

    }
%>