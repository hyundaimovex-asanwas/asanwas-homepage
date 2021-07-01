package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090023_t3 extends HttpServlet{
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

				String strChgno = null;
        
     
        /************************************************************************************
         @ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				//logger.err.println(this,"STEP1::");
				//System.out.println("# Query : \n");
			
				String str1 = reqGauce.getParameter("v_str1");  //��¥
				String str2 = reqGauce.getParameter("v_str2");  //���
        				
				int idxFDCODE     = userSet.indexOfColumn("FDCODE");    // 1
				int idxATCODE     = userSet.indexOfColumn("ATCODE");    // 2
				int idxAST1ST     = userSet.indexOfColumn("AST1ST");   	// 3
				int idxAST2ND     = userSet.indexOfColumn("AST2ND");   	// 4
				int idxAST3RD     = userSet.indexOfColumn("AST3RD");  	// 5
				int idxASTSEQ     = userSet.indexOfColumn("ASTSEQ");   	// 6
				int idxCHGNO      = userSet.indexOfColumn("CHGNO");   	// 7
				int idxCHGDATE    = userSet.indexOfColumn("CHGDATE");   // 8
				int idxCHGTYPE    = userSet.indexOfColumn("CHGTYPE");  	// 9
				int idxDECTYPE    = userSet.indexOfColumn("DECTYPE"); 	// 10
				int idxCHGWHAT    = userSet.indexOfColumn("CHGWHAT"); 	// 11
				int idxCHGQTY     = userSet.indexOfColumn("CHGQTY");   	// 12
				int idxCHGAMT     = userSet.indexOfColumn("CHGAMT");  	// 13
				int idxCHGAMT2    = userSet.indexOfColumn("CHGAMT2"); 	// 14
				int idxCHGAMT3    = userSet.indexOfColumn("CHGAMT3"); 	// 15
				int idxRELFIRM    = userSet.indexOfColumn("RELFIRM"); 	// 16
				int idxRPSTARTDT  = userSet.indexOfColumn("RPSTARTDT"); // 17
				int idxRPENDDT    = userSet.indexOfColumn("RPENDDT");   // 18
				int idxWRDT       = userSet.indexOfColumn("WRDT");      // 19
				int idxWRID       = userSet.indexOfColumn("WRID");      // 20

				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;
				GauceStatement gsmt2=null; 

				Statement stmt =null;
				ResultSet rs=null;
				String sql=null;

				Statement stmt2 =null;
				ResultSet rs2=null;
				String sql2=null;

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTCHG (  " );
				InsertSql.append( " FDCODE,   ATCODE,  	 AST1ST,  AST2ND,	 AST3RD,   " );
				InsertSql.append( " ASTSEQ,   CHGNO,	   CHGDATE, CHGTYPE, DECTYPE,  " );
				InsertSql.append( " CHGWHAT,  CHGQTY,    CHGAMT,  CHGAMT2, CHGAMT3,	 " );
				InsertSql.append( " RELFIRM,  RPSTARTDT, RPENDDT, WRDT,    WRID      " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'"+str1+ "','"+str2+"' ) " );	 

        
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASTCHG  " );
				DeleteSql.append( "  WHERE FDCODE = ?   " );
				DeleteSql.append( "    AND ATCODE = ?   " );
				DeleteSql.append( "    AND AST1ST = ?   " );
				DeleteSql.append( "    AND AST2ND = ?   " );
				DeleteSql.append( "    AND AST3RD = ?   " );
				DeleteSql.append( "    AND ASTSEQ = ?   " );
				DeleteSql.append( "    AND CHGNO = ?   " );
        			
        				    
        //===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
				  //@ ��ǥ��ȣ ä�� START
					//sql = "SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(CHGNO),0)+1)),4) "
					sql = "SELECT LPAD(TO_NUMBER(NVL(MAX(CHGNO),0))+1,4,0) "
							+ "  FROM ACCOUNT.ASTCHG "
							+ " WHERE FDCODE ='"+ rows[j].getString(idxFDCODE)+"'" 
							+ "   AND ATCODE='"+rows[j].getString(idxATCODE)+"'"
							+ "   AND AST1ST='"+rows[j].getString(idxAST1ST)+"'"
							+ "   AND AST2ND='"+rows[j].getString(idxAST2ND)+"'"
							+ "   AND AST3RD='"+rows[j].getString(idxAST3RD)+"'"
							+ "   AND ASTSEQ='"+rows[j].getString(idxASTSEQ)+"'"; 				
					//System.out.println("# Query : \n" + sql);
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql); 
					if(rs.next()){
						 strChgno= rs.getString(1);
					}
					rs.close();
					stmt.close();
				  //@ ��ǥ��ȣ ä�� END

					//================================================================================<<<<
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						 
						rows[j].setString(idxCHGNO,strChgno);//strChgno�� ���� idxCHGNO(�����ͼ�)�� �ִ´�. (�缳��)
  						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxATCODE);   			
						gsmt.bindColumn(3,idxAST1ST);					
						gsmt.bindColumn(4,idxAST2ND);					
						gsmt.bindColumn(5,idxAST3RD);					
						gsmt.bindColumn(6,idxASTSEQ);					
						gsmt.bindColumn(7,idxCHGNO);					
						gsmt.bindColumn(8,idxCHGDATE);				
						gsmt.bindColumn(9,idxCHGTYPE);				
						gsmt.bindColumn(10,idxDECTYPE);				
						gsmt.bindColumn(11,idxCHGWHAT);				
						gsmt.bindColumn(12,idxCHGQTY);				
						gsmt.bindColumn(13,idxCHGAMT);				
						gsmt.bindColumn(14,idxCHGAMT2);				
						gsmt.bindColumn(15,idxCHGAMT3);				
						gsmt.bindColumn(16,idxRELFIRM);				
						gsmt.bindColumn(17,idxRPSTARTDT);			
						gsmt.bindColumn(18,idxRPENDDT);
						gsmt.executeUpdate();
						gsmt.close();
             					
					  //�ں��� ������ ��� ���ݾ��� �����Ѵ�.
						if(rows[j].getString(idxCHGTYPE).equals("3")){ 

							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET  " );
							UpdateSql.append( "        ASTAQAMT = ? ");
							UpdateSql.append( "	 WHERE FDCODE =? ");
							UpdateSql.append( "	   AND ATCODE=? ");
							UpdateSql.append( "	   AND AST1ST=? ");
							UpdateSql.append( "	   AND AST2ND=? ");
							UpdateSql.append( "	   AND AST3RD=? ");
							UpdateSql.append( "    AND ASTSEQ=? ");

							gsmt2 = conn.getGauceStatement(UpdateSql.toString());
							gsmt2.setGauceDataRow(rows[j]);
              
							gsmt2.bindColumn(1,idxCHGAMT2);	
							gsmt2.bindColumn(2,idxFDCODE); 
							gsmt2.bindColumn(3,idxATCODE);   			
							gsmt2.bindColumn(4,idxAST1ST);					
							gsmt2.bindColumn(5,idxAST2ND);					
							gsmt2.bindColumn(6,idxAST3RD);					
							gsmt2.bindColumn(7,idxASTSEQ);
							
							gsmt2.executeUpdate();
							gsmt2.close();

							UpdateSql=null;
						}else if(rows[j].getString(idxCHGTYPE).equals("1")||rows[j].getString(idxCHGTYPE).equals("2")){   //�Ű�, ��� �϶� 
                                                                                                              
							//ASTDEPR �� �����󰢿Ϸᱸ�п� �Ϸ�(1)
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTDEPR SET  " );
							UpdateSql.append( "        ASTDEPRST ='1' ");
							UpdateSql.append( "	 WHERE FDCODE =? ");
							UpdateSql.append( "	   AND ATCODE=? ");
							UpdateSql.append( "	   AND AST1ST=? ");
							UpdateSql.append( "	   AND AST2ND=? ");
							UpdateSql.append( "	   AND AST3RD=? ");
							UpdateSql.append( "    AND ASTSEQ=? ");

							gsmt2 = conn.getGauceStatement(UpdateSql.toString());
							gsmt2.setGauceDataRow(rows[j]);
              
							gsmt2.bindColumn(1,idxFDCODE); 
							gsmt2.bindColumn(2,idxATCODE);   			
							gsmt2.bindColumn(3,idxAST1ST);					
							gsmt2.bindColumn(4,idxAST2ND);					
							gsmt2.bindColumn(5,idxAST3RD);					
							gsmt2.bindColumn(6,idxASTSEQ);
							
							gsmt2.executeUpdate();
							gsmt2.close();
              
							gsmt2=null;

							//ASTBASIC �� ASTSTAT���� ���� �ؾ���.
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET  " );
							UpdateSql.append( "        DEPRGB ='2', ");  //�󰢹�ó��
							UpdateSql.append( "        ASTSTAT =? ");
							UpdateSql.append( "	 WHERE FDCODE =? ");
							UpdateSql.append( "	   AND ATCODE=? ");
							UpdateSql.append( "	   AND AST1ST=? ");
							UpdateSql.append( "	   AND AST2ND=? ");
							UpdateSql.append( "	   AND AST3RD=? ");
							UpdateSql.append( "    AND ASTSEQ=? ");

							gsmt2 = conn.getGauceStatement(UpdateSql.toString());
							gsmt2.setGauceDataRow(rows[j]);
              
							gsmt2.bindColumn(1,idxCHGTYPE); 
							gsmt2.bindColumn(2,idxFDCODE); 
							gsmt2.bindColumn(3,idxATCODE);   			
							gsmt2.bindColumn(4,idxAST1ST);					
							gsmt2.bindColumn(5,idxAST2ND);					
							gsmt2.bindColumn(6,idxAST3RD);					
							gsmt2.bindColumn(7,idxASTSEQ);
							
							gsmt2.executeUpdate();
							gsmt2.close();

						}
					} //if jobtype


          if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxATCODE);   			
						gsmt.bindColumn(3,idxAST1ST);					
						gsmt.bindColumn(4,idxAST2ND);					
						gsmt.bindColumn(5,idxAST3RD);					
						gsmt.bindColumn(6,idxASTSEQ);					
						gsmt.bindColumn(7,idxCHGNO);					
						
						gsmt.executeUpdate();
						gsmt.close();
											
						if(rows[j].getString(idxCHGTYPE).equals("3")){ //�ں�������

							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET  " );
							UpdateSql.append( "        ASTAQAMT = (ASTAQAMT - ?) ");
							UpdateSql.append( "	 WHERE FDCODE =? ");
							UpdateSql.append( "	   AND ATCODE=? ");
							UpdateSql.append( "	   AND AST1ST=? ");
							UpdateSql.append( "	   AND AST2ND=? ");
							UpdateSql.append( "	   AND AST3RD=? ");
							UpdateSql.append( "    AND ASTSEQ=? ");

							gsmt2 = conn.getGauceStatement(UpdateSql.toString());
							gsmt2.setGauceDataRow(rows[j]);

							gsmt2.bindColumn(1,idxCHGAMT);	
							gsmt2.bindColumn(2,idxFDCODE); 
							gsmt2.bindColumn(3,idxATCODE);   			
							gsmt2.bindColumn(4,idxAST1ST);					
							gsmt2.bindColumn(5,idxAST2ND);					
							gsmt2.bindColumn(6,idxAST3RD);					
							gsmt2.bindColumn(7,idxASTSEQ);					

							gsmt2.executeUpdate();
							gsmt2.close();
							UpdateSql=null;
            }else if(rows[j].getString(idxCHGTYPE).equals("1")||rows[j].getString(idxCHGTYPE).equals("2")){//�Ű�, ��� �϶� 
                                                                                                          
							//ASTDEPR �� �����󰢿Ϸᱸ�п� ������(0)																	 																													
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTDEPR SET  " );
							UpdateSql.append( "        ASTDEPRST ='0' ");
							UpdateSql.append( "	 WHERE FDCODE =? ");
							UpdateSql.append( "	   AND ATCODE=? ");
							UpdateSql.append( "	   AND AST1ST=? ");
							UpdateSql.append( "	   AND AST2ND=? ");
							UpdateSql.append( "	   AND AST3RD=? ");
							UpdateSql.append( "    AND ASTSEQ=? ");

							gsmt2 = conn.getGauceStatement(UpdateSql.toString());
							gsmt2.setGauceDataRow(rows[j]);
              
							gsmt2.bindColumn(1,idxFDCODE); 
							gsmt2.bindColumn(2,idxATCODE);   			
							gsmt2.bindColumn(3,idxAST1ST);					
							gsmt2.bindColumn(4,idxAST2ND);					
							gsmt2.bindColumn(5,idxAST3RD);					
							gsmt2.bindColumn(6,idxASTSEQ);
							
							gsmt2.executeUpdate();
							gsmt2.close();

							gsmt2=null;

							//ASTBASIC �� ASTSTAT���� ���� ������. ( ?? �ں������� ���� �Ű� �Ǿ��� ��� �Ű� ����ϸ�  �ں��� ����� ���ư����ϴµ�...��
							//ASTBASIC �� ASTSTAT���� ���� �ؾ���.
							//�ں������⵵ ����
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET  " );
							UpdateSql.append( "        DEPRGB ='1', ");   //��ó��
							UpdateSql.append( "        ASTSTAT ='0' ");
							UpdateSql.append( "	 WHERE FDCODE =? ");
							UpdateSql.append( "	   AND ATCODE=? ");
							UpdateSql.append( "	   AND AST1ST=? ");
							UpdateSql.append( "	   AND AST2ND=? ");
							UpdateSql.append( "	   AND AST3RD=? ");
							UpdateSql.append( "    AND ASTSEQ=? ");

							gsmt2 = conn.getGauceStatement(UpdateSql.toString());
							gsmt2.setGauceDataRow(rows[j]);
              
							gsmt2.bindColumn(1,idxFDCODE); 
							gsmt2.bindColumn(2,idxATCODE);   			
							gsmt2.bindColumn(3,idxAST1ST);					
							gsmt2.bindColumn(4,idxAST2ND);					
							gsmt2.bindColumn(5,idxAST3RD);					
							gsmt2.bindColumn(6,idxASTSEQ);
							
							gsmt2.executeUpdate();
							gsmt2.close();

							
            			}
					}
				}  //for j 
			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
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