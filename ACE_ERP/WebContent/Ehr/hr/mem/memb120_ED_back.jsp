<!--
***********************************************************************
* @source      : memb120_ED.jsp
* @description : 부서별 파견사원 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/16      김학수        최초작성.        
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

    String str_y  = str_ymd.substring(0,4);
    String str_m  = str_ymd.substring(5,7);
    String str_d  = str_ymd.substring(8,10);
    
    str_ymd_val = str_y + str_m + str_d;

    String ymd_val = "(" + str_y + "." + str_m + "." + str_d + ")";

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB120_SHR");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        str_ymd_val, str_ymd_val, str_ymd_val
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("구분");
    hnwExtQuery.AddField("근무부서");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("연령");
    hnwExtQuery.AddField("학력");
    hnwExtQuery.AddField("담당업무");
    hnwExtQuery.AddField("계약기간");
    hnwExtQuery.AddField("파견용역비");
    hnwExtQuery.AddField("파견업체");
    hnwExtQuery.AddField("비고");
    hnwExtQuery.AddField("선구분");
    hnwExtQuery.AddField("날짜");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_GBN2_TAG = "";
    String pre_DPT_NM   = "";
    String pre_JOB_TAG   = "";
    String gubun  = "";
    String gubun2 = "";

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if ( vo.getString("GBN2_TAG").equals("총계") ) { 
                hnwExtQuery.AddData("계");
            } else {
                hnwExtQuery.AddData(Integer.toString(i+1));
            }

            if ( vo.getString("GBN2_TAG").equals(pre_GBN2_TAG) || vo.getString("GBN2_TAG").equals("총계") ) {  
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(vo.getString("GBN2_TAG"));
            }

            if ( vo.getString("DPT_NM").equals(pre_DPT_NM) ) {  
                hnwExtQuery.AddData("");
                gubun = "Y";
            } else {
                hnwExtQuery.AddData(vo.getString("DPT_NM"));
            }

            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("AGE"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));

            if ( vo.getString("DPT_NM").equals(pre_DPT_NM) && vo.getString("JOB_TAG").equals(pre_JOB_TAG) )
            {
                hnwExtQuery.AddData("");
                if ( gubun.equals("Y") ) gubun2 = "Y";
            }
            else
            {
                hnwExtQuery.AddData(vo.getString("JOB_TAG"));
            }
        
//            hnwExtQuery.AddData(vo.getString("JOB_TAG"));
            hnwExtQuery.AddData(vo.getString("CONSE_YMD"));
            hnwExtQuery.AddData(vo.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo.getString("DISCOMP_NM"));
            hnwExtQuery.AddData(vo.getString("CHNG_YMD"));
            hnwExtQuery.AddData(gubun2);
            hnwExtQuery.AddData(ymd_val);

            hnwExtQuery.SendData(response);

            pre_GBN2_TAG = vo.getString("GBN2_TAG");
            pre_DPT_NM   = vo.getString("DPT_NM");
            pre_JOB_TAG  = vo.getString("JOB_TAG");
            gubun  = "";
            gubun2 = "";
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

            hnwExtQuery.SendData(response);
    }

%>