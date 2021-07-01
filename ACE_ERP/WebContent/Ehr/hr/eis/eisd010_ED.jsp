<!--
***********************************************************************
* @source      : eisd010_ED.jsp
* @description : 기념일 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      이승욱        최초작성.
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

<%@page import ="com.shift.gef.support.collection.CollectionUtility"%>
<%@page import ="com.shift.gef.support.utility.SessionUtil"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>
<%
	CBox box = CollectionUtility.getGauceDataBox(request);
	box  = SessionUtil.getSession(request, box);

    String pis_mm      = request.getParameter("PIS_MM");
    String pis_mm_fr_m = request.getParameter("PIS_MM_FR_M");
    String pis_mm_fr_me = request.getParameter("PIS_MM_FR_ME");
    String pis_mm_to_m = request.getParameter("PIS_MM_TO_M");
    String pis_mm_to_mf = request.getParameter("PIS_MM_TO_MF");
    String pis_ym_f5   = request.getParameter("PIS_YM_F5");
    String pis_ym_f10  = request.getParameter("PIS_YM_F10");
    String pis_ym_f15  = request.getParameter("PIS_YM_F15");
    String pis_ym_f20  = request.getParameter("PIS_YM_F20");
    String pis_ym_f25  = request.getParameter("PIS_YM_F25");
    String pis_ym_f30  = request.getParameter("PIS_YM_F30");
    String pis_ym_f35  = request.getParameter("PIS_YM_F35");

    String sql = null;

    sql = XmlSqlUtils.getSQL("eis", "EISD010_SHR");

    String head_cd = "";

    if ( !box.get("SESSION_ROLE_CD").equals("1001") && !box.get("SESSION_ROLE_CD").equals("1002")
            && box.get("SESSION_L3_AUTHO").equals("M") ) {//본부장권한 추가함. 해당본부장만 보이게(20071221, 김우태 대리)
        head_cd = box.get("SESSION_HEADCD");
    }

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_mm, pis_mm_fr_m, pis_mm_fr_me, pis_mm_to_mf, pis_mm_to_m,head_cd,
		  pis_mm,head_cd,
		  pis_ym_f5, pis_ym_f10, pis_ym_f15, pis_ym_f20, pis_ym_f25, pis_ym_f30, pis_ym_f35,
		  pis_ym_f5, pis_ym_f10, pis_ym_f15, pis_ym_f20, pis_ym_f25, pis_ym_f30, pis_ym_f35,head_cd,
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

	hnwExtQuery.AddField("GUBUN");
	hnwExtQuery.AddField("HEAD_NM");
	hnwExtQuery.AddField("DEPT_NM");
	hnwExtQuery.AddField("TEAM_NM");
	hnwExtQuery.AddField("ENO_NM");
	hnwExtQuery.AddField("ENO_NO");
	hnwExtQuery.AddField("AGE");
	hnwExtQuery.AddField("CONG_YMD");
	hnwExtQuery.AddField("HIR_YMD");
	hnwExtQuery.AddField("HSORT_NO");
	hnwExtQuery.AddField("DSORT_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("DEPT_NM"));
            hnwExtQuery.AddData(vo.getString("TEAM_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("AGE"));
            hnwExtQuery.AddData(vo.getString("CONG_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HSORT_NO"));
            hnwExtQuery.AddData(vo.getString("DSORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>

