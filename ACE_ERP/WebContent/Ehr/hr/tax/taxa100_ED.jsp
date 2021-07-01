<!--
***********************************************************************
* @source      : taxa100_ED.jsp                                                *
* @description : 직위별부서별공제현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/05      김학수        최초작성.
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
    String STR_YM  = request.getParameter("STR_YM");
    String END_YM  = request.getParameter("END_YM");
    String OCC_CD1  = request.getParameter("OCC_CD1");
    String OCC_CD2  = request.getParameter("OCC_CD2");
    String SAL_GBN = request.getParameter("SAL_GBN");
    String SEQ     = request.getParameter("SEQ");
    String LUN_AMT = request.getParameter("LUN_AMT");
    String Query = "";
    /** 외부 XML에서 SQL을 읽어 온다 **/
    if ( SEQ.equals("10") ) {
        Query = XmlSqlUtils.getSQL("tax", "TAXA100_SHR1");
    } else if ( SEQ.equals("20") ) {
        Query = XmlSqlUtils.getSQL("tax", "TAXA100_SHR2");
    } else {
        Query = XmlSqlUtils.getSQL("tax", "TAXA100_SHR3");
    }

    //param binding 하기
    Object[] bind = new Object[] {
            OCC_CD1,
            OCC_CD2,
        SAL_GBN,
        STR_YM.replaceAll("-", ""),
        END_YM.replaceAll("-", "")
    };

//    Log.debug.println("ORDER_TYPE:"+orderType);



    //DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다
    Object[] sqlParam = new Object[] {

    };

    //[1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("직급/부서");
    hnwExtQuery.AddField("인원");
    hnwExtQuery.AddField("급여계");
    hnwExtQuery.AddField("공제액계");
    hnwExtQuery.AddField("차인지급액");
    hnwExtQuery.AddField("재형공제계");
    hnwExtQuery.AddField("갑근세");
    hnwExtQuery.AddField("주민세");
    hnwExtQuery.AddField("공조회비");
    hnwExtQuery.AddField("건강보험료");
    hnwExtQuery.AddField("국민연금");
    hnwExtQuery.AddField("고용보험");
    hnwExtQuery.AddField("저축액");
    hnwExtQuery.AddField("금고출자금");
    hnwExtQuery.AddField("융자상환금");
    hnwExtQuery.AddField("가지급금");
    hnwExtQuery.AddField("기타공제엑");
    hnwExtQuery.AddField("중식대");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPTJOB_NM"));
            hnwExtQuery.AddData(vo.getString("CNT"));
            if ( LUN_AMT.equals("Y") ) {
            	hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            } else {
                hnwExtQuery.AddData(Integer.toString(Integer.parseInt(vo.getString("SALT_AMT")) - Integer.parseInt(vo.getString("LUN_AMT"))));
            }
            hnwExtQuery.AddData(vo.getString("DDTT_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
            hnwExtQuery.AddData(vo.getString("STAX_DED"));
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));
            hnwExtQuery.AddData(vo.getString("DHLP_AMT"));
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("SAV_AMT"));
            hnwExtQuery.AddData(vo.getString("INV_AMT"));
            hnwExtQuery.AddData(vo.getString("LON_RPY"));
            hnwExtQuery.AddData(vo.getString("ADV_AMT"));
            hnwExtQuery.AddData(vo.getString("ECT"));
            hnwExtQuery.AddData(vo.getString("LUN_AMT"));
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
        hnwExtQuery.SendData(response);
    }

%>