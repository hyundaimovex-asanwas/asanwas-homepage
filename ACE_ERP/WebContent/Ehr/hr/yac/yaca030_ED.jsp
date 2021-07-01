<!--
***********************************************************************
* @source      : yaca030_ED.jsp
* @description : 의료비지급명세서 PAGE
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

//  --------------------------------회사정보 조회--------------------------------------------------------
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
    String sql1 = XmlSqlUtils.getSQL("yac", "YACA030_SHR_02");

    String eno_nm = "";
    String addr   = "";
    String cet_no = "";

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
    }

//-----------------------------------------------------------------------------------------

//--------------------------------의료비공제내역 조회--------------------------------------------------------

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql2 = XmlSqlUtils.getSQL("yac", "YACA030_SHR");

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

    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("주소");
    hnwExtQuery.AddField("사업자등록번호");
    hnwExtQuery.AddField("상호");
    hnwExtQuery.AddField("카드건수");
    hnwExtQuery.AddField("현금건수");
    hnwExtQuery.AddField("건수");
    hnwExtQuery.AddField("카드금액");
    hnwExtQuery.AddField("현금금액");
    hnwExtQuery.AddField("금액");
    hnwExtQuery.AddField("관계");
    hnwExtQuery.AddField("대상자 주민등록번호");
    hnwExtQuery.AddField("본인 등 해당여부");
    hnwExtQuery.AddField("회사상호");
    hnwExtQuery.AddField("회사사업자등록번호");
    hnwExtQuery.AddField("회사주소");
    hnwExtQuery.AddField("회사전화번호");
    hnwExtQuery.AddField("의료증빙코드");

    hnwExtQuery.SendField(response);

    //System.out.println("voList.size()="+voList2.size());
    int i = 0;
    int k = 0;
    int row_size = 0;
    row_size = 10 - (voList2.size()%10) + (voList2.size()/10);

    if (voList2.size() > 0)
    {
        for ( i=0; i<voList2.size(); i++ )
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);

            if ( vo2.getString("GBN_TAG").equals("A") || vo2.getString("GBN_TAG").equals("B") || vo2.getString("REL_CD").equals("0") ) {
                gbn_tag = "Ｏ";
            } else {
                gbn_tag = "X";
            }

            hnwExtQuery.AddData(eno_nm);
            hnwExtQuery.AddData(cet_no);
            hnwExtQuery.AddData(addr);
            hnwExtQuery.AddData(vo2.getString("COM_NO"));
            hnwExtQuery.AddData(vo2.getString("COM_NM"));
            hnwExtQuery.AddData(vo2.getString("CARD_CNT"));
            hnwExtQuery.AddData(vo2.getString("CASH_CNT"));
            hnwExtQuery.AddData(vo2.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo2.getString("CARD_AMT"));
            hnwExtQuery.AddData(vo2.getString("CASH_AMT"));
            hnwExtQuery.AddData(vo2.getString("SUM_AMT"));
            hnwExtQuery.AddData(vo2.getString("REL_CD"));
            hnwExtQuery.AddData(vo2.getString("CET_NO"));

            hnwExtQuery.AddData(gbn_tag);

            hnwExtQuery.AddData(COMP_NM);
            hnwExtQuery.AddData(TAX_NO);
            hnwExtQuery.AddData(C_ADDR);
            hnwExtQuery.AddData(TEL_NO);
            hnwExtQuery.AddData(vo2.getString("MED_CD"));

            hnwExtQuery.SendData(response);
        }

        for ( k=0; k<row_size; k++ )
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

            hnwExtQuery.SendData(response);
        }

    } else {
        for ( k=0; k<10; k++ )
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


            hnwExtQuery.SendData(response);
        }
    }

%>