package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040065_t3 extends HttpServlet{
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
				String strRegno = reqGauce.getParameter("v_str2");     //공급자 사업자 등록번호
				
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
       
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						//역매출은 1건만 실행 됨.

						//TAXNBR 생성 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//서울 매출건에 대한 계산서번호 생성  	

						strTaxdat = rows[j].getString(idxDTI_WDATE);	
						strTaxdat = "B"+strTaxdat.substring(0,4)+strTaxdat.substring(5,7);	

						sql = new StringBuffer();					
						sql.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(SUBSTR(A.TAXNBR,8,11)),0)+1)),4)    \n" ); 
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

						//세금계산서 MST 
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ATTAXMST (																																							 \n" );
						InsertSql.append( " TAXNBR,     COCODE,    DEPTCD,          EMPNO,       TAXIODIV,																							 \n" );
						InsertSql.append( " TAXDIV,     TAXKND,    VEND_CD,         TAXDAT,      TAXSUM,																								 \n" );
						InsertSql.append( " TAXVATAMT,  TAXTOT,    REMARK,          TAXCDNBR,    ATCODE,																								 \n" );
						InsertSql.append( " TAXPRTYN,   TAXCNT,    LASTPRT,         TAXTYPE,     FSDAT,																									 \n" );
						InsertSql.append( " FSNBR,      TAXKIDIV,  FDCODE,          WORKTYPE,    REPORT,																								 \n" );
						InsertSql.append( " WRDT,       WRID,      UPDT,            UPID,        SSDAT,																									 \n" );
						InsertSql.append( " SSNBR,      SEQ,       CONVERSATION_ID, SUPBUY_TYPE, DIRECTION																							 \n" );
						InsertSql.append( " )																																																					   \n" );
						InsertSql.append( " SELECT '"+strTaxnbr+"' TAXNBR,                                                                               \n" );
						InsertSql.append( "        CASE WHEN SUP_COM_REGNO='1018510695' THEN '02'                                                        \n" );
						InsertSql.append( "             WHEN SUP_COM_REGNO='2218113834' THEN '01'                                                        \n" );
						InsertSql.append( "             ELSE '99' END COCODE,                                                                            \n" );
						InsertSql.append( "        V.DEPTCD,   V.EMPNO,    'B' AS TAXIODIV,                                                              \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" ); 
						InsertSql.append( "        '0001' AS TAXDIV,                                                                                     \n" );
						InsertSql.append( "        CASE WHEN A.DTI_TYPE='01' AND CAST(A.TAX_AMOUNT AS VARCHAR(11))<>'0' THEN '1' --과세                  \n" );
						InsertSql.append( "             WHEN A.DTI_TYPE='01' AND CAST(A.TAX_AMOUNT AS VARCHAR(11)) ='0' THEN '2' --영세                  \n" );
						InsertSql.append( "             WHEN A.DTI_TYPE='02' THEN '3' --면세                                                             \n" );
						InsertSql.append( "             ELSE '9' END TAXKND,                                                                             \n" );
						InsertSql.append( "        G.VEND_CD,  REPLACE(CAST(A.DTI_WDATE AS VARCHAR(10)),'-','') AS TAXDAT,                               \n" );
						InsertSql.append( "        A.SUP_AMOUNT AS TAXSUM,                                                                               \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" ); 
						InsertSql.append( "        A.TAX_AMOUNT AS TAXVATAMT, A.TOTAL_AMOUNT AS TAXTOT, A.REMARK AS REMARK,'' TAXCDNBR, '1110110' ATCODE,\n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" ); 
						InsertSql.append( "        '' AS TAXPRTYN, 0 AS TAXCNT,  '' AS LASTPRT,                                                          \n" );
						InsertSql.append( "        CASE WHEN A.TAX_DEMAND='1' THEN 'Y'                                                                   \n" );
						InsertSql.append( "             WHEN A.TAX_DEMAND='18' THEN 'N'                                                                  \n" );
						InsertSql.append( "             ELSE 'Z' END AS TAXTYPE,                                                                         \n" );
						InsertSql.append( "        ''AS FSDAT,                                                                                           \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" ); 					
						InsertSql.append( "        ''AS FSNBR,                                                                                           \n" );
						InsertSql.append( "        CASE WHEN SUBSTR(REPLACE(CAST(A.DTI_WDATE AS VARCHAR(10)),'-',''),5,2) IN ('01','02','03') THEN '1'   \n" );
						InsertSql.append( "             WHEN SUBSTR(REPLACE(CAST(A.DTI_WDATE AS VARCHAR(10)),'-',''),5,2) IN ('04','05','06') THEN '2'   \n" );
						InsertSql.append( "             WHEN SUBSTR(REPLACE(CAST(A.DTI_WDATE AS VARCHAR(10)),'-',''),5,2) IN ('07','08','09') THEN '3'   \n" );
						InsertSql.append( "             WHEN SUBSTR(REPLACE(CAST(A.DTI_WDATE AS VARCHAR(10)),'-',''),5,2) IN ('10','11','12') THEN '4'   \n" );
						InsertSql.append( "             END AS TAXKIDIV,                                                                                 \n" );
						InsertSql.append( "        '02' AS FDCODE,   'A' AS WORKTYPE,    '' AS REPORT,                                                   \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" ); 					
						InsertSql.append( "        '' AS WRDT,   '' AS WRID,     '' AS UPDT,          '' AS UPID,     '' AS SSDAT,                       \n" );
						InsertSql.append( "        '' AS SSNBR,  K.SEQ AS SEQ,   A.CONVERSATION_ID,   A.SUPBUY_TYPE,  A.DIRECTION                        \n" );
						InsertSql.append( "   FROM HDASAN_EDI.XXSB_DTI_MAIN A, HDASAN_EDI.XXSB_DTI_STATUS C                                              \n" );
						InsertSql.append( "   LEFT JOIN PAYROLL.V_HIPERSON V ON V.EMAIL = A.SUP_EMAIL                                                    \n" );
						InsertSql.append( "   LEFT JOIN ( SELECT VEND_ID, MAX(VEND_CD)VEND_CD                                                            \n" );
						InsertSql.append( "                 FROM ACCOUNT.GCZM_VENDER                                                                     \n" );
						InsertSql.append( "                WHERE USE_TAG='Y'                                                                             \n" );
						InsertSql.append( "                  AND VEND_ID<>''                                                                             \n" );
						InsertSql.append( "                  AND VEND_CD<>''                                                                             \n" );
						InsertSql.append( "                GROUP BY VEND_ID                                                                              \n" );
						InsertSql.append( "              )G ON G.VEND_ID = A.BYR_COM_REGNO                                                               \n" );
						InsertSql.append( "   LEFT JOIN ACCOUNT.CUSTOMER K ON K.VEND_CD =G.VEND_CD AND K.EMAIL = A.BYR_EMAIL                             \n" );						
						InsertSql.append( "  WHERE A.CONVERSATION_ID = C.CONVERSATION_ID                                                                 \n" ); 
						InsertSql.append( "    AND A.SUPBUY_TYPE = C.SUPBUY_TYPE                                                                         \n" ); 
						InsertSql.append( "    AND A.DIRECTION = C.DIRECTION                                                                             \n" ); 
						InsertSql.append( "    AND C.DTI_STATUS ='V'                                                                                     \n" ); 
						InsertSql.append( "    AND A.CONVERSATION_ID=?                                                                                   \n" ); 
						InsertSql.append( "    AND A.SUPBUY_TYPE=?                                                                                       \n" ); 
						InsertSql.append( "    AND A.DIRECTION=?                                                                                         \n" ); 

						//MAIN
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxCONVERSATION_ID);
						gsmt.bindColumn(2, idxSUPBUY_TYPE);
						gsmt.bindColumn(3, idxDIRECTION);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						InsertSql=null;

						//logger.dbg.println(this,"STEP3:::");    			

						
						//세금계산서 DTL
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL(        																					  \n" );
						InsertSql2.append( "  TAXNBR,  TAXSEQ,  TAXPDTNAM,   TAXSTD,  TAXQTY,																  \n" );
						InsertSql2.append( "  TAXPRIC, TAXSUM,  TAXVATAMT,   BIGO,																					  \n" );
						InsertSql2.append( "  WRDT,    WRID,    UPDT,        UPID																						  \n" );
						InsertSql2.append( " ) \n" );
						InsertSql2.append( " SELECT '"+strTaxnbr+"' TAXNBR, RIGHT(CHAR(DIGITS(DTI_LINE_NUM)),3)  AS TAXSEQ,   \n" );
						InsertSql2.append( "        ITEM_NAME AS TAXPDTNAM, ITEM_SIZE AS TAXSTD, ITEM_QTY AS TAXQTY,          \n" );
						InsertSql2.append( "        UNIT_PRICE AS TAXPRIC,  SUP_AMOUNT AS TAXSUM,  TAX_AMOUNT AS TAXVATAMT,   \n" );
						InsertSql2.append( "        REMARK AS BIGO,                                                           \n" );
						InsertSql2.append( "        ''WRDT,    ''WRID,    ''UPDT,        ''UPID                               \n" );
						InsertSql2.append( "   FROM HDASAN_EDI.XXSB_DTI_ITEM                                                  \n" );
						InsertSql2.append( "  WHERE 1=1              \n" );
						InsertSql2.append( "    AND CONVERSATION_ID=?\n" );
						InsertSql2.append( "    AND SUPBUY_TYPE=?    \n" );
						InsertSql2.append( "    AND DIRECTION=?      \n" );

						//ITEM
						gsmt = conn.getGauceStatement(InsertSql2.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxCONVERSATION_ID);
						gsmt.bindColumn(2, idxSUPBUY_TYPE);
						gsmt.bindColumn(3, idxDIRECTION);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						InsertSql2=null;

						//전자세금계산서 STATUS //UPDATE 변경 -- I
						UpdateSql3 = new StringBuffer();
						UpdateSql3.append( " UPDATE HDASAN_EDI.XXSB_DTI_STATUS SET   \n" );
						UpdateSql3.append( " 				DTI_STATUS ='I'                  \n" );
						UpdateSql3.append( "  WHERE CONVERSATION_ID=?                \n" );
						UpdateSql3.append( "    AND SUPBUY_TYPE=?                    \n" );
						UpdateSql3.append( "    AND DIRECTION=?                      \n" );

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

				///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

				if (userSet2 != null) {
					resGauce.enableFirstRow(userSet2);
					userSet2.addDataColumn(new GauceDataColumn("BATCH_ID", GauceDataColumn.TB_STRING,15));
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