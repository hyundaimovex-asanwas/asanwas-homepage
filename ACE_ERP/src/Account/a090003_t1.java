package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090003_t1 extends HttpServlet{
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
			String strErrorNo ="";
			String strFsnbr="";
			String strFdcode="";
			String strFsdat = "";
			String strFsseq="";
			String strAtcode="";
			String strAst1st="";
			String strAst2nd="";
			String strAst3rd="";
			String strAstseq="";
			String strChgno="";
			String strAqamt="";
			String strChgtype="";
			
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
        
     
        /************************************************************************************
         @ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				//String strloginfdcode = reqGauce.getParameter("v_str0");   //로그인 ID에 따른 지점 
				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");  //첫번째 인덱스
				int idxATCODE       = userSet.indexOfColumn("ATCODE");   
				int idxAST1ST        = userSet.indexOfColumn("AST1ST");   
				int idxAST2ND        = userSet.indexOfColumn("AST2ND");   
				int idxAST3RD        = userSet.indexOfColumn("AST3RD");
				int idxASTSEQ       = userSet.indexOfColumn("ASTSEQ");  
				int idxCHGNO        = userSet.indexOfColumn("CHGNO");  
				int idxCHGDATE     = userSet.indexOfColumn("CHGDATE");   
				int idxCHGTYPE     = userSet.indexOfColumn("CHGTYPE");  
				int idxDECTYPE     = userSet.indexOfColumn("DECTYPE"); 
				int idxCHGWHAT    = userSet.indexOfColumn("CHGWHAT");
				int idxCHGQTY      = userSet.indexOfColumn("CHGQTY");
				int idxCHGAMT      = userSet.indexOfColumn("CHGAMT");
				int idxCHGAMT2    = userSet.indexOfColumn("CHGAMT2"); 
				int idxCHGAMT3    = userSet.indexOfColumn("CHGAMT3"); 
				int idxRELFIRM      = userSet.indexOfColumn("RELFIRM");
				int idxWRDT           = userSet.indexOfColumn("WRDT");    
				int idxWRID            = userSet.indexOfColumn("WRID");
				int idxASTAQAMT            = userSet.indexOfColumn("ASTAQAMT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTCHG (  " );
				InsertSql.append( " FDCODE, ATCODE,	 AST1ST, AST2ND,	 AST3RD , " );
				InsertSql.append( " ASTSEQ, CHGNO,	CHGDATE,	 CHGTYPE,  DECTYPE,  " );
			    InsertSql.append( " CHGWHAT,  CHGQTY,  CHGAMT,  CHGAMT2, CHGAMT3,	" );
				InsertSql.append( " RELFIRM, WRDT, WRID " );
				
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?, ?,?,?,?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '"+str1+ "','"+str2+"' ) " );	 
		    
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
					strChgtype = rows[j].getString(idxCHGTYPE);

        	        
				/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           		@ 전표번호 채번 START
				    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
					
							Statement stmt = conn.createStatement();
							String sql = " SELECT COALESCE(MAX(CHGNO),0)+1 FROM ACCOUNT.ASTCHG "
												 + "	WHERE FDCODE ='"+ rows[j].getString(idxFDCODE)+"'" 
												 + "	  AND ATCODE='"+rows[j].getString(idxATCODE)+"'"
												 + "	  AND AST1ST='"+rows[j].getString(idxAST1ST)+"'"
												 + "	  AND AST2ND='"+rows[j].getString(idxAST2ND)+"'"
												 + "	  AND AST3RD='"+rows[j].getString(idxAST3RD)+"'"
												 + "	  AND ASTSEQ='"+rows[j].getString(idxASTSEQ)+"'"
												 + "	  AND CHGNO='"+rows[j].getString(idxCHGNO)+"'" ;

							ResultSet rs = stmt.executeQuery(sql); 
							if(rs.next()){
								 strChgno= rs.getString(1);
							}

							rs.close();
							int ichk = Integer.parseInt(strChgno);

							
							if(ichk<10) strChgno = "000"+strChgno;
							else if(ichk>=10 && ichk<100)strChgno = "00"+strChgno;
							else if(ichk>=100 && ichk<1000) strChgno ="0"+strChgno;
	
							rs.close();

							rows[j].setString(idxCHGNO,strChgno);//strChgno의 값을 idxCHGNO(빈데이터셋)로 넣는다. (재설정)
					
					 /*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           			@ 전표번호 채번 END
				    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

						//================================================================================<<<<
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

							/************************************************************************************/
							//전표 Master
							/***********************************************************************************/

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1, idxFDCODE);
							gsmt.bindColumn(2, idxATCODE);
							gsmt.bindColumn(3, idxAST1ST);
							gsmt.bindColumn(4, idxAST2ND);
							gsmt.bindColumn(5, idxAST3RD);
							gsmt.bindColumn(6, idxASTSEQ);
							gsmt.bindColumn(7, idxCHGNO);
							gsmt.bindColumn(8, idxCHGDATE);
							gsmt.bindColumn(9, idxCHGTYPE);
							gsmt.bindColumn(10,idxDECTYPE);
							gsmt.bindColumn(11, idxCHGWHAT);
							gsmt.bindColumn(12, idxCHGQTY);
							gsmt.bindColumn(13, idxCHGAMT);
							gsmt.bindColumn(14, idxCHGAMT2);
							gsmt.bindColumn(15, idxCHGAMT3);
							gsmt.bindColumn(16, idxRELFIRM);

							gsmt.executeUpdate();
							gsmt.close();
							
						} //if jobtype

						if(strChgtype.equals("3")){ 

							String  sql8_4 = " UPDATE ACCOUNT.ASTBASIC SET  "
												 + "        ASTAQAMT ="+ rows[j].getString(idxASTAQAMT)+"" 
												 + "	WHERE FDCODE ='"+ rows[j].getString(idxFDCODE)+"'" 
												 + "	  AND ATCODE='"+rows[j].getString(idxATCODE)+"'"
												 + "	  AND AST1ST='"+rows[j].getString(idxAST1ST)+"'"
												 + "	  AND AST2ND='"+rows[j].getString(idxAST2ND)+"'"
												 + "	  AND AST3RD='"+rows[j].getString(idxAST3RD)+"'"
												 + "	  AND ASTSEQ='"+rows[j].getString(idxASTSEQ)+"'";
												
						GauceStatement gsmt8_4 = conn.getGauceStatement(sql8_4);
						gsmt8_4.executeUpdate();
						gsmt8_4.close();
						}
				}  //for j 
   
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::"+strErrorNo);
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