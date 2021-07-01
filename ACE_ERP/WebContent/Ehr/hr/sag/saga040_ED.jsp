<!--
***********************************************************************
* @source         : saga040_ED.jsp 				                                                                                     *
* @description   : 급상여지급현황 PAGE.
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


    String sql = "";
    String pis_y       = request.getParameter("PIS_YY_SHR");      // 일자
    String pis_m       = request.getParameter("PIS_MM_SHR");      // 일자
    String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");
    String SAL_GBN_SHR = request.getParameter("SAL_GBN_SHR");

    System.out.println("request 구분 GBN_CD_SHR  = " + request.getParameter("GBN_CD_SHR") + " ==> " +  GBN_CD_SHR);
    System.out.println("request 구분 SAL_GBN_SHR = " + request.getParameter("SAL_GBN_SHR") + " ==> " +  SAL_GBN_SHR);

    /** 외부 XML에서 SQL을 읽어 온다 **/
    sql = XmlSqlUtils.getSQL("sag", "SAGA040_SHR");

	/** 국/내외  구분에 따른 처리 **/
	StringBuffer sb = new StringBuffer();
	/** GBN_CD_SHR ="1"; **/
    if ( GBN_CD_SHR.equals("0") ) {
		 sb.append("AND A.DPT_CD NOT IN ('H2', 'H3', 'H4', 'H5', 'H6')");
      //   System.out.println("saga040_ED 구분0 국내 [" + GBN_CD_SHR + "]");
      //   System.out.println(sql);
     } else if ( GBN_CD_SHR.equals("1") ) {
    	 sb.append("AND A.DPT_CD  IN ('H2', 'H3', 'H4', 'H5', 'H6')");
      //   System.out.println("saga040_ED 구분1 해외 [" + GBN_CD_SHR + "]");
      //   System.out.println(sql);
     } else {
    	 sb.append("AND 2=2");
      //   System.out.println("saga040_ED 구분2 전체 [" + GBN_CD_SHR + "]");
      //   System.out.println(sql);
     }


	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        pis_y, pis_m, SAL_GBN_SHR
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("기본급");
    hnwExtQuery.AddField("법정수당");
    hnwExtQuery.AddField("직무수당");
    hnwExtQuery.AddField("상여금");
    hnwExtQuery.AddField("기타수당");
    hnwExtQuery.AddField("개인연금");
    hnwExtQuery.AddField("기타지불1");
    hnwExtQuery.AddField("기타지불2");
    hnwExtQuery.AddField("식대");
    hnwExtQuery.AddField("지급액계");
    hnwExtQuery.AddField("소득세");
    hnwExtQuery.AddField("주민세");
    hnwExtQuery.AddField("연말정산");
    hnwExtQuery.AddField("국민연금");
    hnwExtQuery.AddField("건강보험");
    hnwExtQuery.AddField("고용보험");
    hnwExtQuery.AddField("장기요양보험");
    hnwExtQuery.AddField("공조회비");
    hnwExtQuery.AddField("개인연금공제");
    hnwExtQuery.AddField("기타공제1");
    hnwExtQuery.AddField("기타공제2");
    hnwExtQuery.AddField("공제액계");
    hnwExtQuery.AddField("차인지급액");
    hnwExtQuery.AddField("사회공헌기금");
    hnwExtQuery.AddField("실지급액");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("BAS_AMT"));		// 기본급
            hnwExtQuery.AddData(vo.getString("LAW_AMT"));		// 법정수당
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));		// 직무수당
            hnwExtQuery.AddData(vo.getString("BNS_AMT"));		// 상여금
            hnwExtQuery.AddData(vo.getString("ETC_AMT"));		// 기타수당(교통비)
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));		// 개인연금
            hnwExtQuery.AddData(vo.getString("OTH_AMT"));		// 기타지불  (학자금, 미사용연차, 미지급급여, 주재원수당, 포상)
            hnwExtQuery.AddData(vo.getString("HOL_AMT"));		// 기타지불2 (휴일근무수당)
            hnwExtQuery.AddData(vo.getString("LUN_AMT"));		// 식대
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));		// 지급액계
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));		// 소득세
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));		// 주민세
            hnwExtQuery.AddData(vo.getString("ETC_AMT_JN"));	// 연말정산
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));		// 국민연금
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));		// 건강보험
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));		// 고용보험
            hnwExtQuery.AddData(vo.getString("OLD_AMT"));		// 장기요양보험
            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));		// 공조회비
            hnwExtQuery.AddData(vo.getString("PPED_AMT"));		// 개인연금
            hnwExtQuery.AddData(vo.getString("OTHD_AMT"));	// 기타공제1 (동호회비, 퇴사자 근로소득세 정산, 축의금 및 조의금 급여공제, 급여 반납, 급여 유보, 학자금, 교육미이수)
            hnwExtQuery.AddData(vo.getString("ETC_AMT2"));	// 기타공제2 (대출인데 사용안함
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));	// 공제액계
            hnwExtQuery.AddData(vo.getString("RL_AMT"));	// 차인지급액
            hnwExtQuery.AddData(vo.getString("CONT_AMT"));	// 사회공헌기금
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));	// 실지급액

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
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>