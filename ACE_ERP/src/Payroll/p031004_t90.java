package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t90 extends HttpServlet{

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
				 기부금 이월공제 프로세스
				 1.YCPRSNG 조회 ==> YCPRSNGC INSERT 
				 2.YCPAY10 조회 ==> CHKAMT01 
				 3.
				 4.
				*********************************************************************/
				/////////////////////////////////////////////////////////////////////////////////
				//기부금 이월공제 적용
				//1.기부금이 존재하는지 체크 
				//2.로직상 근로소득금액이 남아 있는지 체크
				//  2.1 안 남아 있으면 전액 이월
				//  2.2 기부금액 만큼 남아 있으면 이월 안함.
				//  2.3 기부금액보다 적으면.....공제한도 다시 체크해야하나?(????????????????????)
				/////////////////////////////////////////////////////////////////////////////////
        //logger.dbg.println(this,"90:::");

        int intLapamt=0;
				int intChkamt01 =0;  //한도체크에서 기부금 한도 체크 전까지 근로소득금액 공제 잔액
				int intCnt=0;
        int intACCAMT = 0;  //*전년누적공제금액*/
				int intDEDAMT = 0;	//*공제대상금액*/    
				int intGIVAMT = 0;	//*해당연도공제금액*/
				int intEXTAMT = 0;	//*소멸금액*/        
				int intCARAMT = 0;	//*이월금액*/        
				int intCONLMT4041=0; //지정기부금 ( 종교+종교외)
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
            //logger.dbg.println(this,"10:::");

						//기존 데이터 삭제 
						DeleteSql = new StringBuffer();
						DeleteSql.append( "	DELETE FROM PAYROLL.YCPRSNGC  \n  " );
						DeleteSql.append( "	 WHERE APPYY=?                \n  " );
						DeleteSql.append( "	   AND EMPNO=?                \n  " );

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.executeUpdate();
						gsmt.close();

						 
            //logger.dbg.println(this,"20:::");

            //기존 기부금 데이터 INSERT  --법정--특례--공익--종교외--종교
						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.YCPRSNGC   \n" );
						InsertSql.append( "SELECT SUBSTR(APPDT,1,4) AS APPYY, A.EMPNO, GIVCOD, SUBSTR(GIVDATE,1,4) AS GIVYY,	\n " );
						InsertSql.append( "       COALESCE(SUM(GIVAMT1),0)+COALESCE(SUM(GIVAMT2),0) AS TGIVAMT,             	\n " );
						InsertSql.append( "       0 ACCAMT, 0 DEDAMT, 0 GIVAMT, 0 EXTAMT, 0 CARAMT, 0 LMTAMT,                	\n " );
						InsertSql.append( "       '', CURRENT TIMESTAMP, '', CURRENT TIMESTAMP                              	\n " );
            InsertSql.append( "  FROM PAYROLL.YCPRSNG A                                                         	\n " );
						InsertSql.append( " WHERE A.APPDT='"+rows[j].getString(idxAPPYY)+"12'	                               	\n " );
						InsertSql.append( "   AND A.EMPNO=?                                                                 	\n " );
						InsertSql.append( "   AND A.GIVCOD IN ('10','30','31','40','41')                                    	\n " );
						InsertSql.append( " GROUP BY APPDT, A.EMPNO, GIVDATE, GIVCOD                                        	\n " );
						InsertSql.append( " ORDER BY EMPNO, GIVCOD                                                          	\n " );  
						

           // logger.dbg.println(this,"21:::"+InsertSql.toString());
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxEMPNO);

						gsmt.executeUpdate();
						gsmt.close();


						//YCPRSNGC  YCPAY10 조회 
						//B.LABPAY, B.CHKAMT01  는 첫 번째 레코드의 것만 변수에 넣는다. 

						//A.ACCAMT, -/*전년누적공제금액*/
						//A.DEDAMT, -/*공제대상금액*/
						//A.GIVAMT, -/*해당연도공제금액*/ 
						//A.EXTAMT, -/*소멸금액*/  
						//A.CARAMT, -/*이월금액*/ 


					  SelectSql = new StringBuffer();
						SelectSql.append( "  SELECT A.APPYY,  A.EMPNO,   A.GIVCOD,  A.GIVYY,   A.TGIVAMT,       \n" ); 
						SelectSql.append( "         A.ACCAMT, A.DEDAMT,  A.GIVAMT,  A.EXTAMT,  A.CARAMT,        \n" ); 
						SelectSql.append( "         B.LABPAY, B.CHKAMT01,                                       \n" ); 
						SelectSql.append( "          B.CONLMT10, B.CONLMT30, B.CONLMT31, B.CONLMT40, B.CONLMT41 \n" ); 
						SelectSql.append( "    FROM PAYROLL.YCPRSNGC A, PAYROLL.YCPAY10 B								        \n" ); 
						SelectSql.append( "   WHERE A.APPYY = B.APPYY																		        \n" ); 
						SelectSql.append( "     AND A.EMPNO = B.EMPNO																		        \n" ); 
						SelectSql.append( "     AND A.APPYY='"+rows[j].getString(idxAPPYY)+"'	  				        \n" ); 
						SelectSql.append( "     AND A.EMPNO='"+rows[j].getString(idxEMPNO)+"'						        \n" ); 
						logger.dbg.println(this,"SelectSql::"+SelectSql.toString());
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						 logger.dbg.println(this,"40:::");

           //초기화
					 intCONLMT4041 =0;
					 intLapamt=0;
					 intChkamt01=0;
					 intCnt=0;
					
						while(rs.next()){  
							intCnt+=1;
							if(intCnt==1){ // 최초의 건만
								intLapamt   = rs.getInt("LABPAY");
								intChkamt01 = rs.getInt("CHKAMT01");
							}

							if(intChkamt01==0){ //기부금 체크전에 한도가 0 이면 모든 기부금을 이월공제시킴
								intACCAMT = 0;                    //*전년누적공제금액*/
								intDEDAMT = rs.getInt("TGIVAMT");	//*공제대상금액*/    
								intGIVAMT = 0;	                  //*해당연도공제금액*/
								intEXTAMT = 0;	                  //*소멸금액*/        
								intCARAMT = rs.getInt("TGIVAMT");	//*이월금액*/ 						

							}else{ //건별 한도금액 계산하여 update
							  intACCAMT = 0;                                        //*전년누적공제금액*/
								intDEDAMT = rs.getInt("TGIVAMT")+rs.getInt("ACCAMT");	//*공제대상금액*/    
								intGIVAMT = 0;	                                      //*해당연도공제금액*/
								intEXTAMT = 0;	                                      //*소멸금액*/        
								intCARAMT = 0;	                                      //*이월금액*/   

								if(rs.getString("GIVCOD").equals("10")){ //법정기부금
									if(rs.getInt("TGIVAMT")>0){
										if(rs.getInt("CONLMT10")>=rs.getInt("TGIVAMT")){
											intGIVAMT=rs.getInt("TGIVAMT");  //*해당연도공제금액*/
                      intCARAMT=0;                     //*이월금액*/  
										}else{
											intGIVAMT=rs.getInt("CONLMT10");                      //*해당연도공제금액*/
                      intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT10"); //*이월금액*/  
										}	
									}								
								}else if(rs.getString("GIVCOD").equals("30")){
									if(rs.getInt("TGIVAMT")>0){
										if(rs.getInt("CONLMT30")>=rs.getInt("TGIVAMT")){
											intGIVAMT=rs.getInt("TGIVAMT");  //*해당연도공제금액*/
                      intCARAMT=0;                     //*이월금액*/  
										}else{
											intGIVAMT=rs.getInt("CONLMT30");                      //*해당연도공제금액*/
                      intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT30"); //*이월금액*/  
										}	
									}								
                }else if(rs.getString("GIVCOD").equals("31")){
									if(rs.getInt("TGIVAMT")>0){
										if(rs.getInt("CONLMT31")>=rs.getInt("TGIVAMT")){
											intGIVAMT=rs.getInt("TGIVAMT");  //*해당연도공제금액*/
                      intCARAMT=0;                     //*이월금액*/  
										}else{
											intGIVAMT=rs.getInt("CONLMT31");                      //*해당연도공제금액*/
                      intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT31"); //*이월금액*/  
										}	
									}								
                }else if(rs.getString("GIVCOD").equals("40")||rs.getString("GIVCOD").equals("41")){  // 
									if(rs.getInt("TGIVAMT")>0){
										intCONLMT4041+=rs.getInt("TGIVAMT");
										if(rs.getInt("CONLMT40")!=0){ //종교단체가 없는 경우 
											if(rs.getInt("CONLMT40")>=rs.getInt("TGIVAMT")){
												intGIVAMT=rs.getInt("TGIVAMT");  //*해당연도공제금액*/
												intCARAMT=0;                     //*이월금액*/  
											}else{
												intGIVAMT=rs.getInt("CONLMT40");                      //*해당연도공제금액*/
												intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT40"); //*이월금액*/  
											}	
                    }else{                       //종교단체가 있는 경우 
											if(rs.getString("GIVCOD").equals("41")){

												if(rs.getInt("CONLMT41")>=intCONLMT4041){
													intGIVAMT=intCONLMT4041;         //*해당연도공제금액*/
													intCARAMT=0;                     //*이월금액*/  
												}else{
													intGIVAMT=rs.getInt("CONLMT41");               //*해당연도공제금액*/
													intCARAMT=intCONLMT4041-rs.getInt("CONLMT41"); //*이월금액*/  
												}	
											}
										}
									}
								}
							}//if(intChkamt01==0){ //기부금 체크전에 한도가 0 이면 모든 기부금을 이월공제시킴

							logger.dbg.println(this,"50:::");

							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPRSNGC SET    \n");   
							UpdateSql.append( "    ACCAMT='"+intACCAMT+"'     \n");
							UpdateSql.append( "   ,DEDAMT='"+intDEDAMT+"'     \n"); 
							UpdateSql.append( "   ,GIVAMT='"+intGIVAMT+"'     \n"); 
							UpdateSql.append( "   ,EXTAMT='"+intEXTAMT+"'     \n"); 
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