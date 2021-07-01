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
    String str_ymd = request.getParameter("str_ymd");
    String end_ymd = request.getParameter("end_ymd");
    String gubun   = request.getParameter("gubun");
    
    String str_m = str_ymd.substring(5,7);
    String str_d = str_ymd.substring(8,10);
    
    String end_m = end_ymd.substring(5,7);
    String end_d = end_ymd.substring(8,10);

    String md_val = "(" + str_m + "." + str_d + " ~ " + end_m + "." + end_d + ")";
    String where_sql = "";
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB070_SHR");
    
    if ( gubun.equals("1") ) {
        where_sql = " WHERE HIR_YMD >= TO_DATE('" + str_ymd + "','YYYY-MM-DD') AND HIR_YMD <= TO_DATE('" + end_ymd + "','YYYY-MM-DD')";
        where_sql += " OR RHI_YMD >= TO_DATE('" + str_ymd + "','YYYY-MM-DD') AND HIR_YMD <= TO_DATE('" + end_ymd + "','YYYY-MM-DD')";
    } else {
        where_sql = "WHERE RET_YMD >= TO_DATE('" + str_ymd + "','YYYY-MM-DD') AND RET_YMD <= TO_DATE('" + end_ymd + "','YYYY-MM-DD')";
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        where_sql
    };
    
    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("담당업무");
    hnwExtQuery.AddField("나이");
    hnwExtQuery.AddField("학교");
    hnwExtQuery.AddField("전공");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("퇴사일");
    hnwExtQuery.AddField("파견업체");
    hnwExtQuery.AddField("비고");
    hnwExtQuery.AddField("채용사유");
    hnwExtQuery.AddField("기간");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(i+1);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_TAG"));
            hnwExtQuery.AddData(vo.getString("AGE"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
            hnwExtQuery.AddData(vo.getString("RHI_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(vo.getString("HIR_TAG"));
            hnwExtQuery.AddData(md_val);

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
          
            hnwExtQuery.SendData(response);
    }

%>