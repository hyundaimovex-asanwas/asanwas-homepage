package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400310_t3 extends HttpServlet{
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
	 		
	 		Double dblAp_m_sid = 0.0;  //관리자ID
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);  //Transaction 
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//신청번호
				
				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");
				
				int idxAP_M_SID           = userSet.indexOfColumn("AP_M_SID");
				int idxDOC_SID            = userSet.indexOfColumn("DOC_SID");
				int idxDOC_GU             = userSet.indexOfColumn("DOC_GU");
				int idxDOC_GU2            = userSet.indexOfColumn("DOC_GU2");
				int idxAP_STATUS_M        = userSet.indexOfColumn("AP_STATUS_M");
				int idxL_EMPNO            = userSet.indexOfColumn("L_EMPNO");
				int idxI_EMPNO            = userSet.indexOfColumn("I_EMPNO");
				int idxI_DATE             = userSet.indexOfColumn("I_DATE");
				int idxI_IP               = userSet.indexOfColumn("I_IP");
				int idxU_EMPNO            = userSet.indexOfColumn("U_EMPNO");
				int idxU_DATE             = userSet.indexOfColumn("U_DATE");
				int idxU_IP               = userSet.indexOfColumn("U_IP");
				int idxNUM_PARAM1         = userSet.indexOfColumn("NUM_PARAM1");
				int idxNUM_PARAM2         = userSet.indexOfColumn("NUM_PARAM2");
				int idxNUM_PARAM3         = userSet.indexOfColumn("NUM_PARAM3");
				int idxNUM_PARAM4         = userSet.indexOfColumn("NUM_PARAM4");
				int idxNUM_PARAM5         = userSet.indexOfColumn("NUM_PARAM5");
				int idxCH_PARAM1          = userSet.indexOfColumn("CH_PARAM1");
				int idxCH_PARAM2          = userSet.indexOfColumn("CH_PARAM2");
				int idxCH_PARAM3          = userSet.indexOfColumn("CH_PARAM3");

				int idx2AP_SID            = userSet2.indexOfColumn("AP_SID");
				int idx2AP_M_SID          = userSet2.indexOfColumn("AP_M_SID");
				int idx2AP_GU             = userSet2.indexOfColumn("AP_GU");
				int idx2AP_SEQ            = userSet2.indexOfColumn("AP_SEQ");
				int idx2AP_TYPE           = userSet2.indexOfColumn("AP_TYPE");
				int idx2AP_STATUS_D       = userSet2.indexOfColumn("AP_STATUS_D");
				int idx2AP_EMPNO          = userSet2.indexOfColumn("AP_EMPNO");
				int idx2AP_REAL_EMPNO     = userSet2.indexOfColumn("AP_REAL_EMPNO");
				int idx2AP_DESC           = userSet2.indexOfColumn("AP_DESC");
				int idx2I_EMPNO           = userSet2.indexOfColumn("I_EMPNO");
				int idx2I_DATE            = userSet2.indexOfColumn("I_DATE");
				int idx2I_IP              = userSet2.indexOfColumn("I_IP");
				int idx2U_EMPNO           = userSet2.indexOfColumn("U_EMPNO");
				int idx2U_DATE            = userSet2.indexOfColumn("U_DATE");
				int idx2U_IP              = userSet2.indexOfColumn("U_IP");
				int idx2AP_JOBNM          = userSet2.indexOfColumn("AP_JOBNM");
				int idx2AP_DPTNM          = userSet2.indexOfColumn("AP_DPTNM");
				
				int idx3APPNO             = userSet3.indexOfColumn("APPNO");
				int idx3AP_M_SID          = userSet3.indexOfColumn("AP_M_SID");
				
				
				GauceDataRow[] rows  = userSet.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();
				GauceDataRow[] rows3 = userSet3.getDataRows();

				StringBuffer InsertSql   = null;
				StringBuffer InsertSql2  = null;
				StringBuffer UpdateSql3  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO COMMON.APPROVE_MASTER  (                     \n" );
				InsertSql.append( " AP_M_SID,  DOC_SID,   DOC_GU,    DOC_GU2,   AP_STATUS_M,  \n" );
				InsertSql.append( " L_EMPNO,   I_EMPNO,   I_DATE,    I_IP,                    \n" );
				InsertSql.append( " NUM_PARAM1,NUM_PARAM2,NUM_PARAM3, NUM_PARAM4,NUM_PARAM5,  \n" );
				InsertSql.append( " CH_PARAM1, CH_PARAM2, CH_PARAM3      \n" );
				InsertSql.append( " )VALUES (                            \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,CURRENT_TIMESTAMP,?,             \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,?                                \n" );
				InsertSql.append( " )                                    \n" );
				
				GauceStatement gsmt2= null;
				
				//insert statement
				InsertSql2 = new StringBuffer();
				InsertSql2.append( " INSERT INTO COMMON.APPROVE_DETAIL  (                      \n" );
				InsertSql2.append( " AP_SID,      AP_M_SID,  AP_GU,         AP_SEQ,   AP_TYPE, \n" );
				InsertSql2.append( " AP_STATUS_D, AP_EMPNO,  AP_REAL_EMPNO, AP_DESC,  I_EMPNO, \n" );
				InsertSql2.append( " I_DATE,      I_IP,      AP_JOBNM,      AP_DPTNM           \n" );
				InsertSql2.append( " )VALUES (                                                 \n" );
				InsertSql2.append( " COMMON.SWS_APPROVE_DETAIL_ID.NEXTVAL,?,?,?,?,             \n" );
				InsertSql2.append( " ?,?,?,?,?,                                                \n" );
				InsertSql2.append( " CURRENT_TIMESTAMP,?,?,?                                   \n" );
				InsertSql2.append( " )                                                         \n" );
							
				GauceStatement gsmt3= null;
				
				//insert statement
				UpdateSql3 = new StringBuffer();
				UpdateSql3.append( " UPDATE ACCOUNT.ACAPPFUND SET   \n" );
				UpdateSql3.append( "        AP_M_SID =?             \n" );
				UpdateSql3.append( "       ,UPID = '"+str1+"'		\n");
				UpdateSql3.append( "       ,UPDT =CURRENT_TIMESTAMP	\n");
				UpdateSql3.append( "  WHERE APPNO =?                \n" );	
				
				for (int j = 0; j < rows.length; j++){	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						//채번시작/////////////////////////////////////////////////////////////////
						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( "  SELECT COMMON.SWS_APPROVE_MASTER_ID.NEXTVAL FROM DUAL "); 
 						
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							dblAp_m_sid= rs0.getDouble(1);
						}
						rs0.close();
						stmt0.close();
						
						rows[j].setDouble(idxAP_M_SID,dblAp_m_sid);
						//채번완료/////////////////////////////////////////////////////////////////
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAP_M_SID);
						gsmt.bindColumn(2, idxDOC_SID);
						gsmt.bindColumn(3, idxDOC_GU);
						gsmt.bindColumn(4, idxDOC_GU2);
						gsmt.bindColumn(5, idxAP_STATUS_M);
						gsmt.bindColumn(6, idxL_EMPNO);
						gsmt.bindColumn(7, idxI_EMPNO);
						gsmt.bindColumn(8, idxI_IP);
						gsmt.bindColumn(9, idxNUM_PARAM1);
						gsmt.bindColumn(10,idxNUM_PARAM2);
						gsmt.bindColumn(11,idxNUM_PARAM3);
						gsmt.bindColumn(12,idxNUM_PARAM4);
						gsmt.bindColumn(13,idxNUM_PARAM5);
						gsmt.bindColumn(14,idxCH_PARAM1);
						gsmt.bindColumn(15,idxCH_PARAM2);
						gsmt.bindColumn(16,idxCH_PARAM3);
							
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
				   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
				   }//if
				}//for	
				
				for (int i = 0; i < rows2.length; i++){	
					if(rows2[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						rows2[i].setDouble(idx2AP_M_SID,dblAp_m_sid);
												
						gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						
						gsmt2.setGauceDataRow(rows2[i]);
						gsmt2.bindColumn(1, idx2AP_M_SID);
						gsmt2.bindColumn(2, idx2AP_GU);
						gsmt2.bindColumn(3, idx2AP_SEQ);
						gsmt2.bindColumn(4, idx2AP_TYPE);
						gsmt2.bindColumn(5, idx2AP_STATUS_D);
						gsmt2.bindColumn(6, idx2AP_EMPNO);
						gsmt2.bindColumn(7, idx2AP_REAL_EMPNO);
						gsmt2.bindColumn(8, idx2AP_DESC);
						gsmt2.bindColumn(9, idx2I_EMPNO);
						gsmt2.bindColumn(10,idx2I_IP);
						gsmt2.bindColumn(11,idx2AP_JOBNM);
						gsmt2.bindColumn(12,idx2AP_DPTNM);
							
						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt2 = null;
						
					}
				}//for i 
				
				
				for (int k = 0; k < rows3.length; k++){	
					if(rows3[k].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						rows3[k].setDouble(idx3AP_M_SID,dblAp_m_sid);
						
						gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
						gsmt3.setGauceDataRow(rows3[k]);
						gsmt3.bindColumn(1, idx3AP_M_SID);
						gsmt3.bindColumn(2, idx3APPNO);
							
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3 = null;
						
					}
				}//for i 
				
				GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");
				
				if (userSet4 != null) {
					
					resGauce.enableFirstRow(userSet4);
					userSet4.addDataColumn(new GauceDataColumn("AP_M_SID", GauceDataColumn.TB_DECIMAL,10));
         
					GauceDataRow row4 = null;
					row4 = userSet4.newDataRow();
					row4.addColumnValue(dblAp_m_sid);
					userSet4.addDataRow(row4);
					userSet4.flush();
					
				}
				
				
			}//inner try
			catch(Exception e){
				System.out.println("ERROR000::"+e);
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}//outer try
		catch (Exception e) {
			
			System.out.println("ERROR::"+e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}//public void
	
}//classes