<!--
***********************************************************************
* @source      : edui020_ED.jsp
* @description : 교육현황 - 교육비 지급 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     방석호        최초작성.
* 2007/05/09     김학수        수정.
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
	String STR_YMD_SHR	= request.getParameter("STR_YMD_SHR").replaceAll("-", "");
	String END_YMD_SHR  = request.getParameter("END_YMD_SHR").replaceAll("-", "");
	
    String OCC_CD_SHR   = request.getParameter("OCC_CD_SHR");

	String GBN_CD       = request.getParameter("GBN_CD");
	String DPT_CD_SHR   = request.getParameter("DPT_CD_SHR");
//	String DPT_NM_SHR   = request.getParameter("DPT_NM_SHR");
    String EDU_CD_SHR   = request.getParameter("EDU_CD_SHR");
//	String EDU_NM_SHR   = request.getParameter("EDU_NM_SHR");
    String JOB_CD_SHR   = request.getParameter("JOB_CD_SHR");
//	String JOB_NM_SHR   = request.getParameter("JOB_NM_SHR");

    String sort1 = "";
    String sort2 = "";

	/** 조회 조건에 따른 처리 **/


    if ( GBN_CD.equals("2") ) {
	    sort1 = "AA.DPT_NM";
        sort2 = "AA.JOB_NM";
	} else {
	    sort2 = "AA.DPT_NM";
        sort1 = "AA.JOB_NM";
    }


	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("edu", "EDUI020_SHR");
        

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			STR_YMD_SHR,
			END_YMD_SHR,
            OCC_CD_SHR,
            DPT_CD_SHR,
            JOB_CD_SHR,
            EDU_CD_SHR
	};

	StringBuffer sb = new StringBuffer();

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
        sort1, sort2
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("순번");
    hnwExtQuery.AddField("SORT1");
    hnwExtQuery.AddField("SORT2");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("과정명");
    hnwExtQuery.AddField("교육기간");
    hnwExtQuery.AddField("교육비");
    hnwExtQuery.AddField("비고");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));

            hnwExtQuery.AddData(vo.getString("SORT1"));
            hnwExtQuery.AddData(vo.getString("SORT2"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("EDU_NM"));
            hnwExtQuery.AddData(vo.getString("YMD_VAL"));
            hnwExtQuery.AddData(vo.getString("EDU_AMT"));
            hnwExtQuery.AddData(vo.getString("REMARK"));

            hnwExtQuery.SendData(response);
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
       
        hnwExtQuery.SendData(response);
    }

%>