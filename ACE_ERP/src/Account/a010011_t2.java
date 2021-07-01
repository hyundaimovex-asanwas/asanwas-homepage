package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010011_t2 extends HttpServlet{
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

				String strAstcd = null;
        
     
		        /************************************************************************************
		         @ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String strEmpno = reqGauce.getParameter("v_str1");  //사번

				int idxAST2ND     = userSet.indexOfColumn("AST2ND");   		// 1
				int idxAST3RD     = userSet.indexOfColumn("AST3RD");  		// 2
				int idxASTCD      = userSet.indexOfColumn("ASTCD");   			// 3
				int idxASTNM      = userSet.indexOfColumn("ASTNM");   		// 4
				int idxASTUSEDT   = userSet.indexOfColumn("ASTUSEDT");  	// 5
				int idxASTCLSDT   = userSet.indexOfColumn("ASTCLSDT");  	// 6
				int idxASTUSEYN   = userSet.indexOfColumn("ASTUSEYN"); 	// 7
				int idxI_EMPNO    = userSet.indexOfColumn("I_EMPNO");   	// 8
				int idxU_EMPNO    = userSet.indexOfColumn("U_EMPNO");   // 9

				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer Sql = null; 
				
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTNAME (  								\n");
				InsertSql.append( " AST2ND,	    AST3RD,    ASTCD,     ASTNM,  ASTUSEDT, 	\n");
				InsertSql.append( " ASTCLSDT,   ASTUSEYN,	 I_EMPNO,   I_DATE    				\n");
				InsertSql.append( "  ) 																				\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?, sysdate ) 									\n");	 


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ASTNAME SET  		\n");
				UpdateSql.append( "        ASTNM= ?, 									\n");
				UpdateSql.append( "        ASTUSEDT = ?, 							\n");
				UpdateSql.append( "        ASTCLSDT = ?, 							\n");
				UpdateSql.append( "        ASTUSEYN = ?, 							\n");
				UpdateSql.append( "        U_EMPNO = ?, 							\n");
				UpdateSql.append( "        U_DATE = sysdate  						\n");
				UpdateSql.append( "	 WHERE AST2ND =? 							\n");
				UpdateSql.append( "	   AND AST3RD=? 								\n");
				UpdateSql.append( "	   AND ASTCD=? 									\n");

        
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASTNAME  	\n");
				DeleteSql.append( "  WHERE AST2ND = ?   						\n");
				DeleteSql.append( "    AND AST3RD = ?   						\n");
				DeleteSql.append( "    AND ASTCD = ?   							\n");
        				    
				//===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
					//================================================================================<<<<
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//자산번호채번 
						//2011.04.18 JYS - 중분류, 소분류 관계없이 자산번호 채번
						Sql = new StringBuffer();
						Statement stmt = conn.createStatement();

						/* 
						Sql.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(ASTCD),0)+1)),5) 		\n");
						Sql.append( "   FROM ACCOUNT.ASTNAME 															\n");
                        */
						Sql.append( " SELECT CASE WHEN MAX(ASTCD) IS NULL THEN '00001'		\n");
						Sql.append( "        ELSE LPAD(TO_NUMBER(MAX(ASTCD))+1,5,'0') END	\n");
						Sql.append( "   FROM ACCOUNT.ASTNAME								\n");
						    
						ResultSet rs = stmt.executeQuery(Sql.toString()); 
						
						if(rs.next()){
							strAstcd= rs.getString(1);
						}    
						rs.close();


						rows[j].setString(idxASTCD,strAstcd);//(재설정)
						rows[j].setString(idxI_EMPNO,strEmpno);//(재설정)
  						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,idxAST2ND); 
						gsmt.bindColumn(2,idxAST3RD);   			
						gsmt.bindColumn(3,idxASTCD);					
						gsmt.bindColumn(4,idxASTNM);					
						gsmt.bindColumn(5,idxASTUSEDT);					
						gsmt.bindColumn(6,idxASTCLSDT);					
						gsmt.bindColumn(7,idxASTUSEYN);					
						gsmt.bindColumn(8,idxI_EMPNO);				
						
						gsmt.executeUpdate();
						gsmt.close();	
					}


						if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE ){
						rows[j].setString(idxU_EMPNO,strEmpno);

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,idxASTNM);
						gsmt.bindColumn(2,idxASTUSEDT);	
						gsmt.bindColumn(3,idxASTCLSDT); 
						gsmt.bindColumn(4,idxASTUSEYN);   			
						gsmt.bindColumn(5,idxU_EMPNO);					
						gsmt.bindColumn(6,idxAST2ND);					
						gsmt.bindColumn(7,idxAST3RD);					
						gsmt.bindColumn(8,idxASTCD);					

						gsmt.executeUpdate();
						gsmt.close();
					}

						if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxAST2ND); 
						gsmt.bindColumn(2,idxAST3RD);   			
						gsmt.bindColumn(3,idxASTCD);					
						
						gsmt.executeUpdate();
						gsmt.close();
											
					}
				}  //for j 
			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
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