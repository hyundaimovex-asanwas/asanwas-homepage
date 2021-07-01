<!--
***********************************************************************
* @source      : edub010_PV.jsp									  	  *
* @description : 어학성적관리 PAGE 	
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/18      김학수        최초작성.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>                
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>  
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String PRO_YMD_STDT_SHR = request.getParameter("PRO_YMD_STDT_SHR").replaceAll("-", "");	
    String PRO_YMD_ENDT_SHR = request.getParameter("PRO_YMD_ENDT_SHR").replaceAll("-", "");
    String ENO_NO_SHR       = request.getParameter("ENO_NO_SHR");	
    String SBJ_CD_SHR       = request.getParameter("SBJ_CD_SHR");
    String JOB_CD_SHR       = request.getParameter("JOB_CD_SHR");	
    String DPT_CD_SHR       = request.getParameter("DPT_CD_SHR");
    String TTL_AVR_SHR      = request.getParameter("TTL_AVR_SHR");	
    String CHECK4           = request.getParameter("CHECK4");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUB010_SHR_PRINT");

    /** 조회 조건에 따른 처리 **/
    StringBuffer sb = new StringBuffer();
    if (!PRO_YMD_STDT_SHR.equals("") && !PRO_YMD_ENDT_SHR.equals("")) {
        sb.append("AND A.PRO_YMD >= '"+PRO_YMD_STDT_SHR+"' \n");
        sb.append("AND A.PRO_YMD <= '"+PRO_YMD_ENDT_SHR+"' \n");
    } else if (!PRO_YMD_STDT_SHR.equals("") && PRO_YMD_ENDT_SHR.equals("")) {
        sb.append("AND A.PRO_YMD >= '"+PRO_YMD_STDT_SHR+"' \n");
    } else if (PRO_YMD_STDT_SHR.equals("") && !PRO_YMD_ENDT_SHR.equals("")) {
        sb.append("AND A.PRO_YMD <= '"+PRO_YMD_ENDT_SHR+"' \n");
    }
    // 사번으로 검색
    if( !ENO_NO_SHR.equals("") ){
        sb.append("AND A.ENO_NO = '"+ENO_NO_SHR+"' \n");
    }
    // 시험코드로 검색
    if( CHECK4.equals("Y")){ // 4사승진
        sb.append("AND (A.SBJ_CD = 'E4' OR A.SBJ_CD = 'C1') \n"); // E4: 4사승진영어시험, C1:4사승진전산시험
    }else{
        if( !SBJ_CD_SHR.equals("0") ){
            sb.append("AND A.SBJ_CD = '"+SBJ_CD_SHR+"' \n");
        }
    }
    // 직위로 검색
    if( !JOB_CD_SHR.equals("") ){
        sb.append("AND B.JOB_CD = '"+JOB_CD_SHR+"' \n");
    }
    // 부서로 검색
    if( !DPT_CD_SHR.equals("") ){
        sb.append("AND B.DPT_CD = '"+DPT_CD_SHR+"' \n");
    }
    // 시험성적으로 정렬
    if( TTL_AVR_SHR.equals("ASC") ){
        sb.append("ORDER BY DPT_NM, A.PRO_YMD ASC, A.TTL_AVR ASC \n");
    }else{
        sb.append("ORDER BY DPT_NM, A.PRO_YMD ASC, A.TTL_AVR DESC \n");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        sb.toString(),
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("순번");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("시험종류");
    hnwExtQuery.AddField("시행처");
    hnwExtQuery.AddField("L/C");
    hnwExtQuery.AddField("R/C");
    hnwExtQuery.AddField("말하기");
    hnwExtQuery.AddField("어휘");
    hnwExtQuery.AddField("독해");
    hnwExtQuery.AddField("종합");
    hnwExtQuery.AddField("기타");
    hnwExtQuery.AddField("점수");
    hnwExtQuery.AddField("응시일");
    hnwExtQuery.AddField("비고");
   
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("SBJ_NM"));
            hnwExtQuery.AddData(vo.getString("INT_NAM"));
            hnwExtQuery.AddData(vo.getString("SBJ_LSN"));
            hnwExtQuery.AddData(vo.getString("SBJ_RED"));
            hnwExtQuery.AddData(vo.getString("SBJ_SPC"));
            hnwExtQuery.AddData(vo.getString("SBJ_VOC"));
            hnwExtQuery.AddData(vo.getString("SBJ_IPT"));
            hnwExtQuery.AddData(vo.getString("SBJ_TOT"));
            hnwExtQuery.AddData(vo.getString("SBJ_ETC"));
            hnwExtQuery.AddData(vo.getString("TTL_AVR"));
            hnwExtQuery.AddData(vo.getString("PRO_YMD"));
            hnwExtQuery.AddData(vo.getString("REMARK"));

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
        
        hnwExtQuery.SendData(response);
    }

%>
