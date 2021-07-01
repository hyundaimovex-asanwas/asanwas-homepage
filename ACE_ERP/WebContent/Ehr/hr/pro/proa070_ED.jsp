<!--
***********************************************************************
* @source      : memb120_ED.jsp
* @description : 업체별 파견사원 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/30      김학수        최초작성.        
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
    String PMT_YMD_SHR = request.getParameter("PMT_YMD_SHR");
    String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");

    String title_occ = "";
    StringBuffer sb = new StringBuffer();

    if( OCC_CD_SHR.equals("A") ){ 
        title_occ = "◈ 2006년 승진대상자 명단(사무직/직급별)";
    } else if ( OCC_CD_SHR.equals("M") ){ 
        title_occ = "◈ 2006년 승진대상자 명단(택배직/직급별)";
    } else if ( OCC_CD_SHR.equals("0") ){ 
        title_occ = "◈ 2006년 승진대상자 명단(전체/직급별)";
    }

    /** 조회 조건에 따른 처리 **/
    if( ! OCC_CD_SHR.equals("0") ){ 
        sb.append("WHERE OCC_CD = '"+OCC_CD_SHR+"' \n");
    }

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("pro", "PROA070_SHR");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        sb.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        PMT_YMD_SHR
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("구분");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("호봉");
    hnwExtQuery.AddField("생년월일");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("그룹입사일");
    hnwExtQuery.AddField("출신교");
    hnwExtQuery.AddField("전공");
    hnwExtQuery.AddField("현직승진일");
    hnwExtQuery.AddField("현직재직기간");
    hnwExtQuery.AddField("비고");
    hnwExtQuery.AddField("title");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    String pre_JOBNM = "";
    String r_val     = "";
    String gubun_val = "";

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            if ( pre_JOBNM.equals(vo.getString("JOB_NM")) ) {
                hnwExtQuery.AddData("");
            } else {
                gubun_val = vo.getString("JOB_NM") + " (" + vo.getString("R") + "명)";
                hnwExtQuery.AddData(gubun_val);
            }
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("HOB_NM"));
            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HIRG_YMD"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
            hnwExtQuery.AddData(vo.getString("JPR_CON"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(title_occ);

            hnwExtQuery.SendData(response);
            pre_JOBNM = vo.getString("JOB_NM");
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