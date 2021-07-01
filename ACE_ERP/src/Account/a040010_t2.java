package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040010_t2 extends HttpServlet{
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
			String strRefcode_9="";   //관리번호
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

			String gstrSsdat="";       //전표일자 외부입력

			String strdrfamt9_new="";  //임시
			String strcrfamt9_new="";  //임시
			String strdrfamt9_new1="";  //임시
			String strcrfamt9_new1="";  //임시
    
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
        
				String strloginfdcode = reqGauce.getParameter("v_str3");   //로그인 ID에 따른 지점 

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
				int idxCHAUPAMT     = userSet.indexOfColumn("CHAUPAMT");    //상위 차변 금액
				int idxDAEUPAMT     = userSet.indexOfColumn("DAEUPAMT");    //상위 대변 금액 
				int idxDEUPCASH     = userSet.indexOfColumn("DEUPCASH");    //상위 차변 현금 
				int idxCRUPCASH     = userSet.indexOfColumn("CRUPCASH");    //상위 대변 현금
				
				//추가된 필드 
				int idxATCURTYPE       = userSet.indexOfColumn("ATCURTYPE");     //역사적환율 구분 -Y ㅁㅁ
        
				int idxSSDAT           = userSet.indexOfColumn("SSDAT");         //전표일자  ㅁㅁ
				int idxSSNBR           = userSet.indexOfColumn("SSNBR");         //전표번호  ㅁㅁ
  
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

				GauceDataRow[] rows = userSet.getDataRows();
			
				StringBuffer InsertSql_3 = null;
				StringBuffer UpdateSql_3 = null;
				StringBuffer InsertSql_5 = null;
				StringBuffer UpdateSql_5 = null;
			
				InsertSql_3 = new StringBuffer();
				UpdateSql_3 = new StringBuffer();
				InsertSql_5 = new StringBuffer();
				UpdateSql_5 = new StringBuffer();


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

				for (int j=0;j<rows.length; j++){

					  //for (int i=0;i<=8;i++){
						//	if(!rows[j].getString(idxFSREFVAL[i]).equals("")){
						//	}
						//}
					
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
									String sql0 = " SELECT NVL(MAX(SSNBR),0)+1 FROM ACCOUNT.FSLIPMST "
														 + "	WHERE FDCODE ='"+strfdcode+"'" 
														 + "	  AND SSDAT='"+strssdat+"'"
														 + "    AND SSNBR<'500000'"; 
									ResultSet rs0 = stmt0.executeQuery(sql0); 
									if(rs0.next()){
										 strssnbr= rs0.getString(1);
									}
									rs0.close();

									int ichk = Integer.parseInt(strssnbr);
								 
									if(ichk<10) strssnbr = "00000"+strssnbr;
									else if(ichk>=10 && ichk<100)strssnbr = "0000"+strssnbr;
									else if(ichk>=100 && ichk<1000) strssnbr ="000"+strssnbr;
									else if(ichk>=1000 && ichk<10000)strssnbr = "00"+strssnbr;
									else if(ichk>=10000 && ichk<100000) strssnbr = "0"+strssnbr;
								}else{
									Statement stmt0 = conn.createStatement();
									String sql0 = " SELECT NVL(MAX(SSNBR),0)+1 FROM ACCOUNT.FSLIPMST "
														 + "	WHERE FDCODE ='"+strfdcode+"'" 
														 + "	  AND SSDAT='"+strssdat+"'"
														 + "    AND SSNBR>='500000'"; 
									ResultSet rs0 = stmt0.executeQuery(sql0); 
									if(rs0.next()){
										 strssnbr= rs0.getString(1);
									}
										rs0.close();

									int ichk = Integer.parseInt(strssnbr);

									if(ichk<10) strssnbr = "50000"+strssnbr;
									else if(ichk>=10 && ichk<100)strssnbr = "5000"+strssnbr;
									else if(ichk>=100 && ichk<1000) strssnbr ="500"+strssnbr;
									else if(ichk>=1000 && ichk<10000)strssnbr = "50"+strssnbr;
									else if(ichk>=10000 && ichk<100000) strssnbr = "5"+strssnbr;		
								}
							}
							///^^///^^logger.dbg.println(this, "strssnbr"+strssnbr);
						}
						rows[j].setString(idxSSDAT,strssdat);
						rows[j].setString(idxSSNBR,strssnbr);
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

						/////^^logger.dbg.println(this,"strFdcode::"+strFdcode+"::strFsdat::"+strFsdat+"::strFsnbr::"+strFsnbr);
						strErrorNo = rows[j].getString(idxFDCODE)+"-"+rows[j].getString(idxFSDAT)+"-"+rows[j].getString(idxFSNBR);

           
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//합계잔액(일자별)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//^^TEST ///^^logger.dbg.println(this,"step3");
						///^^logger.dbg.println(this, "합계잔액_일자별");
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


						//합계잔액(일자별)_수정건/////
						if(strGubun_2.equals("1")){ //존재함. update
							///^^logger.dbg.println(this, "합계잔액_일자별_수정");
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
							//%logger.dbg.println(this,"1");
							rows[j].setDouble(idxDAEAMT,dblcrtot);
							//%logger.dbg.println(this,"2");
							rows[j].setDouble(idxDECASH,dbldecash);
							//%logger.dbg.println(this,"3");
							rows[j].setDouble(idxCRCASH,dblcrcash);
							//%logger.dbg.println(this,"4");
							rows[j].setDouble(idxCHAUPAMT,dbldeuptot);
							//%logger.dbg.println(this,"5");
							rows[j].setDouble(idxDAEUPAMT,dblcruptot);
							//%logger.dbg.println(this,"6");
							rows[j].setDouble(idxDEUPCASH,dbldeupcash);
							//%logger.dbg.println(this,"7");
							rows[j].setDouble(idxCRUPCASH,dblcrupcash);
							//%logger.dbg.println(this,"8");
							rows[j].setDouble(idxDEUPCASH,dbledecash);
							//%logger.dbg.println(this,"9");
							rows[j].setDouble(idxCRUPCASH,dblecrcash);
							//%logger.dbg.println(this,"10");

							rows[j].setDouble(idxFODEAMT,dblfodetot);
							//%logger.dbg.println(this,"11");
							rows[j].setDouble(idxFOCRAMT,dblfocrtot);
							//%logger.dbg.println(this,"12");
							rows[j].setDouble(idxFODECASH,dblfodecash);
							//%logger.dbg.println(this,"13");
							rows[j].setDouble(idxFOCRCASH,dblfocrcash);
							//%logger.dbg.println(this,"14");
							rows[j].setDouble(idxFODEUPTOT,dblfodeuptot);
							//%logger.dbg.println(this,"15");
							rows[j].setDouble(idxFOCRUPTOT,dblfocruptot);
							//%logger.dbg.println(this,"16");
							rows[j].setDouble(idxFODEUPCASH,dblfodeupcash);
							//%logger.dbg.println(this,"17");
							rows[j].setDouble(idxFOCRUPCASH,dblfocrupcash);
							//%logger.dbg.println(this,"18");
							rows[j].setDouble(idxFOEDECASH,dblfoedecash);
							//%logger.dbg.println(this,"19");
							rows[j].setDouble(idxFOECRCASH,dblfoecrcash);
							//%logger.dbg.println(this,"20");

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


           

						//합계잔액(일자별)_신규건/////
						}else{                    //신규    insert

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
					  }//if
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//합계잔액(일자별) End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//합계잔액(월별)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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

						//&&logger.dbg.println(this,"월별 sql5" +sql5.toString() );
						stmt5 = conn.createStatement();
						rs5 = stmt5.executeQuery(sql5.toString());
          
						//^^TEST ///^^logger.dbg.println(this,"step10");
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

						//^^TEST  ///^^logger.dbg.println(this,"strGubun_5" +strGubun_5);
						//^^TEST ///^^logger.dbg.println(this,"dblcrcash5 -U" + dblcrcash5);

						//합계잔액(월별)_수정건/////
						//&&logger.dbg.println(this, "합계잔액_월별_수정");
						//&&logger.dbg.println(this, "합계잔액_월별_수정11111");
						if(strGubun_5.equals("1")){ //존재함. update
						   //&& logger.dbg.println(this, "합계잔액_월별_수정22222");
						   strGubun_5="";
						  //&&logger.dbg.println(this,"step10 -U");
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
							//%%logger.dbg.println(this,"1");
							rows[j].setDouble(idxDAEAMT,dblcrtot5);
							//%%logger.dbg.println(this,"2");
							rows[j].setDouble(idxDECASH,dbldecash5);
							//%%logger.dbg.println(this,"3");
							rows[j].setDouble(idxCRCASH,dblcrcash5);
							//%%logger.dbg.println(this,"4");
							rows[j].setDouble(idxCHAUPAMT,dbldeuptot5);
							//%%logger.dbg.println(this,"5");
							rows[j].setDouble(idxDAEUPAMT,dblcruptot5);
							//%%logger.dbg.println(this,"6");
							rows[j].setDouble(idxDEUPCASH,dbldeupcash5);
							//%%logger.dbg.println(this,"7");
							rows[j].setDouble(idxCRUPCASH,dblcrupcash5);
							//%%logger.dbg.println(this,"8");
							rows[j].setDouble(idxEDECASH,dbledecash5);
							//%%logger.dbg.println(this,"9");
							rows[j].setDouble(idxECRCASH,dblecrcash5);
							//%%logger.dbg.println(this,"10");

              //외화
							rows[j].setDouble(idxFODEAMT,dblfodetot5);
							//%%logger.dbg.println(this,"11");
							rows[j].setDouble(idxFOCRAMT,dblfocrtot5);
							//%%logger.dbg.println(this,"12");
							rows[j].setDouble(idxFODECASH,dblfodecash5);
							//%%logger.dbg.println(this,"13");
							rows[j].setDouble(idxFOCRCASH,dblfocrcash5);
							//%%logger.dbg.println(this,"14");
							rows[j].setDouble(idxFODEUPTOT,dblfodeuptot5);
							//%%logger.dbg.println(this,"15");
							rows[j].setDouble(idxFOCRUPTOT,dblfocruptot5);
							//%%logger.dbg.println(this,"16");
							rows[j].setDouble(idxFODEUPCASH,dblfodeupcash5);
							//%%logger.dbg.println(this,"17");
							rows[j].setDouble(idxFOCRUPCASH,dblfocrupcash5);
							//%%logger.dbg.println(this,"18");
							rows[j].setDouble(idxFOEDECASH,dblfoedecash5);
							//%%logger.dbg.println(this,"19");
							rows[j].setDouble(idxFOECRCASH,dblfoecrcash5);
							//%%logger.dbg.println(this,"20");

							gsmt5.setGauceDataRow(rows[j]);
						
							gsmt5.bindColumn(1,idxCHAAMT);
							//%%logger.dbg.println(this,"21");
							gsmt5.bindColumn(2,idxDAEAMT);
							gsmt5.bindColumn(3,idxDECASH);
							gsmt5.bindColumn(4,idxCRCASH);
							gsmt5.bindColumn(5,idxCHAUPAMT);
							gsmt5.bindColumn(6,idxDAEUPAMT);
							gsmt5.bindColumn(7,idxDEUPCASH);
							gsmt5.bindColumn(8,idxCRUPCASH);
							//%%logger.dbg.println(this,"22");
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
							//%%logger.dbg.println(this,"23");
							gsmt5.bindColumn(24,idxFDCODE);
							gsmt5.bindColumn(25,idxACTYYMM);
							gsmt5.bindColumn(26,idxATCODE);
							gsmt5.bindColumn(27,idxCOCODE);
							gsmt5.bindColumn(28,idxDIVCD);
							gsmt5.bindColumn(29,idxDEPTCD);
							//%%logger.dbg.println(this,"24");
							gsmt5.executeUpdate();
							gsmt5.close();

							//합계잔액(월별)_신규건/////
						}else{                    //신규    insert
						  //^^TEST  ///^^logger.dbg.println(this,"step14 -I");

							GauceStatement gsmt5 = conn.getGauceStatement(InsertSql_5.toString());
							gsmt5.setGauceDataRow(rows[j]);
						  
							///^^logger.dbg.println(this, "합계잔액_월별_신규22");
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

						 ///^^logger.dbg.println(this,"step14 -I end");
					  }//if

					//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					//합계잔액(월별) End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//전표Mst && 결재완료 Update>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					///^^logger.dbg.println(this,"전표결재완료");			
					if(!strfdcode.equals("")&&!strfsdat.equals("")&&!strfsnbr.equals("")){		
						  String  sql9_0 = " UPDATE  ACCOUNT.MFSLIPDTL SET "
								  					 + "    SSDAT = '"+strssdat+"',"
													 + "    SSNBR = '"+strssnbr+"'"
													 + "    WHERE  FDCODE = '"+strfdcode+"'"
													 + "      AND  FSDAT  = '"+strfsdat+"'"
													 + "      AND  FSNBR  = '"+strfsnbr+"'"
													 + "      AND  FSSEQ  = '"+rows[j].getString(idxFSSEQ)+"'";
													
							GauceStatement gsmt9_0 = conn.getGauceStatement(sql9_0);
							gsmt9_0.executeUpdate();
							gsmt9_0.close(); 


						 if(j==0){
							String  sql9 = " UPDATE  ACCOUNT.MFSLIPMST SET "
													 + "         FSSTAT = 'Y',"
													 + "         SGNDAT = '"+strsgndat+"',"
													 + "         ACTDAT = '"+stractdat+"',"
													 + "         SSDAT = '"+strssdat+"',"
													 + "         SSNBR = '"+strssnbr+"'"
													 + "  WHERE  FDCODE = '"+strfdcode+"'"
													 + "  AND  FSDAT  = '"+strfsdat+"'"
													 + "  AND  FSNBR  = '"+strfsnbr+"'";
													
							GauceStatement gsmt9 = conn.getGauceStatement(sql9);
							gsmt9.executeUpdate();
							gsmt9.close();


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
				}

				///^^logger.err.println(this,"errno::"+strErrorNo);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			///^^logger.err.println(this,e);
			///^^logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}