<!--
***********************************************************************
* @source      : pirh020_ED.jsp
* @description : 직급별,출신학교별 인원현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     방석호        최초작성.
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
    String HIR_YMD_SHR = request.getParameter("HIR_YMD_SHR").replaceAll("-", ""); // 기준일자
    String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");// 근로구분
    String EDGR_CD_SHR = request.getParameter("EDGR_CD_SHR");// 학력
    String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");// 지역

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("pir", "PIRH020_SHR");


    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
//    학력구분에 모두 추가시 아래부분 대치
//    Object[] bind = null;
    Object[] bind = new Object[] {
            "","","","","","","",
            "","","","","","",""
        };

    StringBuffer sb = new StringBuffer();

    /** 조회 조건에 따른 처리 **/
    if( EDGR_CD_SHR.equals("") || EDGR_CD_SHR.equals("9")){ // 전체
    }else if( EDGR_CD_SHR.equals("0") || EDGR_CD_SHR.equals("9")){ // 미취업 || 기타
        sb.append("AND EDGR_CD IS NULL \n");
    }else {
        sb.append("AND EDGR_CD = '"+EDGR_CD_SHR+"' \n");
        String EDGR_CD = "";
//  여기부터 학력구분에 모두 추가시 삭제할 부분
        if(EDGR_CD_SHR.equals("1")){        EDGR_CD="";            } // 초등학교
        else if(EDGR_CD_SHR.equals("2")){    EDGR_CD="E8";        } // 중학교
        else if(EDGR_CD_SHR.equals("3")){    EDGR_CD="E2";        } // 고등학교
        else if(EDGR_CD_SHR.equals("4")){    EDGR_CD="E3";        } // 전문대
        else if(EDGR_CD_SHR.equals("5")){    EDGR_CD="E4";        } // 대학교
        else if(EDGR_CD_SHR.equals("6")){    EDGR_CD="E5";        } // 대학원(수료)
        else if(EDGR_CD_SHR.equals("7")){    EDGR_CD="E5";        } // 대학원(석사)
        else if(EDGR_CD_SHR.equals("8")){    EDGR_CD="E5";        } // 대학원(박사)
        else if(EDGR_CD_SHR.equals("9")){    EDGR_CD="";        }

        bind = new Object[] {
                EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,
                EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD,EDGR_CD
        };
//  여기까지 학력구분에 모두 추가시 삭제할 부분
    }
    if( ! GBN_CD_SHR.equals("0") ){
        if( GBN_CD_SHR.equals("1") ){
            sb.append("AND VI.GBN_CD  = '1' \n"); // 본사 만
        }else{
            sb.append("AND VI.GBN_CD != '1' \n"); // 본사(1) 가 아닌 모두
        }
    }
    if( ! OCC_CD_SHR.equals("0") ){
        sb.append("AND VI.OCC_CD = '"+OCC_CD_SHR+"' \n");
    }
    if( ! HIR_YMD_SHR.equals("") ){
        sb.append("AND TO_CHAR(HIR_YMD,'YYYYMMDD') <= '"+HIR_YMD_SHR+"' \n");
		sb.append("AND (RET_YMD IS NULL OR TO_CHAR(VI.RET_YMD,'YYYYMMDD') > '"+HIR_YMD_SHR+"') \n");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb.toString(),
            sb.toString(),
            sb.toString(),sb.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
    String     colStr  =   "JOB_NM,CNT_TOT,SCH_01,SCH_02,SCH_03,SCH_04,SCH_05,SCH_06,SCH_07,SCH_08,SCH_09,SCH_10,SCH_11,SCH_12,SCH_13,SCH_14,CNT_ETC";
    String[] values = colStr.split(",");
    for( int x = 0; x < values.length; x++ ){
        hnwExtQuery.AddField(values[x]);
    }
    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            for( int x = 0; x < values.length; x++ ){
                hnwExtQuery.AddData(vo.getString(values[x]));
            }
            hnwExtQuery.SendData(response);
        }
    }
    else
    {
        // hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
        for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
        }
        hnwExtQuery.SendData(response);

    }
%>
