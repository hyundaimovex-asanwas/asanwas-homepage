<!--
***********************************************************************
* @source      : ymaa030.jsp
* @description : 연차수당지급내역 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/27      김학수        최초작성.
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
    String PIS_YYMM_SHR  = request.getParameter("PIS_YYMM_SHR");
    String OCC_CD_SHR    = request.getParameter("OCC_CD_SHR");
    String SORT_SHR      = request.getParameter("SORT_SHR");

    String sql = "";

    if ( SORT_SHR.equals("1") ) {
        /** 외부 XML에서 SQL을 읽어 온다 **/
        sql = XmlSqlUtils.getSQL("yma", "YMAA040_SHR");
    } else {
        sql = XmlSqlUtils.getSQL("yma", "YMAA040_SHR_01");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
            OCC_CD_SHR,
            PIS_YYMM_SHR.replaceAll("-", "").substring(0,4),
            PIS_YYMM_SHR.replaceAll("-", "").substring(4,6),
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("순번");
    if ( OCC_CD_SHR.equals("1") ) {
        /** 외부 XML에서 SQL을 읽어 온다 **/
    	hnwExtQuery.AddField("소속");
    } else {
    	hnwExtQuery.AddField("직위");
    }

    hnwExtQuery.AddField("인원");
    hnwExtQuery.AddField("통상임금");
    hnwExtQuery.AddField("지급액");
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
            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_CNT"));
            hnwExtQuery.AddData(vo.getString("MNOR_WAG"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
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
    }

%>