<!--
***********************************************************************
* @source      : proa100_ED.jsp
* @description : 정기승진 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/01      김학수        최초작성.        
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

    String rec_y       = request.getParameter("REC_YMD_SHR");	
	String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");
    String title_val   = request.getParameter("title_val");
    
    String rec_ymd = rec_y + "0101";
    String rec_ym  = rec_y + "12";
    int rec_y_str  = Integer.parseInt(rec_y)-5;
    String rec_y_str2 = Integer.toString(rec_y_str);

    String col_val1   = "";
    String col_val2   = "";
    String gbn_cd_val = "";

    if ( GBN_CD_SHR.equals("1") ) {
        gbn_cd_val = "";
    } else {
        gbn_cd_val = "AND    EST_CD = 'Y'";
    }
    int i = 0;
    int k = 0;
//--------------------------------구분값 조회--------------------------------------------------------
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql1 = XmlSqlUtils.getSQL("pro", "PROA100_SHR_01");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam1 = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql1 = SqlUtils.replaceQuery(sql1, sqlParam1);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind1 = new Object[] {
            rec_y,
            rec_y
    };

    AbstractDAO aaa1= new AbstractDAO("default");
    DynamicValueObject voList1 = aaa1.selectProcessDvo(sql1, bind1);
    String[] gubun  = new String[voList1.size()];
    for ( i=0; i<voList1.size(); i++ ) 
    {
        DynamicValueObject vo1 = (DynamicValueObject)voList1.get(i);
        gubun[i] = vo1.getString("COMM_NM");
        col_val1 += "                      ,SUM(AA.PMT_CNT_"+(i+1)+")                            PMT_CNT_"+(i+1)+"                      \n";
        col_val1 += "                      ,SUM(AA.PRO_CNT_"+(i+1)+")                            PMT_CNT_"+(i+1)+"                      \n";
        col_val1 += "                      ,ROUND(SUM(AA.PRO_CNT_"+(i+1)+")/SUM(AA.PMT_CNT_"+(i+1)+")*100, 1)       PRO_RAT_"+(i+1)+"   \n";
        col_val2 += "                             , MAX(DECODE(HEAD_SORT,'"+(i+1)+"',PMT_CNT))   PMT_CNT_"+(i+1)+"                      \n";
        col_val2 += "                             , MAX(DECODE(HEAD_SORT,'"+(i+1)+"',PRO_CNT))   PRO_CNT_"+(i+1)+"                      \n";
        col_val2 += "                             , MAX(DECODE(HEAD_SORT,'"+(i+1)+"',PRO_RAT))   PRO_RAT_"+(i+1)+"                      \n";
    }

//-----------------------------------------------------------------------------------------

//--------------------------------정기승진현황 조회--------------------------------------------------------

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql2 = XmlSqlUtils.getSQL("pro", "PROA100_SHR_02");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam2 = new Object[] {
        col_val1, col_val2, gbn_cd_val
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind2 = new Object[] {
        rec_ymd,
        rec_ymd,
        rec_ym,
        rec_ym,
        rec_y,
        rec_y,
        rec_y,
        rec_y_str2
    };

    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);
//-----------------------------------------------------------------------------------------
    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("근로구분구분값");
    hnwExtQuery.AddField("직위구분");
    hnwExtQuery.AddField("직위별 정렬번호");
    hnwExtQuery.AddField("대상인원_계");
    hnwExtQuery.AddField("승진인원_계");
    hnwExtQuery.AddField("승진율_계");
    for ( i=1; i<=voList1.size(); i++ ) 
    {
        hnwExtQuery.AddField("대상인원_"+i);
        hnwExtQuery.AddField("승진인원_"+i);
        hnwExtQuery.AddField("승진율_"+i);
    }
    for ( i=1; i<=voList1.size(); i++ ) 
    {
        hnwExtQuery.AddField("구분명_"+i);
    }
    hnwExtQuery.AddField("제목");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList2.size() > 0) 
    {
        for ( i=0; i<voList2.size(); i++ ) 
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);
            hnwExtQuery.AddData(vo2.getString("OCC_CD"));
            hnwExtQuery.AddData(vo2.getString("JOB_NM"));
            hnwExtQuery.AddData(vo2.getString("JOB_NO"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT99"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT99"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT99"));

            hnwExtQuery.AddData(vo2.getString("PMT_CNT_1"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_1"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_1"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_2"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_2"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_2"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_3"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_3"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_3"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_4"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_4"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_4"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_5"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_5"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_5"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_6"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_6"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_6"));
            hnwExtQuery.AddData(vo2.getString("PMT_CNT_7"));
            hnwExtQuery.AddData(vo2.getString("PRO_CNT_7"));
            hnwExtQuery.AddData(vo2.getString("PRO_RAT_7"));

            for ( k=0; k<voList1.size(); k++ ) 
            {
                hnwExtQuery.AddData(gubun[k]);
            }
            hnwExtQuery.AddData(title_val);

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
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        for ( k=0; k<voList1.size(); k++ ) 
        {
            hnwExtQuery.AddData("");
        }
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>