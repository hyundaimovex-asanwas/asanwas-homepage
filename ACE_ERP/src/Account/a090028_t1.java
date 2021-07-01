package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090028_t1 extends HttpServlet{
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

				String  strAstym = reqGauce.getParameter("v_str1"); //상각년월
				String  strAstdat= reqGauce.getParameter("v_str2"); //처리일자	
				String  strPrevym= reqGauce.getParameter("v_str3"); //이체등록 전기 상각년월(이체전 전년도) -- 사용안함.

				String strYm="";
				double intAmt=0;

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE     = userSet.indexOfColumn("FDCODE");      //지점  
				int idxATCODE     = userSet.indexOfColumn("ATCODE");      //계정     
				int idxAST1ST     = userSet.indexOfColumn("AST1ST");      //제1구분      
				int idxAST2ND     = userSet.indexOfColumn("AST2ND");      //제2구분     
				int idxAST3RD     = userSet.indexOfColumn("AST3RD");      //제3구분          
				int idxASTSEQ     = userSet.indexOfColumn("ASTSEQ");      //일련번호     
				
				int idxASTAQAMT   = userSet.indexOfColumn("ASTAQAMT");    //취득금액   
				int idxASTYUSE    = userSet.indexOfColumn("ASTYUSE");     //내용연수     
				int idxASTRMAMT   = userSet.indexOfColumn("ASTRMAMT");    //잔존가액(장부가액)				
				int idxABDEPRAMT  = userSet.indexOfColumn("ABDEPRAMT");   //전기상각액 
				int idxACDEPRAMT  = userSet.indexOfColumn("ACDEPRAMT");   //당기상각액

				int idxASTDEPRST  = userSet.indexOfColumn("ASTDEPRST");   //감가상각완료 구분 0 -진행중 1-상각완료
				int idxDEPRENDDT  = userSet.indexOfColumn("DEPRENDDT");   //감가상각완료일 .... 
			
                int idxCOSTCD     = userSet.indexOfColumn("COSTCD");   //원가코드
                int idxASTAMT     = userSet.indexOfColumn("ASTAMT");   //월상각금액 ( 이체전 금액을 누적해서 넣음) .... 

			    int idxACOSTCD   = userSet.indexOfColumn("ACOSTCD");  //이체전 원가코드
				
				//외화
			    int idxASTAQAMTY = userSet.indexOfColumn("ASTAQAMTY");  //취득금액  
				int idxFOBDAMT   = userSet.indexOfColumn("FOBDAMT");    //전기누계액
				int idxFOCDAMT   = userSet.indexOfColumn("FOCDAMT");    //당기상각액
				int idxFORMAMT   = userSet.indexOfColumn("FORMAMT");    //잔존가액  
				int idxFOATAMT   = userSet.indexOfColumn("FOATAMT");    //감가상각액

				//ASTYEPR ///////////////////////////////////////////////////////////////////
				//2010.07.05 이체전 금액을 누적해서 월 상각에 넣을 경우 당기상각액이 틀려짐.
				//그래서, 이체 등록시 전기상각금액은 이전년도 12월31일로 처리넣고
				//당기상각금액을 당기년월의 최종상각일자로 해서 넣음.
				/////////////////////////////////////////////////////////////////////////////

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	     
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  

						//logger.dbg.println(this,"idxABDEPRAMT::"+ rows[j].getString(idxABDEPRAMT));
                        //logger.dbg.println(this,"idxACDEPRAMT::"+ rows[j].getString(idxACDEPRAMT));
 
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ASTDEPR (  " );
						InsertSql.append( " FDCODE,	   ATCODE,	  AST1ST,	   AST2ND,	  AST3RD,    " );
						InsertSql.append( " ASTSEQ,	   ASTAQAMT,  ASTYUSE,	 ASTRMAMT,  ASTDEPRST, " );
						InsertSql.append( " DEPRENDDT, ABINSAMT,  ACINSAMT,	 ABDECAMT,	ACDECAMT,  " );
						InsertSql.append( " ABDEPRAMT, ABBOOKAMT, ACDEPRAMT, " );
						InsertSql.append( " FOAQAMT,   FORMAMT,   FOBDAMT,   FOCDAMT, " );
						InsertSql.append( " MOAQAMT,   MORMAMT,   MOBDAMT,   MOCDAMT,  " );
						InsertSql.append( " FMOAQAMT,  FMORMAMT,  FMOBDAMT,  FMOCDAMT  ) " );
						InsertSql.append( " VALUES (   " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,0,0,0,0, " );
						InsertSql.append( " ?,0,?,     " );
						InsertSql.append( " ?,?,?,?,   " );
						InsertSql.append( " ?,?,?,?,   " );
						InsertSql.append( " ?,?,?,?  ) " );

                        if (rows[j].getDouble(idxACDEPRAMT)==0) {
							rows[j].setString(idxASTDEPRST,"1");
                        }else{
							rows[j].setString(idxASTDEPRST,"0");
                        }
						

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxFDCODE);
						gsmt.bindColumn(2,  idxATCODE);
						gsmt.bindColumn(3,  idxAST1ST);
						gsmt.bindColumn(4,  idxAST2ND);
						gsmt.bindColumn(5,  idxAST3RD);
						gsmt.bindColumn(6,  idxASTSEQ);
						gsmt.bindColumn(7,  idxASTAQAMT);
						gsmt.bindColumn(8,  idxASTYUSE);
						gsmt.bindColumn(9,  idxASTRMAMT);
						gsmt.bindColumn(10, idxASTDEPRST);
						gsmt.bindColumn(11, idxDEPRENDDT);
						gsmt.bindColumn(12, idxABDEPRAMT);
						gsmt.bindColumn(13, idxACDEPRAMT);
						gsmt.bindColumn(14, idxASTAQAMTY);
						gsmt.bindColumn(15, idxFORMAMT);
						gsmt.bindColumn(16, idxFOBDAMT);
						gsmt.bindColumn(17, idxFOCDAMT);
                        gsmt.bindColumn(18, idxASTAQAMT);
						gsmt.bindColumn(19, idxASTRMAMT);
						gsmt.bindColumn(20, idxABDEPRAMT);
						gsmt.bindColumn(21, idxACDEPRAMT);
						gsmt.bindColumn(22, idxASTAQAMTY);
						gsmt.bindColumn(23, idxFORMAMT);
						gsmt.bindColumn(24, idxFOBDAMT);
						gsmt.bindColumn(25, idxFOCDAMT);

						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;


						for (int i=1; i<=2;i++){

							if(i==1){       //전기누계액 처리
								//월감가상각에 추가함. ( 해당년도의 00월에 전기누계액 입력 ) 
								strYm = strAstym.substring(0,4)+"00";   
								intAmt = rows[j].getDouble(idxABDEPRAMT);

							}else if(i==2){ //당기상각액 처리
								//월감가상각에 추가함.
								strYm = strAstym;
								intAmt = rows[j].getDouble(idxACDEPRAMT);
							}


							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTYEPR (  " );
							InsertSql.append( " FDCODE,	 ATCODE,  AST1ST,	 AST2ND,	AST3RD, " );
							InsertSql.append( " ASTSEQ,	 ASTYM,   ASTAMT,	 ASTDAT,  COSTCD, ASTAQAMT, REGIGB, FOATAMT, FOAQAMT )	" );
							InsertSql.append( " VALUES (   " );
							InsertSql.append( " ?,?,?,?,?, " );
							InsertSql.append( " ?,'"+strYm+"',"+intAmt+",'"+strAstdat+"',?,?,'2',?,?" );
							InsertSql.append( " ) " );

							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1,  idxFDCODE);
							gsmt.bindColumn(2,  idxATCODE);
							gsmt.bindColumn(3,  idxAST1ST);
							gsmt.bindColumn(4,  idxAST2ND);
							gsmt.bindColumn(5,  idxAST3RD);
							gsmt.bindColumn(6,  idxASTSEQ);
							gsmt.bindColumn(7,  idxACOSTCD); //이체전 감가상각
							gsmt.bindColumn(8,  idxASTAQAMT);
							gsmt.bindColumn(9,  idxFOCDAMT);
							gsmt.bindColumn(10, idxASTAQAMTY);

							gsmt.executeUpdate();
							gsmt.close();

							gsmt=null;

						}

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