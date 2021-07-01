<!--
***********************************************************************
* @source      : reta030_ED.jsp
* @description : 퇴직금계산처리(신청내역의 상여금 정보를 조회) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      김학수        최초작성.
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
	String type    = request.getParameter("TYPE");
    String ymd    = request.getParameter("ymd");
    String eno_no = request.getParameter("eno_no");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA030_SHR_BONUS_RET");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
         eno_no, type
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("년원");
    hnwExtQuery.AddField("지급액");
    hnwExtQuery.AddField("연월차");

    hnwExtQuery.SendField(response);

    int i = 0;
    int k = 0;
    int row_size = 0;
    row_size = 12 - (voList.size()%12);
    if ( row_size == 12 ) row_size = 0;
    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("PIS_YM"));
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("SAL_GBN"));

            hnwExtQuery.SendData(response);
        }
        for ( k=0; k<row_size; k++ )
        {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
        }
    } else {
        for ( k=0; k<12; k++ )
        {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
        }
    }

%>