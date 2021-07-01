<!--
***********************************************************************
* @source      : welg010_ED.jsp
* @description : 전보발송자명단
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/20      방석호        최초작성.
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
<%@page import="java.util.HashMap"%>
<%@page import="common.util.JSPUtil"%>

<%

	String GBN_SHR	= request.getParameter("GBN_SHR");
	String BIR_YMD_SHR	= request.getParameter("BIR_YMD_SHR");
	String WED_YMD_SHR	= request.getParameter("WED_YMD_SHR");
	String HIR_YMD_SHR	= request.getParameter("HIR_YMD_SHR");
	String OCC_CD_SHR	= request.getParameter("OCC_CD_SHR");

	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("wel", "WELG010_PRT");

	// 윤년(1900~2100), 윤달
	HashMap yun = new HashMap();

	yun.put("1900", "8");	yun.put("1903", "5");	yun.put("1906", "4");	yun.put("1909", "2");	yun.put("1911", "6");
	yun.put("1914", "5");	yun.put("1917", "2");	yun.put("1919", "7");	yun.put("1922", "5");	yun.put("1925", "4");
	yun.put("1928", "2");	yun.put("1930", "6");	yun.put("1930", "5");	yun.put("1936", "3");	yun.put("1936", "7");
	yun.put("1941", "6");	yun.put("1944", "4");	yun.put("1947", "2");	yun.put("1949", "7");	yun.put("1952", "5");
	yun.put("1955", "3");	yun.put("1957", "8");	yun.put("1960", "6");	yun.put("1963", "4");	yun.put("1966", "3");
	yun.put("1968", "7");	yun.put("1971", "5");	yun.put("1974", "4");	yun.put("1976", "8");	yun.put("1979", "6");
	yun.put("1982", "4");	yun.put("1984", "10");	yun.put("1987", "6");	yun.put("1990", "5");	yun.put("1993", "3");
	yun.put("1995", "8");	yun.put("1998", "5");	yun.put("2001", "4");	yun.put("2004", "2");	yun.put("2006", "7");
	yun.put("2009", "5");	yun.put("2012", "3");	yun.put("2014", "9");	yun.put("2017", "5");	yun.put("2020", "4");
	yun.put("2023", "2");	yun.put("2025", "6");	yun.put("2028", "5");	yun.put("2031", "3");	yun.put("2033", "11");
	yun.put("2036", "6");	yun.put("2039", "5");	yun.put("2042", "2");	yun.put("2044", "7");	yun.put("2047", "5");
	yun.put("2050", "3");	yun.put("2052", "8");	yun.put("2055", "6");	yun.put("2058", "4");	yun.put("2061", "3");
	yun.put("2063", "7");	yun.put("2066", "5");	yun.put("2069", "4");	yun.put("2071", "8");	yun.put("2074", "6");
	yun.put("2077", "4");	yun.put("2080", "3");	yun.put("2082", "7");	yun.put("2085", "5");	yun.put("2088", "4");
	yun.put("2090", "8");	yun.put("2093", "6");	yun.put("2096", "4");	yun.put("2099", "3");

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {};

	StringBuffer sb = new StringBuffer();

	/** 조회 조건에 따른 처리 **/
	if( ! OCC_CD_SHR.equals("0") ){
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}

	// 조회조건(생일)
	if(GBN_SHR.equals("0")){
		String YY  = BIR_YMD_SHR.substring(0,4);
		String MM  = BIR_YMD_SHR.substring(5,7);
		String stS = JSPUtil.changeCalendar(YY, MM, "01", "-").replaceAll("-", "");
		String enS = JSPUtil.changeCalendar(YY, MM, JSPUtil.Last_Date(YY+MM)+"","-").replaceAll("-", "");

		// 윤달이 있는달
		if( yun.containsKey(YY) && yun.get(YY).equals(MM)){

			sb.append("AND ( ( BIR_TAG = 'S' \n");        // 양력
			sb.append("        AND SUBSTR(BIR_YMD,4,2) = '"+MM+"') \n");


			sb.append("OR    ( BIR_TAG = 'M' \n");        // 음력

			// 양력 월 마지막 날의 음력일자가 양력 월 첫날의 음력일자보다 작을경우
			if( Integer.parseInt(stS) >= Integer.parseInt(enS) ){
				sb.append("AND (   ( TO_CHAR(BIR_YMD,'MMDD') >= '"+enS.substring(4,6)+"01"+"' \n");
				sb.append("          AND TO_CHAR(BIR_YMD,'MMDD') <= '"+enS+"')  \n");
				sb.append("     OR ( TO_CHAR(BIR_YMD,'MMDD') >= '"+stS+"' \n");
				sb.append("          AND TO_CHAR(BIR_YMD,'MMDD') <= '"+stS.substring(4,6)+"31"+"') \n");
				sb.append("     ) \n"); // end AND
			}else{
				sb.append("AND TO_CHAR(BIR_YMD,'MMDD') >= '"+stS.substring(4)+"' \n");
				sb.append("AND TO_CHAR(BIR_YMD,'MMDD') <= '"+enS.substring(4)+"' \n");

			}
			sb.append("     ) \n"); // end OR
			sb.append("        ) \n");

		// 윤달이 없는달
		}else{
			sb.append("AND ( ( BIR_TAG = 'S' \n");        // 양력
			sb.append("        AND SUBSTR(BIR_YMD,4,2) = '"+MM+"') \n");
			sb.append("OR    ( BIR_TAG = 'M' \n");        // 음력
			sb.append("        AND TO_CHAR(BIR_YMD,'MMDD') >= '"+stS.substring(4)+"' \n");
			sb.append("        AND TO_CHAR(BIR_YMD,'MMDD') <= '"+enS.substring(4)+"') \n");
			sb.append("        ) \n");
		}
	}

	// 조회조건(결혼기념일)
	if(GBN_SHR.equals("1")){
		//String YY  = WED_YMD_SHR.substring(0,4);
		String MM  = WED_YMD_SHR.substring(5,7);
		//String stS = JSPUtil.changeCalendar(YY, MM, "01", "-").replaceAll("-", "");
		//String enS = JSPUtil.changeCalendar(YY, MM, JSPUtil.Last_Date(YY+MM)+"","-").replaceAll("-", "");
		sb.append("AND  \n");        // 양력
		sb.append("    ( WED_YMD IS NOT NULL \n");  // 결혼기념일
		sb.append("        AND SUBSTR(WED_YMD,4,2) = '"+MM+"') \n");
	}

	//조회조건(입사일)
    if(GBN_SHR.equals("2")){
        sb.append("AND TO_CHAR(HIR_YMD,'YYYYMM') = '"+HIR_YMD_SHR.replaceAll("-", "").substring(0,6)+"' \n");
    }

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
	String 	colStr  =   "DPT_CD,JOB_CD,ENO_NO,ENO_NM,DPT_NM,JOB_NM,BIR_TAG,EM_PHN_NO,BIR_YMD,WED_YMD,ZIP_NO,ADDRESS";
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