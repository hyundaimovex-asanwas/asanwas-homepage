<!--
***********************************************************************
* @source      : misb170_ED.jsp
* @description : 입퇴사자 현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/14      이승욱        최초작성.
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
    String str_ymd   = request.getParameter("STR_YMD");
    String end_ymd   = request.getParameter("END_YMD");
    String acc_cd    = request.getParameter("ACC_CD");
    String gbn_case  = request.getParameter("GBN_CASE");
    String occ_cd  	 = request.getParameter("OCC_CD");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (gbn_case.equals("H")){
        sb1.append("P.HIRG_YMD");
        sb2.append("HIR_YMD");
    } else if (gbn_case.equals("R")){
        sb1.append("P.RET_YMD");
        sb2.append("RET_YMD");
    } else {
        sb1.append("");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString(),
            sb2.toString()
    };

    /** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    if (gbn_case.equals("J")){
	sql = XmlSqlUtils.getSQL("mis", "MISB170_SHR_02");
    } else {
	sql = XmlSqlUtils.getSQL("mis", "MISB170_SHR_01");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    }

  	Object[] bind = null;
  	bind = new Object[] {
		   str_ymd,
		   end_ymd,
		   occ_cd
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("DPT_CD");
	hnwExtQuery.AddField("DPT_NM");
	hnwExtQuery.AddField("JOB_CD");
	hnwExtQuery.AddField("JOB_NM");
	hnwExtQuery.AddField("ENO_NM");
	hnwExtQuery.AddField("CET_NO");
    hnwExtQuery.AddField("HOB_CD");
    hnwExtQuery.AddField("HOB_NM");
    hnwExtQuery.AddField("AGE");
    hnwExtQuery.AddField("EDGR_CD");
    hnwExtQuery.AddField("SCH_NM");
    hnwExtQuery.AddField("MAJ_NM");
    hnwExtQuery.AddField("HIR_YMD");
    hnwExtQuery.AddField("RET_YMD");
    hnwExtQuery.AddField("BF_DPT_NM");
    hnwExtQuery.AddField("ADD_YMD");
    hnwExtQuery.AddField("ADD_YMD1");
    hnwExtQuery.AddField("BIGO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("HOB_CD"));
            hnwExtQuery.AddData(vo.getString("HOB_NM"));
            hnwExtQuery.AddData(vo.getString("AGE"));
            hnwExtQuery.AddData(vo.getString("EDGR_CD"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("BF_DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ADD_YMD"));
            hnwExtQuery.AddData(vo.getString("ADD_YMD1"));
            hnwExtQuery.AddData(vo.getString("BIGO"));

            hnwExtQuery.SendData(response);
        }
    }
    
    hnwExtQuery.EndData(response);

%>
