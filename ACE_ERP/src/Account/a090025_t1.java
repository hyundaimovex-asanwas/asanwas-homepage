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
				String strUserid = reqGauce.getParameter("v_str1"); //사용자

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE      = userSet.indexOfColumn("FDCODE");       //지점코드       
				int idxATCODE      = userSet.indexOfColumn("ATCODE");       //계정과목       
				int idxAST1ST      = userSet.indexOfColumn("AST1ST");       //제1구분        
				int idxAST2ND      = userSet.indexOfColumn("AST2ND");       //제2구분        
				int idxAST3RD      = userSet.indexOfColumn("AST3RD");       //제3구분        
				int idxASTSEQ      = userSet.indexOfColumn("ASTSEQ");       //일련번호       
				int idxASTMOVNO    = userSet.indexOfColumn("ASTMOVNO");     //이동이력순번   
				int idxMOVDATE     = userSet.indexOfColumn("MOVDATE");      //이동일자       
				int idxASTGUBUN    = userSet.indexOfColumn("ASTGUBUN");     //이체이동구분   
				int idxAMNGDPT     = userSet.indexOfColumn("AMNGDPT");      //관리부서       
				int idxAUSEDPT     = userSet.indexOfColumn("AUSEDPT");      //사용부서       
				int idxACOSTCD     = userSet.indexOfColumn("ACOSTCD");      //원가코드       
				int idxAUSER       = userSet.indexOfColumn("AUSER");        //사용자         
				int idxBMNGDPT     = userSet.indexOfColumn("BMNGDPT");      //관리부서       
				int idxBUSEDPT     = userSet.indexOfColumn("BUSEDPT");      //사용부서       
				int idxBCOSTCD     = userSet.indexOfColumn("BCOSTCD");      //원가코드       
				int idxBUSER       = userSet.indexOfColumn("BUSER");        //사용자         
				int idxMOVNOTE     = userSet.indexOfColumn("MOVNOTE");      //이동내역       
				int idxAFDCODE     = userSet.indexOfColumn("AFDCODE");      //이체후지점       

				///////// ///////////////////////////////////////////////////////////////////
				// 자산이동 ( ASTMOVINGN에 적용함 )
				//
				//
				/////////////////////////////////////////////////////////////////////////////

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	  
				StringBuffer Sql = null;   
		
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  

						//ASTMOVNO 채번
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

						//자산BASIC(ASTBASICN)에 UPDATE 
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

						if(rows[j].getString(idxASTGUBUN).equals("8")){ //이체 일경우 ASTBASICN(자산기본)의 ASTSTAT ='8' 로 변경 , 상각미처리
							//자산BASIC(ASTBASICN)에 UPDATE 
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
             
							//자산BASIC(ASTBASICN)에 UPDATE 
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