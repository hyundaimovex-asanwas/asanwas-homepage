package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020004_t1 extends HttpServlet{
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

			String strErrorNo = "" ;
			String strGubun_2 ="";
			String strGubun_4 ="";
			String strGubun_5 ="";
			String strGubun_6 ="";

			double dbldetot= 0;
			double dblcrtot= 0;
			double dbldecash= 0;
			double dblcrcash= 0;
			double dbldeuptot= 0;
			double dblcruptot= 0;
			double dbldeupcash= 0;
			double dblcrupcash= 0;
			double dbledecash=0;   //차변현금등가물
			double dblecrcash=0;   //대변현금등가물
		
			double dbldetot4= 0;
			double dblcrtot4= 0;
			double dbldeuptot4= 0;
			double dblcruptot4= 0;

			double dbldetot5=0;
			double dblcrtot5=0;
			double dbldecash5=0;
			double dblcrcash5=0;
			double dbldeuptot5=0;
			double dblcruptot5=0;
			double dbldeupcash5=0;
			double dblcrupcash5=0;
			double dbledecash5=0;   //월_차변현금등가물
			double dblecrcash5=0;   //월_대변현금등가물

			double dbldetot6= 0;
			double dblcrtot6= 0;
			double dbldeuptot6= 0;
			double dblcruptot6= 0;

			double dbldetot_new= 0;
			double dblcrtot_new= 0;
			double dbldecash_new= 0;
			double dblcrcash_new= 0;
			double dbldeuptot_new= 0;
			double dblcruptot_new= 0;
			double dbldeupcash_new= 0;
			double dblcrupcash_new= 0;
			double dbledecash_new=0;
			double dblecrcash_new=0;
			
			double dblfdeamt=0;
			double dblfcramt=0;
			
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
			String stractdat="";
			String strbgtgb="";

			String strssdat="";  //전표일자(9자리)
			String strssnbr="";  //전표번호
			String strA="";      //테그 (1자리)

			double dblresults_yy=0;
			double dblbresults_yy=0;
			double dblresults_mm=0;
			double dblbresults_mm=0;
			String strbgtyy="";
			String strbgtmm="";
      
			//외화관련
			double dblfodetot =0;
			double dblfocrtot =0;
			double dblfodecash =0; 
			double dblfocrcash =0;
			double dblfodeuptot =0;
			double dblfocruptot =0;
			double dblfodeupcash=0; 
			double dblfocrupcash=0;
			double dblfoedecash =0;
			double dblfoecrcash =0;

			double dblfodetot4 = 0;
			double dblfocrtot4 = 0;
			double dblfodeuptot4 =0;
			double dblfocruptot4 =0;

			double dblfodetot_new=0;       
			double dblfocrtot_new=0;  
			double dblfodecash_new=0;
			double dblfocrcash_new=0;
			double dblfodeuptot_new=0; 
			double dblfocruptot_new=0; 	
			double dblfodeupcash_new=0;
			double dblfocrupcash_new=0;
			double dblfoedecash_new=0;
			double dblfoecrcash_new=0;
			
			double dblfodetot5=0;
			double dblfocrtot5=0; 
			double dblfodecash5=0;
			double dblfocrcash5=0;
			double dblfodeuptot5=0;
			double dblfocruptot5=0;
			double dblfodeupcash5=0;
			double dblfocrupcash5=0;
			double dblfoedecash5=0;
			double dblfoecrcash5=0;

			double dblfodetot6=0;
			double dblfocrtot6=0;
			double dblfodeuptot6=0;
			double dblfocruptot6=0;

			double dbldramt9=0;
			double dblcramt9=0;
			double dbldrfamt9=0;
			double dblcrfamt9=0;
			double dbldrfamt9_new=0; //외화금액
			double dblcrfamt9_new=0; //외화금액
			String strGubun_9="";
			String strRefcode_9=" ";   //관리번호
			String strFsrefcd_9="";
			String strFsrefval_9="";
			String strStrdate_9="";     //발생일자
			String strEnddate_9="";     //만기일자
			String strCust_9="";
			String strStatdiv="";
			String strCurdiv="";
			String strBancod_9="";
			String strVend_cd_9="";
			double dblExrate=0;
			double dblInrate=0;
			double dblOutrate=0;

			String strBjfsrefcd="";    //반제단위
			String strBjfsrefval="";   //반제단위값
			String strBjdeptcd="";     //반제부서
			String strBjvendcd="";     //반제거래처

			String strBjfsrefcd2="";    //관리항목 코드 
			String strBjfsrefval2="";   //관리항목값

			String strBjfsrefcd3="";    //관리항목 코드 
			String strBjfsrefval3="";   //관리항목값

			String strBjfsrefetc="";    //관리항목값 
	      
			String gstrSsdat="";       //전표일자 외부입력

			String strdrfamt9_new="";  //임시
			String strcrfamt9_new="";  //임시
			String strdrfamt9_new1="";  //임시
			String strcrfamt9_new1="";  //임시
			
		    //현금원화, 현금외화관련
			//String strfdcode="";	 
			//String strfsdat	="";
			//String strfsnbr	="";
			String strfsseq ="";	
			String strcashnm="";	
			String strcashcd="";	
			//String stractdat="";	
			double dbldeamt=0;
			double dblcramt=0;
			String strdeamt="";
			String strcramt="";
			
    
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");  //WRDT
				String str2 = reqGauce.getParameter("v_str2");  //WRID
				String strloginfdcode = reqGauce.getParameter("v_str3");   //로그인 ID에 따른 지점 
				String str4 = reqGauce.getParameter("v_str4");  //ssdat
				String str5 = reqGauce.getParameter("v_str5");  //ssnbr


		        /************************************************************************************
		         @ 총계정원장 / 관리항목원장 / 합계잔액 / 관리항목집계
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
        
				int idxFDCODE       = userSet.indexOfColumn("FDCODE");
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");
				int idxFSSEQ        = userSet.indexOfColumn("FSSEQ");
				int idxFSNUM        = userSet.indexOfColumn("FSNUM");
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
				int idxSGNDAT       = userSet.indexOfColumn("SGNDAT"); 
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
				int idxBANJAEYN        = userSet.indexOfColumn("BANJAEYN");     //반제구분.
				int idxBJFSREFCD       = userSet.indexOfColumn("BJFSREFCD");    //반제단위.

				String [] strFSRVALNM = new String []{"FSRVALNM01","FSRVALNM02","FSRVALNM03","FSRVALNM04","FSRVALNM05",     
				                                      "FSRVALNM06","FSRVALNM07","FSRVALNM08","FSRVALNM09"}; 


				//logger.dbg.println(this,"step1");
				//관리항목값명
				int [] idxFSRVALNM = new int[9];
				for (int i=0;i<strFSRVALNM.length;i++){
					idxFSRVALNM[i] = userSet.indexOfColumn(strFSRVALNM[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer InsertSql_1 = null;
				StringBuffer InsertSql_2 = null;
				StringBuffer InsertSql_3 = null;
				StringBuffer UpdateSql_3 = null;
				StringBuffer InsertSql_4 = null;
				StringBuffer UpdateSql_4 = null;
				StringBuffer InsertSql_5 = null;
				StringBuffer UpdateSql_5 = null;
				StringBuffer InsertSql_6 = null;
				StringBuffer UpdateSql_6 = null;
				StringBuffer DeleteSql_7 = null;
				StringBuffer DeleteSql_8 = null;
				StringBuffer UpdateSql_999 = null;  //상위집계상태
				StringBuffer UpdateSql_9999 = null; //자금신청
			
				InsertSql_1 = new StringBuffer();
				InsertSql_2 = new StringBuffer();
				InsertSql_3 = new StringBuffer();
				UpdateSql_3 = new StringBuffer();
				InsertSql_4 = new StringBuffer();
				UpdateSql_4 = new StringBuffer();
				InsertSql_5 = new StringBuffer();
				UpdateSql_5 = new StringBuffer();
				InsertSql_6 = new StringBuffer();
				UpdateSql_6 = new StringBuffer();
				DeleteSql_7 = new StringBuffer();
				DeleteSql_8 = new StringBuffer();
				
				UpdateSql_999 = new StringBuffer();  //상위집계상태
				
				UpdateSql_9999 = new StringBuffer();  //자금신청
				

				InsertSql_1.append( " INSERT INTO ACCOUNT.GENENLED (" );
				InsertSql_1.append( " FDCODE,   ACTDAT,   ATCODE,   COCODE,   FSDAT," );
				InsertSql_1.append( " FSNBR,    FSSEQ,    DEAMT,    CRAMT,    DECASH,  CRCASH, " );
				InsertSql_1.append( " EDECASH,  ECRCASH,  SSDAT,    SSNBR,    FODEAMT, FOCRAMT,  " );
				InsertSql_1.append( " FODECASH, FOCRCASH, FOEDECASH,FOECRCASH,EXRATE,  EXRATEDT, EXRATEGB  " );
				InsertSql_1.append( "  ) " );
				InsertSql_1.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  ) " ); 
				
				InsertSql_2.append( " INSERT INTO ACCOUNT.GENENREF (" );
				InsertSql_2.append( " FDCODE,  FSDAT,   FSNBR,   FSSEQ,   FSREFCD, FSREFVAL, SSDAT, SSNBR  " );
				InsertSql_2.append( "  ) " );
				InsertSql_2.append( " VALUES ( ?,?,?,?,?,?,?,?) " ); 

				InsertSql_3.append( " INSERT INTO ACCOUNT.TOTALBAL (" );
				InsertSql_3.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD, " );
				InsertSql_3.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH , " );
				InsertSql_3.append( " DEUPTOT, CRUPTOT,   DEUPCASH,  CRUPCASH, EDECASH, ECRCASH, " );
				InsertSql_3.append( " FODETOT, FOCRTOT,   FODECASH,  FOCRCASH, FOEDECASH, FOECRCASH, " );
				InsertSql_3.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH, EXRATE, EXRATEDT, EXRATEGB " );
				InsertSql_3.append( "  ) " );
				InsertSql_3.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) " ); 

				UpdateSql_3.append( " UPDATE ACCOUNT.TOTALBAL SET " );
				UpdateSql_3.append( "        DETOT = ?," );
				UpdateSql_3.append( "        CRTOT = ?," );
				UpdateSql_3.append( "        DECASH =?," );
				UpdateSql_3.append( "        CRCASH= ?," );
				UpdateSql_3.append( "        DEUPTOT = ?," );
				UpdateSql_3.append( "        CRUPTOT = ?," );
				UpdateSql_3.append( "        DEUPCASH =?," );
				UpdateSql_3.append( "        CRUPCASH= ?," );

				UpdateSql_3.append( "        EDECASH = ?," );
				UpdateSql_3.append( "        ECRCASH = ?," );
				UpdateSql_3.append( "        FODETOT =?," );
				UpdateSql_3.append( "        FOCRTOT= ?," );
				UpdateSql_3.append( "        FODECASH = ?," );
				UpdateSql_3.append( "        FOCRCASH = ?," );
				UpdateSql_3.append( "        FOEDECASH =?," );
				UpdateSql_3.append( "        FOECRCASH= ?," );
				
				UpdateSql_3.append( "        FODEUPTOT =?," );
				UpdateSql_3.append( "        FOCRUPTOT= ?," );
				UpdateSql_3.append( "        FODEUPCASH =?,");
				UpdateSql_3.append( "        FOCRUPCASH= ?," );

				UpdateSql_3.append( "        EXRATE= ?," );
				UpdateSql_3.append( "        EXRATEDT= ?," );
				UpdateSql_3.append( "        EXRATEGB= ?" );

				UpdateSql_3.append( "  WHERE FDCODE=?" );
				UpdateSql_3.append( "    AND ACTDAT=?" );
				UpdateSql_3.append( "    AND ATCODE=?" );
				UpdateSql_3.append( "    AND COCODE=?" );
				UpdateSql_3.append( "    AND DIVCD=?" );
				UpdateSql_3.append( "    AND DEPTCD=?" );

				InsertSql_4.append( " INSERT INTO ACCOUNT.FSREFTOT (" );
				InsertSql_4.append( " FDCODE,   ACTDAT,  ATCODE,  COCODE,  DIVCD," );
				InsertSql_4.append( " DEPTCD,   FSREFCD, FSREFVAL , DETOT,  CRTOT," );
				InsertSql_4.append( " DEUPTOT,  CRUPTOT," );
				InsertSql_4.append( " FODETOT,  FOCRTOT,   FODEUPTOT,  FOCRUPTOT,");
				InsertSql_4.append( " EXRATE,   EXRATEDT,  EXRATEGB");
				InsertSql_4.append( "  ) " );
				InsertSql_4.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) " ); 

				UpdateSql_4.append( " UPDATE ACCOUNT.FSREFTOT SET " );
				UpdateSql_4.append( "        DETOT = ?," );
				UpdateSql_4.append( "        CRTOT = ?," );
				UpdateSql_4.append( "        DEUPTOT = ?," );
				UpdateSql_4.append( "        CRUPTOT = ?," );
				UpdateSql_4.append( "        FODETOT = ?," );
				UpdateSql_4.append( "        FOCRTOT = ?," );
				UpdateSql_4.append( "        FODEUPTOT = ?," );
				UpdateSql_4.append( "        FOCRUPTOT = ?," );
				UpdateSql_4.append( "        EXRATE = ?," );
				UpdateSql_4.append( "        EXRATEDT = ?," );
				UpdateSql_4.append( "        EXRATEGB = ?" );
				UpdateSql_4.append( "  WHERE FDCODE=?" );
				UpdateSql_4.append( "    AND ACTDAT=?" );
				UpdateSql_4.append( "    AND ATCODE=?" );
				UpdateSql_4.append( "    AND COCODE=?" );
				UpdateSql_4.append( "    AND DIVCD=?" );
				UpdateSql_4.append( "    AND DEPTCD=?" );
				UpdateSql_4.append( "    AND FSREFCD=?" );
				UpdateSql_4.append( "    AND FSREFVAL=?" );

				InsertSql_5.append( " INSERT INTO ACCOUNT.MTOTALBAL (" );
				InsertSql_5.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD, " );
				InsertSql_5.append( " DEPTCD,  DETOT,    CRTOT,   DECASH,  CRCASH, " );
				InsertSql_5.append( " DEUPTOT,   CRUPTOT,   DEUPCASH,   CRUPCASH,   EDECASH,   ECRCASH, " );
				InsertSql_5.append( " FODETOT,   FOCRTOT,   FODECASH,   FOCRCASH,   FOEDECASH, FOECRCASH,   " );
				InsertSql_5.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH, EXRATE,    EXRATEDT, EXRATEGB  " );
				InsertSql_5.append( "  ) " );
				InsertSql_5.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) " ); 

				UpdateSql_5.append( " UPDATE ACCOUNT.MTOTALBAL SET " );
				UpdateSql_5.append( "        DETOT = ?," );
				UpdateSql_5.append( "        CRTOT = ?," );
				UpdateSql_5.append( "        DECASH =?," );
				UpdateSql_5.append( "        CRCASH= ?," );
				UpdateSql_5.append( "        DEUPTOT = ?," );
				UpdateSql_5.append( "        CRUPTOT = ?," );
				UpdateSql_5.append( "        DEUPCASH =?," );
				UpdateSql_5.append( "        CRUPCASH= ?," );
				UpdateSql_5.append( "        EDECASH = ?," );
				UpdateSql_5.append( "        ECRCASH = ?," );
				UpdateSql_5.append( "        FODETOT =?," );
				UpdateSql_5.append( "        FOCRTOT= ?," );
				UpdateSql_5.append( "        FODECASH = ?," );
				UpdateSql_5.append( "        FOCRCASH = ?," );
				UpdateSql_5.append( "        FOEDECASH =?," );
				UpdateSql_5.append( "        FOECRCASH= ?," );
				UpdateSql_5.append( "        FODEUPTOT =?," );
				UpdateSql_5.append( "        FOCRUPTOT= ?," );
				UpdateSql_5.append( "        FODEUPCASH =?,");
				UpdateSql_5.append( "        FOCRUPCASH= ?," );
				UpdateSql_5.append( "        EXRATE= ?," );
				UpdateSql_5.append( "        EXRATEDT= ?," );
				UpdateSql_5.append( "        EXRATEGB= ?" );
				UpdateSql_5.append( "  WHERE FDCODE=?" );
				UpdateSql_5.append( "    AND ACTYYMM=?" );
				UpdateSql_5.append( "    AND ATCODE=?" );
				UpdateSql_5.append( "    AND COCODE=?" );
				UpdateSql_5.append( "    AND DIVCD=?" );
				UpdateSql_5.append( "    AND DEPTCD=?" );

				InsertSql_6.append( " INSERT INTO ACCOUNT.MFSREFTOT (" );
				InsertSql_6.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD," );
				InsertSql_6.append( " DEPTCD,  FSREFCD,  FSREFVAL ,   DETOT,  CRTOT," );
				InsertSql_6.append( " DEUPTOT, CRUPTOT," );
				InsertSql_6.append( " FODETOT, FOCRTOT, FODEUPTOT, FOCRUPTOT, EXRATE, EXRATEDT, EXRATEGB" );
				InsertSql_6.append( "  ) " );
				InsertSql_6.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) " ); 

				UpdateSql_6.append( " UPDATE ACCOUNT.MFSREFTOT SET " );
				UpdateSql_6.append( "        DETOT = ?," );
				UpdateSql_6.append( "        CRTOT = ?," );
				UpdateSql_6.append( "        DEUPTOT = ?," );
				UpdateSql_6.append( "        CRUPTOT = ?," );
				UpdateSql_6.append( "        FODETOT = ?," );
				UpdateSql_6.append( "        FOCRTOT = ?," );
				UpdateSql_6.append( "        FODEUPTOT = ?," );
				UpdateSql_6.append( "        FOCRUPTOT = ?," );
				UpdateSql_6.append( "        EXRATE = ?," );
				UpdateSql_6.append( "        EXRATEDT = ?," );
				UpdateSql_6.append( "        EXRATEGB = ?" );
				UpdateSql_6.append( "  WHERE FDCODE=?" );
				UpdateSql_6.append( "    AND ACTYYMM=?" );
				UpdateSql_6.append( "    AND ATCODE=?" );
				UpdateSql_6.append( "    AND COCODE=?" );
				UpdateSql_6.append( "    AND DIVCD=?" );
				UpdateSql_6.append( "    AND DEPTCD=?" );
				UpdateSql_6.append( "    AND FSREFCD=?" );
				UpdateSql_6.append( "    AND FSREFVAL=?" );

				DeleteSql_7.append( " DELETE FROM ACCOUNT.BGTGELED " );
				DeleteSql_7.append( "  WHERE FDCODE=?" );
				DeleteSql_7.append( "    AND ACTDAT=?" );
				DeleteSql_7.append( "    AND ATCODE=?" );
				DeleteSql_7.append( "    AND COCODE=?" );
				DeleteSql_7.append( "    AND FSDAT=?" );
				DeleteSql_7.append( "    AND FSNBR=?" );
				DeleteSql_7.append( "    AND FSSEQ=?" );

				DeleteSql_8.append( " DELETE FROM ACCOUNT.BGTGEREF " );
				DeleteSql_8.append( "  WHERE FDCODE=?" );
				DeleteSql_8.append( "    AND FSDAT=?" );
				DeleteSql_8.append( "    AND FSNBR=?" );
				DeleteSql_8.append( "    AND FSSEQ=?" );
				DeleteSql_8.append( "    AND FSREFCD=?" );
				DeleteSql_8.append( "    AND FSREFVAL=?" );

				for (int j=0;j<rows.length; j++){
					  for (int i=0;i<=8;i++){
							if(!rows[j].getString(idxFSREFVAL[i]).equals("")){
            
							}
						}
					    //System.out.println("step2");
					  
						strfdcode = rows[j].getString(idxFDCODE);
						strfsdat  = rows[j].getString(idxFSDAT);
						strfsnbr  = rows[j].getString(idxFSNBR);
						strsgndat = rows[j].getString(idxSGNDAT);
						stractdat = rows[j].getString(idxACTDAT);
						strA = strfsdat.substring(0,1);
						strssdat = strA+stractdat;

						gstrSsdat = rows[j].getString(idxSSDAT);

					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표번호생성 Start
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						if(j==0){
							if(!gstrSsdat.equals("")&&gstrSsdat.equals(strssdat)){
								strssnbr = rows[j].getString(idxSSNBR);
							}else{
								if(strloginfdcode.equals(strfdcode)){

									Statement stmt0 = conn.createStatement();
									StringBuffer sql0 = new StringBuffer();
									sql0.append( " SELECT NVL(MAX(SSNBR),0)+1 FROM ACCOUNT.FSLIPMST "); 
									sql0.append( "	WHERE FDCODE ='"+strfdcode+"'"); 
									sql0.append( "	  AND SSDAT='"+strssdat+"'"); 
									sql0.append( "    AND SSNBR<'500000'"); 
									
									//System.out.println("1sql0"+sql0.toString());
									ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
									if(rs0.next()){
										 strssnbr= rs0.getString(1);
									}
									rs0.close();
									stmt0.close();

									int ichk = Integer.parseInt(strssnbr);
								 
									if(ichk<10) strssnbr = "00000"+strssnbr;
									else if(ichk>=10 && ichk<100)strssnbr = "0000"+strssnbr;
									else if(ichk>=100 && ichk<1000) strssnbr ="000"+strssnbr;
									else if(ichk>=1000 && ichk<10000)strssnbr = "00"+strssnbr;
									else if(ichk>=10000 && ichk<100000) strssnbr = "0"+strssnbr;
								}else{
									Statement stmt0 = conn.createStatement();
									StringBuffer sql0 = new StringBuffer();
									sql0.append( " SELECT NVL(MAX(SSNBR),0)+1 FROM ACCOUNT.FSLIPMST "); 
									sql0.append( "	WHERE FDCODE ='"+strfdcode+"'");  
									sql0.append( "	  AND SSDAT='"+strssdat+"'"); 
									sql0.append( "    AND SSNBR>='500000'");  
									//System.out.println("2sql0"+sql0.toString());
									ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
									if(rs0.next()){
										 strssnbr= rs0.getString(1);
									}
									rs0.close();
									stmt0.close();

									int ichk = Integer.parseInt(strssnbr);

									if(ichk<10) strssnbr = "50000"+strssnbr;
									else if(ichk>=10 && ichk<100)strssnbr = "5000"+strssnbr;
									else if(ichk>=100 && ichk<1000) strssnbr ="500"+strssnbr;
									else if(ichk>=1000 && ichk<10000)strssnbr = "50"+strssnbr;
									else if(ichk>=10000 && ichk<100000) strssnbr = "5"+strssnbr;		
								}
							}
						}
						
						
						
						
						rows[j].setString(idxSSDAT,strssdat);
						rows[j].setString(idxSSNBR,strssnbr);

						//2007.06.01추가
						if(!str4.equals("")&&!str5.equals("")){
							rows[j].setString(idxSSDAT,str4);
							rows[j].setString(idxSSNBR,str5);
							strssdat = str4;
							strssnbr = str5;
						}
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표번호생성 End
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

					 //관리항목집계가 신규일때 사용함.
						dbldetot_new= rows[j].getDouble(idxCHAAMT);
						dblcrtot_new= rows[j].getDouble(idxDAEAMT);
						dbldecash_new= rows[j].getDouble(idxDECASH);
						dblcrcash_new= rows[j].getDouble(idxCRCASH);
						dbldeuptot_new= rows[j].getDouble(idxCHAUPAMT);
						dblcruptot_new= rows[j].getDouble(idxDAEUPAMT);
						dbldeupcash_new= rows[j].getDouble(idxDEUPCASH);
						dblcrupcash_new= rows[j].getDouble(idxCRUPCASH);
						dbledecash_new=rows[j].getDouble(idxEDECASH);
						dblecrcash_new=rows[j].getDouble(idxECRCASH);

						//외화 
						dblfodetot_new=rows[j].getDouble(idxFODEAMT);
						dblfocrtot_new=rows[j].getDouble(idxFOCRAMT);
						dblfodecash_new=rows[j].getDouble(idxFODECASH);       //외화차변현금금액       
						dblfocrcash_new=rows[j].getDouble(idxFOCRCASH);				//외화대변현금금액       
						dblfodeuptot_new=rows[j].getDouble(idxFODEUPTOT);			//외화차변상위금액       
						dblfocruptot_new=rows[j].getDouble(idxFOCRUPTOT);			//외화대변상위금액       
						dblfodeupcash_new=rows[j].getDouble(idxFODEUPCASH);		//외화차변상위현금       
						dblfocrupcash_new=rows[j].getDouble(idxFOCRUPCASH);		//외화대변상위현금       
						dblfoedecash_new=rows[j].getDouble(idxFOEDECASH);			//외화차변현금등가물     
						dblfoecrcash_new=rows[j].getDouble(idxFOECRCASH);			//외화대변현금등가물     

						strErrorNo = rows[j].getString(idxFDCODE)+"-"+rows[j].getString(idxFSDAT)+"-"+rows[j].getString(idxFSNBR);

						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//총계정원장>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//**logger.dbg.println(this,"step1 - 총계정원장");
						//System.out.println("InsertSql_1"+InsertSql_1.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql_1.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxACTDAT);
						gsmt.bindColumn(3, idxATCODE);
						gsmt.bindColumn(4, idxCOCODE);
						gsmt.bindColumn(5, idxFSDAT);
						gsmt.bindColumn(6, idxFSNBR);
						gsmt.bindColumn(7, idxFSSEQ);
						gsmt.bindColumn(8, idxCHAAMT);
						gsmt.bindColumn(9, idxDAEAMT);
						gsmt.bindColumn(10,idxDECASH);
						gsmt.bindColumn(11,idxCRCASH);

						gsmt.bindColumn(12,idxEDECASH);
						gsmt.bindColumn(13,idxECRCASH);
						gsmt.bindColumn(14,idxSSDAT);
						gsmt.bindColumn(15,idxSSNBR);
						gsmt.bindColumn(16,idxFODEAMT);
						gsmt.bindColumn(17,idxFOCRAMT);
						gsmt.bindColumn(18,idxFODECASH);
						gsmt.bindColumn(19,idxFOCRCASH);
						gsmt.bindColumn(20,idxFOEDECASH);
						gsmt.bindColumn(21,idxFOECRCASH);
						gsmt.bindColumn(22,idxEXRATE);
						gsmt.bindColumn(23,idxEXRATEDT);
						gsmt.bindColumn(24,idxEXRATEGB);

						gsmt.executeUpdate();
						gsmt.close();
             
						//총계정원장_관리항목원장//////////////////////////////////////////////////////////////////////////////
						for (int i=0;i<=8;i++){
							if(!rows[j].getString(idxFSREFVAL[i]).equals("")){
							
									//System.out.println("InsertSql_2"+InsertSql_2.toString());
									GauceStatement gsmt2 = conn.getGauceStatement(InsertSql_2.toString());
									gsmt2.setGauceDataRow(rows[j]);
								  
									gsmt2.bindColumn(1, idxFDCODE);
									gsmt2.bindColumn(2, idxFSDAT);
									gsmt2.bindColumn(3, idxFSNBR);
									gsmt2.bindColumn(4, idxFSSEQ);
									gsmt2.bindColumn(5, idxFSREFCD[i]);
									gsmt2.bindColumn(6, idxFSREFVAL[i]);
									gsmt2.bindColumn(7, idxSSDAT);
									gsmt2.bindColumn(8, idxSSNBR);

									gsmt2.executeUpdate();
									gsmt2.close();
							}
						}
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//총계정원장 End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        
				    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//합계잔액(일자별)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//**logger.dbg.println(this,"step2 - 합계잔액");
						StringBuffer sql = new StringBuffer();
						Statement stmt = null;
						ResultSet rs = null;
						strGubun_2="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
						dbldetot=0;
						dblcrtot=0;
					  	dbldecash=0;
					  	dblcrcash=0;
					  	dbldeuptot=0;   
						dblcruptot=0;   
						dbldeupcash=0;  
						dblcrupcash=0;  
						dbledecash=0;  
						dblecrcash=0; 

						dblfodetot=0;
						dblfocrtot=0;
						dblfodecash=0;
						dblfocrcash=0;
						dblfodeuptot=0;  
						dblfocruptot=0;   
						dblfodeupcash=0;  
						dblfocrupcash=0; 
						dblfoedecash=0;  
						dblfoecrcash=0; 

						sql.append( " SELECT DETOT,   CRTOT,  DECASH,  CRCASH,  DEUPTOT,   CRUPTOT,   DEUPCASH,   CRUPCASH,  EDECASH,	 ECRCASH,");
						sql.append( "        FODETOT,	FOCRTOT,FODECASH,FOCRCASH,FODEUPTOT, FOCRUPTOT,	FODEUPCASH,	FOCRUPCASH,FOEDECASH,FOECRCASH");
						sql.append( "   FROM ACCOUNT.TOTALBAL  ");
						sql.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
						sql.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  ");
						sql.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
						sql.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
						sql.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
						sql.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");

						stmt = conn.createStatement();
						//System.out.println("sql"+sql.toString());
						rs = stmt.executeQuery(sql.toString());

						while(rs.next())	{
							strGubun_2="1";
							dbldetot=rs.getDouble(1);
							dblcrtot=rs.getDouble(2);
							dbldecash=rs.getDouble(3);
							dblcrcash=rs.getDouble(4);
							dbldeuptot=rs.getDouble(5);  
							dblcruptot=rs.getDouble(6);   
							dbldeupcash=rs.getDouble(7);  
							dblcrupcash=rs.getDouble(8); 
							dbledecash=rs.getDouble(9);  
							dblecrcash=rs.getDouble(10); 

							dblfodetot=rs.getDouble(11);
							dblfocrtot=rs.getDouble(12);
							dblfodecash=rs.getDouble(13);
							dblfocrcash=rs.getDouble(14);
							dblfodeuptot=rs.getDouble(15);  
							dblfocruptot=rs.getDouble(16);   
							dblfodeupcash=rs.getDouble(17);  
							dblfocrupcash=rs.getDouble(18); 
							dblfoedecash=rs.getDouble(19);  
							dblfoecrcash=rs.getDouble(20); 
						}
						rs.close();
						stmt.close();

						//합계잔액(일자별)_수정건/////
						if(strGubun_2.equals("1")){ //존재함. update
							
							//System.out.println("UpdateSql_3"+UpdateSql_3.toString());
							GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql_3.toString());
          
					    //기존금액과 현재 금액을 합산함.
							dbldetot = dbldetot + rows[j].getDouble(idxCHAAMT);
							dblcrtot = dblcrtot + rows[j].getDouble(idxDAEAMT);
							dbldecash = dbldecash + rows[j].getDouble(idxDECASH);
							dblcrcash = dblcrcash + rows[j].getDouble(idxCRCASH);
							dbldeuptot = dbldeuptot + rows[j].getDouble(idxCHAUPAMT);
							dblcruptot = dblcruptot + rows[j].getDouble(idxDAEUPAMT);
							dbldeupcash = dbldeupcash + rows[j].getDouble(idxDEUPCASH);
							dblcrupcash = dblcrupcash + rows[j].getDouble(idxCRUPCASH);
							dbledecash = dbledecash+rows[j].getDouble(idxEDECASH);       //차변현금등가물 
							dblecrcash = dblecrcash+rows[j].getDouble(idxECRCASH);       //대변현금등가물 

							dblfodetot = dblfodetot + rows[j].getDouble(idxFODEAMT);      //외화차변금액 
							dblfocrtot = dblfocrtot + rows[j].getDouble(idxFOCRAMT);			//외화대변금액 
							dblfodecash = dblfodecash + rows[j].getDouble(idxFODECASH);   //외화차변현금금액
							dblfocrcash = dblfocrcash + rows[j].getDouble(idxFOCRCASH);		//외화대변현금금액
							dblfodeuptot = dblfodeuptot + rows[j].getDouble(idxFODEUPTOT);  //외화차변상위금액
							dblfocruptot = dblfocruptot + rows[j].getDouble(idxFOCRUPTOT);	//외화대변상위금액
							dblfodeupcash = dblfodeupcash + rows[j].getDouble(idxFODEUPCASH);  //외화차변상위현금
							dblfocrupcash = dblfocrupcash + rows[j].getDouble(idxFOCRUPCASH);	 //외화대변상위현금
							dblfoedecash = dblfoedecash+rows[j].getDouble(idxFOEDECASH);       //차변현금등가물 
							dblfoecrcash = dblfoecrcash+rows[j].getDouble(idxFOECRCASH);       //대변현금등가물 

							//데이타셋 재설정
							rows[j].setDouble(idxCHAAMT,dbldetot);
							rows[j].setDouble(idxDAEAMT,dblcrtot);
							rows[j].setDouble(idxDECASH,dbldecash);
							rows[j].setDouble(idxCRCASH,dblcrcash);
							rows[j].setDouble(idxCHAUPAMT,dbldeuptot);
							rows[j].setDouble(idxDAEUPAMT,dblcruptot);
							rows[j].setDouble(idxDEUPCASH,dbldeupcash);
							rows[j].setDouble(idxCRUPCASH,dblcrupcash);
							rows[j].setDouble(idxDEUPCASH,dbledecash);
							rows[j].setDouble(idxCRUPCASH,dblecrcash);

							rows[j].setDouble(idxFODEAMT,dblfodetot);
							rows[j].setDouble(idxFOCRAMT,dblfocrtot);
							rows[j].setDouble(idxFODECASH,dblfodecash);
							rows[j].setDouble(idxFOCRCASH,dblfocrcash);
							rows[j].setDouble(idxFODEUPTOT,dblfodeuptot);
							rows[j].setDouble(idxFOCRUPTOT,dblfocruptot);
							rows[j].setDouble(idxFODEUPCASH,dblfodeupcash);
							rows[j].setDouble(idxFOCRUPCASH,dblfocrupcash);
							rows[j].setDouble(idxFOEDECASH,dblfoedecash);
							rows[j].setDouble(idxFOECRCASH,dblfoecrcash);

							gsmt3.setGauceDataRow(rows[j]);
						
							gsmt3.bindColumn(1, idxCHAAMT);
							gsmt3.bindColumn(2, idxDAEAMT);
							gsmt3.bindColumn(3, idxDECASH);
							gsmt3.bindColumn(4, idxCRCASH);
							gsmt3.bindColumn(5, idxCHAUPAMT);
							gsmt3.bindColumn(6, idxDAEUPAMT);
							gsmt3.bindColumn(7, idxDEUPCASH);
							gsmt3.bindColumn(8, idxCRUPCASH);
              
							gsmt3.bindColumn(9,idxEDECASH);
							gsmt3.bindColumn(10,idxECRCASH);
							gsmt3.bindColumn(11,idxFODEAMT);
							gsmt3.bindColumn(12,idxFOCRAMT);
							gsmt3.bindColumn(13,idxFODECASH);
							gsmt3.bindColumn(14,idxFOCRCASH);
							gsmt3.bindColumn(15,idxFOEDECASH);
							gsmt3.bindColumn(16,idxFOECRCASH);
							gsmt3.bindColumn(17,idxFODEUPTOT);
							gsmt3.bindColumn(18,idxFOCRUPTOT);
							gsmt3.bindColumn(19,idxFODEUPCASH);
							gsmt3.bindColumn(20,idxFOCRUPCASH);
							gsmt3.bindColumn(21,idxEXRATE);
							gsmt3.bindColumn(22,idxEXRATEDT);
							gsmt3.bindColumn(23,idxEXRATEGB);

							gsmt3.bindColumn(24,idxFDCODE);
							gsmt3.bindColumn(25,idxACTDAT);
							gsmt3.bindColumn(26,idxATCODE);
							gsmt3.bindColumn(27,idxCOCODE);
							gsmt3.bindColumn(28,idxDIVCD);
							gsmt3.bindColumn(29,idxDEPTCD);
	
							gsmt3.executeUpdate();
							gsmt3.close();

							//관리항목집계(일자별)//////////////////////////////////////////////////////////////////////////////
							for (int p=0;p<=8;p++){
								if(!rows[j].getString(idxFSREFVAL[p]).equals("")){
									StringBuffer sql4 = new StringBuffer();
									Statement stmt4 = null;
									ResultSet rs4 = null;
									strGubun_4="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
									dbldetot4=0;
									dblcrtot4=0;

									sql4.append( " SELECT DETOT,   CRTOT,   DEUPTOT,   CRUPTOT, ");
									sql4.append( "        FODETOT, FOCRTOT,	FODEUPTOT, FOCRUPTOT ");
									sql4.append( "   FROM ACCOUNT.FSREFTOT     	 ");
									sql4.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
									sql4.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  ");
									sql4.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
									sql4.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
									sql4.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
									sql4.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");
									sql4.append( "    AND FSREFCD  ='"+rows[j].getString(idxFSREFCD[p])+"'   ");
									sql4.append( "    AND FSREFVAL ='"+rows[j].getString(idxFSREFVAL[p])+"'  ");

									stmt4 = conn.createStatement();
									
									//System.out.println("sql4"+sql4.toString());
									rs4 = stmt4.executeQuery(sql4.toString());

									while(rs4.next())	{
										strGubun_4="1";
										dbldetot4=rs4.getDouble(1);
										dblcrtot4=rs4.getDouble(2);
										dbldeuptot4=rs4.getDouble(3);
										dblcruptot4=rs4.getDouble(4);

										dblfodetot4=rs4.getDouble(5);
										dblfocrtot4=rs4.getDouble(6);
										dblfodeuptot4=rs4.getDouble(7);
										dblfocruptot4=rs4.getDouble(8);
									}
									rs4.close();
									stmt4.close();

									//관리항목집계(일자별)_수정건/////
									if(strGubun_4.equals("1")){ //존재함. update
										
										//System.out.println("UpdateSql_4"+UpdateSql_4.toString());
										GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql_4.toString());
          
										//기존금액과 현재 금액을 합산함.
										dbldetot4 = dbldetot4 + dbldetot_new;
										dblcrtot4 = dblcrtot4 + dblcrtot_new;
										dbldeuptot4 = dbldeuptot4 + dbldeuptot_new;
										dblcruptot4 = dblcruptot4 + dblcruptot_new;
                    
										//외화의 경우 역사적 환율 일경우만 적용 
										dblfodetot4 = dblfodetot4 + dblfodetot_new;
										dblfocrtot4 = dblfocrtot4 + dblfocrtot_new;
										dblfodeuptot4 = dblfodeuptot4 + dblfodeuptot_new;
										dblfocruptot4 = dblfocruptot4 + dblfocruptot_new;

										//데이타셋 재설정
										rows[j].setDouble(idxCHAAMT,dbldetot4);
										rows[j].setDouble(idxDAEAMT,dblcrtot4);
										rows[j].setDouble(idxCHAUPAMT,dbldeuptot4);
										rows[j].setDouble(idxDAEUPAMT,dblcruptot4);

										rows[j].setDouble(idxFODEAMT,dblfodetot4);
										rows[j].setDouble(idxFOCRAMT,dblfocrtot4);
										rows[j].setDouble(idxFODEUPTOT,dblfodeuptot4);
										rows[j].setDouble(idxFOCRUPTOT,dblfocruptot4);
										
										gsmt4.setGauceDataRow(rows[j]);
									
										gsmt4.bindColumn(1, idxCHAAMT);
										gsmt4.bindColumn(2, idxDAEAMT);
										gsmt4.bindColumn(3, idxCHAUPAMT);
										gsmt4.bindColumn(4, idxDAEUPAMT);

										gsmt4.bindColumn(5,idxFODEAMT);
										gsmt4.bindColumn(6,idxFOCRAMT);
										gsmt4.bindColumn(7,idxFODEUPTOT);
										gsmt4.bindColumn(8,idxFOCRUPTOT);
										gsmt4.bindColumn(9,idxEXRATE);
										gsmt4.bindColumn(10,idxEXRATEDT);
										gsmt4.bindColumn(11,idxEXRATEGB);

										gsmt4.bindColumn(12, idxFDCODE);
										gsmt4.bindColumn(13, idxACTDAT);
										gsmt4.bindColumn(14, idxATCODE);
										gsmt4.bindColumn(15, idxCOCODE);
										gsmt4.bindColumn(16, idxDIVCD);
										gsmt4.bindColumn(17, idxDEPTCD);
										gsmt4.bindColumn(18, idxFSREFCD[p]);
										gsmt4.bindColumn(19, idxFSREFVAL[p]);

										gsmt4.executeUpdate();
										gsmt4.close();
                  
									//관리항목집계(일자별)_신규/////
									}else{                      //신규 .  Insert

										//System.out.println("InsertSql_4"+InsertSql_4.toString());
										GauceStatement gsmt4 = conn.getGauceStatement(InsertSql_4.toString());
										gsmt4.setGauceDataRow(rows[j]);

										//데이타셋 재설정
										rows[j].setDouble(idxCHAAMT,dbldetot_new);
										rows[j].setDouble(idxDAEAMT,dblcrtot_new);
										rows[j].setDouble(idxCHAUPAMT,dbldeuptot_new);
										rows[j].setDouble(idxDAEUPAMT,dblcruptot_new);
                    
										//외화
										rows[j].setDouble(idxFODEAMT,dblfodetot_new);
										rows[j].setDouble(idxFOCRAMT,dblfocrtot_new);
										rows[j].setDouble(idxFODEUPTOT,dblfodeuptot_new);
										rows[j].setDouble(idxFOCRUPTOT,dblfocruptot_new);

										gsmt4.bindColumn(1, idxFDCODE);
										gsmt4.bindColumn(2, idxACTDAT);
										gsmt4.bindColumn(3, idxATCODE);
										gsmt4.bindColumn(4, idxCOCODE);
										gsmt4.bindColumn(5, idxDIVCD);
										gsmt4.bindColumn(6, idxDEPTCD);
										gsmt4.bindColumn(7, idxFSREFCD[p]);
										gsmt4.bindColumn(8, idxFSREFVAL[p]);
										gsmt4.bindColumn(9, idxCHAAMT);
										gsmt4.bindColumn(10,idxDAEAMT);
										gsmt4.bindColumn(11,idxCHAUPAMT);
										gsmt4.bindColumn(12,idxDAEUPAMT);

										gsmt4.bindColumn(13,idxFODEAMT);
										gsmt4.bindColumn(14,idxFOCRAMT);
										gsmt4.bindColumn(15,idxFODEUPTOT);
										gsmt4.bindColumn(16,idxFOCRUPTOT);
										gsmt4.bindColumn(17,idxEXRATE);
										gsmt4.bindColumn(18,idxEXRATEDT);
										gsmt4.bindColumn(19,idxEXRATEGB);
										
										gsmt4.executeUpdate();
										gsmt4.close();
									}//if
								}//if idxFSREFCD
							}//for

							//합계잔액(일자별)_신규건/////
						}else{                    //신규    insert
							//System.out.println("InsertSql_3"+InsertSql_3.toString());
							GauceStatement gsmt3 = conn.getGauceStatement(InsertSql_3.toString());
							gsmt3.setGauceDataRow(rows[j]);
						
							gsmt3.bindColumn(1, idxFDCODE);
							gsmt3.bindColumn(2, idxACTDAT);
							gsmt3.bindColumn(3, idxATCODE);
							gsmt3.bindColumn(4, idxCOCODE);
							gsmt3.bindColumn(5, idxDIVCD);
							gsmt3.bindColumn(6, idxDEPTCD);
							gsmt3.bindColumn(7, idxCHAAMT);
							gsmt3.bindColumn(8, idxDAEAMT);
							gsmt3.bindColumn(9, idxDECASH);
							gsmt3.bindColumn(10,idxCRCASH);
							gsmt3.bindColumn(11,idxCHAUPAMT);
							gsmt3.bindColumn(12,idxDAEUPAMT);
							gsmt3.bindColumn(13,idxDEUPCASH);
							gsmt3.bindColumn(14,idxCRUPCASH);

							gsmt3.bindColumn(15,idxEDECASH);
							gsmt3.bindColumn(16,idxECRCASH);
							gsmt3.bindColumn(17,idxFODEAMT);
							gsmt3.bindColumn(18,idxFOCRAMT);
							gsmt3.bindColumn(19,idxFODECASH);
							gsmt3.bindColumn(20,idxFOCRCASH);
							gsmt3.bindColumn(21,idxFOEDECASH);
							gsmt3.bindColumn(22,idxFOECRCASH);
							gsmt3.bindColumn(23,idxFODEUPTOT);
							gsmt3.bindColumn(24,idxFOCRUPTOT);
							gsmt3.bindColumn(25,idxFODEUPCASH);
							gsmt3.bindColumn(26,idxFOCRUPCASH);
							gsmt3.bindColumn(27,idxEXRATE);
							gsmt3.bindColumn(28,idxEXRATEDT);
							gsmt3.bindColumn(29,idxEXRATEGB);

							gsmt3.executeUpdate();
							gsmt3.close();

							////관리항목집계_신규/////////////
							for (int s=0;s<=8;s++){
								
								if(!rows[j].getString(idxFSREFVAL[s]).equals("")){
									    //System.out.println("InsertSql_4"+InsertSql_4.toString());
										GauceStatement gsmt4 = conn.getGauceStatement(InsertSql_4.toString());
										gsmt4.setGauceDataRow(rows[j]);

										gsmt4.bindColumn(1, idxFDCODE);
										gsmt4.bindColumn(2, idxACTDAT);
										gsmt4.bindColumn(3, idxATCODE);
										gsmt4.bindColumn(4, idxCOCODE);
										gsmt4.bindColumn(5, idxDIVCD);
										gsmt4.bindColumn(6, idxDEPTCD);
										gsmt4.bindColumn(7, idxFSREFCD[s]);
										gsmt4.bindColumn(8, idxFSREFVAL[s]);
										gsmt4.bindColumn(9, idxCHAAMT);
										gsmt4.bindColumn(10,idxDAEAMT);
										gsmt4.bindColumn(11,idxCHAUPAMT);
										gsmt4.bindColumn(12,idxDAEUPAMT);
										
										gsmt4.bindColumn(13,idxFODEAMT);
										gsmt4.bindColumn(14,idxFOCRAMT);
										gsmt4.bindColumn(15,idxFODEUPTOT);
										gsmt4.bindColumn(16,idxFOCRUPTOT);
										gsmt4.bindColumn(17,idxEXRATE);
										gsmt4.bindColumn(18,idxEXRATEDT);
										gsmt4.bindColumn(19,idxEXRATEGB);

										gsmt4.executeUpdate();
										gsmt4.close();
								}//if idxFSREFCD
							}//for
					  }//if
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//합계잔액(일자별) End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//합계잔액(월별)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//**logger.dbg.println(this,"step3 - 합계잔액 월별");
						//&&logger.dbg.println(this,"합계잔액(월별)");
						StringBuffer sql5 = new StringBuffer();
						Statement stmt5 = null;
						ResultSet rs5 = null;
						strGubun_5="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
						dbldetot5=0;
						dblcrtot5=0;
						dbldecash5=0;
						dblcrcash5=0;
						dbldeuptot5=0; 
						dblcruptot5=0; 
						dbldeupcash5=0;
						dblcrupcash5=0;
						dbledecash5=0;  
						dblecrcash5=0; 

						dblfodetot5=0;
						dblfocrtot5=0;
						dblfodecash5=0;
						dblfocrcash5=0;
						dblfodeuptot5=0;  
						dblfocruptot5=0;   
						dblfodeupcash5=0;  
						dblfocrupcash5=0; 
						dblfoedecash5=0;  
						dblfoecrcash5=0; 

						sql5.append( " SELECT DETOT,   CRTOT,  DECASH,  CRCASH,  DEUPTOT,   CRUPTOT,   DEUPCASH,   CRUPCASH,  EDECASH,	 ECRCASH,");
						sql5.append( "        FODETOT,	FOCRTOT,FODECASH,FOCRCASH,FODEUPTOT, FOCRUPTOT,	FODEUPCASH,	FOCRUPCASH,FOEDECASH,FOECRCASH");
						sql5.append( "   FROM ACCOUNT.MTOTALBAL     	 ");
						sql5.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
						sql5.append( "    AND ACTYYMM='"+rows[j].getString(idxACTYYMM)+"' ");
						sql5.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
						sql5.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
						sql5.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
						sql5.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");

						stmt5 = conn.createStatement();
						//System.out.println("sql5"+sql5.toString());
						rs5 = stmt5.executeQuery(sql5.toString());
          
						while(rs5.next())	{
							strGubun_5="1";
							dbldetot5=rs5.getDouble(1);
							dblcrtot5=rs5.getDouble(2);
							dbldecash5=rs5.getDouble(3);
							dblcrcash5=rs5.getDouble(4);
							dbldeuptot5=rs5.getDouble(5); 
							dblcruptot5=rs5.getDouble(6); 
							dbldeupcash5=rs5.getDouble(7);
							dblcrupcash5=rs5.getDouble(8);
							dbledecash5=rs5.getDouble(9);
							dblecrcash5=rs5.getDouble(10);

							dblfodetot5=rs5.getDouble(11);
							dblfocrtot5=rs5.getDouble(12);
							dblfodecash5=rs5.getDouble(13);
							dblfocrcash5=rs5.getDouble(14);
							dblfodeuptot5=rs5.getDouble(15); 
							dblfocruptot5=rs5.getDouble(16); 
							dblfodeupcash5=rs5.getDouble(17);
							dblfocrupcash5=rs5.getDouble(18);
							dblfoedecash5=rs5.getDouble(19);
							dblfoecrcash5=rs5.getDouble(20);
						}
						rs5.close();
						stmt5.close();

						//합계잔액(월별)_수정건/////
						if(strGubun_5.equals("1")){ //존재함. update
						   strGubun_5="";
						    //System.out.println("UpdateSql_5"+UpdateSql_5.toString());
							GauceStatement gsmt5 = conn.getGauceStatement(UpdateSql_5.toString());
          
							//기존금액과 현재 금액을 합산함.
							//dbldetot5 = dbldetot5 + rows[j].getDouble(idxCHAAMT);
							//dblcrtot5 = dblcrtot5 + rows[j].getDouble(idxDAEAMT);
							//dbldecash5 = dbldecash5 + rows[j].getDouble(idxDECASH);
							//dblcrcash5 = dblcrcash5 + rows[j].getDouble(idxCRCASH);

							dbldetot5 = dbldetot5 + dbldetot_new;
							dblcrtot5 = dblcrtot5 + dblcrtot_new;
							dbldecash5 = dbldecash5 + dbldecash_new;
							dblcrcash5 = dblcrcash5 + dblcrcash_new;
							dbldeuptot5 = dbldeuptot5 + dbldeuptot_new;
							dblcruptot5 = dblcruptot5 + dblcruptot_new;
							dbldeupcash5 = dbldeupcash5 + dbldeupcash_new;
							dblcrupcash5 = dblcrupcash5 + dblcrupcash_new;
							dbledecash5= dbledecash5+ dbledecash_new;
							dblecrcash5= dbledecash5+ dbledecash_new;

							dblfodetot5 = dblfodetot5 + dblfodetot_new;
							dblfocrtot5 = dblfocrtot5 + dblfocrtot_new;
							dblfodecash5 = dblfodecash5 + dblfodecash_new;
							dblfocrcash5 = dblfocrcash5 + dblfocrcash_new;
							dblfodeuptot5 = dblfodeuptot5 + dblfodeuptot_new;
							dblfocruptot5 = dblfocruptot5 + dblfocruptot_new;
							dblfodeupcash5 = dblfodeupcash5 + dblfodeupcash_new;
							dblfocrupcash5 = dblfocrupcash5 + dblfocrupcash_new;
							dblfoedecash5= dblfoedecash5+ dblfoedecash_new;
							dblfoecrcash5= dblfoedecash5+ dblfoedecash_new;


							//데이타셋 재설정
							rows[j].setDouble(idxCHAAMT,dbldetot5);						
							rows[j].setDouble(idxDAEAMT,dblcrtot5);
							rows[j].setDouble(idxDECASH,dbldecash5);
							rows[j].setDouble(idxCRCASH,dblcrcash5);
							rows[j].setDouble(idxCHAUPAMT,dbldeuptot5);
							rows[j].setDouble(idxDAEUPAMT,dblcruptot5);
							rows[j].setDouble(idxDEUPCASH,dbldeupcash5);
							rows[j].setDouble(idxCRUPCASH,dblcrupcash5);
							rows[j].setDouble(idxEDECASH,dbledecash5);
							rows[j].setDouble(idxECRCASH,dblecrcash5);

							//외화
							rows[j].setDouble(idxFODEAMT,dblfodetot5);
							rows[j].setDouble(idxFOCRAMT,dblfocrtot5);
							rows[j].setDouble(idxFODECASH,dblfodecash5);
							rows[j].setDouble(idxFOCRCASH,dblfocrcash5);
							rows[j].setDouble(idxFODEUPTOT,dblfodeuptot5);
							rows[j].setDouble(idxFOCRUPTOT,dblfocruptot5);
							rows[j].setDouble(idxFODEUPCASH,dblfodeupcash5);
							rows[j].setDouble(idxFOCRUPCASH,dblfocrupcash5);
							rows[j].setDouble(idxFOEDECASH,dblfoedecash5);
							rows[j].setDouble(idxFOECRCASH,dblfoecrcash5);

							gsmt5.setGauceDataRow(rows[j]);
						
							gsmt5.bindColumn(1,idxCHAAMT);
							gsmt5.bindColumn(2,idxDAEAMT);
							gsmt5.bindColumn(3,idxDECASH);
							gsmt5.bindColumn(4,idxCRCASH);
							gsmt5.bindColumn(5,idxCHAUPAMT);
							gsmt5.bindColumn(6,idxDAEUPAMT);
							gsmt5.bindColumn(7,idxDEUPCASH);
							gsmt5.bindColumn(8,idxCRUPCASH);
							gsmt5.bindColumn(9,idxEDECASH);
							gsmt5.bindColumn(10,idxECRCASH);
							gsmt5.bindColumn(11,idxFODEAMT);
							gsmt5.bindColumn(12,idxFOCRAMT);
							gsmt5.bindColumn(13,idxFODECASH);
							gsmt5.bindColumn(14,idxFOCRCASH);
							gsmt5.bindColumn(15,idxFOEDECASH);
							gsmt5.bindColumn(16,idxFOECRCASH);
							gsmt5.bindColumn(17,idxFODEUPTOT);
							gsmt5.bindColumn(18,idxFOCRUPTOT);
							gsmt5.bindColumn(19,idxFODEUPCASH);
							gsmt5.bindColumn(20,idxFOCRUPCASH);
							gsmt5.bindColumn(21,idxEXRATE);
							gsmt5.bindColumn(22,idxEXRATEDT);
							gsmt5.bindColumn(23,idxEXRATEGB);
							gsmt5.bindColumn(24,idxFDCODE);
							gsmt5.bindColumn(25,idxACTYYMM);
							gsmt5.bindColumn(26,idxATCODE);
							gsmt5.bindColumn(27,idxCOCODE);
							gsmt5.bindColumn(28,idxDIVCD);
							gsmt5.bindColumn(29,idxDEPTCD);
							gsmt5.executeUpdate();
							gsmt5.close();



							//관리항목집계(월별)//////////////////////////////////////////////////////////////////////////////
							//**logger.dbg.println(this,"step33 - 관리항목집계 월별");
							for (int p2=0;p2<=8;p2++){
								if(!rows[j].getString(idxFSREFVAL[p2]).equals("")){

									StringBuffer sql6 = new StringBuffer();
									Statement stmt6 = null;
									ResultSet rs6 = null;
									strGubun_6="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
									dbldetot6=0;
									dblcrtot6=0;
									dbldeuptot6=0;
									dblcruptot6=0;
		
									sql6.append( " SELECT DETOT,   CRTOT,   DEUPTOT,   CRUPTOT, ");
									sql6.append( "        FODETOT, FOCRTOT,	FODEUPTOT, FOCRUPTOT ");
									sql6.append( "   FROM ACCOUNT.MFSREFTOT     	 ");
									sql6.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
									sql6.append( "    AND ACTYYMM ='"+rows[j].getString(idxACTYYMM)+"'  ");
									sql6.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
									sql6.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
									sql6.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
									sql6.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");
									sql6.append( "    AND FSREFCD  ='"+rows[j].getString(idxFSREFCD[p2])+"'   ");
									sql6.append( "    AND FSREFVAL ='"+rows[j].getString(idxFSREFVAL[p2])+"'  ");

									stmt6 = conn.createStatement();
									//System.out.println("sql6"+sql6.toString());
									rs6 = stmt6.executeQuery(sql6.toString());

									while(rs6.next())	{
										strGubun_6="1";
										dbldetot6=rs6.getDouble(1);
										dblcrtot6=rs6.getDouble(2);
										dbldeuptot6=rs6.getDouble(3);
										dblcruptot6=rs6.getDouble(4);

										dblfodetot6=rs6.getDouble(5);
										dblfocrtot6=rs6.getDouble(6);
										dblfodeuptot6=rs6.getDouble(7);
										dblfocruptot6=rs6.getDouble(8);
									}
									rs6.close();
									stmt6.close();

									//관리항목집계(월별)_수정건/////
            
									if(strGubun_6.equals("1")){ //존재함. update
										strGubun_6="";
										//System.out.println("UpdateSql_6"+UpdateSql_6.toString());
										GauceStatement gsmt6 = conn.getGauceStatement(UpdateSql_6.toString());
          
										//기존금액과 현재 금액을 합산함.
										dbldetot6 = dbldetot6 + dbldetot_new;
										dblcrtot6 = dblcrtot6 + dblcrtot_new;
										dbldeuptot6 = dbldeuptot6 + dbldeuptot_new;
										dblcruptot6 = dblcruptot6 + dblcruptot_new;

										//외화
										dblfodetot6 = dblfodetot6 + dblfodetot_new;
										dblfocrtot6 = dblfocrtot6 + dblfocrtot_new;
										dblfodeuptot6 = dblfodeuptot6 + dblfodeuptot_new;
										dblfocruptot6 = dblfocruptot6 + dblfocruptot_new;

										//데이타셋 재설정
										rows[j].setDouble(idxCHAAMT,dbldetot6);
										rows[j].setDouble(idxDAEAMT,dblcrtot6);
										rows[j].setDouble(idxCHAUPAMT,dbldeuptot6);
										rows[j].setDouble(idxDAEUPAMT,dblcruptot6);
                    
										//외화
										rows[j].setDouble(idxFODEAMT,dblfodetot6);
										rows[j].setDouble(idxFOCRAMT,dblfocrtot6);
										rows[j].setDouble(idxFODEUPTOT,dblfodeuptot6);
										rows[j].setDouble(idxFOCRUPTOT,dblfocruptot6);

										gsmt6.setGauceDataRow(rows[j]);
										gsmt6.bindColumn(1, idxCHAAMT);
										gsmt6.bindColumn(2, idxDAEAMT);
										gsmt6.bindColumn(3, idxCHAUPAMT);
										gsmt6.bindColumn(4, idxDAEUPAMT);

										gsmt6.bindColumn(5,idxFODEAMT);
										gsmt6.bindColumn(6,idxFOCRAMT);
										gsmt6.bindColumn(7,idxFODEUPTOT);
										gsmt6.bindColumn(8,idxFOCRUPTOT);
										gsmt6.bindColumn(9,idxEXRATE);
										gsmt6.bindColumn(10,idxEXRATEDT);
										gsmt6.bindColumn(11,idxEXRATEGB);

										gsmt6.bindColumn(12, idxFDCODE);
										gsmt6.bindColumn(13, idxACTYYMM);
										gsmt6.bindColumn(14, idxATCODE);
										gsmt6.bindColumn(15, idxCOCODE);
										gsmt6.bindColumn(16, idxDIVCD);
										gsmt6.bindColumn(17, idxDEPTCD);
										gsmt6.bindColumn(18, idxFSREFCD[p2]);
										gsmt6.bindColumn(19, idxFSREFVAL[p2]);
            
										gsmt6.executeUpdate();
										gsmt6.close();

                 
									//관리항목집계(월별)_신규/////
									}else{                      //신규 .  Insert
										//System.out.println("2InsertSql_6"+InsertSql_6.toString());
										GauceStatement gsmt6 = conn.getGauceStatement(InsertSql_6.toString());
										gsmt6.setGauceDataRow(rows[j]);
										
										//System.out.println("dbldetot_new"+dbldetot_new);
										//System.out.println("dblcrtot_new"+dblcrtot_new);
										//System.out.println("dbldeupcash_new"+dbldeupcash_new);
										//System.out.println("dblcrupcash_new"+dblcrupcash_new);
										//System.out.println("dblfodetot_new"+dblfodetot_new);
										//System.out.println("dblfocrtot_new"+dblfocrtot_new);
										//System.out.println("dblfocrupcash_new"+dblfocrupcash_new);
										//System.out.println("dblfocrupcash_new"+dblfocrupcash_new);
										
          
										rows[j].setDouble(idxCHAAMT,dbldetot_new);
										rows[j].setDouble(idxDAEAMT,dblcrtot_new);
										rows[j].setDouble(idxCHAUPAMT,dbldeupcash_new);
										rows[j].setDouble(idxDAEUPAMT,dblcrupcash_new);
                    
										//외화
										rows[j].setDouble(idxFODEAMT,dblfodetot_new);
										rows[j].setDouble(idxFOCRAMT,dblfocrtot_new);
										rows[j].setDouble(idxFODEUPTOT,dblfodeupcash_new);
										rows[j].setDouble(idxFOCRUPTOT,dblfocrupcash_new);
										
										gsmt6.bindColumn(1, idxFDCODE);
										gsmt6.bindColumn(2, idxACTYYMM);
										gsmt6.bindColumn(3, idxATCODE);
										gsmt6.bindColumn(4, idxCOCODE);
										gsmt6.bindColumn(5, idxDIVCD);
										gsmt6.bindColumn(6, idxDEPTCD);
										gsmt6.bindColumn(7, idxFSREFCD[p2]);
										gsmt6.bindColumn(8, idxFSREFVAL[p2]);
										gsmt6.bindColumn(9, idxCHAAMT);
										gsmt6.bindColumn(10,idxDAEAMT);
										gsmt6.bindColumn(11,idxCHAUPAMT);
										gsmt6.bindColumn(12,idxDAEUPAMT);

										gsmt6.bindColumn(13,idxFODEAMT);
										gsmt6.bindColumn(14,idxFOCRAMT);
										gsmt6.bindColumn(15,idxFODEUPTOT);
										gsmt6.bindColumn(16,idxFOCRUPTOT);
										gsmt6.bindColumn(17,idxEXRATE);
										gsmt6.bindColumn(18,idxEXRATEDT);
										gsmt6.bindColumn(19,idxEXRATEGB);
										
										//System.out.println("2InsertSql_6 executeUpdate  ");
										
										gsmt6.executeUpdate();
										gsmt6.close();
										
										//System.out.println("2InsertSql_6 executeUpdate succ  ");
										
									}//if
								}//if idxFSREFCD
							}//for

							//합계잔액(월별)_신규건/////
						}else{                    //신규    insert
							//System.out.println("InsertSql_5"+InsertSql_5.toString());
							GauceStatement gsmt5 = conn.getGauceStatement(InsertSql_5.toString());
							gsmt5.setGauceDataRow(rows[j]);
						  
							gsmt5.bindColumn(1, idxFDCODE);
							gsmt5.bindColumn(2, idxACTYYMM);
							gsmt5.bindColumn(3, idxATCODE);
							gsmt5.bindColumn(4, idxCOCODE);
							gsmt5.bindColumn(5, idxDIVCD);
							gsmt5.bindColumn(6, idxDEPTCD);
							gsmt5.bindColumn(7, idxCHAAMT);
							gsmt5.bindColumn(8, idxDAEAMT);
							gsmt5.bindColumn(9, idxDECASH);
							gsmt5.bindColumn(10,idxCRCASH);
							gsmt5.bindColumn(11,idxCHAUPAMT);
							gsmt5.bindColumn(12,idxDAEUPAMT);
							gsmt5.bindColumn(13,idxDEUPCASH);
							gsmt5.bindColumn(14,idxCRUPCASH);

							gsmt5.bindColumn(15,idxEDECASH);
							gsmt5.bindColumn(16,idxECRCASH);
							gsmt5.bindColumn(17,idxFODEAMT);
							gsmt5.bindColumn(18,idxFOCRAMT);
							gsmt5.bindColumn(19,idxFODECASH);
							gsmt5.bindColumn(20,idxFOCRCASH);
							gsmt5.bindColumn(21,idxFOEDECASH);
							gsmt5.bindColumn(22,idxFOECRCASH);
							gsmt5.bindColumn(23,idxFODEUPTOT);
							gsmt5.bindColumn(24,idxFOCRUPTOT);
							gsmt5.bindColumn(25,idxFODEUPCASH);
							gsmt5.bindColumn(26,idxFOCRUPCASH);
							gsmt5.bindColumn(27,idxEXRATE);
							gsmt5.bindColumn(28,idxEXRATEDT);
							gsmt5.bindColumn(29,idxEXRATEGB);

							gsmt5.executeUpdate();
							gsmt5.close();

							////관리항목집계_신규/////////////
							//**logger.dbg.println(this,"step33 - 관리항목집계 월별 신규");
							for (int s2=0;s2<=8;s2++){
								///&&logger.dbg.println(this, "합계잔액_월별_신규_관리항목신규");

								if(!rows[j].getString(idxFSREFVAL[s2]).equals("")){
									    //System.out.println("InsertSql_6"+InsertSql_6.toString());
										GauceStatement gsmt6 = conn.getGauceStatement(InsertSql_6.toString());
										gsmt6.setGauceDataRow(rows[j]);
										gsmt6.bindColumn(1, idxFDCODE);
										gsmt6.bindColumn(2, idxACTYYMM);
										gsmt6.bindColumn(3, idxATCODE);
										gsmt6.bindColumn(4, idxCOCODE);
										gsmt6.bindColumn(5, idxDIVCD);
										gsmt6.bindColumn(6, idxDEPTCD);
										gsmt6.bindColumn(7, idxFSREFCD[s2]);
										gsmt6.bindColumn(8, idxFSREFVAL[s2]);
										gsmt6.bindColumn(9, idxCHAAMT);
										gsmt6.bindColumn(10,idxDAEAMT);
										gsmt6.bindColumn(11,idxCHAUPAMT);
										gsmt6.bindColumn(12,idxDAEUPAMT);

										gsmt6.bindColumn(13,idxFODEAMT);
										gsmt6.bindColumn(14,idxFOCRAMT);
										gsmt6.bindColumn(15,idxFODEUPTOT);
										gsmt6.bindColumn(16,idxFOCRUPTOT);
										gsmt6.bindColumn(17,idxEXRATE);
										gsmt6.bindColumn(18,idxEXRATEDT);
										gsmt6.bindColumn(19,idxEXRATEGB);                    

										gsmt6.executeUpdate();
										gsmt6.close();
								}//if idxFSREFCD
							}//for
					  }//if

					//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					//합계잔액(월별) End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
				 
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                    //예산부서가 존재하는 건만 적용함.
                    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						
						

					if(!rows[j].getString(idxBGTDIV).equals("")&&!rows[j].getString(idxBGTDEPT).equals("")&&!rows[j].getString(idxTYPE_FSREFVAL).equals("")){
						
						strbgtyy = rows[j].getString(idxACTDAT);
						strbgtmm = strbgtyy.substring(4,6);
						strbgtyy = strbgtyy.substring(0,4);

						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//예산총계정원장 Data 삭제>>>>>>>.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						///^^logger.dbg.println(this, "예산총계정원장");
						//System.out.println("DeleteSql_7"+DeleteSql_7.toString());
						GauceStatement gsmt7 = conn.getGauceStatement(DeleteSql_7.toString());
						gsmt7.setGauceDataRow(rows[j]);
		
						gsmt7.bindColumn(1, idxFDCODE);
						gsmt7.bindColumn(2, idxACTDAT);
						gsmt7.bindColumn(3, idxATCODE);
						gsmt7.bindColumn(4, idxCOCODE);
						gsmt7.bindColumn(5, idxFSDAT);
						gsmt7.bindColumn(6, idxFSNBR);
						gsmt7.bindColumn(7, idxFSSEQ);
						
						gsmt7.executeUpdate();
						gsmt7.close();

						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//예산관리항목원장 Data 삭제>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//&&logger.dbg.println(this, "예산관리항목원장");
						for (int p8=0;p8<=8;p8++){
							 if(!rows[j].getString(idxFSREFVAL[p8]).equals("")){
								 	//System.out.println("DeleteSql_8"+DeleteSql_8.toString());
									GauceStatement gsmt8 = conn.getGauceStatement(DeleteSql_8.toString());
									gsmt8.setGauceDataRow(rows[j]);
					
									gsmt8.bindColumn(1, idxFDCODE);
									gsmt8.bindColumn(2, idxFSDAT);
									gsmt8.bindColumn(3, idxFSNBR);
									gsmt8.bindColumn(4, idxFSSEQ);
									gsmt8.bindColumn(5, idxFSREFCD[p8]);
									gsmt8.bindColumn(6, idxFSREFVAL[p8]);
									
									gsmt8.executeUpdate();
									gsmt8.close();
							 }
						}

							
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//예산관리 Mst 실적 (+)   결재전 실적(-)  승인 :Y  (update) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						Statement stmt8_1 = conn.createStatement();
						StringBuffer sql8_1 = new StringBuffer();
						sql8_1.append( " SELECT RESULTS,BRESULTS   ");
						sql8_1.append( "   FROM ACCOUNT.BGTMST     ");
						sql8_1.append( "  WHERE FDCODE = '"+strfdcode+"'");
						sql8_1.append( "    AND BGTYY = '"+strbgtyy+"'");
						sql8_1.append( "    AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'");
						sql8_1.append( "    AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'");
						sql8_1.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'");
						sql8_1.append( "    AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'");
						sql8_1.append( "    AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'");
											
						//System.out.println("sql8_1"+sql8_1.toString());
						ResultSet rs8_1 = stmt8_1.executeQuery(sql8_1.toString()); 

						dblresults_yy =0;
						dblbresults_yy=0;

						if(rs8_1.next()){
							dblresults_yy = rs8_1.getDouble(1);
							dblbresults_yy= rs8_1.getDouble(2);
						}
						rs8_1.close();
						stmt8_1.close();

						dblresults_yy=dblresults_yy+dbldetot_new+dblcrtot_new;   //실적
						dblbresults_yy=dblbresults_yy-dbldetot_new-dblcrtot_new; //결재전실적
						
						StringBuffer sql8_2 = new StringBuffer();
						sql8_2.append( " UPDATE ACCOUNT.BGTMST SET  ");
						sql8_2.append( "        RESULTS = "+dblresults_yy+",");
						sql8_2.append( "        BRESULTS ="+dblbresults_yy );
						sql8_2.append( "  WHERE FDCODE = '"+strfdcode+"'");
						sql8_2.append( "     AND BGTYY = '"+strbgtyy+"'");
						sql8_2.append( "    AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'");
						sql8_2.append( "    AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'");
						sql8_2.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'");
						sql8_2.append( "    AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'");
						sql8_2.append( "    AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'");
						//System.out.println("sql8_2"+sql8_2.toString());
						GauceStatement gsmt8_2 = conn.getGauceStatement(sql8_2.toString());
						gsmt8_2.executeUpdate();
						gsmt8_2.close();
					
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//예산관리 Dtl 실적 (+)   결재전 실적(-)  승인 :Y  (update) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						
						Statement stmt8_3 = conn.createStatement();
						StringBuffer sql8_3 = new StringBuffer();
						sql8_3.append( " SELECT RESULTS,BRESULTS  ");
						sql8_3.append( "   FROM ACCOUNT.BGTDTL    ");
						sql8_3.append( "  WHERE FDCODE = '"+strfdcode+"'");
						sql8_3.append( "    AND BGTYY = '"+strbgtyy+"'");
						sql8_3.append( "    AND BGTMM= '"+strbgtmm+"'");
						sql8_3.append( "   AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'");
						sql8_3.append( "   AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'");
						sql8_3.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'");
						sql8_3.append( "   AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'");
						sql8_3.append( "    AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'");
						//System.out.println("sql8_3"+sql8_3.toString());
						ResultSet rs8_3 = stmt8_3.executeQuery(sql8_3.toString()); 

						dblresults_mm =0;
						dblbresults_mm=0;
						if(rs8_3.next()){
							dblresults_mm = rs8_3.getDouble(1);
							dblbresults_mm =rs8_3.getDouble(2);
						}
						rs8_3.close();
						stmt8_3.close();

 
						dblresults_mm=dblresults_mm+dbldetot_new+dblcrtot_new;   //실적
						dblbresults_mm=dblbresults_mm-dbldetot_new-dblcrtot_new; //결재전실적

						StringBuffer sql8_4 = new StringBuffer();
						sql8_4.append( " UPDATE ACCOUNT.BGTDTL SET  ");
						sql8_4.append( "        RESULTS = "+dblresults_mm+",");
						sql8_4.append( "        BRESULTS ="+dblbresults_mm );
						sql8_4.append( " WHERE FDCODE = '"+strfdcode+"'" );
						sql8_4.append( "   AND BGTYY = '"+strbgtyy+"'" );
						sql8_4.append( "   AND BGTMM ='"+strbgtmm+"'" );
						sql8_4.append( "   AND BGTDIV = '"+rows[j].getString(idxBGTDIV)+"'" );
						sql8_4.append( "   AND BGTDPT = '"+rows[j].getString(idxBGTDEPT)+"'" );
						sql8_4.append( "   AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
						sql8_4.append( "   AND FSREFCD = '"+rows[j].getString(idxTYPE_FSREFCD)+"'" );
						sql8_4.append( "   AND SATCODE = '"+rows[j].getString(idxTYPE_FSREFVAL)+"'");
						//System.out.println("sql8_4"+sql8_4.toString());
						GauceStatement gsmt8_4 = conn.getGauceStatement(sql8_4.toString());
						gsmt8_4.executeUpdate();
						gsmt8_4.close();
                    }

					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//자금관리원장 Start        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//추가 : 어음수표 수불부 
					//      지급어음 전표입력시 발생(차변=0, 대변<>0)에  해당될 경우 처리구분(0-->1)로 변경
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					//System.out.println("111j:::"+j+"idxFUNDDIV::"+rows[j].getString(idxFUNDDIV)+"::");
					
					if(!rows[j].getString(idxFUNDDIV).equals("")&&!rows[j].getString(idxFUNDDIV).equals("00")){ 
						
						//System.out.println("222j:::"+j+"idxFUNDDIV::"+rows[j].getString(idxFUNDDIV)+"::");
						//System.out.println("222j:::"+j+"idxFUNDDIV::"+rows[j].getString(idxFUNDDIV)+"::");
						//**logger.dbg.println(this,"step4 자금관리원장");
						
						//관리번호찾기/////////////////////////////////////////////////////////////////////////////
						//10 20 30(예금,적금,차입금)  --계좌번호
						//40      (투자자산)        --증권번호
						//50 60   (받을어음,지급어음) --어음번호(0967)/수표번호(1102)
						
						//System.out.println("SETP1");

						//초기화
						strRefcode_9=" ";
						dbldrfamt9_new=0;
						dblcrfamt9_new=0;
						strStrdate_9="";     //발생일자
						strEnddate_9="";     //만기일자
						strCust_9="";
						strStatdiv="";
						strCurdiv="";
						strBancod_9="";
						strVend_cd_9="";
						dblExrate=0;
						dblInrate=0;
						dblOutrate=0;

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
							
							//System.out.println("SETP2");
						}else if(rows[j].getString(idxFUNDDIV).equals("40")){
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("0023")){     //증권번호 관리항목에 넣은 후 변경해야함.
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
						
						//System.out.println("SETP3");

						//외화금액 찾기////////////////////////////////////////////////////////////////////////////
						for (int p=0;p<=8;p++){
							if(rows[j].getString(idxFSREFCD[p]).equals("1045")){
								//System.out.println("SETP31:::dbldetot_new::"+dbldetot_new);
								//System.out.println("SETP31:::dblcrtot_new::"+dblcrtot_new);
								//System.out.println("SETP31:::rows[j].getString(idxFSREFVAL[p])::"+rows[j].getString(idxFSREFVAL[p]));
								 
								if(rows[j].getString(idxFSREFVAL[p]).equals("-")){
									rows[j].setString(idxFSREFVAL[p],"0");
								}
								
								
								 if(dbldetot_new!=0&&dblcrtot_new==0){
										dbldrfamt9_new = Double.parseDouble(rows[j].getString(idxFSREFVAL[p]));   //외화차변
								    break;
								 }else if(dbldetot_new==0&&dblcrtot_new!=0){
										dblcrfamt9_new = Double.parseDouble(rows[j].getString(idxFSREFVAL[p]));   //외화대변
								    break;
								 }
							}	  
						}
						
						//System.out.println("SETP4");
						///////////////////////////////////////////////////////////////////////////////////////////

       		           //발생일자  만기일자 찾기////////////////////////////////////////////////////////////////////////////
						if(rows[j].getString(idxFUNDDIV).equals("10")){
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1")){
									strStrdate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
						}else if(rows[j].getString(idxFUNDDIV).equals("20")){
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1")){
									strStrdate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1")){
									strEnddate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
							
						}else if(rows[j].getString(idxFUNDDIV).equals("30")){
							//System.out.println("SETP5");
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1")){
									strStrdate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1")){
									strEnddate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
							//System.out.println("SETP6");
						}else if(rows[j].getString(idxFUNDDIV).equals("40")){
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1")){
									strStrdate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1")){
									strEnddate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
						}else if(rows[j].getString(idxFUNDDIV).equals("50")||rows[j].getString(idxFUNDDIV).equals("60")){
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("0968")){
									strStrdate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("0969")){
									strEnddate_9 = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}
						}
						
						
						//System.out.println("SETP7");

						///////////////////////////////////////////////////////////////////////////////////////////
           
                       //거래처///////////////////////////////////////////////////////////////////////////////////
                        for (int p=0;p<=8;p++){
							if(rows[j].getString(idxFSREFCD[p]).equals("0020")){
								 strVend_cd_9 = rows[j].getString(idxFSREFVAL[p]);
								 break;
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////

						//은행/////////////////////////////////////////////////////////////////////////////////////
						for (int p=0;p<=8;p++){
							if(rows[j].getString(idxFSREFCD[p]).equals("0022")){
								 strBancod_9 = rows[j].getString(idxFSREFVAL[p]);
								 break;
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////

						//수신 여신 이율///////////////////////////////////////////////////////////////////////////
						dblInrate=0;
						dblOutrate=0;
						///////////////////////////////////////////////////////////////////////////////////////////

						//통화구분(통화명)/////////////////////////////////////////////////////////////////////////
						for (int p=0;p<=8;p++){
							if(rows[j].getString(idxFSREFCD[p]).equals("1043")){
								 strCurdiv = rows[j].getString(idxFSREFVAL[p]);
								 break;
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////
 
						//System.out.println("SETP8"); 

						//환율/////////////////////////////////////////////////////////////////////////////////////
						for (int p=0;p<=8;p++){
							if(rows[j].getString(idxFSREFCD[p]).equals("1")){
								 dblExrate = Double.parseDouble(rows[j].getString(idxFSREFVAL[p]));
								 break;
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////
						
						//System.out.println("SETP9");
 
						//**logger.dbg.println(this,"step4 자금관리원장 -조회");
						//조회
						Statement stmt9 = conn.createStatement();
						StringBuffer sql9 = new StringBuffer();
						sql9.append( " SELECT DRAMT, CRAMT, DRFAMT, CRFAMT " );
						sql9.append( "   FROM ACCOUNT.AFUNDLDG    " );
						sql9.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql9.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
						sql9.append( "    AND FUNDDIV= '"+rows[j].getString(idxFUNDDIV)+"'" );
						sql9.append( "    AND REFCODE2 = '"+strRefcode_9+"'");		
						
						//System.out.println("sql9"+sql9.toString());
						ResultSet rs9 = stmt9.executeQuery(sql9.toString()); 

						dbldramt9=0;
						dblcramt9=0;
						dbldrfamt9=0;
						dblcrfamt9=0;

						if(rs9.next()){
							strGubun_9="1";  
							dbldramt9 = rs9.getDouble(1);
							dblcramt9 = rs9.getDouble(2);
							dbldrfamt9 =rs9.getDouble(3);
							dblcrfamt9 =rs9.getDouble(4);
						}
						rs9.close();
						stmt9.close();

						dbldramt9 = dbldramt9 + dbldetot_new; 
						dblcramt9 = dblcramt9 + dblcrtot_new;
						dbldrfamt9 = dbldrfamt9 +dbldrfamt9_new;
						dblcrfamt9 = dblcrfamt9 +dblcrfamt9_new;

						//처리구분/////////////////////////////////////////////////////////////////////////////////
						//예금은 항상 0 - 진행중임.
						//그외 : 차변 금액과 대변금액이 동일하면 - 1 완료 (차변과 대변이 0이 아님)
						if(rows[j].getString(idxFUNDDIV).equals("10")){
							strStatdiv="0";
						}else{
							if(dbldramt9!=0&&dblcramt9!=0&&dblcramt9==dblcramt9){
								strStatdiv="1";
							}else{
								strStatdiv="0";
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////

						if(strGubun_9.equals("1")){ //update 
						  StringBuffer sql9_1 = new StringBuffer();
							//**logger.dbg.println(this,"step41 자금관리원장");
							sql9_1.append( " UPDATE ACCOUNT.AFUNDLDG SET  " );
							sql9_1.append( "        DRAMT = "+dbldramt9+"," );
							sql9_1.append( "        CRAMT = "+dblcramt9+"," );
							sql9_1.append( "        DRFAMT = "+dbldrfamt9+"," );
							sql9_1.append( "        CRFAMT = "+dblcrfamt9+"," );
							sql9_1.append( "        FSDAT1 = '"+rows[j].getString(idxFSDAT)+"'," );
							sql9_1.append( "        FSNBR1 = '"+rows[j].getString(idxFSNBR)+"'," );
							sql9_1.append( "        FSSEQ1 = '"+rows[j].getString(idxFSSEQ)+"'," );
							sql9_1.append( "        ACTDAT1 = '"+rows[j].getString(idxACTDAT)+"'," );
							sql9_1.append( "        STATDIV = '"+strStatdiv+"'," );
							sql9_1.append( "        UPDT = '"+str1+"'," );
							sql9_1.append( "        UPID = '"+str2+"'" );
							sql9_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
							sql9_1.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
							sql9_1.append( "    AND FUNDDIV= '"+rows[j].getString(idxFUNDDIV)+"'" );
							sql9_1.append( "    AND REFCODE2 = '"+strRefcode_9+"'");		
														 
							//**logger.dbg.println(this,"sql9_1.toString():::"+sql9_1.toString());
							//System.out.println("sql9_1"+sql9_1.toString());
							GauceStatement gsmt9_1 = conn.getGauceStatement(sql9_1.toString());
							gsmt9_1.executeUpdate();
							gsmt9_1.close();
						}else{                      //insert
						  //logger.dbg.println(this,"step42자금관리원장");
							
						  //System.out.println("strRefcode_9::"+strRefcode_9);	
						  StringBuffer sql9_2 = new StringBuffer();
							sql9_2.append( " INSERT INTO ACCOUNT.AFUNDLDG( " );
							sql9_2.append( "  FDCODE,  ATCODE,  FUNDDIV, REFCODE2, STRDATE, " );
							sql9_2.append( "  ENDDATE, DRAMT,   CRAMT,   VEND_CD,  BANCOD, " );
							sql9_2.append( "  INRATE,  OUTRATE, DRFAMT,  CRFAMT,   CURDIV, " );
							sql9_2.append( "  EXRATE,  STATDIV, REMARK,  FSDAT,    FSNBR, " );
							sql9_2.append( "  FSSEQ,   ACTDAT,  FSDAT1,  FSNBR1,   FSSEQ1,  " );
							sql9_2.append( "  ACTDAT1, FSREFCD, FSREFVAL " );
							sql9_2.append( "  ) VALUES ( " ); 
							sql9_2.append( "  '"+rows[j].getString(idxFDCODE)+"'," );
							sql9_2.append( "  '"+rows[j].getString(idxATCODE)+"'," );
							sql9_2.append( "  '"+rows[j].getString(idxFUNDDIV)+"'," );
							sql9_2.append( "  '"+strRefcode_9+"'," );
							sql9_2.append( "  '"+strStrdate_9+"'," );
							sql9_2.append( "  '"+strEnddate_9+"'," );
							sql9_2.append( "  "+dbldramt9+"," );
							sql9_2.append( "  "+dblcramt9+"," );
							sql9_2.append( "  '"+strVend_cd_9+"'," );
							sql9_2.append( "  '"+strBancod_9+"'," );
							sql9_2.append( "  "+dblInrate+"," );
							sql9_2.append( "  "+dblOutrate+"," );
							sql9_2.append( "  "+dbldrfamt9+"," );
							sql9_2.append( "  "+dblcrfamt9+"," );
							sql9_2.append( "  '"+strCurdiv+"'," );
							sql9_2.append( "  "+dblExrate+"," );
							sql9_2.append( "  '"+strStatdiv+"',?," );
							//sql9_2.append( "  '"+rows[j].getString(idxREMARK)+"'," );
							sql9_2.append( "  '"+rows[j].getString(idxFSDAT)+"'," );
							sql9_2.append( "  '"+rows[j].getString(idxFSNBR)+"'," );
							sql9_2.append( "  '"+rows[j].getString(idxFSSEQ)+"'," );
							sql9_2.append( "  '"+rows[j].getString(idxACTDAT)+"'," );
							sql9_2.append( "  ''," );
							sql9_2.append( "  ''," );
							sql9_2.append( "  ''," );
							sql9_2.append( "  ''," );
							sql9_2.append( "  '"+strFsrefcd_9+"'," );
							sql9_2.append( "  '"+strFsrefval_9+"')");
							
							//System.out.println("sql9_2"+sql9_2.toString());

							GauceStatement gsmt9_2= conn.getGauceStatement(sql9_2.toString());

							//2010.10.22 jys 적요 세미콜론 입력가능하게함.
							gsmt9_2.setGauceDataRow(rows[j]);
							gsmt9_2.bindColumn(1, idxREMARK);

							gsmt9_2.executeUpdate();
							gsmt9_2.close();
							
							//System.out.println("sql9_2:: SUCC");
						}


						/////////////////////////////////////////////
						//어음수표수불부 update
						//지급어음 전표 발생에 해당 될경우  0-->1
						/////////////////////////////////////////////
						//**logger.dbg.println(this,"step43 자금관리원장");
						//2016.09.21 jys :::: 현재시점에서 사용하지 않는 테이블 ....
						if(rows[j].getString(idxFUNDDIV).equals("60")&&dbldetot_new==0&&dblcrtot_new!=0){
							StringBuffer sql9_3 = new StringBuffer();
							sql9_3.append( " UPDATE ACCOUNT.ABILLCHK SET  ");
							sql9_3.append( "        STATDIV = '1'," );
							sql9_3.append( "        UPDT = '"+str1+"'," );
							sql9_3.append( "        UPID = '"+str2+"'" );
							sql9_3.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
							sql9_3.append( "    AND ATCODE = '"+rows[j].getString(idxATCODE)+"'" );
							sql9_3.append( "    AND FUNDDIV= '"+rows[j].getString(idxFUNDDIV)+"'" );
							sql9_3.append( "    AND REFCODE2 = '"+strRefcode_9+"'");
										
							//System.out.println("sql9_3"+sql9_3.toString());
							GauceStatement gsmt9_3 = conn.getGauceStatement(sql9_3.toString());
							gsmt9_3.executeUpdate();
							gsmt9_3.close();
						}
					}
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//자금관리원장 End       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
  
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//반제원장      Start       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//반제계정이면서, 기준차대인건은 반제 발생건임. 
					//예> 법인카드미지급금, 대변 ,  대변금액이 <> 0
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					if(rows[j].getString(idxBANJAEYN).equals("Y")){
						//**logger.dbg.println(this,"step5 반제원장");
		 				if((rows[j].getString(idxATDECR).equals("1")&&dbldetot_new!=0)||(rows[j].getString(idxATDECR).equals("2")&&dblcrtot_new!=0)){
              
							//반제단위 찾기
							if(!rows[j].getString(idxBJFSREFCD).equals("")){
								strBjfsrefcd="";
								strBjfsrefval="";
								strBjfsrefcd =rows[j].getString(idxBJFSREFCD);
								for (int p=0;p<=8;p++){
									if(rows[j].getString(idxFSREFCD[p]).equals(strBjfsrefcd)){
										strBjfsrefval = rows[j].getString(idxFSREFVAL[p]);
										break;
									}
								}
					         }

							//부서찾기
							strBjdeptcd="";
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("0002")){
									 strBjdeptcd = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}

							//거래처찾기
							strBjvendcd="";
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("0020")){
									 strBjvendcd = rows[j].getString(idxFSREFVAL[p]);
									 break;
								}
							}

							//가수금일 경우 가수일자(입금일자 - 1125) 추가
							strBjfsrefcd2="";
							strBjfsrefval2="";
							if(rows[j].getString(idxATCODE).equals("2101300")){
								strBjfsrefcd2="1125";
								for (int p=0;p<=8;p++){
									if(rows[j].getString(idxFSREFCD[p]).equals("1125")){
										 strBjfsrefval2 = rows[j].getString(idxFSREFVAL[p]);
										 break;
									}
								}
							}else if(rows[j].getString(idxATCODE).equals("2100400")){ //단기차입금 경우 만기일(만기일자 - 1044) 추가
								for (int p=0;p<=8;p++){
									if(rows[j].getString(idxFSREFCD[p]).equals("1044")){
										 strBjfsrefcd2="1044";
										 strBjfsrefval2 = rows[j].getString(idxFSREFVAL[p]);
										 break;
									}
								}
							}else if(rows[j].getString(idxATCODE).equals("2100920")){ //상품권 선수금 상품권판매일자(판매일자 1130) 추가
								for (int p=0;p<=8;p++){
									if(rows[j].getString(idxFSREFCD[p]).equals("1130")){
										 strBjfsrefcd2="1130";
										 strBjfsrefval2 = rows[j].getString(idxFSREFVAL[p]);
										 break;
									}
								}
							}else if(rows[j].getString(idxATCODE).equals("2100520")){ //2007.06.29 미지급금(법인카드)의 실제 거래처를 추가함
								for (int p=0;p<=8;p++){
									if(rows[j].getString(idxFSREFCD[p]).equals("0029")){
										 strBjfsrefcd2="0029";
										 strBjfsrefval2 = rows[j].getString(idxFSREFVAL[p]);
										 break;
									}
								}
							}


							//받을어음-1110320&&지급어음(외상매입)-2100120 &&지급어음(미지급금)-2100530경우 
							//발행일(0968), 만기일(0969), 은행(0022) 추가
						 strBjfsrefcd3="";
						 strBjfsrefval3="";
						 strBjfsrefetc="";
						 if(rows[j].getString(idxATCODE).equals("1110320")||rows[j].getString(idxATCODE).equals("2100120")||rows[j].getString(idxATCODE).equals("2100530")){
								for (int p=0;p<=8;p++){
									if(rows[j].getString(idxFSREFCD[p]).equals("0968")){ //발행일자
										 strBjfsrefcd2="0968";
										 strBjfsrefval2 = rows[j].getString(idxFSREFVAL[p]);
									}

									if(rows[j].getString(idxFSREFCD[p]).equals("0969")){ //만기일자
										 strBjfsrefcd3="0969";
										 strBjfsrefval3 = rows[j].getString(idxFSREFVAL[p]);
									}

									if(rows[j].getString(idxFSREFCD[p]).equals("0022")){ //은행
										 strBjfsrefetc = rows[j].getString(idxFSREFVAL[p]);
									}
								}
							}


							//2007.06.01추가 //반제가 걸린 원장을 임의로 취소한 후 다시 결재 할 경우 update함.
							//결재취소한 동일한 전표번호만 입력해야함.
							//관리항목 수정은 가능함.
							if(!str4.equals("")&&!str5.equals("")){
									
								double dblcnt=0;
								//반제원장에 존재확인
								Statement stmt10_0 = conn.createStatement();
								StringBuffer sql10_0 = new StringBuffer();
								sql10_0.append( " SELECT COUNT(*) CNT  ");
								sql10_0.append( "   FROM ACCOUNT.BANJAEMST ");
								sql10_0.append( "    WHERE  FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
								sql10_0.append( "      AND  TSDAT  = '"+rows[j].getString(idxFSDAT)+"'" );
								sql10_0.append( "      AND  TSNBR  = '"+rows[j].getString(idxFSNBR)+"'" );
								sql10_0.append( "      AND  TSSEQ  = '"+rows[j].getString(idxFSSEQ)+"'");

								ResultSet rs10_0 = stmt10_0.executeQuery(sql10_0.toString()); 

								if(rs10_0.next()){
									 dblcnt= rs10_0.getDouble(1);
								}
								rs10_0.close();
								stmt10_0.close();
                
								if(dblcnt==0){
									StringBuffer sql10_1 = new StringBuffer();
									//logger.dbg.println(this,"step44반제mst s");
									sql10_1.append( "  INSERT INTO ACCOUNT.BANJAEMST( " );
									sql10_1.append( "  FDCODE,  TSDAT,   TSNBR,   TSSEQ,    ATCODE, " );
									sql10_1.append( "  DEPTCD,  VENDCD,  FSREFCD, FSREFVAL, DEAMT, " );
									sql10_1.append( "  CRAMT,   STATUS,  SSDAT,   SSNBR,    FSNUM, " );
									sql10_1.append( "  REMARK,  WRDT,    WRID,    FSREFCD2, FSREFVAL2," );
									sql10_1.append( "  FSREFCD3, FSREFVAL3, FSREFETC,  GUBUN " );
									sql10_1.append( "  ) VALUES ( " );
									sql10_1.append( "  '"+rows[j].getString(idxFDCODE)+"'," );
									sql10_1.append( "  '"+rows[j].getString(idxFSDAT)+"'," );
									sql10_1.append( "  '"+rows[j].getString(idxFSNBR)+"'," );
									sql10_1.append( "  '"+rows[j].getString(idxFSSEQ)+"'," );
									sql10_1.append( "  '"+rows[j].getString(idxATCODE)+"'," );
									sql10_1.append( "  '"+strBjdeptcd+"'," );
									sql10_1.append( "  '"+strBjvendcd+"'," );
									sql10_1.append( "  '"+strBjfsrefcd+"'," );
									sql10_1.append( "  '"+strBjfsrefval+"'," );
									sql10_1.append( "  "+dbldetot_new+"," );
									sql10_1.append( "  "+dblcrtot_new+"," );
									sql10_1.append( "  '0'," );
									sql10_1.append( "  '"+rows[j].getString(idxSSDAT)+"'," );
									sql10_1.append( "  '"+rows[j].getString(idxSSNBR)+"'," );
									sql10_1.append( "  '"+rows[j].getString(idxFSNUM)+"',?," );								
									//sql10_1.append( "  '"+rows[j].getString(idxREMARK)+"'," );
									sql10_1.append( "  '"+str1+"'," );
									sql10_1.append( "  '"+str2+"'," );
									sql10_1.append( "  '"+strBjfsrefcd2+"'," );
									sql10_1.append( "  '"+strBjfsrefval2+"'," );
									sql10_1.append( "  '"+strBjfsrefcd3+"'," );
									sql10_1.append( "  '"+strBjfsrefval3+"'," );
									sql10_1.append( "  '"+strBjfsrefetc+"'," );
									sql10_1.append( "  'Y')");  //전표입력 후 결재완료건인 경우

									//System.out.println("sql10_1"+sql10_1.toString());
									GauceStatement gsmt10_1= conn.getGauceStatement(sql10_1.toString());

									//2010.10.22 jys 적요 세미콜론 입력가능하게함.
									gsmt10_1.setGauceDataRow(rows[j]);
									gsmt10_1.bindColumn(1, idxREMARK);

									gsmt10_1.executeUpdate();
									gsmt10_1.close();

									//logger.dbg.println(this,"step44반제mst e");
									//System.out.println("sql10_1: SUCC");
								
								}else{
									  //logger.dbg.println(this,"step44반제mst s2");
									 StringBuffer sql10_1 = new StringBuffer();
									 sql10_1.append( " UPDATE  ACCOUNT.BANJAEMST SET " );
									 sql10_1.append( "   DEAMT = DEAMT +"+dbldetot_new+"," );
									 sql10_1.append( "    CRAMT = CRAMT +"+dblcrtot_new+"," );
									 sql10_1.append( "    DEPTCD = '"+strBjdeptcd+"'," );
									 sql10_1.append( "    FSREFCD = '"+strBjfsrefcd+"'," );
									 sql10_1.append( "    FSREFVAL = '"+strBjfsrefval+"'," );
									 //sql10_1.append( "    REMARK = '"+rows[j].getString(idxREMARK)+"'," );
									 sql10_1.append( "    REMARK = ?," );
									 sql10_1.append( "    FSREFCD2 = '"+strBjfsrefcd2+"'," );
									 sql10_1.append( "    FSREFVAL2 = '"+strBjfsrefval2+"'," );
									 sql10_1.append( "    FSREFCD3 = '"+strBjfsrefcd3+"'," );
									 sql10_1.append( "    FSREFVAL3 = '"+strBjfsrefval3+"'," );
									 sql10_1.append( "    FSREFETC = '"+strBjfsrefetc+"'" );
									 sql10_1.append( "    WHERE  FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
									 sql10_1.append( "      AND  TSDAT  = '"+rows[j].getString(idxFSDAT)+"'" );
									 sql10_1.append( "      AND  TSNBR  = '"+rows[j].getString(idxFSNBR)+"'" );
									 sql10_1.append( "      AND  TSSEQ  = '"+rows[j].getString(idxFSSEQ)+"'");
										
									//System.out.println("2sql10_1"+sql10_1.toString());
									GauceStatement gsmt10_1 = conn.getGauceStatement(sql10_1.toString());
                   
									//2010.10.22 jys 적요 세미콜론 입력가능하게함.
									gsmt10_1.setGauceDataRow(rows[j]);
									gsmt10_1.bindColumn(1, idxREMARK);

									gsmt10_1.executeUpdate();
									gsmt10_1.close(); 
									//logger.dbg.println(this,"step44반제mst e2");
								}

							}else{
								StringBuffer sql10_1 = new StringBuffer();
								//logger.dbg.println(this,"step44반제mst s3");
								sql10_1.append( "  INSERT INTO ACCOUNT.BANJAEMST( " );
								sql10_1.append( "  FDCODE,  TSDAT,   TSNBR,   TSSEQ,    ATCODE, " );
								sql10_1.append( "  DEPTCD,  VENDCD,  FSREFCD, FSREFVAL, DEAMT, " );
								sql10_1.append( "  CRAMT,   STATUS,  SSDAT,   SSNBR,    FSNUM, " );
								sql10_1.append( "  REMARK,  WRDT,    WRID,    FSREFCD2, FSREFVAL2," );
								sql10_1.append( "  FSREFCD3, FSREFVAL3, FSREFETC,  GUBUN " );
								sql10_1.append( "  ) VALUES ( " );
								sql10_1.append( "  '"+rows[j].getString(idxFDCODE)+"'," );
								sql10_1.append( "  '"+rows[j].getString(idxFSDAT)+"'," );
								sql10_1.append( "  '"+rows[j].getString(idxFSNBR)+"'," );
								sql10_1.append( "  '"+rows[j].getString(idxFSSEQ)+"'," );
								sql10_1.append( "  '"+rows[j].getString(idxATCODE)+"'," );
								sql10_1.append( "  '"+strBjdeptcd+"'," );
								sql10_1.append( "  '"+strBjvendcd+"'," );
								sql10_1.append( "  '"+strBjfsrefcd+"'," );
								sql10_1.append( "  '"+strBjfsrefval+"'," );
								sql10_1.append( "  "+dbldetot_new+"," );
								sql10_1.append( "  "+dblcrtot_new+"," );
								sql10_1.append( "  '0'," );
								sql10_1.append( "  '"+rows[j].getString(idxSSDAT)+"'," );
								sql10_1.append( "  '"+rows[j].getString(idxSSNBR)+"'," );
								sql10_1.append( "  '"+rows[j].getString(idxFSNUM)+"',?," );
								//sql10_1.append( "  '"+rows[j].getString(idxREMARK)+"'," );
								sql10_1.append( "  '"+str1+"'," );
								sql10_1.append( "  '"+str2+"'," );
								sql10_1.append( "  '"+strBjfsrefcd2+"'," );
								sql10_1.append( "  '"+strBjfsrefval2+"'," );
								sql10_1.append( "  '"+strBjfsrefcd3+"'," );
								sql10_1.append( "  '"+strBjfsrefval3+"'," );
								sql10_1.append( "  '"+strBjfsrefetc+"'," );
								sql10_1.append( "  'Y')");  //전표입력 후 결재완료건인 경우

								//System.out.println("3ql10_1"+sql10_1.toString());
								GauceStatement gsmt10_1= conn.getGauceStatement(sql10_1.toString());

								//2010.10.22 jys 적요 세미콜론 입력가능하게함.
								gsmt10_1.setGauceDataRow(rows[j]);
								gsmt10_1.bindColumn(1, idxREMARK);

								gsmt10_1.executeUpdate();
								gsmt10_1.close();
								//logger.dbg.println(this,"step44반제mst e3");
							}
						}
					}
 
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//반제원장      End         >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//현금실사현황     START       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					//System.out.println("현금실사 START");
					
					if(rows[j].getString(idxATCODE).equals("1110110")||rows[j].getString(idxATCODE).equals("1110120")){
						
						if(rows[j].getString(idxATCODE).equals("1110110")){ //현금원화
							
							//현금 원화는 TOTALBAL에서 가져오기 때문에 패스
							
						}else if(rows[j].getString(idxATCODE).equals("1110120")){ //현금외화
							//System.out.println("현금외화");
							strcashnm="";
							strcashcd="";
							dbldeamt =0;
							dblcramt =0;
							
							//외화금액이 기준이기 때문에 여기엔 원화금액이 들어감.
							dblfdeamt=0;
							dblfcramt=0;
							dblfdeamt = rows[j].getDouble(idxCHAAMT);
							dblfcramt = rows[j].getDouble(idxDAEAMT);
							
							strfsseq = rows[j].getString(idxFSSEQ);
							
							for (int p=0;p<=8;p++){
								if(rows[j].getString(idxFSREFCD[p]).equals("1043")){ //통화명
									 strcashcd = rows[j].getString(idxFSREFVAL[p]);
									 if(strcashcd.equals("02")){
										 strcashnm ="USD";
									 }else if(strcashcd.equals("04")){
										 strcashnm ="EUR";
									 }else if(strcashcd.equals("31")){
										 strcashnm ="CNY";
									 }else if(strcashcd.equals("03")){
										 strcashnm ="JPY";	 
									 }
								}

								if(rows[j].getString(idxFSREFCD[p]).equals("1045")){ //외화금액
									 if(rows[j].getDouble(idxCHAAMT)!=0){
										 strdeamt= rows[j].getString(idxFSREFVAL[p]);
										 dbldeamt = Double.parseDouble(strdeamt);								 
									 }else if(rows[j].getDouble(idxDAEAMT)!=0){
										 strcramt = rows[j].getString(idxFSREFVAL[p]);
										 dblcramt = Double.parseDouble(strcramt);
									 }//if
								}//if

							}//for	
							
							StringBuffer sql11_1 = new StringBuffer();
							  
						    sql11_1.append( " MERGE INTO ACCOUNT.CASHHAND MC \n ");
						    sql11_1.append( " USING DUAL \n ");
						    sql11_1.append( " ON (  MC.FDCODE = '"+strfdcode+"' AND MC.FSDAT ='"+strfsdat+"' AND MC.FSNBR = '"+strfsnbr+"' AND MC.FSSEQ ='"+strfsseq+"' ) \n ");
						    sql11_1.append( " WHEN MATCHED THEN \n ");
						    sql11_1.append( " 	   UPDATE SET MC.CASHNM='"+strcashnm+"', \n ");
						    sql11_1.append( "                 MC.CASHCD='"+strcashcd+"',   \n ");
						    sql11_1.append( "                 MC.ACTDAT='"+stractdat+"',\n ");
						    sql11_1.append( "                 MC.DEAMT="+dbldeamt+",\n ");
						    sql11_1.append( "                 MC.CRAMT="+dblcramt+",\n ");
						    sql11_1.append( "                 MC.FDEAMT="+dbldeamt+",\n ");
						    sql11_1.append( "                 MC.FCRAMT="+dblcramt+",\n ");
						    sql11_1.append( "                 MC.UPID ='"+str2+"',\n ");
						    sql11_1.append( "                 MC.UPDT =SYSDATE  \n ");
						    sql11_1.append( " WHEN NOT MATCHED THEN \n ");
						    sql11_1.append( "      INSERT (  FDCODE, FSDAT,	FSNBR,	FSSEQ, 	CASHNM,	CASHCD,	ACTDAT,	DEAMT,	CRAMT, WRID, WRDT, FDEAMT, FCRAMT  )  \n ");
						    sql11_1.append( "     VALUES (  '"+strfdcode+"','"+strfsdat+"','"+strfsnbr+"','"+strfsseq+"','"+strcashnm+"','"+strcashcd+"','"+stractdat+"',"+dbldeamt+","+dblcramt+",'"+str2+"',SYSDATE,"+dblfdeamt+","+dblfcramt+"  )  \n ");
							      
						    //ystem.out.println("sql11_1.toString()::"+sql11_1.toString());
						    GauceStatement gsmt11_1 = conn.getGauceStatement(sql11_1.toString());
							gsmt11_1.executeUpdate();
							gsmt11_1.close(); 
						}//if
						//System.out.println("현금실사     END  ::");    
					}
						
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//현금실사     END       >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					
					
					
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//전표Mst && 결재완료 Update>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//**logger.dbg.println(this,"step9 - 결재완료");
					if(!strfdcode.equals("")&&!strfsdat.equals("")&&!strfsnbr.equals("")){		
						  	StringBuffer sql9_0 = new StringBuffer();
						  	sql9_0.append( " UPDATE  ACCOUNT.FSLIPDTL SET " );
						  	sql9_0.append( "  SSDAT = '"+strssdat+"'," );
							sql9_0.append( "  SSNBR = '"+strssnbr+"'" );
							sql9_0.append( "  WHERE  FDCODE = '"+strfdcode+"'" );
							sql9_0.append( "    AND  FSDAT  = '"+strfsdat+"'" );
							sql9_0.append( "    AND  FSNBR  = '"+strfsnbr+"'" );
							sql9_0.append( "    AND  FSSEQ  = '"+rows[j].getString(idxFSSEQ)+"'");
													
							GauceStatement gsmt9_0 = conn.getGauceStatement(sql9_0.toString());
							gsmt9_0.executeUpdate();
							gsmt9_0.close(); 

							//2007.05.11 추가(정영식)>>
							StringBuffer sql99 = new StringBuffer();
							sql99.append( " UPDATE  ACCOUNT.FSLIPREF SET " );
							sql99.append( "  SSDAT = '"+strssdat+"'," );
							sql99.append( "  SSNBR = '"+strssnbr+"'" );
							sql99.append( "  WHERE  FDCODE = '"+strfdcode+"'" );
							sql99.append( "    AND  FSDAT  = '"+strfsdat+"'" );
							sql99.append( "    AND  FSNBR  = '"+strfsnbr+"'" );
							sql99.append( "    AND  FSSEQ  = '"+rows[j].getString(idxFSSEQ)+"'");
													
							GauceStatement gsmt99 = conn.getGauceStatement(sql99.toString());
							gsmt99.executeUpdate();
							gsmt99.close(); 
							//<<

						 if(j==0){
							StringBuffer sql9 = new StringBuffer();
							sql9.append( " UPDATE  ACCOUNT.FSLIPMST SET " );
							sql9.append( "         FSSTAT = 'Y'," );
							sql9.append( "         SGNDAT = '"+strsgndat+"'," );
							sql9.append( "         ACTDAT = '"+stractdat+"'," );
							sql9.append( "         SSDAT = '"+strssdat+"'," );
							sql9.append( "         SSNBR = '"+strssnbr+"'" );
							sql9.append( "  WHERE  FDCODE = '"+strfdcode+"'" );
							sql9.append( "    AND  FSDAT  = '"+strfsdat+"'" );
							sql9.append( "    AND  FSNBR  = '"+strfsnbr+"'");
													
							GauceStatement gsmt9 = conn.getGauceStatement(sql9.toString());
							gsmt9.executeUpdate();
							gsmt9.close();

							////////////////////////////////////////////////////
							//Detail건수와 상관없이 전표번호 당 1건 저장
							////////////////////////////////////////////////////
						
								Statement stmt_10 = conn.createStatement();
								StringBuffer sql_10 = new StringBuffer();
								sql_10.append( " SELECT SEQ,ACCSGNID, " );
								sql_10.append( "        EMPNO,ACCSGNDAT,ACCSGNEND,FROMGB,TOGB,BIGO,BGTGB " );
								sql_10.append( "   FROM ACCOUNT.ACTSGNSTS " );
								sql_10.append( "  WHERE FDCODE='"+strfdcode+"'"  );
								sql_10.append( "    AND FSDAT='"+strfsdat+"'"  );
								sql_10.append( "    AND FSNBR='"+strfsnbr+"'"  );
								sql_10.append( "    AND SEQ  = (SELECT MAX(B.SEQ) FROM ACCOUNT.ACTSGNSTS B" );
								sql_10.append( "                  WHERE  FDCODE = B.FDCODE                " );
								sql_10.append( "                    AND  FSDAT = B.FSDAT                  " );
								sql_10.append( "                    AND  FSNBR = B.FSNBR                  " );
								sql_10.append( "                    AND  B.FDCODE = '"+strfdcode+"'" );
								sql_10.append( "                    AND  B.FSDAT ='"+strfsdat+"'" );  
								sql_10.append( "                    AND  B.FSNBR = '"+strfsnbr+"')");  

								//System.out.println("sql_10"+sql_10.toString());
								ResultSet rs_10 = stmt_10.executeQuery(sql_10.toString()); 
								
								  
								if(rs_10.next()){
									strseq= rs_10.getString(1);
									straccsgnid= rs_10.getString(2);
									strempno= rs_10.getString(3);
									straccsgndat= rs_10.getString(4);
									straccsgnend="Y";
									strfromgb= "03";
									strtogb= "05";
									strbigo= rs_10.getString(8);
									strbgtgb=rs_10.getString(9);
								}
								rs_10.close();
								stmt_10.close();

								int ichk2 = Integer.parseInt(strseq)+1;
								    strseq = String.valueOf(ichk2);
								if(ichk2<10) strseq = "0"+strseq;
								StringBuffer sql10 = new StringBuffer();
								sql10.append( "  INSERT INTO ACCOUNT.ACTSGNSTS ( " );
								sql10.append( "  FDCODE, FSDAT, FSNBR, SEQ, ACCSGNID, EMPNO, " );
								sql10.append( "  ACCSGNDAT, ACCSGNEND, FROMGB, TOGB, BIGO, BGTGB, " );
								sql10.append( "  WRDT, WRID  " );
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
								
								GauceStatement gsmt10= conn.getGauceStatement(sql10.toString());
								gsmt10.executeUpdate();
								gsmt10.close();

								//2007.05.11 추가(정영식)>>
								StringBuffer sql100 = new StringBuffer();
								sql100.append( " UPDATE ACCOUNT.ACTSGNSTS SET " );
								sql100.append( "          SSDAT = '"+strssdat+"'," );
								sql100.append( "          SSNBR = '"+strssnbr+"'"  );
								sql100.append( "   WHERE  FDCODE = '"+strfdcode+"'" );
								sql100.append( "     AND  FSDAT  = '"+strfsdat+"'"  );
								sql100.append( "     AND  FSNBR  = '"+strfsnbr+"'");
														
								GauceStatement gsmt100 = conn.getGauceStatement(sql100.toString());
								gsmt100.executeUpdate();
								gsmt100.close();


								//2010.08.27 JYS 추가 
								//결재취소시 상위집계상태에 UPDATE함./////////////////////////////////////////
								UpdateSql_999.append( " UPDATE ACCOUNT.UPSUMSTS SET " );
								UpdateSql_999.append( "        UPSTS = '3'," );
								UpdateSql_999.append( "        UPID ='"+str2+"'," );
								UpdateSql_999.append( "        UPDT = sysdate" );
								UpdateSql_999.append( "  WHERE GUBUN='1'       " );
								UpdateSql_999.append( "    AND FDCODE = '"+rows[j].getString(idxFDCODE)+"' " );
								UpdateSql_999.append( "    AND ACTYYMM ='"+rows[j].getString(idxACTYYMM)+"' " );

								//System.out.println("UpdateSql_999"+UpdateSql_999.toString());
								GauceStatement gsmt999 = conn.getGauceStatement(UpdateSql_999.toString());
								gsmt999.executeUpdate();
								gsmt999.close();
								//////////////////////////////////////////////////////////////////////////////
								
								
								//2017.01.16.JYS 자금신청 테이블에 지급완료일 적용 ( 회계일자가 지급완료일로 적용 됨 ) 
								UpdateSql_9999.append( " UPDATE ACCOUNT.ACAPPFUND SET " );
								UpdateSql_9999.append( "        PAYDATE = '"+stractdat+"'," );
								UpdateSql_9999.append( "        PAYSTAT = '3'," );
								UpdateSql_9999.append( "        UPID ='"+str2+"'," );
								UpdateSql_9999.append( "        UPDT = sysdate" );
								UpdateSql_9999.append( "  WHERE FDCODE   ='"+strfdcode+"' ");
								UpdateSql_9999.append( "    AND PAYFSDAT ='"+strfsdat+"' " );
								UpdateSql_9999.append( "    AND PAYFSNBR ='"+strfsnbr+"' " );
								GauceStatement gsmt9999 = conn.getGauceStatement(UpdateSql_9999.toString());
								gsmt9999.executeUpdate();
								gsmt9999.close();

							}else if(j>0){
								/*
								///^^logger.dbg.println(this,"jj2:: insert::" +j);
								if(!rows[j-1].getString(idxFDCODE).equals(strfdcode)||
									 !rows[j-1].getString(idxFSDAT).equals(strfsdat)||
									 !rows[j-1].getString(idxFSNBR).equals(strfsnbr)){
							
									Statement stmt_10 = conn.createStatement();
									String sql_10 = " SELECT SEQ,ACCSGNID,                                     "
																+ "        EMPNO,ACCSGNDAT,ACCSGNEND,FROMGB,TOGB,            "
																+ "        BIGO                                              "
																+ "   FROM ACCOUNT.ACTSGNSTS                                 "
																+ "  WHERE FDCODE='"+strfdcode+"'"  
																+ "    AND FSDAT='"+strfsdat+"'"  
																+ "    AND FSNBR='"+strfsnbr+"'"  
																+ "    AND SEQ  = (SELECT MAX(B.SEQ) FROM ACCOUNT.ACTSGNSTS B"
																+ "                  WHERE  FDCODE = B.FDCODE                "
																+ "                    AND  FSDAT = B.FSDAT                  "
																+ "                    AND  FSNBR = B.FSNBR                  "
																+ "                    AND  B.FDCODE = '"+strfdcode+"'"
																+ "                    AND  B.FSDAT ='"+strfsdat+"'"   
																+ "                    AND  B.FSNBR = '"+strfsnbr+"')";  

									ResultSet rs_10 = stmt_10.executeQuery(sql_10); 
									
										
									if(rs_10.next()){
										strseq= rs_10.getString(1);
										straccsgnid= rs_10.getString(2);
										strempno= rs_10.getString(3);
										straccsgndat= rs_10.getString(4);
										straccsgnend= "Y";
										strfromgb= "03";
										strtogb= "05";
										strbigo= rs_10.getString(8);
									}

									int ichk = Integer.parseInt(strseq)+1;
											strseq = String.valueOf(ichk);
											//////^^logger.dbg.println(this,"strseq:"+strseq);
									if(ichk<10) strseq = "0"+strseq;

									String  sql10 = "  INSERT INTO ACCOUNT.ACTSGNSTS ( "
																+ "  FDCODE, FSDAT, FSNBR, SEQ, ACCSGNID, EMPNO, "
																+ "  ACCSGNDAT, ACCSGNEND, FROMGB, TOGB, BIGO, "
																+ "  WRDT, WRID "
																+ "  ) VALUES ( "
																+ "  '"+strfdcode+"',"
																+ "  '"+strfsdat+"',"
																+ "  '"+strfsnbr+"',"
																+ "  '"+strseq+"',"
																+ "  '"+straccsgnid+"',"
																+ "  '"+strempno+"',"
																+ "  '"+straccsgndat+"',"
																+ "  '"+straccsgnend+"',"
																+ "  '"+strfromgb+"',"
																+ "  '"+strtogb+"',"
																+ "  '"+strbigo+"',"
																+ "  '"+str1+"',"
																+ "  '"+str2+"')";
																
									/////^^logger.dbg.println(this,"sql10" +sql10);

									GauceStatement gsmt10= conn.getGauceStatement(sql10);
									gsmt10.executeUpdate();
									gsmt10.close();
								}//if(!rows[j-1].getString(idxFDCODE).equals(strfdcode)||
								*/
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
					//전표Mst &&결재완료 Update End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
				}//for j
			} //try
			catch(Exception e){
				conn.rollback();

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
				
				if (userSet2 != null) {
					resGauce.enableFirstRow(userSet2);
					
					userSet2.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING));
					userSet2.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING));
					userSet2.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING));

					GauceDataRow row = null;
					row = userSet2.newDataRow();
					row.addColumnValue(strfdcode);
					row.addColumnValue(strfsdat);
					row.addColumnValue(strfsnbr);
					userSet2.addDataRow(row);
					userSet2.flush();
					//System.out.println("end");
				}
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			///^^logger.err.println(this,e);jys4988
			///^^logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}