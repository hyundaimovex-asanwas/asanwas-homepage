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
    sql = XmlSqlUtils.getSQL("pir", "PIRC020_SHR_02");

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

    hnwExtQuery.AddField("갑근세");
    hnwExtQuery.AddField("주민세");
    hnwExtQuery.AddField("건강보험료");
    hnwExtQuery.AddField("장기요양보험");

    hnwExtQuery.AddField("국민연금");
    hnwExtQuery.AddField("고용보험");

    hnwExtQuery.AddField("공조회비");
    hnwExtQuery.AddField("개인연금공제");
    hnwExtQuery.AddField("대출상환금");
    hnwExtQuery.AddField("대출상환이자");
    hnwExtQuery.AddField("기타공제액");
    hnwExtQuery.AddField("보증보험");

    hnwExtQuery.AddField("여직원회비");
    hnwExtQuery.AddField("저축");
    hnwExtQuery.AddField("출연금");
    hnwExtQuery.AddField("복지카페");

    hnwExtQuery.AddField("정산건강보험");
    hnwExtQuery.AddField("정산주민보험");

    hnwExtQuery.AddField("연말정산소득세");
    hnwExtQuery.AddField("연말정산주민세");
    
    hnwExtQuery.AddField("연말정산농특세");
    hnwExtQuery.AddField("1월유보");
    
    hnwExtQuery.AddField("급여유보");
    hnwExtQuery.AddField("통근버스");    
    
    hnwExtQuery.AddField("총지급액");
    hnwExtQuery.AddField("공제계");
    hnwExtQuery.AddField("실수령액");


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

            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("OLD_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));

            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));
            hnwExtQuery.AddData(vo.getString("PPED_AMT"));
            hnwExtQuery.AddData(vo.getString("LON_RPY"));
            hnwExtQuery.AddData(vo.getString("LON_INT"));
            hnwExtQuery.AddData(vo.getString("OTHD_AMT_PRN"));
            hnwExtQuery.AddData(vo.getString("LAB_AMT"));

            hnwExtQuery.AddData(vo.getString("WOM_AMT"));
            hnwExtQuery.AddData(vo.getString("SAV_AMT"));
            hnwExtQuery.AddData(vo.getString("APP_AMT"));
            hnwExtQuery.AddData(vo.getString("WEL_POINT"));
            hnwExtQuery.AddData(vo.getString("DRE_INTX"));
            hnwExtQuery.AddData(vo.getString("DRE_CTTX"));
            
            hnwExtQuery.AddData(vo.getString("YC_INT"));
            hnwExtQuery.AddData(vo.getString("YC_CTT"));            
            
            hnwExtQuery.AddData(vo.getString("ETC_AMT_A6"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT_AF"));                 
            hnwExtQuery.AddData(vo.getString("ITXD_AMT"));
            hnwExtQuery.AddData(vo.getString("ETC_AMT_A5"));        
            
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));

            //System.out.println("------------>"+hnwExtQuery.get_column_cnt());


            hnwExtQuery.SendData(response);
        }
    }

    hnwExtQuery.EndData(response);
%>