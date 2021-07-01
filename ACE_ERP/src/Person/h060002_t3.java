package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060002_t3 extends HttpServlet{

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

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
        
				int idxEVAYM  = userSet.indexOfColumn("EVAYM");
				int idxWRDT  = userSet.indexOfColumn("WRDT");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
        StringBuffer DeleteSql = null;
				GauceStatement gsmt =null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.HVEMP_DPT" );
						DeleteSql.append( "  WHERE EVAYM ='"+rows[j].getString(idxEVAYM)+"'" );

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.executeUpdate();
						gsmt.close();

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.HVEMP_DPT ( EVAYM, EMPNO, DEPTCD, PAYGRD, WRDT, RECDIV, JOBKIND,DEPREF, GRSREF, JOBREF)       " );
						InsertSql.append( " SELECT '"+rows[j].getString(idxEVAYM)+"' ,  A.EMPNO,  Y.DEPTCD,   A.PAYGRD, '"+rows[j].getString(idxWRDT)+"', " );
						InsertSql.append( "        A.RECDIV, A.JOBKIND,  CASE WHEN B.DEPTGB ='1' THEN '1' ELSE '2' END DEPREF,                        " );
						InsertSql.append( "        '1' GRSREF, A.JOBKIND JOBREF                                                                       " );
						InsertSql.append( "  FROM PAYROLL.HIPERSON A                                                                                  " );
						InsertSql.append( "  LEFT JOIN ( SELECT X.EMPNO,                                                                              " );
						InsertSql.append( "                     CASE WHEN X.DEPTCD = 'U110' THEN 'J430'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'Q000' THEN 'C000'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'K110' THEN 'D110'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'K100' THEN 'D100'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'GC20' THEN 'I320'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'GC10' THEN 'I310'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'GC00' THEN 'I300'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'G580' THEN 'I230'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'G470' THEN 'I150'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'G460' THEN 'I140'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'E070' THEN 'F210'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'D560' THEN 'E160'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'D510' THEN 'E110'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'G810' THEN 'F330'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'G820' THEN 'F310'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'G830' THEN 'F320'                                               " );
						InsertSql.append( "                          WHEN X.DEPTCD = 'C250' THEN 'C130'                                               " );
						InsertSql.append( "                          ELSE X.DEPTCD END DEPTCD                                                         " );
						InsertSql.append( "                FROM PAYROLL.HOORDER X, PAYROLL.HIPERSON BB                                                " );
						InsertSql.append( "               WHERE X.EMPNO = BB.EMPNO                                                                    " );
						InsertSql.append( "                 AND X.ORDCD <> 'D7'                                                                       " );
						InsertSql.append( "                 AND X.ORDDT = (SELECT MAX(K.ORDDT)                                                        " );
						InsertSql.append( "                                  FROM PAYROLL.HOORDER K                                                   " );
						InsertSql.append( "                                 WHERE K.EMPNO = X.EMPNO                                                   " );
						InsertSql.append( "                                   AND K.ORDCD <>'D7'                                                      " );
						InsertSql.append( "                                   AND K.ORDCD <>'D1'                                                      " );
						InsertSql.append( "                                )                                                                          " );
						InsertSql.append( "                 AND X.SEQ = (SELECT MAX(K1.SEQ)                                                           " );
						InsertSql.append( "                                FROM PAYROLL.HOORDER K1                                                    " );
						InsertSql.append( "                               WHERE K1.EMPNO = X.EMPNO                                                    " );
						InsertSql.append( "                                 AND K1.ORDDT = (SELECT MAX(K2.ORDDT)                                      " );
						InsertSql.append( "                                                   FROM PAYROLL.HOORDER K2                                 " );
						InsertSql.append( "                                                  WHERE K2.EMPNO = X.EMPNO                                 " );
						InsertSql.append( "                                                    AND K2.ORDCD <>'D7'                                    " );
						InsertSql.append( "                                                    AND K2.ORDCD <>'D1'                                    " );
						InsertSql.append( "                                                 )                                                         " );
						InsertSql.append( "                                 AND K1.ORDCD <>'D7'                                                       " );
						InsertSql.append( "                                 AND K1.ORDCD <>'D1'                                                       " );
						InsertSql.append( "                               )                                                                           " );  
						InsertSql.append( "                 AND X.ORDCD <>'D1'                                                                        " );
						InsertSql.append( "           ) Y ON A.EMPNO = Y.EMPNO                                                                        " );
						InsertSql.append( "  LEFT JOIN PAYROLL.HCDEPT B ON Y.DEPTCD = B.DEPTCD AND B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT ) " );
						InsertSql.append( " WHERE A.USESTS='1'                                                                                        " );
						InsertSql.append( "   AND (A.JOBDTY IN ('05','17','29','34') OR (A.JOBDTY ='20' AND A.PAYGRD IN ('140','150','160','170')))   " );

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}