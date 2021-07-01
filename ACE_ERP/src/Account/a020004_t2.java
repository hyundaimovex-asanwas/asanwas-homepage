package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020004_t2 extends HttpServlet{
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

			////////////////////////////////////////////////////////////////////// 
			//2013.01.25. 결재취소시 금강산 관리항목의 금액 빼어주기 
			//금강산 지점만..
			//모든계정이 아니고, 환율원화적용계정만 해당함. 
			//관리항목이 외화금액(1045)일 경우만 (-) 함.
			//////////////////////////////////////////////////////////////////////
			

			double dbldeamt_new=0;    //차감해야할 차변금액
			double dblcramt_new=0;    //차감해야할 대변금액
			double dbldecash_new=0;   //차감해야할 차변현금금액 
			double dblcrcash_new=0;   //차감해야할 대변현금금액
			double dblfodeamt_new=0;  //차감해야할 차변원화금액
			double dblfocramt_new=0;  //차감해야할 대변원화금액


			double dbldetot_3=0;    //일합계잔액시산 차변금액     
			double dblcrtot_3=0;		//일합계잔액시산 대변금액     
			double dbldecash_3=0;		//일합계잔액시산 차변현금금액 
			double dblcrcash_3=0;		//일합계잔액시산 대변현금금액 
			double dbldeuptot_3=0;  //일합계잔액시산 상위차변금액     
			double dblcruptot_3=0;  //일합계잔액시산 상위대변금액     
			double dbldeupcash_3=0; //일합계잔액시산 상위차변현금금액 
			double dblcrupcash_3=0; //일합계잔액시산 상위대변현금금액 
			double dblfodetot_3=0;  //일합계잔액시산 차변원화금액     
			double dblfocrtot_3=0;	//일합계잔액시산 대변원화금액     


			double dbldetot_4=0;    //일관리항목집계 차변금액
			double dblcrtot_4=0;    //일관리항목집계 대변금액
			double dbldeuptot_4=0;  //일관리항목집계 상위차변금액 
			double dblcruptot_4=0;  //일관리항목집계 상위대변금액 
			double dblfodetot_4=0;  //일관리항목집계 차변원화금액
			double dblfocrtot_4=0;  //일관리항목집계 대변원화금액 


			double dbldetot_5=0;    //월합계잔액시산 차변금액         
			double dblcrtot_5=0;   	//월합계잔액시산 대변금액         
			double dbldecash_5=0;  	//월합계잔액시산 차변현금금액     
			double dblcrcash_5=0;  	//월합계잔액시산 대변현금금액     
			double dbldeuptot_5=0; 	//월합계잔액시산 상위차변금액     
			double dblcruptot_5=0; 	//월합계잔액시산 상위대변금액     
			double dbldeupcash_5=0;	//월합계잔액시산 상위차변현금금액 
			double dblcrupcash_5=0;	//월합계잔액시산 상위대변현금금액 
			double dblfodetot_5=0;  //월합계잔액시산 차변원화금액         
			double dblfocrtot_5=0;  //월합계잔액시산 대변원화금액         


			double dbldetot_6=0;     //월관리항목집계 차변금액      
			double dblcrtot_6=0;		 //월관리항목집계 대변금액      
			double dbldeuptot_6= 0;	 //월관리항목집계 상위차변금액  
			double dblcruptot_6= 0;	 //월관리항목집계 상위대변금액  
			double dblfodetot_6=0;   //월관리항목집계 차변원화금액      
			double dblfocrtot_6=0;	 //월관리항목집계 대변원화금액       

      
			String strseq="";
			String strfdcode ="";
			String strfsdat ="";
			String strfsnbr ="";
			String strsgndat ="";
			String straccsgnid="";
			String strempno="";
			String straccsgndat="";
			String straccsgnend="";
			String strfromgb="";
			String strtogb="";
			String strbigo="";
			String strbgtgb="";

			//예산
			double dblresults_yy=0;
			double dblbresults_yy=0;
			double dblresults_mm=0;
			double dblbresults_mm=0;
			String strbgtyy="";
			String strbgtmm="";

			//자금   
			double dbldeamt9=0; 
			double dblcramt9=0;
			double dbldrfamt9=0;
			double dblcrfamt9=0;
			double dbldrfamt9_new=0;  //외화금액
			double dblcrfamt9_new=0;  //외화금액
			String strStatdiv="";
			String strRefcode_9="";   //관리번호
			String strFsrefcd_9="";
			String strFsrefval_9="";

			//반제   
			double dbldeamt10=0; 
			double dblcramt10=0;
			String strStatdiv10="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");  //WRDT
				String str2 = reqGauce.getParameter("v_str2");  //WRID

		/************************************************************************************
		 @ 총계정원장 / 관리항목원장 / 합계잔액 / 관리항목집계 
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");
				int idxFSSEQ        = userSet.indexOfColumn("FSSEQ");
				int idxATCODE       = userSet.indexOfColumn("ATCODE");
				int idxATKORNAM     = userSet.indexOfColumn("ATKORNAM");
				int idxATDECR       = userSet.indexOfColumn("ATDECR");
				int idxREMARK       = userSet.indexOfColumn("REMARK");
				int idxCHAAMT       = userSet.indexOfColumn("CHAAMT");
				int idxDAEAMT       = userSet.indexOfColumn("DAEAMT");
				int idxCOCODE       = userSet.indexOfColumn("COCODE");
				int idxDIVCD        = userSet.indexOfColumn("DIVCD");
				int idxDEPTCD       = userSet.indexOfColumn("DEPTCD");
				int idxDECASH       = userSet.indexOfColumn("DECASH");
				int idxCRCASH       = userSet.indexOfColumn("CRCASH");
				int idxACTDAT       = userSet.indexOfColumn("ACTDAT");
				int idxACTYYMM      = userSet.indexOfColumn("ACTYYMM");
				//	int idxSGNDAT       = userSet.indexOfColumn("SGNDAT"); 
				int idxCHAUPAMT     = userSet.indexOfColumn("CHAUPAMT");
				int idxDAEUPAMT     = userSet.indexOfColumn("DAEUPAMT");
				int idxDEUPCASH     = userSet.indexOfColumn("DEUPCASH");
				int idxCRUPCASH     = userSet.indexOfColumn("CRUPCASH"); 

				String [] strFSREFSEQ = new String []{"FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05",  
													  "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09"}; 

				String [] strFSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
													 "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] strFSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
													  "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idxFSREFSEQ = new int[9];
				for (int i=0;i<strFSREFSEQ.length;i++){
					idxFSREFSEQ[i] = userSet.indexOfColumn(strFSREFSEQ[i]);
				}

				int [] idxFSREFCD = new int[9];
				for (int i=0;i<strFSREFCD.length;i++){
					idxFSREFCD[i] = userSet.indexOfColumn(strFSREFCD[i]);
				}

				int [] idxFSREFVAL = new int[9];
				for (int i=0;i<strFSREFVAL.length;i++){
					idxFSREFVAL[i] = userSet.indexOfColumn(strFSREFVAL[i]);
				}

				//추가된 필드 
				int idxATCURTYPE       = userSet.indexOfColumn("ATCURTYPE");     //역사적환율 구분 -Y
				int idxBGTDIV          = userSet.indexOfColumn("BGTDIV");        //예산본부
				int idxBGTDEPT         = userSet.indexOfColumn("BGTDEPT");       //예산부서
				int idxTYPE_FSREFCD    = userSet.indexOfColumn("TYPE_FSREFCD");  //세목관리항목
				int idxTYPE_FSREFVAL   = userSet.indexOfColumn("TYPE_FSREFVAL"); //세목값
				int idxFSWRKDIV        = userSet.indexOfColumn("FSWRKDIV");      //예산관리타입

				int idxSSDAT           = userSet.indexOfColumn("SSDAT");         //전표일자
				int idxSSNBR           = userSet.indexOfColumn("SSNBR");         //전표번호
  
				int idxEDECASH         = userSet.indexOfColumn("EDECASH");       //차변현금등가물
				int idxECRCASH         = userSet.indexOfColumn("ECRCASH");       //대변현금등가물

				int idxFODEAMT         = userSet.indexOfColumn("FODEAMT");       //외화차변금액
				int idxFOCRAMT         = userSet.indexOfColumn("FOCRAMT");       //외화대변금액
 
				int idxFODECASH        = userSet.indexOfColumn("FODECASH");      //외화차변현금금액
				int idxFOCRCASH        = userSet.indexOfColumn("FOCRCASH");      //외화대변현금금액
           
				int idxFOEDECASH       = userSet.indexOfColumn("FOEDECASH");       //외화차변현금등가물
				int idxFOECRCASH       = userSet.indexOfColumn("FOECRCASH");       //외화대변현금등가물

				int idxFODEUPTOT       = userSet.indexOfColumn("FODEUPTOT");     //외화차변상위금액
				int idxFOCRUPTOT       = userSet.indexOfColumn("FOCRUPTOT");     //외화대변상위금액

				int idxFODEUPCASH      = userSet.indexOfColumn("FODEUPCASH");    //외화차변상위현금
				int idxFOCRUPCASH      = userSet.indexOfColumn("FOCRUPCASH");    //외화대변상위현금

				int idxEXRATE          = userSet.indexOfColumn("EXRATE");        //환율 
				int idxEXRATEDT        = userSet.indexOfColumn("EXRATEDT");      //환율적용월
				int idxEXRATEGB        = userSet.indexOfColumn("EXRATEGB");      //환율구분 1- 역사적환율로 추후 변경없음.

				int idxFUNDDIV         = userSet.indexOfColumn("FUNDDIV");      //자금구분.
				int idxBANJAEYN        = userSet.indexOfColumn("BANJAEYN");     //반제구분

				String [] strFSRVALNM = new String []{"FSRVALNM01","FSRVALNM02","FSRVALNM03","FSRVALNM04","FSRVALNM05",     
													  "FSRVALNM06","FSRVALNM07","FSRVALNM08","FSRVALNM09"}; 
				//관리항목값명
				int [] idxFSRVALNM = new int[9];
				for (int i=0;i<strFSRVALNM.length;i++){
					idxFSRVALNM[i] = userSet.indexOfColumn(strFSRVALNM[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
			
				StringBuffer DeleteSql_1 = null; //총계정원장
				StringBuffer DeleteSql_2 = null; //관리항목원장
				StringBuffer UpdateSql_3 = null; //일합계잔액시산
				StringBuffer UpdateSql_4 = null; //일관리항목집계
				StringBuffer UpdateSql_5 = null; //월합계자액시산
				StringBuffer UpdateSql_6 = null; //월관리항목집계
				StringBuffer InsertSql_7 = null; //총계정원장
				StringBuffer InsertSql_8 = null; //관리항목원장
				
				StringBuffer DeleteSql_9 = null; //현금실사현황

				StringBuffer UpdateSql_999 = null; //상위집계상태
				StringBuffer UpdateSql_9999 = null; //자금신청 지급완료일
				
				DeleteSql_1 = new StringBuffer();
				DeleteSql_2 = new StringBuffer();
				UpdateSql_3 = new StringBuffer();
				UpdateSql_4 = new StringBuffer();
				UpdateSql_5 = new StringBuffer();
				UpdateSql_6 = new StringBuffer();
				InsertSql_7 = new StringBuffer();
				InsertSql_8 = new StringBuffer();
				DeleteSql_9 = new StringBuffer();
				
				
				UpdateSql_999 = new StringBuffer();  //상위집계상태
				UpdateSql_9999 = new StringBuffer();  //자금신청 지급완료일
				

				DeleteSql_1.append( " DELETE FROM  ACCOUNT.GENENLED  " );
				DeleteSql_1.append( "  WHERE FDCODE = ? " );
				DeleteSql_1.append( "    AND ACTDAT = ? " );
				DeleteSql_1.append( "    AND ATCODE = ? " );
				DeleteSql_1.append( "    AND COCODE = ? " );
				DeleteSql_1.append( "    AND FSDAT  = ? " );
				DeleteSql_1.append( "    AND FSNBR  = ? " );
				DeleteSql_1.append( "    AND FSSEQ  = ? " );

				DeleteSql_2.append( " DELETE FROM  ACCOUNT.GENENREF  " );
				DeleteSql_2.append( "  WHERE FDCODE = ? " );
				DeleteSql_2.append( "    AND FSDAT = ? " );
				DeleteSql_2.append( "    AND FSNBR = ? " );
				DeleteSql_2.append( "    AND FSSEQ = ? " );
				DeleteSql_2.append( "    AND FSREFCD = ? " );
				DeleteSql_2.append( "    AND FSREFVAL = ? " );

				UpdateSql_3.append( " UPDATE ACCOUNT.TOTALBAL SET " );
				UpdateSql_3.append( "        DETOT = ?," );
				UpdateSql_3.append( "        CRTOT = ?," );
				UpdateSql_3.append( "        DECASH =?," );
				UpdateSql_3.append( "        CRCASH= ?," );
				UpdateSql_3.append( "        DEUPTOT = ?," );
				UpdateSql_3.append( "        CRUPTOT = ?," );
				UpdateSql_3.append( "        DEUPCASH =?," );
				UpdateSql_3.append( "        CRUPCASH= ?," );
				UpdateSql_3.append( "        FODETOT = ?," );
				UpdateSql_3.append( "        FOCRTOT = ?" );
				UpdateSql_3.append( "  WHERE FDCODE=?" );
				UpdateSql_3.append( "    AND ACTDAT=?" );
				UpdateSql_3.append( "    AND ATCODE=?" );
				UpdateSql_3.append( "    AND COCODE=?" );
				UpdateSql_3.append( "    AND DIVCD=?" );
				UpdateSql_3.append( "    AND DEPTCD=?" );

				UpdateSql_4.append( " UPDATE ACCOUNT.FSREFTOT SET " );
				UpdateSql_4.append( "        DETOT = ?," );
				UpdateSql_4.append( "        CRTOT = ?," );
				UpdateSql_4.append( "        DEUPTOT = ?," );
				UpdateSql_4.append( "        CRUPTOT = ?," );
				UpdateSql_4.append( "        FODETOT = ?," );
				UpdateSql_4.append( "        FOCRTOT = ?" );
				UpdateSql_4.append( "  WHERE FDCODE=?" );
				UpdateSql_4.append( "    AND ACTDAT=?" );
				UpdateSql_4.append( "    AND ATCODE=?" );
				UpdateSql_4.append( "    AND COCODE=?" );
				UpdateSql_4.append( "    AND DIVCD=?" );
				UpdateSql_4.append( "    AND DEPTCD=?" );
				UpdateSql_4.append( "    AND FSREFCD=?" );
				UpdateSql_4.append( "    AND FSREFVAL=?" );

				UpdateSql_5.append( " UPDATE ACCOUNT.MTOTALBAL SET " );
				UpdateSql_5.append( "        DETOT = ?," );
				UpdateSql_5.append( "        CRTOT = ?," );
				UpdateSql_5.append( "        DECASH =?," );
				UpdateSql_5.append( "        CRCASH= ?," );
				UpdateSql_5.append( "        DEUPTOT = ?," );
				UpdateSql_5.append( "        CRUPTOT = ?," );
				UpdateSql_5.append( "        DEUPCASH =?," );
				UpdateSql_5.append( "        CRUPCASH= ?," );
				UpdateSql_5.append( "        FODETOT = ?," );
				UpdateSql_5.append( "        FOCRTOT = ?" );
				UpdateSql_5.append( "  WHERE FDCODE=?" );
				UpdateSql_5.append( "    AND ACTYYMM=?" );
				UpdateSql_5.append( "    AND ATCODE=?" );
				UpdateSql_5.append( "    AND COCODE=?" );
				UpdateSql_5.append( "    AND DIVCD=?" );
				UpdateSql_5.append( "    AND DEPTCD=?" );

				UpdateSql_6.append( " UPDATE ACCOUNT.MFSREFTOT SET " );
				UpdateSql_6.append( "        DETOT = ?," );
				UpdateSql_6.append( "        CRTOT = ?," );
				UpdateSql_6.append( "        DEUPTOT = ?," );
				UpdateSql_6.append( "        CRUPTOT = ?," );
				UpdateSql_6.append( "        FODETOT = ?," );
				UpdateSql_6.append( "        FOCRTOT = ?" );
				UpdateSql_6.append( "  WHERE FDCODE=?" );
				UpdateSql_6.append( "    AND ACTYYMM=?" );
				UpdateSql_6.append( "    AND ATCODE=?" );
				UpdateSql_6.append( "    AND COCODE=?" );
				UpdateSql_6.append( "    AND DIVCD=?" );
				UpdateSql_6.append( "    AND DEPTCD=?" );
				UpdateSql_6.append( "    AND FSREFCD=?" );
				UpdateSql_6.append( "    AND FSREFVAL=?" );

				InsertSql_7.append( " INSERT INTO ACCOUNT.BGTGELED (" );
				InsertSql_7.append( " FDCODE,   ACTDAT,   ATCODE,   COCODE,   FSDAT," );
				InsertSql_7.append( " FSNBR,    FSSEQ,    DEAMT,    CRAMT,    DECASH,  CRCASH " );
				InsertSql_7.append( "  ) " );
				InsertSql_7.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,? ) " ); 
				
				InsertSql_8.append( " INSERT INTO ACCOUNT.BGTGEREF (" );
				InsertSql_8.append( " FDCODE,  FSDAT,   FSNBR,   FSSEQ,   FSREFCD, FSREFVAL " );
				InsertSql_8.append( "  ) " );
				InsertSql_8.append( " VALUES (?,?,?,?,?,?) " ); 
				
				
				DeleteSql_9.append( " DELETE FROM ACCOUNT.CASHHAND  " );
				DeleteSql_9.append( "  WHERE FDCODE = ? " );
				DeleteSql_9.append( "    AND FSDAT  = ? " );
				DeleteSql_9.append( "    AND FSNBR  = ? " );
				DeleteSql_9.append( "    AND FSSEQ  = ? " );


			  for (int j=0;j<rows.length; j++){
					strfdcode = rows[j].getString(idxFDCODE);
					strfsdat  = rows[j].getString(idxFSDAT);
					strfsnbr  = rows[j].getString(idxFSNBR);
				//	strsgndat = rows[j].getString(idxSGNDAT);
					 	
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//총계정원장의 금액 저장>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						StringBuffer sql_1 = new StringBuffer();
						Statement stmt_1 = null;
						ResultSet rs_1 = null;
				
						dbldeamt_new=0;  
						dblcramt_new=0;  
						dbldecash_new=0; 
						dblcrcash_new=0;  

						//A1.변수초기화
						dblfodeamt_new=0;  
						dblfocramt_new=0;  


						//A2.SELECT 문에 컬럼 추가

						sql_1.append( " SELECT -DEAMT, -CRAMT, -DECASH, -CRCASH, -FODEAMT, -FOCRAMT ");
						sql_1.append( "   FROM ACCOUNT.GENENLED     	 ");
						sql_1.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
						sql_1.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  ");
						sql_1.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
						sql_1.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
						sql_1.append( "    AND FSDAT  ='"+rows[j].getString(idxFSDAT)+"'   ");
						sql_1.append( "    AND FSNBR ='"+rows[j].getString(idxFSNBR)+"'  ");
						sql_1.append( "    AND FSSEQ ='"+rows[j].getString(idxFSSEQ)+"'  ");

						stmt_1 = conn.createStatement();
						rs_1 = stmt_1.executeQuery(sql_1.toString());

						while(rs_1.next())	{
							//strGubun_2="1";
							dbldeamt_new=rs_1.getDouble(1);  
							dblcramt_new=rs_1.getDouble(2);
							dbldecash_new=rs_1.getDouble(3);
							dblcrcash_new=rs_1.getDouble(4);					
						//A3.데이터  
							dblfodeamt_new=rs_1.getDouble(5);  
							dblfocramt_new=rs_1.getDouble(6);
						} 

						rs_1.close();
						stmt_1.close();

						////////////////////////////////////////////////////
						//총계정원장 Delete 
						///////////////////////////////////////////////////////
						GauceStatement gsmt_1 = conn.getGauceStatement(DeleteSql_1.toString());
						gsmt_1.setGauceDataRow(rows[j]);
           
						gsmt_1.bindColumn(1, idxFDCODE);
						gsmt_1.bindColumn(2, idxACTDAT);
						gsmt_1.bindColumn(3, idxATCODE);
						gsmt_1.bindColumn(4, idxCOCODE);
						gsmt_1.bindColumn(5, idxFSDAT);
						gsmt_1.bindColumn(6, idxFSNBR);
						gsmt_1.bindColumn(7, idxFSSEQ);

						gsmt_1.executeUpdate();
						gsmt_1.close();

						///////////////////////////////////////////////////////
						//관리항목원장 Delete 
						///////////////////////////////////////////////////////
						for (int i=0;i<=8;i++){
							if(!rows[j].getString(idxFSREFVAL[i]).equals("")){
								GauceStatement gsmt_2 = conn.getGauceStatement(DeleteSql_2.toString());
								gsmt_2.setGauceDataRow(rows[j]);
								gsmt_2.bindColumn(1, idxFDCODE);
								gsmt_2.bindColumn(2, idxFSDAT);
								gsmt_2.bindColumn(3, idxFSNBR);
								gsmt_2.bindColumn(4, idxFSSEQ);
								gsmt_2.bindColumn(5, idxFSREFCD[i]);
								gsmt_2.bindColumn(6, idxFSREFVAL[i]);

								gsmt_2.executeUpdate();
								gsmt_2.close();
							}//if
						}//for i

						///////////////////////////////////////////////////////
						// 일합계잔액시산 Update 
						///////////////////////////////////////////////////////

						StringBuffer sql_3 = new StringBuffer();
						Statement stmt_3 = null;
						ResultSet rs_3 = null;
	
						dbldetot_3=0;
						dblcrtot_3=0;
						dbldecash_3=0;
						dblcrcash_3=0;
						dbldeuptot_3= 0;   
						dblcruptot_3= 0;   
						dbldeupcash_3= 0;  
						dblcrupcash_3= 0;  

						//A4.변수초기화
						dblfodetot_3=0;
						dblfocrtot_3=0;
						
						//A5.SELECT 문에 컬럼 추가 
				
						sql_3.append( " SELECT DETOT, CRTOT, DECASH, CRCASH, DEUPTOT, CRUPTOT, DEUPCASH, CRUPCASH, FODETOT, FOCRTOT  ");
						sql_3.append( "   FROM ACCOUNT.TOTALBAL     	 ");
						sql_3.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
						sql_3.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  ");
						sql_3.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
						sql_3.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
						sql_3.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
						sql_3.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");

						stmt_3 = conn.createStatement();
						rs_3 = stmt_3.executeQuery(sql_3.toString());

						while(rs_3.next())	{
							dbldetot_3=rs_3.getDouble(1);
							dblcrtot_3=rs_3.getDouble(2);
							dbldecash_3=rs_3.getDouble(3);
							dblcrcash_3=rs_3.getDouble(4);
							dbldeuptot_3=rs_3.getDouble(5);  
							dblcruptot_3=rs_3.getDouble(6);   
							dbldeupcash_3=rs_3.getDouble(7);  
							dblcrupcash_3=rs_3.getDouble(8); 
							
							//A6.변수에 데이터 
							dblfodetot_3=rs_3.getDouble(9);
							dblfocrtot_3=rs_3.getDouble(10);
						}
						rs_3.close();
						stmt_3.close();
					
						GauceStatement gsmt_3 = conn.getGauceStatement(UpdateSql_3.toString());
				
						//기존금액에서 현재 금액을 빼어줌
						dbldetot_3 = dbldetot_3 + dbldeamt_new;
						dblcrtot_3 = dblcrtot_3 + dblcramt_new;
						dbldecash_3 = dbldecash_3 + dbldecash_new;
						dblcrcash_3 = dblcrcash_3 + dblcrcash_new;
						dbldeuptot_3 = dbldeuptot_3 + dbldeamt_new;
						dblcruptot_3 = dblcruptot_3 + dblcramt_new;
						dbldeupcash_3 = dbldeupcash_3 + dbldecash_new;
						dblcrupcash_3 = dblcrupcash_3 + dblcrcash_new;

						//A7.변수에 기존금액  
						dblfodetot_3 = dblfodetot_3 + dblfodeamt_new;
						dblfocrtot_3 = dblfocrtot_3 + dblfocramt_new;
					
						//데이타셋 재설정
						rows[j].setDouble(idxCHAAMT,dbldetot_3);
						rows[j].setDouble(idxDAEAMT,dblcrtot_3);
						rows[j].setDouble(idxDECASH,dbldecash_3);
						rows[j].setDouble(idxCRCASH,dblcrcash_3);
						rows[j].setDouble(idxCHAUPAMT,dbldeuptot_3);
						rows[j].setDouble(idxDAEUPAMT,dblcruptot_3);
						rows[j].setDouble(idxDEUPCASH,dbldeupcash_3);
						rows[j].setDouble(idxCRUPCASH,dblcrupcash_3);

						//A8.데이타셋 재설정  
						rows[j].setDouble(idxFODEAMT,dblfodetot_3);
						rows[j].setDouble(idxFOCRAMT,dblfocrtot_3);
            
						gsmt_3.setGauceDataRow(rows[j]);
					
						gsmt_3.bindColumn(1, idxCHAAMT);
						gsmt_3.bindColumn(2, idxDAEAMT);
						gsmt_3.bindColumn(3, idxDECASH);
						gsmt_3.bindColumn(4, idxCRCASH);
						gsmt_3.bindColumn(5, idxCHAUPAMT);
						gsmt_3.bindColumn(6, idxDAEUPAMT);
						gsmt_3.bindColumn(7, idxDEUPCASH);
						gsmt_3.bindColumn(8, idxCRUPCASH);
						gsmt_3.bindColumn(9, idxFODEAMT);
						gsmt_3.bindColumn(10,idxFOCRAMT);
						gsmt_3.bindColumn(11,idxFDCODE);
						gsmt_3.bindColumn(12,idxACTDAT);
						gsmt_3.bindColumn(13,idxATCODE);
						gsmt_3.bindColumn(14,idxCOCODE);
						gsmt_3.bindColumn(15,idxDIVCD);
						gsmt_3.bindColumn(16,idxDEPTCD);

						//A9 컬럼추가 
						//A10. UpdateSql_3에 컬럼 추가 

						gsmt_3.executeUpdate();
						gsmt_3.close();
			
						///////////////////////////////////////////////////////
						// 일관리항목집계 Update
						///////////////////////////////////////////////////////
						for (int p=0;p<=8;p++){
								if(!rows[j].getString(idxFSREFVAL[p]).equals("")){
									StringBuffer sql_4 = new StringBuffer();
									Statement stmt_4 = null;
									ResultSet rs_4 = null;
								
									dbldetot_4=0;
									dblcrtot_4=0;
									dbldeuptot_4=0;
									dblcruptot_4=0;

									//A11. 변수초기화 
									dblfodetot_4=0;
									dblfocrtot_4=0;

									//A12. SELECT 에 컬럼 추가 
		
									sql_4.append( " SELECT DETOT, CRTOT, DEUPTOT, CRUPTOT, FODETOT, FOCRTOT ");
									sql_4.append( "   FROM ACCOUNT.FSREFTOT     	 ");
									sql_4.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
									sql_4.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  ");
									sql_4.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
									sql_4.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
									sql_4.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
									sql_4.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");
									sql_4.append( "    AND FSREFCD  ='"+rows[j].getString(idxFSREFCD[p])+"'   ");
									sql_4.append( "    AND FSREFVAL ='"+rows[j].getString(idxFSREFVAL[p])+"'  ");

									stmt_4 = conn.createStatement();
									rs_4 = stmt_4.executeQuery(sql_4.toString());

									while(rs_4.next())	{
										dbldetot_4=rs_4.getDouble(1);
										dblcrtot_4=rs_4.getDouble(2);
										dbldeuptot_4=rs_4.getDouble(3);
										dblcruptot_4=rs_4.getDouble(4);

										//A13. 변수에 데이터
										dblfodetot_4=rs_4.getDouble(5);
										dblfocrtot_4=rs_4.getDouble(6);
									}
									
									rs_4.close();
									stmt_4.close();

									GauceStatement gsmt_4 = conn.getGauceStatement(UpdateSql_4.toString());
				
									//기존금액에서 현재 금액을 빼어줌.
									//dbldetot4 = dbldetot4 + rows[j].getDouble(idxCHAAMT);
									//dblcrtot4 = dblcrtot4 + rows[j].getDouble(idxDAEAMT);
									dbldetot_4 = dbldetot_4 + dbldeamt_new;
									dblcrtot_4 = dblcrtot_4 + dblcramt_new;
									dbldeuptot_4 = dbldeuptot_4 + dbldeamt_new;
									dblcruptot_4 = dblcruptot_4 + dblcramt_new;

									//A14. 변수에 데이터
									dblfodetot_4 = dblfodetot_4 + dblfodeamt_new;
									dblfocrtot_4 = dblfocrtot_4 + dblfocramt_new;

									//데이타셋 재설정
									rows[j].setDouble(idxCHAAMT,dbldetot_4);
									rows[j].setDouble(idxDAEAMT,dblcrtot_4);
									rows[j].setDouble(idxCHAUPAMT,dbldeuptot_4);
									rows[j].setDouble(idxDAEUPAMT,dblcruptot_4);
									rows[j].setDouble(idxFODEAMT,dblfodetot_4);
									rows[j].setDouble(idxFOCRAMT,dblfocrtot_4);

									//A15. 변수에 데이터 재설정
									
									gsmt_4.setGauceDataRow(rows[j]);
								
									gsmt_4.bindColumn(1, idxCHAAMT);
									gsmt_4.bindColumn(2, idxDAEAMT);
									gsmt_4.bindColumn(3, idxCHAUPAMT);
									gsmt_4.bindColumn(4, idxDAEUPAMT);
									gsmt_4.bindColumn(5, idxFODEAMT);
									gsmt_4.bindColumn(6, idxFOCRAMT);
									gsmt_4.bindColumn(7, idxFDCODE);
									gsmt_4.bindColumn(8, idxACTDAT);
									gsmt_4.bindColumn(9, idxATCODE);
									gsmt_4.bindColumn(10,idxCOCODE);
									gsmt_4.bindColumn(11,idxDIVCD);
									gsmt_4.bindColumn(12,idxDEPTCD);
									gsmt_4.bindColumn(13,idxFSREFCD[p]);
									gsmt_4.bindColumn(14,idxFSREFVAL[p]);

									//A15. 추가컬럼
									//A16. UpdateSql_4 수정 
					        
									gsmt_4.executeUpdate();
									gsmt_4.close();
								
								}//if
							}//for p

						///////////////////////////////////////////////////////
						// 월합계잔액시산 Update
						///////////////////////////////////////////////////////
						StringBuffer sql_5 = new StringBuffer();
						Statement stmt_5 = null;
						ResultSet rs_5 = null;
						dbldetot_5=0;
						dblcrtot_5=0;
						dbldecash_5=0;
						dblcrcash_5=0;
						dbldeuptot_5=0; 
						dblcruptot_5=0; 
						dbldeupcash_5=0;
						dblcrupcash_5=0;
						
						//A21. 변수초기화
						dblfodetot_5=0;
						dblfocrtot_5=0;
						
						//A22. SELECT 에  컬럼추가 
										
						sql_5.append( " SELECT DETOT, CRTOT, DECASH, CRCASH, DEUPTOT, CRUPTOT, DEUPCASH, CRUPCASH, FODETOT, FOCRTOT ");
						sql_5.append( "   FROM ACCOUNT.MTOTALBAL     	 ");
						sql_5.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
						sql_5.append( "    AND ACTYYMM='"+rows[j].getString(idxACTYYMM)+"' ");
						sql_5.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
						sql_5.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
						sql_5.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
						sql_5.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");

						stmt_5 = conn.createStatement();
						rs_5 = stmt_5.executeQuery(sql_5.toString());
          
						while(rs_5.next())	{
							dbldetot_5=rs_5.getDouble(1);
							dblcrtot_5=rs_5.getDouble(2);
							dbldecash_5=rs_5.getDouble(3);
							dblcrcash_5=rs_5.getDouble(4);
							dbldeuptot_5=rs_5.getDouble(5); 
							dblcruptot_5=rs_5.getDouble(6); 
							dbldeupcash_5=rs_5.getDouble(7);
							dblcrupcash_5=rs_5.getDouble(8);

							//A23. 변수에 데이터
							dblfodetot_5=rs_5.getDouble(9);
							dblfocrtot_5=rs_5.getDouble(10); 
						}

						rs_5.close();
						stmt_5.close();

						//합계잔액(월별)_수정건/////
						GauceStatement gsmt_5 = conn.getGauceStatement(UpdateSql_5.toString());
				
						//기존금액에서 현재 금액을 빼어줌
						dbldetot_5 = dbldetot_5 + dbldeamt_new;
						dblcrtot_5 = dblcrtot_5 + dblcramt_new;
						dbldecash_5 = dbldecash_5 + dbldecash_new;
						dblcrcash_5 = dblcrcash_5 + dblcrcash_new;
						dbldeuptot_5 = dbldeuptot_5 + dbldeamt_new;
						dblcruptot_5 = dblcruptot_5 + dblcramt_new;
						dbldeupcash_5 = dbldeupcash_5 + dbldecash_new;
						dblcrupcash_5 = dblcrupcash_5 + dblcrcash_new;

						//A24. 변수에 데이터
						dblfodetot_5 = dblfodetot_5 + dblfodeamt_new;
						dblfocrtot_5 = dblfocrtot_5 + dblfocramt_new;

						//데이타셋 재설정
						rows[j].setDouble(idxCHAAMT,dbldetot_5);
						rows[j].setDouble(idxDAEAMT,dblcrtot_5);
						rows[j].setDouble(idxDECASH,dbldecash_5);
						rows[j].setDouble(idxCRCASH,dblcrcash_5);
						rows[j].setDouble(idxCHAUPAMT,dbldeuptot_5);
						rows[j].setDouble(idxDAEUPAMT,dblcruptot_5);
						rows[j].setDouble(idxDEUPCASH,dbldeupcash_5);
						rows[j].setDouble(idxCRUPCASH,dblcrupcash_5);

						//A25. 데이터셋 재설정
						rows[j].setDouble(idxFODEAMT,dbldetot_5);
						rows[j].setDouble(idxFOCRAMT,dblcrtot_5);

						gsmt_5.setGauceDataRow(rows[j]);
					
						gsmt_5.bindColumn(1, idxCHAAMT);
						gsmt_5.bindColumn(2, idxDAEAMT);
						gsmt_5.bindColumn(3, idxDECASH);
						gsmt_5.bindColumn(4, idxCRCASH);
						gsmt_5.bindColumn(5, idxCHAUPAMT);
						gsmt_5.bindColumn(6, idxDAEUPAMT);
						gsmt_5.bindColumn(7, idxDEUPCASH);
						gsmt_5.bindColumn(8, idxCRUPCASH);
						gsmt_5.bindColumn(9, idxFODEAMT);
						gsmt_5.bindColumn(10,idxFOCRAMT);
						gsmt_5.bindColumn(11,idxFDCODE);
						gsmt_5.bindColumn(12,idxACTYYMM);
						gsmt_5.bindColumn(13,idxATCODE);
						gsmt_5.bindColumn(14,idxCOCODE);
						gsmt_5.bindColumn(15,idxDIVCD);
						gsmt_5.bindColumn(16,idxDEPTCD);

						//A26. 컬럼 추가 

						//A27. UpdateSql_5 수정

						gsmt_5.executeUpdate();
						gsmt_5.close();


						///////////////////////////////////////////////////////
						// 월관리항목집계 Update
						///////////////////////////////////////////////////////
						///logger.dbg.println(this,"월관리항목집계");
						for (int p2=0;p2<=8;p2++){
							if(!rows[j].getString(idxFSREFVAL[p2]).equals("")){
								StringBuffer sql_6 = new StringBuffer();
								Statement stmt_6 = null;
								ResultSet rs_6 = null;
							
								dbldetot_6=0;
								dblcrtot_6=0;
								dbldeuptot_6= 0;
								dblcruptot_6= 0;

								//A31.변수초기화
								dblfodetot_6=0;
								dblfocrtot_6=0;

								//A32.SELECT에 컬럼 추가  
	
								sql_6.append( " SELECT DETOT, CRTOT, DEUPTOT, CRUPTOT, FODETOT, FOCRTOT ");
								sql_6.append( "   FROM ACCOUNT.MFSREFTOT     	 ");
								sql_6.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
								sql_6.append( "    AND ACTYYMM ='"+rows[j].getString(idxACTYYMM)+"'  ");
								sql_6.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
								sql_6.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
								sql_6.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
								sql_6.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");
								sql_6.append( "    AND FSREFCD  ='"+rows[j].getString(idxFSREFCD[p2])+"'   ");
								sql_6.append( "    AND FSREFVAL ='"+rows[j].getString(idxFSREFVAL[p2])+"'  ");

								//logger.dbg.println(this,"월별 sql_6" +sql_6.toString() );

								stmt_6 = conn.createStatement();
								rs_6 = stmt_6.executeQuery(sql_6.toString());

								while(rs_6.next())	{
									dbldetot_6=rs_6.getDouble(1);
									dblcrtot_6=rs_6.getDouble(2);
									dbldeuptot_6= rs_6.getDouble(3);
									dblcruptot_6= rs_6.getDouble(4);

									//A33.변수에 데이터 담기
									dblfodetot_6=rs_6.getDouble(5);
									dblfocrtot_6=rs_6.getDouble(6);
								}
								rs_6.close();
								stmt_6.close();

								//관리항목집계(월별)_수정건/////
								GauceStatement gsmt_6 = conn.getGauceStatement(UpdateSql_6.toString());
			
								//기존금액에서 현재 금액을 빼어줌.
								//dbldetot4 = dbldetot4 + rows[j].getDouble(idxCHAAMT);
								//dblcrtot4 = dblcrtot4 + rows[j].getDouble(idxDAEAMT);
								dbldetot_6 = dbldetot_6 + dbldeamt_new;
								dblcrtot_6 = dblcrtot_6 + dblcramt_new;
								dbldeuptot_6 = dbldeuptot_6 + dbldeamt_new;
								dblcruptot_6 = dblcruptot_6 + dblcramt_new;

								//A34.변수
								dblfodetot_6 = dblfodetot_6 + dblfodeamt_new;
								dblfocrtot_6 = dblfocrtot_6 + dblfocramt_new; 
								
								//데이타셋 재설정
								rows[j].setDouble(idxCHAAMT,dbldetot_6);
								rows[j].setDouble(idxDAEAMT,dblcrtot_6);
								rows[j].setDouble(idxCHAUPAMT,dbldeuptot_6);
								rows[j].setDouble(idxDAEUPAMT,dblcruptot_6);

								//A35.데이터셋 재설정
								rows[j].setDouble(idxFODEAMT,dblfodetot_6);
								rows[j].setDouble(idxFOCRAMT,dblfocrtot_6);

								gsmt_6.setGauceDataRow(rows[j]);
								gsmt_6.bindColumn(1, idxCHAAMT);
								gsmt_6.bindColumn(2, idxDAEAMT);
								gsmt_6.bindColumn(3, idxCHAUPAMT);
								gsmt_6.bindColumn(4, idxDAEUPAMT);
								gsmt_6.bindColumn(5, idxFODEAMT);
								gsmt_6.bindColumn(6, idxFOCRAMT);
								gsmt_6.bindColumn(7, idxFDCODE);
								gsmt_6.bindColumn(8, idxACTYYMM);
								gsmt_6.bindColumn(9, idxATCODE);
								gsmt_6.bindColumn(10,idxCOCODE);
								gsmt_6.bindColumn(11,idxDIVCD);
								gsmt_6.bindColumn(12,idxDEPTCD);
								gsmt_6.bindColumn(13,idxFSREFCD[p2]);
								gsmt_6.bindColumn(14,idxFSREFVAL[p2]);

								//A36.컬럼추가 
								//A37.UpdateSql_6 수정
				
								gsmt_6.executeUpdate();
								gsmt_6.close();
							}//if
						}//for p2

					
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//예산부서 Start 7 
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						if(!rows[j].getString(idxBGTDIV).equals("")&&!rows[j].getString(idxBGTDEPT).equals("")&&!rows[j].getString(idxTYPE_FSREFVAL).equals("")){

						strbgtyy = rows[j].getString(idxACTDAT);
						strbgtmm = strbgtyy.substring(4,6);
						strbgtyy = strbgtyy.substring(0,4);
            
						//================================================ 
						// 예산총계정원장    INSERT
						// 예산관리항목원장  INSERT
						//================================================ 
						GauceStatement gsmt7 = conn.getGauceStatement(InsertSql_7.toString());
						gsmt7.setGauceDataRow(rows[j]);
            
						/*
						logger.dbg.println(this,"step11111");
						logger.dbg.println(this,"idxCHAAMT:"+rows[j].getDouble(idxCHAAMT));
						logger.dbg.println(this,"idxDAEAMT:"+rows[j].getDouble(idxDAEAMT));
						logger.dbg.println(this,"idxDECASH:"+rows[j].getDouble(idxDECASH));
						logger.dbg.println(this,"idxCRCASH:"+rows[j].getDouble(idxCRCASH));
						logger.dbg.println(this,"idxACTDAT:"+rows[j].getString(idxACTDAT));
						*/	
										
						rows[j].setDouble(idxCHAAMT,-dbldeamt_new);
						rows[j].setDouble(idxDAEAMT,-dblcramt_new);

						gsmt7.bindColumn(1, idxFDCODE);
						gsmt7.bindColumn(2, idxACTDAT);
						gsmt7.bindColumn(3, idxATCODE);
						gsmt7.bindColumn(4, idxCOCODE);
						gsmt7.bindColumn(5, idxFSDAT);
						gsmt7.bindColumn(6, idxFSNBR);
						gsmt7.bindColumn(7, idxFSSEQ);
						gsmt7.bindColumn(8, idxCHAAMT);
						gsmt7.bindColumn(9, idxDAEAMT);
						gsmt7.bindColumn(10,idxDECASH);
						gsmt7.bindColumn(11,idxCRCASH);

						gsmt7.executeUpdate();
						gsmt7.close();
             
						//총계정원장_관리항목원장//////////////////////////////////////////////////////////////////////////////
						for (int i=0;i<=8;i++){
							if(!rows[j].getString(idxFSREFVAL[i]).equals("")){
									GauceStatement gsmt8 = conn.getGauceStatement(InsertSql_8.toString());
									gsmt8.setGauceDataRow(rows[j]);
									gsmt8.bindColumn(1, idxFDCODE);
									gsmt8.bindColumn(2, idxFSDAT);
									gsmt8.bindColumn(3, idxFSNBR);
									gsmt8.bindColumn(4, idxFSSEQ);
									gsmt8.bindColumn(5, idxFSREFCD[i]);
									gsmt8.bindColumn(6, idxFSREFVAL[i]);
									gsmt8.executeUpdate();
									gsmt8.close();
							}
						}

						//================================================ 
						// 예산 MST   UPDATE  (실적 = 실적 - 금액)
						// 예산 DTL   UPDATE  (결재전실적 = 결재전 실적 + 금액)
						//================================================ 

						dblresults_yy=0;
						dblbresults_yy=0;
						dblresults_mm=0;
						dblbresults_mm=0;

						Statement stmt8_1 = conn.createStatement();
						StringBuffer sql8_1 = new StringBuffer();
						sql8_1.append( " SELECT RESULTS,BRESULTS   " );
						sql8_1.append( "   FROM ACCOUNT.BGTMST     " );
						sql8_1.append( "  WHERE FDCODE = '"+strfdcode+"'" );
						sql8_1.append( "    AND BGTYY = '"+strbgtyy+"'" );
						sql8_1.append( "    AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'" );
						sql8_1.append( "    AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'" );
						sql8_1.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
						sql8_1.append( "    AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'" );
						sql8_1.append( "   AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'");
											
						ResultSet rs8_1 = stmt8_1.executeQuery(sql8_1.toString()); 

						if(rs8_1.next()){
							dblresults_yy = rs8_1.getDouble(1);
							dblbresults_yy= rs8_1.getDouble(2);
						}
						rs8_1.close();
						stmt8_1.close();

						dblresults_yy=dblresults_yy+dbldeamt_new+dblcramt_new;   //실적
						dblbresults_yy=dblbresults_yy-dbldeamt_new-dblcramt_new; //결재전실적
            
						StringBuffer sql8_2 = new StringBuffer();
						sql8_2.append( " UPDATE ACCOUNT.BGTMST SET  " );
						sql8_2.append( "        RESULTS = "+dblresults_yy+"," );
						sql8_2.append( "        BRESULTS ="+dblbresults_yy );
						sql8_2.append( "  WHERE FDCODE = '"+strfdcode+"'" );
						sql8_2.append( "    AND BGTYY = '"+strbgtyy+"'" );
						sql8_2.append( "    AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'" );
						sql8_2.append( "    AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'" );
						sql8_2.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
						sql8_2.append( "    AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'" );
						sql8_2.append( "    AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'");
													 	
						GauceStatement gsmt8_2 = conn.getGauceStatement(sql8_2.toString());
						gsmt8_2.executeUpdate();
						gsmt8_2.close();
					
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//예산관리 Dtl 실적 (+)   결재전 실적(-)  승인 :Y  (update) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						Statement stmt8_3 = conn.createStatement();
						StringBuffer sql8_3 = new StringBuffer();
						sql8_3.append( " SELECT RESULTS,BRESULTS   " );
						sql8_3.append( "   FROM ACCOUNT.BGTDTL    " );
						sql8_3.append( "  WHERE FDCODE = '"+strfdcode+"'" );
						sql8_3.append( "    AND BGTYY = '"+strbgtyy+"'" );
						sql8_3.append( "    AND BGTMM= '"+strbgtmm+"'" );
						sql8_3.append( "    AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'" );
						sql8_3.append( "    AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'" );
						sql8_3.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
						sql8_3.append( "    AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'" );
						sql8_3.append( "    AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'");
						ResultSet rs8_3 = stmt8_3.executeQuery(sql8_3.toString()); 

						dblresults_mm =0;
						dblbresults_mm=0;
						if(rs8_3.next()){
							dblresults_mm = rs8_3.getDouble(1);
							dblbresults_mm =rs8_3.getDouble(2);
						}
						rs8_3.close();
						stmt8_3.close();

						dblresults_mm=dblresults_mm+dbldeamt_new+dblcramt_new;   //실적
						dblbresults_mm=dblbresults_mm-dbldeamt_new-dblcramt_new; //결재전실적

						StringBuffer sql8_4 = new StringBuffer();
						sql8_4.append( " UPDATE ACCOUNT.BGTDTL SET  " );
						sql8_4.append( "        RESULTS = "+dblresults_mm+","  );
						sql8_4.append( "        BRESULTS ="+dblbresults_mm  );
						sql8_4.append( " WHERE FDCODE = '"+strfdcode+"'"  );
						sql8_4.append( "   AND BGTYY = '"+strbgtyy+"'"  );
						sql8_4.append( "   AND BGTMM ='"+strbgtmm+"'"  );
						sql8_4.append( "   AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'"  );
						sql8_4.append( "   AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'"  );
						sql8_4.append( "   AND ATCODE = '"+rows[j].getString(idxATCODE)+"'"  );
						sql8_4.append( "   AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'"  );
						sql8_4.append( "   AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'" );
														
						GauceStatement gsmt8_4 = conn.getGauceStatement(sql8_4.toString());
						gsmt8_4.executeUpdate();
						gsmt8_4.close();

					}
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//예산부서 End
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
          
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//자금관리원장 Start>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 
					if(!rows[j].getString(idxFUNDDIV).equals("")&&!rows[j].getString(idxFUNDDIV).equals("00")){ 
						
						//strRefcode_9 찾기////////////////////////////////////////////////////////////////////////////
						if(rows[j].getString(idxFUNDDIV).equals("10")||rows[j].getString(idxFUNDDIV).equals("20")||rows[j].getString(idxFUNDDIV).equals("30")){
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("0023")){
									 if(rows[j].getString(idxFSRVALNM[p]).equals("")){
											strRefcode_9 = rows[j].getString(idxFSREFVAL[p]);
									 }else{
										 strRefcode_9 = rows[j].getString(idxFSRVALNM[p]);
									 }
									 strFsrefcd_9=rows[j].getString(idxFSREFCD[p]);
									 strFsrefval_9=rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
						}else if(rows[j].getString(idxFUNDDIV).equals("40")){
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("0023")){
									if(rows[j].getString(idxFSRVALNM[p]).equals("")){
											strRefcode_9 = rows[j].getString(idxFSREFVAL[p]);
									 }else{
										 strRefcode_9 = rows[j].getString(idxFSRVALNM[p]);
									 }
									 strFsrefcd_9=rows[j].getString(idxFSREFCD[p]);
									 strFsrefval_9=rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
						}else if(rows[j].getString(idxFUNDDIV).equals("50")||rows[j].getString(idxFUNDDIV).equals("60")){
							for (int p=0;p<=8;p++){  
								if(rows[j].getString(idxFSREFCD[p]).equals("0967")||rows[j].getString(idxFSREFCD[p]).equals("1102")){
									if(rows[j].getString(idxFSRVALNM[p]).equals("")){
											strRefcode_9 = rows[j].getString(idxFSREFVAL[p]);
									 }else{
										 strRefcode_9 = rows[j].getString(idxFSRVALNM[p]);
									 }
									 strFsrefcd_9=rows[j].getString(idxFSREFCD[p]);
									 strFsrefval_9=rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
						}	
						///////////////////////////////////////////////////////////////////////////////////////////


						//외화금액 찾기////////////////////////////////////////////////////////////////////////////
						for (int p=0;p<=8;p++){
							if(rows[j].getString(idxFSREFCD[p]).equals("1045")){
								
								 //2016.04.04 jys test
								 if(rows[j].getString(idxFSREFVAL[p]).equals("-")){
									 rows[j].setString(idxFSREFVAL[p],"0");
								 }
								
								 if(dbldeamt_new!=0&&dblcramt_new==0){
										dbldrfamt9_new = Double.parseDouble(rows[j].getString(idxFSREFVAL[p]));   //외화차변
									break;
								 }else if(dbldeamt_new==0&&dblcramt_new!=0){
										dblcrfamt9_new = Double.parseDouble(rows[j].getString(idxFSREFVAL[p]));   //외화대변
									break;
								 }
							}	  
						}
						///////////////////////////////////////////////////////////////////////////////////////////

						//조회 자금관리원장 조회
						Statement stmt9 = conn.createStatement();
						StringBuffer sql9 = new StringBuffer();
						sql9.append( " SELECT DRAMT, CRAMT, DRFAMT, CRFAMT " );
						sql9.append( "   FROM ACCOUNT.AFUNDLDG    " );
						sql9.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql9.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
						sql9.append( "    AND FUNDDIV= '"+rows[j].getString(idxFUNDDIV)+"'" );
						sql9.append( "    AND REFCODE2 = '"+strRefcode_9+"'"); 			
						ResultSet rs9 = stmt9.executeQuery(sql9.toString()); 

						dbldeamt9=0;
						dblcramt9=0;
						dbldrfamt9=0;
						dblcrfamt9=0;

						if(rs9.next()){
		
							dbldeamt9 = rs9.getDouble(1);
							dblcramt9 = rs9.getDouble(2);
							dbldrfamt9 =rs9.getDouble(3);
							dblcrfamt9 =rs9.getDouble(4);
						}
						rs9.close();
						stmt9.close();

						dbldeamt9 = dbldeamt9+dbldeamt_new; 
						dblcramt9 = dblcramt9+dblcramt_new;
						dbldrfamt9 = dbldrfamt9+dbldrfamt9_new;
						dblcrfamt9 = dblcrfamt9+dblcrfamt9_new;

						//처리구분/////////////////////////////////////////////////////////////////////////////////
						//예금은 항상 0 - 진행중임.
						//그외 : 차변 금액과 대변금액이 동일하면 - 1 완료 (차변과 대변이 0이 아님)
						if(rows[j].getString(idxFUNDDIV).equals("10")){
							strStatdiv="0";
						}else{
							if(dbldeamt9!=0&&dblcramt9!=0&&dblcramt9==dblcramt9){
								strStatdiv="1";
							}else{
								strStatdiv="0";
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////

							StringBuffer sql9_1 = new StringBuffer();
							sql9_1.append( " UPDATE ACCOUNT.AFUNDLDG SET  ");
							sql9_1.append( "        DRAMT = "+dbldeamt9+"," );
							sql9_1.append( "        CRAMT = "+dblcramt9+"," );
							sql9_1.append( "        DRFAMT = "+dbldrfamt9+"," );
							sql9_1.append( "        CRFAMT = "+dblcrfamt9+"," );
							sql9_1.append( "        STATDIV = '"+strStatdiv+"'," );
							sql9_1.append( "        UPDT = '"+str1+"'," );
							sql9_1.append( "        UPID = '"+str2+"'" );
							sql9_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
							sql9_1.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
							sql9_1.append( "    AND FUNDDIV= '"+rows[j].getString(idxFUNDDIV)+"'" );
							sql9_1.append( "    AND REFCODE2 = '"+strRefcode_9+"'");	
														 
							GauceStatement gsmt9_1 = conn.getGauceStatement(sql9_1.toString());
							gsmt9_1.executeUpdate();
							gsmt9_1.close();
   
							/////////////////////////////////////////////
							//어음수표수불부 update
							//지급어음 전표 발생에 해당 될경우  0-->1
							/////////////////////////////////////////////
							if(rows[j].getString(idxFUNDDIV).equals("60")&&dbldeamt_new==0&&dblcramt_new!=0){
								StringBuffer sql9_3 = new StringBuffer();
								sql9_3.append( " UPDATE ACCOUNT.ABILLCHK SET  " );
								sql9_3.append( "        STATDIV = '0'," );
								sql9_3.append( "        UPDT = '"+str1+"'," );
								sql9_3.append( "        UPID = '"+str2+"'" );
								sql9_3.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
								sql9_3.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
								sql9_3.append( "    AND FUNDDIV= '"+rows[j].getString(idxFUNDDIV)+"'" );
								sql9_3.append( "    AND REFCODE2 = '"+strRefcode_9+"'"); 	
															 
								GauceStatement gsmt9_3 = conn.getGauceStatement(sql9_3.toString());
								gsmt9_3.executeUpdate();
								gsmt9_3.close();
							}
		  }
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//자금관리원장 End>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 

					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//반제원장      Start       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//반제계정이면서, 기준차대인건은 반제 발생건임. 
					//예> 법인카드미지급금, 대변 ,  대변금액이 <> 0
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					if(rows[j].getString(idxBANJAEYN).equals("Y")){
						if((rows[j].getString(idxATDECR).equals("1")&&dbldeamt_new!=0)||(rows[j].getString(idxATDECR).equals("2")&&dblcramt_new!=0)){
							//Data 조회 후 update 및 Delete
							//조회

							Statement stmt10 = conn.createStatement();
							StringBuffer sql10 = new StringBuffer();
							sql10.append( " SELECT DEAMT, CRAMT, STATUS " );
							sql10.append( "   FROM ACCOUNT.BANJAEMST    " );
							sql10.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
							sql10.append( "    AND TSDAT = '"+rows[j].getString(idxFSDAT)+"'" );
							sql10.append( "    AND TSNBR = '"+rows[j].getString(idxFSNBR)+"'" );
							sql10.append( "    AND TSSEQ = '"+rows[j].getString(idxFSSEQ)+"'");			
							ResultSet rs10 = stmt10.executeQuery(sql10.toString()); 

							dbldeamt10=0;
							dblcramt10=0;
						
							if(rs10.next()){
								dbldeamt10 = rs10.getDouble(1);
								dblcramt10 = rs10.getDouble(2);							
							}
							rs10.close(); 
							stmt10.close();

							dbldeamt10 = dbldeamt10+dbldeamt_new; 
							dblcramt10 = dblcramt10+dblcramt_new;

							if(dbldeamt10==0&&dblcramt10==0){  //Delete
							  StringBuffer sql10_1 = new StringBuffer();
								sql10_1.append( " DELETE FROM ACCOUNT.BANJAEMST   ");
								sql10_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'");
								sql10_1.append( "    AND TSDAT = '"+rows[j].getString(idxFSDAT)+"'");
								sql10_1.append( "    AND TSNBR = '"+rows[j].getString(idxFSNBR)+"'");
								sql10_1.append( "    AND TSSEQ = '"+rows[j].getString(idxFSSEQ)+"'");		
													 
								GauceStatement gsmt10_1 = conn.getGauceStatement(sql10_1.toString());
								gsmt10_1.executeUpdate();
								gsmt10_1.close();
 
							}else{                             //Update
								if(dbldeamt10==dblcramt10){
									strStatdiv10="1";
								}else{
									strStatdiv10="0";	
								}
								StringBuffer sql10_1 = new StringBuffer();
								sql10_1.append( " UPDATE ACCOUNT.BANJAEMST SET  ");
								sql10_1.append( "        DEAMT = "+dbldeamt10+"," );
								sql10_1.append( "        CRAMT = "+dblcramt10+"," );
								sql10_1.append( "        STATUS = '"+strStatdiv10+"'," );
								sql10_1.append( "        UPDT = '"+str1+"'," );
								sql10_1.append( "       UPID = '"+str2+"'" );
								sql10_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
								sql10_1.append( "    AND TSDAT = '"+rows[j].getString(idxFSDAT)+"'" );
								sql10_1.append( "    AND TSNBR = '"+rows[j].getString(idxFSNBR)+"'" );
								sql10_1.append( "    AND TSSEQ = '"+rows[j].getString(idxFSSEQ)+"'");		
													 
								GauceStatement gsmt10_1 = conn.getGauceStatement(sql10_1.toString());
								gsmt10_1.executeUpdate();
								gsmt10_1.close();
							}
						}
					}
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//반제원장      End         >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//현금실사현황     START       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					//System.out.println("DeleteSql_9.toString();;"+DeleteSql_9.toString());
					
					//System.out.println("idxFDCODE;"+rows[j].getString(idxFDCODE));
					//System.out.println("idxFSDAT;"+rows[j].getString(idxFSDAT));
					//System.out.println("idxFSNBR;"+rows[j].getString(idxFSNBR));
					//System.out.println("idxFSSEQ;"+rows[j].getString(idxFSSEQ));
					
					GauceStatement gsmt_9 = conn.getGauceStatement(DeleteSql_9.toString());
					
					gsmt_9.setGauceDataRow(rows[j]);
								
					gsmt_9.bindColumn(1, idxFDCODE);
					gsmt_9.bindColumn(2, idxFSDAT);
					gsmt_9.bindColumn(3, idxFSNBR);
					gsmt_9.bindColumn(4, idxFSSEQ);
					
					gsmt_9.executeUpdate();
					gsmt_9.close();
					
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//현금실사현황     END       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
				    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//전표Mst && 결재완료 Update>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					if(!strfdcode.equals("")&&!strfsdat.equals("")&&!strfsnbr.equals("")){
							StringBuffer sql99 = new StringBuffer();
							sql99.append( " UPDATE  ACCOUNT.FSLIPMST SET " );
							sql99.append( "         FSSTAT = 'C'," );
							sql99.append( "         SSDAT = ''," );
							sql99.append( "         SSNBR = ''" );
													 //+ "         SGNDAT = '"+strsgndat+"'"
							sql99.append( "  WHERE  FDCODE = '"+strfdcode+"'" );
							sql99.append( "    AND  FSDAT  = '"+strfsdat+"'" );
							sql99.append( "    AND  FSNBR  = '"+strfsnbr+"'");
													
							GauceStatement gsmt99 = conn.getGauceStatement(sql99.toString());
							gsmt99.executeUpdate();
							gsmt99.close();

							StringBuffer sql100 = new StringBuffer();
							sql100.append( " UPDATE  ACCOUNT.FSLIPDTL SET " );
							sql100.append( "         SSDAT = ''," );
							sql100.append( "         SSNBR = ''" );
							sql100.append( "  WHERE  FDCODE = '"+strfdcode+"'" );
							sql100.append( "    AND  FSDAT  = '"+strfsdat+"'" );
							sql100.append( "    AND  FSNBR  = '"+strfsnbr+"'");

							GauceStatement gsmt100 = conn.getGauceStatement(sql100.toString());
							gsmt100.executeUpdate();
							gsmt100.close();

              
							StringBuffer sql101 = new StringBuffer();
							sql101.append( " UPDATE  ACCOUNT.FSLIPREF SET " );
							sql101.append( "         SSDAT = ''," );
							sql101.append( "         SSNBR = ''" );
							sql101.append( "  WHERE  FDCODE = '"+strfdcode+"'" );
							sql101.append( "    AND  FSDAT  = '"+strfsdat+"'" );
							sql101.append( "    AND  FSNBR  = '"+strfsnbr+"'");

							GauceStatement gsmt101 = conn.getGauceStatement(sql101.toString());
							gsmt101.executeUpdate();
							gsmt101.close();

							////////////////////////////////////////////////////
							//Detail건수와 상관없이 전표번호 당 1건 저장
							////////////////////////////////////////////////////
						
							if(j==0){
								Statement stmt_10 = conn.createStatement();
								StringBuffer sql_10 = new StringBuffer();
								sql_10.append( " SELECT SEQ,ACCSGNID,");
								sql_10.append( "        EMPNO,ACCSGNDAT,ACCSGNEND,FROMGB,TOGB, BIGO,BGTGB  ");
								sql_10.append( "   FROM ACCOUNT.ACTSGNSTS " );
								sql_10.append( "  WHERE FDCODE='"+strfdcode+"'");  
								sql_10.append( "    AND FSDAT='"+strfsdat+"'");  
								sql_10.append( "    AND FSNBR='"+strfsnbr+"'");  
								sql_10.append( "    AND SEQ  = (SELECT MAX(B.SEQ) FROM ACCOUNT.ACTSGNSTS B");
								sql_10.append( "                  WHERE  FDCODE = B.FDCODE ");
								sql_10.append( "                    AND  FSDAT = B.FSDAT   ");
								sql_10.append( "                    AND  FSNBR = B.FSNBR   ");
								sql_10.append( "                    AND  B.FDCODE = '"+strfdcode+"'");
								sql_10.append( "                    AND  B.FSDAT ='"+strfsdat+"'" );  
								sql_10.append( "                    AND  B.FSNBR = '"+strfsnbr+"')"); 
								ResultSet rs_10 = stmt_10.executeQuery(sql_10.toString()); 

								//logger.dbg.println(this,"000::"+sql_10.toString());
								
								if(rs_10.next()){
									strseq= rs_10.getString(1);
									straccsgnid= rs_10.getString(2);
									strempno= rs_10.getString(3);
									straccsgndat= rs_10.getString(4);
									straccsgnend="C";
									strfromgb= "05";
									strtogb= "03";
									strbigo= rs_10.getString(8);
									strbgtgb= rs_10.getString(9);
								}
								rs_10.close();
								stmt_10.close();

								int ichk = Integer.parseInt(strseq)+1;
									strseq = String.valueOf(ichk);
								if(ichk<10) strseq = "0"+strseq;
								StringBuffer sql10 = new StringBuffer();
								sql10.append( "  INSERT INTO ACCOUNT.ACTSGNSTS ( " );
								sql10.append( "  FDCODE, FSDAT, FSNBR, SEQ, ACCSGNID, EMPNO, " );
								sql10.append( "  ACCSGNDAT, ACCSGNEND, FROMGB, TOGB, BIGO,BGTGB, " );
								sql10.append( "  WRDT, WRID " );
								sql10.append( "  ) VALUES ( " );
								sql10.append( "  '"+strfdcode+"'," );
								sql10.append( "  '"+strfsdat+"'," );
								sql10.append( "  '"+strfsnbr+"'," );
								sql10.append( "  '"+strseq+"'," );
								sql10.append( "  '"+straccsgnid+"'," );
								sql10.append( "  '"+strempno+"'," );
								sql10.append( "  '"+straccsgndat+"'," );
								sql10.append( "  '"+straccsgnend+"'," );
								sql10.append( "  '"+strfromgb+"'," );
								sql10.append( "  '"+strtogb+"'," );
								sql10.append( "  '"+strbigo+"'," );
								sql10.append( "  '"+strbgtgb+"'," );
								sql10.append( "  '"+str1+"'," );
								sql10.append( "  '"+str2+"')");

								//logger.dbg.println(this,"100::"+sql10.toString());
															
								GauceStatement gsmt10= conn.getGauceStatement(sql10.toString());
								gsmt10.executeUpdate();
								gsmt10.close();

								//2007.05.11 추가(정영식)>>
								StringBuffer sql110 = new StringBuffer();
								sql110.append( " UPDATE ACCOUNT.ACTSGNSTS SET " );
								sql110.append( "          SSDAT = ''," );
								sql110.append( "          SSNBR = ''" );
								sql110.append( "   WHERE  FDCODE = '"+strfdcode+"'" );
								sql110.append( "     AND  FSDAT  = '"+strfsdat+"'" );
								sql110.append( "     AND  FSNBR  = '"+strfsnbr+"'");
														
								GauceStatement gsmt110 = conn.getGauceStatement(sql110.toString());
								gsmt110.executeUpdate();
								gsmt110.close();

								//2010.08.27 JYS 추가 
								//결재취소시 상위집계상태에 UPDATE함./////////////////////////////////////////
								UpdateSql_999.append( " UPDATE ACCOUNT.UPSUMSTS SET " );
								UpdateSql_999.append( "        UPSTS = '2'," );
								UpdateSql_999.append( "        UPID ='"+str2+"'," );
								UpdateSql_999.append( "        UPDT = sysdate " );
								UpdateSql_999.append( "  WHERE GUBUN='1'       " );
								UpdateSql_999.append( "    AND FDCODE = '"+rows[j].getString(idxFDCODE)+"' " );
								UpdateSql_999.append( "    AND ACTYYMM ='"+rows[j].getString(idxACTYYMM)+"' " );

								GauceStatement gsmt999 = conn.getGauceStatement(UpdateSql_999.toString());
								gsmt999.executeUpdate();
								gsmt999.close();
								//////////////////////////////////////////////////////////////////////////////
								
								
								//2017.01.16 JYS 추가 
								//결재취소시 자금신청에서 지급완료일 처리 ./////////////////////////////////////////
								UpdateSql_9999.append( " UPDATE ACCOUNT.ACAPPFUND SET " );
								UpdateSql_9999.append( "        PAYDATE =''," );
								UpdateSql_9999.append( "        PAYSTAT = '2'," );
								UpdateSql_9999.append( "        UPID ='"+str2+"'," );
								UpdateSql_9999.append( "        UPDT = sysdate" );
								UpdateSql_9999.append( "  WHERE FDCODE   ='"+strfdcode+"' ");
								UpdateSql_9999.append( "    AND PAYFSDAT ='"+strfsdat+"' " );
								UpdateSql_9999.append( "    AND PAYFSNBR ='"+strfsnbr+"' " );
								
								//System.out.println("UpdateSql_9999::"+UpdateSql_9999.toString());
								GauceStatement gsmt9999 = conn.getGauceStatement(UpdateSql_9999.toString());
								gsmt9999.executeUpdate();
								gsmt9999.close();
								//////////////////////////////////////////////////////////////////////////////
								
							
							}else if(j>0){
								if(!rows[j-1].getString(idxFDCODE).equals(strfdcode)||
									 !rows[j-1].getString(idxFSDAT).equals(strfsdat)||
									 !rows[j-1].getString(idxFSNBR).equals(strfsnbr)){
							
									Statement stmt_10 = conn.createStatement();
									StringBuffer sql_10 = new StringBuffer();
									sql_10.append( " SELECT SEQ,ACCSGNID, ");
									sql_10.append( "        EMPNO,ACCSGNDAT,ACCSGNEND,FROMGB,TOGB, BIGO,BGTGB ");
									sql_10.append( "   FROM ACCOUNT.ACTSGNSTS ");
									sql_10.append( "  WHERE FDCODE='"+strfdcode+"'" ); 
									sql_10.append( "    AND FSDAT='"+strfsdat+"'"  ); 
									sql_10.append( "    AND FSNBR='"+strfsnbr+"'" );  
									sql_10.append( "    AND SEQ  = (SELECT MAX(B.SEQ) FROM ACCOUNT.ACTSGNSTS B" ); 
									sql_10.append( "                 WHERE  FDCODE = B.FDCODE " ); 
									sql_10.append( "                   AND  FSDAT = B.FSDAT   " ); 
									sql_10.append( "                   AND  FSNBR = B.FSNBR   " ); 
									sql_10.append( "                   AND  B.FDCODE = '"+strfdcode+"'" ); 
									sql_10.append( "                    AND  B.FSDAT ='"+strfsdat+"'" );   
									sql_10.append( "                    AND  B.FSNBR = '"+strfsnbr+"')"); 

									ResultSet rs_10 = stmt_10.executeQuery(sql_10.toString()); 

									//logger.dbg.println(this,"200::"+sql_10.toString());
									
									if(rs_10.next()){
										strseq= rs_10.getString(1);
										straccsgnid= rs_10.getString(2);
										strempno= rs_10.getString(3);
										straccsgndat= rs_10.getString(4);
										straccsgnend= "C";
										strfromgb= "05";
										strtogb= "03";
										strbigo= rs_10.getString(8);
										strbgtgb= rs_10.getString(9);
									}
									rs_10.close();
									stmt_10.close();

									int ichk = Integer.parseInt(strseq)+1;
											strseq = String.valueOf(ichk);
									if(ichk<10) strseq = "0"+strseq;
									StringBuffer sql10 = new StringBuffer();
									sql10.append( "  INSERT INTO ACCOUNT.ACTSGNSTS ( " );
									sql10.append( "  FDCODE, FSDAT, FSNBR, SEQ, ACCSGNID, EMPNO, " );
									sql10.append( "  ACCSGNDAT, ACCSGNEND, FROMGB, TOGB, BIGO, BGTGB, " );
									sql10.append( "  WRDT, WRID " );
									sql10.append( "  ) VALUES ( " );
									sql10.append( "  '"+strfdcode+"',");
									sql10.append( "  '"+strfsdat+"'," );
									sql10.append( "  '"+strfsnbr+"'," );
									sql10.append( "  '"+strseq+"'," );
									sql10.append( "  '"+straccsgnid+"',");
									sql10.append( "  '"+strempno+"'," );
									sql10.append( "  '"+straccsgndat+"'," );
									sql10.append( "  '"+straccsgnend+"',");
									sql10.append( "  '"+strfromgb+"'," );
									sql10.append( "  '"+strtogb+"'," );
									sql10.append( "  '"+strbigo+"'," );
									sql10.append( "  '"+strbgtgb+"'," );
									sql10.append( "  '"+str1+"'," );
									sql10.append( "  '"+str2+"')");
																
									// logger.dbg.println(this,"300::"+sql10.toString());
									GauceStatement gsmt10= conn.getGauceStatement(sql10.toString());
									gsmt10.executeUpdate();
									gsmt10.close();


									//2007.05.11 추가(정영식)>>
								StringBuffer sql110 = new StringBuffer();
								sql110.append( " UPDATE ACCOUNT.ACTSGNSTS SET " );
								sql110.append( "          SSDAT = ''," );
								sql110.append( "          SSNBR = ''" );
								sql110.append( "   WHERE  FDCODE = '"+strfdcode+"'");
								sql110.append( "     AND  FSDAT  = '"+strfsdat+"'");
								sql110.append( "     AND  FSNBR  = '"+strfsnbr+"'");
														
								GauceStatement gsmt110 = conn.getGauceStatement(sql110.toString());
								gsmt110.executeUpdate();
								gsmt110.close();
								}//if(!rows[j-1].getString(idxFDCODE).equals(strfdcode)||
						 }// if(j==0){

						strseq= "";
						straccsgnid= "";
						strempno= "";
						straccsgndat="";
						straccsgnend="";
						strfromgb="";
						strtogb= "";
						strbigo= "";
					}
					
					//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					//전표Mst &&결재완료 Update End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

				}//for j

			} //try
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