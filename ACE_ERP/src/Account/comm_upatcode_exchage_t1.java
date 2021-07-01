package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class comm_upatcode_exchage_t1 extends HttpServlet{
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

      ///////////////////////////////////
			//집계 테이블의 상위계정 합 구하기
      ///////////////////////////////////

			int strlevel = 0;
			String strGubun_1 ="0";
			String strGubun_2 ="0";
      
			//합계잔액
			String [] str = new String [6];
				     		
      //외화
			double [] dbl_fo = new double [10];
      double [] dbl2_fo = new double [10];
			double [] dbl_sum_fo = new double [10];

	
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
				 @ 금강산 외화 환율 변환 
         @ 일별합계잔액 / 일별관리항목집계 / 월별합계잔액 / 월별관리항목집계
         //현금등가물의 경우 상위 집계 제외 됨.==>상위 필드 없음.
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String strYYMM = reqGauce.getParameter("v_str1");     //기준년월
				String strFDCODE = reqGauce.getParameter("v_str2");   //지점
				String strYY01 = reqGauce.getParameter("v_str3");     //년초

        //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				//상위 집계 계정 Clear 및 상위집계 데이타 생성 (Start)
        //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
        //1.일집계 해당월의 상위 데이타 삭제 
				String  sql001 = " UPDATE ACCOUNT.TOTALBAL A SET A.FODETOT=0, A.FOCRTOT=0"
									  	 + "  WHERE SUBSTR(A.ACTDAT,1,6)>='"+strYY01+"' "
											 + "    AND SUBSTR(A.ACTDAT,1,6)<='"+strYYMM+"' "
									  	 + "    AND EXISTS ( SELECT B.ATCODE FROM ACCOUNT.ACTCODE B"
									  	 + " 			            WHERE A.ATCODE = B.ATCODE "
								  		 + "   		              AND SUBSTR(A.ACTDAT,1,6)>='"+strYY01+"'"
											 + "                    AND SUBSTR(A.ACTDAT,1,6)<='"+strYYMM+"'"
											 + "   		              AND B.ATUSEYN <>'Y'	)	"
											 + "    AND A.FDCODE IN ('"+strFDCODE+"')" ;
				//logger.dbg.println(this,"sql001::"+sql001);						
				GauceStatement gsmt001 = conn.getGauceStatement(sql001);
				gsmt001.executeUpdate();
				gsmt001.close();

				//2.일집계 해당월의 상위 집계 할 데이타 update  
				String  sql002 = " UPDATE ACCOUNT.TOTALBAL SET FODEUPTOT=FODETOT , FOCRUPTOT =FOCRTOT "
									  	 + "  WHERE SUBSTR(ACTDAT,1,6)>='"+strYY01+"'"
											 + "    AND SUBSTR(ACTDAT,1,6)<='"+strYYMM+"'"
											 + "    AND FDCODE IN ('"+strFDCODE+"')" ;
				//logger.dbg.println(this,"sql002::"+sql002);									
				GauceStatement gsmt002 = conn.getGauceStatement(sql002);
				gsmt002.executeUpdate();
				gsmt002.close();

				//3.월집계 해당월의 상위 데이타 삭제  
				String  sql003 = " UPDATE ACCOUNT.MTOTALBAL A SET FODETOT=0 , FOCRTOT=0 "
									  	 + "  WHERE A.ACTYYMM>='"+strYY01+"' "
											 + "    AND A.ACTYYMM<='"+strYYMM+"' "
									  	 + "    AND EXISTS ( SELECT B.ATCODE FROM ACCOUNT.ACTCODE B"
									  	 + " 			            WHERE A.ATCODE = B.ATCODE "
								  		 + "   		              AND A.ACTYYMM>='"+strYY01+"'"
											 + "   		              AND A.ACTYYMM<='"+strYYMM+"'"
											 + "   		              AND B.ATUSEYN <>'Y'	)	" 
											 + "    AND A.FDCODE IN ('"+strFDCODE+"')" ;
				
				//logger.dbg.println(this,"sql003::"+sql003);
				GauceStatement gsmt003 = conn.getGauceStatement(sql003);
				gsmt003.executeUpdate();
				gsmt003.close();

				//4.월집계 해당월의 상위 집계 할 데이타 update  
				String  sql004 = " UPDATE ACCOUNT.MTOTALBAL SET FODEUPTOT = FODETOT , FOCRUPTOT =FOCRTOT  "
									  	 + "  WHERE ACTYYMM >='"+strYY01+"'"
											 + "    AND ACTYYMM <='"+strYYMM+"'"
											 + "    AND FDCODE IN ('"+strFDCODE+"')" ;
				//logger.dbg.println(this,"sql004::"+sql004);
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
							dbl_fo[s] = 0;
							dbl2_fo[s] = 0;
							dbl_sum_fo[s] = 0;
					}

					/************************************************************************************
					 @ 합계잔액(일별)
					*************************************************************************************/
					//logger.dbg.println(this,"일별합계잔액");
					StringBuffer sql_d = new StringBuffer();
					Statement stmt_d = null;
					ResultSet rs_d = null;

          //기존금액 조회
					sql_d.append( " SELECT A.FDCODE,  A.ACTDAT, B.ATUPCODE, A.COCODE, A.DIVCD,  ");
					sql_d.append( "        A.DEPTCD,                                            ");
					sql_d.append( "        SUM(A.FODETOT)    AS FODETOT,         ");
					sql_d.append( "        SUM(A.FOCRTOT)    AS FOCRTOT,         ");
					sql_d.append( "        SUM(A.FODECASH)   AS FODECASH,        ");
					sql_d.append( "        SUM(A.FOCRCASH)   AS FOCRCASH,        ");
					sql_d.append( "        SUM(A.FODEUPTOT)  AS FODEUPTOT,       ");
					sql_d.append( "        SUM(A.FOCRUPTOT)  AS FOCRUPTOT,       ");
					sql_d.append( "        SUM(A.FODEUPCASH) AS FODEUPCASH,      ");
					sql_d.append( "        SUM(A.FOCRUPCASH) AS FOCRUPCASH,      ");
					sql_d.append( "        SUM(A.FOEDECASH)  AS FOEDECASH,       ");
					sql_d.append( "        SUM(A.FOECRCASH)  AS FOECRCASH        ");
					sql_d.append( "   FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B  ");
					sql_d.append( "  WHERE A.ATCODE = B.ATCODE                   ");
					sql_d.append( "    AND (A.FODEUPTOT <> 0 OR A.FOCRUPTOT <> 0  ");
					sql_d.append( "     OR A.FODEUPCASH <> 0 OR A.FOCRUPCASH <> 0)");
					sql_d.append( "    AND B.ATUSEYN ='Y'                         ");
					sql_d.append( "    AND SUBSTR(A.ACTDAT,1,6)>='"+strYY01+"'    ");
					sql_d.append( "    AND SUBSTR(A.ACTDAT,1,6)<='"+strYYMM+"'    ");
					sql_d.append( "    AND A.FDCODE IN ('"+strFDCODE+"') ");
					sql_d.append( "    AND A.EXRATEGB IN ('1','4','9')" );  //
					sql_d.append( "  GROUP BY A.FDCODE, A.ACTDAT, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD");
					
					//logger.dbg.println(this,sql_d.toString());
					stmt_d = conn.createStatement();
					rs_d = stmt_d.executeQuery(sql_d.toString());

          //logger.dbg.println(this,sql_d.toString());
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

						dbl_fo[0]=rs_d.getDouble(7); 
						dbl_fo[1]=rs_d.getDouble(8); 
						dbl_fo[2]=rs_d.getDouble(9); 
						dbl_fo[3]=rs_d.getDouble(10);
						dbl_fo[4]=rs_d.getDouble(11);
						dbl_fo[5]=rs_d.getDouble(12);
						dbl_fo[6]=rs_d.getDouble(13);
						dbl_fo[7]=rs_d.getDouble(14);
						dbl_fo[8]=rs_d.getDouble(15);
						dbl_fo[9]=rs_d.getDouble(16);

						gstrAtupcode = str[2];
            //logger.dbg.println(this,"rs_d.gstrAtupcode:::"+gstrAtupcode);
						//logger.dbg.println(this,"rs_d.getString(3):::"+rs_d.getString(3));
						if(dbl_fo[4]!=0||dbl_fo[5]!=0||dbl_fo[6]!=0||dbl_fo[7]!=0){   //상위계정의 값이 0이 아닌 경우
              //icnt+=1;
							//logger.dbg.println(this,"icnt::"+icnt);
							_out1:
							for(int k=1;k<=5;k++){
								StringBuffer sql_u1 = new StringBuffer();
								Statement stmt_u1 = null;
								ResultSet rs_u1 = null;
								
								sql_u1.append( " SELECT A.FODETOT,A.FOCRTOT,A.FODECASH,A.FOCRCASH, ");
								sql_u1.append( "        A.FODEUPTOT,A.FOCRUPTOT,A.FODEUPCASH,A.FOCRUPCASH,A.FOEDECASH,A.FOECRCASH, "); 
								sql_u1.append( "        IFNULL(B.ATGRP,'')ATGRP,B.ATUPCODE "); 
								sql_u1.append( "   FROM ACCOUNT.TOTALBAL A ,ACCOUNT.ACTCODE B ");
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
									
									//외화
									dbl2_fo[0]=rs_u1.getDouble(1); 
									dbl2_fo[1]=rs_u1.getDouble(2); 
									dbl2_fo[2]=rs_u1.getDouble(3); 
									dbl2_fo[3]=rs_u1.getDouble(4); 
									dbl2_fo[4]=rs_u1.getDouble(5); 
									dbl2_fo[5]=rs_u1.getDouble(6); 
									dbl2_fo[6]=rs_u1.getDouble(7); 
									dbl2_fo[7]=rs_u1.getDouble(8); 
									dbl2_fo[8]=rs_u1.getDouble(9); 
									dbl2_fo[9]=rs_u1.getDouble(10);

									strAtgrp=rs_u1.getString(11);
									strAtupcode=rs_u1.getString(12);

									//기존금액 Sum
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
									UpdateSql_u1.append( " UPDATE ACCOUNT.TOTALBAL SET " );
									UpdateSql_u1.append( "        FODETOT = "+dbl_sum_fo[0]+"," );
									UpdateSql_u1.append( "        FOCRTOT = "+dbl_sum_fo[1]+"," );
									UpdateSql_u1.append( "        FODECASH ="+dbl_sum_fo[2]+"," );
									UpdateSql_u1.append( "        FOCRCASH= "+dbl_sum_fo[3]+"," );
									UpdateSql_u1.append( "        FODEUPTOT = "+dbl_sum_fo[4]+"," );
									UpdateSql_u1.append( "        FOCRUPTOT = "+dbl_sum_fo[5]+"," );
									UpdateSql_u1.append( "        FODEUPCASH ="+dbl_sum_fo[6]+"," );
									UpdateSql_u1.append( "        FOCRUPCASH= "+dbl_sum_fo[7]+"" );
									UpdateSql_u1.append( "  WHERE FDCODE='"+str[0]+"'" );
									UpdateSql_u1.append( "    AND ACTDAT='"+str[1]+"'" );
									UpdateSql_u1.append( "    AND ATCODE='"+gstrAtupcode+"'" );
									UpdateSql_u1.append( "    AND COCODE='"+str[3]+"'" );
									UpdateSql_u1.append( "    AND DIVCD='"+str[4]+"'" );
									UpdateSql_u1.append( "    AND DEPTCD='"+str[5]+"'" );

									//logger.dbg.println(this,"UpdateSql_u1"+UpdateSql_u1.toString());
									//if(gstrAtupcode.equals("4110000")){
										//logger.dbg.println(this,"UpdateSql_u1"+UpdateSql_u1.toString());	
									//}

									GauceStatement gsmt_u1 = conn.getGauceStatement(UpdateSql_u1.toString());
									gsmt_u1.executeUpdate();
									gsmt_u1.close();	
								} //while rs_u1

                //logger.dbg.println(this,"strGubun_1::"+strGubun_1);
								if(strGubun_1.equals("0")){  //Insert 
								  //logger.dbg.println(this,"DATA 존재안함.....");
									StringBuffer sql_u11 = new StringBuffer();
									Statement stmt_u11 = null;
									ResultSet rs_u11 = null;

									sql_u11.append( " SELECT IFNULL(B.ATGRP,'')ATGRP,B.ATUPCODE "); 
									sql_u11.append( "   FROM ACCOUNT.ACTCODE B ");
									sql_u11.append( "  WHERE B.ATCODE ='"+gstrAtupcode+"'  ");

										
                 // if(gstrAtupcode.equals("4110000")){
								 //logger.dbg.println(this,"insert::select"+sql_u11.toString());	
								 //	}

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
									InsertSql_u1.append( " INSERT INTO ACCOUNT.TOTALBAL (" );
									InsertSql_u1.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD, DEPTCD," );
									InsertSql_u1.append( " FODETOT,   FOCRTOT,   FODECASH,   FOCRCASH,  " );
									InsertSql_u1.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH  " );
									InsertSql_u1.append( "  ) " );
									InsertSql_u1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+gstrAtupcode+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
									InsertSql_u1.append( " "+dbl_fo[0]+","+dbl_fo[1]+","+dbl_fo[2]+","+dbl_fo[3]+"," );
									InsertSql_u1.append( " "+dbl_fo[4]+","+dbl_fo[5]+","+dbl_fo[6]+","+dbl_fo[7]+")" ); 

									//logger.dbg.println(this,"InsertSql_u1"+InsertSql_u1.toString());
                  // if(gstrAtupcode.equals("4110000")){
								  //logger.dbg.println(this,"InsertSql_u1"+InsertSql_u1.toString());	
							    //	}

									GauceStatement gsmt_u1 = conn.getGauceStatement(InsertSql_u1.toString());
									gsmt_u1.executeUpdate();
									gsmt_u1.close();	
								}//if rs_u1
	              rs_u1.close(); 

                //logger.dbg.println(this,"strAtgrp::"+strAtgrp);
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
 

          //=======================================================================
					//변수 초기화
					//=======================================================================
					//변수 초기화
					for (int s=0;s<=5;s++) {
							str[s] = "";
					}

					for (int s=0;s<=9;s++) {
						
							dbl_fo[s] = 0;
							dbl2_fo[s] = 0;
							dbl_sum_fo[s] = 0;
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

					sql_md.append( " SELECT A.FDCODE,  A.ACTYYMM, B.ATUPCODE, A.COCODE, A.DIVCD,  \n");
					sql_md.append( "        A.DEPTCD,                                            \n");
					sql_md.append( "        SUM(A.FODETOT)    AS FODETOT,                    \n");
					sql_md.append( "        SUM(A.FOCRTOT)    AS FOCRTOT,                    \n");
					sql_md.append( "        SUM(A.FODECASH)   AS FODECASH,                   \n");
					sql_md.append( "        SUM(A.FOCRCASH)   AS FOCRCASH,                   \n");
					sql_md.append( "        SUM(A.FODEUPTOT)  AS FODEUPTOT,                  \n");
					sql_md.append( "        SUM(A.FOCRUPTOT)  AS FOCRUPTOT,                  \n");
					sql_md.append( "        SUM(A.FODEUPCASH) AS FODEUPCASH,                 \n");
					sql_md.append( "        SUM(A.FOCRUPCASH) AS FOCRUPCASH,                 \n");
					sql_md.append( "        SUM(A.FOEDECASH)  AS FOEDECASH,                  \n");
					sql_md.append( "        SUM(A.FOECRCASH)  AS FOECRCASH                   \n");
           
					sql_md.append( "   FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B           \n");
					sql_md.append( "  WHERE A.ATCODE = B.ATCODE                            \n");
					sql_md.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0                  \n");
					sql_md.append( "     OR A.DEUPCASH <> 0 OR A.CRUPCASH <> 0)                \n");
					sql_md.append( "    AND B.ATUSEYN ='Y'                         \n");
					sql_md.append( "    AND A.ACTYYMM='"+strYYMM+"'                         \n");
					sql_md.append( "    AND A.FDCODE IN ('"+strFDCODE+"') ");
					sql_md.append( "  GROUP BY A.FDCODE, A.ACTYYMM, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD\n");
					
				 
					//logger.dbg.println(this,"sql_md" +sql_md.toString());
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

						dbl_fo[0]=rs_md.getDouble(7); 
						dbl_fo[1]=rs_md.getDouble(8); 
						dbl_fo[2]=rs_md.getDouble(9); 
						dbl_fo[3]=rs_md.getDouble(10);
						dbl_fo[4]=rs_md.getDouble(11);
						dbl_fo[5]=rs_md.getDouble(12);
						dbl_fo[6]=rs_md.getDouble(13);
						dbl_fo[7]=rs_md.getDouble(14);
						dbl_fo[8]=rs_md.getDouble(15);
						dbl_fo[9]=rs_md.getDouble(16);

						gstrAtupcode = str[2];

						//icnt=0;

						if(dbl_fo[4]+dbl_fo[5]+dbl_fo[6]+dbl_fo[7]!=0){
               //logger.dbg.println(this,"월별합계잔액3");
							//Next_Level3:
							_out3:
							for(int k3=1;k3<=5;k3++){

								StringBuffer sql_mu1 = new StringBuffer();
								Statement stmt_mu1 = null;
								ResultSet rs_mu1 = null;

								//icnt+=1;
								//logger.dbg.println(this,"3icnt:::"+icnt);
								
								sql_mu1.append( " SELECT A.FODETOT,A.FOCRTOT,A.FODECASH,A.FOCRCASH, \n");
								sql_mu1.append( "        A.FODEUPTOT,A.FOCRUPTOT,A.FODEUPCASH,A.FOCRUPCASH,A.FOEDECASH,A.FOECRCASH, \n");
								sql_mu1.append( "        IFNULL(B.ATGRP,'')ATGRP,B.ATUPCODE \n");
								sql_mu1.append( "   FROM ACCOUNT.MTOTALBAL A,  ACCOUNT.ACTCODE B 	\n");
								sql_mu1.append( "  WHERE A.ATCODE =B.ATCODE  \n");
								sql_mu1.append( "    AND A.FDCODE ='"+str[0]+"'  \n");
								sql_mu1.append( "    AND A.ACTYYMM ='"+str[1]+"' \n");
								sql_mu1.append( "    AND A.ATCODE ='"+gstrAtupcode+"'  \n");
								sql_mu1.append( "    AND A.COCODE ='"+str[3]+"'  \n");
								sql_mu1.append( "    AND A.DIVCD  ='"+str[4]+"'  \n");
								sql_mu1.append( "    AND A.DEPTCD ='"+str[5]+"'  \n");
								
								//logger.dbg.println(this,"sql_mu1"+sql_mu1.toString());

								stmt_mu1 = conn.createStatement();
								rs_mu1 = stmt_mu1.executeQuery(sql_mu1.toString());

								strGubun_1="0";
								strAtgrp="";
								strAtupcode="";
									
								while(rs_mu1.next())	{
									//logger.dbg.println(this,"월별합계잔액4");
									strGubun_1="1";
									
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
									UpdateSql_mu1.append( " UPDATE ACCOUNT.MTOTALBAL SET " );
									UpdateSql_mu1.append( "        FODETOT = "+dbl_sum_fo[0]+"," );
									UpdateSql_mu1.append( "        FOCRTOT = "+dbl_sum_fo[1]+"," );
									UpdateSql_mu1.append( "        FODECASH ="+dbl_sum_fo[2]+"," );
									UpdateSql_mu1.append( "        FOCRCASH= "+dbl_sum_fo[3]+"," );
									UpdateSql_mu1.append( "        FODEUPTOT = "+dbl_sum_fo[4]+"," );
									UpdateSql_mu1.append( "        FOCRUPTOT = "+dbl_sum_fo[5]+"," );
									UpdateSql_mu1.append( "        FODEUPCASH ="+dbl_sum_fo[6]+"," );
									UpdateSql_mu1.append( "        FOCRUPCASH= "+dbl_sum_fo[7]+"" );

									UpdateSql_mu1.append( "  WHERE FDCODE='"+str[0]+"'" );
									UpdateSql_mu1.append( "    AND ACTYYMM='"+str[1]+"'" );
									UpdateSql_mu1.append( "    AND ATCODE='"+gstrAtupcode+"'" );
									UpdateSql_mu1.append( "    AND COCODE='"+str[3]+"'" );
									UpdateSql_mu1.append( "    AND DIVCD='"+str[4]+"'" );
									UpdateSql_mu1.append( "    AND DEPTCD='"+str[5]+"'" );
									
									//logger.dbg.println(this,"UpdateSql_mu1" + UpdateSql_mu1.toString());

									GauceStatement gsmt_mu1 = conn.getGauceStatement(UpdateSql_mu1.toString());
									gsmt_mu1.executeUpdate();
									gsmt_mu1.close();	
								}//while rs_u1

								if(strGubun_1.equals("0")){                          //Insert
									 
									StringBuffer sql_mu11 = new StringBuffer();
									Statement stmt_mu11 = null;
									ResultSet rs_mu11 = null;

									sql_mu11.append( " SELECT IFNULL(B.ATGRP,'')ATGRP,B.ATUPCODE \n"); 
									sql_mu11.append( "   FROM ACCOUNT.ACTCODE B \n");
									sql_mu11.append( "  WHERE B.ATCODE ='"+gstrAtupcode+"'  \n");
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
									InsertSql_mu1.append( " INSERT INTO ACCOUNT.MTOTALBAL (" );
									InsertSql_mu1.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD,DEPTCD," );
									InsertSql_mu1.append( " FODETOT,   FOCRTOT,   FODECASH,   FOCRCASH,  " );
									InsertSql_mu1.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH  " );
									InsertSql_mu1.append( "  ) " );
									InsertSql_mu1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+gstrAtupcode+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
									InsertSql_mu1.append( " "+dbl_fo[0]+","+dbl_fo[1]+","+dbl_fo[2]+","+dbl_fo[3]+"," );
									InsertSql_mu1.append( " "+dbl_fo[4]+","+dbl_fo[5]+","+dbl_fo[6]+","+dbl_fo[7]+")" ); 

									//logger.dbg.println(this,"InsertSql_mu1"+InsertSql_mu1.toString());

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
         			
        
        /***********************************************************
					잔액관련 필드 모두 0 으로 셋팅함.
				************************************************************/
				
        String  sql9 = " UPDATE  ACCOUNT.TOTALBAL SET "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0,FODEUPCASH =0,FOCRUPCASH=0 "
										 + "  WHERE  (FODEUPTOT !=0 OR FOCRUPTOT !=0 OR FODEUPCASH !=0 OR FOCRUPCASH!=0) "
										 + "    AND  SUBSTR(ACTDAT,1,6)='"+strYYMM+"'"   
										 + "    AND  FDCODE IN ('"+strFDCODE+"')" ;
										
				GauceStatement gsmt9 = conn.getGauceStatement(sql9);
				gsmt9.executeUpdate();
				gsmt9.close();
				
        
        String  sql92 = " UPDATE  ACCOUNT.MTOTALBAL SET "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0,FODEUPCASH =0,FOCRUPCASH=0 "
										 + "  WHERE  (FODEUPTOT !=0 OR FOCRUPTOT !=0 OR FODEUPCASH !=0 OR FOCRUPCASH!=0) "
										 + "    AND  ACTYYMM='"+strYYMM+"'"
										 + "    AND  FDCODE IN ('"+strFDCODE+"')" ;
										
				GauceStatement gsmt92 = conn.getGauceStatement(sql92);
				gsmt92.executeUpdate();
				gsmt92.close();


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