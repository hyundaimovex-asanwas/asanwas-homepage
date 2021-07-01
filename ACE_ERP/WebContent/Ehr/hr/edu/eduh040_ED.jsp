<!--
***********************************************************************
* @source      : idta020_ED.jsp
* @description : 증명서발급처리
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      방석호        최초작성.
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
<%@ include file="/common/sessionCheck.jsp" %>

<%

	String SESSION_ENONO     = box.get("SESSION_ENONO");

    String sql = null;
    sql = XmlSqlUtils.getSQL("edu", "EDUH040_PRINT");
  	System.out.println(sql);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			SESSION_ENONO
	};

	/** 조회 조건(사용일자)에 따른 처리 **/


	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("소속사업장코드");
    hnwExtQuery.AddField("최종학력");
    hnwExtQuery.AddField("전공");
    hnwExtQuery.AddField("종사근로구분");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("주당근무시간");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("피보험취득일");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("GO_NUM"));
            hnwExtQuery.AddData(vo.getString("EDGR_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
            hnwExtQuery.AddData(vo.getString("OCC_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("WORK_TIME"));
            hnwExtQuery.AddData(vo.getString("HIRG_YMD"));
            hnwExtQuery.AddData(vo.getString("HIRG_YMD2"));

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);
%>