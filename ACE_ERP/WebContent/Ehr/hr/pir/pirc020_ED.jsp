<!--
***********************************************************************
* @source      : guna100_ED.jsp
* @description : 개인별근태집계현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      김학수        최초작성.
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

    String eno_no   = request.getParameter("eno_no");
	String sal_gbn  = request.getParameter("sal_gbn");
    String pis_yy    = request.getParameter("pis_yy");
    String pis_mm  = request.getParameter("pis_mm");
    String seq  = request.getParameter("seq");

    String sql = null;
    sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_01");

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy,
		  pis_mm,
		  sal_gbn,
		  seq,
		  eno_no
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("직위/호봉");
    hnwExtQuery.AddField("계좌번호");
    hnwExtQuery.AddField("부양코드");

    hnwExtQuery.AddField("기본급");
    hnwExtQuery.AddField("직무수당");
    hnwExtQuery.AddField("법정수당");
    hnwExtQuery.AddField("상여금");
    hnwExtQuery.AddField("차량유지비");
    hnwExtQuery.AddField("개인연금");

    hnwExtQuery.AddField("지역근무수당");
    hnwExtQuery.AddField("식대");
    hnwExtQuery.AddField("가족부양비");
    hnwExtQuery.AddField("기타지불");
    hnwExtQuery.AddField("근속수당");

    hnwExtQuery.AddField("자기계발비");
    hnwExtQuery.AddField("출납수당");
    hnwExtQuery.AddField("기사수당");
    hnwExtQuery.AddField("자격수당");
    hnwExtQuery.AddField("남북경협수당");
    hnwExtQuery.AddField("특수지수당");
    hnwExtQuery.AddField("학자금");
    hnwExtQuery.AddField("현장직책수당");
    hnwExtQuery.AddField("전월소급");
    hnwExtQuery.AddField("휴일근무수당");
    hnwExtQuery.AddField("계약_북측근무수당");
    hnwExtQuery.AddField("계약_현장수당");
	hnwExtQuery.AddField("계약_성과금");

    hnwExtQuery.AddField("총지급액");
    hnwExtQuery.AddField("공제계");
    hnwExtQuery.AddField("실수령액");
    hnwExtQuery.AddField("부서명");

    hnwExtQuery.AddField("배");
    hnwExtQuery.AddField("부");
    hnwExtQuery.AddField("장");
    hnwExtQuery.AddField("경");
    hnwExtQuery.AddField("부1");
    hnwExtQuery.AddField("자");
    hnwExtQuery.AddField("급여지급일");
    hnwExtQuery.AddField("공지사항");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ACC_NO"));
            hnwExtQuery.AddData(vo.getString("BY_CD"));

            hnwExtQuery.AddData(vo.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));
            hnwExtQuery.AddData(vo.getString("LAW_AMT"));
            hnwExtQuery.AddData(vo.getString("BNS_AMT"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT"));
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));

            hnwExtQuery.AddData(vo.getString("ETC_AMT2"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT3"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT4"));
            hnwExtQuery.AddData(vo.getString("OTH_AMT_PRN"));
            hnwExtQuery.AddData(vo.getString("LSEV_AMT"));

     	    hnwExtQuery.AddData(vo.getString("OSE_AMT"));
			hnwExtQuery.AddData(vo.getString("MONEY_AMT"));
			hnwExtQuery.AddData(vo.getString("DRIVE_AMT"));
			hnwExtQuery.AddData(vo.getString("RUN_AMT"));
			hnwExtQuery.AddData(vo.getString("SPECIAL_AMT"));
			hnwExtQuery.AddData(vo.getString("OTH_AMT2"));
			hnwExtQuery.AddData(vo.getString("SCH_AMT"));
			hnwExtQuery.AddData(vo.getString("POSITION_AMT"));
			hnwExtQuery.AddData(vo.getString("RETRO_AMT"));
			hnwExtQuery.AddData(vo.getString("HOL_AMT"));
			hnwExtQuery.AddData(vo.getString("T_NORTH_AMT"));
			hnwExtQuery.AddData(vo.getString("T_SITE_AMT"));
			hnwExtQuery.AddData(vo.getString("T_GOAL_AMT"));


            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));

            hnwExtQuery.AddData(vo.getString("SOU_CNT"));
            hnwExtQuery.AddData(vo.getString("DFM_CNT"));
            hnwExtQuery.AddData(vo.getString("TRB_CNT"));
            hnwExtQuery.AddData(vo.getString("GOL_CNT"));
            hnwExtQuery.AddData(vo.getString("WCT_CNT"));
            hnwExtQuery.AddData(vo.getString("CHI_CNT"));
            hnwExtQuery.AddData(vo.getString("PAY_YMD"));
            hnwExtQuery.AddData(vo.getString("REMARK"));


            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);
%>