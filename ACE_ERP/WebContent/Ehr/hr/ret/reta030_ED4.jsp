<!--
***********************************************************************
* @source      : yaca030_ED.jsp
* @description : 퇴직금계산처리(사원정보조회) PAGE
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
    String eno_no = request.getParameter("eno_no");

//--------------------------------사원정보 조회--------------------------------------------------------
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA030_SHR_PERSON");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        eno_no
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
//-----------------------------------------------------------------------------------------

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("은행/계좌번호");
    hnwExtQuery.AddField("우편번호");
    hnwExtQuery.AddField("주소1");
    hnwExtQuery.AddField("주소2");

    hnwExtQuery.SendField(response);
    
//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0) {
        DynamicValueObject vo = (DynamicValueObject)voList.get(0);
        
        hnwExtQuery.AddData(vo.getString("CET_NO"));
        hnwExtQuery.AddData(vo.getString("ACC_NO"));
        hnwExtQuery.AddData(vo.getString("ZIP_NO"));
        hnwExtQuery.AddData(vo.getString("ADR_CT"));
        hnwExtQuery.AddData(vo.getString("ADDRESS"));

        hnwExtQuery.SendData(response);
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");      
        hnwExtQuery.SendData(response);
    }

%>