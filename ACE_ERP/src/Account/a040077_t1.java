package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a040077_t1 extends HttpServlet{
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
				
				//taxmst 정보 
				GauceDataSet userSet01 = reqGauce.getGauceDataSet("USER01");
				
				String strRegno       = reqGauce.getParameter("v_str1");     //공급자 사업자 등록번호
				String strUserid      = reqGauce.getParameter("v_str2");     //사번
				String strOriissueid  = reqGauce.getParameter("v_str3");     //당초승인번호
				
				//System.out.println("strRegno::"+strRegno);
				//System.out.println("strUserid::"+strUserid);
				//System.out.println("strOriissueid::"+strOriissueid);
						
				
				String[] StrArrCN0 = new String[] {
					"TAXNBR",   "COCODE",     "DEPTCD",         "EMPNO",       "TAXIODIV",
					"TAXDIV",   "TAXKND",     "VEND_CD",        "TAXDAT",      "TAXSUM",
					"TAXVATAMT","TAXTOT",     "REMARK",         "TAXCDNBR",    "ATCODE",
					"TAXPRTYN", "TAXCNT",     "LASTPRT",        "TAXTYPE",     "FSDAT",	
					"FSNBR",    "TAXKIDIV",   "FDCODE",         "WORKTYPE",    "REPORT", 
					"WRDT", 	"WRID",       "UPDT",           "UPID",        "SSDAT",
					"SSNBR",    "SEQ",        "CONVERSATION_ID","SUPBUY_TYPE", "DIRECTION", 
					"GUBUN",    "AMEND_CODE", "AMEND_REMARK",   "EXTCHK",      "REMARK2",
					"REMARK3",  "S_BIZPLACE", "B_BIZPLACE",     "COSTCD",
					"EBILLGB",  "DUEDATE",    "TAXSTS",         "ORI_ISSUE_ID"
				};

				int[] idx0 = new int[48];
				for(int i=0;i<StrArrCN0.length;i++) {
					idx0[i] = userSet01.indexOfColumn(StrArrCN0[i]);
					
					
					//System.out.println("i::"+i+":::::::::::::::::::::"+idx0[i]);
					
				}
				
				GauceDataRow[] rows0 = userSet01.getDataRows();
				
				Statement stmt0 = null;
				ResultSet rs0 = null;
				
				StringBuffer sql0=null;
				StringBuffer InsertSql0 = null;
				GauceStatement gsmt0 = null;
				
				//System.out.println("i::");
				
				String strTaxnbr="";
				strTaxnbr ="B"+rows0[0].getString(idx0[8]).substring(0,6);  //B201403
				
				//System.out.println("i::22");
								
				for (int i = 0; i < rows0.length; i++){
					if(rows0[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						sql0 = new StringBuffer();	
						sql0.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(SUBSTR(TAXNBR,8,11)),0))+1,4,'0') \n");
						sql0.append( "   FROM ACCOUNT.ATTAXMST   								\n");
						sql0.append( "  WHERE TAXNBR LIKE '"+strTaxnbr+"%'                      \n");
						
						//System.out.println("sql0::"+sql0.toString());
						
						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());
						

						while(rs0.next())	{
							//System.out.println("sql3::");
							strTaxnbr = strTaxnbr+rs0.getString(1);
							//System.out.println("sql4::");
						}
						
						//System.out.println("strTaxnbr::"+strTaxnbr);
						
						
						//INSERT ATTAXMST 
						/**
						"TAXNBR",   "COCODE",   "DEPTCD",  "EMPNO",    "TAXIODIV",                  0-4
						"TAXDIV",   "TAXKND",   "VEND_CD", "TAXDAT",   "TAXSUM",                    5-9
						"TAXVATAMT","TAXTOT",   "REMARK",  "TAXCDNBR", "ATCODE",                   10-14 
						"TAXPRTYN", "TAXCNT",   "LASTPRT", "TAXTYPE",  "FSDAT",	                   15-19  
						"FSNBR",    "TAXKIDIV", "FDCODE",  "WORKTYPE", "REPORT",                   20-24 
						"WRDT", 	"WRID",     "UPDT",    "UPID",     "SSDAT",                    25-29 
						"SSNBR",    "SEQ",      "CONVERSATION_ID",     "SUPBUY_TYPE", "DIRECTION", 30-34
						"GUBUN",    "AMEND_CODE", "AMEND_REMARK", "EXTCHK", "REMARK2",             35-39 
						"REMARK3",  "S_BIZPLACE", "B_BIZPLACE"                                     40-42
						**/
						
						InsertSql0 = new StringBuffer();
						InsertSql0.append( " INSERT INTO ACCOUNT.ATTAXMST (					       \n");
						InsertSql0.append( " TAXNBR,COCODE,DEPTCD,EMPNO,TAXIODIV,			       \n");
						InsertSql0.append( " TAXDIV,TAXKND,VEND_CD,TAXDAT,TAXSUM,			       \n");
						InsertSql0.append( " TAXVATAMT,TAXTOT,REMARK,TAXCDNBR,ATCODE,	           \n");
						InsertSql0.append( " TAXPRTYN,TAXCNT,LASTPRT,TAXTYPE,FSDAT,		           \n");
						InsertSql0.append( " FSNBR,TAXKIDIV,FDCODE,WORKTYPE,WRDT,	               \n");
						InsertSql0.append( " WRID,SEQ, GUBUN, AMEND_CODE, AMEND_REMARK,            \n");
						InsertSql0.append( " EXTCHK, REMARK2, REMARK3, S_BIZPLACE,COSTCD,          \n");
						InsertSql0.append( " EBILLGB, DUEDATE, TAXSTS, ORI_ISSUE_ID                \n");
						InsertSql0.append( " ) VALUES(											   \n");
						InsertSql0.append( " '"+strTaxnbr+"','"+rows0[i].getString(idx0[1])+"','"+rows0[i].getString(idx0[2])+"','"+rows0[i].getString(idx0[3])+"','"+rows0[i].getString(idx0[4])+"',\n");
						InsertSql0.append( " '"+rows0[i].getString(idx0[5])+"','"+rows0[i].getString(idx0[6])+"','"+rows0[i].getString(idx0[7])+"','"+rows0[i].getString(idx0[8])+"',"+rows0[i].getString(idx0[9])+",\n");
						InsertSql0.append( " "+rows0[i].getString(idx0[10])+","+rows0[i].getString(idx0[11])+",'"+rows0[i].getString(idx0[12])+"','"+rows0[i].getString(idx0[13])+"','"+rows0[i].getString(idx0[14])+"',\n");
						InsertSql0.append( " '"+rows0[i].getString(idx0[15])+"',"+rows0[i].getString(idx0[16])+",'"+rows0[i].getString(idx0[17])+"','"+rows0[i].getString(idx0[18])+"','"+rows0[i].getString(idx0[19])+"',\n");
						InsertSql0.append( " '"+rows0[i].getString(idx0[20])+"','"+rows0[i].getString(idx0[21])+"','"+rows0[i].getString(idx0[22])+"','"+rows0[i].getString(idx0[23])+"','"+rows0[i].getString(idx0[25])+"',\n");
						InsertSql0.append( " '"+rows0[i].getString(idx0[26])+"','"+rows0[i].getString(idx0[31])+"','"+rows0[i].getString(idx0[35])+"','"+rows0[i].getString(idx0[36])+"','"+rows0[i].getString(idx0[37])+"',\n");
						InsertSql0.append( " '"+rows0[i].getString(idx0[38])+"','"+rows0[i].getString(idx0[39])+"','"+rows0[i].getString(idx0[40])+"','"+rows0[i].getString(idx0[41])+"','"+rows0[i].getString(idx0[43])+"',\n");
						InsertSql0.append( " '"+rows0[i].getString(idx0[44])+"','"+rows0[i].getString(idx0[45])+"','"+rows0[i].getString(idx0[46])+"','"+rows0[i].getString(idx0[47])+"'\n");
						InsertSql0.append( " ) 			   \n");

						
						//System.out.println("InsertSql0::"+InsertSql0.toString());
						gsmt0 = conn.getGauceStatement(InsertSql0.toString());
												
						
						gsmt0.setGauceDataRow(rows0[i]);
						
						/*
						for(int k=1;k<=23;k++) {
							gsmt0.bindColumn(k, idx0[k]);
						}
						
						gsmt0.bindColumn(25, idx0[25]);
						gsmt0.bindColumn(26, idx0[26]);
						gsmt0.bindColumn(31, idx0[31]);
						for(int k=35;k<=41;k++) {
							gsmt0.bindColumn(k, idx0[k]);
						}
						*/
																
						gsmt0.executeUpdate();
						gsmt0.close();
						//INSERT ATTAXDTL
						
					}//if	
					
					//UPDATE 도 있어야 하네...
					
					
				}//for i

				
				GauceDataSet userSet02 = reqGauce.getGauceDataSet("USER02");
				String[] StrArrCN02 = new String[] {
						"TAXNBR",  "TAXSEQ", "TAXPDTNAM","TAXSTD","TAXQTY",
						"TAXPRIC", "TAXSUM", "TAXVATAMT","BIGO","WRDT",
						"WRID",    "UPDT",   "UPID", "MMDD"
				};

				int[] idx02 = new int[14];
				for(int i=0;i<StrArrCN02.length;i++) {
					idx02[i] = userSet02.indexOfColumn(StrArrCN02[i]);
				}
				
				GauceDataRow[] rows02 = userSet02.getDataRows();
				
				for (int i = 0; i < rows02.length; i++){
					if(rows02[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						InsertSql0 = new StringBuffer();
						InsertSql0.append( " INSERT INTO ACCOUNT.ATTAXDTL (			   \n");
						InsertSql0.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,    \n");
						InsertSql0.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,WRDT,       \n");
						InsertSql0.append( " WRID ) VALUES (                	           \n");
						InsertSql0.append( " '"+strTaxnbr+"','"+rows02[i].getString(idx02[1])+"','"+rows02[i].getString(idx02[2])+"','"+rows02[i].getString(idx02[3])+"',"+rows02[i].getString(idx02[4])+",\n");
						InsertSql0.append( " "+rows02[i].getString(idx02[5])+","+rows02[i].getString(idx02[6])+","+rows02[i].getString(idx02[7])+",'"+rows02[i].getString(idx02[8])+"','"+rows02[i].getString(idx02[9])+"',\n");
						InsertSql0.append( " '"+rows02[i].getString(idx02[10])+"' \n");
						InsertSql0.append( " ) \n");
					
						//System.out.println("2InsertSql0::"+InsertSql0.toString());
						gsmt0 = conn.getGauceStatement(InsertSql0.toString());
						
						
						gsmt0.setGauceDataRow(rows0[i]);
						gsmt0.executeUpdate();
						gsmt0.close();
					}
				}
				
				/************************************************************************************
				 @ 계산서 번호 return값
				*************************************************************************************/
					GauceDataSet userSet7 = reqGauce.getGauceDataSet("USER7");

					if (userSet7 != null) {
						resGauce.enableFirstRow(userSet7);
						userSet7.addDataColumn(new GauceDataColumn("TAXNBR", GauceDataColumn.TB_STRING,11));
									 
						GauceDataRow row = null;
						row = userSet7.newDataRow();
						row.addColumnValue(strTaxnbr);
						userSet7.addDataRow(row);
						userSet7.flush();
					} //(userSet7 != null) {
					  //logger.dbg.println(this,"strTaxnbr::"+strTaxnbr);
				
				/******************************************************************************************* 
				/////////////////////////////////////////////////////////////////////////////////////////////
				//여기부터는 전자세금계산서 발행 기존과 거의 동일
				/////////////////////////////////////////////////////////////////////////////////////////////
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				String strEmpno  = strUserid;     //사번
				
				//int idxTAXNBR             = userSet.indexOfColumn("TAXNBR");                 //빈값
				//int idxCONVERSATION_ID    = userSet.indexOfColumn("CONVERSATION_ID");        //빈값 

				String str_Coversation_id="";
				String str_Seq="";
				String str_Vend_id="";
				String str_Taxdat ="";

				String strID="";
				String strPW="";
 				long lng_Interface_Batch_id = 0;

				String strTaxGb=""; // 계산서 구분 - 개성
				
				GauceDataRow[] rows = userSet.getDataRows();

				//BATCH_ID
				StringBuffer sql00 = null;
				Statement stmt00 = null;
				ResultSet rs00 = null;

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
				sql00 = new StringBuffer();	
				sql00.append( " SELECT CAST(SUBSTR(TO_CHAR(CURRENT_TIMESTAMP,'YYMMDDHH24MISSxFF3'),1,12)||SUBSTR(TO_CHAR(CURRENT_TIMESTAMP,'YYMMDDHH24MISSxFF3'),14,3) AS NUMBER(15)) \n" ); 
				sql00.append( "   FROM SYS.DUAL                                                    \n" ); 	        
			    
				stmt00 = conn.createStatement();
				rs00 = stmt00.executeQuery(sql00.toString());
				while(rs00.next()){         
					lng_Interface_Batch_id = rs00.getLong(1);  //키값으로 사용함.
				}
				
				
				//System.out.println("lng_Interface_Batch_id::"+lng_Interface_Batch_id);
				
				rs00.close();
				stmt00.close();
				///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
				//전자세금계산서 DTL

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//CONVERSATION_ID >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						sql = new StringBuffer();					
						sql.append( " SELECT HDASAN_EDI.FN_CONVERSATION_SEQ('"+strRegno+"'||SUBSTR(TRIM(B.VEND_ID),1,10)||A.TAXDAT) SEQ, SUBSTR(TRIM(B.VEND_ID),1,10), A.TAXDAT   \n" ); 
						sql.append( "   FROM ACCOUNT.ATTAXMST A,  ACCOUNT.GCZM_VENDER B    \n" ); 
						sql.append( "  WHERE A.TAXNBR ='"+strTaxnbr+"'  \n" ); 
						sql.append( "    AND A.VEND_CD = B.VEND_CD  \n" ); 

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						
						//System.out.println("sql::"+sql.toString());
						
						while(rs.next()){         
							str_Seq     = rs.getString(1);  //seq 생성
							str_Vend_id = rs.getString(2);  //거래처 사업자등록번호
							str_Taxdat  = rs.getString(3);  //계산서일자
						}
						stmt.close();
						str_Coversation_id = strRegno+str_Vend_id+str_Taxdat+str_Seq+"003"; //Conversation_ID
						///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						
						//System.out.println("str_Coversation_id::"+str_Coversation_id);
						strTaxGb = strTaxnbr.substring(0,1);
	
						//전자세금계산서 MAIN 
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO HDASAN_EDI.XXSB_DTI_MAIN (																																		   \n" );
						InsertSql.append( " CONVERSATION_ID, SUPBUY_TYPE,    DIRECTION,       INTERFACE_BATCH_ID, DTI_WDATE,							 \n" );
						InsertSql.append( " BLANK_CNT,       DTI_TYPE,       TAX_DEMAND,      SUP_COM_ID,         SUP_COM_REGNO,						 \n" );
						InsertSql.append( " SUP_REP_NAME,    SUP_COM_NAME,   SUP_COM_TYPE,    SUP_COM_CLASSIFY,   SUP_COM_ADDR,							 \n" );
						InsertSql.append( " SUP_DEPT_NAME,   SUP_EMP_NAME,   SUP_TEL_NUM,     SUP_EMAIL,          BYR_COM_ID,							 \n" );
						InsertSql.append( " BYR_COM_REGNO,   BYR_REP_NAME,   BYR_COM_NAME,    BYR_COM_TYPE,       BYR_COM_CLASSIFY,						 \n" );
						InsertSql.append( " BYR_COM_ADDR,    BYR_DEPT_NAME,  BYR_EMP_NAME,    BYR_TEL_NUM,        BYR_EMAIL,							 \n" );
						InsertSql.append( " SUP_AMOUNT,      TAX_AMOUNT,     TOTAL_AMOUNT,    DTT_YN,													 \n" );
						InsertSql.append( " CREATED_BY,      CREATION_DATE,  LAST_UPDATED_BY, LAST_UPDATE_DATE,   AMEND_CODE, REMARK,REMARK2, REMARK3, 	 \n" );
						InsertSql.append( " SUP_BIZPLACE_CODE, ORI_ISSUE_ID , BYR_BIZPLACE_CODE 				   \n" );
						
						//if(strEmpno.equals("4090003")||strEmpno.equals("2020013")||strEmpno.equals("3150005")||strEmpno.equals("2110003"))InsertSql.append( " ,BYR_BIZPLACE_CODE   \n" );
						
						InsertSql.append( " )																																																					   \n" );
						InsertSql.append( "  SELECT '"+str_Coversation_id+"' ,                                                                           \n" );
						InsertSql.append( "        CASE WHEN A.TAXIODIV IN ('A','C') THEN 'AP'                                                           \n" );
						InsertSql.append( "             WHEN A.TAXIODIV IN ('B','D') THEN 'AR' END  AS SUPBUY_TYPE,                                      \n" );
						InsertSql.append( "        '2' AS DIRECTION,     "+lng_Interface_Batch_id+" AS INTERFACE_BATCH_ID,                               \n" );
						InsertSql.append( "        CAST(SUBSTR(A.TAXDAT,1,4)||'-'||SUBSTR(A.TAXDAT,5,2)||'-'||SUBSTR(A.TAXDAT,7,2)AS DATE) AS DTI_WDATE, \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        11-LENGTH(A.TAXSUM) AS BLANK_CNT,                                                                     \n" );
						InsertSql.append( "        CASE WHEN A.TAXKND IN ('1','2') THEN '01'                                                             \n" );
						InsertSql.append( "             WHEN A.TAXKND ='3' THEN '02' END  AS DTI_TYPE,                                                   \n" );
						InsertSql.append( "        CASE WHEN A.TAXTYPE ='Y' THEN '1'                                                                     \n" );
						InsertSql.append( "             WHEN A.TAXTYPE ='N' THEN '18' END AS TAX_DEMAND,                                                 \n" );
						InsertSql.append( "        X.SMART_ID AS SUP_COM_ID,         C.VEND_ID  AS SUP_COM_REGNO,                                        \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        TRIM(C.VD_DIRECT) AS SUP_REP_NAME, TRIM(C.VEND_NM) AS SUP_COM_NAME,  C.BSNS_CND  AS SUP_COM_TYPE,     \n" );
						InsertSql.append( "        C.BSNS_KND  AS SUP_COM_CLASSIFY,   TRIM(C.ADDRESS1)||TRIM(C.ADDRESS2) AS SUP_COM_ADDR,                \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        TRIM(H.DEPTNMK) AS SUP_DEPT_NAME, TRIM(V.EMPNMK)  AS SUP_EMP_NAME,  V.HPNO  AS SUP_TEL_NUM,           \n" );
            
						if(strTaxGb.equals("D")){ // 개성 건은 구현진 씨.... --> 이윤석차장
							InsertSql.append( "        Y.EMAIL AS SUP_EMAIL,                                                                             \n" );
						}else{
							InsertSql.append( "        V.EMAIL AS SUP_EMAIL,                                                                             \n" );
						}
						
						InsertSql.append( "        '' AS BYR_COM_ID,                                                                                     \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "         TRIM(B.VEND_ID)   AS BYR_COM_REGNO,    B.VD_DIRECT AS BYR_REP_NAME,      B.VEND_NM   AS BYR_COM_NAME,\n" );
						InsertSql.append( "         B.BSNS_CND  AS BYR_COM_TYPE,     B.BSNS_KND  AS BYR_COM_CLASSIFY,                                    \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        TRIM(B.ADDRESS1)||TRIM(B.ADDRESS2) AS BYR_COM_ADDR,  J.DEPTNM AS BYR_DEPT_NAME,                       \n" );
						InsertSql.append( "        J.EMPNM  AS BYR_EMP_NAME,         J.TELNO  AS BYR_TEL_NUM,       J.EMAIL  AS BYR_EMAIL,               \n" );
						InsertSql.append( "        ----------------------------------------------------------------------------------------------------- \n" );
						InsertSql.append( "        A.TAXSUM    AS SUP_AMOUNT,  A.TAXVATAMT AS TAX_AMOUNT,  A.TAXTOT    AS TOTAL_AMOUNT,   'N' AS DTT_YN, \n" );
						InsertSql.append( "        '' AS CREATED_BY, sysdate  ,  '' AS  LAST_UPDATED_BY,  sysdate, A.AMEND_CODE, A.AMEND_REMARK ,A.REMARK2,A.REMARK3, \n" );
						InsertSql.append( "        A.S_BIZPLACE, '"+strOriissueid+"' , A.B_BIZPLACE \n" );

						
						//if(strEmpno.equals("4090003")){
						//	InsertSql.append( " ,  CASE WHEN TRIM(B.VEND_ID)='1208200052' THEN '0005' ELSE '' END  BYR_BIZPLACE_CODE   \n" );
						//}else if(strEmpno.equals("2020013")){
						//	InsertSql.append( " ,  CASE WHEN TRIM(B.VEND_ID) IN ('1378207000') THEN '0002'    \n" );
						//	InsertSql.append( "         WHEN TRIM(B.VEND_ID) IN ('3058213158') THEN '0001' ELSE '' END  BYR_BIZPLACE_CODE  \n" );
						//}else if(strEmpno.equals("2110003")){	
						//	InsertSql.append( " ,  CASE WHEN TRIM(B.VEND_ID) IN ('1168129539') THEN '0054' ELSE '' END  BYR_BIZPLACE_CODE  \n" );
						//}else if(strEmpno.equals("3150005")){
						//	InsertSql.append( " ,  CASE WHEN TRIM(B.VEND_ID) IN ('1378207000') THEN '0002' ELSE '' END  BYR_BIZPLACE_CODE  \n" );
						//}
						

						InsertSql.append( "   FROM ACCOUNT.ATTAXMST A                                                                                    \n" );
						InsertSql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD = B.VEND_CD                                                   \n" );
						InsertSql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER C ON C.VEND_ID='"+strRegno+"' AND C.USE_TAG='Y'                              \n" );
						InsertSql.append( "   LEFT JOIN PAYROLL.V_HIPERSON V ON V.EMPNO =A.EMPNO                                                         \n" );
						//개성 구현진 -> 이윤석차장
						//InsertSql.append( "   LEFT JOIN PAYROLL.V_HIPERSON Y ON Y.EMPNO ='2110003'                                                       \n" );
						InsertSql.append( "   LEFT JOIN PAYROLL.V_HIPERSON Y ON Y.EMPNO ='1'                                                             \n" );
						InsertSql.append( "   LEFT JOIN PAYROLL.HCDEPT H ON H.DEPTCD =A.DEPTCD                                                           \n" );
						
						if(strTaxGb.equals("D")){ // 개성 건은 구현진 씨....-->이윤석차장
							//InsertSql.append( "   LEFT JOIN HDASAN_EDI.XXSB_DTI_SM_USER X ON X.FND_USER = '2110003' AND X.FND_REGNO = '"+strRegno+"'       \n" );
							InsertSql.append( "   LEFT JOIN HDASAN_EDI.XXSB_DTI_SM_USER X ON X.FND_USER = '1990044' AND X.FND_REGNO = '"+strRegno+"'     \n" );
						}else{
							InsertSql.append( "   LEFT JOIN HDASAN_EDI.XXSB_DTI_SM_USER X ON X.FND_USER = A.EMPNO AND X.FND_REGNO = '"+strRegno+"'       \n" );
						}
						
						InsertSql.append( "   LEFT JOIN ACCOUNT.CUSTOMER J ON A.VEND_CD = J.VEND_CD AND A.SEQ = J.SEQ                                    \n" );
						InsertSql.append( "  WHERE A.TAXNBR ='"+strTaxnbr+"'                                                                             \n" );
						InsertSql.append( "    AND A.VEND_CD = B.VEND_CD                                                                                 \n" );			
						InsertSql.append( "    AND A.EXTCHK<>'1'                                                                                         \n" );		
						
						//MAIN
						
						//System.out.println("InsertSql.toString() \n"+InsertSql.toString());

						gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);  
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
						InsertSql2.append( "        '2' AS DIRECTION,                                                                                  \n" );
						InsertSql2.append( "        CAST(Z.TAXSEQ AS INTEGER) AS DTI_LINE_NUM,  '' AS ITEM_CODE,  Z.TAXPDTNAM AS ITEM_NAME,            \n" );
						InsertSql2.append( "        Z.TAXSTD AS ITEM_SIZE,                                                                             \n" );
						InsertSql2.append( "        CAST(SUBSTR(A.TAXDAT,1,4)||'-'||SUBSTR(A.TAXDAT,5,2)||'-'||SUBSTR(A.TAXDAT,7,2)AS DATE) AS ITEM_MD,\n" );
						InsertSql2.append( "        Z.TAXPRIC AS UNIT_PRICE,  Z.TAXQTY  AS ITEM_QTY,  Z.TAXSUM  AS SUP_AMOUNT,                         \n" );
						InsertSql2.append( "        Z.TAXVATAMT AS TAX_AMOUT, 0 FOREIGN_AMOUNT,       '' CURRENCY_CODE,       Z.BIGO AS REMARK,        \n" );
						InsertSql2.append( "        '' AS CREATED_BY, sysdate, '' AS  LAST_UPDATED_BY, sysdate                     \n" );
						InsertSql2.append( "   FROM ACCOUNT.ATTAXDTL Z, ACCOUNT.ATTAXMST A, ACCOUNT.GCZM_VENDER B                                      \n" );
						InsertSql2.append( "  WHERE A.TAXNBR = '"+strTaxnbr+"'                                                                         \n" );
						InsertSql2.append( "    AND Z.TAXNBR = A.TAXNBR                                                                                \n" );
						InsertSql2.append( "    AND A.VEND_CD = B.VEND_CD                                                                              \n" );

						//ITEM
						
						//System.out.println("InsertSql2.toString() \n"+InsertSql2.toString());
						gsmt = conn.getGauceStatement(InsertSql2.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						InsertSql2=null;

						//전자세금계산서 STATUS
						InsertSql3 = new StringBuffer();
						InsertSql3.append( " INSERT INTO HDASAN_EDI.XXSB_DTI_STATUS                                                      \n" );
						InsertSql3.append( "  SELECT '"+str_Coversation_id+"' ,                                                          \n" );
						InsertSql3.append( " 				CASE WHEN A.TAXIODIV IN ('A','C') THEN 'AP'                                  \n" );
						InsertSql3.append( " 						 WHEN A.TAXIODIV IN ('B','D') THEN 'AR' END  AS SUPBUY_TYPE,         \n" );
						InsertSql3.append( " 				'2' AS DIRECTION,                                                            \n" );
						InsertSql3.append( " 				'S' AS DTI_STATUS,                                                           \n" );
						InsertSql3.append( " 				0 AS SUP_PRINT_CNT,                                                          \n" );
						InsertSql3.append( " 				0 AS BYR_PRINT_CNT,                                                          \n" );
						InsertSql3.append( " 				'' AS RETURN_CODE,                                                           \n" );
						InsertSql3.append( " 				'' AS RETURN_DESCRIPTION,                                                    \n" );
						InsertSql3.append( " 				'' AS SBDESCRIPTION,                                                         \n" );
						InsertSql3.append( " 				'' AS CREATED_BY, sysdate, '' AS  LAST_UPDATED_BY, sysdate                   \n" );
						InsertSql3.append( " 				FROM ACCOUNT.ATTAXMST A,  ACCOUNT.GCZM_VENDER B                              \n" );
						InsertSql3.append( " WHERE A.TAXNBR ='"+strTaxnbr+"'                                                             \n" );
						InsertSql3.append( "   AND A.VEND_CD = B.VEND_CD                                                                 \n" );

						
						//System.out.println("InsertSql3.toString() \n"+InsertSql3.toString());
						//STATUS
						gsmt = conn.getGauceStatement(InsertSql3.toString());
						gsmt.setGauceDataRow(rows[j]);  
						//gsmt.bindColumn(1, idxTAXNBR);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						InsertSql3=null;

						/////////////////////////////////////////////////////////////////////////////
						//ATTAXMST 에 매출 키값 저장
						//CONVERSATION_ID, SUPBUY_TYPE, DIRECTION  UPDATE 함
						//발행여부 TAXPRTYN ='Y'   'Y'-발행  'N'-미발행 
						//TAXCNT - 발행건수 
						/////////////////////////////////////////////////////////////////////////////

						UpdateSql4 = new StringBuffer();
						UpdateSql4.append( " UPDATE ACCOUNT.ATTAXMST SET  \n" );
						UpdateSql4.append( "        CONVERSATION_ID = '"+str_Coversation_id+"', \n" );
						UpdateSql4.append( "        SUPBUY_TYPE = 'AR', \n" );
						UpdateSql4.append( "        DIRECTION ='2',     \n" );
						UpdateSql4.append( "        TAXPRTYN ='Y',      \n" );
						UpdateSql4.append( "        TAXCNT = COALESCE(TAXCNT,0)+1 \n" );
						UpdateSql4.append( "  WHERE TAXNBR = '"+strTaxnbr+"' \n" );

						//System.out.println("UpdateSql4.toString() \n"+UpdateSql4.toString());
						gsmt = conn.getGauceStatement(UpdateSql4.toString());
						gsmt.setGauceDataRow(rows[j]);
						//gsmt.bindColumn(1, idxTAXNBR);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						UpdateSql4=null;
					}//if
				}//for


				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

		        //스마트빌 ID, PW 조회 >>>>>>>>>>>
		        sql9 = new StringBuffer();
		        sql9.append( " SELECT SMART_ID, SMART_PASSWORD     		\n" ); 
				sql9.append( " 	 FROM HDASAN_EDI.XXSB_DTI_SM_USER  		\n" ); 
				sql9.append( "  WHERE FND_USER ='"+strEmpno+"'     		\n" ); 
				sql9.append( "    AND FND_REGNO ='"+strRegno+"'    		\n" );
				
				
				//System.out.println("sql9.toString() \n"+sql9.toString());
				stmt9 = conn.createStatement();
				rs9 = stmt9.executeQuery(sql9.toString());
				while(rs9.next()){         
					strID = rs9.getString(1);  
					strPW = rs9.getString(2);  
				}
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
				*********************************************************************************************/
				
				
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