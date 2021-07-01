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
    String pis_yy = request.getParameter("pis_yy");
    String eno_no = request.getParameter("eno_no");

    String Query =  XmlSqlUtils.getSQL("yac", "YACA040_SHR_04");

    //param binding 하기
    Object[] bind = new Object[] {
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		eno_no
    };

//    Log.debug.println("ORDER_TYPE:"+orderType);



    //DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다
    Object[] sqlParam = new Object[] {
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		eno_no

    };

    //[1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("기부금코드");
    hnwExtQuery.AddField("기부연도");
    hnwExtQuery.AddField("기부금액");
    hnwExtQuery.AddField("전년까지공제된금액");
    hnwExtQuery.AddField("공제대상금액");
    hnwExtQuery.AddField("해당연도공제금액");
    hnwExtQuery.AddField("소멸금액");
    hnwExtQuery.AddField("이월금액");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REL_CD"));
            hnwExtQuery.AddData(vo.getString("DON_YY"));
            hnwExtQuery.AddData(vo.getString("ACC_DON_AMT"));
            hnwExtQuery.AddData(vo.getString("ACC_DON_DED"));
            hnwExtQuery.AddData(vo.getString("ACC_DON_DIF"));
            hnwExtQuery.AddData(vo.getString("DON_DED"));
            hnwExtQuery.AddData(vo.getString("EXH_AMT"));
            hnwExtQuery.AddData(vo.getString("VAL_AMT"));
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
        hnwExtQuery.SendData(response);
    }

%>