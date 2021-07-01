package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class xat1002_t1 extends HttpServlet{

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
	 			
	 		String strJouseq = "";

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxJOUNO                 = userSet.indexOfColumn("JOUNO");
				int idxJOUSEQ                = userSet.indexOfColumn("JOUSEQ");
				int idxATCODE                = userSet.indexOfColumn("ATCODE");
				int idxATDECR                = userSet.indexOfColumn("ATDECR");
				int idxACCCHK                = userSet.indexOfColumn("ACCCHK");
				int idxCHKNAME               = userSet.indexOfColumn("CHKNAME");
				int idxVENDCD                = userSet.indexOfColumn("VENDCD");
				int idxVENDNM                = userSet.indexOfColumn("VENDNM");
				int idxFSREFCD1              = userSet.indexOfColumn("FSREFCD1");
				int idxFSREFCDNM1            = userSet.indexOfColumn("FSREFCDNM1");
				int idxFSREFVAL1             = userSet.indexOfColumn("FSREFVAL1");
				int idxFSREFVALNM1           = userSet.indexOfColumn("FSREFVALNM1");
				int idxFSREFCD2              = userSet.indexOfColumn("FSREFCD2");
				int idxFSREFCDNM2            = userSet.indexOfColumn("FSREFCDNM2");
				int idxFSREFVAL2             = userSet.indexOfColumn("FSREFVAL2");
				int idxFSREFVALNM2           = userSet.indexOfColumn("FSREFVALNM2");
				int idxFSREFCD3              = userSet.indexOfColumn("FSREFCD3");
				int idxFSREFCDNM3            = userSet.indexOfColumn("FSREFCDNM3");
				int idxFSREFVAL3             = userSet.indexOfColumn("FSREFVAL3");
				int idxFSREFVALNM3           = userSet.indexOfColumn("FSREFVALNM3");
				int idxFSREFCD4              = userSet.indexOfColumn("FSREFCD4");
				int idxFSREFCDNM4            = userSet.indexOfColumn("FSREFCDNM4");
				int idxFSREFVAL4             = userSet.indexOfColumn("FSREFVAL4");
				int idxFSREFVALNM4           = userSet.indexOfColumn("FSREFVALNM4");
				int idxFSREFCD5              = userSet.indexOfColumn("FSREFCD5");
				int idxFSREFCDNM5            = userSet.indexOfColumn("FSREFCDNM5");
				int idxFSREFVAL5             = userSet.indexOfColumn("FSREFVAL5");
				int idxFSREFVALNM5           = userSet.indexOfColumn("FSREFVALNM5");
				int idxFSREFCD6              = userSet.indexOfColumn("FSREFCD6");
				int idxFSREFCDNM6            = userSet.indexOfColumn("FSREFCDNM6");
				int idxFSREFVAL6             = userSet.indexOfColumn("FSREFVAL6");
				int idxFSREFVALNM6           = userSet.indexOfColumn("FSREFVALNM6");
				int idxFSREFCD7              = userSet.indexOfColumn("FSREFCD7");
				int idxFSREFCDNM7            = userSet.indexOfColumn("FSREFCDNM7");
				int idxFSREFVAL7             = userSet.indexOfColumn("FSREFVAL7");
				int idxFSREFVALNM7           = userSet.indexOfColumn("FSREFVALNM7");
				int idxUSEGB                 = userSet.indexOfColumn("USEGB");
				int idxENDDT                 = userSet.indexOfColumn("ENDDT");
				int idxSORTSEQ               = userSet.indexOfColumn("SORTSEQ");
				int idxCREATE_ID             = userSet.indexOfColumn("CREATE_ID");
				int idxCREATE_DATE           = userSet.indexOfColumn("CREATE_DATE");
				int idxUPDATE_ID             = userSet.indexOfColumn("UPDATE_ID");
				int idxUPDATE_DATE           = userSet.indexOfColumn("UPDATE_DATE");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append (" INSERT INTO ACCOUNT.TBIF_ACCJOU (                   \n");
				InsertSql.append (" JOUNO,	 JOUSEQ,    ATCODE,   ATDECR,   \n");
				InsertSql.append (" ACCCHK,	 CHKNAME,   VENDCD,   VENDNM,	\n");
				InsertSql.append (" FSREFCD1,FSREFCDNM1,FSREFVAL1,FSREFVALNM1,	\n");
				InsertSql.append (" FSREFCD2,FSREFCDNM2,FSREFVAL2,FSREFVALNM2,	\n");
				InsertSql.append (" FSREFCD3,FSREFCDNM3,FSREFVAL3,FSREFVALNM3,	\n");
				InsertSql.append (" FSREFCD4,FSREFCDNM4,FSREFVAL4,FSREFVALNM4,	\n");
				InsertSql.append (" FSREFCD5,FSREFCDNM5,FSREFVAL5,FSREFVALNM5,	\n");
				InsertSql.append (" FSREFCD6,FSREFCDNM6,FSREFVAL6,FSREFVALNM6,	\n");
				InsertSql.append (" FSREFCD7,FSREFCDNM7,FSREFVAL7,FSREFVALNM7,	\n");
				InsertSql.append (" USEGB,	 ENDDT,	    SORTSEQ,	            \n");
				InsertSql.append (" CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE \n");
				InsertSql.append (" ) VALUES (                                  \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,?,                                    \n");
				InsertSql.append (" ?,?,?,                                     \n");
				InsertSql.append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP )    \n");

  
				UpdateSql = new StringBuffer();
				UpdateSql.append (" UPDATE ACCOUNT.TBIF_ACCJOU SET        \n");
				UpdateSql.append ("  ATCODE = ?      \n");
				UpdateSql.append (" ,ATDECR = ?      \n");
				UpdateSql.append (" ,ACCCHK  = ?     \n");
				UpdateSql.append (" ,CHKNAME = ?     \n");
				UpdateSql.append (" ,VENDCD = ?      \n");
				UpdateSql.append (" ,VENDNM = ?      \n");
				UpdateSql.append (" ,FSREFCD1 = ?    \n");
				UpdateSql.append (" ,FSREFCDNM1 = ?  \n");
				UpdateSql.append (" ,FSREFVAL1 = ?   \n");
				UpdateSql.append (" ,FSREFVALNM1 = ? \n");
				UpdateSql.append (" ,FSREFCD2 = ?    \n");
				UpdateSql.append (" ,FSREFCDNM2 = ?  \n");
				UpdateSql.append (" ,FSREFVAL2 = ?   \n");
				UpdateSql.append (" ,FSREFVALNM2 = ? \n");
				UpdateSql.append (" ,FSREFCD3 = ?    \n");
				UpdateSql.append (" ,FSREFCDNM3 = ?  \n");
				UpdateSql.append (" ,FSREFVAL3 = ?   \n");
				UpdateSql.append (" ,FSREFVALNM3 = ? \n");
				UpdateSql.append (" ,FSREFCD4 = ?    \n");
				UpdateSql.append (" ,FSREFCDNM4 = ?  \n");
				UpdateSql.append (" ,FSREFVAL4 = ?   \n");
				UpdateSql.append (" ,FSREFVALNM4 = ? \n");
				UpdateSql.append (" ,FSREFCD5 = ?    \n");
				UpdateSql.append (" ,FSREFCDNM5 = ?  \n");
				UpdateSql.append (" ,FSREFVAL5 = ?   \n");
				UpdateSql.append (" ,FSREFVALNM5 = ? \n");
				UpdateSql.append (" ,FSREFCD6 = ?    \n");
				UpdateSql.append (" ,FSREFCDNM6 = ?  \n");
				UpdateSql.append (" ,FSREFVAL6 = ?   \n");
				UpdateSql.append (" ,FSREFVALNM6 = ? \n");
				UpdateSql.append (" ,FSREFCD7 = ?    \n");
				UpdateSql.append (" ,FSREFCDNM7 = ?  \n");
				UpdateSql.append (" ,FSREFVAL7 = ?   \n");
				UpdateSql.append (" ,FSREFVALNM7 = ? \n");
				UpdateSql.append (" ,USEGB = ?       \n");
				UpdateSql.append (" ,ENDDT = ?       \n");
				UpdateSql.append (" ,SORTSEQ = ?     \n");
				UpdateSql.append (" ,UPDATE_ID = ?                  \n");
				UpdateSql.append (" ,UPDATE_DATE=CURRENT_TIMESTAMP  \n");
				UpdateSql.append ("  WHERE JOUNO = ? \n");
				UpdateSql.append ("    AND JOUSEQ= ? \n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.TBIF_ACCJOU   \n");
				DeleteSql.append( "  WHERE JOUNO= ?					  \n");		
				DeleteSql.append( "    AND JOUSEQ= ?				  \n");		

				for (int j = 0; j < rows.length; j++){
					
					rows[j].setString(idxCREATE_ID,str1);
					rows[j].setString(idxUPDATE_ID,str1);

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						Statement stmt = conn.createStatement();
						StringBuffer sql = new StringBuffer();
						//sql.append( "  SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(FSNBR),0)+1)),6) ");
						sql.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(JOUSEQ),0))+1,2,0)  \n");
						sql.append( "	FROM ACCOUNT.TBIF_ACCJOU \n"); 
						sql.append( "  WHERE JOUNO ='"+ rows[j].getString(idxJOUNO)+"'\n"); 
						
						ResultSet rs = stmt.executeQuery(sql.toString()); 
						
						if(rs.next()){
							strJouseq= rs.getString(1);
						}
						rs.close();
						stmt.close();
						
						
						rows[j].setString(idxJOUSEQ,strJouseq);
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxJOUNO);
						gsmt.bindColumn(2,idxJOUSEQ);
						gsmt.bindColumn(3,idxATCODE);
						gsmt.bindColumn(4,idxATDECR);
						gsmt.bindColumn(5,idxACCCHK);
						gsmt.bindColumn(6,idxCHKNAME);
						gsmt.bindColumn(7,idxVENDCD);
						gsmt.bindColumn(8,idxVENDNM);
						gsmt.bindColumn(9,idxFSREFCD1);
						gsmt.bindColumn(10,idxFSREFCDNM1);
						gsmt.bindColumn(11,idxFSREFVAL1);
						gsmt.bindColumn(12,idxFSREFVALNM1);
						gsmt.bindColumn(13,idxFSREFCD2);
						gsmt.bindColumn(14,idxFSREFCDNM2);
						gsmt.bindColumn(15,idxFSREFVAL2);
						gsmt.bindColumn(16,idxFSREFVALNM2);
						gsmt.bindColumn(17,idxFSREFCD3);
						gsmt.bindColumn(18,idxFSREFCDNM3);
						gsmt.bindColumn(19,idxFSREFVAL3);
						gsmt.bindColumn(20,idxFSREFVALNM3);
						gsmt.bindColumn(21,idxFSREFCD4);
						gsmt.bindColumn(22,idxFSREFCDNM4);
						gsmt.bindColumn(23,idxFSREFVAL4);
						gsmt.bindColumn(24,idxFSREFVALNM4);
						gsmt.bindColumn(25,idxFSREFCD5);
						gsmt.bindColumn(26,idxFSREFCDNM5);
						gsmt.bindColumn(27,idxFSREFVAL5);
						gsmt.bindColumn(28,idxFSREFVALNM5);
						gsmt.bindColumn(29,idxFSREFCD6);
						gsmt.bindColumn(30,idxFSREFCDNM6);
						gsmt.bindColumn(31,idxFSREFVAL6);
						gsmt.bindColumn(32,idxFSREFVALNM6);
						gsmt.bindColumn(33,idxFSREFCD7);
						gsmt.bindColumn(34,idxFSREFCDNM7);
						gsmt.bindColumn(35,idxFSREFVAL7);
						gsmt.bindColumn(36,idxFSREFVALNM7);
						gsmt.bindColumn(37,idxUSEGB);
						gsmt.bindColumn(38,idxENDDT);
						gsmt.bindColumn(39,idxSORTSEQ);
						gsmt.bindColumn(40,idxCREATE_ID);
						gsmt.bindColumn(41,idxUPDATE_ID);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxATCODE);
						gsmt.bindColumn(2,idxATDECR);
						gsmt.bindColumn(3,idxACCCHK);
						gsmt.bindColumn(4,idxCHKNAME);
						gsmt.bindColumn(5,idxVENDCD);
						gsmt.bindColumn(6,idxVENDNM);
						gsmt.bindColumn(7,idxFSREFCD1);
						gsmt.bindColumn(8,idxFSREFCDNM1);
						gsmt.bindColumn(9,idxFSREFVAL1);
						gsmt.bindColumn(10,idxFSREFVALNM1);
						gsmt.bindColumn(11,idxFSREFCD2);
						gsmt.bindColumn(12,idxFSREFCDNM2);
						gsmt.bindColumn(13,idxFSREFVAL2);
						gsmt.bindColumn(14,idxFSREFVALNM2);
						gsmt.bindColumn(15,idxFSREFCD3);
						gsmt.bindColumn(16,idxFSREFCDNM3);
						gsmt.bindColumn(17,idxFSREFVAL3);
						gsmt.bindColumn(18,idxFSREFVALNM3);
						gsmt.bindColumn(19,idxFSREFCD4);
						gsmt.bindColumn(20,idxFSREFCDNM4);
						gsmt.bindColumn(21,idxFSREFVAL4);
						gsmt.bindColumn(22,idxFSREFVALNM4);
						gsmt.bindColumn(23,idxFSREFCD5);
						gsmt.bindColumn(24,idxFSREFCDNM5);
						gsmt.bindColumn(25,idxFSREFVAL5);
						gsmt.bindColumn(26,idxFSREFVALNM5);
						gsmt.bindColumn(27,idxFSREFCD6);
						gsmt.bindColumn(28,idxFSREFCDNM6);
						gsmt.bindColumn(29,idxFSREFVAL6);
						gsmt.bindColumn(30,idxFSREFVALNM6);
						gsmt.bindColumn(31,idxFSREFCD7);
						gsmt.bindColumn(32,idxFSREFCDNM7);
						gsmt.bindColumn(33,idxFSREFVAL7);
						gsmt.bindColumn(34,idxFSREFVALNM7);
						gsmt.bindColumn(35,idxUSEGB);
						gsmt.bindColumn(36,idxENDDT);
						gsmt.bindColumn(37,idxSORTSEQ);
						gsmt.bindColumn(38,idxUPDATE_ID);
						gsmt.bindColumn(39,idxJOUNO);
						gsmt.bindColumn(40,idxJOUSEQ);
						
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxJOUNO);
						gsmt.bindColumn(2,idxJOUSEQ);
						gsmt.executeUpdate();
						gsmt.close();
					}
					
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				
				System.out.println(" xat1002_t1 err:::::::::::::"+e);
			}

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