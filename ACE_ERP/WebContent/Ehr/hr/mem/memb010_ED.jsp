<!--
***********************************************************************
* @source      : memb010_ED.jsp
* @description : 파견사원 근태현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/12      김학수        최초작성.        
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
    String eno_no     = request.getParameter("eno_no");
    String pis_yy     = request.getParameter("pis_yy");
    String pis_mm_str = request.getParameter("pis_mm_str");
    String pis_mm_end = request.getParameter("pis_mm_end");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB010_SHR");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        eno_no, pis_yy, pis_mm_str, pis_mm_end, eno_no
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("구분");
    hnwExtQuery.AddField("1");
    hnwExtQuery.AddField("2");
    hnwExtQuery.AddField("3");
    hnwExtQuery.AddField("4");
    hnwExtQuery.AddField("5");
    hnwExtQuery.AddField("6");
    hnwExtQuery.AddField("7");
    hnwExtQuery.AddField("8");
    hnwExtQuery.AddField("9");
    hnwExtQuery.AddField("10");
    hnwExtQuery.AddField("11");
    hnwExtQuery.AddField("12");
    hnwExtQuery.AddField("13");
    hnwExtQuery.AddField("14");
    hnwExtQuery.AddField("15");
    hnwExtQuery.AddField("16");
    hnwExtQuery.AddField("17");
    hnwExtQuery.AddField("18");
    hnwExtQuery.AddField("19");
    hnwExtQuery.AddField("20");
    hnwExtQuery.AddField("21");
    hnwExtQuery.AddField("22");
    hnwExtQuery.AddField("23");
    hnwExtQuery.AddField("24");
    hnwExtQuery.AddField("25");
    hnwExtQuery.AddField("26");
    hnwExtQuery.AddField("27");
    hnwExtQuery.AddField("28");
    hnwExtQuery.AddField("29");
    hnwExtQuery.AddField("30");
    hnwExtQuery.AddField("31");
    hnwExtQuery.AddField("성명" );
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("파견회사");
    hnwExtQuery.AddField("근무부서");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("GUBUN_YM"));
            hnwExtQuery.AddData(vo.getString("1"));
            hnwExtQuery.AddData(vo.getString("2"));
            hnwExtQuery.AddData(vo.getString("3"));
            hnwExtQuery.AddData(vo.getString("4"));
            hnwExtQuery.AddData(vo.getString("5"));
            hnwExtQuery.AddData(vo.getString("6"));
            hnwExtQuery.AddData(vo.getString("7"));
            hnwExtQuery.AddData(vo.getString("8"));
            hnwExtQuery.AddData(vo.getString("9"));
            hnwExtQuery.AddData(vo.getString("10"));
            hnwExtQuery.AddData(vo.getString("11"));
            hnwExtQuery.AddData(vo.getString("12"));
            hnwExtQuery.AddData(vo.getString("13"));
            hnwExtQuery.AddData(vo.getString("14"));
            hnwExtQuery.AddData(vo.getString("15"));
            hnwExtQuery.AddData(vo.getString("16"));
            hnwExtQuery.AddData(vo.getString("17"));
            hnwExtQuery.AddData(vo.getString("18"));
            hnwExtQuery.AddData(vo.getString("19"));
            hnwExtQuery.AddData(vo.getString("20"));
            hnwExtQuery.AddData(vo.getString("21"));
            hnwExtQuery.AddData(vo.getString("22"));
            hnwExtQuery.AddData(vo.getString("23"));
            hnwExtQuery.AddData(vo.getString("24"));
            hnwExtQuery.AddData(vo.getString("25"));
            hnwExtQuery.AddData(vo.getString("26"));
            hnwExtQuery.AddData(vo.getString("27"));
            hnwExtQuery.AddData(vo.getString("28"));
            hnwExtQuery.AddData(vo.getString("29"));
            hnwExtQuery.AddData(vo.getString("30"));
            hnwExtQuery.AddData(vo.getString("31"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
  
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