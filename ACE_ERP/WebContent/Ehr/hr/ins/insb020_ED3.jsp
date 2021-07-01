<!--
***********************************************************************
* @source      : insb020_ED3.jsp
* @description : 건강보험신고내역서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/09      김학수        최초작성.        
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
    String occ_cd  = request.getParameter("occ_cd");
    String str_ymd = request.getParameter("str_ymd");
    String end_ymd = request.getParameter("end_ymd");

    if ( occ_cd.equals("0") ) {
        occ_cd = "";
    }
    String sql = null;
    
    sql = XmlSqlUtils.getSQL("ins", "INSB020_SHR_03");

    //param binding 하기
    Object[] bind = new Object[] {
             str_ymd
            ,end_ymd
            ,occ_cd
    };
        
    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("일련번호");
    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("증번호");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("주민번호");
    hnwExtQuery.AddField("변경일");
    hnwExtQuery.AddField("변경전 부서");
    hnwExtQuery.AddField("변경전 직위");
    hnwExtQuery.AddField("변경전 금액");
    hnwExtQuery.AddField("변경후 부서");
    hnwExtQuery.AddField("변경후 직위");
    hnwExtQuery.AddField("변경후 금액");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);                 
                                                                                       
            hnwExtQuery.AddData(i+1);                                                
            hnwExtQuery.AddData(vo.getString("DPT_NM"));                               
            hnwExtQuery.AddData(vo.getString("JOB_NM"));                               
            hnwExtQuery.AddData(vo.getString("ENO_NO"));                               
            hnwExtQuery.AddData(vo.getString("HIU_NO"));                               
            hnwExtQuery.AddData(vo.getString("ENO_NM"));                               
            hnwExtQuery.AddData(vo.getString("CET_NO"));                               
            hnwExtQuery.AddData(vo.getString("CHANGE_YMD"));                           
            hnwExtQuery.AddData(vo.getString("CHANGE_DPT_NM"));                        
            hnwExtQuery.AddData(vo.getString("CHANGE_JOB_NM"));                        
            hnwExtQuery.AddData(vo.getString("CHANGE_AMT"));                           
            hnwExtQuery.AddData(vo.getString("BEFORE_DPT_NM"));     
            hnwExtQuery.AddData(vo.getString("BEFORE_JOB_NM"));                        
            hnwExtQuery.AddData(vo.getString("BEFORE_AMT"));                                                                            

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

            hnwExtQuery.SendData(response);  
    }

%>