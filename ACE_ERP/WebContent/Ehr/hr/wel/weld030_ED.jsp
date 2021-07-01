<!--
***********************************************************************
* @source      : weld030_ED.jsp
* @description : 콘도신청리스트
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/17      방석호        최초작성.
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




	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("wel", "WELD030_SHR");

	/** 조회 조건(등록일자)에 따른 처리 #1 **/
	StringBuffer sb = new StringBuffer();
	if (!RST_GBN.equals("")) {
		sb.append("AND    A.RST_GBN LIKE '%'||'"+RST_GBN+"'||'%' \n");
	}
	/** 조회 조건(등록일자)에 따른 처리 #2 **/
	if (!STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND    A.STR_YMD >= '"+STR_YMD.replaceAll("-", "")+"' \n");
		sb.append("AND    A.STR_YMD <= '"+END_YMD.replaceAll("-", "")+"' \n");
	} else if (!STR_YMD.equals("") && END_YMD.equals("")) {
		sb.append("AND    A.STR_YMD >= '"+STR_YMD.replaceAll("-", "")+"' \n");
	} else if (STR_YMD.equals("") && !END_YMD.equals("")) {
		sb.append("AND    A.STR_YMD <= '"+END_YMD.replaceAll("-", "")+"' \n");
	}

	/** 조회 조건()에 따른 처리 #3 **/
    //전체 조건에서는 신청과 예약건만 보여줌
    if(RSV_GBN.equals("13")) {
        sb.append("AND A.RSV_GBN IN ('1', '3')");
    } else {
        sb.append("AND A.RSV_GBN = NVL('"+RSV_GBN+"', A.RSV_GBN)");
    }


	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()

	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			CN_CD,
			SEASON_GBN
	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
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
    	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
    	for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
    	}
        hnwExtQuery.SendData(response);

    }
%>