package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a050015_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceStatement gsmt = null;
				GauceStatement gsmt2 = null;
				GauceStatement gsmt3 = null;
				GauceStatement gsmt4 = null;
				GauceStatement gsmt4_2 = null;
				GauceStatement gsmt5 = null;
				GauceStatement gsmt99 = null;
				GauceStatement gsmt100 = null;


			 //HEAD//////////////////////////////////////////////////////////////////////////////
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				String[] StrArrCN = new String[] {
					"FDCODE",	 "FRYMD",	   "TOYMD",	 "RCDGB",	  "TAXOFF",	
					"ACCYMD",	 "SENDGB",   "TAXNO",	 "VENDID",	"VENDNM",	
					"COREGNO", "VDDIRECT", "POSTNO", "VDADDR",	"TELNO",	
					"SENDCNT", "KORCD",	   "FILLER", "ACCYY",   "ACCYYQT", "RPTGB"
				};			
				
				int[] idx = new int[21];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
       
				StringBuffer InsertSql = null;
				StringBuffer InsertSql2 = null;
				StringBuffer InsertSql3 = null;
				StringBuffer InsertSql4 = null;
				StringBuffer InsertSql4_2 = null;

				StringBuffer InsertSql5 = null;

				StringBuffer DeleteSql = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;
				StringBuffer DeleteSql4 = null;
				StringBuffer DeleteSql5 = null;

				StringBuffer UpdateSql = null;
				StringBuffer UpdateSql2 = null;
				
				//AVATRPT11 계산서 합계표 A레코드
				//AVATRPT12 계산서 합계표 B레코드
				//AVATRPT13 계산서 합계표 C레코드
				//AVATRPT14 계산서 합계표 D레코드
				//AVATRPT15 계산서 합계표 E레코드
	
				for (int k = 0; k < rows.length; k++){
					if(rows[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            
						//삭제
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.AVATRPT11	");
						DeleteSql.append( "  WHERE FDCODE=?	");
						DeleteSql.append( "    AND FRYMD=? 	");
						DeleteSql.append( "    AND TOYMD=?	");
			
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[k]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);

						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;

						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.AVATRPT12	");
						DeleteSql2.append( "  WHERE FDCODE=?	");
						DeleteSql2.append( "    AND FRYMD=? 	");
						DeleteSql2.append( "    AND TOYMD=?	  ");
						
						gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[k]);
						gsmt2.bindColumn(1, idx[0]);
						gsmt2.bindColumn(2, idx[1]);
						gsmt2.bindColumn(3, idx[2]);

						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt2=null;

						DeleteSql3 = new StringBuffer();
						DeleteSql3.append( " DELETE FROM ACCOUNT.AVATRPT13	");
						DeleteSql3.append( "  WHERE FDCODE=?	");
						DeleteSql3.append( "    AND ACCYY=? 	");
						DeleteSql3.append( "    AND ACCYYQT=?	");
						DeleteSql3.append( "    AND RPTGB=?	  ");
						
						gsmt3 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt3.setGauceDataRow(rows[k]);
						gsmt3.bindColumn(1, idx[0]);
						gsmt3.bindColumn(2, idx[18]);
						gsmt3.bindColumn(3, idx[19]);
						gsmt3.bindColumn(4, idx[20]);
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3=null;


						DeleteSql4 = new StringBuffer();
						DeleteSql4.append( " DELETE FROM ACCOUNT.AVATRPT14	");
						DeleteSql4.append( "  WHERE FDCODE=?	");
						DeleteSql4.append( "    AND ACCYY=? 	");
						DeleteSql4.append( "    AND ACCYYQT=?	");
						DeleteSql4.append( "    AND RPTGB=?	  ");
						
						gsmt4 = conn.getGauceStatement(DeleteSql4.toString());
						gsmt4.setGauceDataRow(rows[k]);
						gsmt4.bindColumn(1, idx[0]);
						gsmt4.bindColumn(2, idx[18]);
						gsmt4.bindColumn(3, idx[19]);
						gsmt4.bindColumn(4, idx[20]);
						gsmt4.executeUpdate();
						gsmt4.close();
						gsmt4=null;

          
						DeleteSql5 = new StringBuffer();
						DeleteSql5.append(" DELETE FROM ACCOUNT.AVATRPT15	");
						DeleteSql5.append("  WHERE FDCODE=?		");
						DeleteSql5.append("    AND ACCYY=?			");
						DeleteSql5.append("    AND ACCYYQT=?		");
						DeleteSql5.append("    AND RPTGB=?			");
	
						gsmt5 = conn.getGauceStatement(DeleteSql5.toString());
						gsmt5.setGauceDataRow(rows[k]);
						gsmt5.bindColumn(1, idx[0]);
						gsmt5.bindColumn(2, idx[18]);
						gsmt5.bindColumn(3, idx[19]);
						gsmt5.bindColumn(4, idx[20]);
	 				    
						gsmt5.executeUpdate();
						gsmt5.close();
						gsmt5 = null;
					
						

                        //INSERT A
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.AVATRPT11 (			    	\n");
						InsertSql.append( " FDCODE,  FRYMD,   TOYMD,  RCDGB,  TAXOFF,	\n");
						InsertSql.append( " ACCYMD,  SENDGB,  TAXNO,  VENDID, VENDNM,	\n");
						InsertSql.append( " COREGNO, VDDIRECT,POSTNO, VDADDR, TELNO,  \n");
						InsertSql.append( " SENDCNT, KORCD,    FILLER                	\n");
						InsertSql.append( " ) VALUES(													      	\n");						
						InsertSql.append( " ?,?,?,?,?,  \n");
						InsertSql.append( " ?,?,?,?,?,  \n");
						InsertSql.append( " ?,?,?,?,?,  \n");
						InsertSql.append( " ?,?,?       \n");
						InsertSql.append( " )					  \n");

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[k]);
            
						gsmt.bindColumn(1, idx[0] );   
						gsmt.bindColumn(2, idx[1] );   
						gsmt.bindColumn(3, idx[2] );   
						gsmt.bindColumn(4, idx[3] );   
						gsmt.bindColumn(5, idx[4] );   
						gsmt.bindColumn(6, idx[5] );   
						gsmt.bindColumn(7, idx[6] );   
						gsmt.bindColumn(8, idx[7] );   
						gsmt.bindColumn(9, idx[8] );   
						gsmt.bindColumn(10,idx[9] );   
						gsmt.bindColumn(11,idx[10] );   
						gsmt.bindColumn(12,idx[11] );   
						gsmt.bindColumn(13,idx[12] );   
						gsmt.bindColumn(14,idx[13] );   
						gsmt.bindColumn(15,idx[14] );   
						gsmt.bindColumn(16,idx[15] );   
						gsmt.bindColumn(17,idx[16] );   
						gsmt.bindColumn(18,idx[17] );   
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;
						

						//INSERT B
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.AVATRPT12 (	\n");
						InsertSql2.append( " FDCODE, FRYMD,  TOYMD,  RCDGB,     TAXOFF,                \n");
						InsertSql2.append( " SEQ,    VENDID, VENDNM, VDDIRECT,  POSTNO, VDADDR, FILLER \n");
						InsertSql2.append( " ) VALUES(												   \n");						
						InsertSql2.append( " ?,?,?,?,?,     \n");
						InsertSql2.append( " ?,?,?,?,?,?,?  \n");
						InsertSql2.append( " )				\n");

						gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows[k]);

						rows[k].setString(idx[3],"B");
            
						gsmt2.bindColumn(1, idx[0] );   
						gsmt2.bindColumn(2, idx[1] );   
						gsmt2.bindColumn(3, idx[2] );   
						gsmt2.bindColumn(4, idx[3] );   
						gsmt2.bindColumn(5, idx[4] );   
						gsmt2.bindColumn(6, idx[15] );   
						gsmt2.bindColumn(7, idx[8] );   
						gsmt2.bindColumn(8, idx[9] );   
						gsmt2.bindColumn(9, idx[11] );   
						gsmt2.bindColumn(10,idx[12] );   
						gsmt2.bindColumn(11,idx[13] );   
						gsmt2.bindColumn(12,idx[17] );   
						
						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt2=null;
            
						String strFdcode = rows[k].getString(idx[0]);
						String strAccyy =  rows[k].getString(idx[18]);
						String strAccyyqt =  rows[k].getString(idx[19]);
						String strRptgb  =  rows[k].getString(idx[20]);
						String strTaxoff =  rows[k].getString(idx[4]);
						String strVendid =  rows[k].getString(idx[8]);

						//2012.01.18.JYS 김효중GJ요청으로 전표상태 체크안함.

						//INSERT D				  
						InsertSql4 = new StringBuffer();
						InsertSql4.append( "INSERT INTO ACCOUNT.AVATRPT14	                                                                        \n");
						InsertSql4.append( "SELECT '"+strFdcode+"','"+strAccyy+"','D', 17 ,'"+strAccyyqt+"',      	                              \n");
						InsertSql4.append( "       '"+strRptgb+"','"+strTaxoff+"', ROW_NUMBER()OVER(ORDER BY C.VEND_ID),                        	\n");
						InsertSql4.append( "       '2218113834',C.VEND_ID, MAX(C.VEND_NM), COUNT(*),                                          	\n");
						InsertSql4.append( "       CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END,                                                 	\n");
						InsertSql4.append( "       ABS(SUM(A.TAXTOT)) TAXTOT,''FILLER                                                           	\n");
						InsertSql4.append( "  FROM ACCOUNT.ATTAXMST A                                                                           	\n");
						InsertSql4.append( "  LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR    	\n");
						InsertSql4.append( "  LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                          	\n");
						InsertSql4.append( " WHERE A.TAXDAT BETWEEN ? AND ?                                                                     	\n");
						InsertSql4.append( "   AND A.TAXIODIV IN ('B') --매출                                                                    	\n");
						InsertSql4.append( "   AND A.TAXKND IN ('3') -- 면세                                                                    	\n");
						InsertSql4.append("   AND A.GUBUN IN ('2') -- 수기                                                                    \n");
						InsertSql4.append("   AND LENGTH(C.VEND_ID) < '12'																\n");						
						InsertSql4.append( " GROUP BY C.VEND_ID                                                                                 	\n");						
						InsertSql4.append( "UNION ALL                                                                                           	\n");
						InsertSql4.append( "SELECT '"+strFdcode+"','"+strAccyy+"','D', 18 ,'"+strAccyyqt+"',                                    	\n");
						InsertSql4.append( "       '"+strRptgb+"','"+strTaxoff+"', ROW_NUMBER()OVER(ORDER BY C.VEND_ID),                        	\n");
						InsertSql4.append( "       '2218113834',C.VEND_ID, MAX(C.VEND_NM), COUNT(*),                                             	\n");
						InsertSql4.append( "       CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END,                                                 	\n");
						InsertSql4.append( "       ABS(SUM(A.TAXTOT)) TAXTOT,''FILLER                                                           	\n");
						InsertSql4.append( "  FROM ACCOUNT.ATTAXMST A                                                                           	\n");
						InsertSql4.append( "  LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR    	\n");
						InsertSql4.append( "  LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                          	\n");
						InsertSql4.append( " WHERE A.TAXDAT BETWEEN ? AND ?                                                                     	\n");
						InsertSql4.append( "   AND A.TAXIODIV IN ('A') --매입                                                                    	\n");
						InsertSql4.append( "   AND A.TAXKND IN ('3') -- 면세                                                                    	\n");
						InsertSql4.append("   AND A.GUBUN IN ('2') -- 수기																	    	\n");
						InsertSql4.append( " GROUP BY C.VEND_ID                                                                                 	\n");

						//System.out.println("수기 InsertSql4::"+InsertSql4.toString());
						
						gsmt4 = conn.getGauceStatement(InsertSql4.toString());
						gsmt4.setGauceDataRow(rows[k]);
            
						gsmt4.bindColumn(1, idx[1] ); 
						gsmt4.bindColumn(2, idx[2] );  
						gsmt4.bindColumn(3, idx[1] ); 
						gsmt4.bindColumn(4, idx[2] );
						
						gsmt4.executeUpdate();
						gsmt4.close();
						gsmt4=null;
						
	
					  InsertSql4_2 = new StringBuffer();

					  InsertSql4_2.append("INSERT INTO ACCOUNT.AVATRPT14                                                                        \n");
					  InsertSql4_2.append("SELECT '" + strFdcode + "','" + strAccyy + "','F', 17 ,'" + strAccyyqt + "',                                    \n");
					  InsertSql4_2.append("       '" + strRptgb + "','" + strTaxoff + "', ROW_NUMBER()OVER(ORDER BY C.VEND_ID),                        \n");
					  InsertSql4_2.append("       '2218113834',C.VEND_ID, MAX(C.VEND_NM), COUNT(*),                                          \n");
					  InsertSql4_2.append("       CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END,                                                 \n");
					  InsertSql4_2.append("       ABS(SUM(A.TAXTOT)) TAXTOT,''FILLER                                                           \n");
					  InsertSql4_2.append("  FROM ACCOUNT.ATTAXMST A                                                                           \n");
					  InsertSql4_2.append("  LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR    \n");
					  InsertSql4_2.append("  LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                          \n");
					  InsertSql4_2.append(" WHERE A.TAXDAT BETWEEN ? AND ?                                                                     \n");
					  InsertSql4_2.append("   AND A.TAXIODIV IN ('B') --매출                                                                    \n");
					  InsertSql4_2.append("   AND A.TAXKND IN ('3') -- 면세                                                                    \n");
					  InsertSql4_2.append("   AND A.GUBUN IN ('1') -- 전자                                                                    \n");
					  InsertSql4_2.append("   AND LENGTH(C.VEND_ID) < '12'\n");
					  InsertSql4_2.append(" GROUP BY C.VEND_ID                                                                                 \n");
					  InsertSql4_2.append("UNION ALL                                                                                           \n");
					  InsertSql4_2.append("SELECT '" + strFdcode + "','" + strAccyy + "','F', 18 ,'" + strAccyyqt + "',                                    \n");
					  InsertSql4_2.append("       '" + strRptgb + "','" + strTaxoff + "', ROW_NUMBER()OVER(ORDER BY C.VEND_ID),                        \n");
					  InsertSql4_2.append("       '2218113834',C.VEND_ID, MAX(C.VEND_NM), COUNT(*),                                             \n");
					  InsertSql4_2.append("       CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END,                                                 \n");
					  InsertSql4_2.append("       ABS(SUM(A.TAXTOT)) TAXTOT,''FILLER                                                           \n");
					  InsertSql4_2.append("  FROM ACCOUNT.ATTAXMST A                                                                           \n");
					  InsertSql4_2.append("  LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR    \n");
					  InsertSql4_2.append("  LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                          \n");
					  InsertSql4_2.append(" WHERE A.TAXDAT BETWEEN ? AND ?                                                                     \n");
					  InsertSql4_2.append("   AND A.TAXIODIV IN ('A') --매입                                                                    \n");
					  InsertSql4_2.append("   AND A.TAXKND IN ('3') -- 면세                                                                    \n");
					  InsertSql4_2.append("   AND A.GUBUN IN ('1') -- 전자                                                                     \n");
					  InsertSql4_2.append(" GROUP BY C.VEND_ID                                                                                 \n");

					  //System.out.println("전자 InsertSql4_2::"+InsertSql4_2.toString());
					  
					  gsmt4_2 = conn.getGauceStatement(InsertSql4_2.toString());
					  gsmt4_2.setGauceDataRow(rows[k]);

					  gsmt4_2.bindColumn(1, idx[1]);
					  gsmt4_2.bindColumn(2, idx[2]);
					  gsmt4_2.bindColumn(3, idx[1]);
					  gsmt4_2.bindColumn(4, idx[2]);

					  gsmt4_2.executeUpdate();
					  gsmt4_2.close();
					  gsmt4_2 = null;

					    String strFrymd =  rows[k].getString(idx[1]);
						String strToymd =  rows[k].getString(idx[2]);
						String strWrymd =  rows[k].getString(idx[5]);

           				InsertSql3 = new StringBuffer();
						InsertSql3.append( " INSERT INTO ACCOUNT.AVATRPT13                                                        	\n");
						InsertSql3.append( " SELECT A.FDCODE, 'C' RCDGB, A.DATADIV, A.ACCYYQT, A.RPTGB,                             \n");
						InsertSql3.append( "        A.TAXOFF, ROW_NUMBER()OVER(PARTITION BY A.DATADIV ORDER BY A.DATADIV) AS SEQ,  A.VENDID,           \n");
						InsertSql3.append( "        A.ACCYY, '"+strFrymd+"' AS FRYMD, '"+strToymd+"'AS TOYMD, '"+strWrymd+"' AS WRYMD,\n");
						InsertSql3.append( "        COUNT(*) AS VENDCNT, SUM(A.SHTCNT) AS SHTCHT,                                   \n");
						InsertSql3.append( "        CASE WHEN SUM(A.REQAMT)<0 THEN 1 ELSE 0 END NUMEXP,                             \n");
						InsertSql3.append( "        SUM(CASE WHEN NUMEXP=1 THEN (-A.REQAMT) ELSE A.REQAMT END) AS REQAMT,           \n");
						InsertSql3.append( "        0 VENDCNT1, 0 SHTCNT1, 0 NUMEXP1, 0 REQAMT1,                                    \n");
						InsertSql3.append( "        0 VENDCNT2, 0 SHTCNT2, 0 NUMEXP2, 0 REQAMT2,                                    \n");
						InsertSql3.append( "        ''FILLER                                                                        \n");
						InsertSql3.append( "   FROM ACCOUNT.AVATRPT14 A                                                             \n");
						InsertSql3.append( "  WHERE A.FDCODE =?                                                                     \n");
						InsertSql3.append( "    AND A.ACCYY =?                                                                      \n");
						InsertSql3.append( "    AND A.ACCYYQT =?                                                                    \n");
						InsertSql3.append( "    AND A.RPTGB =?                                                                      \n");
						//2013.12.27 jys 추가
						InsertSql3.append( "    AND A.RCDGB ='D'                                                                      \n");
						InsertSql3.append( "  GROUP BY A.FDCODE, A.RCDGB, A.DATADIV, A.ACCYYQT, A.RPTGB,                            \n");
						InsertSql3.append( "           A.TAXOFF, A.VENDID, A.ACCYY                                                  \n");				

						
						//System.out.println("AVATRPT13 InsertSql3::"+InsertSql3.toString());
						
						gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows[k]);
            
  						gsmt3.bindColumn(1, idx[0]);
						gsmt3.bindColumn(2, idx[18]);
						gsmt3.bindColumn(3, idx[19]);
						gsmt3.bindColumn(4, idx[20]);
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3=null;
						
					 
					
					  InsertSql5 = new StringBuffer();
					  InsertSql5.append(" INSERT INTO ACCOUNT.AVATRPT15                                                        \n");
					  InsertSql5.append(" SELECT A.FDCODE, 'E' RCDGB, A.DATADIV, A.ACCYYQT, A.RPTGB,                             \n");
					  InsertSql5.append("        A.TAXOFF, ROW_NUMBER()OVER(PARTITION BY A.DATADIV ORDER BY A.DATADIV) AS SEQ,  A.VENDID,          \n");
					  InsertSql5.append("        A.ACCYY, '" + strFrymd + "' AS FRYMD, '" + strToymd + "'AS TOYMD, '" + strWrymd + "' AS WRYMD,\n");
					  InsertSql5.append("        COUNT(*) AS VENDCNT, SUM(A.SHTCNT) AS SHTCHT,                                   \n");
					  InsertSql5.append("        CASE WHEN SUM(A.REQAMT)<0 THEN 1 ELSE 0 END NUMEXP,                             \n");
					  InsertSql5.append("        SUM(CASE WHEN NUMEXP=1 THEN (-A.REQAMT) ELSE A.REQAMT END) AS REQAMT,           \n");
					  InsertSql5.append("        0 VENDCNT1, 0 SHTCNT1, 0 NUMEXP1, 0 REQAMT1,                                    \n");
					  InsertSql5.append("        0 VENDCNT2, 0 SHTCNT2, 0 NUMEXP2, 0 REQAMT2,                                    \n");
					  InsertSql5.append("        ''FILLER                                                                        \n");
					  InsertSql5.append("   FROM ACCOUNT.AVATRPT14 A                                                             \n");
					  InsertSql5.append("  WHERE A.FDCODE =?                                                                     \n");
					  InsertSql5.append("    AND A.ACCYY =?                                                                      \n");
					  InsertSql5.append("    AND A.ACCYYQT =?                                                                    \n");
					  InsertSql5.append("    AND A.RPTGB =?                                                                      \n");
					  InsertSql5.append("    AND A.RCDGB ='F'                                                                      \n");
					  InsertSql5.append("  GROUP BY A.FDCODE, A.RCDGB, A.DATADIV, A.ACCYYQT, A.RPTGB,                            \n");
					  InsertSql5.append("           A.TAXOFF, A.VENDID, A.ACCYY                                                  \n");

					  //System.out.println("AVATRPT15 InsertSql5::"+InsertSql5.toString());
					  gsmt5 = conn.getGauceStatement(InsertSql5.toString());
					  gsmt5.setGauceDataRow(rows[k]);

					  gsmt5.bindColumn(1, idx[0]);
					  gsmt5.bindColumn(2, idx[18]);
					  gsmt5.bindColumn(3, idx[19]);
					  gsmt5.bindColumn(4, idx[20]);

					  gsmt5.executeUpdate();
					  gsmt5.close();
					  gsmt5 = null;
					  
					  
					  //2014.01.19. JYS 정영식 추가 START
					  //AVATRPT15에 데이터가 존재하지 않으면 기본 데이터 입력 ...금액은 0 
					  ////////////////////////////////////////////////////////////////////
					  //매출..
					  int cnt = 0;
					  StringBuffer sql0 = new StringBuffer();
					  sql0.append("  SELECT COUNT(*) CNT FROM ACCOUNT.AVATRPT15  \n");	 
					  sql0.append("   WHERE FDCODE   = '"+strFdcode+"' \n");
					  sql0.append("     AND ACCYY    = '"+strAccyy+"' \n");
					  sql0.append("     AND ACCYYQT  = '"+strAccyyqt+"' \n");
					  sql0.append("     AND RPTGB    = '"+strRptgb+"' \n");
					  sql0.append( "    AND DATADIV  = '17' \n");	//매출
					  
					  Statement stmt0 = conn.createStatement();
					  ResultSet rs0   = stmt0.executeQuery(sql0.toString());
					  
					  while(rs0.next()){
						  cnt=rs0.getInt(1); 
					  }
					  rs0.close();
					  stmt0.close();
					  
					  if(cnt==0){
						  InsertSql5 = new StringBuffer();
						  InsertSql5.append(" INSERT INTO ACCOUNT.AVATRPT15 (                \n");
						  InsertSql5.append(" FDCODE,   RCDGB,   DATADIV, ACCYYQT, RPTGB,    \n");
						  InsertSql5.append(" TAXOFF,   SEQ,     VENDID,  ACCYY,   FRYMD,    \n");
						  InsertSql5.append(" TOYMD,    WRYMD,   VENDCNT, SHTCNT,  NUMEXP,   \n");
						  InsertSql5.append(" REQAMT,   VENDCNT1,SHTCNT1, NUMEXP1, REQAMT1,  \n");
						  InsertSql5.append(" VENDCNT2, SHTCNT2, NUMEXP2, REQAMT2, FILLER    \n");
						  InsertSql5.append(" )VALUES(                                       \n");
						  InsertSql5.append(" '"+strFdcode+"','E','17','"+strAccyyqt+"','"+strRptgb+"',   \n");
						  InsertSql5.append(" '"+strTaxoff+"', 1, '"+strVendid+"', '"+strAccyy+"','" + strFrymd + "',  \n");
						  InsertSql5.append(" '" + strToymd + "', '" + strWrymd + "', 0,0,0,  \n");
						  InsertSql5.append("  0,0,0,0,0,  \n");
						  InsertSql5.append("  0,0,0,0,'' )\n");

						  gsmt5= conn.getGauceStatement(InsertSql5.toString());
						  gsmt5.setGauceDataRow(rows[k]);
						  gsmt5.executeUpdate();
						  gsmt5.close();
					  }
					  
					  
					  
					  //매입..
					  cnt = 0;
					  sql0 = new StringBuffer();
					  sql0.append(" SELECT COUNT(*) CNT FROM ACCOUNT.AVATRPT15  \n");	 
					  sql0.append("   WHERE FDCODE   = '"+strFdcode+"' \n");
					  sql0.append("     AND ACCYY    = '"+strAccyy+"' \n");
					  sql0.append("     AND ACCYYQT  = '"+strAccyyqt+"' \n");
					  sql0.append("     AND RPTGB    = '"+strRptgb+"' \n");
					  sql0.append( "    AND DATADIV  = '18' \n");	//매입
					  
					  stmt0 = conn.createStatement();
					  rs0   = stmt0.executeQuery(sql0.toString());
					  
					  while(rs0.next()){
						  cnt=rs0.getInt(1); 
					  }
					  rs0.close();
					  stmt0.close();
					  
					  if(cnt==0){
						  InsertSql5 = new StringBuffer();
						  InsertSql5.append(" INSERT INTO ACCOUNT.AVATRPT15 (                \n");
						  InsertSql5.append(" FDCODE,   RCDGB,   DATADIV, ACCYYQT, RPTGB,    \n");
						  InsertSql5.append(" TAXOFF,   SEQ,     VENDID,  ACCYY,   FRYMD,    \n");
						  InsertSql5.append(" TOYMD,    WRYMD,   VENDCNT, SHTCNT,  NUMEXP,   \n");
						  InsertSql5.append(" REQAMT,   VENDCNT1,SHTCNT1, NUMEXP1, REQAMT1,  \n");
						  InsertSql5.append(" VENDCNT2, SHTCNT2, NUMEXP2, REQAMT2, FILLER    \n");
						  InsertSql5.append(" )VALUES(                                       \n");
						  InsertSql5.append(" '"+strFdcode+"','E','18','"+strAccyyqt+"','"+strRptgb+"',   \n");
						  InsertSql5.append(" '"+strTaxoff+"', 1, '"+strVendid+"', '"+strAccyy+"','" + strFrymd + "',  \n");
						  InsertSql5.append(" '" + strToymd + "', '" + strWrymd + "', 0,0,0,  \n");
						  InsertSql5.append("  0,0,0,0,0,  \n");
						  InsertSql5.append("  0,0,0,0,'' )\n");

						  gsmt5= conn.getGauceStatement(InsertSql5.toString());
						  gsmt5.setGauceDataRow(rows[k]);
						  gsmt5.executeUpdate();
						  gsmt5.close();
					  }
					 
					  //AVATRPT15에 데이터가 존재하지 않으면 기본 데이터 입력 ...금액은 0 
					  //2014.01.19. JYS 정영식 추가 END
					  /////////////////////////////////////////////////////////////////////



					  //C테이블의 매출 중 사업자등록번호 건과 주민등록번호 건 구분하여 UPDATE 처리함. 
					    double dblVendcnt=0;
						double dblShtcnt=0;
						double dblNumexp=0;
						double dblReqamt=0;		
						double dblVendcnt1=0;
						double dblShtcnt1=0;
						double dblNumexp1=0;
						double dblReqamt1=0;
						double dblVendcnt2=0;
						double dblShtcnt2=0;
						double dblNumexp2=0;
						double dblReqamt2=0;
               

						StringBuffer sql = new StringBuffer();

						sql.append(" SELECT  \n");	
						sql.append("        SUM(X.VENDCNT1)VENDCNT1,SUM(X.SHTCNT1)SHTCNT1, SUM(X.NUMEXP1)NUMEXP1, SUM(X.REQAMT1)REQAMT1,\n");	
						sql.append("        SUM(X.VENDCNT2)VENDCNT2,SUM(X.SHTCNT2)SHTCNT2, SUM(nvl(X.NUMEXP2,0))NUMEXP2, SUM(X.REQAMT2)REQAMT2 ,X.TAXIODIV\n");	
						sql.append(" FROM (                                                                                             \n");	
						sql.append("	SELECT COUNT(DISTINCT C.VEND_ID) VENDCNT1, COUNT(*) SHTCNT1,                                      \n");	
						sql.append("         CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END AS  NUMEXP1,                                   \n");	
						sql.append("         ABS(SUM(A.TAXTOT)) REQAMT1,                                                                \n");	
						sql.append("         0 VENDCNT2, 0 SHTCNT2, 0 NUMEXP2, 0 REQAMT2 , A.TAXIODIV                                   \n");	
						sql.append("    FROM ACCOUNT.ATTAXMST A                                                                         \n");	
						sql.append("	  LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR  \n");	
						sql.append("    LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                        \n");	
						sql.append("   WHERE A.TAXDAT BETWEEN '"+strFrymd+"' AND '"+strToymd+"'                                         \n");	
						sql.append("     AND A.TAXIODIV IN ('A','B')                                                                        \n");	
						sql.append("     AND A.TAXKND IN ('3') -- 면세                                                                  \n");	
						sql.append("	 AND A.GUBUN ='2'      -- 수기                                                                               \n");	
						sql.append("     AND LENGTH(C.VEND_ID)=10  --사업자등록분                                                       \n");	
						sql.append("     GROUP BY A.TAXIODIV                                              \n");
						sql.append("   UNION ALL                                                                                        \n");	
						sql.append("  SELECT 0 VENDCNT1, 0 SHTCNT1, 0 NUMEXP1, 0 REQAMT1,                                               \n");	
						sql.append("         COUNT(DISTINCT C.VEND_ID) VENDCNT2, COUNT(*) SHTCNT2,                                      \n");	
						sql.append("	       CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END AS  NUMEXP2,                                   \n");	
						sql.append("         ABS(SUM(A.TAXTOT)) REQAMT2 , A.TAXIODIV                                                     \n");	
						sql.append("    FROM ACCOUNT.ATTAXMST A                                                                         \n");	
						sql.append("    LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR  \n");	
						sql.append("    LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                        \n");	
						sql.append("	 WHERE A.TAXDAT BETWEEN '"+strFrymd+"' AND '"+strToymd+"'                                         \n");	
						sql.append("     AND A.TAXIODIV IN ('A','B')                                                                        \n");	
						sql.append("     AND A.TAXKND IN ('3') -- 면세                                                                  \n");	
						sql.append("     AND A.GUBUN ='2'      -- 수기                                                                           \n");	
						sql.append("     AND LENGTH(C.VEND_ID)=13  --주민번호등록분                                                     \n");	
						sql.append("     GROUP BY A.TAXIODIV                                              \n");
						sql.append("	)X                                                                                                \n");	
						sql.append(" GROUP BY X.TAXIODIV                                                                               \n");
						//System.out.println("수기sql::"+sql.toString()); 
						Statement stmt = conn.createStatement();
						ResultSet rs   = stmt.executeQuery(sql.toString());
					
						while(rs.next()) {
							
							dblVendcnt=0;
							dblShtcnt=0;
							dblNumexp=0;
							dblReqamt=0;		
							dblVendcnt1=0;
							dblShtcnt1=0;
							dblNumexp1=0;
							dblReqamt1=0;
							dblVendcnt2=0;
							dblShtcnt2=0;
							dblNumexp2=0;
							dblReqamt2=0;

							dblVendcnt1 = rs.getDouble(1);
							dblShtcnt1  = rs.getDouble(2);
							dblNumexp1  = rs.getDouble(3);
							dblReqamt1  = rs.getDouble(4);
							dblVendcnt2 = rs.getDouble(5);
							dblShtcnt2  = rs.getDouble(6);
							dblNumexp2  = rs.getDouble(7);
							dblReqamt2  = rs.getDouble(8);

							dblVendcnt = rs.getDouble(1) + rs.getDouble(5);
							dblShtcnt = rs.getDouble(2) + rs.getDouble(6);
							//dblNumexp = rs.getDouble(3) + rs.getDouble(7);
							dblReqamt = rs.getDouble(4) + rs.getDouble(8);
							
							//2015.07.15.jys 수정
							if(dblReqamt<0){
								dblNumexp = 1; //음수
							}else{
								dblNumexp = 0; //양수
							}
							
							
							//수기 UPDATE 
							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE  ACCOUNT.AVATRPT13 SET \n" );

							//매출합계 
						    UpdateSql.append("  VENDCNT = " + dblVendcnt + ",\n");
						    UpdateSql.append("  SHTCNT  = " + dblShtcnt + ", \n");
						    UpdateSql.append("  NUMEXP  = " + dblNumexp + ", \n");
						    UpdateSql.append("  REQAMT  = " + dblReqamt + ", \n");

						    //매출사업자번호
							UpdateSql.append( "  VENDCNT1 = "+dblVendcnt1+",\n" );
							UpdateSql.append( "  SHTCNT1  = "+dblShtcnt1+", \n" );
							UpdateSql.append( "  NUMEXP1  = "+dblNumexp1+", \n" );
							UpdateSql.append( "  REQAMT1  = "+dblReqamt1+", \n" );

	                        //매출주민번호
							UpdateSql.append( "  VENDCNT2 = "+dblVendcnt2+",\n" );
							UpdateSql.append( "  SHTCNT2  = "+dblShtcnt2+", \n" );
							UpdateSql.append( "  NUMEXP2  = "+dblNumexp2+", \n" );
							UpdateSql.append( "  REQAMT2  = "+dblReqamt2+"  \n" );


							UpdateSql.append( "   WHERE FDCODE   = ? \n");
							UpdateSql.append( "     AND ACCYY    = ? \n");
							UpdateSql.append( "     AND ACCYYQT  = ? \n");
							UpdateSql.append( "     AND RPTGB    = ? \n");
							
							if(rs.getString(9).equals("B")){
								UpdateSql.append( "     AND DATADIV  = '17' \n");	//매출
							}else if(rs.getString(9).equals("A")){
								UpdateSql.append( "     AND DATADIV  = '18' \n");	//매입	
							}
							
							
							
							//System.out.println("매출 수기 UpdateSql::"+UpdateSql.toString());

							gsmt99 = conn.getGauceStatement(UpdateSql.toString());

							gsmt99.setGauceDataRow(rows[k]);

							gsmt99.bindColumn(1, idx[0]);
							gsmt99.bindColumn(2, idx[18]);
							gsmt99.bindColumn(3, idx[19]);
							gsmt99.bindColumn(4, idx[20]);

							gsmt99.executeUpdate();
							gsmt99.close(); 

						}
						stmt.close();
						rs.close();

						

						  double FdblVendcnt = 0;
						  double FdblShtcnt = 0;
						  double FdblNumexp = 0;
						  double FdblReqamt = 0;

						  double FdblVendcnt1 = 0;
						  double FdblShtcnt1 = 0;
						  double FdblNumexp1 = 0;
						  double FdblReqamt1 = 0;

						  double FdblVendcnt2 = 0;
						  double FdblShtcnt2 = 0;
						  double FdblNumexp2 = 0;
						  double FdblReqamt2 = 0;

						  StringBuffer sql2 = new StringBuffer();
						  sql2.append(" SELECT \n");
						  sql2.append("        SUM(X.VENDCNT1)VENDCNT1,SUM(X.SHTCNT1)SHTCNT1, SUM(X.NUMEXP1)NUMEXP1, SUM(X.REQAMT1)REQAMT1,\n");
						  sql2.append("        SUM(X.VENDCNT2)VENDCNT2,SUM(X.SHTCNT2)SHTCNT2, SUM(X.NUMEXP2)NUMEXP2, SUM(X.REQAMT2)REQAMT2,X.TAXIODIV \n");
						  sql2.append(" FROM (                                                                                             \n");
						  sql2.append("SELECT COUNT(DISTINCT C.VEND_ID) VENDCNT1, COUNT(*) SHTCNT1,                                      \n");
						  sql2.append("         CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END AS  NUMEXP1,                                   \n");
						  sql2.append("         ABS(SUM(A.TAXTOT)) REQAMT1,                                                                \n");
						  sql2.append("         0 VENDCNT2, 0 SHTCNT2, 0 NUMEXP2, 0 REQAMT2, A.TAXIODIV                                    \n");
						  sql2.append("    FROM ACCOUNT.ATTAXMST A                                                                         \n");
						  sql2.append("  LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR  \n");
						  sql2.append("    LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                        \n");
						  sql2.append("   WHERE A.TAXDAT BETWEEN '" + strFrymd + "' AND '" + strToymd + "'                                         \n");
						  sql2.append("     AND A.TAXIODIV IN ('A','B')                                                                         \n");
						  sql2.append("     AND A.TAXKND IN ('3') -- 면세                                                                  \n");
						  sql2.append("     AND A.GUBUN ='1'      -- 전자                                                                      \n");
						  sql2.append("     AND LENGTH(C.VEND_ID)=10  --사업자등록분                                                       \n");
						  sql2.append("     GROUP BY A.TAXIODIV                                              \n");
						  sql2.append("   UNION ALL                                                                                        \n");
						  sql2.append("  SELECT 0 VENDCNT1, 0 SHTCNT1, 0 NUMEXP1, 0 REQAMT1,                                               \n");
						  sql2.append("         COUNT(DISTINCT C.VEND_ID) VENDCNT2, COUNT(*) SHTCNT2,                                      \n");
						  sql2.append("       CASE WHEN SUM(A.TAXTOT)<0 THEN 1 ELSE 0 END AS  NUMEXP2,                                   \n");
						  sql2.append("         ABS(SUM(A.TAXTOT)) REQAMT2, A.TAXIODIV                                                     \n");
						  sql2.append("    FROM ACCOUNT.ATTAXMST A                                                                         \n");
						  sql2.append("    LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR  \n");
						  sql2.append("    LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                        \n");
						  sql2.append("   WHERE A.TAXDAT BETWEEN '" + strFrymd + "' AND '" + strToymd + "'                                         \n");
						  sql2.append("     AND A.TAXIODIV IN ('A','B')                                                                        \n");
						  sql2.append("     AND A.TAXKND IN ('3') -- 면세                                                                  \n");
						  sql2.append("     AND A.GUBUN ='1'      -- 전자                                                                            \n");
						  sql2.append("     AND LENGTH(C.VEND_ID)=13  --주민번호등록분                                                     \n");
						  sql2.append("     GROUP BY A.TAXIODIV                                              \n");
						  sql2.append(")X                                                                                                \n");
						  sql2.append(" GROUP BY X.TAXIODIV                                                                               \n");
						  
						  //System.out.println("전자sql2::"+sql2.toString()); 
						  Statement stmt2 = conn.createStatement();
						  ResultSet rs2 = stmt2.executeQuery(sql2.toString());

						  //logger.dbg.println(this, sql2.toString());

						  while (rs2.next())
						  {
							  
							 //초기화 
							 FdblVendcnt = 0;
							 FdblShtcnt = 0;
							 FdblNumexp = 0;
							 FdblReqamt = 0;

							 FdblVendcnt1 = 0;
							 FdblShtcnt1 = 0;
							 FdblNumexp1 = 0;
							 FdblReqamt1 = 0;

							 FdblVendcnt2 = 0;
							 FdblShtcnt2 = 0;
							 FdblNumexp2 = 0;
							 FdblReqamt2 = 0;
							  
							FdblVendcnt1= rs2.getDouble(1);
							FdblShtcnt1 = rs2.getDouble(2);
							FdblNumexp1 = rs2.getDouble(3);
							FdblReqamt1 = rs2.getDouble(4);
							
							FdblVendcnt2= rs2.getDouble(5);
							FdblShtcnt2 = rs2.getDouble(6);
							FdblNumexp2 = rs2.getInt(7);
							FdblReqamt2 = rs2.getDouble(8);
							
							FdblVendcnt = rs2.getDouble(1) + rs2.getDouble(5);
							FdblShtcnt = rs2.getDouble(2) + rs2.getDouble(6);
							FdblNumexp = rs2.getDouble(3) + rs2.getDouble(7);
							FdblReqamt = rs2.getDouble(4) + rs2.getDouble(8);
							
							//2015.07.15.jys 수정
							if(FdblReqamt<0){
								FdblNumexp = 1; //음수
							}else{
								FdblNumexp = 0; //양수
							}
							
							//System.out.println("rs2.getDouble(3)::"+rs2.getDouble(3)+"rs2.getDouble(7)::"+rs2.getDouble(7)+"rs2.getInt(7)::"+rs2.getInt(7));
							
							//System.out.println("FdblNumexp::"+FdblNumexp+"FdblNumexp1::"+FdblNumexp1+"FdblNumexp2::"+FdblNumexp2);

							  //전자
							  UpdateSql2 = new StringBuffer();
							  UpdateSql2.append("  UPDATE  ACCOUNT.AVATRPT15 SET \n");
							
							  UpdateSql2.append("  VENDCNT = " + FdblVendcnt + ",\n");
							  UpdateSql2.append("  SHTCNT  = " + FdblShtcnt + ", \n");
							  UpdateSql2.append("  NUMEXP  = " + FdblNumexp + ", \n");
							  UpdateSql2.append("  REQAMT  = " + FdblReqamt + ", \n");
							
							  UpdateSql2.append("  VENDCNT1 = " + FdblVendcnt1 + ",\n");
							  UpdateSql2.append("  SHTCNT1  = " + FdblShtcnt1 + ", \n");
							  UpdateSql2.append("  NUMEXP1  = " + FdblNumexp1 + ", \n");
							  UpdateSql2.append("  REQAMT1  = " + FdblReqamt1 + ", \n");
							  UpdateSql2.append("  VENDCNT2 = " + FdblVendcnt2 + ",\n");
							  UpdateSql2.append("  SHTCNT2  = " + FdblShtcnt2 + ", \n");
							  UpdateSql2.append("  NUMEXP2  = " + FdblNumexp2 + ", \n");
							  UpdateSql2.append("  REQAMT2  = " + FdblReqamt2 + "  \n");
							  UpdateSql2.append("   WHERE FDCODE   = ? \n");
							  UpdateSql2.append("     AND ACCYY    = ? \n");
							  UpdateSql2.append("     AND ACCYYQT  = ? \n");
							  UpdateSql2.append("     AND RPTGB    = ? \n");
							  
							  if(rs2.getString(9).equals("B")){
								UpdateSql2.append( "     AND DATADIV  = '17' \n");	//매출
							  }else if(rs2.getString(9).equals("A")){
								UpdateSql2.append( "     AND DATADIV  = '18' \n");	//매입	
							  }
								
							  //System.out.println("UpdateSql2.toString()::"+UpdateSql2.toString());
							  
							  gsmt100 = conn.getGauceStatement(UpdateSql2.toString());
							
							  gsmt100.setGauceDataRow(rows[k]);
							
							  gsmt100.bindColumn(1, idx[0]);
							  gsmt100.bindColumn(2, idx[18]);
							  gsmt100.bindColumn(3, idx[19]);
							  gsmt100.bindColumn(4, idx[20]);
							
							  //logger.dbg.println(this, UpdateSql2.toString());
							
							  gsmt100.executeUpdate();
							  gsmt100.close();

						  }

						  stmt2.close();
						  rs2.close();
                        
						  
					}//if
   			}//for

				////////////////////////////////////////////////////////////////////////////////////////////////////////

			
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) try {conn.close(true);} catch (Exception e) {}
			loader.restoreService(service);
	 	}
	}
}