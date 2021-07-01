<!--
***********************************************************************
* @source      : ymaa050.jsp
* @description : 소득공제항목별 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/28      김학수        최초작성.
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
    String PIS_YM      = request.getParameter("PIS_YM");
    String PIS_YY      = request.getParameter("PIS_YY");
    String PIS_MM      = request.getParameter("PIS_MM");
    String DED_CD      = request.getParameter("DED_CD");
    String SAL_GBN     = request.getParameter("SAL_GBN");
    String OCC_CD      = request.getParameter("OCC_CD");
    String DTP_CD      = request.getParameter("DTP_CD");
    String ORDER_TYPE  = request.getParameter("ORDER_TYPE");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String Query = XmlSqlUtils.getSQL("tax", "TAXA050_SHR");

    StringBuffer Order = new StringBuffer();
    String orderType = ORDER_TYPE;

    System.out.println(DED_CD);
    System.out.println(DED_CD);
    System.out.println(PIS_YY);
    System.out.println(PIS_MM);
    System.out.println(SAL_GBN);
    System.out.println(OCC_CD);
    System.out.println(DTP_CD);

    //param binding 하기
    Object[] bind = new Object[] {
             DED_CD
            ,DED_CD
            ,PIS_YY
            ,PIS_MM
            ,SAL_GBN
            ,OCC_CD
            ,DTP_CD
    };

//    Log.debug.println("ORDER_TYPE:"+orderType);


    //정렬 방식 결정
    if(orderType.equals("DPT")) {
        Order.append("           ORDER BY DPT_SEQ            \n");
        Order.append("                   ,JOB_SEQ            \n");
        Order.append("                   ,ENO_NO             \n");
    }
    else if(orderType.equals("ENO")){
        Order.append("           ORDER BY ENO_NO             \n");
    }

    //DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다
    Object[] sqlParam = new Object[] {
            Order.toString()
    };

    //[1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("순번");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("공제대상금액");
    hnwExtQuery.AddField("공제금액");
    hnwExtQuery.AddField("비고");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//            hnwExtQuery.AddData(i);
            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("TDED_AMT"));
            hnwExtQuery.AddData(vo.getString("DED_AMT"));
            hnwExtQuery.AddData(vo.getString("REMARK"));

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

        hnwExtQuery.SendData(response);
    }

%>