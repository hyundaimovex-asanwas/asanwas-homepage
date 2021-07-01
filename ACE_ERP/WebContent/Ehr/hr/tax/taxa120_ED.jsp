<!--
***********************************************************************
* @source      : taxa120_ED.jsp                                                *
* @description : 은행송금명세서 PAGE  
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/03      김학수        최초작성.        
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
    String PIS_YM   = request.getParameter("PIS_YM");
    String OCC_CD   = request.getParameter("OCC_CD");
    String SAL_GBN  = request.getParameter("SAL_GBN");
    String LC_SEQ   = request.getParameter("LC_SEQ");
    String ABA_CD   = request.getParameter("ABA_CD");
   
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String Query = "";

    // 외환은행, 기타은행 경우
    if ( ABA_CD.equals("10") ) {
        Query = XmlSqlUtils.getSQL("tax", "TAXA120_SHR1");
    } else {
        Query = XmlSqlUtils.getSQL("tax", "TAXA120_SHR2");
    }

    //DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다
    Object[] sqlParam = new Object[] {

    };
    
    //[1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    //param binding 하기
    Object[] bind = new Object[] {
             OCC_CD 
            ,SAL_GBN
            ,LC_SEQ    
            ,PIS_YM.replaceAll("-", "") 
            ,PIS_YM.replaceAll("-", "")
            ,OCC_CD 
            ,SAL_GBN
            ,LC_SEQ    
            ,PIS_YM.replaceAll("-", "") 
            ,PIS_YM.replaceAll("-", "") 
    };
   

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("은행명");
    hnwExtQuery.AddField("사원번호");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("수취인");
    hnwExtQuery.AddField("계좌번호");
    hnwExtQuery.AddField("송금액");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//            hnwExtQuery.AddData(i);
            hnwExtQuery.AddData(vo.getString("ABA"));
            hnwExtQuery.AddData(vo.getString("ENO"));
            hnwExtQuery.AddData(vo.getString("NAM"));
            hnwExtQuery.AddData(vo.getString("REC"));
            hnwExtQuery.AddData(vo.getString("ACC"));
            hnwExtQuery.AddData(vo.getString("PAY"));
            hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.SendData(response);
    }

%>