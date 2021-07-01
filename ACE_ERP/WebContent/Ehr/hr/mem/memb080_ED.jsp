<!--
***********************************************************************
* @source      : memb080_ED.jsp
* @description : 파견사원 입퇴사자 현황 PAGE
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
    String str_ymd = request.getParameter("str_ymd");
    String end_ymd = request.getParameter("end_ymd");
    String gubun   = request.getParameter("gubun");
    String str_ymd_val = "";
    String end_ymd_val = "";

    String str_y  = str_ymd.substring(0,4);
    String str_y2 = str_ymd.substring(2,4);
    String str_m  = str_ymd.substring(5,7);
    String str_d  = str_ymd.substring(8,10);
    
    String end_y  = end_ymd.substring(0,4);
    String end_y2 = end_ymd.substring(2,4);
    String end_m  = end_ymd.substring(5,7);
    String end_d  = end_ymd.substring(8,10);
    
    str_ymd_val = str_y + str_m + str_d;
    end_ymd_val = end_y + end_m + end_d;

    String ymd_val = "(" + str_y + "." + str_m + "." + str_d + " ~ " + end_y + "." + end_m + "." + end_d + ")";
    String str_val = "'" + str_y2 + "/" + str_m + "/" + str_d;
    String end_val = "'" + end_y2 + "/" + end_m + "/" + end_d;
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB080_SHR");
    
    str_ymd = str_ymd.replaceAll("-","");
    end_ymd = end_ymd.replaceAll("-","");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        end_ymd, str_ymd, str_ymd, end_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd
            , str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, str_ymd, end_ymd, end_ymd, str_ymd
            , end_ymd, str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd, str_ymd, end_ymd
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("구분번호");
    hnwExtQuery.AddField("구분명1");
    hnwExtQuery.AddField("구분명2");
    hnwExtQuery.AddField("시작달");
    hnwExtQuery.AddField("끝나는달");
    hnwExtQuery.AddField("증감");
    hnwExtQuery.AddField("입사");
    hnwExtQuery.AddField("전입");
    hnwExtQuery.AddField("소계");
    hnwExtQuery.AddField("퇴사");
    hnwExtQuery.AddField("전출");
    hnwExtQuery.AddField("계약직전환");
    hnwExtQuery.AddField("소계2");
    hnwExtQuery.AddField("기간");
    hnwExtQuery.AddField("시작달표시");
    hnwExtQuery.AddField("끝나는달표시");
    hnwExtQuery.AddField("선표시1");
    hnwExtQuery.AddField("선표시2");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_GUBUN    = "";
    String pre_GUBUN_NM = "";
    String pre_COMM_NM  = "";
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            if ( pre_GUBUN.equals(vo.getString("GUBUN")) )  {
                hnwExtQuery.AddData("");
            } else if ( vo.getString("GUBUN").equals("1") ) {     
                hnwExtQuery.AddData("지역");
            } else if ( vo.getString("GUBUN").equals("99") ) {
                hnwExtQuery.AddData("담당업무");
            } else if ( vo.getString("GUBUN").equals("0") ) {
                hnwExtQuery.AddData("총원");
            } else {
                hnwExtQuery.AddData(""); 
            }
            
            if ( vo.getString("GUBUN").equals("1") || vo.getString("GUBUN").equals("9") ) {  
                if ( pre_GUBUN_NM.equals(vo.getString("GUBUN_NM")) )  {
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(vo.getString("COMM_NM"));
                } else {
                    hnwExtQuery.AddData(vo.getString("GUBUN_NM"));
                    hnwExtQuery.AddData(vo.getString("COMM_NM"));
                }
            } else {
                if ( vo.getString("COMM_NM").equals("본사행정지원") || vo.getString("COMM_NM").equals("지방행정지원") ) {
                    if ( vo.getString("COMM_NM").equals("본사행정지원") )
                    {
                        hnwExtQuery.AddData("행정지원");
                        hnwExtQuery.AddData("본사");
                    }
                    if ( vo.getString("COMM_NM").equals("지방행정지원") )
                    {
                        hnwExtQuery.AddData("");
                        hnwExtQuery.AddData("지점");
                    }
                } else {
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(vo.getString("COMM_NM"));
                }
            }
            hnwExtQuery.AddData(vo.getString("STR_G"));
            hnwExtQuery.AddData(vo.getString("END_G"));
            hnwExtQuery.AddData(vo.getString("DIF"));
            hnwExtQuery.AddData(vo.getString("HIR"));
            hnwExtQuery.AddData(vo.getString("APPIN"));
            hnwExtQuery.AddData(vo.getString("TOT1"));
            hnwExtQuery.AddData(vo.getString("RET"));
            hnwExtQuery.AddData(vo.getString("APPRET"));
            hnwExtQuery.AddData(vo.getString("CHNG"));
            hnwExtQuery.AddData(vo.getString("TOT2"));
            hnwExtQuery.AddData(ymd_val);
            hnwExtQuery.AddData(str_val);
            hnwExtQuery.AddData(end_val);

            if ( pre_COMM_NM.equals("지방행정지원") ) {    //표준도표 디자인서식
                hnwExtQuery.AddData("Y");
            } else if ( vo.getString("GUBUN").equals("99") && !pre_COMM_NM.equals("본사행정지원") ) {
                hnwExtQuery.AddData("K");
            } else {
                hnwExtQuery.AddData("N");
            }

            if ( vo.getString("GUBUN").equals("99") && !vo.getString("COMM_NM").equals("본사행정지원") && !vo.getString("COMM_NM").equals("지방행정지원") ) {
                hnwExtQuery.AddData("Y");
            } else {
                hnwExtQuery.AddData("N");
            }

            hnwExtQuery.SendData(response);

            pre_GUBUN    = vo.getString("GUBUN");
            pre_GUBUN_NM = vo.getString("GUBUN_NM");
            pre_COMM_NM  = vo.getString("COMM_NM"); 
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

            hnwExtQuery.SendData(response);
    }

%>