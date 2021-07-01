package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trLoadLst3_batch extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 
				int idxETD_DATE       =userSet.indexOfColumn("ETD_DATE");
				int idxLINE_PART      =userSet.indexOfColumn("LINE_PART");
				int idxGUSER          =userSet.indexOfColumn("GUSER");

				String strUser="";
				String strLine_Part="";

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer sql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						//상차예정정보
						InsertSql = new StringBuffer();

						strUser = rows[j].getString(idxGUSER);
						strLine_Part = rows[j].getString(idxLINE_PART);
            if(strLine_Part==null)strLine_Part="";

						InsertSql.append(" INSERT INTO TRANSFER.LTLOADLST (                                 \n ")
						         .append("		CAR_SEQ_NO,   ORDER_NO,   ORDER_SEQ,  ARTC_CNT,   PUNIT_CNT,  \n ")
							       .append("		PUNIT_WEIGHT, PKG_LNGTH,  PKG_HEIGHT, PKG_WIDTH,  TOTAL_CBM,  \n ")
										 .append("		TOTAL_WEIGHT, STS_CODE,   UPEND_DT,   UPEND_TIME, REMARK,     \n ")
							       .append("		BAECHA_NO,    ENTER_NO,   CAR_NO,     CREATE_DT,  CREATE_USR, \n ")
							       .append("		UPDATE_DT,    UPDATE_UST, PKG_CNT,    EDT_DATE,   EDI_STS    	\n ")
							       .append("	)                                                              	\n ")
										 .append("	SELECT I.CAR_SEQ_NO,   A.ORDER_NO,  A.ORDER_SEQ,  A.ARTC_CNT,  A.PUNIT_CNT,         	\n ")
							       .append("	       A.PUNIT_WEIGHT, A.PKG_LNGTH, A.PKG_HEIGHT, A.PKG_WIDTH, A.TOTAL_CBM,         	\n ")
							       .append("	       A.TOTAL_WEIGHT, ''STS_CODE, ''UPEND_DT,   ''UPEND_TIME, ''REMARK,             	\n ")
							       .append("	       J.BAECHA_NO,     A.ENTER_NO, J.CAR_NO,     CURRENT TIMESTAMP AS CREATE_DT,    	\n ")
										 .append("	       '"+strUser+"' AS CREATE_USR, CURRENT TIMESTAMP AS UPDATE_DT,                 	\n ")
							       .append("	       '"+strUser+"' AS UPDATE_UST, I.PKG_CNT, B.ETD_DT EDT_DATE, ''EDI_STS         	\n ")
							       .append("	  FROM TRANSFER.LTINWRHS A                                                                       	\n ")
							       .append("	  LEFT JOIN TRANSFER.LTORDERDTL B ON A.ORDER_NO = B.ORDER_NO AND A.ORDER_SEQ = B.ORDER_SEQ       	\n ")
										 .append("	  LEFT JOIN TRANSFER.LTORDERMST C ON A.ORDER_NO = C.ORDER_NO                                     	\n ")
							       .append("	  LEFT JOIN TRANSFER.LTCARGOODS I ON A.ORDER_NO = I.ORDER_NO AND A.ORDER_SEQ = I.ORDER_SEQ       	\n ")
							       .append("	  LEFT JOIN TRANSFER.LTCARACC J ON I.CAR_SEQ_NO = J.CAR_SEQ_NO AND J.ACCSECTION='O',             	\n ")
							       .append("	   (SELECT I.ORDER_NO, I.ORDER_SEQ, COUNT(*) CNT                                                 	\n ")
										 .append("	      FROM TRANSFER.LTCARGOODS I                                                                 	\n ")
							       .append("	      LEFT JOIN TRANSFER.LTORDERDTL B ON I.ORDER_NO = B.ORDER_NO AND I.ORDER_SEQ = B.ORDER_SEQ   	\n ")
							       .append("	     WHERE B.ETD_DT = '"+rows[j].getString(idxETD_DATE)+"'                                       	\n ")
							       .append("	     GROUP BY I.ORDER_NO, I.ORDER_SEQ                                                            	\n ")
										 .append("	    HAVING COUNT(*)=1 ) W                                                                        	\n ")
							       .append("	WHERE A.ORDER_NO = W.ORDER_NO AND A.ORDER_SEQ = W.ORDER_SEQ                                                                     	\n ")
										 .append("	  AND A.ENTER_STS NOT IN ('99','88')                                                             	\n ")
							       .append("	  AND B.ETD_DT= '"+rows[j].getString(idxETD_DATE)+"'                                            	\n ");
						if(!strLine_Part.equals(""))InsertSql.append( " AND C.LINE_PART= '" + strLine_Part + "' \n "   ); 	  
            InsertSql.append("    AND C.DLVL_TYPE= '0002' \n "   ); 	   //2008.10.31 JYS 공장상차도만 임으로 저장함.
						InsertSql.append("	UNION ALL                                                                                      	\n ")
							       .append("	SELECT I.CAR_SEQ_NO, A.ORDER_NO,   A.ORDER_SEQ,  I.ARTC_CNT,  B.PUNIT_CNT,                      \n ")
										 .append("	       B.PUNIT_WGHT, B.PKG_LNGTH,  B.PKG_HEIGHT, B.PKG_WIDTH, I.PKG_CBM AS TOTAL_CBM,           \n ")
							       .append("	       I.PKG_WGHT AS TOTAL_WEIGHT, ''STS_CODE,   ''UPEND_DT,  ''UPEND_TIME, ''REMARK,           \n ")
										 .append("	       J.BAECHA_NO,  A.ENTER_NO,   J.CAR_NO,  CURRENT TIMESTAMP AS CREATE_DT,                   \n ")
							       .append("	       '"+strUser+"' AS CREATE_USR, CURRENT TIMESTAMP AS UPDATE_DT,                             \n ")
										 .append("	       '"+strUser+"' AS UPDATE_UST, I.PKG_CNT,   B.ETD_DT EDT_DATE, ''EDI_STS                   \n ")
							       .append("	  FROM TRANSFER.LTINWRHS A                                                                     	\n ")
										 .append("	  LEFT JOIN TRANSFER.LTORDERDTL B ON A.ORDER_NO = B.ORDER_NO AND A.ORDER_SEQ = B.ORDER_SEQ     	\n ")
							       .append("	  LEFT JOIN TRANSFER.LTORDERMST C ON A.ORDER_NO = C.ORDER_NO                                   	\n ")
										 .append("	  LEFT JOIN TRANSFER.LTCARGOODS I ON A.ORDER_NO = I.ORDER_NO AND A.ORDER_SEQ = I.ORDER_SEQ     	\n ")
							       .append("	  LEFT JOIN TRANSFER.LTCARACC J ON I.CAR_SEQ_NO = J.CAR_SEQ_NO AND J.ACCSECTION='O',           	\n ")
										 .append("	   (SELECT I.ORDER_NO, I.ORDER_SEQ, COUNT(*) CNT                                               	\n ")
							       .append("	      FROM TRANSFER.LTCARGOODS I                                                               	\n ")
										 .append("	      LEFT JOIN TRANSFER.LTORDERDTL B ON I.ORDER_NO = B.ORDER_NO AND I.ORDER_SEQ = B.ORDER_SEQ 	\n ")
							       .append("	     WHERE B.ETD_DT = '"+rows[j].getString(idxETD_DATE)+"'                                      \n ")
										 .append("	     GROUP BY I.ORDER_NO, I.ORDER_SEQ                                                          	\n ")
							       .append("	    HAVING COUNT(*)>1 ) W                                                                      	\n ")
										 .append("	WHERE A.ORDER_NO = W.ORDER_NO AND A.ORDER_SEQ = W.ORDER_SEQ                                     \n ")
							       .append("	  AND A.ENTER_STS NOT IN ('99','88')                                                           	\n ")
										 .append("	  AND B.ETD_DT= '"+rows[j].getString(idxETD_DATE)+"'                                            \n ");
						if(!strLine_Part.equals(""))InsertSql.append( " AND C.LINE_PART= '" + strLine_Part + "'  \n " ); 	  
					  InsertSql.append("    AND C.DLVL_TYPE= '0002' \n "   ); 	   //2008.10.31 JYS 공장상차도만 임으로 저장함.

						logger.dbg.println(this,InsertSql.toString());

						GauceStatement gstmt = null;
						gstmt = conn.getGauceStatement(InsertSql.toString());
						gstmt.executeUpdate();
						gstmt.close();
            
            //SELECT 해서 ORDER_NO 가져와와서 건별로 UPDATE 함.
						sql = new StringBuffer();
						sql.append(" SELECT A.ORDER_NO, A.ORDER_SEQ                                           \n")
							 .append("   FROM TRANSFER.LTINWRHS A, TRANSFER.LTORDERMST C, TRANSFER.LTORDERDTL B \n")
               .append("  WHERE A.ORDER_NO =B.ORDER_NO                                            \n")
							 .append("    AND A.ORDER_SEQ = B.ORDER_SEQ                                         \n")
							 .append("    AND A.ORDER_NO = C.ORDER_NO                                           \n")
							 .append("    AND A.ENTER_STS NOT IN ('99','88')                                    \n")
               .append("    AND B.ETD_DT='"+rows[j].getString(idxETD_DATE)+"'                     \n");
						if(!strLine_Part.equals(""))sql.append( " AND C.LINE_PART= '" + strLine_Part + "' \n"   );
            sql.append("    AND C.DLVL_TYPE= '0002' \n "   ); 	   //2008.10.31 JYS 공장상차도만 

						Statement stmt = null;
						ResultSet rs = null;
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						            
						while (rs.next())	{
							UpdateSql = new StringBuffer();
							UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS ='99'  \n")
											 .append("	WHERE ORDER_NO	= '"+rs.getString(1)+"' \n")
											 .append("		AND ORDER_SEQ	= '"+rs.getString(2)+"' \n");
							
							logger.dbg.println(this,UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());							
							gsmt.executeUpdate(); 
							gsmt = null;
							UpdateSql=null;
            }
						stmt.close();
						rs.close();

					}
				}
			}
			catch(SQLException se){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (gsmt != null) {	try {	gsmt.close();	}	catch (Exception e) {}}
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}