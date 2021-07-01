<!--
***********************************************************************
* @source      : memb120_ED.jsp
* @description : 월별 파견사원 입퇴사자 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/17      김학수        최초작성.        
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
    
    String str_ymd_val = "";
    String str_y       = str_ymd.substring(0,4);
    String str_m       = str_ymd.substring(5,7);

    String title_val   = "";
    String title_m     = "";
    String title_m_val = str_ymd.substring(5,6);
    if ( title_m_val.equals("0") ) {
        title_m = str_ymd.substring(6,7);
    } else {
        title_m = str_ymd.substring(5,7);
    }
    str_ymd_val = str_y + str_m;
    title_val   = str_y + "년 " + title_m + "월 파견사원 입,퇴사자 현황";
    System.out.println(title_val);
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB090_SHR");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("구분1");
    hnwExtQuery.AddField("구분2");
    hnwExtQuery.AddField("본사행정지원");
    hnwExtQuery.AddField("입사1");
    hnwExtQuery.AddField("퇴사1");
    hnwExtQuery.AddField("지점행정지원");
    hnwExtQuery.AddField("입사2");
    hnwExtQuery.AddField("퇴사2");
    hnwExtQuery.AddField("상하차&사무");
    hnwExtQuery.AddField("입사3");
    hnwExtQuery.AddField("퇴사3");
    hnwExtQuery.AddField("TM");
    hnwExtQuery.AddField("입사4");
    hnwExtQuery.AddField("퇴사4");
    hnwExtQuery.AddField("문서수발");
    hnwExtQuery.AddField("입사5");
    hnwExtQuery.AddField("퇴사5");
    hnwExtQuery.AddField("B/L");
    hnwExtQuery.AddField("입사6");
    hnwExtQuery.AddField("퇴사6");
    hnwExtQuery.AddField("운전");
    hnwExtQuery.AddField("입사7");
    hnwExtQuery.AddField("퇴사7");
    hnwExtQuery.AddField("계");
    hnwExtQuery.AddField("입사계");
    hnwExtQuery.AddField("퇴사계");
    hnwExtQuery.AddField("제목부분");  
    
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_GUBUN = "";
    String gubun  = "";

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if ( vo.getString("GUBUN").equals("0") ) {
                gubun = "총계";
            } else if ( vo.getString("GUBUN").equals("1") ) {
                gubun = "본사";                
            } else {
                gubun = "지방";
            }
            
            if ( vo.getString("GUBUN").equals(pre_GUBUN) ) {  
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(gubun);
            }

            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("1_DIF"));
            hnwExtQuery.AddData(vo.getString("1_HIR"));
            hnwExtQuery.AddData(vo.getString("1_RET"));
            hnwExtQuery.AddData(vo.getString("2_DIF"));
            hnwExtQuery.AddData(vo.getString("2_HIR"));
            hnwExtQuery.AddData(vo.getString("2_RET"));
            hnwExtQuery.AddData(vo.getString("3_DIF"));
            hnwExtQuery.AddData(vo.getString("3_HIR"));
            hnwExtQuery.AddData(vo.getString("3_RET"));
            hnwExtQuery.AddData(vo.getString("4_DIF"));
            hnwExtQuery.AddData(vo.getString("4_HIR"));
            hnwExtQuery.AddData(vo.getString("4_RET"));
            hnwExtQuery.AddData(vo.getString("5_DIF"));
            hnwExtQuery.AddData(vo.getString("5_HIR"));
            hnwExtQuery.AddData(vo.getString("5_RET"));
            hnwExtQuery.AddData(vo.getString("6_DIF"));
            hnwExtQuery.AddData(vo.getString("6_HIR"));
            hnwExtQuery.AddData(vo.getString("6_RET"));
            hnwExtQuery.AddData(vo.getString("7_DIF"));
            hnwExtQuery.AddData(vo.getString("7_HIR"));
            hnwExtQuery.AddData(vo.getString("7_RET"));
            hnwExtQuery.AddData(vo.getString("DIF_TOT"));
            hnwExtQuery.AddData(vo.getString("HIR_TOT"));
            hnwExtQuery.AddData(vo.getString("RET_TOT"));
            hnwExtQuery.AddData(title_val);

            hnwExtQuery.SendData(response);

            pre_GUBUN = vo.getString("GUBUN");
            gubun  = "";
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

            hnwExtQuery.SendData(response);
    }

%>