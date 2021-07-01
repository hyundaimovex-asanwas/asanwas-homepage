<!--
***********************************************************************
* @source      : yaca040_ED.jsp
* @description : 기부금명세서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/10      김학수        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
    String pis_yy = request.getParameter("pis_yy");
    String eno_no = request.getParameter("eno_no");

//--------------------------------회사정보 조회--------------------------------------------------------
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql3 = XmlSqlUtils.getSQL("yac", "YACA040_SHR_03");

    String COMP_NM = "";
    String TAX_NO  = "";
    String C_ADDR  = "";
    String TEL_NO  = "";

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam3 = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql3 = SqlUtils.replaceQuery(sql3, sqlParam3);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind3 = new Object[] {
    };

    AbstractDAO aaa3= new AbstractDAO("default");
    DynamicValueObject voList3 = aaa3.selectProcessDvo(sql3, bind3);

    if (voList3.size() > 0)
    {
        DynamicValueObject vo3 = (DynamicValueObject)voList3.get(0);
        COMP_NM = vo3.getString("COMP_NM");
        TAX_NO  = vo3.getString("TAX_NO");
        C_ADDR    = vo3.getString("ADDR");
        TEL_NO  = vo3.getString("TEL_NO");
    }

//-----------------------------------------------------------------------------------------

//--------------------------------사원정보 조회--------------------------------------------------------
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql1 = XmlSqlUtils.getSQL("yac", "YACA040_SHR_02");

    String eno_nm = "";
    String addr   = "";
    String cet_no = "";
    String PHN_NO = "";
    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam1 = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql1 = SqlUtils.replaceQuery(sql1, sqlParam1);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind1 = new Object[] {
        eno_no
    };

    AbstractDAO aaa1= new AbstractDAO("default");
    DynamicValueObject voList1 = aaa1.selectProcessDvo(sql1, bind1);
    String[] gubun  = new String[voList1.size()];

    if (voList1.size() > 0)
    {
        DynamicValueObject vo1 = (DynamicValueObject)voList1.get(0);
        eno_nm = vo1.getString("ENO_NM");
        cet_no = vo1.getString("CET_NO");
        addr   = vo1.getString("ADDR");
        PHN_NO = vo1.getString("PHN_NO");
    }

//-----------------------------------------------------------------------------------------

//--------------------------------기부금공제내역 조회--------------------------------------------------------

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql2 = XmlSqlUtils.getSQL("yac", "YACA040_SHR_01");

    String gbn_tag = "";

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam2 = new Object[] {

    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind2 = new Object[] {
        pis_yy, eno_no
    };

    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);
