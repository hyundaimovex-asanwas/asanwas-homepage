package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040001_t2_2_ee_A2 extends HttpServlet{
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

		   try{
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");	//계산서번호
				String str2 = reqGauce.getParameter("v_str2");	//작업(=수정)일
				String str3 = reqGauce.getParameter("v_str3");	//작업(=수정)자
				String taxch="";

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"TAXNBR","TAXSEQ","TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC","TAXSUM","TAXVATAMT","BIGO","WRDT",
					"WRID","UPDT","UPID", "REMARK"
				};

				int[] idx = new int[14];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql2 = null;

				Statement stmt = null;
				ResultSet rs = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						taxch = rows[j].getString(idx[1]);
						StringBuffer sql = new StringBuffer();

						sql.append(" SELECT COALESCE(MAX(TAXSEQ),0)+1 CNT	");
						sql.append(" FROM ACCOUNT.ATTAXDTL								");
						sql.append(" WHERE TAXNBR = '"+str1+"'						");

						//System.out.println("a040001_t2_2_ee_A2# Query : \n" + sql);								
						
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while(rs.next()) {
							taxch = rs.getInt(1) + "";
						}

						if (taxch.length()==1) taxch = "00"+taxch;
						else if (taxch.length()==2) taxch = "0"+taxch;

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ATTAXDTL (					");
						InsertSql.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,	");
						InsertSql.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,					");
						InsertSql.append( " WRDT,WRID										");
						InsertSql.append( " ) VALUES(										");
						InsertSql.append( " '"+str1+"','"+taxch+"', ?, ?, ?,				");
						InsertSql.append( " ?, ?, ?, ?,										");
						InsertSql.append( " '"+str2+"', '"+str3+"' )						");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int k=1;k<=7;k++) {
							gsmt.bindColumn(k, idx[k+1]);
						}
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
						taxch = "";
					} 

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ATTAXDTL SET					    				");
						UpdateSql.append( " TAXPDTNAM = ?, TAXSTD = ?, TAXQTY = ?, TAXPRIC = ?, TAXSUM = ?,	");
						UpdateSql.append( " TAXVATAMT = ?, BIGO = ?,   UPDT = '"+str2+"',	UPID = '"+str3+"'	");
						UpdateSql.append( " WHERE TAXNBR = '"+str1+"'	AND TAXSEQ = ?							");
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int s=1;s<=7;s++) {
							gsmt.bindColumn(s, idx[s+1]);
						}

						gsmt.bindColumn(8, idx[1]);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
					
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.ATTAXDTL WHERE TAXNBR = '"+str1+"' AND TAXSEQ = ? ");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idx[1]);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

				}
		/************************************************************************************
			 @세금계산서 master 수정
		*************************************************************************************/
    
		 GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2"); //두번째 데이타셋 넘김
		 if (userSet2 != null) { //null체크
			 	int idx2TAXNBR      = userSet2.indexOfColumn("TAXNBR");
				int idx2COCODE      = userSet2.indexOfColumn("COCODE");
				int idx2DEPTCD      = userSet2.indexOfColumn("DEPTCD");
				int idx2EMPNO       = userSet2.indexOfColumn("EMPNO");
				int idx2TAXIODIV    = userSet2.indexOfColumn("TAXIODIV");
				int idx2TAXDIV      = userSet2.indexOfColumn("TAXDIV");

				int idx2TAXKND      = userSet2.indexOfColumn("TAXKND");
				int idx2VEND_CD     = userSet2.indexOfColumn("VEND_CD");
				int idx2TAXDAT      = userSet2.indexOfColumn("TAXDAT");
				int idx2TAXSUM      = userSet2.indexOfColumn("TAXSUM");
				int idx2TAXVATAMT   = userSet2.indexOfColumn("TAXVATAMT");

				int idx2TAXTOT      = userSet2.indexOfColumn("TAXTOT");
				int idx2REMARK      = userSet2.indexOfColumn("REMARK");
				int idx2TAXCDNBR	  = userSet2.indexOfColumn("TAXCDNBR");
				int idx2ATCODE		  = userSet2.indexOfColumn("ATCODE");
				int idx2TAXPRTYN	  = userSet2.indexOfColumn("TAXPRTYN");

				int idx2TAXCNT		  = userSet2.indexOfColumn("TAXCNT");
				int idx2LASTPRT		  = userSet2.indexOfColumn("LASTPRT");
				int idx2TAXTYPE		  = userSet2.indexOfColumn("TAXTYPE");
				int idx2FSDAT		    = userSet2.indexOfColumn("FSDAT");
				int idx2FSNBR		    = userSet2.indexOfColumn("FSNBR");

				int idx2TAXKIDIV	  = userSet2.indexOfColumn("TAXKIDIV");
				int idx2FDCODE		  = userSet2.indexOfColumn("FDCODE");
				int idx2WORKTYPE    = userSet2.indexOfColumn("WORKTYPE");
				int idx2UPDT		    = userSet2.indexOfColumn("UPDT");
				int idx2UPID		    = userSet2.indexOfColumn("UPID");
				int idx2SEQ		      = userSet2.indexOfColumn("SEQ");
				int idx2GUBUN	      = userSet2.indexOfColumn("GUBUN");
				int idx2AMEND_CODE  = userSet2.indexOfColumn("AMEND_CODE");
				int idx2AMEDN_REMARK= userSet2.indexOfColumn("AMEND_REMARK");
				int idx2EXTCHK      = userSet2.indexOfColumn("EXTCHK");
				int idx2REMARK2     = userSet2.indexOfColumn("REMARK2");
				int idx2REMARK3     = userSet2.indexOfColumn("REMARK3");
				int idx2S_BIZPLACE     = userSet2.indexOfColumn("S_BIZPLACE");

				GauceDataRow[] rows2 = userSet2.getDataRows();

				for (int ab = 0; ab < rows2.length; ab++){			   

					StringBuffer UpdateSql11 = null;
					UpdateSql11 = new StringBuffer();
					UpdateSql11.append( " UPDATE ACCOUNT.ATTAXMST SET " );
					UpdateSql11.append( " COCODE = '" + rows2[ab].getString(idx2COCODE) + "', 	");
					UpdateSql11.append( " TAXIODIV = '" + rows2[ab].getString(idx2TAXIODIV) + "', 	");
					UpdateSql11.append( " TAXDIV = '" + rows2[ab].getString(idx2TAXDIV) + "', 	");

					UpdateSql11.append( " TAXKND = '" + rows2[ab].getString(idx2TAXKND) + "', 	");
					UpdateSql11.append( " VEND_CD = '" + rows2[ab].getString(idx2VEND_CD) + "', 	");
					UpdateSql11.append( " TAXDAT = '" + rows2[ab].getString(idx2TAXDAT) + "', 	");
					UpdateSql11.append( " TAXSUM = " + rows2[ab].getDouble(idx2TAXSUM) + ", 	");
					UpdateSql11.append( " TAXVATAMT = " + rows2[ab].getDouble(idx2TAXVATAMT) + ", 	");

					UpdateSql11.append( " TAXTOT = " + rows2[ab].getDouble(idx2TAXTOT) + ",  	");
					UpdateSql11.append( " REMARK = ?, 	");
					UpdateSql11.append( " TAXCDNBR = '" + rows2[ab].getString(idx2TAXCDNBR) + "', 	");
					UpdateSql11.append( " ATCODE = '" + rows2[ab].getString(idx2ATCODE) + "', 	");
					UpdateSql11.append( " TAXPRTYN = '" + rows2[ab].getString(idx2TAXPRTYN) + "',	");

					UpdateSql11.append( " TAXCNT = '" + rows2[ab].getString(idx2TAXCNT) + "', 	");
					UpdateSql11.append( " LASTPRT = '" + rows2[ab].getString(idx2LASTPRT) + "', 	");
					UpdateSql11.append( " TAXTYPE = '" + rows2[ab].getString(idx2TAXTYPE) + "', 	");
					UpdateSql11.append( " FSDAT = '" + rows2[ab].getString(idx2FSDAT) + "', 	");
					UpdateSql11.append( " FSNBR = '" + rows2[ab].getString(idx2FSNBR) + "', 	");

					UpdateSql11.append( " TAXKIDIV = '" + rows2[ab].getString(idx2TAXKIDIV) + "', 	");
					UpdateSql11.append( " FDCODE = '" + rows2[ab].getString(idx2FDCODE) + "', 	");
					UpdateSql11.append( " WORKTYPE = '" + rows2[ab].getString(idx2WORKTYPE) + "', 	");
					UpdateSql11.append( " UPDT = '" +str2+"', 	");
					UpdateSql11.append( " UPID = '" +str3+"', 	");
					UpdateSql11.append( " SEQ = " +rows2[ab].getInt(idx2SEQ)+", 	");
					UpdateSql11.append( " GUBUN = '" +rows2[ab].getString(idx2GUBUN)+"', 	");
					UpdateSql11.append( " AMEND_CODE  = '" +rows2[ab].getString(idx2AMEND_CODE)+"', 	");
					UpdateSql11.append( " AMEND_REMARK= '" +rows2[ab].getString(idx2AMEDN_REMARK)+"', 	");
					UpdateSql11.append( " EXTCHK= '" +rows2[ab].getString(idx2EXTCHK)+"', 	");
					UpdateSql11.append( " REMARK2= '" +rows2[ab].getString(idx2REMARK2)+"', ");
					UpdateSql11.append( " REMARK3= '" +rows2[ab].getString(idx2REMARK3)+"', ");
					UpdateSql11.append( " S_BIZPLACE= '" +rows2[ab].getString(idx2S_BIZPLACE)+"' 	");
	
					UpdateSql11.append( " WHERE TAXNBR = '" + rows2[ab].getString(idx2TAXNBR) + "' 	");

					//logger.dbg.println(this,"UpdateSql11.toString():::"+UpdateSql11.toString());
									
					GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql11.toString());

					//2010.10.22 jys 적요 세미콜론 입력가능하게함.
					gsmt2.setGauceDataRow(rows2[ab]);
					gsmt2.bindColumn(1, idx2REMARK);
						
					gsmt2.executeUpdate();
					gsmt2.close();
				} // for (int ab = 0; ab < rows6.length; ab++){	
		 }//		 if (userSet6 != null) { //null체크
     
		 /************************************************************************************
		 자산 End
		*************************************************************************************/

		/************************************************************************************
			 @세금계산서 자산 수정
		*************************************************************************************/
    
		 GauceDataSet userSet6 = reqGauce.getGauceDataSet("USER6"); //두번째 데이타셋 넘김
		 if (userSet6 != null) { //null체크
			 	int idx6FDCODE   = userSet6.indexOfColumn("FDCODE");
				int idx6ATCODE   = userSet6.indexOfColumn("ATCODE");
				int idx6AST1ST   = userSet6.indexOfColumn("AST1ST");
				int idx6AST2ND   = userSet6.indexOfColumn("AST2ND");
				int idx6AST3RD   = userSet6.indexOfColumn("AST3RD");
				int idx6ASTSEQ   = userSet6.indexOfColumn("ASTSEQ");

				GauceDataRow[] rows6 = userSet6.getDataRows();

				for (int ab = 0; ab < rows6.length; ab++){			

					StringBuffer UpdateSql22 = null;
					UpdateSql22 = new StringBuffer();
					UpdateSql22.append( " UPDATE ACCOUNT.ASTMST SET " );
					UpdateSql22.append( " TAXNBR = 'A"+taxch+"' " );
					UpdateSql22.append( " WHERE FDCODE = '" + rows6[ab].getString(idx6FDCODE) + "' 	");
					UpdateSql22.append( " AND ATCODE =  '" + rows6[ab].getString(idx6ATCODE) + "'	");
					UpdateSql22.append( " AND AST1ST = '" + rows6[ab].getString(idx6AST1ST) + "' 	");
					UpdateSql22.append( " AND AST2ND = '" + rows6[ab].getString(idx6AST2ND) + "' 	");
					UpdateSql22.append( " AND AST3RD = '" + rows6[ab].getString(idx6AST3RD) + "' 	");
					UpdateSql22.append( " AND ASTSEQ = '" + rows6[ab].getString(idx6ASTSEQ) + "' 	");     
						
					GauceStatement gsmt6 = conn.getGauceStatement(UpdateSql22.toString());
						
					gsmt6.executeUpdate();
					gsmt6.close();
				} // for (int ab = 0; ab < rows6.length; ab++){	
		 }//		 if (userSet6 != null) { //null체크
     
		 /************************************************************************************
		 자산 End
		*************************************************************************************/
			}//Try
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
	} //
}//


