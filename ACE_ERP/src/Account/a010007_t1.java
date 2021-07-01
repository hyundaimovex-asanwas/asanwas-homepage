package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010007_t1 extends HttpServlet{
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

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1"); // 테이블 구분

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxVEND_CD    		 = userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM         = userSet.indexOfColumn("VEND_NM");
				int idxVEND_ID         = userSet.indexOfColumn("VEND_ID");
				int idxVEND_NO         = userSet.indexOfColumn("VEND_NO");
				int idxVD_DIRECT  		 = userSet.indexOfColumn("VD_DIRECT");
				int idxBSNS_CND        = userSet.indexOfColumn("BSNS_CND");
				int idxBSNS_KND        = userSet.indexOfColumn("BSNS_KND");
				int idxVD_TELNO        = userSet.indexOfColumn("VD_TELNO");
				int idxVD_FAXNO   		 = userSet.indexOfColumn("VD_FAXNO");
				int idxPOST_NO1        = userSet.indexOfColumn("POST_NO1");
				int idxPOST_NO2        = userSet.indexOfColumn("POST_NO2");
				int idxADDRESS1        = userSet.indexOfColumn("ADDRESS1");
				int idxADDRESS2   		 = userSet.indexOfColumn("ADDRESS2");
				int idxC_BANKCD        = userSet.indexOfColumn("C_BANKCD");
				int idxC_ACCTNO        = userSet.indexOfColumn("C_ACCTNO");
				int idxC_ACCTNO_NM     = userSet.indexOfColumn("C_ACCTNO_NM");
				int idxC_ACCTNM   		 = userSet.indexOfColumn("C_ACCTNM");
				int idxB_BANKCD        = userSet.indexOfColumn("B_BANKCD");
				int idxB_ACCTNO        = userSet.indexOfColumn("B_ACCTNO");
				int idxB_ACCTNO_NM     = userSet.indexOfColumn("B_ACCTNO_NM");
				int idxB_ACCTNM   		 = userSet.indexOfColumn("B_ACCTNM");
				int idxO_VENDGB        = userSet.indexOfColumn("O_VENDGB");
				int idxO_VENDCD        = userSet.indexOfColumn("O_VENDCD");
				int idxVEND_MAG        = userSet.indexOfColumn("VEND_MAG");
				int idxUSE_TAG    		 = userSet.indexOfColumn("USE_TAG");
				int idxREMARK          = userSet.indexOfColumn("REMARK");
				int idxCREAT_DT        = userSet.indexOfColumn("CREAT_DT");
				int idxCREAT_NM        = userSet.indexOfColumn("CREAT_NM");
				int idxMSN        		 = userSet.indexOfColumn("MSN");
				int idxMPWD            = userSet.indexOfColumn("MPWD");
				int idxCOCOMYN         = userSet.indexOfColumn("COCOMYN");

        String strTB_GCZM_VEND="";

				if(str1.equals("1")){
					strTB_GCZM_VEND="GCZM_VENDER_ALL";             			//통합
				}else if(str1.equals("2")){
					strTB_GCZM_VEND="GCZM_VENDER";                 			//서울
				}else if(str1.equals("3")){
					strTB_GCZM_VEND="GCZM_VENDER_KUMGANG";         		//금강산
				}else if(str1.equals("4")){
					strTB_GCZM_VEND="GCZM_VENDER_KAESONG";         		//개성			
				}else if(str1.equals("5")){
					strTB_GCZM_VEND="GCZM_VENDER_KAESONG_080220";  //개성080222 		
				}else if(str1.equals("6")){
					strTB_GCZM_VEND="GCZM_VENDER_KAESONG080718";   //개성080718 	
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT."+strTB_GCZM_VEND+"( 											\n");
				InsertSql.append( " VEND_CD,     VEND_NM,    VEND_ID,    VEND_NO,    VD_DIRECT,  					\n");
				InsertSql.append( " BSNS_CND,    BSNS_KND,   VD_TELNO,   VD_FAXNO,   POST_NO1,  			\n");
				InsertSql.append( " POST_NO2,    ADDRESS1,   ADDRESS2,   C_BANKCD,   C_ACCTNO,   			\n");
				InsertSql.append( " C_ACCTNO_NM, C_ACCTNM,   B_BANKCD,   B_ACCTNO,   B_ACCTNO_NM,	\n");
				InsertSql.append( " B_ACCTNM,    O_VENDGB,   O_VENDCD,   VEND_MAG,   USE_TAG,   		 	\n");
				InsertSql.append( " REMARK,      CREAT_DT,   CREAT_NM,   MSN,        MPWD,       					\n");
				InsertSql.append( " COCOMYN                                                      										\n");
				InsertSql.append( "  ) 																										\n");
				InsertSql.append( "  VALUES 																								\n");
				InsertSql.append( " ( 																										\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ? ) 																										\n");

				// logger.dbg.println(this,InsertSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxVEND_CD);
						gsmt.bindColumn(2,idxVEND_NM);
						gsmt.bindColumn(3,idxVEND_ID);
						gsmt.bindColumn(4,idxVEND_NO);
						gsmt.bindColumn(5,idxVD_DIRECT);
						gsmt.bindColumn(6,idxBSNS_CND);
						gsmt.bindColumn(7,idxBSNS_KND);
						gsmt.bindColumn(8,idxVD_TELNO);
						gsmt.bindColumn(9,idxVD_FAXNO);
						gsmt.bindColumn(10,idxPOST_NO1);
						gsmt.bindColumn(11,idxPOST_NO2);
						gsmt.bindColumn(12,idxADDRESS1);
						gsmt.bindColumn(13,idxADDRESS2);
						gsmt.bindColumn(14,idxC_BANKCD);
						gsmt.bindColumn(15,idxC_ACCTNO);
						gsmt.bindColumn(16,idxC_ACCTNO_NM);
						gsmt.bindColumn(17,idxC_ACCTNM);
						gsmt.bindColumn(18,idxB_BANKCD);
						gsmt.bindColumn(19,idxB_ACCTNO);
						gsmt.bindColumn(20,idxB_ACCTNO_NM);
						gsmt.bindColumn(21,idxB_ACCTNM);
						gsmt.bindColumn(22,idxO_VENDGB);
						gsmt.bindColumn(23,idxO_VENDCD);
						gsmt.bindColumn(24,idxVEND_MAG);
						gsmt.bindColumn(25,idxUSE_TAG);
						gsmt.bindColumn(26,idxREMARK);
						gsmt.bindColumn(27,idxCREAT_DT);
						gsmt.bindColumn(28,idxCREAT_NM);
						gsmt.bindColumn(29,idxMSN);
						gsmt.bindColumn(30,idxMPWD);
						gsmt.bindColumn(31,idxCOCOMYN);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//gsmt.setGauceDataRow(rows[j]);
						//gsmt.executeUpdate(); 
						//gsmt.close();                                             
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						//GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//gsmt.setGauceDataRow(rows[j]);
						//gsmt.executeUpdate();
						//gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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