//-----------------------------------------------------------------------------------------

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("상호");
    hnwExtQuery.AddField("사업자등록번호");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("주소");
    hnwExtQuery.AddField("전화번호");
    hnwExtQuery.AddField("사업장소재지");
    hnwExtQuery.AddField("사업장전화번호");

    hnwExtQuery.AddField("유형");
    hnwExtQuery.AddField("코드");
    hnwExtQuery.AddField("기부내용");
    hnwExtQuery.AddField("연월");
    hnwExtQuery.AddField("일련번호");
    hnwExtQuery.AddField("적요");
    hnwExtQuery.AddField("기부처상호");
    hnwExtQuery.AddField("기부처사업자등록번호");
    hnwExtQuery.AddField("건수");
    hnwExtQuery.AddField("금액");

    hnwExtQuery.AddField("기부자관계");
    hnwExtQuery.AddField("기부자성명");
    hnwExtQuery.AddField("기부자주민번호");

    hnwExtQuery.AddField("합계_10");
    hnwExtQuery.AddField("합계_20");
    hnwExtQuery.AddField("합계_30");
    hnwExtQuery.AddField("합계_31");
    hnwExtQuery.AddField("합계_40");
    hnwExtQuery.AddField("합계_41");
    hnwExtQuery.AddField("합계_42");
    hnwExtQuery.AddField("합계_50");

    hnwExtQuery.AddField("본인_10");
    hnwExtQuery.AddField("본인_20");
    hnwExtQuery.AddField("본인_30");
    hnwExtQuery.AddField("본인_31");
    hnwExtQuery.AddField("본인_40");
    hnwExtQuery.AddField("본인_41");
    hnwExtQuery.AddField("본인_42");
    hnwExtQuery.AddField("본인_50");

    hnwExtQuery.AddField("배우자_10");
    hnwExtQuery.AddField("배우자_20");
    hnwExtQuery.AddField("배우자_30");
    hnwExtQuery.AddField("배우자_31");
    hnwExtQuery.AddField("배우자_40");
    hnwExtQuery.AddField("배우자_41");
    hnwExtQuery.AddField("배우자_42");
    hnwExtQuery.AddField("배우자_50");

    hnwExtQuery.AddField("비속_10");
    hnwExtQuery.AddField("비속_20");
    hnwExtQuery.AddField("비속_30");
    hnwExtQuery.AddField("비속_31");
    hnwExtQuery.AddField("비속_40");
    hnwExtQuery.AddField("비속_41");
    hnwExtQuery.AddField("비속_42");
    hnwExtQuery.AddField("비속_50");

    hnwExtQuery.AddField("존속_10");
    hnwExtQuery.AddField("존속_20");
    hnwExtQuery.AddField("존속_30");
    hnwExtQuery.AddField("존속_31");
    hnwExtQuery.AddField("존속_40");
    hnwExtQuery.AddField("존속_41");
    hnwExtQuery.AddField("존속_42");
    hnwExtQuery.AddField("존속_50");

    hnwExtQuery.AddField("형제_10");
    hnwExtQuery.AddField("형제_20");
    hnwExtQuery.AddField("형제_30");
    hnwExtQuery.AddField("형제_31");
    hnwExtQuery.AddField("형제_40");
    hnwExtQuery.AddField("형제_41");
    hnwExtQuery.AddField("형제_42");
    hnwExtQuery.AddField("형제_50");

    hnwExtQuery.AddField("그외_10");
    hnwExtQuery.AddField("그외_20");
    hnwExtQuery.AddField("그외_30");
    hnwExtQuery.AddField("그외_31");
    hnwExtQuery.AddField("그외_40");
    hnwExtQuery.AddField("그외_41");
    hnwExtQuery.AddField("그외_42");
    hnwExtQuery.AddField("그외_50");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;
    int k = 0;
    int row_size = 0;
    int tot_cnt  = 0;
    String A_10  = "0";
    String B_20  = "0";
    String D_30  = "0";
    String D_31  = "0";
    String E_40  = "0";
    String F_41  = "0";
    String G_42  = "0";
    String H_50  = "0";

    String A_10_1  = "0";
    String B_20_1  = "0";
    String D_30_1  = "0";
    String D_31_1  = "0";
    String E_40_1  = "0";
    String F_41_1  = "0";
    String G_42_1  = "0";
    String H_50_1  = "0";

    String A_10_2  = "0";
    String B_20_2  = "0";
    String D_30_2  = "0";
    String D_31_2  = "0";
    String E_40_2  = "0";
    String F_41_2  = "0";
    String G_42_2  = "0";
    String H_50_2  = "0";

    String A_10_3  = "0";
    String B_20_3  = "0";
    String D_30_3  = "0";
    String D_31_3  = "0";
    String E_40_3  = "0";
    String F_41_3  = "0";
    String G_42_3  = "0";
    String H_50_3  = "0";

    String A_10_4  = "0";
    String B_20_4  = "0";
    String D_30_4  = "0";
    String D_31_4  = "0";
    String E_40_4  = "0";
    String F_41_4  = "0";
    String G_42_4  = "0";
    String H_50_4  = "0";

    String A_10_5  = "0";
    String B_20_5  = "0";
    String D_30_5  = "0";
    String D_31_5  = "0";
    String E_40_5  = "0";
    String F_41_5  = "0";
    String G_42_5  = "0";
    String H_50_5  = "0";

    String A_10_6  = "0";
    String B_20_6  = "0";
    String D_30_6  = "0";
    String D_31_6  = "0";
    String E_40_6  = "0";
    String F_41_6  = "0";
    String G_42_6  = "0";
    String H_50_6  = "0";

    if (voList2.size() > 0)
    {
        for ( i=0; i<voList2.size(); i++ )
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);

            if ( vo2.getString("GUBUN").equals("1") ) {
                tot_cnt = tot_cnt + 1;
                if ( vo2.getString("REL_CD").equals("10") ) A_10 = Long.toString(Long.parseLong(A_10) + Long.parseLong(vo2.getString("SUM_AMT")));
                if ( vo2.getString("REL_CD").equals("20") ) B_20 = Long.toString(Long.parseLong(B_20) + Long.parseLong(vo2.getString("SUM_AMT")));
                if ( vo2.getString("REL_CD").equals("30") ) D_30 = Long.toString(Long.parseLong(D_30) + Long.parseLong(vo2.getString("SUM_AMT")));
                if ( vo2.getString("REL_CD").equals("31") ) D_31 = Long.toString(Long.parseLong(D_31) + Long.parseLong(vo2.getString("SUM_AMT")));
                if ( vo2.getString("REL_CD").equals("40") ) E_40 = Long.toString(Long.parseLong(E_40) + Long.parseLong(vo2.getString("SUM_AMT")));
                if ( vo2.getString("REL_CD").equals("41") ) F_41 = Long.toString(Long.parseLong(F_41) + Long.parseLong(vo2.getString("SUM_AMT")));
                if ( vo2.getString("REL_CD").equals("42") ) G_42 = Long.toString(Long.parseLong(G_42) + Long.parseLong(vo2.getString("SUM_AMT")));
                if ( vo2.getString("REL_CD").equals("50") ) H_50 = Long.toString(Long.parseLong(H_50) + Long.parseLong(vo2.getString("SUM_AMT")));

                if( vo2.getString("FAM_CD").equals("1")){
	                if ( vo2.getString("REL_CD").equals("10") ) A_10_1 = Long.toString(Long.parseLong(A_10_1) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("20") ) B_20_1 = Long.toString(Long.parseLong(B_20_1) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("30") ) D_30_1 = Long.toString(Long.parseLong(D_30_1) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("31") ) D_31_1 = Long.toString(Long.parseLong(D_31_1) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("40") ) E_40_1 = Long.toString(Long.parseLong(E_40_1) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("41") ) F_41_1 = Long.toString(Long.parseLong(F_41_1) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("42") ) G_42_1 = Long.toString(Long.parseLong(G_42_1) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("50") ) H_50_1 = Long.toString(Long.parseLong(H_50_1) + Long.parseLong(vo2.getString("SUM_AMT")));
                }else if( vo2.getString("FAM_CD").equals("2")){
                	if ( vo2.getString("REL_CD").equals("10") ) A_10_2 = Long.toString(Long.parseLong(A_10_2) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("20") ) B_20_2 = Long.toString(Long.parseLong(B_20_2) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("30") ) D_30_2 = Long.toString(Long.parseLong(D_30_2) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("31") ) D_31_2 = Long.toString(Long.parseLong(D_31_2) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("40") ) E_40_2 = Long.toString(Long.parseLong(E_40_2) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("41") ) F_41_2 = Long.toString(Long.parseLong(F_41_2) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("42") ) G_42_2 = Long.toString(Long.parseLong(G_42_2) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("50") ) H_50_2 = Long.toString(Long.parseLong(H_50_2) + Long.parseLong(vo2.getString("SUM_AMT")));

                }else if( vo2.getString("FAM_CD").equals("3")){
                	if ( vo2.getString("REL_CD").equals("10") ) A_10_3 = Long.toString(Long.parseLong(A_10_3) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("20") ) B_20_3 = Long.toString(Long.parseLong(B_20_3) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("30") ) D_30_3 = Long.toString(Long.parseLong(D_30_3) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("31") ) D_31_3 = Long.toString(Long.parseLong(D_31_3) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("40") ) E_40_3 = Long.toString(Long.parseLong(E_40_3) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("41") ) F_41_3 = Long.toString(Long.parseLong(F_41_3) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("42") ) G_42_3 = Long.toString(Long.parseLong(G_42_3) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("50") ) H_50_3 = Long.toString(Long.parseLong(H_50_3) + Long.parseLong(vo2.getString("SUM_AMT")));
                }else if( vo2.getString("FAM_CD").equals("4")){
                	if ( vo2.getString("REL_CD").equals("10") ) A_10_4 = Long.toString(Long.parseLong(A_10_4) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("20") ) B_20_4 = Long.toString(Long.parseLong(B_20_4) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("30") ) D_30_4 = Long.toString(Long.parseLong(D_30_4) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("31") ) D_31_4 = Long.toString(Long.parseLong(D_31_4) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("40") ) E_40_4 = Long.toString(Long.parseLong(E_40_4) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("41") ) F_41_4 = Long.toString(Long.parseLong(F_41_4) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("42") ) G_42_4 = Long.toString(Long.parseLong(G_42_4) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("50") ) H_50_4 = Long.toString(Long.parseLong(H_50_4) + Long.parseLong(vo2.getString("SUM_AMT")));
                }else if( vo2.getString("FAM_CD").equals("5")){
                	if ( vo2.getString("REL_CD").equals("10") ) A_10_5 = Long.toString(Long.parseLong(A_10_5) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("20") ) B_20_5 = Long.toString(Long.parseLong(B_20_5) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("30") ) D_30_5 = Long.toString(Long.parseLong(D_30_5) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("31") ) D_31_5 = Long.toString(Long.parseLong(D_31_5) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("40") ) E_40_5 = Long.toString(Long.parseLong(E_40_5) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("41") ) F_41_5 = Long.toString(Long.parseLong(F_41_5) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("42") ) G_42_5 = Long.toString(Long.parseLong(G_42_5) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("50") ) H_50_5 = Long.toString(Long.parseLong(H_50_5) + Long.parseLong(vo2.getString("SUM_AMT")));
                }else if( vo2.getString("FAM_CD").equals("6")){
                	if ( vo2.getString("REL_CD").equals("10") ) A_10_6 = Long.toString(Long.parseLong(A_10_6) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("20") ) B_20_6 = Long.toString(Long.parseLong(B_20_6) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("30") ) D_30_6 = Long.toString(Long.parseLong(D_30_6) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("31") ) D_31_6 = Long.toString(Long.parseLong(D_31_6) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("40") ) E_40_6 = Long.toString(Long.parseLong(E_40_6) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("41") ) F_41_6 = Long.toString(Long.parseLong(F_41_6) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("42") ) G_42_6 = Long.toString(Long.parseLong(G_42_6) + Long.parseLong(vo2.getString("SUM_AMT")));
	                if ( vo2.getString("REL_CD").equals("50") ) H_50_6 = Long.toString(Long.parseLong(H_50_6) + Long.parseLong(vo2.getString("SUM_AMT")));
                }


               // E_40 = Long.toString(Long.parseLong(E_40) + Long.parseLong(F_41));

            } else {
                hnwExtQuery.AddData(COMP_NM);
                hnwExtQuery.AddData(TAX_NO);
                hnwExtQuery.AddData(eno_nm);
                hnwExtQuery.AddData(cet_no);
                hnwExtQuery.AddData(addr);
                hnwExtQuery.AddData(PHN_NO);
                hnwExtQuery.AddData(C_ADDR);
                hnwExtQuery.AddData(TEL_NO);

                hnwExtQuery.AddData(vo2.getString("REL_NM"));
                hnwExtQuery.AddData(vo2.getString("REL_CD"));
                hnwExtQuery.AddData(vo2.getString("REMARK"));
                hnwExtQuery.AddData(vo2.getString("PIS_YM"));
                hnwExtQuery.AddData(vo2.getString("SEQ_NO"));
                hnwExtQuery.AddData("");
                hnwExtQuery.AddData(vo2.getString("COM_NM"));
                hnwExtQuery.AddData(vo2.getString("COM_NO"));
                hnwExtQuery.AddData(vo2.getString("TOT_CNT"));
                hnwExtQuery.AddData(vo2.getString("SUM_AMT"));

                hnwExtQuery.AddData(vo2.getString("FAM_CD"));
                hnwExtQuery.AddData(vo2.getString("FAM_NM"));
                hnwExtQuery.AddData(vo2.getString("FAM_NO"));

                hnwExtQuery.AddData(A_10.equals("0") ? "" : A_10);
                hnwExtQuery.AddData(B_20.equals("0") ? "" : B_20);
                hnwExtQuery.AddData(D_30.equals("0") ? "" : D_30);
                hnwExtQuery.AddData(D_31.equals("0") ? "" : D_31);
                hnwExtQuery.AddData(E_40.equals("0") ? "" : E_40);
                hnwExtQuery.AddData(F_41.equals("0") ? "" : F_41);
                hnwExtQuery.AddData(G_42.equals("0") ? "" : G_42);
                hnwExtQuery.AddData(H_50.equals("0") ? "" : H_50);

                hnwExtQuery.AddData(A_10_1.equals("0") ? "" : A_10_1);
                hnwExtQuery.AddData(B_20_1.equals("0") ? "" : B_20_1);
                hnwExtQuery.AddData(D_30_1.equals("0") ? "" : D_30_1);
                hnwExtQuery.AddData(D_31_1.equals("0") ? "" : D_31_1);
                hnwExtQuery.AddData(E_40_1.equals("0") ? "" : E_40_1);
                hnwExtQuery.AddData(F_41_1.equals("0") ? "" : F_41_1);
                hnwExtQuery.AddData(G_42_1.equals("0") ? "" : G_42_1);
                hnwExtQuery.AddData(H_50_1.equals("0") ? "" : H_50_1);

                hnwExtQuery.AddData(A_10_2.equals("0") ? "" : A_10_2);
                hnwExtQuery.AddData(B_20_2.equals("0") ? "" : B_20_2);
                hnwExtQuery.AddData(D_30_2.equals("0") ? "" : D_30_2);
                hnwExtQuery.AddData(D_31_2.equals("0") ? "" : D_31_2);
                hnwExtQuery.AddData(E_40_2.equals("0") ? "" : E_40_2);
                hnwExtQuery.AddData(F_41_2.equals("0") ? "" : F_41_2);
                hnwExtQuery.AddData(G_42_2.equals("0") ? "" : G_42_2);
                hnwExtQuery.AddData(H_50_2.equals("0") ? "" : H_50_2);

                hnwExtQuery.AddData(A_10_3.equals("0") ? "" : A_10_3);
                hnwExtQuery.AddData(B_20_3.equals("0") ? "" : B_20_3);
                hnwExtQuery.AddData(D_30_3.equals("0") ? "" : D_30_3);
                hnwExtQuery.AddData(D_31_3.equals("0") ? "" : D_31_3);
                hnwExtQuery.AddData(E_40_3.equals("0") ? "" : E_40_3);
                hnwExtQuery.AddData(F_41_3.equals("0") ? "" : F_41_3);
                hnwExtQuery.AddData(G_42_3.equals("0") ? "" : G_42_3);
                hnwExtQuery.AddData(H_50_3.equals("0") ? "" : H_50_3);

                hnwExtQuery.AddData(A_10_4.equals("0") ? "" : A_10_4);
                hnwExtQuery.AddData(B_20_4.equals("0") ? "" : B_20_4);
                hnwExtQuery.AddData(D_30_4.equals("0") ? "" : D_30_4);
                hnwExtQuery.AddData(D_31_4.equals("0") ? "" : D_31_4);
                hnwExtQuery.AddData(E_40_4.equals("0") ? "" : E_40_4);
                hnwExtQuery.AddData(F_41_4.equals("0") ? "" : F_41_4);
                hnwExtQuery.AddData(G_42_4.equals("0") ? "" : G_42_4);
                hnwExtQuery.AddData(H_50_4.equals("0") ? "" : H_50_4);

                hnwExtQuery.AddData(A_10_5.equals("0") ? "" : A_10_5);
                hnwExtQuery.AddData(B_20_5.equals("0") ? "" : B_20_5);
                hnwExtQuery.AddData(D_30_5.equals("0") ? "" : D_30_5);
                hnwExtQuery.AddData(D_31_5.equals("0") ? "" : D_31_5);
                hnwExtQuery.AddData(E_40_5.equals("0") ? "" : E_40_5);
                hnwExtQuery.AddData(F_41_5.equals("0") ? "" : F_41_5);
                hnwExtQuery.AddData(G_42_5.equals("0") ? "" : G_42_5);
                hnwExtQuery.AddData(H_50_5.equals("0") ? "" : H_50_5);

                hnwExtQuery.AddData(A_10_6.equals("0") ? "" : A_10_6);
                hnwExtQuery.AddData(B_20_6.equals("0") ? "" : B_20_6);
                hnwExtQuery.AddData(D_30_6.equals("0") ? "" : D_30_6);
                hnwExtQuery.AddData(D_31_6.equals("0") ? "" : D_31_6);
                hnwExtQuery.AddData(E_40_6.equals("0") ? "" : E_40_6);
                hnwExtQuery.AddData(F_41_6.equals("0") ? "" : F_41_6);
                hnwExtQuery.AddData(G_42_6.equals("0") ? "" : G_42_6);
                hnwExtQuery.AddData(H_50_6.equals("0") ? "" : H_50_6);

                hnwExtQuery.SendData(response);
            }
        }

        for ( k=0; k<8-((voList2.size()-tot_cnt)%8); k++ )
        {
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
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
        }

    } else {
        for ( k=0; k<8; k++ )
        {
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
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
        }
    }

%>