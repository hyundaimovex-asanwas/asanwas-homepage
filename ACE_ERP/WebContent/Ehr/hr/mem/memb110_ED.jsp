<!--
***********************************************************************
* @source      : memb110_ED.jsp
* @description : 파견사원 관리대장 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25      김학수        최초작성.        
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
    String str_ymd = request.getParameter("str_ymd");
    String eno_no  = request.getParameter("eno_no");
    String str_ymd_val = "";
    String str_y       = str_ymd.substring(0,4);
    String str_m       = str_ymd.substring(5,7);
    
    str_ymd_val = str_y + str_m;
    String title_val   = "( " + str_y + " 년   " + str_m + "월 )";

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB110_SHR_03");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        eno_no, str_ymd
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("시업시각");
    hnwExtQuery.AddField("종업시각");
    hnwExtQuery.AddField("근무시간");
    hnwExtQuery.AddField("휴식시간");
    hnwExtQuery.AddField("업무내용");
    hnwExtQuery.AddField("파견회사명");
    hnwExtQuery.AddField("파견직원명");
    hnwExtQuery.AddField("근무장소");
    hnwExtQuery.AddField("업무관리자");
    hnwExtQuery.AddField("날짜");

    hnwExtQuery.SendField(response);
    
    String str_hms = "";
    String end_hms = "";
    String gun_hms = "";
    String rest_hms = "";
//    System.out.println("voList.size()="+voList.size());
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            if ( ! vo.getString("STR_HMS").equals("") ) str_hms = vo.getString("STR_HMS").substring(0,2) + ":" + vo.getString("STR_HMS").substring(2,4);
            if ( ! vo.getString("END_HMS").equals("") ) end_hms = vo.getString("END_HMS").substring(0,2) + ":" + vo.getString("END_HMS").substring(2,4);
            if ( ! vo.getString("GUN_HMS").equals("") ) gun_hms = vo.getString("GUN_HMS").substring(0,2) + ":" + vo.getString("GUN_HMS").substring(2,4);
            if ( ! vo.getString("REST_HMS").equals("") )rest_hms = vo.getString("REST_HMS").substring(0,2) + ":" + vo.getString("REST_HMS").substring(2,4);

            hnwExtQuery.AddData(i + 1);
            hnwExtQuery.AddData(str_hms);
            hnwExtQuery.AddData(end_hms);
            hnwExtQuery.AddData(gun_hms);
            hnwExtQuery.AddData(rest_hms);
            hnwExtQuery.AddData(vo.getString("JOB_TAG"));
            hnwExtQuery.AddData(vo.getString("DISCOMP_CD"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("REG_CD"));
            hnwExtQuery.AddData(vo.getString("SYENO_NM"));
            hnwExtQuery.AddData(title_val);

            hnwExtQuery.SendData(response);

            str_hms = "";
            end_hms = "";
            gun_hms = "";
            rest_hms = "";
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
            
            hnwExtQuery.SendData(response);
    }

%>