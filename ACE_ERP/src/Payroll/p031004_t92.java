package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t92 extends HttpServlet{

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
				 연금 저축 소득공제  
				 -- 처음엔 건별 소득공제 해서 UPDATE 함
				 -- 마지막에 한도 체크함.

				 퇴직연금+연금저축 (한도300만원)
				 개인연금저축 (불입액 40% & 72만원)
				 연금저축( 퇴직연금과 합하여 한도 300만원)
				 주택마련저축      (불입액 40% )
				 장기주식형저축 (불입액한도 연간 1200만원 ) 
				 1년차 : 불입액의 20%
				 2년차 : 불입액의 10%
				 3년차 : 불입액의  5%
				 
				*********************************************************************/
        
				long lngPAYAMT=0;    //
				long lngCHKAMT=0;
				long lngDEDAMT=0;

				long lngPENAMT03=0;  //퇴직연금
				long lngPESAMT01=0;  //개인연금저축
        long lngPESAMT02=0;  //연금저축
				long lngSAVAMT01=0;  //청약저축
				long lngSAVAMT02=0;  //근로자주택마련저축
				long lngSAVAMT03=0;  //주택청약종합저축
				long lngSAVAMT04=0;  //장기주택마련저축
        long lngFNDSUM=0;    //장기주식형저축 

				String strDUDGB="";

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

						strDUDGB="";

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT A.APPYY,   A.EMPNO, A.SEQ,     A.DUDGB,   A.FINACD,        \n" ); 
						SelectSql.append( "        A.FINANM,  A.ACCNO, A.YEARLY,  A.PAYAMT,  A.DEDAMT,        \n" ); 
						SelectSql.append( "        A.STATDT,                                                  \n" ); 
						SelectSql.append( "        CASE WHEN A.DUDGB='11' THEN A.PAYAMT                       \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='21' THEN INTEGER(A.PAYAMT*0.4)          \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='22' THEN A.PAYAMT                       \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='31' THEN INTEGER(A.PAYAMT*0.4)          \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='32' THEN INTEGER(A.PAYAMT*0.4)          \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='33' THEN INTEGER(A.PAYAMT*0.4)          \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='34' THEN INTEGER(A.PAYAMT*0.4)          \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='41' AND YEARLY=1 THEN INTEGER(A.PAYAMT*0.2)  \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='41' AND YEARLY=2 THEN INTEGER(A.PAYAMT*0.1)  \n" ); 
						SelectSql.append( "             WHEN A.DUDGB='41' AND YEARLY=3 THEN INTEGER(A.PAYAMT*0.05) \n" ); 
						SelectSql.append( "             ELSE 0 END CHKAMT,                                    \n" ); 
						SelectSql.append( "        B.PENAMT03, B.PESAMT01, B.PESAMT02,                        \n" ); 
						SelectSql.append( "        B.SAVAMT01, B.SAVAMT02, B.SAVAMT03, B.SAVAMT04, B.FNDSUM   \n" ); 
						SelectSql.append( "   FROM PAYROLL.YCPRSNPS A, PAYROLL.YCPAY10 B                      \n" ); 
						SelectSql.append( "  WHERE A.APPYY ='"+rows[j].getString(idxAPPYY)+"'                 \n" ); 
						SelectSql.append( "    AND A.EMPNO ='"+rows[j].getString(idxEMPNO)+"'                 \n" ); 
						SelectSql.append( "    AND A.APPYY = B.APPYY                                          \n" ); 
						SelectSql.append( "    AND A.EMPNO = B.EMPNO                                          \n" ); 
						SelectSql.append( "  ORDER BY A.EMPNO, A.DUDGB, A.SEQ;                                \n" ); 
						
						//logger.dbg.println(this,"SelectSql::"+SelectSql.toString());
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						//logger.dbg.println(this,"40:::");

						//초기화

						while(rs.next()){  

							//logger.dbg.println(this,"DUDGB:::"+rs.getString("DUDGB")+"::");
							//logger.dbg.println(this,"strDUDGB:::"+strDUDGB+"::");

							if(!rs.getString("DUDGB").equals(strDUDGB)){ // 코드별 최초 또는 동일건이 없는 경우 
								strDUDGB = rs.getString("DUDGB");     

								//logger.dbg.println(this,"zzz");
							                                      
								lngPAYAMT   = rs.getLong("PAYAMT");   
								lngCHKAMT   = rs.getLong("CHKAMT");   
								lngPENAMT03 = rs.getLong("PENAMT03"); 
								lngPESAMT01 = rs.getLong("PESAMT01"); 
								lngPESAMT02 = rs.getLong("PESAMT02"); 
								lngSAVAMT01 = rs.getLong("SAVAMT01"); 
								lngSAVAMT02 = rs.getLong("SAVAMT02"); 
								lngSAVAMT03 = rs.getLong("SAVAMT03"); 
								lngSAVAMT04 = rs.getLong("SAVAMT04"); 
								lngFNDSUM   = rs.getLong("FNDSUM");   
								                                     
								                                      
								if(strDUDGB.equals("11")){        //퇴직연금
								  if(lngPENAMT03!=0){
										if(lngCHKAMT <= lngPENAMT03){       
											lngDEDAMT = lngCHKAMT;            
											lngPENAMT03 -=lngCHKAMT;          
										}else{                              
											lngDEDAMT = lngPENAMT03;          
											lngPENAMT03=0;                    
										}
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("21")){  //개인연금저축  
									if(lngPESAMT01!=0){
										if(lngCHKAMT <= lngPESAMT01){       
											lngDEDAMT = lngCHKAMT;            
											lngPESAMT01 -=lngCHKAMT;          
										}else{                              
											lngDEDAMT = lngPESAMT01;          
											lngPESAMT01=0;                    
										}				
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("22")){  //연금저축      
								  if(lngPESAMT02!=0){
										if(lngCHKAMT <= lngPESAMT02){       
											lngDEDAMT = lngCHKAMT;            
											lngPESAMT02 -=lngCHKAMT ;         
										}else{                              
											lngDEDAMT = lngPESAMT02;          
											lngPESAMT02=0;                    
										}      
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("31")){  //청약저축 
								  if(lngSAVAMT01!=0){
										if(lngCHKAMT <= lngSAVAMT01){       
											lngDEDAMT = lngCHKAMT;            
											lngSAVAMT01 -=lngCHKAMT ;         
										}else{                              
											lngDEDAMT = lngSAVAMT01;          
											lngSAVAMT01=0;                    
										}  
								  }else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("32")){ //주택청약종합저축  
								  if(lngSAVAMT03!=0){
										if(lngCHKAMT <= lngSAVAMT03){       
											lngDEDAMT = lngCHKAMT;            
											lngSAVAMT03 -=lngCHKAMT ;         
										}else{                              
											lngDEDAMT = lngSAVAMT03;          
											lngSAVAMT03=0;                    
										} 
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("33")){ //장기주택마련저축   
									if(lngSAVAMT04!=0){
										if(lngCHKAMT <= lngSAVAMT04){       
											lngDEDAMT = lngCHKAMT;            
											lngSAVAMT04 -=lngCHKAMT ;         
										}else{                              
											lngDEDAMT = lngSAVAMT04;          
											lngSAVAMT04=0;                    
										}           
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("34")){ //근로자주택마련저축 
									if(lngSAVAMT02!=0){
										if(lngCHKAMT <= lngSAVAMT02){       
											lngDEDAMT = lngCHKAMT;            
											lngSAVAMT02 -=lngCHKAMT ;         
										}else{                              
											lngDEDAMT = lngSAVAMT02;          
											lngSAVAMT02=0;                    
										}          
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("41")){ //장기주식형저축  
									if(lngFNDSUM!=0){
										if(lngCHKAMT <= lngFNDSUM){         
											lngDEDAMT = lngCHKAMT;            
											lngFNDSUM -=lngCHKAMT ;           
										}else{                              
											lngDEDAMT = lngFNDSUM;            
											lngFNDSUM=0;                      
										}          
									}else{
										lngDEDAMT=0;
									}
								}                                     

							}else{  // 동일건이 존재하는 경우 /////////////////////////////////////////////////////////////////
							  lngCHKAMT   = rs.getLong("CHKAMT");  
								if(strDUDGB.equals("11")){         //퇴직연금   
									if(lngPENAMT03!=0){
										if(lngCHKAMT <= lngPENAMT03){
											lngDEDAMT = lngCHKAMT;
											lngPENAMT03 -=lngCHKAMT;
										}else{
											lngDEDAMT=lngPENAMT03;
											lngPENAMT03=0;
										}
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("21")){  //개인연금저축  
									if(lngPESAMT01!=0){
										if(lngCHKAMT <= lngPESAMT01){
											lngDEDAMT = lngCHKAMT;
											lngPESAMT01 -=lngCHKAMT;
										}else{
											lngDEDAMT=lngPESAMT01;
											lngPESAMT01=0;
										}
									}else{
										lngDEDAMT=0;
									}
                }else if(strDUDGB.equals("22")){  //연금저축  
									if(lngPESAMT02!=0){
										if(lngCHKAMT <= lngPESAMT02){
											lngDEDAMT = lngCHKAMT;
											lngPESAMT02 -=lngCHKAMT;
										}else{
											lngDEDAMT=lngPESAMT02;
											lngPESAMT02=0;
										}
									}else{
										lngDEDAMT=0;
									}
                }else if(strDUDGB.equals("31")){   //청약저축 
									if(lngSAVAMT01!=0){
										if(lngCHKAMT <= lngSAVAMT01){
											lngDEDAMT = lngCHKAMT;
											lngSAVAMT01 -=lngCHKAMT;
										}else{
											lngDEDAMT=lngSAVAMT01;
											lngSAVAMT01=0;
										}
									}else{
										lngDEDAMT=0;
									}
                }else if(strDUDGB.equals("32")){   //주택청약종합저축 
								  if(lngSAVAMT03!=0){
										if(lngCHKAMT <= lngSAVAMT03){
											lngDEDAMT = lngCHKAMT;
											lngSAVAMT03 -=lngCHKAMT;
										}else{
											lngDEDAMT=lngSAVAMT03;
											lngSAVAMT03=0;
										}
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("33")){   //장기주택마련저축    
                  if(lngSAVAMT04!=0){
										if(lngCHKAMT <= lngSAVAMT04){
											lngDEDAMT = lngCHKAMT;
											lngSAVAMT04 -=lngCHKAMT;
										}else{
											lngDEDAMT=lngSAVAMT04;
											lngSAVAMT04=0;
										}
									}else{
										lngDEDAMT=0;
									}
								}else if(strDUDGB.equals("34")){   //근로자주택마련저축
                  if(lngSAVAMT02!=0){
										if(lngCHKAMT <= lngSAVAMT02){
											lngDEDAMT = lngCHKAMT;
											lngSAVAMT02 -=lngCHKAMT;
										}else{
											lngDEDAMT=lngSAVAMT02;
											lngSAVAMT02=0;
										}
									}else{
										lngDEDAMT=0;
									}
							 }else if(strDUDGB.equals("41")){    //장기주식형저축
                  if(lngFNDSUM!=0){
										if(lngCHKAMT <= lngFNDSUM){
											lngDEDAMT = lngCHKAMT;
											lngFNDSUM -=lngCHKAMT;
										}else{
											lngDEDAMT=lngFNDSUM;
											lngFNDSUM=0;
										}
									}else{
										lngDEDAMT=0;
									}
								}
							}


							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPRSNPS SET    \n");   
							UpdateSql.append( "    DEDAMT='"+lngDEDAMT+"'     \n"); 
							UpdateSql.append( "   WHERE APPYY = '"+rows[j].getString(idxAPPYY)+"' " );
							UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
							UpdateSql.append( "     AND SEQ= '"+rs.getString("SEQ")+"'  " );
							//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();

							//logger.dbg.println(this,"60:::");

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