<!--
***********************************************************************
* @source      : guna110_ED.jsp
* @description : 개인별근태집계현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      김학수        최초작성.        
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
    
    String occ_cd  = request.getParameter("occ_cd");	//조회구분(사무직,택배직)
	String str_ymd = request.getParameter("str_ymd");   //시작일자
    String end_ymd = request.getParameter("end_ymd");   //종료일자
    String dpt_cd  = request.getParameter("dpt_cd");    //부서코드
    String dpt_nm  = request.getParameter("dpt_nm");    //부서명
    String flag    = request.getParameter("flag");    //부서명
    String ymd     = request.getParameter("ymd");    //부서명
    String dpt_nm_val = request.getParameter("dpt_nm_val");    //부서명

    String str_y = str_ymd.substring(0,4);
    String str_m = str_ymd.substring(5,7);
    String str_d = str_ymd.substring(8,10);
    
    String end_y = end_ymd.substring(0,4);
    String end_m = end_ymd.substring(5,7);
    String end_d = end_ymd.substring(8,10);
    String dpt_cd_val = "";

    int str_no = Integer.parseInt(str_d);    
    int end_no = Integer.parseInt(end_d);    
    int str_no2 = str_no - 1;
    
    String mem_cnt = "";        //총인원

    if ( dpt_cd.equals("") || dpt_cd.equals(null) ) {
        dpt_cd_val  = "";
    } else {
        dpt_cd_val = " AND AA.DPT_CD = '"+ dpt_cd +"'";
    }
    StringBuffer sb_str1 = new StringBuffer();
    StringBuffer sb_str2 = new StringBuffer();
    StringBuffer sb_end1 = new StringBuffer();
    StringBuffer sb_end2 = new StringBuffer();
    
    int i = 0;
    String sql = "";
    Object[] bind = null;

    if ( str_m.equals(end_m) )
    {
        for ( i = str_no; i <= end_no; i++ )    // 시작월
        {              
            sb_str1.append("when "+ i +" then AT"+ i +"_CD \n");
            sb_end1.append(", AT"+ i +"_CD \n");
        }
        
        sql = XmlSqlUtils.getSQL("gun", "GUNA110_SHR02");
        
        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {
                  dpt_cd_val
                , occ_cd
                , sb_str1.toString()
                , sb_end1.toString()
                , dpt_cd_val
                , occ_cd
                , Integer.toString(str_no2)
                , Integer.toString(end_no)
        };
        
        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        bind = new Object[] {
                str_ymd, str_ymd, str_ymd , end_ymd
        };
    }
    else
    {
        for ( i = str_no; i <= 31; i++ )    // 시작월
        {              
            sb_str1.append("when "+ i +" then AT"+ i +"_CD \n");
            sb_str2.append(", AT"+ i +"_CD \n");
        }
        for ( i = 1; i <= end_no; i++ )    // 끝나는 월
        {              
            sb_end1.append("when "+ i +" then AT"+ i +"_CD \n");
            sb_end2.append(", AT"+ i +"_CD \n");
        }
        
        sql = XmlSqlUtils.getSQL("gun", "GUNA110_SHR");
        
        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {
                  dpt_cd_val
                , occ_cd
                , sb_str1.toString()
                , sb_str2.toString()
                , dpt_cd_val
                , occ_cd
                , Integer.toString(str_no2)
                , Integer.toString(str_no)
                , dpt_cd_val
                , occ_cd
                , sb_end1.toString()
                , sb_end2.toString()
                , dpt_cd_val
                , occ_cd
                , Integer.toString(end_no)
        };
        
        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        bind = new Object[] {
                str_ymd, str_ymd, str_ymd, str_ymd, str_ymd, str_ymd ,end_ymd, str_ymd , end_ymd
        };
    }

    AbstractDAO aaa= new AbstractDAO("default");
    
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("발생연차");
    hnwExtQuery.AddField("교육");

    hnwExtQuery.AddField("기념");
    hnwExtQuery.AddField("년차");
    hnwExtQuery.AddField("Refresh");
    hnwExtQuery.AddField("유급");
    hnwExtQuery.AddField("특별");
    hnwExtQuery.AddField("유결");
    hnwExtQuery.AddField("무결");
    hnwExtQuery.AddField("지각");
    hnwExtQuery.AddField("조퇴");
    hnwExtQuery.AddField("출장");
    hnwExtQuery.AddField("대체휴가");
    hnwExtQuery.AddField("기타");

    hnwExtQuery.AddField("지각");
    hnwExtQuery.AddField("연차");
    hnwExtQuery.AddField("미사용연차");
    hnwExtQuery.AddField("총인원");

    hnwExtQuery.AddField("부서명");
    hnwExtQuery.AddField("기간");


    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0 && flag.equals("Y") ) 
    {
        for ( i = 0; i < voList.size(); i++ ) 
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList.get(voList.size()-1);    //제일마지막로우의 총인원값을 가져옴
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("NYRP_CNT"));
            hnwExtQuery.AddData(vo.getString("F"));

            hnwExtQuery.AddData(vo.getString("Q"));
            hnwExtQuery.AddData(vo.getString("H"));
            hnwExtQuery.AddData(vo.getString("Z"));
            hnwExtQuery.AddData(vo.getString("S"));
            hnwExtQuery.AddData(vo.getString("I"));
            hnwExtQuery.AddData(vo.getString("A"));
            hnwExtQuery.AddData(vo.getString("B"));
            hnwExtQuery.AddData(vo.getString("C"));
            hnwExtQuery.AddData(vo.getString("D"));
            hnwExtQuery.AddData(vo.getString("E"));
            hnwExtQuery.AddData(vo.getString("T"));
            hnwExtQuery.AddData(vo.getString("L"));

            hnwExtQuery.AddData(vo.getString("C_YEAR"));
            hnwExtQuery.AddData(vo.getString("H_YEAR"));
            hnwExtQuery.AddData(vo.getString("NYRP_CNT2"));
          
            hnwExtQuery.AddData(vo2.getString("CNT"));
            hnwExtQuery.AddData(dpt_nm_val);
            hnwExtQuery.AddData(ymd);
            
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
          
            if ( flag.equals("Y") ) hnwExtQuery.AddData("0");
            else hnwExtQuery.AddData("");

            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.SendData(response);
    }
%>