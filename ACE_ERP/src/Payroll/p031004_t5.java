package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t5 extends HttpServlet{

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

				long lngPENAMT03=0; //현퇴직연금+전퇴직연금

				long[] lngINSAMT = new long[2];  //보장성보험료/장애인전용보험료
				long[] lngMEDAMT = new long[2];  //본인65세장애인/그외
				
				long lngEDUAMT01 =0;              //본인
				long[] lngEDUAMT02 = new long[6];  //취학전
				long[] lngEDUAMT03 = new long[6];  //초중고
				long[] lngEDUAMT04 = new long[6];  //대학
				long[] lngEDUAMT05 = new long[6];  //장애인 교육비
				long lngEDUSUM=0;
				long lngSAVSUM1234=0; //저축관련합계 
				long[] lngHOUAMT = new long[5];  //주택임차차입금/월세액/장기주택차입14/장기주택차입15/장기주택차입30
				long[] lngCONAMT = new long[7];  //정치자금세액공제외/법정/특례/공인법인신탁/우리사주/종교외/종교
				long[] lngPESAMT = new long[2];  //개인연금저축/연금저축
				long[] lngSAVAMT = new long[4];  //청약저축/근로자주택마련저축/주택청약종합저축/장기주택마련저축
				long[] lngCRDAMT = new long[4];  //신용카드/직불카드/현금영수증/학원지로비납부
				long[] lngFNDAMT = new long[3];  //장기주식저축 1년/2년/3년차

				long lngConChk=0;   //기부금체크 
        long lngConChk2=0;  //기부금체크 
				long lngCONAMT67=0; //종교단체+종교단체외
				long lngCONSUM =0;

        long lngCRDAMT1234 =0; //카드전체금액 
				long lngCRDAMT134 =0;  //직불카드이외금액		              
				long lngCrdChk =0;     //카드체크
				long lngCRDSUM =0;     //카드공제금액
				long lngFNDSUM =0;     //장기주식형 저축공제
				long lngMEDSUM =0;     //의료비
				long lngHOUSUM =0;     //주택저당차입금합

				long lngTOTPAY =0;    //지급합계
				double dblCardCal=0;    //카드 소숫점 이하 계산

				//기부금공제한도
				long lngCONLMT10 =0;    //법정기부금공제한도
				long lngCONLMT30 =0;    //특례기부금공제한도
				long lngCONLMT31 =0;    //공익기부금공제한도
				long lngCONLMT40 =0;    //종교외기부금공제한도
				long lngCONLMT41 =0;    //종교기부금공제한도


  
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
						lngPENAMT03=0;
						lngEDUAMT01=0;
						lngEDUSUM=0;
						lngSAVSUM1234=0;  //저축관련합계 
            lngConChk=0;      //기부금체크               
           	lngConChk2=0;     //기부금체크              
						lngCONAMT67=0;    //종교단체+종교단체외     
						lngCONSUM =0;     //기부금합계                       
						lngCRDAMT1234 =0; //카드전체금액         
						lngCRDAMT134 =0;  //직불카드이외금액		 
						lngCrdChk =0;     //카드체크             
						lngCRDSUM =0;     //카드공제금액         
						lngFNDSUM =0;     //장기주식형 저축공제  
						lngMEDSUM =0;     //의료비               
						lngHOUSUM =0;     //주택저당차입금합     
						lngTOTPAY =0;     //지급합계
				    dblCardCal=0;     //카드 소숫점 이하 계산

						lngCONLMT10 =0;    //법정기부금공제한도
						lngCONLMT30 =0;    //특례기부금공제한도
						lngCONLMT31 =0;    //공익기부금공제한도
						lngCONLMT40 =0;    //종교외기부금공제한도
						lngCONLMT41 =0;    //종교기부금공제한도

						for(int i=0;i<2;i++){
							lngINSAMT[i]=0;
							lngMEDAMT[i]=0;
							lngPESAMT[i]=0;
						}

						for(int i=0;i<3;i++){
							lngFNDAMT[i]=0;
						}

						for(int i=0;i<4;i++){
							lngSAVAMT[i]=0;
							lngCRDAMT[i]=0;
						}

						for(int i=0;i<5;i++){
							lngHOUAMT[i]=0;
						}

            //[0]은 인원수 이다.
						for(int i=0;i<6;i++){
							lngEDUAMT02[i]=0;
							lngEDUAMT03[i]=0;
							lngEDUAMT04[i]=0;
							lngEDUAMT05[i]=0;
							
						}

						for(int i=0;i<7;i++){
							lngCONAMT[i]=0;
						}
         
						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT A.APPYY,    A.EMPNO,   B.TOTPAY, B.LABPAY,                                          \n" ); 
						SelectSql.append( "        A.INSAMT03, A.INSAMT04,                                                             \n" ); 
						SelectSql.append( "        A.MEDAMT01, A.MEDAMT02,                                                             \n" ); 
						SelectSql.append( "        A.EDUAMT01,                                                                         \n" ); 
            SelectSql.append( "        A.EDUCNT02, A.EDUAMT021, A.EDUAMT022, A.EDUAMT023, A.EDUAMT024, A.EDUAMT025,        \n" ); 
						SelectSql.append( "        A.EDUCNT03, A.EDUAMT031, A.EDUAMT032, A.EDUAMT033, A.EDUAMT034, A.EDUAMT035,        \n" ); 
						SelectSql.append( "        A.EDUCNT04, A.EDUAMT041, A.EDUAMT042, A.EDUAMT043, A.EDUAMT044, A.EDUAMT045,        \n" ); 
						SelectSql.append( "        A.EDUCNT05, A.EDUAMT051, A.EDUAMT052, A.EDUAMT053, A.EDUAMT054, A.EDUAMT055,        \n" ); 
						SelectSql.append( "        A.HOUAMT01, A.HOUAMT02, A.HOUAMT03, A.HOUAMT04, A.HOUAMT05,                         \n" ); 
						SelectSql.append( "        A.CONAMT01, A.CONAMT02, A.CONAMT03, A.CONAMT04, A.CONAMT05, A.CONAMT06, A.CONAMT07, \n" ); 
						SelectSql.append( "        ---------------------------------------------------------------------               \n" ); 
						SelectSql.append( "        (A.PESAMT01+A.YERAMT) AS PESAMT01,  (A.PESAMT02+A.JUCAMT)AS PESAMT02, A.CPENAMT03, A.BPENAMT03, \n" );
						SelectSql.append( "        A.SAVAMT01, A.SAVAMT02, A.SAVAMT03, A.SAVAMT04,                                     \n" ); 
						SelectSql.append( "        A.CRDAMT01, A.CRDAMT02, A.CRDAMT03, A.CRDAMT04,                                     \n" ); 
						SelectSql.append( "        A.FNDAMT01, A.FNDAMT02, A.FNDAMT03                                                  \n" );
						//SelectSql.append( "   FROM PAYROLL.YCENTRY10_2 A, PAYROLL.YCPAY10 B                                            \n" ); 
						SelectSql.append( "   FROM PAYROLL.YCENTRY10 A, PAYROLL.YCPAY10 B                                              \n" ); 
						SelectSql.append( "  WHERE A.APPYY='"+rows[j].getString(idxAPPYY)+"'														             	   \n" ); 
						SelectSql.append( "    AND A.EMPNO ='"+rows[j].getString(idxEMPNO)+"'															               \n" ); 
            SelectSql.append( "    AND A.APPYY = B.APPYY														               \n" ); 
						SelectSql.append( "    AND A.EMPNO = B.EMPNO														               \n" ); 
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  

							//logger.dbg.println(this,"step1");


               //퇴직연금
              lngPENAMT03 = rs.getLong("CPENAMT03")+rs.getLong("BPENAMT03");
							if(lngPENAMT03>3000000) lngPENAMT03=3000000;

              //보장성보험 
							if(rs.getInt("INSAMT03")>=1000000){
								lngINSAMT[0]=1000000;
							}else{
                lngINSAMT[0]=rs.getInt("INSAMT03");
							}

							//장애인전용보험
              if(rs.getInt("INSAMT04")>=1000000){
								lngINSAMT[1]=1000000;
							}else{
                lngINSAMT[1]=rs.getInt("INSAMT04");
							}

							//의료비 ==> 총급여액이 필요함.
							lngMEDAMT[0] = rs.getLong("MEDAMT01");                             //본인65세장애인
              lngMEDAMT[1] = rs.getLong("MEDAMT02")- rs.getLong("TOTPAY")*3/100;  //그외 추가공제
              if(lngMEDAMT[1]>=7000000){
                lngMEDAMT[1]=7000000;
							}
              lngMEDSUM=lngMEDAMT[0]+lngMEDAMT[1];
							if(lngMEDSUM<0){
								lngMEDSUM=0;
							}

						
							//교육비//////////////////////////////////////////////////////////////////
							lngEDUAMT01=rs.getLong("EDUAMT01"); //본인(전액)
              lngEDUAMT02[1]=rs.getLong("EDUAMT021"); //취학전(300만)
							lngEDUAMT02[2]=rs.getLong("EDUAMT022"); //취학전(300만)
							lngEDUAMT02[3]=rs.getLong("EDUAMT023"); //취학전(300만)
							lngEDUAMT02[4]=rs.getLong("EDUAMT024"); //취학전(300만)
							lngEDUAMT02[5]=rs.getLong("EDUAMT025"); //취학전(300만)
							lngEDUAMT03[1]=rs.getLong("EDUAMT031"); //초중고(300만))
							lngEDUAMT03[2]=rs.getLong("EDUAMT032"); //초중고(300만))
							lngEDUAMT03[3]=rs.getLong("EDUAMT033"); //초중고(300만))
							lngEDUAMT03[4]=rs.getLong("EDUAMT034"); //초중고(300만))
							lngEDUAMT03[5]=rs.getLong("EDUAMT035"); //초중고(300만))
							lngEDUAMT04[1]=rs.getLong("EDUAMT041"); //대학(900만)
							lngEDUAMT04[2]=rs.getLong("EDUAMT042"); //대학(900만)
							lngEDUAMT04[3]=rs.getLong("EDUAMT043"); //대학(900만)
							lngEDUAMT04[4]=rs.getLong("EDUAMT044"); //대학(900만)
							lngEDUAMT04[5]=rs.getLong("EDUAMT045"); //대학(900만)
							lngEDUAMT05[1]=rs.getLong("EDUAMT051"); //장애(전액)
							lngEDUAMT05[2]=rs.getLong("EDUAMT052"); //장애(전액)
							lngEDUAMT05[3]=rs.getLong("EDUAMT053"); //장애(전액)
							lngEDUAMT05[4]=rs.getLong("EDUAMT054"); //장애(전액)
							lngEDUAMT05[5]=rs.getLong("EDUAMT055"); //장애(전액)
							
							if(rs.getLong("EDUAMT021")>3000000) lngEDUAMT02[1]=3000000; //취학전(300만)
							if(rs.getLong("EDUAMT022")>3000000) lngEDUAMT02[2]=3000000; //취학전(300만)
							if(rs.getLong("EDUAMT023")>3000000) lngEDUAMT02[3]=3000000; //취학전(300만)
							if(rs.getLong("EDUAMT024")>3000000) lngEDUAMT02[4]=3000000; //취학전(300만)
							if(rs.getLong("EDUAMT025")>3000000) lngEDUAMT02[5]=3000000; //취학전(300만)

							if(rs.getLong("EDUAMT031")>3000000) lngEDUAMT03[1]=3000000; //초중고(300만) 
							if(rs.getLong("EDUAMT032")>3000000) lngEDUAMT03[2]=3000000; //초중고(300만) 
							if(rs.getLong("EDUAMT033")>3000000) lngEDUAMT03[3]=3000000; //초중고(300만) 
							if(rs.getLong("EDUAMT034")>3000000) lngEDUAMT03[4]=3000000; //초중고(300만) 
							if(rs.getLong("EDUAMT035")>3000000) lngEDUAMT03[5]=3000000; //초중고(300만) 

							if(rs.getLong("EDUAMT041")>9000000) lngEDUAMT04[1]=9000000; //대학(900만) 
							if(rs.getLong("EDUAMT042")>9000000) lngEDUAMT04[2]=9000000; //대학(900만) 
							if(rs.getLong("EDUAMT043")>9000000) lngEDUAMT04[3]=9000000; //대학(900만) 
							if(rs.getLong("EDUAMT044")>9000000) lngEDUAMT04[4]=9000000; //대학(900만) 
							if(rs.getLong("EDUAMT045")>9000000) lngEDUAMT04[5]=9000000; //대학(900만) 

							lngEDUSUM=lngEDUAMT01;

              for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT02[i];
							}

							for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT03[i];
							}

							for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT04[i];
							}

							for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT05[i];
							}
							

							//logger.dbg.println(this,"step2");


             /////////////////////////////////////////////////////////////////////////

              //주택마련저축(1)
							//청약저축
							//주택청약종합저축
							//장기주택마련저축

							//주택임차차입금(2)
							//주택임차금 40%
              //월세액     40%

							//장기주택저당차입금(3)
							//(1)+(2)       한도 300만원
							//(3)의         한도 600 / 1000 / 1500
							//(1)+(2)+(3)의 한도 600 / 1000 / 1500

							//연소득이 8800만원이하만 가능

             
         			//주택마련저축 한도300만원///////////////////////////////////////////////
              lngSAVAMT[0] =rs.getLong("SAVAMT01")*4/10 ; //청약저축                100
							lngSAVAMT[1] =rs.getLong("SAVAMT02")*4/10 ; //근로자주택마련저축      70 
							lngSAVAMT[2] =rs.getLong("SAVAMT03")*4/10 ; //주택청약종합저축        50
							lngSAVAMT[3] =rs.getLong("SAVAMT04")*4/10 ; //장기주택마련저축        200

              //장기주택마련저축:총급여 8천8백이하만 적용
							if(rs.getLong("TOTPAY")>88000000){
								lngSAVAMT[3]=0;
							}

							//logger.dbg.println(this,"step3");
              
							lngSAVSUM1234 = lngSAVAMT[0]+lngSAVAMT[1]+lngSAVAMT[2]+lngSAVAMT[3]; //

              //합이 300만원 이상인 경우 잔액 계산 
              if(lngSAVSUM1234>3000000){
								lngSAVSUM1234=3000000;	
							}

							if(lngSAVAMT[0]>3000000){
								lngSAVAMT[0]=3000000;
                lngSAVAMT[1]=0;
								lngSAVAMT[2]=0;
								lngSAVAMT[3]=0;
							}else if((lngSAVAMT[0]+lngSAVAMT[1])>3000000){
								lngSAVAMT[1]=lngSAVSUM1234-lngSAVAMT[0];
								lngSAVAMT[2]=0;
								lngSAVAMT[3]=0;
							}else if((lngSAVAMT[0]+lngSAVAMT[1]+lngSAVAMT[2])>3000000){
								lngSAVAMT[2]=lngSAVSUM1234-lngSAVAMT[0]-lngSAVAMT[1];
								lngSAVAMT[3]=0;
							}else{
								lngSAVAMT[3]=lngSAVSUM1234-lngSAVAMT[0]-lngSAVAMT[1]-lngSAVAMT[2];
							}
               ///////////////////////////////////////////////////////////////////////           			            
              
              //주택임차차입금관련
              lngHOUAMT[0] = rs.getLong("HOUAMT01")*4/10; //주택임차차입금
              lngHOUAMT[1] = rs.getLong("HOUAMT02")*4/10; //월세액

							//logger.dbg.println(this,"step4");
							
							//합이 300만원 이상인 경우 잔액 계산 
							//주택임차차입금
              if(lngHOUAMT[0]>0){
								lngHOUAMT[0] = lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[0]>3000000){
									lngHOUAMT[0]=3000000;
								}
								lngHOUAMT[0] = lngHOUAMT[0]-lngSAVSUM1234;
							}
     
              //월세액
              if(lngHOUAMT[1]>0){
								lngHOUAMT[1] = lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[1]>3000000){
									lngHOUAMT[1]=3000000;
								}
								lngHOUAMT[1] = lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							} 

							//주택저당차입금 600&1000&1500만원이 동시에 없다는 가정하에서 만듬.

      				//주택저당차입금 600만원
              lngHOUAMT[2] = rs.getLong("HOUAMT03");

							if(lngHOUAMT[2]>0){
								lngHOUAMT[2]=lngHOUAMT[2]+lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[2]>6000000){
									lngHOUAMT[2]=6000000;
								}
								lngHOUAMT[2]=lngHOUAMT[2]-lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							}
               
              //주택저당차입금 1000만원
              lngHOUAMT[3] = rs.getLong("HOUAMT04");
              
							if(lngHOUAMT[3]>0){
								lngHOUAMT[3]=lngHOUAMT[3]+lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[3]>10000000){
									lngHOUAMT[3]=10000000;  
								}
								lngHOUAMT[3]=lngHOUAMT[3]-lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							}

							//주택저당차입금 1500만원
              lngHOUAMT[4] = rs.getLong("HOUAMT05");
              if(lngHOUAMT[4]>0){
								lngHOUAMT[4]=lngHOUAMT[4]+lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[4]>15000000){
									lngHOUAMT[4]=15000000;  
								}
								lngHOUAMT[4]=lngHOUAMT[4]-lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							}	

							lngHOUSUM = lngHOUAMT[2] + lngHOUAMT[3] + lngHOUAMT[4];

              //기부금공제//////////////////////////////////////////////////////////////////              
							lngCONAMT[0] = rs.getLong("CONAMT01");  //정치       100
							lngCONAMT[1] = rs.getLong("CONAMT02");  //법정       100  
							lngCONAMT[2] = rs.getLong("CONAMT03");  //특례        50
							lngCONAMT[3] = rs.getLong("CONAMT04");  //공익        50
							lngCONAMT[4] = rs.getLong("CONAMT05");  //우리사주    30
							lngCONAMT[5] = rs.getLong("CONAMT06");  //종교단체외  20
							lngCONAMT[6] = rs.getLong("CONAMT07");  //종교단체    10

							lngConChk = rs.getLong("LABPAY");        //근로소득금액

							//logger.dbg.println(this,"step5");
					    
							//정치
							if(lngCONAMT[0]>lngConChk){
								lngCONAMT[0] = lngConChk;
							}

              //법정
							lngConChk = rs.getLong("LABPAY")-lngCONAMT[0];
							lngCONLMT10 = lngConChk;
              if(lngCONAMT[1]>lngConChk){
								lngCONAMT[1] = lngConChk;
							}

              //특례
							lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1])*5/10;
              lngCONLMT30=lngConChk;
							if(lngCONAMT[2]>lngConChk){
								lngCONAMT[2] = lngConChk;
							}
              //logger.dbg.println(this,"step55");
              //공익 
							lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2])*5/10;
              lngCONLMT31=lngConChk;
							if(lngCONAMT[3]>lngConChk){
								lngCONAMT[3] = lngConChk;
							}

							//우리사주
							lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3])*3/10;
							if(lngCONAMT[4]>lngConChk){
								lngCONAMT[4] = lngConChk;
							}

							//logger.dbg.println(this,"step555");

							//종교단체가 있는 경우 
							if(lngCONAMT[6]>0){
								lngConChk  = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3]-lngCONAMT[4])*1/10;
								lngConChk2 = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3]-lngCONAMT[4])*1/10;

								if(lngCONAMT[5]>lngConChk2){
										lngConChk = lngConChk+lngConChk2;
								}else{
										lngConChk = lngConChk+lngCONAMT[5];
								}
								

                
								if(lngCONAMT[5]>0){ //종교외 단체가 있는 경우   (종교 & 종교외 둘다 있음)       
                  lngCONLMT40 = 0;
									lngCONLMT41 = lngConChk;								
								}else{              //종교외 단체가 없는 경우   (종교단체만 있음)  
								  lngCONLMT40 = 0;
                  lngCONLMT41 = lngConChk;
								}
							}

							//logger.dbg.println(this,"step5555");

							//종교단체가 없는 경우 
							if(lngCONAMT[6]==0){
								lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3]-lngCONAMT[4])*2/10;							
								lngCONLMT40 =lngConChk;
								lngCONLMT41 =0;
							}

							lngCONAMT67 = lngCONAMT[5]+lngCONAMT[6];

							if(lngCONAMT67>lngConChk){
								lngCONAMT67=lngConChk;
							}

							lngCONSUM = lngCONAMT[0]+lngCONAMT[1]+lngCONAMT[2]+lngCONAMT[3]+lngCONAMT[4]+lngCONAMT67;
              							
              //logger.dbg.println(this,"step55555");
							//개인연금저축 소득공제 
							lngPESAMT[0] = rs.getLong("PESAMT01")*4/10;


							if(lngPESAMT[0]>720000){
								lngPESAMT[0]=720000;
							}
									
							//연금저축소득공제 ( 연금저축+퇴직연금<=300만원)
              //회사연금저축도 추가해야함....2011.02.01.JYS
							//PAYROLL.YCENTRY10에  HPESAMT02 에 일괄적용해야함.

							lngPESAMT[1]=rs.getLong("PESAMT02")+rs.getLong("CPENAMT03")+rs.getLong("BPENAMT03");
							if(lngPESAMT[1]>3000000){
								lngPESAMT[1]=3000000;
							}

							//logger.dbg.println(this,"step555555");

							//신용카드등 소득공제
							lngCRDAMT[0]=rs.getLong("CRDAMT01"); //신용카드
							lngCRDAMT[1]=rs.getLong("CRDAMT02"); //직불카드
							lngCRDAMT[2]=rs.getLong("CRDAMT03"); //현금영수증
							lngCRDAMT[3]=rs.getLong("CRDAMT04"); //학원지로비납부

							//산출금액 (ㄱ) 신용카드+현금영수증+학원지로비납부
							//산출금액 (ㄴ) 직불카드

							//신용카드 사용금액 
							lngCRDAMT1234 = lngCRDAMT[0]+lngCRDAMT[1]+lngCRDAMT[2]+lngCRDAMT[3];
							lngCRDAMT134  = lngCRDAMT[0]+lngCRDAMT[2]+lngCRDAMT[3];
              lngTOTPAY = rs.getLong("TOTPAY");

