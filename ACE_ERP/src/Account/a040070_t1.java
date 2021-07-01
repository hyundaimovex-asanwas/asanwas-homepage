package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040070_t1 extends HttpServlet{
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

				String strRegno = reqGauce.getParameter("v_str1");     //공급자 사업자 등록번호
				String strEmpno = reqGauce.getParameter("v_str2");     //사번
				
				int idxTAXNBR             = userSet.indexOfColumn("TAXNBR");                 //계산서 번호 
				int idxCONVERSATION_ID    = userSet.indexOfColumn("CONVERSATION_ID");        //빈값 

				String str_Coversation_id="";
				String str_Seq="";
				String str_Vend_id="";
				String str_Taxdat ="";

				String strID="";
				String strPW="";
 				long lng_Interface_Batch_id = 0;
				
				GauceDataRow[] rows = userSet.getDataRows();

				//BATCH_ID
				StringBuffer sql0 = null;
				Statement stmt0 = null;
				ResultSet rs0 = null;

				//CONVERSATION_ID
				StringBuffer sql = null;
				Statement stmt = null;
				ResultSet rs = null;


				//SMART BILL ID PW
				StringBuffer sql9 = null;
				Statement stmt9 = null;
				ResultSet rs9 = null;
        
				//MAIN
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				//ITEM
				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;

				//STATUS
				StringBuffer InsertSql3 = null;
				StringBuffer UpdateSql3 = null;
				StringBuffer DeleteSql3 = null;

				//ATTAXMST
				StringBuffer UpdateSql4 = null;

				//logger.dbg.println(this,"step2");


				//BATCH_ID 조회 >>>>>>>>>>>>>>>>
				sql0 = new StringBuffer();
				//sql0.append( " SELECT CAST(REPLACE(CHAR(CURRENT DATE,ISO),'-','')||REPLACE(CHAR(CURRENT TIME,ISO),'.','')||SUBSTR(MICROSECOND(sysdate),1,1) AS NUMERIC(15))  \n" ); 
				//sql0.append( " 	 FROM SYSIBM.SYSDUMMY1                                                      \n" );     
			
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
				///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

				//logger.dbg.println(this,"str_Interface_Batch_id::::"+str_Interface_Batch_id);
				//전자세금계산서 DTL

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {


						//CONVERSATION_ID >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						sql = new StringBuffer();					
						sql.append( " SELECT HDASAN_EDI.FN_CONVERSATION_SEQ(B.VEND_ID||'"+strRegno+"'||A.TAXDAT) SEQ, B.VEND_ID, A.TAXDAT   \n" ); 
						sql.append( "   FROM ACCOUNT.ATTAXMST A,  ACCOUNT.GCZM_VENDER B   \n" ); 
						sql.append( "  WHERE A.TAXNBR ='"+rows[j].getString(idxTAXNBR)+"'  \n" ); 
						sql.append( "    AND A.VEND_CD = B.VEND_CD  \n" ); 

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());


						while(rs.next()){         
							str_Seq     = rs.getString(1);  //seq 생성
							str_Vend_id = rs.getString(2);  //거래처 사업자등록번호
							str_Taxdat  = rs.getString(3);  //계산서일자
						}
						rs.close();
						stmt.close();
						str_Coversation_id = str_Vend_id+strRegno+str_Taxdat+str_Seq+"003"; //Conversation_ID

						///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
						//전자세금계산서 MAIN 
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO HDASAN_EDI.XXSB_DTI_MAIN (																																		   \n" );
						InsertSql.append( " CONVERSATION_ID, SUPBUY_TYPE,    DIRECTION,       INTERFACE_BATCH_ID, DTI_WDATE,													   \n" );
						InsertSql.append( " BLANK_CNT,       DTI_TYPE,       TAX_DEMAND,      SUP_COM_ID,         SUP_COM_REGNO,											   \n" );
						InsertSql.append( " SUP_REP_NAME,    SUP_COM_NAME,   SUP_COM_TYPE,    SUP_COM_CLASSIFY,   SUP_COM_ADDR,												   \n" );
						InsertSql.append( " SUP_DEPT_NAME,   SUP_EMP_NAME,   SUP_TEL_NUM,     SUP_EMAIL,          BYR_COM_ID,													   \n" );
						InsertSql.append( " BYR_COM_REGNO,   BYR_REP_NAME,   BYR_COM_NAME,    BYR_COM_TYPE,       BYR_COM_CLASSIFY,										   \n" );
						InsertSql.append( " BYR_COM_ADDR,    BYR_DEPT_NAME,  BYR_EMP_NAME,    BYR_TEL_NUM,        BYR_EMAIL,													   \n" );
						InsertSql.append( " SUP_AMOUNT,      TAX_AMOUNT,     TOTAL_AMOUNT,    DTT_YN,																									   \n" );
						InsertSql.append( " CREATED_BY,      CREATION_DATE,  LAST_UPDATED_BY, LAST_UPDATE_DATE																				   \n" );
						InsertSql.append( " )																																																					   \n" );
						InsertSql.append( "  SELECT '"+str_Coversation_id+"' ,                                                                           \n" );
						InsertSql.append( "        CASE WHEN A.TAXIODIV IN ('A','C') THEN 'AP'                                                           \n" );
						InsertSql.append( "             WHEN A.TAXIODIV IN ('B','D') THEN 'AR' END  AS SUPBUY_TYPE,                                      \n" );
						InsertSql.append( "        '1' AS DIRECTION,     "+lng_Interface_Batch_id+" AS INTERFACE_BATCH_ID,                               \n" );
						InsertSql.append( "        CAST(SUBSTR(A.TAXDAT,1,4)||'-'||SUBSTR(A.TAXDAT,5,2)||'-'||SUBSTR(A.TAXDAT,7,2)AS DATE) AS DTI_WDATE, \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        11-LENGTH(A.TAXSUM) AS BLANK_CNT,                                                                     \n" );
						InsertSql.append( "        CASE WHEN A.TAXKND IN ('1','2') THEN '01'                                                             \n" );
						InsertSql.append( "             WHEN A.TAXKND =3 THEN '02' END     AS DTI_TYPE,                                                   \n" );
						InsertSql.append( "        CASE WHEN A.TAXTYPE ='Y' THEN '1'                                                                     \n" );
						InsertSql.append( "             WHEN A.TAXTYPE ='N' THEN '18'                                                                    \n" );
						InsertSql.append( "             ELSE '18' END AS TAX_DEMAND,                                                                     \n" );
						InsertSql.append( "        '' AS SUP_COM_ID,         B.VEND_ID  AS SUP_COM_REGNO,                                                \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        TRIM(B.VD_DIRECT) AS SUP_REP_NAME, TRIM(B.VEND_NM) AS SUP_COM_NAME,  B.BSNS_CND  AS SUP_COM_TYPE,     \n" );
						InsertSql.append( "        B.BSNS_KND  AS SUP_COM_CLASSIFY,   TRIM(B.ADDRESS1)||TRIM(B.ADDRESS2) AS SUP_COM_ADDR,                \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        TRIM(J.DEPTNM) AS SUP_DEPT_NAME,  J.EMPNM  AS SUP_EMP_NAME,  J.TELNO  AS SUP_TEL_NUM,                 \n" );
						InsertSql.append( "        J.EMAIL AS SUP_EMAIL,             X.SMART_ID AS BYR_COM_ID,                                           \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        C.VEND_ID   AS BYR_COM_REGNO,    C.VD_DIRECT AS BYR_REP_NAME,      C.VEND_NM   AS BYR_COM_NAME,       \n" );
						InsertSql.append( "        C.BSNS_CND  AS BYR_COM_TYPE,     C.BSNS_KND  AS BYR_COM_CLASSIFY,                                     \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        TRIM(C.ADDRESS1)||TRIM(C.ADDRESS2) AS BYR_COM_ADDR,  TRIM(H.DEPTNMK) AS BYR_DEPT_NAME,                \n" );
						InsertSql.append( "        TRIM(V.EMPNMK)  AS BYR_EMP_NAME,       V.HPNO  AS BYR_TEL_NUM,       V.EMAIL  AS BYR_EMAIL,           \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        A.TAXSUM    AS SUP_AMOUNT,  A.TAXVATAMT AS TAX_AMOUNT,  A.TAXTOT    AS TOTAL_AMOUNT,   'N' AS DTT_YN, \n" );
						InsertSql.append( "        '' AS CREATED_BY, sysdate  ,  '' AS  LAST_UPDATED_BY,  sysdate                    \n" );
						//InsertSql.append( "   FROM ACCOUNT.ATTAXMST A, ACCOUNT.GCZM_VENDER B                                                             \n" );
						InsertSql.append( "   FROM ACCOUNT.ATTAXMST A                                                                                    \n" );
						InsertSql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD = B.VEND_CD                                                   \n" );
						InsertSql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER C ON C.VEND_ID='"+strRegno+"' AND C.USE_TAG='Y'                              \n" );
						InsertSql.append( "   LEFT JOIN PAYROLL.V_HIPERSON V ON V.EMPNO =A.EMPNO                                                         \n" );
						InsertSql.append( "   LEFT JOIN PAYROLL.HCDEPT H ON H.DEPTCD =A.DEPTCD                                                           \n" );
						InsertSql.append( "   LEFT JOIN HDASAN_EDI.XXSB_DTI_SM_USER X ON X.FND_USER = A.EMPNO AND X.FND_REGNO = '"+strRegno+"'           \n" );
						InsertSql.append( "   LEFT JOIN ACCOUNT.CUSTOMER J ON A.VEND_CD = J.VEND_CD AND A.SEQ = J.SEQ                                    \n" );
						InsertSql.append( "  WHERE A.TAXNBR =?                                                                                           \n" );
						InsertSql.append( "    AND A.VEND_CD = B.VEND_CD                                                                                 \n" );				 

						//MAIN
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxTAXNBR);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						InsertSql=null;

						//전자세금계산서 ITEM
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO HDASAN_EDI.XXSB_DTI_ITEM                                                                      \n" );
						InsertSql2.append( "  SELECT '"+str_Coversation_id+"'  ,    \n" );
						InsertSql2.append( "        CASE WHEN A.TAXIODIV IN ('A','C') THEN 'AP'                                                        \n" );
						InsertSql2.append( "             WHEN A.TAXIODIV IN ('B','D') THEN 'AR' END  AS SUPBUY_TYPE,                                   \n" );
						InsertSql2.append( "        '1' AS DIRECTION,                                                                                  \n" );
						InsertSql2.append( "        CAST(Z.TAXSEQ AS INTEGER) AS DTI_LINE_NUM,  '' AS ITEM_CODE,  Z.TAXPDTNAM AS ITEM_NAME,            \n" );
						InsertSql2.append( "        Z.TAXSTD AS ITEM_SIZE,                                                                             \n" );
						InsertSql2.append( "        CAST(SUBSTR(A.TAXDAT,1,4)||'-'||SUBSTR(A.TAXDAT,5,2)||'-'||SUBSTR(A.TAXDAT,7,2)AS DATE) AS ITEM_MD,\n" );
						InsertSql2.append( "        Z.TAXPRIC AS UNIT_PRICE,  Z.TAXQTY  AS ITEM_QTY,  Z.TAXSUM  AS SUP_AMOUNT,                         \n" );
						InsertSql2.append( "        Z.TAXVATAMT AS TAX_AMOUT, 0 FOREIGN_AMOUNT,       '' CURRENCY_CODE,       Z.BIGO AS REMARK,        \n" );
						InsertSql2.append( "        '' AS CREATED_BY, sysdate, '' AS  LAST_UPDATED_BY, sysdate                     \n" );
						InsertSql2.append( "   FROM ACCOUNT.ATTAXDTL Z, ACCOUNT.ATTAXMST A, ACCOUNT.GCZM_VENDER B                                      \n" );
						InsertSql2.append( "  WHERE A.TAXNBR = ?                                                                                       \n" );
						InsertSql2.append( "    AND Z.TAXNBR = A.TAXNBR                                                                                \n" );
						InsertSql2.append( "    AND A.VEND_CD = B.VEND_CD                                                                              \n" );

						//ITEM
						gsmt = conn.getGauceStatement(InsertSql2.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxTAXNBR);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						InsertSql2=null;


						//전자세금계산서 STATUS
						InsertSql3 = new StringBuffer();
						InsertSql3.append( " INSERT INTO HDASAN_EDI.XXSB_DTI_STATUS                                                                  \n" );
						InsertSql3.append( "  SELECT '"+str_Coversation_id+"' ,    \n" );
						InsertSql3.append( " 				CASE WHEN A.TAXIODIV IN ('A','C') THEN 'AP'                                                      \n" );
						InsertSql3.append( " 						 WHEN A.TAXIODIV IN ('B','D') THEN 'AR' END  AS SUPBUY_TYPE,                                 \n" );
						InsertSql3.append( " 				'1' AS DIRECTION,                                                                                \n" );
						InsertSql3.append( " 				'A' AS DTI_STATUS,                                                                                \n" );
						InsertSql3.append( " 				0 AS SUP_PRINT_CNT,                                                                              \n" );
						InsertSql3.append( " 				0 AS BYR_PRINT_CNT,                                                                              \n" );
						InsertSql3.append( " 				'' AS RETURN_CODE,                                                                               \n" );
						InsertSql3.append( " 				'' AS RETURN_DESCRIPTION,                                                                        \n" );
						InsertSql3.append( " 				'' AS SBDESCRIPTION,                                                                             \n" );
						InsertSql3.append( " 				'' AS CREATED_BY, sysdate, '' AS  LAST_UPDATED_BY, sysdate                   \n" );
						InsertSql3.append( " 				FROM ACCOUNT.ATTAXMST A,  ACCOUNT.GCZM_VENDER B                                                  \n" );
						InsertSql3.append( " WHERE A.TAXNBR =?                                                                                       \n" );
						InsertSql3.append( "   AND A.VEND_CD = B.VEND_CD                                                                             \n" );

						//STATUS
						gsmt = conn.getGauceStatement(InsertSql3.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxTAXNBR);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						InsertSql3=null;


						/////////////////////////////////////////////////////////////////////////////
						//ATTAXMST 에 매출 키값 저장
						//CONVERSATION_ID, SUPBUY_TYPE, DIRECTION  UPDATE 함
						/////////////////////////////////////////////////////////////////////////////

						UpdateSql4 = new StringBuffer();
						UpdateSql4.append( " UPDATE ACCOUNT.ATTAXMST SET  \n" );
						UpdateSql4.append( "        CONVERSATION_ID = '"+str_Coversation_id+"', \n" );
						UpdateSql4.append( "        SUPBUY_TYPE = 'AP', \n" );
						UpdateSql4.append( "        DIRECTION ='1' \n" );
						UpdateSql4.append( "  WHERE TAXNBR = ? \n" );

						gsmt = conn.getGauceStatement(UpdateSql4.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxTAXNBR);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						UpdateSql4=null;
					
					}//if

				}//for


		  	    GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

		        //스마트빌 ID, PW 조회 >>>>>>>>>>>
		        sql9 = new StringBuffer();
		        sql9.append( " SELECT SMART_ID, SMART_PASSWORD     \n" ); 
				sql9.append( " 	 FROM HDASAN_EDI.XXSB_DTI_SM_USER  \n" ); 
				sql9.append( "  WHERE FND_USER ='"+strEmpno+"'     \n" ); 
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