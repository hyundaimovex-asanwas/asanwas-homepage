package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040075_t3 extends HttpServlet{
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

				GauceStatement gsmt=null;
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String strEmpno = reqGauce.getParameter("v_str1");     //사번
				String strRegno = reqGauce.getParameter("v_str2");     //사업자 등록번호
				
				int idxCONVERSATION_ID     = userSet.indexOfColumn("CONVERSATION_ID");     //공급자사업자ID + 공급받는자 사업자ID + 세금계산서일자 + 일련번호+003
				int idxSUPBUY_TYPE         = userSet.indexOfColumn("SUPBUY_TYPE");         //매입매출 구분  AP-매입, AR-매출
				int idxDIRECTION           = userSet.indexOfColumn("DIRECTION");           //정/역 구분   2- 정발행 1- 역발행
				int idxDTI_WDATE           = userSet.indexOfColumn("DTI_WDATE");           //계산서일자 ( FORMAT ####-##-##) 

				String strTaxnbr="";
				String strSeq="";
				String strTaxdat ="";

				String strID="";
				String strPW="";
 				long lng_Interface_Batch_id = 0;
				
				GauceDataRow[] rows = userSet.getDataRows();


				//TAXNBR 생성
				StringBuffer sql = null;
				Statement stmt = null;
				ResultSet rs = null;


				//SMART BILL ID PW
				StringBuffer sql9 = null;
				Statement stmt9 = null;
				ResultSet rs9 = null;
        
				//MAIN
				StringBuffer InsertSql = null;
				//StringBuffer UpdateSql = null;
				//StringBuffer DeleteSql = null;

				//ITEM
				StringBuffer InsertSql2 = null;
				//StringBuffer UpdateSql2 = null;
				//StringBuffer DeleteSql2 = null;

				//STATUS
				//StringBuffer InsertSql3 = null;
				StringBuffer UpdateSql3 = null;
				//StringBuffer DeleteSql3 = null;

				StringBuffer sql0 = null;
				Statement stmt0 = null;
				ResultSet rs0 = null;

				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						//역매출은 1건만 실행 됨.

						//TAXNBR 생성 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//서울 매출건에 대한 계산서번호 생성 	

						strTaxdat = rows[j].getString(idxDTI_WDATE);
						strTaxdat = "A"+strTaxdat.substring(0,4)+strTaxdat.substring(5,7); 	

						sql = new StringBuffer();					
						sql.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(SUBSTR(A.TAXNBR,8,11)),0))+1,4,0)           \n" ); 
						sql.append( "   FROM ACCOUNT.ATTAXMST A, ACCOUNT.ATTAXDTL B                             \n" ); 
						sql.append( "  WHERE A.TAXNBR = B.TAXNBR                                                \n" ); 
						sql.append( "    AND SUBSTR(A.TAXNBR,1,7) = '"+strTaxdat+"'                             \n" );   	

						stmt = conn.createStatement();  	
						rs = stmt.executeQuery(sql.toString());

						while(rs.next()){         
							strSeq  = rs.getString(1);  //seq 생성
						}
						rs.close();
						stmt.close();

						strTaxnbr = strTaxdat+strSeq; //TAXNBR
 			
						///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

						//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  
						// JYS : 2009.10.12
						// 정발행 매입관련해서 수신 승인시 자동으로 데이터 INSERT 처리 안함.
						// - 사용자들이 수신 승인 후 다시 매입세금계산서 입력하는 경우가 발생함.
						// - 수신승인자와 전표작성자가 틀려서 이중으로 매입세금계산서 발생함.
						// - 자동생성시 ATTAXMST의 적요는 자동 입력이 되지 않는 불편함이 있음.
						//세금계산서 MST 
						//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  

						//전자세금계산서 STATUS //UPDATE 변경 -- I
						UpdateSql3 = new StringBuffer();
						UpdateSql3.append( " UPDATE HDASAN_EDI.XXSB_DTI_STATUS SET   	\n" );
						UpdateSql3.append( " 				DTI_STATUS ='I'                  			\n" );
						UpdateSql3.append( "  WHERE CONVERSATION_ID=?                			\n" );
						UpdateSql3.append( "    AND SUPBUY_TYPE=?                    				\n" );
						UpdateSql3.append( "    AND DIRECTION=?                      					\n" );

						//STATUS
						gsmt = conn.getGauceStatement(UpdateSql3.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxCONVERSATION_ID);
						gsmt.bindColumn(2, idxSUPBUY_TYPE);
						gsmt.bindColumn(3, idxDIRECTION);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						UpdateSql3=null;
	
					}//if
				}//for


				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

		        //스마트빌 ID, PW 조회 >>>>>>>>>>>
		        sql9 = new StringBuffer();
		        sql9.append( " SELECT SMART_ID, SMART_PASSWORD     \n" ); 
				sql9.append( " 	 FROM HDASAN_EDI.XXSB_DTI_SM_USER  \n" ); 
				sql9.append( "  WHERE FND_USER ='"+strEmpno+"'     \n" ); 
				sql9.append( "    AND FND_REGNO ='"+strRegno+"'    \n" ); 
				stmt9 = conn.createStatement();
				rs9 = stmt9.executeQuery(sql9.toString());
				while(rs9.next()){         
					strID = rs9.getString(1);  
					strPW = rs9.getString(2);  
				}
					rs9.close();
					stmt9.close();

				//BATCH_ID 조회 >>>>>>>>>>>>>>>>
				sql0 = new StringBuffer();
				
				//sql0.append( " SELECT CAST(SUBSTR(REPLACE(CHAR(CURRENT DATE,ISO),'-',''),3,6)||REPLACE(CHAR(CURRENT TIME,ISO),'.','')|| SUBSTR(MICROSECOND(sysdate),1,3) AS NUMERIC(15))  \n" ); 
				//sql0.append( " 	 FROM SYSIBM.SYSDUMMY1                                                      \n" ); 
				sql0.append( " SELECT CAST(SUBSTR(TO_CHAR(CURRENT_TIMESTAMP,'YYMMDDHH24MISSxFF3'),1,12)||SUBSTR(TO_CHAR(CURRENT_TIMESTAMP,'YYMMDDHH24MISSxFF3'),14,3) AS NUMBER(15)) \n" ); 
				sql0.append( " 	 FROM SYS.DUAL                                                    \n" ); 
								
				stmt0 = conn.createStatement();
				rs0 = stmt0.executeQuery(sql0.toString());
				while(rs0.next()){         
					lng_Interface_Batch_id = rs0.getLong(1);  //키값으로 사용함.
				}
				rs0.close();
				stmt0.close();

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "  UPDATE HDASAN_EDI.XXSB_DTI_MAIN \n" );
						UpdateSql.append( "     SET INTERFACE_BATCH_ID="+lng_Interface_Batch_id+",\n" );
						UpdateSql.append( "         LAST_UPDATED_BY='"+strEmpno+"',               \n" );
						UpdateSql.append( "         LAST_UPDATE_DATE=sysdate            \n" );
						UpdateSql.append( "   WHERE CONVERSATION_ID=?        \n" );
						UpdateSql.append( "     AND SUPBUY_TYPE=?            \n" );
						UpdateSql.append( "     AND DIRECTION=?              \n" );

						//MAIN
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxCONVERSATION_ID);
						gsmt.bindColumn(2, idxSUPBUY_TYPE);
						gsmt.bindColumn(3, idxDIRECTION);

						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						UpdateSql=null;

					}//if
				}//for

				///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

				if (userSet2 != null) {
					resGauce.enableFirstRow(userSet2);
					userSet2.addDataColumn(new GauceDataColumn("BATCH_ID", GauceDataColumn.TB_DECIMAL,15));
					userSet2.addDataColumn(new GauceDataColumn("ID",   GauceDataColumn.TB_STRING,12));
					userSet2.addDataColumn(new GauceDataColumn("PASS", GauceDataColumn.TB_STRING,35));
         
					GauceDataRow row = null;
					row = userSet2.newDataRow();
					row.addColumnValue(lng_Interface_Batch_id);
					row.addColumnValue(strID);
					row.addColumnValue(strPW);
					userSet2.addDataRow(row);
					userSet2.flush();
				}
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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