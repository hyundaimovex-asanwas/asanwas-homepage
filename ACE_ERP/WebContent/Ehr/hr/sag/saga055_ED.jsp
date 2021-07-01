<!--
***********************************************************************
* @source         : saga055_ED.jsp 				                                                                                     *
* @description   : 상여대장 PAGE.
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/07      김학수        최초작성.
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

    String pis_ym = request.getParameter("pis_ym");
    String dpt_cd = request.getParameter("dpt_cd");
    String gbn_cd = request.getParameter("gbn_cd");


   // gbn_cd = "0";
    pis_ym = pis_ym.replaceAll("-","");
    String sql = "";
    String pis_y = request.getParameter("PIS_YY_SHR");      // 일자
    String pis_m = request.getParameter("PIS_MM_SHR");      // 일자
    /** 외부 XML에서 SQL을 읽어 온다 **/
    //sql = XmlSqlUtils.getSQL("sag", "SAGA050_SHR");
    System.out.println("년도 ED시작:[" + pis_y + "]");
    System.out.println("  월 ED시작:[" + pis_m + "]");
    System.out.println("dpt_cd ED시작:"+dpt_cd);
    System.out.println("gbn_cd ED시작:"+gbn_cd);

    if ( gbn_cd.equals("0") ) {
        /** 외부 XML에서 SQL을 읽어 온다 **/
         sql = XmlSqlUtils.getSQL("sag", "SAGA055_SHR");
         System.out.println("구분0 [" + gbn_cd + "]");
         System.out.println(sql);
     } else if ( gbn_cd.equals("1") ) {
         sql = XmlSqlUtils.getSQL("sag", "SAGA055_SHR_01");
         System.out.println("구분1 [" + gbn_cd + "]");
         System.out.println(sql);
     } else {
         sql = XmlSqlUtils.getSQL("sag", "SAGA055_SHR_02");
         System.out.println("구분2 [" + gbn_cd + "]");
         System.out.println(sql);
     }



    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        pis_y, pis_m, dpt_cd
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
   // hnwExtQuery.AddField("구분");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("이름");
    hnwExtQuery.AddField("직위");

	//실지급액
    hnwExtQuery.AddField("급여지급액(A)");
    hnwExtQuery.AddField("급여공제액(B)");
    hnwExtQuery.AddField("차인지급액(C=A-B)");
    hnwExtQuery.AddField("실지급액(E=C-D)");
	//상여지급액(A)
    hnwExtQuery.AddField("기본급");
    hnwExtQuery.AddField("법정수당");
    hnwExtQuery.AddField("기타수당");
    hnwExtQuery.AddField("기타지불1");
    hnwExtQuery.AddField("식대");
    hnwExtQuery.AddField("직무수당");
    hnwExtQuery.AddField("상여금");
    hnwExtQuery.AddField("개인연금");
    hnwExtQuery.AddField("기타지불2");
	//상여공제액(B)
    hnwExtQuery.AddField("소득세");
    hnwExtQuery.AddField("주민세");
    hnwExtQuery.AddField("국민연금");
    hnwExtQuery.AddField("연말정산");
    hnwExtQuery.AddField("건강보험");
    hnwExtQuery.AddField("고용보험");
    hnwExtQuery.AddField("공조회비");
    hnwExtQuery.AddField("장기요양보험");
    hnwExtQuery.AddField("개인연금공제");
    hnwExtQuery.AddField("기타공제1");
    hnwExtQuery.AddField("기타공제2");
    hnwExtQuery.AddField("사회공헌기금(D)");

    hnwExtQuery.SendField(response);

    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//			hnwExtQuery.AddData(vo.getString("GUBUN"));		    // 국내외구분
			hnwExtQuery.AddData(vo.getString("DPT_NM"));		// 부서
            hnwExtQuery.AddData(vo.getString("ENO_NO"));		// 사번
            hnwExtQuery.AddData(vo.getString("ENO_NM"));		// 이름
            hnwExtQuery.AddData(vo.getString("JOB_NM"));		// 직위
			//실지급액
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));		// 상여지급액(A)
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));		// 상여공제액(B)
            hnwExtQuery.AddData(vo.getString("RL_AMT"));		// 차인지급액(C=A-B)
            hnwExtQuery.AddData(vo.getString("NET_PAY_AMT"));	// 실지급액(E=C-D)
			//상여지급액(A)
            hnwExtQuery.AddData(vo.getString("NET_BAS_AMT"));	// 기본급
            hnwExtQuery.AddData(vo.getString("LAW_AMT"));		// 법정수당
            hnwExtQuery.AddData(vo.getString("ETC_AMT"));		// 기타수당
            hnwExtQuery.AddData(vo.getString("OTH_AMT"));		// 기타지불1
            hnwExtQuery.AddData(vo.getString("LUN_AMT"));		// 식대
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));		// 직무수당
            hnwExtQuery.AddData(vo.getString("BNS_AMT"));		// 상여금
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));		// 개인연금
            hnwExtQuery.AddData(vo.getString("HOL_AMT"));	// 기타지불2
			//상여공제액(B)
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));		// 소득세
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));		// 주민세
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));		// 국민연금
            hnwExtQuery.AddData(vo.getString("ETC_AMT_JN"));	// 연말정산
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));		// 건강보험
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));		// 고용보험
            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));		// 공조회비
            hnwExtQuery.AddData(vo.getString("OLD_AMT"));		// 장기요양보험
            hnwExtQuery.AddData(vo.getString("PPED_AMT"));		// 개인연금
            hnwExtQuery.AddData(vo.getString("OTHD_AMT"));		// 기타공제1
            hnwExtQuery.AddData(vo.getString("OTHD_AMT2"));		// 기타공제2
            hnwExtQuery.AddData(vo.getString("CONT_AMT"));		// 사회공헌기금(D)

			hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
		//실지급액
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
		//상여지급액(A)
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
		//상여공제액(B)
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
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