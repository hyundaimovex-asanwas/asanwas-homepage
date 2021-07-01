package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t6 extends HttpServlet{

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

			  long lngChkSum = 0; //한도 체크금액 
				long lngCCP41000=0; //결정소득세
				long lngCCP42000=0; //결정지방소득세
				long lngCCP43000=0; //결정농특세
				long lngCCP40000=0; //결정세액계

				long lngBA41000=0;  //차감징수소득세
				long lngBA42000=0;  //차감징수지방소득세
				long lngBA43000=0;  //차감징수농특세
				long lngBA40000=0;  //차감징수세액계

				long lngCBP41000=0;  //기납부소득세    
				long lngCBP42000=0;  //기납부지방소득세
				long lngCBP43000=0;  //기납부농특세    
				long lngCBP40000=0;  //기납부세액계    

        long[] lngBAAMT = new long[3];  //본인/배우자/부양가족공제
				long[] lngADAMT = new long[6];  //경로우대/장애인/부녀자/자녀양육비/출산입양자/다자녀추가공제

				long lngPENAMT01 =0;  //국민연금보험료
        long lngPENAMT03 =0;  //근로자퇴직연금

				long[] lngINSAMT = new long[4];  //건강보험료//고용보험료//보장성보험료/장애인전용보험료
				long lngMEDSUM =0;    //의료비
				long lngEDUSUM =0;    //교육비
				long lngHOUAMT01 =0;  //주택임차차입금
				long lngHOUAMT02 =0;  //월세액
				long lngHOUAMT03 =0;  //주택저당차입금
				long lngCONAMT =0;    //기부금
				long lngSPCSUM =0;    //특별공제계
				long lngSTDSUM =0;    //표준공제
				long lngOFFSUM =0;    //차감소득금액
				long[] lngPESAMT = new long[2];  //개인연금저축/연금저축
				long[] lngSAVAMT = new long[4];  //청약저축/근로자주택마련저축/주택청약종합저축/장기주택마련저축
				long lngCRDSUM =0;    //신용카드
				long lngFNDSUM =0;    //장기주식형 저축공제
				long lngETCSUM =0;    //그밖의소득공제계
				long lngTAXSTDAMT =0; //종합소득과세표준
				long lngTAXSUM =0;    //산출세액
				long lngDEDAMT01 =0;  //근로소득세액공제
				long lngDEDAMT02 =0;  //납세조합세액공제
				long lngDEDAMT03 =0;  //주택차입세액공제
				long lngDEDAMT04 =0;  //기부정치세액공제
				long lngDEDAMT05 =0;  //외국납부세액공제
				long lngDEDSUM =0;    //세액공제계

				long lngTempSum=0; 

				long lngChkamt01 =0;  //한도체크에서 기부금 한도 체크 전까지 근로소득금액 공제 잔액
  
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //귀속년도       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //귀속년도       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;
	       
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //초기화 
						lngChkSum = 0; //한도 체크금액 
						lngCCP41000=0;   //결정소득세
						lngCCP42000=0;   //결정지방소득세
						lngCCP43000=0;   //결정농특세
						lngCCP40000=0;   //결정세액계
            lngBA41000=0;    //차감징수소득세     
						lngBA42000=0;	   //차감징수지방소득세 
						lngBA43000=0;	   //차감징수농특세     
						lngBA40000=0;	   //차감징수세액계     
						lngCBP41000=0;   //기납부소득세     
						lngCBP42000=0;	 //기납부지방소득세 
						lngCBP43000=0;	 //기납부농특세     
						lngCBP40000=0;	 //기납부세액계     
						lngPENAMT01 =0;  //국민연금보험료
						lngPENAMT03 =0;  //근로자퇴직연금
						lngMEDSUM =0;    //의료비
						lngEDUSUM =0;    //교육비
						lngHOUAMT01 =0;  //주택임차차입금
						lngHOUAMT02 =0;  //월세액
						lngHOUAMT03 =0;  //주택저당차입금
						lngCONAMT =0;    //기부금
						lngSPCSUM =0;    //특별공제계
						lngSTDSUM =0;    //표준공제
						lngOFFSUM =0;    //차감소득금액
						lngCRDSUM =0;    //신용카드
						lngFNDSUM =0;    //장기주식형 저축공제
						lngETCSUM =0;    //그밖의소득공제계
						lngTAXSTDAMT =0; //종합소득과세표준
						lngTAXSUM =0;    //산출세액
						lngDEDAMT01 =0;  //근로소득세액공제 
						lngDEDAMT02 =0;  //납세조합세액공제 
						lngDEDAMT03 =0;  //주택차입세액공제 
						lngDEDAMT04 =0;  //기부정치세액공제 
						lngDEDAMT05 =0;  //외국납부세액공제 
						lngDEDSUM =0;    //세액공제계       


						lngTempSum=0;					

						for(int i=0;i<2;i++){
							lngINSAMT[i]=0;
							lngPESAMT[i]=0;
						}

						for(int i=0;i<3;i++){
							lngBAAMT[i]=0;
						}

						for(int i=0;i<4;i++){
							lngSAVAMT[i]=0;
						}

				    for(int i=0;i<6;i++){
							lngADAMT[i]=0;
						}

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT                                                                   \n" ); 
						SelectSql.append( " 		APPYY,      EMPNO,      EMPNMK,     MGENO,                           \n" ); 
						SelectSql.append( " 		CCP41000,   CCP42000,   CCP43000,   CCP40000,                        \n" ); 
						SelectSql.append( " 		BP41000,    BP42000,    BP43000,    BP40000,                         \n" ); 
            SelectSql.append( " 		BP51000,    BP52000,    BP53000,    BP50000,                         \n" ); 
						SelectSql.append( " 		BP61000,    BP62000,    BP63000,    BP60000,                         \n" ); 
						SelectSql.append( " 		CP41000,    CP42000,    CP43000,    CP40000,                         \n" ); 
						SelectSql.append( " 		BP41000+BP51000+BP61000+CP41000 AS CBP41000,                         \n" ); 
            SelectSql.append( " 		BP42000+BP52000+BP62000+CP42000 AS CBP42000,                         \n" ); 
						SelectSql.append( " 		BP43000+BP53000+BP63000+CP43000 AS CBP43000,                         \n" ); 
						SelectSql.append( " 		BP40000+BP50000+BP60000+CP40000 AS CBP40000,                         \n" ); 
						SelectSql.append( " 		BA41000,    BA42000,    BA43000,    BA40000,                         \n" ); 
						SelectSql.append( " 		TOTPAY,     DUDPAY,     LABPAY,                                      \n" ); 
						SelectSql.append( " 		BAAMT01,    BAAMT02,    BACNT03,    BAAMT03,                         \n" ); 
						SelectSql.append( " 		ADCNT01,    ADAMT01,    ADCNT02,    ADAMT02,    ADAMT03,             \n" ); 
						SelectSql.append( " 		ADCNT04,    ADAMT04,    ADCNT05,    ADAMT05,    ADCNT06,    ADAMT06, \n" );
						SelectSql.append( " 		PENAMT01,   PENAMT03,                                                \n" ); 
						SelectSql.append( " 		INSAMT01,   INSAMT02,   INSAMT03,   INSAMT04,                        \n" ); 
						SelectSql.append( " 		MEDSUM,     EDUSUM,     HOUAMT01,   HOUAMT02,   HOUAMT03,            \n" );
						SelectSql.append( " 		CONAMT,     SPCSUM,     STDSUM,     OFFSUM,                          \n" ); 
						SelectSql.append( " 		PESAMT01,   PESAMT02,   SMAAMT,                                      \n" ); 
						SelectSql.append( " 		SAVAMT01,   SAVAMT02,   SAVAMT03,   SAVAMT04,                        \n" ); 
						SelectSql.append( " 		INVSUM,     CRDSUM,     ASSSUM,     FNDSUM,     ETCSUM,              \n" ); 
						SelectSql.append( " 		TAXSTDAMT,  TAXSUM,     TREDAMT01,  TREDAMT02,  TREDSUM,             \n" ); 
            SelectSql.append( " 		DEDAMT01,   DEDAMT02,   DEDAMT03,   DEDAMT04,   DEDAMT05,   DEDSUM   \n" ); 
						SelectSql.append( "  FROM PAYROLL.YCPAY10                                                    \n" ); 
						SelectSql.append( "  WHERE APPYY='"+rows[j].getString(idxAPPYY)+"'	 \n" ); 
						SelectSql.append( "    AND EMPNO ='"+rows[j].getString(idxEMPNO)+"'	 \n" ); 
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  

							lngChkSum = rs.getLong("LABPAY");     //근로소득공제금액 체크
							lngBAAMT[0]= rs.getLong("BAAMT01"); 
							lngBAAMT[1]= rs.getLong("BAAMT02"); 
							lngBAAMT[2]= rs.getLong("BAAMT03"); 
              lngADAMT[0]= rs.getLong("ADAMT01");  
							lngADAMT[1]= rs.getLong("ADAMT02"); 
							lngADAMT[2]= rs.getLong("ADAMT03"); 
							lngADAMT[3]= rs.getLong("ADAMT04"); 
							lngADAMT[4]= rs.getLong("ADAMT05"); 
              lngADAMT[5]= rs.getLong("ADAMT06");  
							lngPENAMT01= rs.getLong("PENAMT01");  
							lngPENAMT03= rs.getLong("PENAMT03");
							lngINSAMT[0]= rs.getLong("INSAMT01");
							lngINSAMT[1]= rs.getLong("INSAMT02");
							lngINSAMT[2]= rs.getLong("INSAMT03");
							lngINSAMT[3]= rs.getLong("INSAMT04");
							lngMEDSUM=rs.getLong("MEDSUM");
							lngEDUSUM=rs.getLong("EDUSUM");
							lngHOUAMT01= rs.getLong("HOUAMT01");
							lngHOUAMT02= rs.getLong("HOUAMT02");
							lngHOUAMT03= rs.getLong("HOUAMT03");
							lngCONAMT = rs.getLong("CONAMT");
							lngSPCSUM = rs.getLong("SPCSUM");
							lngSTDSUM = rs.getLong("STDSUM");
							lngOFFSUM = rs.getLong("OFFSUM");
              lngPESAMT[0]= rs.getLong("PESAMT01");
							lngPESAMT[1]= rs.getLong("PESAMT02");
							lngSAVAMT[0]= rs.getLong("SAVAMT01");
							lngSAVAMT[1]= rs.getLong("SAVAMT02");
							lngSAVAMT[2]= rs.getLong("SAVAMT03");
							lngSAVAMT[3]= rs.getLong("SAVAMT04");
							lngCRDSUM=rs.getLong("CRDSUM");
							lngFNDSUM=rs.getLong("FNDSUM");
							lngETCSUM=rs.getLong("ETCSUM");
              lngTAXSTDAMT =rs.getLong("TAXSTDAMT");
							lngTAXSUM =rs.getLong("TAXSUM");
							lngDEDAMT01 =rs.getLong("DEDAMT01");
							lngDEDAMT02 =rs.getLong("DEDAMT02");
							lngDEDAMT03 =rs.getLong("DEDAMT03");
							lngDEDAMT04 =rs.getLong("DEDAMT04");
							lngDEDAMT05 =rs.getLong("DEDAMT05");
							lngDEDSUM =rs.getLong("DEDSUM");

							lngCBP41000=rs.getLong("CBP41000");  //기납부소득세    
							lngCBP42000=rs.getLong("CBP42000");  //기납부지방소득세
							lngCBP43000=rs.getLong("CBP43000");  //기납부농특세    
							lngCBP40000=rs.getLong("CBP40000");  //기납부세액계     
            																			
              //본인공제 
							if(lngChkSum>0){ 
								if(lngBAAMT[0]>0)lngChkSum -= lngBAAMT[0];
								if(lngChkSum<0){
									lngBAAMT[0] = lngBAAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngBAAMT[0]=0;
							}

							//배우자
							if(lngChkSum>0){
								if(lngBAAMT[1]>0)lngChkSum -= lngBAAMT[1];
								if(lngChkSum<0){
									lngBAAMT[1] = lngBAAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngBAAMT[1]=0; 
							}

							//부양가족
							if(lngChkSum>0){
								if(lngBAAMT[2] >0)lngChkSum -= lngBAAMT[2];
								if(lngChkSum<0){
									lngBAAMT[2] = lngBAAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
							  lngBAAMT[2]=0;
							}

							//경로우대
							if(lngChkSum>0){
								if(lngADAMT[0]>0) lngChkSum -= lngADAMT[0];
								if(lngChkSum<0){
									lngADAMT[0] = lngADAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[0] =0;
							}

							//장애인
							if(lngChkSum>0){
								if(lngADAMT[1]>0) lngChkSum -= lngADAMT[1];
								if(lngChkSum<0){
									lngADAMT[1] = lngADAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[1]=0;
							}

							//부녀자
							if(lngChkSum>0){
								if(lngADAMT[2]>0) lngChkSum -= lngADAMT[2];
								if(lngChkSum<0){
									lngADAMT[2] = lngADAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[2] =0;
							}

							//자녀양육
							if(lngChkSum>0){
								if(lngADAMT[3]>0) lngChkSum -=lngADAMT[3];
								if(lngChkSum<0){
									lngADAMT[3] = lngADAMT[3]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[3] =0;
							}

							//출산입양자
							if(lngChkSum>0){
								if(lngADAMT[4]>0) lngChkSum -=lngADAMT[4];
								if(lngChkSum<0){
									lngADAMT[4] = lngADAMT[4]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[4] = 0;
							}

							//다자녀추가공제
							if(lngChkSum>0){
								if(lngADAMT[5]>0) lngChkSum -= lngADAMT[5];
								if(lngChkSum<0){
									lngADAMT[5] = lngADAMT[5]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[5] =0;
							}

							//국민연금
							if(lngChkSum>0){
								if(lngPENAMT01>0) lngChkSum -= lngPENAMT01;
								if(lngChkSum<0){
									lngPENAMT01= lngPENAMT01+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngPENAMT01=0;
							}

							//퇴직연금
							if(lngChkSum>0){
								if(lngPENAMT03>0) lngChkSum -= lngPENAMT03;
								if(lngChkSum<0){
									lngPENAMT03 = lngPENAMT03+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngPENAMT03=0;
							}

              //차감소득금액엑 적용하기 위한 임시 합계 
              lngTempSum = rs.getLong("LABPAY") 
								         -(lngBAAMT[0]+lngBAAMT[1]+lngBAAMT[2]
								         + lngADAMT[0]+lngADAMT[1]+lngADAMT[2]+lngADAMT[3]+lngADAMT[4]+lngADAMT[5]
							           + lngPENAMT01+lngPENAMT03);	 
							//=============================================

							//건강보험
							if(lngChkSum>0){
								if(lngINSAMT[0]>0) lngChkSum -= lngINSAMT[0];
								if(lngChkSum<0){
									lngINSAMT[0] = lngINSAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[0] =0;
							}

							//고용보험
							if(lngChkSum>0){
								if(lngINSAMT[1]>0) lngChkSum -= lngINSAMT[1];
								if(lngChkSum<0){
									lngINSAMT[1] = lngINSAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[1] =0;
							}

							//보장성보험
							if(lngChkSum>0){
								if(lngINSAMT[2]>0) lngChkSum -= lngINSAMT[2];
								if(lngChkSum<0){
									lngINSAMT[2] = lngINSAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[2] = 0;
							}

							//장애인보험
							if(lngChkSum>0){
								if(lngINSAMT[3]>0) lngChkSum -= lngINSAMT[3];
								if(lngChkSum<0){
									lngINSAMT[3] = lngINSAMT[3]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[3] =0;
							}

							//의료비
							if(lngChkSum>0){
								if(lngMEDSUM>0) lngChkSum -= lngMEDSUM;
								if(lngChkSum<0){
									lngMEDSUM = lngMEDSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngMEDSUM =0;
							}

							//교육비
							if(lngChkSum>0){
								if(lngEDUSUM>0) lngChkSum -= lngEDUSUM;
								if(lngChkSum<0){
									lngEDUSUM = lngEDUSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngEDUSUM = 0;
							}

							//주택임차
							if(lngChkSum>0){
								if(lngHOUAMT01>0) lngChkSum -= lngHOUAMT01;
								if(lngChkSum<0){
									lngHOUAMT01 = lngHOUAMT01+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngHOUAMT01 = 0;
							}

							//월세액
							if(lngChkSum>0){
								if(lngHOUAMT02>0) lngChkSum -= lngHOUAMT02;
								if(lngChkSum<0){
									lngHOUAMT02 = lngHOUAMT02+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngHOUAMT02 = 0;
							}

							//장기주택저당
							if(lngChkSum>0){
								if(lngHOUAMT03>0) lngChkSum -= lngHOUAMT03;
								if(lngChkSum<0){
									lngHOUAMT03 = lngHOUAMT03+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngHOUAMT03 =0;
							}

              //한도체크에서 기부금 한도 체크 전까지 근로소득금액 공제 잔액
							lngChkamt01 = lngChkSum;

							//기부금
							if(lngChkSum>0){
								if(lngCONAMT>0) lngChkSum -=lngCONAMT;
								if(lngChkSum<0){
									lngCONAMT = lngCONAMT+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngCONAMT=0;
							}

              /////////////////////////////////////////////////////////////////////////////////
							//기부금 이월공제 적용
							//1.기부금이 존재하는지 체크 
							//2.로직상 근로소득금액이 남아 있는지 체크
							//  2.1 안 남아 있으면 전액 이월
							//  2.2 기부금액 만큼 남아 있으면 이월 안함.
							//  2.3 기부금액보다 적으면.....공제한도 다시 체크해야하나?(????????????????????)

							/////////////////////////////////////////////////////////////////////////////////
              

              //특별공제계
       				lngSPCSUM=lngINSAMT[0]+lngINSAMT[1]+lngINSAMT[2]+lngINSAMT[3]+lngMEDSUM
                       +lngEDUSUM+lngHOUAMT01+lngHOUAMT02+lngHOUAMT03+lngCONAMT;
							
							//표준공제 및 차감소득금액
							if(lngSPCSUM<1000000){
								//lngSPCSUM=0;  2011.02.20 특별공제계는 별도로함.
                lngSTDSUM=1000000;
								lngChkSum =lngTempSum-lngSTDSUM;
								if(lngChkSum<0){
									lngOFFSUM=0;  //차감소득금액
									lngChkSum=0;												
								}else{
									lngOFFSUM = lngChkSum;
								}
              }else{
								lngSTDSUM=0;
								lngOFFSUM =lngChkSum;
							}


						
							//개인연금저축
							if(lngChkSum>0){
								if(lngPESAMT[0]>0) lngChkSum -=lngPESAMT[0];
								if(lngChkSum<0){
									lngPESAMT[0] = lngPESAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngPESAMT[0] =0;
							}

							//연금저축
							if(lngChkSum>0){
               	//퇴직연금이 0이 아닌 경우 ( 연금저축 + 퇴직연금 합계 한도 300만원 ) 
								if(lngPENAMT03!=0){
									lngPESAMT[1] = 3000000-lngPENAMT03;
								}

								if(lngPESAMT[1]>0) lngChkSum -=lngPESAMT[1];
								if(lngChkSum<0){
									lngPESAMT[1] = lngPESAMT[1]+lngChkSum;
									lngChkSum=0;							
								}						
							}else{
								lngPESAMT[1] = 0;
							}

							//청약저축
							if(lngChkSum>0){
								if(lngSAVAMT[0]>0) lngChkSum -=lngSAVAMT[0];
								if(lngChkSum<0){
									lngSAVAMT[0] = lngSAVAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[0] =0;
							}

							//근로자주택마련저축
							if(lngChkSum>0){
								if(lngSAVAMT[1]>0) lngChkSum -=lngSAVAMT[1];
								if(lngChkSum<0){
									lngSAVAMT[1] = lngSAVAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[1] =0;
							}

							//주택청약종합저축
							if(lngChkSum>0){
								if(lngSAVAMT[2]>0) lngChkSum -=lngSAVAMT[2];
								if(lngChkSum<0){
									lngSAVAMT[2] = lngSAVAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[2] = 0;
							}

							//장기주택마련저축 
              if(lngChkSum>0){
								if(lngSAVAMT[3]>0) lngChkSum -=lngSAVAMT[3];
								if(lngChkSum<0){
									lngSAVAMT[3] = lngSAVAMT[3]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[3] =0;
							}

							//신용카드등
							if(lngChkSum>0){
								if(lngCRDSUM>0) lngChkSum -=lngCRDSUM;
								if(lngChkSum<0){
									lngCRDSUM = lngCRDSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngCRDSUM = 0;
							}

							//장기주식형소득공제
							if(lngChkSum>0){
								if(lngFNDSUM>0) lngChkSum -=lngFNDSUM;
								if(lngChkSum<0){
									lngFNDSUM = lngFNDSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngFNDSUM =0;
							}

							//그 밖의 소득공제
              lngETCSUM = lngPESAMT[0]+lngPESAMT[1]
                        + lngSAVAMT[0]+lngSAVAMT[1]+lngSAVAMT[2]+lngSAVAMT[3]
                        + lngCRDSUM+lngFNDSUM;

							//종합소득과세표준
							if(lngChkSum>0){
								lngTAXSTDAMT = lngChkSum;
							}

							//산출세액
							if(lngTAXSTDAMT<=0){
								lngTAXSUM =0;
							}else if (lngTAXSTDAMT>0&&lngTAXSTDAMT<=12000000){
								lngTAXSUM = lngTAXSTDAMT*6/100;
							}else if (lngTAXSTDAMT>12000000&&lngTAXSTDAMT<=46000000){
								lngTAXSUM = (lngTAXSTDAMT*15/100)-1080000;
							}else if (lngTAXSTDAMT>46000000&&lngTAXSTDAMT<=88000000){
								lngTAXSUM = (lngTAXSTDAMT*24/100)-5220000;
							}else if (lngTAXSTDAMT>88000000){
								lngTAXSUM = (lngTAXSTDAMT*35/100)-14900000;
							}

							//세액감면계 (없어서 패스)

              //////////////////////////////////////////////////////////
              //세액공제
              //////////////////////////////////////////////////////////
							//근로소득세액공제
							if(lngTAXSUM<=500000){
								lngDEDAMT01 = (long)(lngTAXSUM*55)/100;
							}else{
								lngDEDAMT01 = 275000+(long)(lngTAXSUM-500000)*3/10;
								if(lngDEDAMT01>500000){
									lngDEDAMT01=500000;
								}
							}

							//납세조합세액공제 패스 
							//미분양주택취득차입금 상환이자세액공제(없어서 패스).
							//기부정치자금
							if(lngDEDAMT04>100000){
								lngDEDAMT04=100000;
							}

							//외국납부세액공제(추후 수기 입력) 일단 패스 
              //권덕차장님 외국납부세액 
							if(rs.getString("EMPNO").equals("1990033")){
								lngDEDAMT05 = 1228430;
							}
			

							//세액공제계
              lngDEDSUM = lngDEDAMT01+lngDEDAMT02+lngDEDAMT03+lngDEDAMT04+lngDEDAMT05;

							//결정세액 ( 산출세액 - 세액감면 - 세액공제 )
              if(lngTAXSUM-lngDEDSUM<0){
								lngCCP41000=0;
							}else{
                lngCCP41000=(long)(lngTAXSUM-lngDEDSUM); //결정소득세   
							}

							lngCCP42000=lngCCP41000*1/10; //결정지방소득세
							lngCCP43000=0; //결정농특세    
							lngCCP40000=lngCCP41000+lngCCP42000; //결정세액계    

							if(lngCCP40000<0){
								lngCCP40000=0;
							}

							//차감징수금 = 결정세액 - 기납부세액
              lngBA41000 = lngCCP41000 - lngCBP41000;
              lngBA41000 = lngBA41000/10;
							lngBA41000 = lngBA41000*10;

              lngBA42000 = lngCCP42000 - lngCBP42000;
              lngBA42000 = lngBA42000/10;
							lngBA42000 = lngBA42000*10;
							//lngBA43000 = lngCCP43000 - lngCBP43000;
							//lngBA40000 = lngCCP40000 - lngCBP40000;
              lngBA40000 = lngBA41000 + lngBA42000;						

   						//logger.dbg.prlngln(this,"step2::"+lngChkSum);
         
						  /////////////////////////////////////////////////////////////////////////////////////////////
							//0 지급명세서 UPDATE 
						  /////////////////////////////////////////////////////////////////////////////////////////////
							
							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET \n");   
							UpdateSql.append( "  CCP41000 = "+lngCCP41000+" \n");  //결정소득세           
							UpdateSql.append( " ,CCP42000 = "+lngCCP42000+" \n");  //결정지방소득세       
							UpdateSql.append( " ,CCP43000 = "+lngCCP43000+" \n");  //결정농특세           
							UpdateSql.append( " ,CCP40000 = "+lngCCP40000+" \n");  //결정세액계           
              UpdateSql.append( " ,BA41000  = "+lngBA41000+"  \n");  //차감징수소득세       
							UpdateSql.append( " ,BA42000  = "+lngBA42000+"  \n");  //차감징수지방소득세   
							UpdateSql.append( " ,BA43000  = "+lngBA43000+"  \n");  //차감징수농특세       
							UpdateSql.append( " ,BA40000  = "+lngBA40000+"  \n");  //차감징수세액계       
							UpdateSql.append( " ,BAAMT01  = "+lngBAAMT[0]+" \n");  //본인       
							UpdateSql.append( " ,BAAMT02  = "+lngBAAMT[1]+" \n");  //배우자     
							UpdateSql.append( " ,BAAMT03  = "+lngBAAMT[2]+" \n");  //부양가족
							UpdateSql.append( " ,ADAMT01  = "+lngADAMT[0]+" \n");  //경로
							UpdateSql.append( " ,ADAMT02  = "+lngADAMT[1]+" \n");  //장애
							UpdateSql.append( " ,ADAMT03  = "+lngADAMT[2]+" \n");  //부녀자
							UpdateSql.append( " ,ADAMT04  = "+lngADAMT[3]+" \n");  //자녀양육
							UpdateSql.append( " ,ADAMT05  = "+lngADAMT[4]+" \n");  //출산입양
							UpdateSql.append( " ,ADAMT06  = "+lngADAMT[5]+" \n");  //다자녀
							UpdateSql.append( " ,PENAMT01 = "+lngPENAMT01+" \n");  //국민연금
							UpdateSql.append( " ,PENAMT03 = "+lngPENAMT03+" \n");  //퇴직연금
							UpdateSql.append( " ,INSAMT01 = "+lngINSAMT[0]+"\n");  //건강보험
							UpdateSql.append( " ,INSAMT02 = "+lngINSAMT[1]+"\n");  //고용보험
							UpdateSql.append( " ,INSAMT03 = "+lngINSAMT[2]+"\n");  //보장성보험
							UpdateSql.append( " ,INSAMT04 = "+lngINSAMT[3]+"\n");  //장애인보험
							UpdateSql.append( " ,MEDSUM   = "+lngMEDSUM+"   \n");  //의료
							UpdateSql.append( " ,EDUSUM   = "+lngEDUSUM+"   \n");  //교육
							UpdateSql.append( " ,HOUAMT01 = "+lngHOUAMT01+" \n");  //주택임차차입금
							UpdateSql.append( " ,HOUAMT02 = "+lngHOUAMT02+" \n");  //월세액
							UpdateSql.append( " ,HOUAMT03 = "+lngHOUAMT03+" \n");  //주택저당차입금
							UpdateSql.append( " ,CONAMT   = "+lngCONAMT+"   \n");  //기부금
							UpdateSql.append( " ,SPCSUM   = "+lngSPCSUM+"   \n");  //특별공제
							UpdateSql.append( " ,STDSUM   = "+lngSTDSUM+"   \n");  //표준공제
							UpdateSql.append( " ,OFFSUM   = "+lngOFFSUM+"   \n");  //차감소득금액
							UpdateSql.append( " ,PESAMT01 = "+lngPESAMT[0]+"\n");  //개인연금
							UpdateSql.append( " ,PESAMT02 = "+lngPESAMT[1]+"\n");  //연금저축
							UpdateSql.append( " ,SAVAMT01 = "+lngSAVAMT[0]+"\n");  //청약저축
							UpdateSql.append( " ,SAVAMT02 = "+lngSAVAMT[1]+"\n");  //근로자주택마련저축
							UpdateSql.append( " ,SAVAMT03 = "+lngSAVAMT[2]+"\n");  //주택청약조합저축
							UpdateSql.append( " ,SAVAMT04 = "+lngSAVAMT[3]+"\n");  //장기주택마련저축
							UpdateSql.append( " ,CRDSUM   = "+lngCRDSUM+"   \n");  //신용카드
							UpdateSql.append( " ,FNDSUM   = "+lngFNDSUM+"   \n");  //펀드
							UpdateSql.append( " ,ETCSUM   = "+lngETCSUM+"   \n");  //그밖의소득공제계
							UpdateSql.append( " ,TAXSTDAMT= "+lngTAXSTDAMT+"\n");  //종합소득과세표준
							UpdateSql.append( " ,TAXSUM   = "+lngTAXSUM +"  \n");  //산출세액
							UpdateSql.append( " ,DEDAMT01 = "+lngDEDAMT01+" \n");  //근로소득세액공제
							UpdateSql.append( " ,DEDAMT02 = "+lngDEDAMT02+" \n");  //납세조합세액공제
							UpdateSql.append( " ,DEDAMT03 = "+lngDEDAMT03+" \n");  //주택차입세액공제
							UpdateSql.append( " ,DEDAMT04 = "+lngDEDAMT04+" \n");  //기부정치세액공제
							UpdateSql.append( " ,DEDAMT05 = "+lngDEDAMT05+" \n");  //외국납부세액공제
							UpdateSql.append( " ,DEDSUM   = "+lngDEDSUM+"   \n");  //세액공제계
							UpdateSql.append( " ,CHKAMT01 = "+lngChkamt01+" \n");  //한도체크에서 기부금 한도 체크 전까지 근로소득금액 공제 잔액
							//비과세 전체 
							UpdateSql.append( " ,NTAXSUM01 = CNTAX01+BNTAX101+BNTAX201+BNTAX301 \n");  //01
							UpdateSql.append( " ,NTAXSUM02 = CNTAX02+BNTAX102+BNTAX202+BNTAX302 \n");  //02
							UpdateSql.append( " ,NTAXSUM03 = CNTAX03+BNTAX103+BNTAX203+BNTAX303 \n");  //03
							UpdateSql.append( " ,NTAXSUM04 = CNTAX04+BNTAX104+BNTAX204+BNTAX304 \n");  //04
							UpdateSql.append( " ,NTAXSUM05 = CNTAX05+BNTAX105+BNTAX205+BNTAX305 \n");  //05
							UpdateSql.append( " ,NTAXSUM = CNTAXSUM+BNTAX1SUM+BNTAX2SUM+BNTAX3SUM \n");  //비과세 전체 합계
							UpdateSql.append( "   WHERE APPYY =  '"+rows[j].getString(idxAPPYY)+"' " );
							UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
							logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();

							logger.dbg.println(this,"step16");
												
 					  }//while			
						stmt.close();
						rs.close();

				 } //getJobType
			}  //for j 
     			
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
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