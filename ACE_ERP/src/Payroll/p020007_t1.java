package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p020007_t1 extends HttpServlet{

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

			GauceStatement gsmt=null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1"); //지급년월
			
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");		

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer SelectSql = null;
				StringBuffer UpdateSql = null;
				Statement stmt = null;


 				for (int j = 0; j < 1; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT A.EMPNO,                                                                                               \n " );
						SelectSql.append( "        CASE WHEN A.EMPNO ='1990016' THEN  '30'                                                                \n " );
						SelectSql.append( "             WHEN A.EMPNO ='2000001' THEN  '31'                                                                \n " );
						SelectSql.append( "             ELSE B.GROUPID END GROUPID,                                                                       \n " );
						SelectSql.append( "        TRIM(D.MINORNM)MINORNM, D.SEQ, D.MINORCD                                                               \n " );
						SelectSql.append( "   FROM PAYROLL.PBPAY A                                                                                        \n " );
						SelectSql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                                                           \n " );
						SelectSql.append( "                             AND B.CHGYM = ( SELECT MAX(C.CHGYM) FROM PAYROLL.HCDEPT C WHERE C.CHGYM<='"+str1+"')\n " );
						SelectSql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON D.MINORCD=(CASE WHEN A.EMPNO ='1990016' THEN  '30'                           \n " );
						SelectSql.append( "                                                  WHEN A.EMPNO ='2000001' THEN  '31'                           \n " );
						SelectSql.append( "                                                  ELSE B.GROUPID END)  AND D.MAJORCD='2051'                    \n " );
						SelectSql.append( "  WHERE A.APPDT ='"+str1+"'                                                                                    \n " );
						SelectSql.append( "    AND A.PAYDIV IN ('1','4','T')                                                                              \n " );
						//SelectSql.append( "    AND A.PAYDIV IN ('5')                                                                              \n " );
						//SelectSql.append( "    AND (A.JTGB<>1 AND A.JTGB<>2 AND A.JTGB<>3 AND A.JTGB<>4 AND A.JTGB<>5 AND A.JTGB<>6)                      \n " );
					  SelectSql.append( "    AND (A.JTGB2<>1 AND A.JTGB2<>2 AND A.JTGB2<>3 AND A.JTGB2<>4 AND A.JTGB2<>5 )                      \n " );

						SelectSql.append( "  UNION ALL                                                                                                    \n " );
						SelectSql.append( " SELECT A.EMPNO, B.GROUPID,                                                                                    \n " );
						SelectSql.append( "        CASE WHEN A.JTGB2 = 1 THEN '재택_경영지원본부'                                                                            \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 2 THEN '재택_관광사업부'                                                            \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 3 THEN '재택_경협사업부'                                                            \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 4 THEN '재택_건설사업본부'                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 5 THEN '재택_해외사업부' END AS MINORNM,                                            \n " );
						SelectSql.append( "        CASE WHEN A.JTGB2 = 1 THEN 995                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 2 THEN 996                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 3 THEN 997                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 4 THEN 998                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 5 THEN 999 END AS SEQ,                                                              \n " );
						SelectSql.append( "        CASE WHEN A.JTGB2 = 1 THEN 'Z5'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 2 THEN 'Z6'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 3 THEN 'Z7'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 4 THEN 'Z8'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB2 = 5 THEN 'Z9'END AS MINORCD                                                           \n " );
						
            /**
            SelectSql.append( "        CASE WHEN A.JTGB = 1 THEN                                                                              \n " );
						SelectSql.append( "             WHEN A.JTGB = 2 THEN '재택_경영부분'                                                              \n " );
						SelectSql.append( "             WHEN A.JTGB = 3 THEN '재택_관광부분'                                                              \n " );
						SelectSql.append( "             WHEN A.JTGB = 4 THEN '재택_경협부분'                                                              \n " );
						SelectSql.append( "             WHEN A.JTGB = 5 THEN '재택_경협부분'                                                              \n " );
						SelectSql.append( "             WHEN A.JTGB = 6 THEN '재택_건설부분' END AS MINORNM,                                              \n " );
						SelectSql.append( "        CASE WHEN A.JTGB = 2 THEN 995                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 3 THEN 996                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 4 THEN 997                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 5 THEN 997                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 6 THEN 999 END AS SEQ,                                                              \n " );
						SelectSql.append( "        CASE WHEN A.JTGB = 2 THEN 'Z5'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 3 THEN 'Z6'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 4 THEN 'Z7'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 5 THEN 'Z7'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 6 THEN 'Z9'END AS MINORCD                                                           \n " );
            **/

						/*				
						SelectSql.append( "        CASE WHEN A.JTGB = 2 THEN '금강산_재택근무'                                                            \n " );
						SelectSql.append( "             WHEN A.JTGB = 3 THEN '고성_재택근무'                                                              \n " );
						SelectSql.append( "             WHEN A.JTGB = 4 THEN '개성_재택근무'                                                              \n " );
						SelectSql.append( "             WHEN A.JTGB = 5 THEN '도라산_재택근무'                                                            \n " );
						SelectSql.append( "             WHEN A.JTGB = 6 THEN '현장_재택근무' END AS MINORNM,                                              \n " );
						SelectSql.append( "        CASE WHEN A.JTGB = 2 THEN 995                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 3 THEN 996                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 4 THEN 997                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 5 THEN 998                                                                          \n " );
						SelectSql.append( "             WHEN A.JTGB = 6 THEN 999 END AS SEQ,                                                              \n " );
						SelectSql.append( "        CASE WHEN A.JTGB = 2 THEN 'Z5'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 3 THEN 'Z6'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 4 THEN 'Z7'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 5 THEN 'Z8'                                                                         \n " );
						SelectSql.append( "             WHEN A.JTGB = 6 THEN 'Z9'END AS MINORCD                                                           \n " );
						**/
						SelectSql.append( "   FROM PAYROLL.PBPAY A                                                                                        \n " );
						SelectSql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                                                           \n " );
						SelectSql.append( "                             AND B.CHGYM = ( SELECT MAX(C.CHGYM) FROM PAYROLL.HCDEPT C WHERE C.CHGYM<='"+str1+"')\n " );
						SelectSql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON D.MINORCD=B.GROUPID  AND D.MAJORCD='2051'                                    \n " );
						SelectSql.append( "  WHERE A.APPDT ='"+str1+"'                                                                                    \n " );
						SelectSql.append( "    AND A.PAYDIV IN ('1','4','T')                                                                              \n " );
						//SelectSql.append( "    AND A.PAYDIV IN ('5')                                                                                \n " );
						SelectSql.append( "    AND A.JTGB2 IN ('1','2','3','4','5')                                                                     \n " );
						SelectSql.append( "  ORDER BY SEQ, MINORCD, MINORNM                                                                               \n " );

						//logger.dbg.println(this,SelectSql.toString());

            stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(SelectSql.toString()); 
						while(rs.next()){
					
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE PAYROLL.PBPAY SET  \n " );
							UpdateSql.append( "        PRTSEQ =  "+rs.getInt(4)+", \n " );
							UpdateSql.append( "        PRTCOD = '"+rs.getString(5)+"',\n " );
							UpdateSql.append( "        PRTDEPTNM ='"+rs.getString(3)+"' \n " );   
							UpdateSql.append( "  WHERE APPDT = '"+str1+"' \n " );
              //UpdateSql.append( "  WHERE APPDT LIKE '2010%' \n " );
							UpdateSql.append( "    AND  EMPNO = '"+rs.getString(1)+"' \n " );
							//UpdateSql.append( "    AND A.PAYDIV IN ('1','4','T')      \n " );
							//UpdateSql.append( "    AND  PAYDIV = '5' \n " );
													 
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();
						}
						rs.close();
					}
				}				
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
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}