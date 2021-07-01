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
    String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");	
    String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");
    int REC_YMD_SHR2   = Integer.parseInt(REC_YMD_SHR);
    int ii        = 6;
    String sql = "";
               sql =  "SELECT              \n";
        for(int j=5; j>0; j--){
           if ( j != 5 ) {sql +=  ",";}
		       sql +=  "       SUM(DECODE(YMD_A,'"+j+"',CASE COPYT.INT                                   \n";
               sql +=  "                                 WHEN 1 THEN TO_CHAR(REC_YMD,999999)         \n";
               sql +=  "                                 WHEN 2 THEN TO_CHAR(NOW_CNT,999999)         \n";
               sql +=  "                                 WHEN 3 THEN TO_CHAR(PMT_CNT,999999)         \n";
               sql +=  "                                 WHEN 4 THEN TO_CHAR(PMT_RAT,999999.9)       \n";
               sql +=  "                                 WHEN 5 THEN TO_CHAR(PRO_CNT,999999)         \n";
               sql +=  "                                 WHEN 6 THEN TO_CHAR(PRO_RAT,999999.9)       \n";
               sql +=  "                             END)) AS A_"+(ii-j)+"                                    \n";	   
        }
               sql +=  "      ,SUM(INT)    INT                                                       \n";
               sql +=  "      ,ROUND(SUM(PRO_CNT)/SUM(PMT_CNT)*100,1) AS PRO_AVR                     \n";
               sql += "FROM (";

		for(int i=5; i>0; i--){
			   sql += "     SELECT  A.D AS REC_YMD, A.NOW_CNT, B.PMT_CNT, ROUND(B.PMT_CNT/A.NOW_CNT*100, 1) AS PMT_RAT  \n";
			   sql += "             ,C.PRO_CNT, ROUND(C.PRO_CNT/B.PMT_CNT*100, 1) AS PRO_RAT, '"+i+"' YMD_A  \n";
			   sql += "     FROM   (SELECT '"+(REC_YMD_SHR2-i)+"' D, COUNT(*) AS NOW_CNT  \n";
			   sql += "             FROM   T_CM_PERSON  \n";
			   sql += "             WHERE  TO_CHAR(HIR_YMD,'YYYYMMDD') <= '"+(REC_YMD_SHR2-i)+"0101'  \n";
			   sql += "             AND    (TO_CHAR(RET_YMD,'YYYYMMDD') > '"+(REC_YMD_SHR2-i)+"0101' OR RET_YMD IS NULL)  \n";
			   sql += "             ) A,  \n";
			   sql += "             (SELECT PMT_YY, COUNT(*) AS PMT_CNT  \n";
			   sql += "             FROM   T_PM_PROMOTION  \n";
			   sql += "             WHERE  PMT_YY = '"+(REC_YMD_SHR2-i)+"'  \n";
			   sql += "             GROUP  BY PMT_YY  \n";
			   sql += "             ) B,  \n";
			   sql += "             (SELECT PMT_YY, EST_CD, COUNT(*) AS PRO_CNT  \n";
			   sql += "             FROM   T_PM_PROMOTION  \n";
			   sql += "             WHERE  PMT_YY = '"+(REC_YMD_SHR2-i)+"'  \n";
			   sql += "             AND    EST_CD = 'Y'  \n";
			   sql += "             GROUP  BY PMT_YY, EST_CD  \n";
			   sql += "             ) C  \n";
			   sql += "       WHERE A.D = B.PMT_YY(+)  \n";
               sql += "         AND A.D = C.PMT_YY(+)  \n";

			   if( i!=1 ){
			   sql += "UNION ALL  \n";
			   }
		}	   
		       sql += "     ) A,                        \n";
               sql += "     (                           \n";
               sql += "     SELECT ROWNUM INT           \n";
               sql += "       FROM DICT                 \n";
               sql += "      WHERE ROWNUM <=6           \n";
               sql += "     ) COPYT                     \n";
               sql += " GROUP BY INT                    \n";

    /** 검색 조건 Mapping(PrepareStatement ) **/
    Object[] bind = new Object[] {
            
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("2001");
    hnwExtQuery.AddField("2002");
    hnwExtQuery.AddField("2003");
    hnwExtQuery.AddField("2004");
    hnwExtQuery.AddField("2005");
    hnwExtQuery.AddField("1");
    hnwExtQuery.AddField("2");
    hnwExtQuery.AddField("3");
    hnwExtQuery.AddField("4");
    hnwExtQuery.AddField("5");
    hnwExtQuery.AddField("평균승진율");

    hnwExtQuery.SendField(response);
    
//    System.out.println("voList.size()="+voList.size());
    String pre_job = "";
    String A_year1 = "";
    String A_year2 = "";
    String A_year3 = "";
    String A_year4 = "";
    String A_year5 = "";


    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);  

            if ( i == 0 ) {
                A_year1 = vo.getString("A_1");
                A_year2 = vo.getString("A_2");
                A_year3 = vo.getString("A_3");
                A_year4 = vo.getString("A_4");
                A_year5 = vo.getString("A_5");
            } else {
                hnwExtQuery.AddData(vo.getString("A_1"));
                hnwExtQuery.AddData(vo.getString("A_2"));
                hnwExtQuery.AddData(vo.getString("A_3"));
                hnwExtQuery.AddData(vo.getString("A_4"));
                hnwExtQuery.AddData(vo.getString("A_5"));
                hnwExtQuery.AddData(A_year1);
                hnwExtQuery.AddData(A_year2);
                hnwExtQuery.AddData(A_year3);
                hnwExtQuery.AddData(A_year4);
                hnwExtQuery.AddData(A_year5);
                hnwExtQuery.AddData(vo.getString("PRO_AVR"));

                hnwExtQuery.SendData(response);
            }
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

            hnwExtQuery.SendData(response);
    }

%>