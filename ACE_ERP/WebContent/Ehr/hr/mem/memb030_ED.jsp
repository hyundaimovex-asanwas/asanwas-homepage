<!--
***********************************************************************
* @source      : memb030_ED.jsp
* @description : 파견사원 근무수당 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/20      김학수        최초작성.        
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

    String str_y_val   = str_ymd.substring(2,4);
    String str_m_val   = str_ymd.substring(5,6);

    str_ymd_val = str_y + str_m;

    if ( str_m_val.equals("0") ) {
        str_m_val = str_ymd.substring(6,7);
    } else {
        str_m_val = str_ymd.substring(5,7);
    }

    String title_val   = "'" + str_y_val + ". " + str_m_val + "월 파견직 근무수당 현황";
 
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB030_SHR");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
    		str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, 
    		//str_ymd_val, str_ymd_val, 
    		str_y ,str_m 
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("근무일");
    hnwExtQuery.AddField("근무날짜");
    hnwExtQuery.AddField("근무수당");
    hnwExtQuery.AddField("제목");


    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_DPT = "";
    String eno_no  = "";
    String hol_ymd = "";
    String space_gubun = "";
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if ( vo.getString("GUBUN").equals("3") ) {
                eno_no = vo.getString("ENO_NO");
                System.out.println("eno_no="+eno_no);
                String sql2 = XmlSqlUtils.getSQL("mem", "MEMB030_SHR_02");
                Object[] bind2 = new Object[] {
                    eno_no, str_ymd_val
                };
                AbstractDAO aaa2= new AbstractDAO("default");
                DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);  
                if (voList2.size() > 0) 
                {
                    for ( int j=0; j<voList2.size(); j++ ) 
                    {
                        DynamicValueObject vo2 = (DynamicValueObject)voList2.get(j);
                        if ( ! hol_ymd.equals("") ) {
                            space_gubun = ", ";
                        } else {
                            space_gubun = "";
                        }
                        hol_ymd = hol_ymd + space_gubun + vo2.getString("HOL_YMD");
                    }
                }
            } 


            if  ( vo.getString("GUBUN").equals("1") ) {
                hnwExtQuery.AddData("합 계");
                hnwExtQuery.AddData("");
            } else if ( vo.getString("GUBUN").equals("2") ) {
                hnwExtQuery.AddData("");
                hnwExtQuery.AddData("소계");
            } else if ( vo.getString("GUBUN").equals("3") ) {
                if ( vo.getString("DPT_NM").equals(pre_DPT) ) {
                    hnwExtQuery.AddData("");
                } else {
                    hnwExtQuery.AddData(vo.getString("DPT_NM"));
                }
                hnwExtQuery.AddData(vo.getString("ENO_NM"));
            }

            hnwExtQuery.AddData(vo.getString("HOW_CNT"));
            hnwExtQuery.AddData(hol_ymd);
            hnwExtQuery.AddData(vo.getString("HOW_AMT"));
            hnwExtQuery.AddData(title_val);

            hnwExtQuery.SendData(response);

            pre_DPT = vo.getString("DPT_NM");
            hol_ymd = "";
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