//							logger.dbg.prlngln(this,"lngCRDAMT1234:::"+lngCRDAMT1234);
//							logger.dbg.prlngln(this,"lngCRDAMT134:::"+lngCRDAMT134);
//							logger.dbg.prlngln(this,"lngTOTPAY:::"+lngTOTPAY);


              //lngTOTPAY =(lngTOTPAY*25);
//						  logger.dbg.prlngln(this,"11lngTOTPAY:::"+lngTOTPAY);
							
							//lngTOTPAY = lngTOTPAY/100;

							if(lngCRDAMT1234>0){
								lngTOTPAY = (lngTOTPAY*25)/100; //총급여의 25%

								//logger.dbg.println(this,"22lngTOTPAY:::"+lngTOTPAY);
								lngCrdChk =(lngCRDAMT1234-lngTOTPAY);


								//logger.dbg.println(this,"lngCRDAMT1234:::"+lngCRDAMT1234);
								//logger.dbg.println(this,"lngCrdChk:::"+lngCrdChk);

								//logger.dbg.println(this,"lngCRDAMT134:::"+lngCRDAMT134);
								//logger.dbg.println(this,"lngCRDAMT[1]:::"+lngCRDAMT[1]);

								dblCardCal =(double)((lngCRDAMT134*0.2+lngCRDAMT[1]*0.25)/lngCRDAMT1234);

								//logger.dbg.println(this,"dblCardCal:::"+dblCardCal);



								if(lngCrdChk<=0){
									lngCrdChk=0;
								}else{
									 lngCrdChk= (long)(lngCrdChk*dblCardCal);								       
								}

								//logger.dbg.println(this,"step6");
							 
								if(lngCrdChk>(rs.getLong("TOTPAY")*20)/100){
									lngCrdChk=(rs.getLong("TOTPAY")*20)/100;
								}

								//logger.dbg.println(this,"step7::"+lngCrdChk);

								//logger.dbg.println(this,"xxxx:::"+(rs.getLong("TOTPAY")*20)/100);

								if(lngCrdChk>3000000){
									lngCRDSUM=3000000;
								}else{
									lngCRDSUM=lngCrdChk;
								}
							}

							//장기주식형저축 소득공제
							lngFNDAMT[0]=rs.getLong("FNDAMT01");
							lngFNDAMT[1]=rs.getLong("FNDAMT02");
							lngFNDAMT[2]=rs.getLong("FNDAMT03");
							
							if(lngFNDAMT[0]>0) lngFNDAMT[0] =lngFNDAMT[0]*20/100;
							if(lngFNDAMT[1]>0) lngFNDAMT[1] =lngFNDAMT[1]*10/100;
							if(lngFNDAMT[2]>0) lngFNDAMT[2] =lngFNDAMT[2]*5/100;


							//logger.dbg.println(this,"step8");

							lngFNDSUM=lngFNDAMT[0]+lngFNDAMT[1]+lngFNDAMT[2]; 

						  /////////////////////////////////////////////////////////////////////////////////////////////
							//0 지급명세서 UPDATE 
						  /////////////////////////////////////////////////////////////////////////////////////////////
							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET  \n");   						
							UpdateSql.append( "  PENAMT03 = "+lngPENAMT03+" \n");   // 현퇴직연금+전퇴직연금 넣음.
							UpdateSql.append( " ,INSAMT03 = "+lngINSAMT[0]+" \n");  //보장성보험료
							UpdateSql.append( " ,INSAMT04 = "+lngINSAMT[1]+" \n");  //장애인보험료 
							UpdateSql.append( " ,MEDSUM   = "+lngMEDSUM+"    \n");  //의료비
							UpdateSql.append( " ,EDUSUM   = "+lngEDUSUM+"    \n");  //교육비
							UpdateSql.append( " ,HOUAMT01 = "+lngHOUAMT[0]+" \n");  //주택임차차입금
							UpdateSql.append( " ,HOUAMT02 = "+lngHOUAMT[1]+" \n");  //월세액
							UpdateSql.append( " ,HOUAMT03 = "+lngHOUSUM+"    \n");  //주택저당차입금
							UpdateSql.append( " ,CONAMT   = "+lngCONSUM+"    \n");  //기부금
							UpdateSql.append( " ,PESAMT01 = "+lngPESAMT[0]+" \n");  //개인연금저축
							UpdateSql.append( " ,PESAMT02 = "+lngPESAMT[1]+" \n");  //연금저축
							UpdateSql.append( " ,SAVAMT01 = "+lngSAVAMT[0]+" \n");  //청약저축
							UpdateSql.append( " ,SAVAMT02 = "+lngSAVAMT[1]+" \n");  //근로자주택마련저축
							UpdateSql.append( " ,SAVAMT03 = "+lngSAVAMT[2]+" \n");  //주택청약종합저축
							UpdateSql.append( " ,SAVAMT04 = "+lngSAVAMT[3]+" \n");  //장기주택마련저축
							UpdateSql.append( " ,CRDSUM   = "+lngCRDSUM+"    \n");  //신용카드등
							UpdateSql.append( " ,FNDSUM   = "+lngFNDSUM+"    \n");  //장기주식형저축
							UpdateSql.append( " ,CONLMT10 = "+lngCONLMT10+"  \n");  //
							UpdateSql.append( " ,CONLMT30 = "+lngCONLMT30+"  \n");  //
							UpdateSql.append( " ,CONLMT31 = "+lngCONLMT31+"  \n");  //
							UpdateSql.append( " ,CONLMT40 = "+lngCONLMT40+"  \n");  //
							UpdateSql.append( " ,CONLMT41 = "+lngCONLMT41+"  \n");  //
							//비과세합계 
              UpdateSql.append( " ,BNTAX1SUM = BNTAX101+BNTAX102+BNTAX103+BNTAX104+BNTAX105  \n");  //
							UpdateSql.append( " ,BNTAX2SUM = BNTAX201+BNTAX202+BNTAX203+BNTAX204+BNTAX205  \n");  //
              UpdateSql.append( " ,BNTAX3SUM = BNTAX301+BNTAX302+BNTAX303+BNTAX304+BNTAX305  \n");  //

							UpdateSql.append( "   WHERE APPYY =  '"+rows[j].getString(idxAPPYY)+"' " );
							UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
							//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();

							//logger.dbg.println(this,"step16");
												
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