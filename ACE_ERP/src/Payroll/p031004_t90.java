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
				 ��α� �̿����� ���μ���
				 1.YCPRSNG ��ȸ ==> YCPRSNGC INSERT 
				 2.YCPAY10 ��ȸ ==> CHKAMT01 
				 3.
				 4.
				*********************************************************************/
				/////////////////////////////////////////////////////////////////////////////////
				//��α� �̿����� ����
				//1.��α��� �����ϴ��� üũ 
				//2.������ �ٷμҵ�ݾ��� ���� �ִ��� üũ
				//  2.1 �� ���� ������ ���� �̿�
				//  2.2 ��αݾ� ��ŭ ���� ������ �̿� ����.
				//  2.3 ��αݾ׺��� ������.....�����ѵ� �ٽ� üũ�ؾ��ϳ�?(????????????????????)
				/////////////////////////////////////////////////////////////////////////////////
        //logger.dbg.println(this,"90:::");

        int intLapamt=0;
				int intChkamt01 =0;  //�ѵ�üũ���� ��α� �ѵ� üũ ������ �ٷμҵ�ݾ� ���� �ܾ�
				int intCnt=0;
        int intACCAMT = 0;  //*���⴩�������ݾ�*/
				int intDEDAMT = 0;	//*�������ݾ�*/    
				int intGIVAMT = 0;	//*�ش翬�������ݾ�*/
				int intEXTAMT = 0;	//*�Ҹ�ݾ�*/        
				int intCARAMT = 0;	//*�̿��ݾ�*/        
				int intCONLMT4041=0; //������α� ( ����+������)
				int intTGIVAMT =0;  //��αݾ�

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //�ͼӳ⵵       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //�ͼӳ⵵       

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

						//���� ������ ���� 
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

            //���� ��α� ������ INSERT  --����--Ư��--����--������--����
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


						//YCPRSNGC  YCPAY10 ��ȸ 
						//B.LABPAY, B.CHKAMT01  �� ù ��° ���ڵ��� �͸� ������ �ִ´�. 

						//A.ACCAMT, -/*���⴩�������ݾ�*/
						//A.DEDAMT, -/*�������ݾ�*/
						//A.GIVAMT, -/*�ش翬�������ݾ�*/ 
						//A.EXTAMT, -/*�Ҹ�ݾ�*/  
						//A.CARAMT, -/*�̿��ݾ�*/ 


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

           //�ʱ�ȭ
					 intCONLMT4041 =0;
					 intLapamt=0;
					 intChkamt01=0;
					 intCnt=0;
					
						while(rs.next()){  
							intCnt+=1;
							if(intCnt==1){ // ������ �Ǹ�
								intLapamt   = rs.getInt("LABPAY");
								intChkamt01 = rs.getInt("CHKAMT01");
							}

							if(intChkamt01==0){ //��α� üũ���� �ѵ��� 0 �̸� ��� ��α��� �̿�������Ŵ
								intACCAMT = 0;                    //*���⴩�������ݾ�*/
								intDEDAMT = rs.getInt("TGIVAMT");	//*�������ݾ�*/    
								intGIVAMT = 0;	                  //*�ش翬�������ݾ�*/
								intEXTAMT = 0;	                  //*�Ҹ�ݾ�*/        
								intCARAMT = rs.getInt("TGIVAMT");	//*�̿��ݾ�*/ 						

							}else{ //�Ǻ� �ѵ��ݾ� ����Ͽ� update
							  intACCAMT = 0;                                        //*���⴩�������ݾ�*/
								intDEDAMT = rs.getInt("TGIVAMT")+rs.getInt("ACCAMT");	//*�������ݾ�*/    
								intGIVAMT = 0;	                                      //*�ش翬�������ݾ�*/
								intEXTAMT = 0;	                                      //*�Ҹ�ݾ�*/        
								intCARAMT = 0;	                                      //*�̿��ݾ�*/   

								if(rs.getString("GIVCOD").equals("10")){ //������α�
									if(rs.getInt("TGIVAMT")>0){
										if(rs.getInt("CONLMT10")>=rs.getInt("TGIVAMT")){
											intGIVAMT=rs.getInt("TGIVAMT");  //*�ش翬�������ݾ�*/
                      intCARAMT=0;                     //*�̿��ݾ�*/  
										}else{
											intGIVAMT=rs.getInt("CONLMT10");                      //*�ش翬�������ݾ�*/
                      intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT10"); //*�̿��ݾ�*/  
										}	
									}								
								}else if(rs.getString("GIVCOD").equals("30")){
									if(rs.getInt("TGIVAMT")>0){
										if(rs.getInt("CONLMT30")>=rs.getInt("TGIVAMT")){
											intGIVAMT=rs.getInt("TGIVAMT");  //*�ش翬�������ݾ�*/
                      intCARAMT=0;                     //*�̿��ݾ�*/  
										}else{
											intGIVAMT=rs.getInt("CONLMT30");                      //*�ش翬�������ݾ�*/
                      intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT30"); //*�̿��ݾ�*/  
										}	
									}								
                }else if(rs.getString("GIVCOD").equals("31")){
									if(rs.getInt("TGIVAMT")>0){
										if(rs.getInt("CONLMT31")>=rs.getInt("TGIVAMT")){
											intGIVAMT=rs.getInt("TGIVAMT");  //*�ش翬�������ݾ�*/
                      intCARAMT=0;                     //*�̿��ݾ�*/  
										}else{
											intGIVAMT=rs.getInt("CONLMT31");                      //*�ش翬�������ݾ�*/
                      intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT31"); //*�̿��ݾ�*/  
										}	
									}								
                }else if(rs.getString("GIVCOD").equals("40")||rs.getString("GIVCOD").equals("41")){  // 
									if(rs.getInt("TGIVAMT")>0){
										intCONLMT4041+=rs.getInt("TGIVAMT");
										if(rs.getInt("CONLMT40")!=0){ //������ü�� ���� ��� 
											if(rs.getInt("CONLMT40")>=rs.getInt("TGIVAMT")){
												intGIVAMT=rs.getInt("TGIVAMT");  //*�ش翬�������ݾ�*/
												intCARAMT=0;                     //*�̿��ݾ�*/  
											}else{
												intGIVAMT=rs.getInt("CONLMT40");                      //*�ش翬�������ݾ�*/
												intCARAMT=rs.getInt("TGIVAMT")-rs.getInt("CONLMT40"); //*�̿��ݾ�*/  
											}	
                    }else{                       //������ü�� �ִ� ��� 
											if(rs.getString("GIVCOD").equals("41")){

												if(rs.getInt("CONLMT41")>=intCONLMT4041){
													intGIVAMT=intCONLMT4041;         //*�ش翬�������ݾ�*/
													intCARAMT=0;                     //*�̿��ݾ�*/  
												}else{
													intGIVAMT=rs.getInt("CONLMT41");               //*�ش翬�������ݾ�*/
													intCARAMT=intCONLMT4041-rs.getInt("CONLMT41"); //*�̿��ݾ�*/  
												}	
											}
										}
									}
								}
							}//if(intChkamt01==0){ //��α� üũ���� �ѵ��� 0 �̸� ��� ��α��� �̿�������Ŵ

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
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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