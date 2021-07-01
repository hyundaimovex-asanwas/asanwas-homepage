package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class comm_upatcode_t3 extends HttpServlet{
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

      ///////////////////////////////////////////////
			//수정 분개 집계 테이블의 상위계정 합 구하기
      ///////////////////////////////////////////////

			int strlevel = 0;
			String strGubun_1 ="0";
			String strGubun_2 ="0";
      
			//합계잔액
			String [] str = new String [6];
			
			//원화
			double [] dbl = new double [10];
			double [] dbl2 = new double [10];
			double [] dbl_sum = new double [10];
	     		
			//외화
			double [] dbl_fo = new double [10];
			double [] dbl2_fo = new double [10];
			double [] dbl_sum_fo = new double [10];

			//관리항목집계
			String [] str3 = new String [8];
			double [] dbl3 = new double [4];
			double [] dbl4 = new double [4];
			double [] dbl_sum3 = new double [4];

			//외화
			double [] dbl3_fo = new double [4];
			double [] dbl4_fo = new double [4];
			double [] dbl_sum3_fo = new double [4];

			String strAtgrp="";
			String strAtupcode="";
			String gstrAtupcode=""; //상위계정
			int icnt=0;


			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

        /************************************************************************************
         @ 일별합계잔액 / 일별관리항목집계 / 월별합계잔액 / 월별관리항목집계
         //현금등가물의 경우 상위 집계 제외 됨.==>상위 필드 없음.
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String strYYMM = reqGauce.getParameter("v_str1");   //기준년월
				String strFDCODE = reqGauce.getParameter("v_str2"); //지점
				String strEMPNO  = reqGauce.getParameter("v_str3"); //사번

				if(strFDCODE.equals("A")){
					strFDCODE ="01','02','03','04";
				}

        //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				//상위 집계 계정 Clear 및 상위집계 데이타 생성 (Start)
        //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
        //1.일집계 해당월의 상위 데이타 삭제 
				String  sql001 = " DELETE FROM ACCOUNT.MDTOTAL A "
							   + "  WHERE SUBSTR(A.ACTDAT,1,6)='"+strYYMM+"' "
						  	   + "    AND EXISTS ( SELECT B.ATCODE FROM ACCOUNT.ACTCODE B"
						  	   + " 			            WHERE A.ATCODE = B.ATCODE "
					  		   + "   		              AND SUBSTR(A.ACTDAT,1,6)='"+strYYMM+"'"
							   + "   		              AND B.ATUSEYN <>'Y'	)	" 
							   + "    AND A.FDCODE IN ('"+strFDCODE+"')" ;
								
				GauceStatement gsmt001 = conn.getGauceStatement(sql001);
				gsmt001.executeUpdate();
				gsmt001.close();



				//2.일집계 해당월의 상위 집계 할 데이타 update  
				String  sql002 = " UPDATE ACCOUNT.MDTOTAL SET DEUPTOT = DETOT , CRUPTOT =CRTOT,FODEUPTOT = FODETOT , FOCRUPTOT =FOCRTOT "
							   + "  WHERE SUBSTR(ACTDAT,1,6)='"+strYYMM+"'"
						  	   + "    AND FDCODE IN ('"+strFDCODE+"')";
											 //+ "    AND STATUS='Y' ;
							
				GauceStatement gsmt002 = conn.getGauceStatement(sql002);
				gsmt002.executeUpdate();
				gsmt002.close();

				//3.월집계 해당월의 상위 데이타 삭제  
				String  sql003 = " DELETE FROM ACCOUNT.MDMTOTAL A "
							   + "  WHERE A.ACTYYMM='"+strYYMM+"' "
							   + "    AND EXISTS ( SELECT B.ATCODE FROM ACCOUNT.ACTCODE B"
							   + " 			        WHERE A.ATCODE = B.ATCODE "
						  	   + "   		          AND A.ACTYYMM='"+strYYMM+"'"
							   + "   		          AND B.ATUSEYN <>'Y'	)	" 
							   + "    AND A.FDCODE IN ('"+strFDCODE+"')" ;
										
				GauceStatement gsmt003 = conn.getGauceStatement(sql003);
				gsmt003.executeUpdate();
				gsmt003.close();

				//4.월집계 해당월의 상위 집계 할 데이타 update  
				String  sql004 = " UPDATE ACCOUNT.MDMTOTAL SET DEUPTOT = DETOT , CRUPTOT =CRTOT,FODEUPTOT = FODETOT , FOCRUPTOT =FOCRTOT "
						  	   + "  WHERE ACTYYMM ='"+strYYMM+"'"
							   + "    AND FDCODE IN ('"+strFDCODE+"')" ;
										
				GauceStatement gsmt004 = conn.getGauceStatement(sql004);
				gsmt004.executeUpdate();
				gsmt004.close();

				//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				//상위 집계 계정 Clear 및 상위집계 데이타 생성 (End)
                //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 

				
        
					//변수 초기화
					for (int s=0;s<=5;s++) {
							str[s] = "";
					}

					for (int s=0;s<=9;s++) {
							dbl[s] = 0;
							dbl2[s] = 0;
							dbl_sum[s] = 0;
							
							dbl_fo[s] = 0;
							dbl2_fo[s] = 0;
							dbl_sum_fo[s] = 0;
					}

					for (int s=0;s<=7;s++) {
						str3[s] = "";
					}

					for (int s=0;s<=3;s++) {
							dbl3[s] = 0;
							dbl4[s] = 0;
							dbl_sum3[s] = 0;

							dbl3_fo[s] = 0;
							dbl4_fo[s] = 0;
							dbl_sum3_fo[s] = 0;
					}

					/************************************************************************************
					 @ 합계잔액(일별)
					*************************************************************************************/
					///logger.dbg.println(this,"일별합계잔액");
					StringBuffer sql_d = new StringBuffer();
					Statement stmt_d = null;
					ResultSet rs_d = null;

					///logger.dbg.println(this,"합계잔액");
					//기존금액 저장
					sql_d.append( " SELECT A.FDCODE,  A.ACTDAT, B.ATUPCODE, A.COCODE, A.DIVCD,  ");
					sql_d.append( "        A.DEPTCD,                                       ");
					sql_d.append( "        SUM(A.DETOT)    AS DETOT,                        ");
					sql_d.append( "        SUM(A.CRTOT)    AS CRTOT,                        ");
					sql_d.append( "        SUM(A.DECASH)   AS DECASH,                       ");
					sql_d.append( "        SUM(A.CRCASH)   AS CRCASH,                       ");
					sql_d.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                      ");
					sql_d.append( "        SUM(A.CRUPTOT)  AS CRUPTOT,                      ");
					sql_d.append( "        SUM(A.DEUPCASH) AS DEUPCASH,                     ");
					sql_d.append( "        SUM(A.CRUPCASH) AS CRUPCASH,                     ");
					sql_d.append( "        SUM(A.EDECASH)  AS EDECASH,                      ");
					sql_d.append( "        SUM(A.ECRCASH)  AS ECRCASH,                      ");

					sql_d.append( "        SUM(A.FODETOT)    AS FODETOT,                    ");
					sql_d.append( "        SUM(A.FOCRTOT)    AS FOCRTOT,                    ");
					sql_d.append( "        SUM(A.FODECASH)   AS FODECASH,                   ");
					sql_d.append( "        SUM(A.FOCRCASH)   AS FOCRCASH,                   ");
					sql_d.append( "        SUM(A.FODEUPTOT)  AS FODEUPTOT,                  ");
					sql_d.append( "        SUM(A.FOCRUPTOT)  AS FOCRUPTOT,                  ");
					sql_d.append( "        SUM(A.FODEUPCASH) AS FODEUPCASH,                 ");
					sql_d.append( "        SUM(A.FOCRUPCASH) AS FOCRUPCASH,                 ");
					sql_d.append( "        SUM(A.FOEDECASH)  AS FOEDECASH,                  ");
					sql_d.append( "        SUM(A.FOECRCASH)  AS FOECRCASH                   ");
					sql_d.append( "   FROM ACCOUNT.MDTOTAL A,ACCOUNT.ACTCODE B             ");
					sql_d.append( "  WHERE A.ATCODE = B.ATCODE                              ");
					sql_d.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0                  ");
					sql_d.append( "     OR A.DEUPCASH <> 0 OR A.CRUPCASH <> 0)                ");
					sql_d.append( "    AND B.ATUSEYN ='Y'                         ");
					sql_d.append( "    AND SUBSTR(A.ACTDAT,1,6)='"+strYYMM+"'                         ");
					sql_d.append( "    AND A.FDCODE IN ('"+strFDCODE+"') ");
					//추가 
					//sql_d.append( "    AND A.STATUS ='Y'                         ");
					sql_d.append( "  GROUP BY A.FDCODE, A.ACTDAT, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD");
					stmt_d = conn.createStatement();
					rs_d = stmt_d.executeQuery(sql_d.toString());

          
					//stmt = createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
					//CONCUR_READ_ONLY

					strAtgrp="";
					strAtupcode="";

					while(rs_d.next())	{		//
						//loop돌기
						str[0]=rs_d.getString(1);  //FDCODE
						str[1]=rs_d.getString(2);  //ACTDAT
						str[2]=rs_d.getString(3);  //ATUPCODE  ==> 상위계정
						str[3]=rs_d.getString(4);  //COCODE
						str[4]=rs_d.getString(5);  //DIVCD
						str[5]=rs_d.getString(6);  //DEPTCD

						dbl[0]=rs_d.getDouble(7);
						dbl[1]=rs_d.getDouble(8);
						dbl[2]=rs_d.getDouble(9);
						dbl[3]=rs_d.getDouble(10);
						dbl[4]=rs_d.getDouble(11);
						dbl[5]=rs_d.getDouble(12);
						dbl[6]=rs_d.getDouble(13);
						dbl[7]=rs_d.getDouble(14);
						dbl[8]=rs_d.getDouble(15);
						dbl[9]=rs_d.getDouble(16);

						dbl_fo[0]=rs_d.getDouble(17);
						dbl_fo[1]=rs_d.getDouble(18);
						dbl_fo[2]=rs_d.getDouble(19);
						dbl_fo[3]=rs_d.getDouble(20);
						dbl_fo[4]=rs_d.getDouble(21);
						dbl_fo[5]=rs_d.getDouble(22);
						dbl_fo[6]=rs_d.getDouble(23);
						dbl_fo[7]=rs_d.getDouble(24);
						dbl_fo[8]=rs_d.getDouble(25);
						dbl_fo[9]=rs_d.getDouble(26);

						gstrAtupcode = str[2];
						if(dbl[4]+dbl[5]+dbl[6]+dbl[7]!=0){   //상위계정의 값이 0이 아닌 경우
							//icnt+=1;
							//logger.dbg.println(this,"icnt::"+icnt);
							_out1:
							for(int k=1;k<=5;k++){
								StringBuffer sql_u1 = new StringBuffer();
								Statement stmt_u1 = null;
								ResultSet rs_u1 = null;
								//icnt+=1;
								
								sql_u1.append( " SELECT A.DETOT,  A.CRTOT,  A.DECASH,  A.CRCASH,  A.DEUPTOT,  A.CRUPTOT,  A.DEUPCASH,  A.CRUPCASH,  A.EDECASH,  A.ECRCASH, ");
								sql_u1.append( "        A.FODETOT,A.FOCRTOT,A.FODECASH,A.FOCRCASH,A.FODEUPTOT,A.FOCRUPTOT,A.FODEUPCASH,A.FOCRUPCASH,A.FOEDECASH,A.FOECRCASH, ");
								sql_u1.append( "        NVL(B.ATGRP,'')ATGRP,B.ATUPCODE "); 
								sql_u1.append( "   FROM ACCOUNT.MDTOTAL A ,ACCOUNT.ACTCODE B ");
                                sql_u1.append( "  WHERE A.ATCODE = B.ATCODE  ");
								sql_u1.append( "    AND A.FDCODE ='"+str[0]+"'  ");
								sql_u1.append( "    AND A.ACTDAT ='"+str[1]+"'  ");
								sql_u1.append( "    AND A.ATCODE ='"+gstrAtupcode+"'  ");
								sql_u1.append( "    AND A.COCODE ='"+str[3]+"'  ");
								sql_u1.append( "    AND A.DIVCD  ='"+str[4]+"'  ");
								sql_u1.append( "    AND A.DEPTCD ='"+str[5]+"'  ");
                
								stmt_u1 = conn.createStatement();
								rs_u1 = stmt_u1.executeQuery(sql_u1.toString());

								strAtgrp="";
								strAtupcode="";

								strGubun_1="0";
								while(rs_u1.next())	{
									//logger.dbg.println(this,"DATA 존재함.....");
									strGubun_1="1";
									//원화
									dbl2[0]=rs_u1.getDouble(1);
									dbl2[1]=rs_u1.getDouble(2);
									dbl2[2]=rs_u1.getDouble(3);
									dbl2[3]=rs_u1.getDouble(4);
									dbl2[4]=rs_u1.getDouble(5);
									dbl2[5]=rs_u1.getDouble(6);
									dbl2[6]=rs_u1.getDouble(7);
									dbl2[7]=rs_u1.getDouble(8);
									dbl2[8]=rs_u1.getDouble(9);
									dbl2[9]=rs_u1.getDouble(10);
									
									//외화
									dbl2_fo[0]=rs_u1.getDouble(11);
									dbl2_fo[1]=rs_u1.getDouble(12);
									dbl2_fo[2]=rs_u1.getDouble(13);
									dbl2_fo[3]=rs_u1.getDouble(14);
									dbl2_fo[4]=rs_u1.getDouble(15);
									dbl2_fo[5]=rs_u1.getDouble(16);
									dbl2_fo[6]=rs_u1.getDouble(17);
									dbl2_fo[7]=rs_u1.getDouble(18);
									dbl2_fo[8]=rs_u1.getDouble(19);
									dbl2_fo[9]=rs_u1.getDouble(20);

									strAtgrp=rs_u1.getString(21);
									strAtupcode=rs_u1.getString(22);

									//기존금액 Sum
									//원화
									dbl_sum[0] = dbl[4] + dbl2[0];     
									dbl_sum[1] = dbl[5] + dbl2[1];
									dbl_sum[2] = dbl[6] + dbl2[2];
									dbl_sum[3] = dbl[7] + dbl2[3];

									dbl_sum[4] = dbl[4];
									dbl_sum[5] = dbl[5];
									dbl_sum[6] = dbl[6];
									dbl_sum[7] = dbl[7];

									//외화
									dbl_sum_fo[0] = dbl_fo[4] + dbl2_fo[0];     
									dbl_sum_fo[1] = dbl_fo[5] + dbl2_fo[1];
									dbl_sum_fo[2] = dbl_fo[6] + dbl2_fo[2];
									dbl_sum_fo[3] = dbl_fo[7] + dbl2_fo[3];

									dbl_sum_fo[4] = dbl_fo[4];
									dbl_sum_fo[5] = dbl_fo[5];
									dbl_sum_fo[6] = dbl_fo[6];
									dbl_sum_fo[7] = dbl_fo[7];

									//logger.dbg.println(this,"합계잔액5");

									//Update
									StringBuffer UpdateSql_u1 = null;
									UpdateSql_u1 = new StringBuffer();
									UpdateSql_u1.append( " UPDATE ACCOUNT.MDTOTAL SET " );
									UpdateSql_u1.append( "        DETOT = "+dbl_sum[0]+"," );
									UpdateSql_u1.append( "        CRTOT = "+dbl_sum[1]+"," );
									UpdateSql_u1.append( "        DECASH ="+dbl_sum[2]+"," );
									UpdateSql_u1.append( "        CRCASH= "+dbl_sum[3]+"," );
									UpdateSql_u1.append( "        DEUPTOT = "+dbl_sum[4]+"," );
									UpdateSql_u1.append( "        CRUPTOT = "+dbl_sum[5]+"," );
									UpdateSql_u1.append( "        DEUPCASH ="+dbl_sum[6]+"," );
									UpdateSql_u1.append( "        CRUPCASH= "+dbl_sum[7]+"," );
									
									UpdateSql_u1.append( "        FODETOT = "+dbl_sum_fo[0]+"," );
									UpdateSql_u1.append( "        FOCRTOT = "+dbl_sum_fo[1]+"," );
									UpdateSql_u1.append( "        FODECASH ="+dbl_sum_fo[2]+"," );
									UpdateSql_u1.append( "        FOCRCASH= "+dbl_sum_fo[3]+"," );
									UpdateSql_u1.append( "        FODEUPTOT = "+dbl_sum_fo[4]+"," );
									UpdateSql_u1.append( "        FOCRUPTOT = "+dbl_sum_fo[5]+"," );
									UpdateSql_u1.append( "        FODEUPCASH ="+dbl_sum_fo[6]+"," );
									UpdateSql_u1.append( "        FOCRUPCASH= "+dbl_sum_fo[7]+"," );
									UpdateSql_u1.append( "        STATUS= 'Y' ");

									UpdateSql_u1.append( "  WHERE FDCODE='"+str[0]+"'" );
									UpdateSql_u1.append( "    AND ACTDAT='"+str[1]+"'" );
									UpdateSql_u1.append( "    AND ATCODE='"+gstrAtupcode+"'" );
									UpdateSql_u1.append( "    AND COCODE='"+str[3]+"'" );
									UpdateSql_u1.append( "    AND DIVCD='"+str[4]+"'" );
									UpdateSql_u1.append( "    AND DEPTCD='"+str[5]+"'" );

									GauceStatement gsmt_u1 = conn.getGauceStatement(UpdateSql_u1.toString());
									gsmt_u1.executeUpdate();
									gsmt_u1.close();	
								}//while rs_u1

								//logger.dbg.println(this,"strGubun_1::"+strGubun_1);
								if(strGubun_1.equals("0")){  //Insert 
								  ///logger.dbg.println(this,"DATA 존재안함.....");
									StringBuffer sql_u11 = new StringBuffer();
									Statement stmt_u11 = null;
									ResultSet rs_u11 = null;

									sql_u11.append( " SELECT NVL(B.ATGRP,'')ATGRP,B.ATUPCODE "); 
									sql_u11.append( "   FROM ACCOUNT.ACTCODE B ");
									sql_u11.append( "  WHERE B.ATCODE ='"+gstrAtupcode+"'  ");

									stmt_u11 = conn.createStatement();
									rs_u11 = stmt_u11.executeQuery(sql_u11.toString());

									strAtgrp="";
									strAtupcode="";

									while(rs_u11.next())	{
										strAtgrp=rs_u11.getString(1);
										strAtupcode=rs_u11.getString(2);
									}

									rs_u11.close();
                
									StringBuffer InsertSql_u1 = null;
									InsertSql_u1 = new StringBuffer();
									InsertSql_u1.append( " INSERT INTO ACCOUNT.MDTOTAL (" );
									InsertSql_u1.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD," );
									InsertSql_u1.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH," );
									InsertSql_u1.append( " DEUPTOT, CRUPTOT, DEUPCASH,  CRUPCASH,  " );
									InsertSql_u1.append( " FODETOT,   FOCRTOT,   FODECASH,   FOCRCASH,  " );
									InsertSql_u1.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH,STATUS  " );
									InsertSql_u1.append( "  ) " );
									InsertSql_u1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+gstrAtupcode+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
									InsertSql_u1.append( " "+dbl[0]+","+dbl[1]+","+dbl[2]+","+dbl[3]+","+dbl[4]+","+dbl[5]+","+dbl[6]+","+dbl[7]+"," ); 
									InsertSql_u1.append( " "+dbl_fo[0]+","+dbl_fo[1]+","+dbl_fo[2]+","+dbl_fo[3]+"," );
									InsertSql_u1.append( " "+dbl_fo[4]+","+dbl_fo[5]+","+dbl_fo[6]+","+dbl_fo[7]+",'Y')" ); 

									GauceStatement gsmt_u1 = conn.getGauceStatement(InsertSql_u1.toString());
									gsmt_u1.executeUpdate();
									gsmt_u1.close();	
								}//if rs_u1
								rs_u1.close(); 

								///logger.dbg.println(this,"strAtgrp::"+strAtgrp);
								if(!strAtgrp.equals("1")&&!strAtgrp.equals("")){
									gstrAtupcode = strAtupcode;
								}else{
									//logger.dbg.println(this,"strAtgrp_null::"+strAtgrp); 
									break _out1;
								}
							}//for k						
						} //dbl[4]+dbl[5]+dbl[6]+dbl[7]!	
					}//while rs_d
					rs_d.close();
 
				/************************************************************************************
				 @ 관리항목집계(일별)
				*************************************************************************************/

				/*  
					logger.dbg.println(this,"일별관리항목");

				  StringBuffer sql_u2 = new StringBuffer();
					Statement stmt_u2 = null;
					ResultSet rs_u2 = null;
					logger.dbg.println(this,"관리항목집계1");
					sql_u2.append( " SELECT A.FDCODE,  A.ACTDAT, B.ATUPCODE, A.COCODE, A.DIVCD, ");
					sql_u2.append( "        A.DEPTCD,  A.FSREFCD, A.FSREFVAL,                   ");
					sql_u2.append( "        SUM(A.DETOT)    AS DETOT,                           ");
					sql_u2.append( "        SUM(A.CRTOT)    AS CRTOT,                           ");
					sql_u2.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                         ");
					sql_u2.append( "        SUM(A.CRUPTOT)  AS CRUPTOT,                         ");
					sql_u2.append( "        SUM(A.FODETOT)    AS FODETOT,                           ");
					sql_u2.append( "        SUM(A.FOCRTOT)    AS FOCRTOT,                           ");
					sql_u2.append( "        SUM(A.FODEUPTOT)  AS FODEUPTOT,                         ");
					sql_u2.append( "        SUM(A.FOCRUPTOT)  AS FOCRUPTOT                         ");
					sql_u2.append( "   FROM ACCOUNT.FSREFTOT A,ACCOUNT.ACTCODE B                ");
					sql_u2.append( "  WHERE A.ATCODE = B.ATCODE                                 ");
					sql_u2.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0)                  ");
					sql_u2.append( "    AND B.ATUSEYN ='Y'                         ");
					sql_u2.append( "    AND SUBSTR(A.ACTDAT,1,6)='"+strYYMM+"'                         ");
					sql_u2.append( "  GROUP BY A.FDCODE, A.ACTDAT, B.ATUPCODE, A.COCODE,A.DIVCD,");
					sql_u2.append( "           A.DEPTCD,A.FSREFCD, A.FSREFVAL                   ");
			
					stmt_u2 = conn.createStatement();
					rs_u2 = stmt_u2.executeQuery(sql_u2.toString());
		
					while(rs_u2.next())	{		
  
						str3[0]=rs_u2.getString(1);  //FDCODE
						str3[1]=rs_u2.getString(2);  //ACTDAT
						str3[2]=rs_u2.getString(3);  //ATUPCODE
						str3[3]=rs_u2.getString(4);  //COCODE
						str3[4]=rs_u2.getString(5);  //DIVCD
						str3[5]=rs_u2.getString(6);  //DEPTCD
						str3[6]=rs_u2.getString(7);  //FSREFCD
						str3[7]=rs_u2.getString(8);  //FSREFVAL

						dbl3[0]=rs_u2.getDouble(9);
						dbl3[1]=rs_u2.getDouble(10);
						dbl3[2]=rs_u2.getDouble(11);
						dbl3[3]=rs_u2.getDouble(12);

						dbl3_fo[0]=rs_u2.getDouble(13);
						dbl3_fo[1]=rs_u2.getDouble(14);
						dbl3_fo[2]=rs_u2.getDouble(15);
						dbl3_fo[3]=rs_u2.getDouble(16);

						gstrAtupcode = str3[2];

						//logger.dbg.println(this,"관리항목집계3");

            icnt=0;
						if(dbl3[2]+dbl3[3]!=0){
							
							for(int k2=1;k2<=5;k2++){
								StringBuffer sql_u3 = new StringBuffer();
								Statement stmt_u3 = null;
								ResultSet rs_u3 = null;
                
                //icnt+=1;
								//logger.dbg.println(this,"2icnt:::"+icnt);
								///logger.dbg.println(this,"관리항목집계4");
								sql_u3.append( " SELECT A.DETOT,   A.CRTOT,   A.DEUPTOT,   A.CRUPTOT,  ");
								sql_u3.append( "        A.FODETOT, A.FOCRTOT, A.FODEUPTOT, A.FOCRUPTOT, ");
								sql_u3.append( "        IFNULL(B.ATGRP,'')ATGRP, B.ATUPCODE  ");
								sql_u3.append( "   FROM ACCOUNT.FSREFTOT A, ACCOUNT.ACTCODE B     	");
								sql_u3.append( "  WHERE A.ATCODE = B.ATCODE  ");
								sql_u3.append( "    AND A.FDCODE ='"+str3[0]+"'  ");
								sql_u3.append( "    AND A.ACTDAT ='"+str3[1]+"'  ");
								sql_u3.append( "    AND A.ATCODE ='"+gstrAtupcode+"'  ");
								sql_u3.append( "    AND A.COCODE ='"+str3[3]+"'  ");
								sql_u3.append( "    AND A.DIVCD  ='"+str3[4]+"'  ");
								sql_u3.append( "    AND A.DEPTCD ='"+str3[5]+"'  ");
								sql_u3.append( "    AND A.FSREFCD  ='"+str3[6]+"'  ");
								sql_u3.append( "    AND A.FSREFVAL ='"+str3[7]+"'  ");

								///logger.dbg.println(this,"sql_u3" + sql_u3.toString());
								
								stmt_u3 = conn.createStatement();
								rs_u3 = stmt_u3.executeQuery(sql_u3.toString());
								
								strGubun_2="0";

								strAtgrp="";
								strAtupcode="";

								while(rs_u3.next())	{
									logger.dbg.println(this,"관리항목집계5");
									strGubun_2="1";
									dbl4[0]=rs_u3.getDouble(1);
									dbl4[1]=rs_u3.getDouble(2);
									dbl4[2]=rs_u3.getDouble(3);
									dbl4[3]=rs_u3.getDouble(4);

									dbl4_fo[0]=rs_u3.getDouble(5);
									dbl4_fo[1]=rs_u3.getDouble(6);
									dbl4_fo[2]=rs_u3.getDouble(7);
									dbl4_fo[3]=rs_u3.getDouble(8);

									strAtgrp=rs_u3.getString(9);
									strAtupcode=rs_u3.getString(10);
									
									//기존금액 Sum
									//원화
									dbl_sum3[0] = dbl4[0]+ dbl3[2]; 
									dbl_sum3[1] = dbl4[1]+ dbl3[3];
									dbl_sum3[2] = dbl3[2];
									dbl_sum3[3] = dbl3[3];

									//외화
									dbl_sum3_fo[0] = dbl4_fo[0]+ dbl3_fo[2]; 
									dbl_sum3_fo[1] = dbl4_fo[1]+ dbl3_fo[3];
									dbl_sum3_fo[2] = dbl3_fo[2];
									dbl_sum3_fo[3] = dbl3_fo[3];

									//Update
									StringBuffer UpdateSql_u3 = null;
									UpdateSql_u3 = new StringBuffer();
									UpdateSql_u3.append( " UPDATE ACCOUNT.FSREFTOT SET " );
									UpdateSql_u3.append( "        DETOT = "+dbl_sum3[0]+"," );
									UpdateSql_u3.append( "        CRTOT = "+dbl_sum3[1]+"," );
									UpdateSql_u3.append( "        DEUPTOT = "+dbl_sum3[2]+"," );
									UpdateSql_u3.append( "        CRUPTOT = "+dbl_sum3[3]+"," );
									
									UpdateSql_u3.append( "        FODETOT = "+dbl_sum3_fo[0]+"," );
									UpdateSql_u3.append( "        FOCRTOT = "+dbl_sum3_fo[1]+"," );
									UpdateSql_u3.append( "        FODEUPTOT = "+dbl_sum3_fo[2]+"," );
									UpdateSql_u3.append( "        FOCRUPTOT = "+dbl_sum3_fo[3]+"" );
									UpdateSql_u3.append( "  WHERE FDCODE='"+str3[0]+"'" );
									UpdateSql_u3.append( "    AND ACTDAT='"+str3[1]+"'" );
									UpdateSql_u3.append( "    AND ATCODE='"+gstrAtupcode+"'" );
									UpdateSql_u3.append( "    AND COCODE='"+str3[3]+"'" );
									UpdateSql_u3.append( "    AND DIVCD='"+str3[4]+"'" );
									UpdateSql_u3.append( "    AND DEPTCD='"+str3[5]+"'" );
									UpdateSql_u3.append( "    AND FSREFCD='"+str3[6]+"'" );
									UpdateSql_u3.append( "    AND FSREFVAL='"+str3[7]+"'" );

									///logger.dbg.println(this,"UpdateSql_u3" + UpdateSql_u3.toString());

									GauceStatement gsmt_u3 = conn.getGauceStatement(UpdateSql_u3.toString());
									gsmt_u3.executeUpdate();
									gsmt_u3.close();	
								}//while rs_u1

							
								if(strGubun_2.equals("0")){                       //Insert           
									
								  StringBuffer sql_u12 = new StringBuffer();
									Statement stmt_u12 = null;
									ResultSet rs_u12 = null;

									sql_u12.append( " SELECT IFNULL(B.ATGRP,'')ATGRP,B.ATUPCODE "); 
									sql_u12.append( "   FROM ACCOUNT.ACTCODE B ");
									sql_u12.append( "  WHERE B.ATCODE ='"+gstrAtupcode+"'  ");
									stmt_u12 = conn.createStatement();
									rs_u12 = stmt_u12.executeQuery(sql_u12.toString());

									strAtgrp="";
                  					strAtupcode="";

									while(rs_u12.next())	{
										strAtgrp=rs_u12.getString(1);
										strAtupcode=rs_u12.getString(2);
									}
									rs_u12.close();

								//관리항목집계(일별)
									StringBuffer InsertSql_u3 = null;
									InsertSql_u3 = new StringBuffer();
									InsertSql_u3.append( " INSERT INTO ACCOUNT.FSREFTOT (" );
									InsertSql_u3.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD," );
									InsertSql_u3.append( " DEPTCD,  FSREFCD, FSREFVAL , " );
									InsertSql_u3.append( " DETOT,   CRTOT,   DEUPTOT,   CRUPTOT," );
									InsertSql_u3.append( " FODETOT, FOCRTOT, FODEUPTOT, FOCRUPTOT" );
									InsertSql_u3.append( "  ) " );
									InsertSql_u3.append( " VALUES ( '"+str3[0]+"','"+str3[1]+"','"+gstrAtupcode+"','"+str3[3]+"','"+str3[4]+"'," ); 
									InsertSql_u3.append( " '"+str3[5]+"','"+str3[6]+"','"+str3[7]+"'," ); 
									InsertSql_u3.append( " "+dbl3[0]+","+dbl3[1]+","+dbl3[0]+","+dbl3[1]+","); 
									InsertSql_u3.append( " "+dbl3_fo[0]+","+dbl3_fo[1]+","+dbl3_fo[0]+","+dbl3_fo[1]+")" ); 
									
									///logger.dbg.println(this,"InsertSql_u3" + InsertSql_u3.toString());
									GauceStatement gsmt_u3 = conn.getGauceStatement(InsertSql_u3.toString());
									gsmt_u3.executeUpdate();
									gsmt_u3.close();
								}//if rs_u3

								rs_u3.close();

                if(!strAtgrp.equals("1")&&!strAtgrp.equals("")){
									gstrAtupcode = strAtupcode;
								}else{
									//logger.dbg.println(this,"strAtgrp_null::"+strAtgrp); 
									break;
								}
							}//for k2 
						}//if(dbl3[2]+dbl3[3]!=0)
					}//while rs_u2

					rs_u2.close();

					*/

          //=======================================================================
					//변수 초기화
					//=======================================================================
					//변수 초기화
					for (int s=0;s<=5;s++) {
							str[s] = "";
					}

					for (int s=0;s<=9;s++) {
							dbl[s] = 0;
							dbl2[s] = 0;
							dbl_sum[s] = 0;
						
							dbl_fo[s] = 0;
							dbl2_fo[s] = 0;
							dbl_sum_fo[s] = 0;
					}

					for (int s=0;s<=7;s++) {
						str3[s] = "";
					}

					for (int s=0;s<=3;s++) {
							dbl3[s] = 0;
							dbl4[s] = 0;
							dbl_sum3[s] = 0;

							dbl3_fo[s] = 0;
							dbl4_fo[s] = 0;
							dbl_sum3_fo[s] = 0;
					}

					strGubun_1="0";
					strGubun_2="0";

				 /************************************************************************************
					 @ 합계잔액(월별)
					*************************************************************************************/
					
					StringBuffer sql_md = new StringBuffer();
					Statement stmt_md = null;
					ResultSet rs_md = null;

					// logger.dbg.println(this,"월별합계잔액1");

					sql_md.append( " SELECT A.FDCODE,  A.ACTYYMM, B.ATUPCODE, A.COCODE, A.DIVCD,  ");
					sql_md.append( "        A.DEPTCD,                                            ");
					sql_md.append( "        SUM(A.DETOT)    AS DETOT,                            ");
					sql_md.append( "        SUM(A.CRTOT)    AS CRTOT,                          ");
					sql_md.append( "        SUM(A.DECASH)   AS DECASH,                       ");
					sql_md.append( "        SUM(A.CRCASH)   AS CRCASH,                       ");
					sql_md.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                      ");
					sql_md.append( "        SUM(A.CRUPTOT)  AS CRUPTOT,                      ");
					sql_md.append( "        SUM(A.DEUPCASH) AS DEUPCASH,                     ");
					sql_md.append( "        SUM(A.CRUPCASH) AS CRUPCASH,                      ");
					sql_md.append( "        SUM(A.EDECASH)  AS EDECASH,                      ");
					sql_md.append( "        SUM(A.ECRCASH)  AS ECRCASH,                      ");

					sql_md.append( "        SUM(A.FODETOT)    AS FODETOT,                    ");
					sql_md.append( "        SUM(A.FOCRTOT)    AS FOCRTOT,                    ");
					sql_md.append( "        SUM(A.FODECASH)   AS FODECASH,                   ");
					sql_md.append( "        SUM(A.FOCRCASH)   AS FOCRCASH,                   ");
					sql_md.append( "        SUM(A.FODEUPTOT)  AS FODEUPTOT,                  ");
					sql_md.append( "        SUM(A.FOCRUPTOT)  AS FOCRUPTOT,                  ");
					sql_md.append( "        SUM(A.FODEUPCASH) AS FODEUPCASH,                 ");
					sql_md.append( "        SUM(A.FOCRUPCASH) AS FOCRUPCASH,                 ");
					sql_md.append( "        SUM(A.FOEDECASH)  AS FOEDECASH,                  ");
					sql_md.append( "        SUM(A.FOECRCASH)  AS FOECRCASH                   ");
           
					sql_md.append( "   FROM ACCOUNT.MDMTOTAL A,ACCOUNT.ACTCODE B           ");
					sql_md.append( "  WHERE A.ATCODE = B.ATCODE                            ");
					sql_md.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0                  ");
					sql_md.append( "     OR A.DEUPCASH <> 0 OR A.CRUPCASH <> 0)                ");
					sql_md.append( "    AND B.ATUSEYN ='Y'                         ");
					sql_md.append( "    AND A.ACTYYMM='"+strYYMM+"'                         ");
					sql_md.append( "    AND A.FDCODE IN ('"+strFDCODE+"') ");
					//sql_md.append( "    AND A.STATUS ='Y'                         ");
					sql_md.append( "  GROUP BY A.FDCODE, A.ACTYYMM, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD");
					
					stmt_md = conn.createStatement();
					rs_md = stmt_md.executeQuery(sql_md.toString());

					while(rs_md.next())	{
					//logger.dbg.println(this,"월별합계잔액2");
						str[0]=rs_md.getString(1);  //FDCODE
						str[1]=rs_md.getString(2);  //ACTYYMM
						str[2]=rs_md.getString(3);  //ATUPCODE
						str[3]=rs_md.getString(4);  //COCODE
						str[4]=rs_md.getString(5);  //DIVCD
						str[5]=rs_md.getString(6);  //DEPTCD

						dbl[0]=rs_md.getDouble(7);
						dbl[1]=rs_md.getDouble(8);
						dbl[2]=rs_md.getDouble(9);
						dbl[3]=rs_md.getDouble(10);
						dbl[4]=rs_md.getDouble(11);
						dbl[5]=rs_md.getDouble(12);
						dbl[6]=rs_md.getDouble(13);
						dbl[7]=rs_md.getDouble(14);
						dbl[8]=rs_md.getDouble(15);
						dbl[9]=rs_md.getDouble(16);

						dbl_fo[0]=rs_md.getDouble(17);
						dbl_fo[1]=rs_md.getDouble(18);
						dbl_fo[2]=rs_md.getDouble(19);
						dbl_fo[3]=rs_md.getDouble(20);
						dbl_fo[4]=rs_md.getDouble(21);
						dbl_fo[5]=rs_md.getDouble(22);
						dbl_fo[6]=rs_md.getDouble(23);
						dbl_fo[7]=rs_md.getDouble(24);
						dbl_fo[8]=rs_md.getDouble(25);
						dbl_fo[9]=rs_md.getDouble(26);

						gstrAtupcode = str[2];

						//icnt=0;

						//logger.dbg.println(this,"gstrAtupcode:::"+gstrAtupcode);

						if(dbl[4]+dbl[5]+dbl[6]+dbl[7]!=0){
							//logger.dbg.println(this,"월별합계잔액3");
							//Next_Level3:
							_out3:
							for(int k3=1;k3<=5;k3++){

								StringBuffer sql_mu1 = new StringBuffer();
								Statement stmt_mu1 = null;
								ResultSet rs_mu1 = null;

								//icnt+=1;
								//logger.dbg.println(this,"3icnt:::"+icnt);
								
								sql_mu1.append( " SELECT A.DETOT,  A.CRTOT,  A.DECASH,  A.CRCASH,  A.DEUPTOT,  A.CRUPTOT,  A.DEUPCASH,  A.CRUPCASH,  A.EDECASH,  A.ECRCASH, ");
								sql_mu1.append( "        A.FODETOT,A.FOCRTOT,A.FODECASH,A.FOCRCASH,A.FODEUPTOT,A.FOCRUPTOT,A.FODEUPCASH,A.FOCRUPCASH,A.FOEDECASH,A.FOECRCASH, ");
								sql_mu1.append( "        NVL(B.ATGRP,'')ATGRP,B.ATUPCODE ");
								sql_mu1.append( "   FROM ACCOUNT.MDMTOTAL A,  ACCOUNT.ACTCODE B 	");
								sql_mu1.append( "  WHERE A.ATCODE =B.ATCODE  ");
								sql_mu1.append( "    AND A.FDCODE ='"+str[0]+"'  ");
								sql_mu1.append( "    AND A.ACTYYMM ='"+str[1]+"' ");
								sql_mu1.append( "    AND A.ATCODE ='"+gstrAtupcode+"'  ");
								sql_mu1.append( "    AND A.COCODE ='"+str[3]+"'  ");
								sql_mu1.append( "    AND A.DIVCD  ='"+str[4]+"'  ");
								sql_mu1.append( "    AND A.DEPTCD ='"+str[5]+"'  ");
								
								stmt_mu1 = conn.createStatement();
								rs_mu1 = stmt_mu1.executeQuery(sql_mu1.toString());

								strGubun_1="0";
								strAtgrp="";
								strAtupcode="";
									
								while(rs_mu1.next())	{
									//logger.dbg.println(this,"월별합계잔액4");
									strGubun_1="1";

									//원화
									dbl2[0]=rs_mu1.getDouble(1);
									dbl2[1]=rs_mu1.getDouble(2);
									dbl2[2]=rs_mu1.getDouble(3);
									dbl2[3]=rs_mu1.getDouble(4);
									dbl2[4]=rs_mu1.getDouble(5);
									dbl2[5]=rs_mu1.getDouble(6);
									dbl2[6]=rs_mu1.getDouble(7);
									dbl2[7]=rs_mu1.getDouble(8);
									dbl2[8]=rs_mu1.getDouble(9);
									dbl2[9]=rs_mu1.getDouble(10);
									
									//외화
									dbl2_fo[0]=rs_mu1.getDouble(11);
									dbl2_fo[1]=rs_mu1.getDouble(12);
									dbl2_fo[2]=rs_mu1.getDouble(13);
									dbl2_fo[3]=rs_mu1.getDouble(14);
									dbl2_fo[4]=rs_mu1.getDouble(15);
									dbl2_fo[5]=rs_mu1.getDouble(16);
									dbl2_fo[6]=rs_mu1.getDouble(17);
									dbl2_fo[7]=rs_mu1.getDouble(18);
									dbl2_fo[8]=rs_mu1.getDouble(19);
									dbl2_fo[9]=rs_mu1.getDouble(20);

									strAtgrp=rs_mu1.getString(21);
									strAtupcode=rs_mu1.getString(22);
									
									//기존금액 Sum
									//원화
									dbl_sum[0] = dbl[4] + dbl2[0];
									dbl_sum[1] = dbl[5] + dbl2[1];
									dbl_sum[2] = dbl[6] + dbl2[2];
									dbl_sum[3] = dbl[7] + dbl2[3];
									dbl_sum[4] = dbl[4] ;
									dbl_sum[5] = dbl[5] ;
									dbl_sum[6] = dbl[6] ;
									dbl_sum[7] = dbl[7] ;

							
									//외화
									dbl_sum_fo[0] = dbl_fo[4] + dbl2_fo[0];     
									dbl_sum_fo[1] = dbl_fo[5] + dbl2_fo[1];
									dbl_sum_fo[2] = dbl_fo[6] + dbl2_fo[2];
									dbl_sum_fo[3] = dbl_fo[7] + dbl2_fo[3];
									dbl_sum_fo[4] = dbl_fo[4];
									dbl_sum_fo[5] = dbl_fo[5];
									dbl_sum_fo[6] = dbl_fo[6];
									dbl_sum_fo[7] = dbl_fo[7];

									//Update
									StringBuffer UpdateSql_mu1 = null;
									UpdateSql_mu1 = new StringBuffer();
									UpdateSql_mu1.append( " UPDATE ACCOUNT.MDMTOTAL SET " );
									UpdateSql_mu1.append( "        DETOT = "+dbl_sum[0]+"," );
									UpdateSql_mu1.append( "        CRTOT = "+dbl_sum[1]+"," );
									UpdateSql_mu1.append( "        DECASH ="+dbl_sum[2]+"," );
									UpdateSql_mu1.append( "        CRCASH= "+dbl_sum[3]+"," );
									UpdateSql_mu1.append( "        DEUPTOT = "+dbl_sum[4]+"," );
									UpdateSql_mu1.append( "        CRUPTOT = "+dbl_sum[5]+"," );
									UpdateSql_mu1.append( "        DEUPCASH ="+dbl_sum[6]+"," );
									UpdateSql_mu1.append( "        CRUPCASH= "+dbl_sum[7]+"," );

									UpdateSql_mu1.append( "        FODETOT = "+dbl_sum_fo[0]+"," );
									UpdateSql_mu1.append( "        FOCRTOT = "+dbl_sum_fo[1]+"," );
									UpdateSql_mu1.append( "        FODECASH ="+dbl_sum_fo[2]+"," );
									UpdateSql_mu1.append( "        FOCRCASH= "+dbl_sum_fo[3]+"," );
									UpdateSql_mu1.append( "        FODEUPTOT = "+dbl_sum_fo[4]+"," );
									UpdateSql_mu1.append( "        FOCRUPTOT = "+dbl_sum_fo[5]+"," );
									UpdateSql_mu1.append( "        FODEUPCASH ="+dbl_sum_fo[6]+"," );
									UpdateSql_mu1.append( "        FOCRUPCASH= "+dbl_sum_fo[7]+"," );
									UpdateSql_mu1.append( "        STATUS= 'Y'" );

									UpdateSql_mu1.append( "  WHERE FDCODE='"+str[0]+"'" );
									UpdateSql_mu1.append( "    AND ACTYYMM='"+str[1]+"'" );
									UpdateSql_mu1.append( "    AND ATCODE='"+gstrAtupcode+"'" );
									UpdateSql_mu1.append( "    AND COCODE='"+str[3]+"'" );
									UpdateSql_mu1.append( "    AND DIVCD='"+str[4]+"'" );
									UpdateSql_mu1.append( "    AND DEPTCD='"+str[5]+"'" );
									
									/// logger.dbg.println(this,"UpdateSql_mu1" + UpdateSql_mu1.toString());

									GauceStatement gsmt_mu1 = conn.getGauceStatement(UpdateSql_mu1.toString());
									gsmt_mu1.executeUpdate();
									gsmt_mu1.close();	
								}//while rs_u1

								if(strGubun_1.equals("0")){                          //Insert
									 
									StringBuffer sql_mu11 = new StringBuffer();
									Statement stmt_mu11 = null;
									ResultSet rs_mu11 = null;

									sql_mu11.append( " SELECT NVL(B.ATGRP,'')ATGRP,B.ATUPCODE "); 
									sql_mu11.append( "   FROM ACCOUNT.ACTCODE B ");
									sql_mu11.append( "  WHERE B.ATCODE ='"+gstrAtupcode+"'  ");
									stmt_mu11 = conn.createStatement();
									rs_mu11 = stmt_mu11.executeQuery(sql_mu11.toString());

									strAtgrp="";
									strAtupcode="";

									while(rs_mu11.next())	{
										strAtgrp=rs_mu11.getString(1);
										strAtupcode=rs_mu11.getString(2);
									}
									rs_mu11.close();

									StringBuffer InsertSql_mu1 = null;
									InsertSql_mu1 = new StringBuffer();
									InsertSql_mu1.append( " INSERT INTO ACCOUNT.MDMTOTAL (" );
									InsertSql_mu1.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD," );
									InsertSql_mu1.append( " DEPTCD,  " );
									InsertSql_mu1.append( " DETOT,     CRTOT,     DECASH,     CRCASH," );
									InsertSql_mu1.append( " DEUPTOT,   CRUPTOT,   DEUPCASH,   CRUPCASH,  " );
									InsertSql_mu1.append( " FODETOT,   FOCRTOT,   FODECASH,   FOCRCASH,  " );
									InsertSql_mu1.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH,STATUS  " );
									InsertSql_mu1.append( "  ) " );
									InsertSql_mu1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+gstrAtupcode+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
									InsertSql_mu1.append( " "+dbl[0]+","+dbl[1]+","+dbl[2]+","+dbl[3]+","+dbl[4]+","+dbl[5]+","+dbl[6]+","+dbl[7]+"," ); 
									InsertSql_mu1.append( " "+dbl_fo[0]+","+dbl_fo[1]+","+dbl_fo[2]+","+dbl_fo[3]+"," );
									InsertSql_mu1.append( " "+dbl_fo[4]+","+dbl_fo[5]+","+dbl_fo[6]+","+dbl_fo[7]+",'Y')" ); 

									/// logger.dbg.println(this,"InsertSql_mu1"+InsertSql_mu1.toString());

									GauceStatement gsmt_mu1 = conn.getGauceStatement(InsertSql_mu1.toString());
									gsmt_mu1.executeUpdate();
									gsmt_mu1.close();	
								}//if rs_u1
								rs_mu1.close();

								if(!strAtgrp.equals("1")&&!strAtgrp.equals("")){
									gstrAtupcode = strAtupcode;
								}else{
									//logger.dbg.println(this,"strAtgrp_null::"+strAtgrp); 
									break _out3;
								}
							}//for k3 
						}
					}//while rs_d
					rs_md.close();
         
				 
				/************************************************************************************
				 @ 관리항목집계(월별)
				*************************************************************************************/
				/*
					StringBuffer sql_mu2 = new StringBuffer();
					Statement stmt_mu2 = null;
					ResultSet rs_mu2 = null;
					
					logger.dbg.println(this,"월별관리항목집계1");
					sql_mu2.append( " SELECT A.FDCODE,  A.ACTYYMM, B.ATUPCODE, A.COCODE, A.DIVCD, ");
					sql_mu2.append( "        A.DEPTCD,  A.FSREFCD, A.FSREFVAL,                   ");
					sql_mu2.append( "        SUM(A.DETOT)    AS DETOT,                           ");
					sql_mu2.append( "        SUM(A.CRTOT)    AS CRTOT,                           ");
					sql_mu2.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                         ");
					sql_mu2.append( "        SUM(A.CRUPTOT)  AS CRUPTOT,                          ");
          
          sql_mu2.append( "        SUM(A.FODETOT)    AS FODETOT,                           ");
					sql_mu2.append( "        SUM(A.FOCRTOT)    AS FOCRTOT,                           ");
					sql_mu2.append( "        SUM(A.FODEUPTOT)  AS FODEUPTOT,                         ");
					sql_mu2.append( "        SUM(A.FOCRUPTOT)  AS FOCRUPTOT                         ");
					sql_mu2.append( "   FROM ACCOUNT.MFSREFTOT A,ACCOUNT.ACTCODE B                ");
					sql_mu2.append( "  WHERE A.ATCODE = B.ATCODE                                 ");
					sql_mu2.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0)                  ");
					sql_mu2.append( "    AND B.ATUSEYN ='Y'                         ");
					sql_mu2.append( "    AND A.ACTYYMM='"+strYYMM+"'                         ");
					sql_mu2.append( "  GROUP BY A.FDCODE, A.ACTYYMM, B.ATUPCODE, A.COCODE,A.DIVCD,");
					sql_mu2.append( "           A.DEPTCD,A.FSREFCD, A.FSREFVAL                   ");
			
			   /// logger.dbg.println(this,"sql_mu2"+sql_mu2.toString());
					stmt_mu2 = conn.createStatement();
					rs_mu2 = stmt_mu2.executeQuery(sql_mu2.toString());
				
					while(rs_mu2.next())	{
						logger.dbg.println(this,"월별관리항목집계2");
						str3[0]=rs_mu2.getString(1);  //FDCODE
						str3[1]=rs_mu2.getString(2);  //ACTDAT
						str3[2]=rs_mu2.getString(3);  //ATUPCODE
						str3[3]=rs_mu2.getString(4);  //COCODE
						str3[4]=rs_mu2.getString(5);  //DIVCD
						str3[5]=rs_mu2.getString(6);  //DEPTCD
						str3[6]=rs_mu2.getString(7);  //FSREFCD
						str3[7]=rs_mu2.getString(8);  //FSREFVAL

						dbl3[0]=rs_mu2.getDouble(9);
						dbl3[1]=rs_mu2.getDouble(10);
						dbl3[2]=rs_mu2.getDouble(11);
						dbl3[3]=rs_mu2.getDouble(12);

						dbl3_fo[0]=rs_mu2.getDouble(13);
						dbl3_fo[1]=rs_mu2.getDouble(14);
						dbl3_fo[2]=rs_mu2.getDouble(15);
						dbl3_fo[3]=rs_mu2.getDouble(16);

						gstrAtupcode = str3[2];
             
           // icnt=0;
          
						if(dbl3[2]+dbl3[3]!=0){
             /// logger.dbg.println(this,"월별관리항목집계222");

             // Next_Level4:
							for(int k4=1;k4<=5;k4++){
								StringBuffer sql_mu3 = new StringBuffer();
								Statement stmt_mu3 = null;
								ResultSet rs_mu3 = null;

								//icnt+=1;
							//	logger.dbg.println(this,"4icnt:::"+icnt);
								
								sql_mu3.append( " SELECT A.DETOT,   A.CRTOT,   A.DEUPTOT,   A.CRUPTOT,  ");
								sql_mu3.append( "        A.FODETOT, A.FOCRTOT, A.FODEUPTOT, A.FOCRUPTOT,  ");
                sql_mu3.append( "        IFNULL(B.ATGRP,'')ATGRP,B.ATUPCODE  ");
								sql_mu3.append( "   FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B ");
								sql_mu3.append( "  WHERE A.ATCODE =B.ATCODE  ");
								sql_mu3.append( "    AND A.FDCODE ='"+str3[0]+"'  ");
								sql_mu3.append( "    AND A.ACTYYMM ='"+str3[1]+"'  ");
								sql_mu3.append( "    AND A.ATCODE ='"+gstrAtupcode+"'  ");
								sql_mu3.append( "    AND A.COCODE ='"+str3[3]+"'  ");
								sql_mu3.append( "    AND A.DIVCD  ='"+str3[4]+"'  ");
								sql_mu3.append( "    AND A.DEPTCD ='"+str3[5]+"'  ");
								sql_mu3.append( "    AND A.FSREFCD  ='"+str3[6]+"'  ");
								sql_mu3.append( "    AND A.FSREFVAL ='"+str3[7]+"'  ");

								///logger.dbg.println(this,"sql_mu3"+sql_mu3.toString());
								stmt_mu3 = conn.createStatement();
								rs_mu3 = stmt_mu3.executeQuery(sql_mu3.toString());

								strGubun_2="0";
								
								while(rs_mu3.next())	{
									logger.dbg.println(this,"월별관리항목집계333");
									strGubun_2="1";
									dbl4[0]=rs_mu3.getDouble(1);
									dbl4[1]=rs_mu3.getDouble(2);
									dbl4[2]=rs_mu3.getDouble(3);
									dbl4[3]=rs_mu3.getDouble(4);

									dbl4_fo[0]=rs_mu3.getDouble(5);
									dbl4_fo[1]=rs_mu3.getDouble(6);
									dbl4_fo[2]=rs_mu3.getDouble(7);
									dbl4_fo[3]=rs_mu3.getDouble(8);

									strAtgrp=rs_mu3.getString(9);
									strAtupcode=rs_mu3.getString(10);
									
									//기존금액 Sum
									//원화
									dbl_sum3[0] = dbl4[0]+ dbl3[2]; 
									dbl_sum3[1] = dbl4[1]+ dbl3[3];
									dbl_sum3[2] = dbl3[2];
									dbl_sum3[3] = dbl3[3];

									//외화
									dbl_sum3_fo[0] = dbl4_fo[0]+ dbl3_fo[2]; 
									dbl_sum3_fo[1] = dbl4_fo[1]+ dbl3_fo[3];
									dbl_sum3_fo[2] = dbl3_fo[2];
									dbl_sum3_fo[3] = dbl3_fo[3];

									///logger.dbg.println(this,"월별관리항목집계444");
									//Update
									StringBuffer UpdateSql_mu3 = null;
									UpdateSql_mu3 = new StringBuffer();
									UpdateSql_mu3.append( " UPDATE ACCOUNT.MFSREFTOT SET " );
									UpdateSql_mu3.append( "        DETOT = "+dbl_sum3[0]+"," );
									UpdateSql_mu3.append( "        CRTOT = "+dbl_sum3[1]+"," );
									UpdateSql_mu3.append( "        DEUPTOT = "+dbl_sum3[2]+"," );
									UpdateSql_mu3.append( "        CRUPTOT = "+dbl_sum3[3]+"," );

									UpdateSql_mu3.append( "        FODETOT = "+dbl_sum3_fo[0]+"," );
									UpdateSql_mu3.append( "        FOCRTOT = "+dbl_sum3_fo[1]+"," );
									UpdateSql_mu3.append( "        FODEUPTOT = "+dbl_sum3_fo[2]+"," );
									UpdateSql_mu3.append( "        FOCRUPTOT = "+dbl_sum3_fo[3]+"" );

									UpdateSql_mu3.append( "  WHERE FDCODE='"+str3[0]+"'" );
									UpdateSql_mu3.append( "    AND ACTYYMM='"+str3[1]+"'" );
									UpdateSql_mu3.append( "    AND ATCODE='"+gstrAtupcode+"'" );
									UpdateSql_mu3.append( "    AND COCODE='"+str3[3]+"'" );
									UpdateSql_mu3.append( "    AND DIVCD='"+str3[4]+"'" );
									UpdateSql_mu3.append( "    AND DEPTCD='"+str3[5]+"'" );
									UpdateSql_mu3.append( "    AND FSREFCD='"+str3[6]+"'" );
									UpdateSql_mu3.append( "    AND FSREFVAL='"+str3[7]+"'" );

									///logger.dbg.println(this,"UpdateSql_mu3"+UpdateSql_mu3.toString());

									GauceStatement gsmt_mu3 = conn.getGauceStatement(UpdateSql_mu3.toString());
									gsmt_mu3.executeUpdate();
									gsmt_mu3.close();	
								}//while rs_u1
							
								if( strGubun_2.equals("0")){                          //Insert
									  StringBuffer sql_mu12 = new StringBuffer();
										Statement stmt_mu12 = null;
										ResultSet rs_mu12 = null;

										sql_mu12.append( " SELECT IFNULL(B.ATGRP,'')ATGRP,B.ATUPCODE "); 
										sql_mu12.append( "   FROM ACCOUNT.ACTCODE B ");
										sql_mu12.append( "  WHERE B.ATCODE ='"+gstrAtupcode+"'  ");
										stmt_mu12 = conn.createStatement();
										rs_mu12 = stmt_mu12.executeQuery(sql_mu12.toString());

										strAtgrp="";
										strAtupcode="";

										while(rs_mu12.next())	{
											strAtgrp=rs_mu12.getString(1);
											strAtupcode=rs_mu12.getString(2);
										}
										rs_mu12.close();

										StringBuffer InsertSql_mu3 = null;
										InsertSql_mu3 = new StringBuffer();
										InsertSql_mu3.append( " INSERT INTO ACCOUNT.MFSREFTOT (" );
										InsertSql_mu3.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD," );
										InsertSql_mu3.append( " DEPTCD,  FSREFCD, FSREFVAL," );
										InsertSql_mu3.append( " DETOT,   CRTOT,   DEUPTOT,   CRUPTOT," );
										InsertSql_mu3.append( " FODETOT, FOCRTOT, FODEUPTOT, FOCRUPTOT" );
										InsertSql_mu3.append( "  ) " );
										InsertSql_mu3.append( " VALUES ( '"+str3[0]+"','"+str3[1]+"','"+str3[2]+"','"+str3[3]+"','"+str3[4]+"'," ); 
										InsertSql_mu3.append( " '"+str3[5]+"','"+str3[6]+"','"+str3[7]+"'," ); 
										InsertSql_mu3.append( " "+dbl3[0]+","+dbl3[1]+","+dbl3[0]+","+dbl3[1]+","); 
										InsertSql_mu3.append( " "+dbl3_fo[0]+","+dbl3_fo[1]+","+dbl3_fo[0]+","+dbl3_fo[1]+")" ); 
										
										///logger.dbg.println(this,"InsertSql_mu3"+InsertSql_mu3.toString());
										GauceStatement gsmt_mu3 = conn.getGauceStatement(InsertSql_mu3.toString());
										gsmt_mu3.executeUpdate();
										gsmt_mu3.close();
								}//if strGubun_2
								rs_mu3.close();
								if(!strAtgrp.equals("1")&&!strAtgrp.equals("")){
									gstrAtupcode = strAtupcode;
								}else{
									//logger.dbg.println(this,"strAtgrp_null::"+strAtgrp); 
									break;
								}
							} //for k4
						}//if if(dbl3[2]+dbl3[3]!=0)
						
					}//while rs_mu2
					rs_mu2.close();

					*/
				  ///logger.dbg.println(this,"end j::"+ j);
			
        
					/***********************************************************
					잔액관련 필드 모두 0 으로 셋팅함.
				    ************************************************************/
				String  sql9 = " UPDATE  ACCOUNT.MDTOTAL SET "
							 + "         DEUPTOT = 0,  CRUPTOT = 0,  DEUPCASH =0,  CRUPCASH=0, "
							 + "         FODEUPTOT = 0,FOCRUPTOT = 0,FODEUPCASH =0,FOCRUPCASH=0 "
							 + "  WHERE  (DEUPTOT !=0 OR CRUPTOT !=0 OR DEUPCASH !=0 OR CRUPCASH!=0) "
							 + "    AND  SUBSTR(ACTDAT,1,6)='"+strYYMM+"'"   
							 + "    AND  FDCODE IN ('"+strFDCODE+"')" ;					
				GauceStatement gsmt9 = conn.getGauceStatement(sql9);
				gsmt9.executeUpdate();
				gsmt9.close();
        
				/*
				String  sql91 = " UPDATE  ACCOUNT.FSREFTOT SET "
										 + "         DEUPTOT = 0,  CRUPTOT = 0, "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0 "
										 + "  WHERE  (DEUPTOT !=0 OR CRUPTOT !=0)"
										 + "    AND  SUBSTR(ACTDAT,1,6)='"+strYYMM+"'" ;
										
				GauceStatement gsmt91 = conn.getGauceStatement(sql91);
				gsmt91.executeUpdate();
				gsmt91.close();
        */
				String  sql92 = " UPDATE  ACCOUNT.MDMTOTAL SET "
										 + "         DEUPTOT = 0,  CRUPTOT = 0,  DEUPCASH =0,  CRUPCASH=0, "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0,FODEUPCASH =0,FOCRUPCASH=0 "
										 + "  WHERE  (DEUPTOT !=0 OR CRUPTOT !=0 OR DEUPCASH !=0 OR CRUPCASH!=0) "
										 + "    AND  ACTYYMM='"+strYYMM+"'"
										 + "    AND  FDCODE IN ('"+strFDCODE+"')" ;
				
				GauceStatement gsmt92 = conn.getGauceStatement(sql92);
				gsmt92.executeUpdate();
				gsmt92.close();

        /*
				String  sql93 = " UPDATE  ACCOUNT.MFSREFTOT SET "
										 + "         DEUPTOT = 0,  CRUPTOT = 0, "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0 "
										 + "  WHERE  (DEUPTOT !=0 OR CRUPTOT !=0)"
										 + "    AND  ACTYYMM='"+strYYMM+"'";
										
				GauceStatement gsmt93 = conn.getGauceStatement(sql93);
				gsmt93.executeUpdate();
				gsmt93.close();
        */
       ///logger.dbg.println(this,"END");
			 //update

        //상위집계상태조회
				//유무 체크후 update/insert
				//상위집계내역 insert

        /**
			  --상위집계상태 조회
				SELECT COUNT(*) INTO V_CNT2
					FROM ACCOUNT.UPSUMSTS
				 WHERE GUBUN='1'
					 AND FDCODE = pFDCODE
					 AND ACTYYMM =pYYYYMM;

				--상위집계상태
					IF V_CNT2 = 0 THEN -- INSERT
					INSERT INTO ACCOUNT.UPSUMSTS (
						GUBUN, FDCODE, ACTYYMM, UPSTS, 
						WRID,  WRDT,   UPID,  UPDT
					)VALUES(
									'1', pFDCODE, pYYYYMM, '1',
						pEMPNO, CURRENT TIMESTAMP, pEMPNO, CURRENT TIMESTAMP
					);	 
				ELSE --UPDATE
						UPDATE ACCOUNT.UPSUMSTS SET
						UPSTS = '1',    --집계완료
									UPID = pEMPNO, 
									UPDT = CURRENT TIMESTAMP
							 WHERE GUBUN='1'
						 AND FDCODE = pFDCODE
								 AND ACTYYMM =pYYYYMM;
				END IF;

				-------------------------------------------------------

				--상위집계내역 
				INSERT INTO ACCOUNT.UPSUMHIS ( 
					GUBUN, FDCODE, ACTYYMM, UPSEQ, 
					WRID,  WRDT,   UPID,    UPDT
				)VALUES ('1',  pFDCODE, pYYYYMM, ACCOUNT.FN_MAXSEQ('1',pFDCODE, pYYYYMM),
							pEMPNO, CURRENT TIMESTAMP, pEMPNO, CURRENT TIMESTAMP
				);
        **/
				int intCnt=0;
				String strCnt="0";

				StringBuffer sql_999 = new StringBuffer();
				Statement stmt_999 = null;
				ResultSet rs_999 = null;

				sql_999.append( " SELECT COUNT(*) CNT "); 
				sql_999.append( "   FROM ACCOUNT.UPSUMSTS ");
				sql_999.append( "  WHERE GUBUN='9'  ");
				sql_999.append( "    AND FDCODE IN ('"+strFDCODE+"')    ");
				sql_999.append( "    AND ACTYYMM ='"+strYYMM+"'  ");

				stmt_999 = conn.createStatement();
				rs_999 = stmt_999.executeQuery(sql_999.toString());

				while(rs_999.next())	{
					intCnt =  rs_999.getInt(1);
				}

				strCnt = String.valueOf(intCnt);
			 
			  if(strCnt.equals("0")){ //INSERT 
					StringBuffer InsertSql_999 = new StringBuffer();
					InsertSql_999.append( " INSERT INTO ACCOUNT.UPSUMSTS (  " );
					InsertSql_999.append( "  GUBUN, FDCODE, ACTYYMM, UPSTS, " );
					InsertSql_999.append( "   WRID, WRDT,   UPID,    UPDT "  );
					InsertSql_999.append( " )VALUES(  ");
					InsertSql_999.append( "   '9','"+strFDCODE+"','"+strYYMM+"','1', " );
					InsertSql_999.append( "   '"+strEMPNO+"', CURRENT_TIMESTAMP, '"+strEMPNO+"', CURRENT_TIMESTAMP " );
					InsertSql_999.append( " ) " );

					GauceStatement gsmt999 = conn.getGauceStatement(InsertSql_999.toString());
					gsmt999.executeUpdate();
					gsmt999.close();
				}else{ // UPDAET 
					StringBuffer UpdateSql_999 = new StringBuffer();
					UpdateSql_999.append( " UPDATE ACCOUNT.UPSUMSTS SET " );
					UpdateSql_999.append( "        UPSTS = '1'," );
					UpdateSql_999.append( "        UPID ='"+strEMPNO+"'," );
					UpdateSql_999.append( "        UPDT = CURRENT_TIMESTAMP" );
					UpdateSql_999.append( "  WHERE GUBUN='9'       " );
					UpdateSql_999.append( "    AND FDCODE IN ('"+strFDCODE+"') " );
					UpdateSql_999.append( "    AND ACTYYMM ='"+strYYMM+"'   " );
 
					GauceStatement gsmt999 = conn.getGauceStatement(UpdateSql_999.toString());
					gsmt999.executeUpdate();
					gsmt999.close();
				}

			
				//상위집계내역 INSERT
				StringBuffer InsertSql9999 = new StringBuffer();
				InsertSql9999.append( " INSERT INTO ACCOUNT.UPSUMHIS (  " );
				InsertSql9999.append( "  GUBUN, FDCODE, ACTYYMM, UPSEQ, " );
				InsertSql9999.append( "   WRID, WRDT,   UPID,    UPDT "  );
				InsertSql9999.append( " )VALUES(  ");
				InsertSql9999.append( "   '9',  '"+strFDCODE+"','"+strYYMM+"', ACCOUNT.FN_MAXSEQ('9','"+strFDCODE+"', '"+strYYMM+"' ), " );
				InsertSql9999.append( "   '"+strEMPNO+"', CURRENT_TIMESTAMP, '"+strEMPNO+"', CURRENT_TIMESTAMP " );
				InsertSql9999.append( " ) " );

				GauceStatement gsmt9999 = conn.getGauceStatement(InsertSql9999.toString());
				gsmt9999.executeUpdate();
				gsmt9999.close();

        
			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
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