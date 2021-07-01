package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a050010_t1 extends HttpServlet{
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

				GauceStatement gsmt= null;
				GauceStatement gsmt2= null;
				GauceStatement gsmt3= null;

				String strfrdt = reqGauce.getParameter("v_str1");
				String strtodt = reqGauce.getParameter("v_str2");

				//HEAD//////////////////////////////////////////////////////////////////////////////
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				String[] StrArrCN = new String[] {
					"FDCODE",  "RCDGB",   "ACCYY",      "ACCHF",  "HALFNO",
					"VENDID",  "VENDNM",  "VDDIRECT",   "VENDNO", "SENDDT",
					"FILLER"
				};			
				
				int[] idx = new int[11];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
       
				StringBuffer InsertSql  = null;
				StringBuffer InsertSql2 = null;
				StringBuffer InsertSql3 = null;

				StringBuffer DeleteSql  = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;
	
				for (int k = 0; k < rows.length; k++){
					if(rows[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            
						//삭제
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.AVATRPT81	");
						DeleteSql.append( "  WHERE FDCODE=?	");
						DeleteSql.append( "    AND ACCYY=? 	");
						DeleteSql.append( "    AND ACCHF=?	");
						DeleteSql.append( "    AND HALFNO=?	");
			
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[k]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[2]);
						gsmt.bindColumn(3, idx[3]);
						gsmt.bindColumn(4, idx[4]);

						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;

						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.AVATRPT82	");
						DeleteSql2.append( "  WHERE FDCODE=?	");
						DeleteSql2.append( "    AND ACCYY=? 	");
						DeleteSql2.append( "    AND ACCHF=?	  ");
						DeleteSql2.append( "    AND HALFNO=?	");
						
						gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[k]);
						gsmt2.bindColumn(1, idx[0]);
						gsmt2.bindColumn(2, idx[2]);
						gsmt2.bindColumn(3, idx[3]);
						gsmt2.bindColumn(4, idx[4]);
						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt2=null;

						DeleteSql3 = new StringBuffer();
						DeleteSql3.append( " DELETE FROM ACCOUNT.AVATRPT83	");
						DeleteSql3.append( "  WHERE FDCODE=?	");
						DeleteSql3.append( "    AND ACCYY=? 	");
						DeleteSql3.append( "    AND ACCHF=?	  ");
						DeleteSql3.append( "    AND HALFNO=?	");
						
						gsmt3 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt3.setGauceDataRow(rows[k]);
						gsmt3.bindColumn(1, idx[0]);
						gsmt3.bindColumn(2, idx[2]);
						gsmt3.bindColumn(3, idx[3]);
						gsmt3.bindColumn(4, idx[4]);
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3=null;

           
						//INSERT HEADER
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.AVATRPT81 (			    	\n");
						InsertSql.append( " FDCODE, RCDGB,  ACCYY,    ACCHF,  HALFNO,	\n");
						InsertSql.append( " VENDID, VENDNM, VDDIRECT, VENDNO, SENDDT,	\n");
						InsertSql.append( " FILLER																    \n");
						InsertSql.append( " ) VALUES(													      	\n");						
						InsertSql.append( " ?,?,?,?,?,  \n");
						InsertSql.append( " ?,?,?,?,?,  \n");
						InsertSql.append( " ?           \n");
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
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;
           
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.AVATRPT82	\n");
						InsertSql2.append( " SELECT X.REFNO, X.FDCODE, X.RCDGB, X.ACCYY, X.ACCHF, X.HALFNO, X.VENDID,                            	\n");
						InsertSql2.append( "        X.CARDGB, X.TAXCDNBR, X.AFVENDID,                                                            	\n");
						InsertSql2.append( "        COUNT(*) V_CNT,                                                                               \n");
						InsertSql2.append( "        CASE WHEN SUM(X.TAXSUM)>=0 THEN '' ELSE '-' END NUMEXP1,                                     	\n");						
						InsertSql2.append( "        ABS(SUM(X.TAXSUM)) REQAMT,                                                                         \n");
						InsertSql2.append( "        CASE WHEN SUM(X.TAXVATAMT)>=0 THEN '' ELSE '-' END NUMEXP2,                                   \n");
						InsertSql2.append( "        ABS(SUM(X.TAXVATAMT))TAXAMT,                                                                       \n");
						InsertSql2.append( "        '' FILLER                                                                                     \n");
						InsertSql2.append( "  FROM (                                                                                             	\n");
						InsertSql2.append( "  SELECT A.COCODE||SUBSTR(TAXDAT,1,4)||                                                              	\n");
						InsertSql2.append( "         CASE WHEN SUBSTR(TAXDAT,5,2)>='01' AND SUBSTR(TAXDAT,5,2)<='06' THEN '1'                    	\n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='07' AND SUBSTR(TAXDAT,5,2)<='12' THEN '2'                     \n");
						InsertSql2.append( "              END||                                                                                  	\n");						
						InsertSql2.append( "         CASE WHEN SUBSTR(TAXDAT,5,2)>='01' AND SUBSTR(TAXDAT,5,2)<='03' THEN '3'                     \n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='04' AND SUBSTR(TAXDAT,5,2)<='06' THEN '6'                     \n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='07' AND SUBSTR(TAXDAT,5,2)<='09' THEN '3'                     \n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='10' AND SUBSTR(TAXDAT,5,2)<='12' THEN '6'                     \n");
						InsertSql2.append( "              END||                                                                                  	\n");
						//InsertSql2.append( "         nvl(A.TAXCDNBR,'0000000000000000')||C.VEND_ID AS REFNO,                                  	\n");
						//InsertSql2.append( "          nvl(A.TAXCDNBR,'0000000000000000')||                                	  \n"); //2021.04.22 막음
						InsertSql2.append( "         CASE WHEN A.TAXKND='8' THEN '1111111111111111' 	  \n");
						InsertSql2.append( "        	  WHEN A.TAXKND='7' THEN '0000000000000000' END|| \n");
						
													
						//InsertSql2.append( "         CASE WHEN A.TAXKND='7' THEN '0000000000' ELSE C.VEND_ID END AS REFNO,      \n");//2021.04.22 막음
						InsertSql2.append( "         CASE WHEN A.TAXKND='7' THEN '0000000000' ELSE '1111111111'  END AS REFNO,    \n");
						
						
						InsertSql2.append( "         A.COCODE FDCODE, 'DL' RCDGB, SUBSTR(TAXDAT,1,4) ACCYY,                                      	\n");
						InsertSql2.append( "         CASE WHEN SUBSTR(TAXDAT,5,2)>='01' AND SUBSTR(TAXDAT,5,2)<='06' THEN '1'                     \n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='07' AND SUBSTR(TAXDAT,5,2)<='12' THEN '2'                    	\n");						
						InsertSql2.append( "              END ACCHF,                                                                              \n");
						InsertSql2.append( "         CASE WHEN SUBSTR(TAXDAT,5,2)>='01' AND SUBSTR(TAXDAT,5,2)<='03' THEN '3'                     \n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='04' AND SUBSTR(TAXDAT,5,2)<='06' THEN '6'                     \n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='07' AND SUBSTR(TAXDAT,5,2)<='09' THEN '3'                     \n");
						InsertSql2.append( "              WHEN SUBSTR(TAXDAT,5,2)>='10' AND SUBSTR(TAXDAT,5,2)<='12' THEN '6'                    	\n");
						InsertSql2.append( "              END HALFNO,                                                                            	\n");
						InsertSql2.append( "         '2218113834' VENDID,                                                                        	\n");
						InsertSql2.append( "         CASE WHEN A.TAXKND='8' THEN '4'    --  기타신용카드(1) 에서 사업용신용카드(4) 변경 2021.04.22  \n");//2021.04.22 막음
						InsertSql2.append( "              WHEN A.TAXKND='7' THEN '2' END CARDGB,                                                 	\n");						
						//InsertSql2.append( "         nvl(A.TAXCDNBR,'0000000000000000')TAXCDNBR,       \n");
						InsertSql2.append( "         CASE WHEN A.TAXKND='8' THEN '1111111111111111'   \n");
						InsertSql2.append( "               WHEN A.TAXKND='7' THEN '0000000000000000' END TAXCDNBR, \n");
						
						//InsertSql2.append( "         C.VEND_ID AS AFVENDID, A.TAXSUM, A.TAXVATAMT                                                 \n");
						//InsertSql2.append( "        CASE WHEN A.TAXKND='7' THEN '0000000000' ELSE C.VEND_ID END AS AFVENDID,   \n");//2021.04.22 막음
						InsertSql2.append( "        CASE WHEN A.TAXKND='7' THEN '0000000000' ELSE '1111111111' END AS AFVENDID,	\n");
						InsertSql2.append( "        A.TAXSUM, A.TAXVATAMT                                                 \n");
						
						InsertSql2.append( "    FROM ACCOUNT.ATTAXMST A                                                                           \n");
						InsertSql2.append( "    LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR= B.FSNBR    \n");
						InsertSql2.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD = C.VEND_CD                                         	\n");
						InsertSql2.append( "   WHERE A.TAXDAT BETWEEN '"+strfrdt+"' AND '"+strtodt+"'                                            	\n");
						InsertSql2.append( "     AND A.TAXIODIV ='A'                                                                              \n");
						InsertSql2.append( "     AND A.TAXKND IN ('7','8')                                                                       	\n");						
						InsertSql2.append( "     AND B.FSSTAT ='Y'                                                                                \n");
						InsertSql2.append( "     AND A.COCODE =?                                                                                  \n");
						InsertSql2.append( "  )X                                                                                                  \n");
						InsertSql2.append( " GROUP BY X.REFNO, X.FDCODE, X.RCDGB, X.ACCYY, X.ACCHF, X.HALFNO, X.VENDID,                           \n");
						InsertSql2.append( "          X.CARDGB, X.TAXCDNBR, X.AFVENDID                                                           	\n");
						InsertSql2.append( " ORDER BY X.REFNO                                                                                    	\n");

						//System.out.println("a050010_t1::"+InsertSql2.toString());
						
						gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows[k]);
            
						gsmt2.bindColumn(1, idx[0] );   
						
						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt2=null;

						InsertSql3 = new StringBuffer();
						InsertSql3.append( " INSERT INTO ACCOUNT.AVATRPT83                                 	\n");
						InsertSql3.append( " SELECT FDCODE, 'TL', ACCYY, ACCHF, HALFNO, VENDID,            	\n");
						InsertSql3.append( "        COUNT(*) DCNT, SUM(VCNT)TVCNT,                         	\n");
						InsertSql3.append( "        CASE WHEN SUM(REQAMT)>=0 THEN '' ELSE '-' END NUMEXP1, 	\n");
						InsertSql3.append( "        ABS(SUM(REQAMT))TREQAMT,                               	\n");
						InsertSql3.append( "        CASE WHEN SUM(TAXAMT)>=0 THEN '' ELSE '-' END NUMEXP2, 	\n");
						InsertSql3.append( "        ABS(SUM(TAXAMT))TTAXAMT,                               	\n");
						InsertSql3.append( "        ''FILLER                                               	\n");
						InsertSql3.append( "   FROM ACCOUNT.AVATRPT82                                      	\n");
						InsertSql3.append( "  WHERE FDCODE =?                                             	\n");
						InsertSql3.append( "    AND ACCYY=?                                               	\n");
						InsertSql3.append( "    AND ACCHF=?                                             	  \n");
						InsertSql3.append( "    AND HALFNO=?                                             	  \n");
						InsertSql3.append( "  GROUP BY FDCODE, RCDGB, ACCYY, ACCHF, HALFNO, VENDID         	\n");
            
						gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows[k]);
            
						gsmt3.bindColumn(1, idx[0]);
						gsmt3.bindColumn(2, idx[2]);
						gsmt3.bindColumn(3, idx[3]);
						gsmt3.bindColumn(4, idx[4]);
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3=null;

					  //logger.dbg.println(this,"step6::");

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