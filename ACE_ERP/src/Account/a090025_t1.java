package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090025_t1 extends HttpServlet{
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
				GauceStatement gsmt=null;

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String strAstmovno="";
				String strUserid = reqGauce.getParameter("v_str1"); //�����

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE      = userSet.indexOfColumn("FDCODE");       //�����ڵ�       
				int idxATCODE      = userSet.indexOfColumn("ATCODE");       //��������       
				int idxAST1ST      = userSet.indexOfColumn("AST1ST");       //��1����        
				int idxAST2ND      = userSet.indexOfColumn("AST2ND");       //��2����        
				int idxAST3RD      = userSet.indexOfColumn("AST3RD");       //��3����        
				int idxASTSEQ      = userSet.indexOfColumn("ASTSEQ");       //�Ϸù�ȣ       
				int idxASTMOVNO    = userSet.indexOfColumn("ASTMOVNO");     //�̵��̷¼���   
				int idxMOVDATE     = userSet.indexOfColumn("MOVDATE");      //�̵�����       
				int idxASTGUBUN    = userSet.indexOfColumn("ASTGUBUN");     //��ü�̵�����   
				int idxAMNGDPT     = userSet.indexOfColumn("AMNGDPT");      //�����μ�       
				int idxAUSEDPT     = userSet.indexOfColumn("AUSEDPT");      //���μ�       
				int idxACOSTCD     = userSet.indexOfColumn("ACOSTCD");      //�����ڵ�       
				int idxAUSER       = userSet.indexOfColumn("AUSER");        //�����         
				int idxBMNGDPT     = userSet.indexOfColumn("BMNGDPT");      //�����μ�       
				int idxBUSEDPT     = userSet.indexOfColumn("BUSEDPT");      //���μ�       
				int idxBCOSTCD     = userSet.indexOfColumn("BCOSTCD");      //�����ڵ�       
				int idxBUSER       = userSet.indexOfColumn("BUSER");        //�����         
				int idxMOVNOTE     = userSet.indexOfColumn("MOVNOTE");      //�̵�����       
				int idxAFDCODE     = userSet.indexOfColumn("AFDCODE");      //��ü������       

				///////// ///////////////////////////////////////////////////////////////////
				// �ڻ��̵� ( ASTMOVINGN�� ������ )
				//
				//
				/////////////////////////////////////////////////////////////////////////////

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	  
				StringBuffer Sql = null;   
		
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  

						//ASTMOVNO ä��
						Sql = new StringBuffer();
						Statement stmt = conn.createStatement();

						//Sql.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(ASTMOVNO),0)+1)),4) 	\n");
						Sql.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(ASTMOVNO),0))+1,4,0)				\n");
						Sql.append( "   FROM ACCOUNT.ASTMOVINGN 													\n");
						Sql.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"' 						\n");
						Sql.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"' 							\n");
						Sql.append( "    AND AST1ST ='"+rows[j].getString(idxAST1ST)+"' 							\n");
						Sql.append( "    AND AST2ND ='"+rows[j].getString(idxAST2ND)+"' 							\n");
						Sql.append( "    AND AST3RD ='"+rows[j].getString(idxAST3RD)+"' 							\n");
						Sql.append( "    AND ASTSEQ ='"+rows[j].getString(idxASTSEQ)+"' 							\n");

						//System.out.println("# Query : \n" + Sql);
						//logger.dbg.println(this,"Sql.toString()::"+Sql.toString());

						ResultSet rs = stmt.executeQuery(Sql.toString()); 
						if(rs.next()){
							strAstmovno= rs.getString(1);
						}    
						rs.close();
						stmt.close();

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ASTMOVINGN (  										" );
						InsertSql.append( " FDCODE,	   ATCODE,	  AST1ST,	  AST2ND,	   AST3RD,		 			" );
						InsertSql.append( " ASTSEQ,	   ASTMOVNO,  MOVDATE,	ASTGUBUN,  AMNGDPT, 		" );
						InsertSql.append( " AUSEDPT,   ACOSTCD,	  AUSER,	  BMNGDPT,   BUSEDPT, 			" );
						InsertSql.append( " BCOSTCD,   BUSER,	    MOVNOTE,	WRDT,	     WRID ,  AFDCODE  " );
						InsertSql.append( "  ) 																							" );
						InsertSql.append( " VALUES (   									" );
						InsertSql.append( " ?,?,?,?,?, 									" );
						InsertSql.append( " ?,'"+strAstmovno+"',?,?,?, 				" );
						InsertSql.append( " ?,?,?,?,?, 									" );
						InsertSql.append( " ?,?,?,sysdate,'"+strUserid+"', ?) 		" );

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxFDCODE);
						gsmt.bindColumn(2,idxATCODE);
						gsmt.bindColumn(3,idxAST1ST);
						gsmt.bindColumn(4,idxAST2ND);
						gsmt.bindColumn(5,idxAST3RD);
						gsmt.bindColumn(6,idxASTSEQ);
						gsmt.bindColumn(7,idxMOVDATE);
						gsmt.bindColumn(8,idxASTGUBUN);
						gsmt.bindColumn(9,idxAMNGDPT);
						gsmt.bindColumn(10,idxAUSEDPT);
						gsmt.bindColumn(11,idxACOSTCD);
						gsmt.bindColumn(12,idxAUSER);
						gsmt.bindColumn(13,idxBMNGDPT);
						gsmt.bindColumn(14,idxBUSEDPT);
						gsmt.bindColumn(15,idxBCOSTCD);
						gsmt.bindColumn(16,idxBUSER);
						gsmt.bindColumn(17,idxMOVNOTE);
						gsmt.bindColumn(18,idxAFDCODE);

						//System.out.println("# Query : \n" + InsertSql);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;

						//�ڻ�BASIC(ASTBASICN)�� UPDATE 
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET  " );
						UpdateSql.append( " MNGDPT  =?, " );
						UpdateSql.append( " USEDPT  =?, " );
						UpdateSql.append( " COSTCD  =?, " );
						UpdateSql.append( " ASTUSER =?, " );
						UpdateSql.append( " UPDT = sysdate,  " );
						UpdateSql.append( " UPID = '"+strUserid+"'     " );
						UpdateSql.append( " WHERE FDCODE =? " );
						UpdateSql.append( "   AND ATCODE =? " );
						UpdateSql.append( "   AND AST1ST =? " );
						UpdateSql.append( "   AND AST2ND =? " );
						UpdateSql.append( "   AND AST3RD =? " );
						UpdateSql.append( "   AND ASTSEQ =? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
            
						gsmt.bindColumn(1, idxAMNGDPT);
						gsmt.bindColumn(2, idxAUSEDPT);
						gsmt.bindColumn(3, idxACOSTCD);
						gsmt.bindColumn(4, idxAUSER);
						gsmt.bindColumn(5, idxFDCODE);
						gsmt.bindColumn(6, idxATCODE);
						gsmt.bindColumn(7, idxAST1ST);
						gsmt.bindColumn(8, idxAST2ND);
						gsmt.bindColumn(9, idxAST3RD);
						gsmt.bindColumn(10,idxASTSEQ);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;

						if(rows[j].getString(idxASTGUBUN).equals("8")){ //��ü �ϰ�� ASTBASICN(�ڻ�⺻)�� ASTSTAT ='8' �� ���� , �󰢹�ó��
							//�ڻ�BASIC(ASTBASICN)�� UPDATE 
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET  " );
							UpdateSql.append( " ASTSTAT  ='8', 						" );
							UpdateSql.append( " DEPRGB   ='2', 						" );
							UpdateSql.append( " UPDT = sysdate,  					" );
							UpdateSql.append( " UPID = '"+strUserid+"'     			" );
							UpdateSql.append( " WHERE FDCODE =? 				" );
							UpdateSql.append( "   AND ATCODE =? 					" );
							UpdateSql.append( "   AND AST1ST =? 					" );
							UpdateSql.append( "   AND AST2ND =? 					" );
							UpdateSql.append( "   AND AST3RD =? 					" );
							UpdateSql.append( "   AND ASTSEQ =? 					" );

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							
							gsmt.bindColumn(1, idxFDCODE);
							gsmt.bindColumn(2, idxATCODE);
							gsmt.bindColumn(3, idxAST1ST);
							gsmt.bindColumn(4, idxAST2ND);
							gsmt.bindColumn(5, idxAST3RD);
							gsmt.bindColumn(6, idxASTSEQ);

							gsmt.executeUpdate();
							gsmt.close();
							gsmt=null;
             
							//�ڻ�BASIC(ASTBASICN)�� UPDATE 
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.ASTDEPR SET  " );
							UpdateSql.append( " ASTDEPRST  ='1' 						" );
							UpdateSql.append( " WHERE FDCODE =? 					" );
							UpdateSql.append( "   AND ATCODE =? 						" );
							UpdateSql.append( "   AND AST1ST =? 						" );
							UpdateSql.append( "   AND AST2ND =? 						" );
							UpdateSql.append( "   AND AST3RD =? 						" );
							UpdateSql.append( "   AND ASTSEQ =? 						" );

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							
							gsmt.bindColumn(1, idxFDCODE);
							gsmt.bindColumn(2, idxATCODE);
							gsmt.bindColumn(3, idxAST1ST);
							gsmt.bindColumn(4, idxAST2ND);
							gsmt.bindColumn(5, idxAST3RD);
							gsmt.bindColumn(6, idxASTSEQ);

							gsmt.executeUpdate();
							gsmt.close();
							gsmt=null;

						}//rows[j].getString(idxASTGUBUN).equals("8")
					}
				}
		}
		 	catch(Exception e){
      conn.rollback(); 
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