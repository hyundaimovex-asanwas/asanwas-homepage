<!--
***********************************************************************
* @source      : proa060_ED.jsp
* @description : 정기승진 대상자 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/05      김학수        최초작성.        
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
    String REC_YMD_SHR = request.getParameter("REC_YMD_SHR");
    String title_val   = request.getParameter("title_val");



    String str_ymd = "";
    String end_ymd = "";
    String end_ym  = "";
    String end_ym_val  = "";
    int rec_y_str     = Integer.parseInt(REC_YMD_SHR)-5;
    String rec_y_str2 = Integer.toString(rec_y_str);
    
    str_ymd = REC_YMD_SHR + "0101";
    end_ym  = REC_YMD_SHR + "12";
    end_ym_val =  "AND    STR_YMD <= TO_CHAR(LAST_DAY(TO_DATE('"+ end_ym +"'||'01','YYYYMMDD')),'YYYYMMDD') \n";
    end_ym_val += "                                               AND   (END_YMD >= TO_CHAR(LAST_DAY(TO_DATE('"+ end_ym +"'||'01','YYYYMMDD')),'YYYYMMDD') OR END_YMD IS NULL)";

    int i = 0;
    int k = 0;
//--------------------------------구분값(직위) 조회--------------------------------------------------------
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql1 = XmlSqlUtils.getSQL("pro", "PROA060_SHR_01");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam1 = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql1 = SqlUtils.replaceQuery(sql1, sqlParam1);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind1 = new Object[] {
        REC_YMD_SHR,
        //rec_y_str2
    };

    AbstractDAO aaa1= new AbstractDAO("default");
    DynamicValueObject voList1 = aaa1.selectProcessDvo(sql1, bind1);
    int a_cnt = 0;
    int m_cnt = 0;

    for ( i=0; i<voList1.size(); i++ ) 
    {
        DynamicValueObject vo1 = (DynamicValueObject)voList1.get(i);
        if ( vo1.getString("OCC_CD").equals("A") ) {
            a_cnt = a_cnt + 1;
        } else if ( vo1.getString("OCC_CD").equals("M") ) {
            m_cnt = m_cnt + 1;
        }
    }
    
    String[] gubun1  = new String[a_cnt];
    String[] gubun2  = new String[m_cnt];
    String col_val1 = "";
    String col_val2 = "";
    a_cnt = 0;
    m_cnt = 0;

    for ( i=0; i<voList1.size(); i++ ) 
    {
        DynamicValueObject vo1 = (DynamicValueObject)voList1.get(i);
        if ( vo1.getString("OCC_CD").equals("A") ) {
            if ( vo1.getString("FJOB_NM").equals("4사") ) {
                gubun1[a_cnt] = "5사" + "→" + vo1.getString("FJOB_NM");
            } else {
                gubun1[a_cnt] = vo1.getString("PJOB_NM") + "→" + vo1.getString("FJOB_NM");
            }
            a_cnt = a_cnt + 1;
            
            col_val1 += "                  ,SUM(DECODE(OCC_CD,'A',DECODE(R,"+a_cnt+",NOW_CNT)))            A_"+a_cnt+"_NOW \n";
            col_val1 += "                  ,SUM(DECODE(OCC_CD,'A',DECODE(R,"+a_cnt+",PMT_CNT)))            A_"+a_cnt+"_PMT \n";
            col_val1 += "                  ,ROUND(SUM(DECODE(OCC_CD,'A',DECODE(R,"+a_cnt+",PMT_CNT))) \n";
            col_val1 += "                        /SUM(DECODE(OCC_CD,'A',DECODE(R,"+a_cnt+",NOW_CNT)))*100) A_"+a_cnt+"_PER \n";
        } else if ( vo1.getString("OCC_CD").equals("M") ) {
            gubun2[m_cnt] = vo1.getString("PJOB_NM") + "→" + vo1.getString("FJOB_NM");
            m_cnt = m_cnt + 1;

			col_val2 += "                  ,SUM(DECODE(OCC_CD,'M',DECODE(R,"+m_cnt+",NOW_CNT)))            M_"+m_cnt+"_NOW \n";
			col_val2 += "                  ,SUM(DECODE(OCC_CD,'M',DECODE(R,"+m_cnt+",PMT_CNT)))            M_"+m_cnt+"_PMT \n";
			col_val2 += "                  ,ROUND(SUM(DECODE(OCC_CD,'M',DECODE(R,"+m_cnt+",PMT_CNT))) \n";
			col_val2 += "                        /SUM(DECODE(OCC_CD,'M',DECODE(R,"+m_cnt+",NOW_CNT)))*100) M_"+m_cnt+"_PER \n";
        }    
    }

//-----------------------------------------------------------------------------------------

//--------------------------------정기승진 대상자 조회--------------------------------------------------------

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql2 = XmlSqlUtils.getSQL("pro", "PROA060_SHR_02");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam2 = new Object[] {
        col_val1, col_val2, end_ym_val
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind2 = new Object[] {
            REC_YMD_SHR
            , rec_y_str2
            , REC_YMD_SHR
            , REC_YMD_SHR
            , str_ymd
            , str_ymd
            , REC_YMD_SHR
 

    };

    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);
