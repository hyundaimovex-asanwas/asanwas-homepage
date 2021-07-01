package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t91 extends HttpServlet{

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

				/*********************************************************************
				 기부금 이월공제 한도 체크 
				 -- 기부금 이월공제 전 근로소득금액 잔액이 기부금보다 적은 경우 
				*********************************************************************/

				int intChkamt01 =0;  //한도체크에서 기부금 한도 체크 전까지 근로소득금액 공제 잔액
				int intCnt=0;
				int intGIVAMT = 0;	//*해당연도공제금액*/
				int intCARAMT = 0;	//*이월금액*/        
				int intTGIVAMT =0;  //기부금액

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //귀속년도       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //귀속년도       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;
	       
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
        		
						//A.ACCAMT, -/*전년누적공제금액*/
						//A.DEDAMT, -/*공제대상금액*/
						//A.GIVAMT, -/*해당연도공제금액*/ 
						//A.EXTAMT, -/*소멸금액*/  
						//A.CARAMT, -/*이월금액*/ 

					  SelectSql = new StringBuffer();
						SelectSql.append( "  SELECT A.APPYY,  A.EMPNO,   A.GIVCOD,  A.GIVYY,   A.TGIVAMT,            \n" ); 
						SelectSql.append( "         A.ACCAMT, A.DEDAMT,  A.GIVAMT,  A.EXTAMT,  A.CARAMT,             \n" ); 
						SelectSql.append( "         B.LABPAY, B.CHKAMT01,                                            \n" ); 
						SelectSql.append( "          B.CONLMT10, B.CONLMT30, B.CONLMT31, B.CONLMT40, B.CONLMT41      \n" ); 
						SelectSql.append( "    FROM PAYROLL.YCPRSNGC A, PAYROLL.YCPAY10 B								             \n" ); 
						SelectSql.append( "   WHERE A.APPYY = B.APPYY																		             \n" ); 
						SelectSql.append( "     AND A.EMPNO = B.EMPNO																		             \n" ); 
						SelectSql.append( "     AND A.APPYY='"+rows[j].getString(idxAPPYY)+"'	  				             \n" ); 
						SelectSql.append( "     AND A.EMPNO='"+rows[j].getString(idxEMPNO)+"'	  				             \n" ); 
						SelectSql.append( "     AND A.EMPNO IN ( 	SELECT  X.EMPNO                                    \n" ); 
						SelectSql.append( "                       	FROM ( SELECT APPYY, EMPNO, SUM(TGIVAMT)TGIVAMT  \n" ); 
						SelectSql.append( "                       					 FROM PAYROLL.YCPRSNGC                   \n" ); 
						SelectSql.append( "                       					WHERE APPYY='"+rows[j].getString(idxAPPYY)+"' \n" ); 
						SelectSql.append( "                       					GROUP BY APPYY,EMPNO                     \n" ); 
						SelectSql.append( "                       			 )X, PAYROLL.YCPAY10 B                       \n" ); 
						SelectSql.append( "                       WHERE X.APPYY =B.APPYY                             \n" ); 
						SelectSql.append( "                       	AND X.EMPNO =B.EMPNO                             \n" ); 
						SelectSql.append( "                       	AND X.APPYY='"+rows[j].getString(idxAPPYY)+"'    \n" ); 
						SelectSql.append( "                       	AND X.TGIVAMT > B.CHKAMT01                       \n" ); 
						SelectSql.append( "                       	AND B.CHKAMT01<>0                                \n" ); 
						SelectSql.append( "                       )                                                  \n" );						
						
						logger.dbg.println(this,"SelectSql::"+SelectSql.toString());
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

					 logger.dbg.println(this,"40:::");

           //초기화
					 intChkamt01=0;
					 intCnt=0;
				
						while(rs.next()){  
							logger.dbg.println(this,"41:::");
							intGIVAMT =rs.getInt("GIVAMT");
							intCARAMT =rs.getInt("CARAMT");
							intCnt+=1;
							if(intCnt==1){ // 최초의 건만
								intChkamt01 = rs.getInt("CHKAMT01");
							}

							if(intChkamt01>0 ){ //기부금 체크전에 한도가 
								if(rs.getInt("TGIVAMT")>intChkamt01){  // 기부금>기부금 체크전 근로소득금액 잔액 보다 큰 경우
									if(rs.getInt("GIVAMT")>intChkamt01){ // 공제금액> 기부금 체크전 근로소득금액 잔액 보다 큰 경우
										intGIVAMT = intChkamt01;
										intCARAMT = rs.getInt("DEDAMT") - intGIVAMT;   //이월금액=공제대상금액 - 이월금액
										logger.dbg.println(this,"42:::");
									}
								}else{
									intChkamt01-=rs.getInt("GIVAMT"); //
								}
							}//if(intChkamt01>0){ //기부금 체크전에 한도가 0 이면 모든 기부금을 이월공제시킴

							logger.dbg.println(this,"50:::");

							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPRSNGC SET    \n");   
							UpdateSql.append( "    GIVAMT='"+intGIVAMT+"'     \n"); 
							UpdateSql.append( "   ,CARAMT='"+intCARAMT+"'     \n"); 
							UpdateSql.append( "   WHERE APPYY = '"+rows[j].getString(idxAPPYY)+"' " );
							UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
							UpdateSql.append( "     AND GIVCOD= '"+rs.getString("GIVCOD")+"'  " );
							UpdateSql.append( "     AND GIVYY = '"+rs.getString("GIVYY")+"'  " );
							logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();

							logger.dbg.println(this,"60:::");

           }//while(rs.next()){  
					 stmt.close();
					 rs.close();
				 } //getJobType
			}  //for j     			
		} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
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