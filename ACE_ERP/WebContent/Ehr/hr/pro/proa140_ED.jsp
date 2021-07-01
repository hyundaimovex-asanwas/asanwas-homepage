<!--
***********************************************************************
* @source      : proa050_ED.jsp
* @description : 최근 5년 승진 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/28      김학수        최초작성.        
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
    String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");
    String occ_cd_val  = request.getParameter("occ_cd_val");

    int REC_YMD_SHR2   = Integer.parseInt(REC_YMD_SHR);
    int row_count = 7;    // 보고서양식에 표현될 row수 -----> 수정시 변경요함
    int year_cnt  = 5;                               //-----> 변경시 수정요함
    int ii        = 6;
    int i = 0;
    int j = 0;
    int n = 0;
    String sql = "";
               sql  = "SELECT JOB_NO                        \n";
               sql += "      ,INT           GUBUN           \n";
        for(j = year_cnt; j > 0; j--){
           
               sql += "      ,MAX(DECODE(YMD_A,"+j+",CASE COPYT.INT             \n";
               sql += "                                 WHEN 1 THEN PJOB_NM                         \n";
               sql += "                                 WHEN 2 THEN '`'||DECODE(SUBSTR(REC_YMD,3,1),0,'0'||SUBSTR(REC_YMD,4,1),SUBSTR(REC_YMD,4,1))         \n";
               sql += "                                 WHEN 3 THEN TO_CHAR(NOW_CNT,999999)         \n";
               sql += "                                 WHEN 4 THEN TO_CHAR(PMT_CNT,999999)         \n";
               sql += "                                 WHEN 5 THEN TO_CHAR(PRO_CNT,999999)         \n";
               sql += "                                 WHEN 6 THEN TO_CHAR(PRO_RAT,999999.9)       \n";
               sql += "                                 WHEN 7 THEN TO_CHAR(PRO_AVR,999999.9)       \n";
               sql += "                             END)) AS A_"+(ii-j)+"                         \n";    
        }
               sql += "  FROM (SELECT PJOB_NM, REC_YMD, NOW_CNT, PMT_CNT, PRO_CNT, PRO_RAT, YMD_A, JOB_NO               \n";
               sql += "             , ROUND(SUM(PRO_CNT) OVER(PARTITION BY OCC_CD, PJOB_NM)/SUM(PMT_CNT) OVER(PARTITION BY OCC_CD, PJOB_NM)*100,1) AS PRO_AVR        \n";
               sql += "          FROM (                                                                                 \n";
               sql += "                SELECT DECODE(INT,1,'',AA.OCC_CD)                                OCC_CD          \n";
               sql += "                     , DECODE(INT,1,'계',(AA.PJOB_NM||' → '||BB.FJOB_NM))       PJOB_NM         \n";
               sql += "                     , DECODE(INT,1,AA.REC_YMD||'계',AA.REC_YMD)                 REC_YMD         \n";
               sql += "                     , SUM(AA.NOW_CNT)                                           NOW_CNT         \n";
               sql += "                     , SUM(AA.PMT_CNT)                                           PMT_CNT         \n";
               sql += "                     , SUM(AA.PRO_CNT)                                           PRO_CNT         \n";
               sql += "                     , ROUND(SUM(AA.PRO_CNT)/SUM(AA.PMT_CNT)*100, 1)             PRO_RAT         \n";
               sql += "                     , MAX(YMD_A)                                                YMD_A           \n";
               sql += "                     , MAX(DECODE(INT,1,JOB_NO+1,JOB_NO))                        JOB_NO          \n";
               sql += "                 FROM (                                                                          \n";
               
               sql += " \n";
               sql += "-->반복쿼리 시작 \n";
               sql += " \n";

        for(i=year_cnt; i>0; i--){
            if ( i != 5 )
               sql += "               UNION ALL                                                                                                              \n";
               sql += "                       SELECT  D.OCC_CD, D.REC_YMD, D.PJOB_NM, AA.NOW_CNT, AA.PMT_CNT, AA.PMT_RAT                                     \n";
               sql += "                              ,AA.PRO_CNT, AA.PRO_RAT, '"+i+"' YMD_A, D.JOB_NO                                                            \n";
               sql += "                        FROM  ( SELECT B.OCC_CD, B.PMT_YY AS REC_YMD, B.PJOB_NM, A.NOW_CNT, B.PMT_CNT                                 \n";
               sql += "                                      ,ROUND(B.PMT_CNT/A.NOW_CNT*100, 1) AS PMT_RAT                                                   \n";
               sql += "                                      ,C.PRO_CNT, ROUND(C.PRO_CNT/B.PMT_CNT*100, 1) AS PRO_RAT                                        \n";
               sql += "                                  FROM (SELECT SF_GET_COMMNAME('01','A2',JOB_CD) AS JOB_NM, COUNT(*) AS NOW_CNT                       \n";
               sql += "                                          FROM T_CM_PERSON                                                                            \n";
               sql += "                                         WHERE TO_CHAR(HIR_YMD,'YYYYMMDD') <= '"+(REC_YMD_SHR2-i)+"0101'                              \n";
               sql += "                                           AND (TO_CHAR(RET_YMD,'YYYYMMDD') > '"+(REC_YMD_SHR2-i)+"0101' OR RET_YMD IS NULL)          \n";
               sql += "                                           AND OCC_CD = '"+OCC_CD_SHR+"'                                                                           \n";
               sql += "                                         GROUP BY SF_GET_COMMNAME('01','A2',JOB_CD)                                                   \n";
               sql += "                                        ) A,                                                                                          \n"; 
               sql += "                                                                                                                                      \n";
               sql += "                                       (SELECT OCC_CD, PMT_YY, SF_GET_COMMNAME('01','A2',PJOB_CD) AS PJOB_NM, COUNT(*) AS PMT_CNT     \n";         
               sql += "                                        FROM   T_PM_PROMOTION                                                                         \n";
               sql += "                                        WHERE  PMT_YY = '"+(REC_YMD_SHR2-i)+"'                                                        \n";
               sql += "                                        AND    OCC_CD = '"+OCC_CD_SHR+"'                                                                           \n";
               sql += "                                        GROUP  BY SF_GET_COMMNAME('01','A2',PJOB_CD), PMT_YY, OCC_CD                                  \n";
               sql += "                                        ) B,                                                                                          \n";
               sql += "                                       (SELECT SF_GET_COMMNAME('01','A2',PJOB_CD) AS PJOB_NM, EST_CD, COUNT(*) AS PRO_CNT             \n"; 
               sql += "                                        FROM   T_PM_PROMOTION                                                                         \n";
               sql += "                                        WHERE  PMT_YY = '"+(REC_YMD_SHR2-i)+"'                                                        \n";
               sql += "                                        AND    EST_CD = 'Y'                                                                           \n";
               sql += "                                        AND    OCC_CD = '"+OCC_CD_SHR+"'                                                                           \n";
               sql += "                                        GROUP  BY SF_GET_COMMNAME('01','A2',PJOB_CD), EST_CD                                          \n";
               sql += "                                        ) C                                                                                           \n";                                                                                                                             
               sql += "                                  WHERE A.JOB_NM = B.PJOB_NM                                                                          \n";
               sql += "                                    AND A.JOB_NM = C.PJOB_NM                                                                          \n";
               sql += "                                ) AA,                                                                                                 \n";
               sql += "                               (SELECT P.OCC_CD, P.REC_YMD, P.PJOB_NM, ROWNUM JOB_NO                                                  \n";
               sql += "                                  FROM (SELECT OCC_CD, '"+(REC_YMD_SHR2-i)+"' REC_YMD, SF_GET_COMMNAME('01','A2',PJOB_CD) AS PJOB_NM  \n";
               sql += "                                        FROM   T_PM_PROMOTION                                                                         \n";
               sql += "                                        WHERE  PMT_YY <= '"+(REC_YMD_SHR2-1)+"' AND PMT_YY >'"+(REC_YMD_SHR2-6)+"'                    \n";
               sql += "                                        AND    OCC_CD = '"+OCC_CD_SHR+"'                                                                           \n";
               sql += "                                        GROUP  BY OCC_CD, SF_GET_COMMNAME('01','A2',PJOB_CD)                                          \n";
               sql += "                                        ) P,                                                                                          \n";
               sql += "                                       (SELECT A.PJOB_NM, B.SORT_NO                                                                   \n";
               sql += "                                         FROM   (SELECT PJOB_CD                                                                       \n";
               sql += "                                                       ,SF_GET_COMMNAME('01', 'A2', PJOB_CD) AS PJOB_NM                               \n";
               sql += "                                                 FROM   T_PM_PMTALLOT                                                                 \n";
               sql += "                                                 ) A,                                                                                 \n";
               sql += "                                                (SELECT COMM_CD, COMM_NM, SORT_NO                                                     \n";
               sql += "                                                 FROM   T_CM_COMMON                                                                   \n";
               sql += "                                                 WHERE CD_GBN='A2'                                                                    \n";
               sql += "                                                 ) B                                                                                  \n";
               sql += "                                         WHERE A.PJOB_CD = B.COMM_CD                                                                  \n";
               sql += "                                         ORDER BY SORT_NO DESC                                                                        \n";
               sql += "                                        ) C                                                                                           \n";
               sql += "                                 WHERE P.PJOB_NM = C.PJOB_NM                                                                          \n";
               sql += "                                 ORDER BY C.SORT_NO                                                                                   \n";
               sql += "                                ) D                                                                                                   \n";
               sql += "                        WHERE   D.PJOB_NM = AA.PJOB_NM(+)                                                                             \n";
        }
        
               sql += " \n";
               sql += "-->반복쿼리 종료 \n";
               sql += " \n";
        
               sql += "                     ) AA,                                                                                                            \n";  
               sql += "                     (SELECT SF_GET_COMMNAME('01', 'A2', PJOB_CD) AS PJOB_NM                                                          \n";
               sql += "                            ,SF_GET_COMMNAME('01', 'A2', FJOB_CD) AS FJOB_NM                                                          \n";
               sql += "                        FROM T_PM_PMTALLOT                                                                                            \n";
               sql += "                      ) BB,                                                                                                           \n";
               sql += "                     (SELECT ROWNUM INT                                                                                               \n";
               sql += "                        FROM DICT                                                                                                     \n";
               sql += "                       WHERE ROWNUM<=2                                                                                                \n";
               sql += "                      ) COPYT                                                                                                         \n";
               sql += "                WHERE AA.PJOB_NM = BB.PJOB_NM                                                                                         \n";
               sql += "                GROUP BY DECODE(INT,1,'',AA.OCC_CD)                                                                                   \n";
               sql += "                       , DECODE(INT,1,'계',(AA.PJOB_NM||' → '||BB.FJOB_NM))                                                           \n";
               sql += "                       , DECODE(INT,1,AA.REC_YMD||'계',AA.REC_YMD)                                                                    \n";
               sql += "               )                                                                                                                      \n";
               sql += "         ORDER BY OCC_CD                                                                                                              \n";
               sql += "       ) S,                                                                                                                           \n";
               sql += "      (SELECT ROWNUM INT                                                                                                              \n";
               sql += "         FROM DICT                                                                                                                    \n";
               sql += "        WHERE ROWNUM <="+row_count+"                                                                                                  \n";
               sql += "       ) COPYT                                                                                                                        \n";
               sql += "  GROUP BY JOB_NO, INT                           \n";

    /** 검색 조건 Mapping(PrepareStatement ) **/
    Object[] bind = new Object[] {
            
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    int col_block_cnt = voList.size()/row_count;    
    int col_cnt       = col_block_cnt*year_cnt;     // 5는 년도개수(최근5년조회)
    int row_i         = 0;                   // i값에 매칭되는 배열에 들어갈 row넘버
    int col_i         = 0;                   // i값에 매칭되는 배열에 들어갈 col넘버
    extquery hnwExtQuery = new extquery();

/*--------------- 데이타 필트 전송 -----------*/
    for ( i = 1; i <= col_block_cnt; i++ )
    {
        for ( j = 1; j <= year_cnt; j++ )
            hnwExtQuery.AddField("JOB_"+i+"_"+j);
    }
   
    for ( n = 1; n <= col_block_cnt; n++ ) {
        hnwExtQuery.AddField("직위_"+n);
    }
    for ( n = 1; n <= col_block_cnt; n++ ) {
        hnwExtQuery.AddField("평균승진율_"+n);
    }
    hnwExtQuery.AddField("근로구분");
/*-------------------------------------------*/

    hnwExtQuery.SendField(response);
    
//    System.out.println("voList.size()="+voList.size());

    String[] JOB_NM  = new String[col_block_cnt];
    String[] PRO_AVR = new String[col_block_cnt];

//    System.out.println("col_cnt="+col_cnt);
    String[][] arr_temp = new String[row_count][col_cnt];
    if (voList.size() > 0) 
    {
        //---------------데이터를 배열에 담는부분-----------
        for ( i=0; i < voList.size(); i++ ) 
        {
            if ( i % row_count == 0 && i != 0 ) {
                col_i = col_i + year_cnt;  
            }
            row_i = i % row_count;

            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//            System.out.println(i+"   " + row_i + "   " + col_i );

            arr_temp[row_i][col_i]   = vo.getString("A_1");   //-------------------> 조회년수가 바뀔경우 수정요함
            arr_temp[row_i][col_i+1] = vo.getString("A_2");
            arr_temp[row_i][col_i+2] = vo.getString("A_3");
            arr_temp[row_i][col_i+3] = vo.getString("A_4");
            arr_temp[row_i][col_i+4] = vo.getString("A_5");

//            System.out.println(i % row_count);
        }
        for ( i = 0; i < col_block_cnt; i++ ) {
            JOB_NM[i] = arr_temp[0][year_cnt*i];
        }
        for ( i = 0; i < col_block_cnt; i++ ) {
            PRO_AVR[i] = arr_temp[row_count-1][year_cnt*i];
        }
        //----------------------------------------------------

        /************배열에 담긴 데이터를 전송***********/
        for ( int k = 0; k < row_count; k++ )
        {
            if ( k != 0 && k != row_count-1 ) 
            {
                for ( int m = 0; m < col_cnt; m++ )
                {
                    hnwExtQuery.AddData(arr_temp[k][m]);
                }
                for ( i = 0; i < col_block_cnt; i++ ) {
                    hnwExtQuery.AddData(JOB_NM[i]);
                }
                for ( i = 0; i < col_block_cnt; i++ ) {
                    hnwExtQuery.AddData(PRO_AVR[i]);
                }
                hnwExtQuery.AddData(occ_cd_val);
                
                hnwExtQuery.SendData(response);
            }
        }
        /***********************************************/
    } else {
        for ( i = 0; i < col_cnt+(col_block_cnt*2); i++ )
        {
            hnwExtQuery.AddData("");
        }
        hnwExtQuery.AddData("");
        hnwExtQuery.SendData(response);

    }
    
    

%>