//-----------------------------------------------------------------------------------------
    extquery hnwExtQuery = new extquery();   
    
        hnwExtQuery.AddField("구분");
        hnwExtQuery.AddField("현재원");
        hnwExtQuery.AddField("대상");
        hnwExtQuery.AddField("%");

    for ( i=1; i<=gubun1.length; i++ ) 
    {
        hnwExtQuery.AddField("사무직현재원_"+i);
        hnwExtQuery.AddField("사무직대상_"+i);
        hnwExtQuery.AddField("사무직대상율_"+i);
    }
        hnwExtQuery.AddField("사무직현재원_소계");
        hnwExtQuery.AddField("사무직대상_소계");           
        hnwExtQuery.AddField("사무직대상율_소계");         
                                                           
    for ( i=1; i<=gubun2.length; i++ ) 
    {
        hnwExtQuery.AddField("택배직현재원_"+i);
        hnwExtQuery.AddField("택배직대상_"+i);
        hnwExtQuery.AddField("택배직대상율_"+i);
    }
        hnwExtQuery.AddField("택배직현재원_소계");
        hnwExtQuery.AddField("택배직대상_소계");
        hnwExtQuery.AddField("택배직대상율_소계");

        hnwExtQuery.AddField("택배직현재원_총계");
        hnwExtQuery.AddField("택배직대상_총계");
        hnwExtQuery.AddField("택배직대상율_총계");

        hnwExtQuery.AddField("5사현재원_남녀합");
        hnwExtQuery.AddField("5사대상_남녀합");
        hnwExtQuery.AddField("5사대상율_납녀합");
    for ( i=1; i<=gubun1.length; i++ ) 
    {
        hnwExtQuery.AddField(gubun1[i-1]);
//        System.out.println(gubun1[i-1]);
    }
    for ( i=1; i<=gubun2.length; i++ ) 
    {
        hnwExtQuery.AddField(gubun2[i-1]);
    }

    hnwExtQuery.SendField(response);

    //    System.out.println("voList.size()="+voList.size());
 
    if ( voList2.size() > 0 ) 
    {
        for ( i = 0; i < voList2.size(); i++ )  
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);
           
            hnwExtQuery.AddData(vo2.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo2.getString("TITLE_NOW"));
            hnwExtQuery.AddData(vo2.getString("TITLE_PTM"));
            hnwExtQuery.AddData(vo2.getString("TITLE_PER"));

            hnwExtQuery.AddData(vo2.getString("A_1_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_1_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_1_PER"));
            hnwExtQuery.AddData(vo2.getString("A_2_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_2_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_2_PER"));
            hnwExtQuery.AddData(vo2.getString("A_3_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_3_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_3_PER"));
            hnwExtQuery.AddData(vo2.getString("A_4_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_4_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_4_PER"));
            hnwExtQuery.AddData(vo2.getString("A_5_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_5_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_5_PER"));
            hnwExtQuery.AddData(vo2.getString("A_6_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_6_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_6_PER"));
            hnwExtQuery.AddData(vo2.getString("A_7_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_7_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_7_PER"));

            hnwExtQuery.AddData(vo2.getString("A_99_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_99_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_99_PER"));
                                                        
            hnwExtQuery.AddData(vo2.getString("M_1_NOW"));
            hnwExtQuery.AddData(vo2.getString("M_1_PMT"));
            hnwExtQuery.AddData(vo2.getString("M_1_PER"));
            hnwExtQuery.AddData(vo2.getString("M_2_NOW"));
            hnwExtQuery.AddData(vo2.getString("M_2_PMT"));
            hnwExtQuery.AddData(vo2.getString("M_2_PER"));
            hnwExtQuery.AddData(vo2.getString("M_3_NOW"));
            hnwExtQuery.AddData(vo2.getString("M_3_PMT"));
            hnwExtQuery.AddData(vo2.getString("M_3_PER"));

            hnwExtQuery.AddData(vo2.getString("M_99_NOW"));
            hnwExtQuery.AddData(vo2.getString("M_99_PMT"));
            hnwExtQuery.AddData(vo2.getString("M_99_PER"));
                                                      
            hnwExtQuery.AddData(vo2.getString("AM_999_NOW"));
            hnwExtQuery.AddData(vo2.getString("AM_999_PMT"));
            hnwExtQuery.AddData(vo2.getString("AM_999_PER"));

            hnwExtQuery.AddData(vo2.getString("A_88_NOW"));
            hnwExtQuery.AddData(vo2.getString("A_88_PMT"));
            hnwExtQuery.AddData(vo2.getString("A_88_PER"));

            for ( k=0; k<gubun1.length; k++ ) 
            {
                hnwExtQuery.AddData(gubun1[k]);
            }
            for ( k=0; k<gubun2.length; k++ ) 
            {
                hnwExtQuery.AddData(gubun2[k]);
            }

            hnwExtQuery.SendData(response);
        }
    } else {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

        for ( i=1; i<=gubun1.length; i++ ) 
        {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
        }
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
        for ( i=1; i<=gubun2.length; i++ ) 
        {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
        }
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            for ( k=0; k<gubun1.length; k++ ) 
            {
                hnwExtQuery.AddData("");
            }
            for ( k=0; k<gubun2.length; k++ ) 
            {
                hnwExtQuery.AddData("");
            }

            hnwExtQuery.SendData(response);
    }
%>