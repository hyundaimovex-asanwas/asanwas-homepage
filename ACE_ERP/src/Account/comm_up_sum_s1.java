package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class comm_up_sum_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

      int strlevel = 0;
			String strGubun_1 ="";
			String [] str = new String [6];
			double [] dbl = new double [8];
      double [] dbl2 = new double [8];
			double [] dbl_sum = new double [8];
			
      String [] str3 = new String [8];
			double [] dbl3 = new double [4];
			double [] dbl4 = new double [4];
			double [] dbl_sum3 = new double [4];
			
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

        logger.dbg.println(this,"start");
        
				for (int j=5;j>4;j--){
        
					logger.dbg.println(this,"j::"+j);
					//변수 초기화
					for (int s=0;s<=5;s++) {
							str[s] = "";
					}

					for (int s=0;s<=7;s++) {
							dbl[s] = 0;
							dbl2[s] = 0;
							dbl_sum[s] = 0;
							str3[s] = "";
					}

					for (int s=0;s<=3;s++) {
							dbl3[s] = 0;
							dbl4[s] = 0;
							dbl_sum3[s] = 0;
					}

					/************************************************************************************
					 @ 합계잔액(일별)
					*************************************************************************************/
					StringBuffer sql_d = new StringBuffer();
					Statement stmt_d = null;
					ResultSet rs_d = null;
					
					//int temp = Integer.parseInt(strFsnbr);
					strlevel = j;

					logger.dbg.println(this,"합계잔액");
     
					sql_d.append( " SELECT A.FDCODE,  A.ACTDAT, B.ATUPCODE, A.COCODE, A.DIVCD,  ");
					sql_d.append( "        A.DEPTCD,                                            ");
					sql_d.append( "        SUM(A.DETOT)    AS DETOT,                            ");
					sql_d.append( "        SUM(A.CRTOT)    AS CRTOT,                          ");
					sql_d.append( "        SUM(A.DECASH)   AS DECASH,                       ");
					sql_d.append( "        SUM(A.CRCASH)   AS CRCASH,                       ");
					sql_d.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                      ");
					sql_d.append( "        SUM(A.CRUPTOT)  AS CRUPTOT,                      ");
					sql_d.append( "        SUM(A.DEUPCASH) AS DEUPCASH,                     ");
					sql_d.append( "        SUM(A.CRUPCASH) AS CRUPCASH                      ");
					sql_d.append( "   FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B           ");
					sql_d.append( "  WHERE A.ATCODE = B.ATCODE                            ");
					sql_d.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0                  ");
					sql_d.append( "     OR A.DEUPCASH <> 0 OR A.CRUPCASH <> 0)                ");
					sql_d.append( "    AND SUMLEVEL ='"+strlevel+"'                              ");
					sql_d.append( "  GROUP BY A.FDCODE, A.ACTDAT, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD");
					
					stmt_d = conn.createStatement();
					rs_d = stmt_d.executeQuery(sql_d.toString());

          //logger.dbg.println(this,"합계잔액2");
					while(rs_d.next())	{
						
						str[0]=rs_d.getString(1);  //FDCODE
						str[1]=rs_d.getString(2);  //ACTDAT
						str[2]=rs_d.getString(3);  //ATUPCODE
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

            //logger.dbg.println(this,"합계잔액3");
						if(dbl[4]+dbl[5]+dbl[6]+dbl[7]!=0){
             // logger.dbg.println(this,"합계잔액33");
							StringBuffer sql_u1 = new StringBuffer();
							Statement stmt_u1 = null;
							ResultSet rs_u1 = null;
							
							sql_u1.append( " SELECT DETOT, CRTOT, DECASH, CRCASH, DEUPTOT, CRUPTOT, DEUPCASH, CRUPCASH ");
							sql_u1.append( "   FROM ACCOUNT.TOTALBAL     	");
							sql_u1.append( "  WHERE FDCODE ='"+str[0]+"'  ");
							sql_u1.append( "    AND ACTDAT ='"+str[1]+"'  ");
							sql_u1.append( "    AND ATCODE ='"+str[2]+"'  ");
							sql_u1.append( "    AND COCODE ='"+str[3]+"'  ");
							sql_u1.append( "    AND DIVCD  ='"+str[4]+"'  ");
							sql_u1.append( "    AND DEPTCD ='"+str[5]+"'  ");

							//logger.dbg.println(this,sql_u1.toString());
							
							stmt_u1 = conn.createStatement();
							rs_u1 = stmt_u1.executeQuery(sql_u1.toString());

							if(!rs_u1.equals(null)){                         //update 
								while(rs_u1.next())	{
									//logger.dbg.println(this,"합계잔액4");
									dbl2[0]=rs_u1.getDouble(1);
									dbl2[1]=rs_u1.getDouble(2);
									dbl2[2]=rs_u1.getDouble(3);
									dbl2[3]=rs_u1.getDouble(4);
									dbl2[4]=rs_u1.getDouble(5);
									dbl2[5]=rs_u1.getDouble(6);
									dbl2[6]=rs_u1.getDouble(7);
									dbl2[7]=rs_u1.getDouble(8);
									
                  //기존금액 Sum
                  dbl_sum[0] = dbl[4] + dbl2[0];
									dbl_sum[1] = dbl[5] + dbl2[1];
									dbl_sum[2] = dbl[6] + dbl2[2];
									dbl_sum[3] = dbl[7] + dbl2[3];
									dbl_sum[4] = dbl[4] ;
									dbl_sum[5] = dbl[5] ;
									dbl_sum[6] = dbl[6] ;
                  dbl_sum[7] = dbl[7] ;


									//logger.dbg.println(this,"합계잔액5");

								  //Update
                  StringBuffer UpdateSql_u1 = null;
				          UpdateSql_u1 = new StringBuffer();
									UpdateSql_u1.append( " UPDATE ACCOUNT.TOTALBAL SET " );
									UpdateSql_u1.append( "        DETOT = "+dbl_sum[0]+"," );
									UpdateSql_u1.append( "        CRTOT = "+dbl_sum[1]+"," );
									UpdateSql_u1.append( "        DECASH ="+dbl_sum[2]+"," );
									UpdateSql_u1.append( "        CRCASH= "+dbl_sum[3]+"," );
									UpdateSql_u1.append( "        DEUPTOT = "+dbl_sum[4]+"," );
									UpdateSql_u1.append( "        CRUPTOT = "+dbl_sum[5]+"," );
									UpdateSql_u1.append( "        DEUPCASH ="+dbl_sum[6]+"," );
									UpdateSql_u1.append( "        CRUPCASH= "+dbl_sum[7]+"" );
									UpdateSql_u1.append( "  WHERE FDCODE='"+str[0]+"'" );
									UpdateSql_u1.append( "    AND ACTDAT='"+str[1]+"'" );
									UpdateSql_u1.append( "    AND ATCODE='"+str[2]+"'" );
									UpdateSql_u1.append( "    AND COCODE='"+str[3]+"'" );
									UpdateSql_u1.append( "    AND DIVCD='"+str[4]+"'" );
									UpdateSql_u1.append( "    AND DEPTCD='"+str[5]+"'" );

									GauceStatement gsmt_u1 = conn.getGauceStatement(UpdateSql_u1.toString());
									gsmt_u1.executeUpdate();
									gsmt_u1.close();	
								}//while rs_u1
							}else{                 //Insert
								
								logger.dbg.println(this,"합계잔액6");
								//합계잔액(일별)
								StringBuffer InsertSql_u1 = null;
				        InsertSql_u1 = new StringBuffer();
								InsertSql_u1.append( " INSERT INTO ACCOUNT.TOTALBAL (" );
								InsertSql_u1.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD," );
								InsertSql_u1.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH," );
								InsertSql_u1.append( " DEUPTOT, CRUPTOT, DEUPCASH,  CRUPCASH  " );
								InsertSql_u1.append( "  ) " );
								InsertSql_u1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+str[2]+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
								InsertSql_u1.append( " "+dbl[0]+","+dbl[1]+","+dbl[2]+","+dbl[3]+","+dbl[4]+","+dbl[5]+","+dbl[6]+","+dbl[7]+")" ); 

								GauceStatement gsmt_u1 = conn.getGauceStatement(InsertSql_u1.toString());
								gsmt_u1.executeUpdate();
								gsmt_u1.close();	
							}//if rs_u1
						
						 //logger.dbg.println(this,"합계잔액7");
						} //dbl[4]+dbl[5]+dbl[6]+dbl[7]!
             
            //logger.dbg.println(this,"합계잔액8");
					}//while rs_d


				/************************************************************************************
				 @ 관리항목집계(일별)
				*************************************************************************************/
				  StringBuffer sql_u2 = new StringBuffer();
					Statement stmt_u2 = null;
					ResultSet rs_u2 = null;
					logger.dbg.println(this,"관리항목집계1");
					sql_u2.append( " SELECT A.FDCODE,  A.ACTDAT, B.ATUPCODE, A.COCODE, A.DIVCD, ");
					sql_u2.append( "        A.DEPTCD,  A.FSREFCD, A.FSREFVAL,                   ");
					sql_u2.append( "        SUM(A.DETOT)    AS DETOT,                           ");
					sql_u2.append( "        SUM(A.CRTOT)    AS CRTOT,                           ");
					sql_u2.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                         ");
					sql_u2.append( "        SUM(A.CRUPTOT)  AS CRUPTOT                          ");
					sql_u2.append( "   FROM ACCOUNT.FSREFTOT A,ACCOUNT.ACTCODE B                ");
					sql_u2.append( "  WHERE A.ATCODE = B.ATCODE                                 ");
					sql_u2.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0)                  ");
					sql_u2.append( "    AND SUMLEVEL ='"+strlevel+"'                            ");
					sql_u2.append( "  GROUP BY A.FDCODE, A.ACTDAT, B.ATUPCODE, A.COCODE,A.DIVCD,");
					sql_u2.append( "           A.DEPTCD,A.FSREFCD, A.FSREFVAL                   ");
			
			    //logger.dbg.println(this,"sql_u2" + sql_u2.toString());
					stmt_u2 = conn.createStatement();
					rs_u2 = stmt_u2.executeQuery(sql_u2.toString());
				  //logger.dbg.println(this,"관리항목집계2");
					while(rs_u2.next())	{
	         // logger.dbg.println(this,"관리항목집계22");					
  
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

						//logger.dbg.println(this,"관리항목집계3");

						if(dbl3[2]+dbl3[3]!=0){

							StringBuffer sql_u3 = new StringBuffer();
							Statement stmt_u3 = null;
							ResultSet rs_u3 = null;

							//logger.dbg.println(this,"관리항목집계4");
							
							sql_u3.append( " SELECT DETOT, CRTOT, DEUPTOT, CRUPTOT  ");
							sql_u3.append( "   FROM ACCOUNT.FSREFTOT     	");
							sql_u3.append( "  WHERE FDCODE ='"+str3[0]+"'  ");
							sql_u3.append( "    AND ACTDAT ='"+str3[1]+"'  ");
							sql_u3.append( "    AND ATCODE ='"+str3[2]+"'  ");
							sql_u3.append( "    AND COCODE ='"+str3[3]+"'  ");
							sql_u3.append( "    AND DIVCD  ='"+str3[4]+"'  ");
							sql_u3.append( "    AND DEPTCD ='"+str3[5]+"'  ");
							sql_u3.append( "    AND FSREFCD  ='"+str3[6]+"'  ");
							sql_u3.append( "    AND FSREFVAL ='"+str3[7]+"'  ");

							//logger.dbg.println(this,"sql_u3" + sql_u3.toString());
							
							stmt_u3 = conn.createStatement();
							rs_u3 = stmt_u3.executeQuery(sql_u3.toString());

							if(!rs_u3.equals(null)){                         //update 
								while(rs_u3.next())	{
									//logger.dbg.println(this,"관리항목집계5");
									dbl4[0]=rs_u3.getDouble(1);
									dbl4[1]=rs_u3.getDouble(2);
									dbl4[2]=rs_u3.getDouble(3);
									dbl4[3]=rs_u3.getDouble(4);
									
                  //기존금액 Sum
                  dbl_sum3[0] = dbl3[0] + dbl4[0];
									dbl_sum3[1] = dbl3[1] + dbl4[1];
									dbl_sum3[2] = dbl3[0];
									dbl_sum3[3] = dbl3[1];

								  //Update
                  StringBuffer UpdateSql_u3 = null;
				          UpdateSql_u3 = new StringBuffer();
									UpdateSql_u3.append( " UPDATE ACCOUNT.FSREFTOT SET " );
									UpdateSql_u3.append( "        DETOT = "+dbl_sum3[0]+"," );
									UpdateSql_u3.append( "        CRTOT = "+dbl_sum3[1]+"," );
									UpdateSql_u3.append( "        DEUPTOT = "+dbl_sum3[2]+"," );
									UpdateSql_u3.append( "        CRUPTOT = "+dbl_sum3[3]+"" );
									UpdateSql_u3.append( "  WHERE FDCODE='"+str3[0]+"'" );
									UpdateSql_u3.append( "    AND ACTDAT='"+str3[1]+"'" );
									UpdateSql_u3.append( "    AND ATCODE='"+str3[2]+"'" );
									UpdateSql_u3.append( "    AND COCODE='"+str3[3]+"'" );
									UpdateSql_u3.append( "    AND DIVCD='"+str3[4]+"'" );
									UpdateSql_u3.append( "    AND DEPTCD='"+str3[5]+"'" );
									UpdateSql_u3.append( "    AND FSREFCD='"+str3[6]+"'" );
									UpdateSql_u3.append( "    AND FSREFVAL='"+str3[7]+"'" );

                   //logger.dbg.println(this,"UpdateSql_u3" + UpdateSql_u3.toString());


									GauceStatement gsmt_u3 = conn.getGauceStatement(UpdateSql_u3.toString());
									gsmt_u3.executeUpdate();
									gsmt_u3.close();	
								}//while rs_u1
							}else{                 //Insert
								
								 logger.dbg.println(this,"관리항목집계6");
								//관리항목집계(일별)
									StringBuffer InsertSql_u3 = null;
									InsertSql_u3 = new StringBuffer();
									InsertSql_u3.append( " INSERT INTO ACCOUNT.FSREFTOT (" );
									InsertSql_u3.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD," );
									InsertSql_u3.append( " DEPTCD,  FSREFCD, FSREFVAL , DETOT,  CRTOT," );
									InsertSql_u3.append( " DEUPTOT,  CRUPTOT" );
									InsertSql_u3.append( "  ) " );
									InsertSql_u3.append( " VALUES ( '"+str3[0]+"','"+str3[1]+"','"+str3[2]+"','"+str3[3]+"','"+str3[4]+"','"+str3[5]+"', " ); 
									InsertSql_u3.append( " '"+str3[6]+"','"+str3[7]+"',"+dbl3[0]+","+dbl3[1]+","+dbl3[0]+","+dbl3[1]+")" ); 
									
									//logger.dbg.println(this,"InsertSql_u3" + InsertSql_u3.toString());
									GauceStatement gsmt_u3 = conn.getGauceStatement(InsertSql_u3.toString());
									gsmt_u3.executeUpdate();
									gsmt_u3.close();
							}//if rs_u1
						}
					}//while rs_d

          //=======================================================================
					//변수 초기화
					//=======================================================================
					//변수 초기화
					for (int s=0;s<=5;s++) {
							str[s] = "";
					}

					for (int s=0;s<=7;s++) {
							dbl[s] = 0;
							dbl2[s] = 0;
							dbl_sum[s] = 0;
							str3[s] = "";
					}

					for (int s=0;s<=3;s++) {
							dbl3[s] = 0;
							dbl4[s] = 0;
							dbl_sum3[s] = 0;
					}

				
				
				 /************************************************************************************
					 @ 합계잔액(월별)
					*************************************************************************************/
					StringBuffer sql_md = new StringBuffer();
					Statement stmt_md = null;
					ResultSet rs_md = null;

					 //logger.dbg.println(this,"월별합계잔액1");

					sql_md.append( " SELECT A.FDCODE,  A.ACTYYMM, B.ATUPCODE, A.COCODE, A.DIVCD,  ");
					sql_md.append( "        A.DEPTCD,                                            ");
					sql_md.append( "        SUM(A.DETOT)    AS DETOT,                            ");
					sql_md.append( "        SUM(A.CRTOT)    AS CRTOT,                          ");
					sql_md.append( "        SUM(A.DECASH)   AS DECASH,                       ");
					sql_md.append( "        SUM(A.CRCASH)   AS CRCASH,                       ");
					sql_md.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                      ");
					sql_md.append( "        SUM(A.CRUPTOT)  AS CRUPTOT,                      ");
					sql_md.append( "        SUM(A.DEUPCASH) AS DEUPCASH,                     ");
					sql_md.append( "        SUM(A.CRUPCASH) AS CRUPCASH                      ");
					sql_md.append( "   FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B           ");
					sql_md.append( "  WHERE A.ATCODE = B.ATCODE                            ");
					sql_md.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0                  ");
					sql_md.append( "     OR A.DEUPCASH <> 0 OR A.CRUPCASH <> 0)                ");
					sql_md.append( "    AND SUMLEVEL ='"+strlevel+"'                              ");
					sql_md.append( "  GROUP BY A.FDCODE, A.ACTYYMM, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD");
					
				 
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

						dbl[0]=rs_md.getDouble(7);
						dbl[1]=rs_md.getDouble(8);
						dbl[2]=rs_md.getDouble(9);
						dbl[3]=rs_md.getDouble(10);
						dbl[4]=rs_md.getDouble(11);
						dbl[5]=rs_md.getDouble(12);
						dbl[6]=rs_md.getDouble(13);
						dbl[7]=rs_md.getDouble(14);

						if(dbl[4]+dbl[5]+dbl[6]+dbl[7]!=0){
              // logger.dbg.println(this,"월별합계잔액3");

							StringBuffer sql_mu1 = new StringBuffer();
							Statement stmt_mu1 = null;
							ResultSet rs_mu1 = null;
							
							sql_mu1.append( " SELECT DETOT, CRTOT, DECASH, CRCASH, DEUPTOT, CRUPTOT, DEUPCASH, CRUPCASH  ");
							sql_mu1.append( "   FROM ACCOUNT.MTOTALBAL     	");
							sql_mu1.append( "  WHERE FDCODE ='"+str[0]+"'  ");
							sql_mu1.append( "    AND ACTYYMM ='"+str[1]+"'  ");
							sql_mu1.append( "    AND ATCODE ='"+str[2]+"'  ");
							sql_mu1.append( "    AND COCODE ='"+str[3]+"'  ");
							sql_mu1.append( "    AND DIVCD  ='"+str[4]+"'  ");
							sql_mu1.append( "    AND DEPTCD ='"+str[5]+"'  ");
							stmt_mu1 = conn.createStatement();
							rs_mu1 = stmt_mu1.executeQuery(sql_mu1.toString());

							if(!rs_mu1.equals(null)){                         //update 
								while(rs_mu1.next())	{
									//logger.dbg.println(this,"월별합계잔액4");

									dbl2[0]=rs_mu1.getDouble(1);
									dbl2[1]=rs_mu1.getDouble(2);
									dbl2[2]=rs_mu1.getDouble(3);
									dbl2[3]=rs_mu1.getDouble(4);
									dbl2[4]=rs_mu1.getDouble(5);
									dbl2[5]=rs_mu1.getDouble(6);
									dbl2[6]=rs_mu1.getDouble(7);
									dbl2[7]=rs_mu1.getDouble(8);
									
                  //기존금액 Sum
                  dbl_sum[0] = dbl[4] + dbl2[0];
									dbl_sum[1] = dbl[5] + dbl2[1];
									dbl_sum[2] = dbl[6] + dbl2[2];
									dbl_sum[3] = dbl[7] + dbl2[3];
									dbl_sum[4] = dbl[4] ;
									dbl_sum[5] = dbl[5] ;
									dbl_sum[6] = dbl[6] ;
                  dbl_sum[7] = dbl[7] ;

								  //Update
                  StringBuffer UpdateSql_mu1 = null;
				          UpdateSql_mu1 = new StringBuffer();
									UpdateSql_mu1.append( " UPDATE ACCOUNT.MTOTALBAL SET " );
									UpdateSql_mu1.append( "        DETOT = "+dbl_sum[0]+"," );
									UpdateSql_mu1.append( "        CRTOT = "+dbl_sum[1]+"," );
									UpdateSql_mu1.append( "        DECASH ="+dbl_sum[2]+"," );
									UpdateSql_mu1.append( "        CRCASH= "+dbl_sum[3]+"," );
									UpdateSql_mu1.append( "        DEUPTOT = "+dbl_sum[4]+"," );
									UpdateSql_mu1.append( "        CRUPTOT = "+dbl_sum[5]+"," );
									UpdateSql_mu1.append( "        DEUPCASH ="+dbl_sum[6]+"," );
									UpdateSql_mu1.append( "        CRUPCASH= "+dbl_sum[7]+"" );
									UpdateSql_mu1.append( "  WHERE FDCODE='"+str[0]+"'" );
									UpdateSql_mu1.append( "    AND ACTYYMM='"+str[1]+"'" );
									UpdateSql_mu1.append( "    AND ATCODE='"+str[2]+"'" );
									UpdateSql_mu1.append( "    AND COCODE='"+str[3]+"'" );
									UpdateSql_mu1.append( "    AND DIVCD='"+str[4]+"'" );
									UpdateSql_mu1.append( "    AND DEPTCD='"+str[5]+"'" );
                  
									 //logger.dbg.println(this,"월별합계잔액5");

									GauceStatement gsmt_mu1 = conn.getGauceStatement(UpdateSql_mu1.toString());
									gsmt_mu1.executeUpdate();
									gsmt_mu1.close();	
								}//while rs_u1
							}else{                 //Insert
								
								//합계잔액(일별)
								 //logger.dbg.println(this,"월별합계잔액6");

								StringBuffer InsertSql_mu1 = null;
				        InsertSql_mu1 = new StringBuffer();
								InsertSql_mu1.append( " INSERT INTO ACCOUNT.MTOTALBAL (" );
								InsertSql_mu1.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD," );
								InsertSql_mu1.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH," );
								InsertSql_mu1.append( " DEUPTOT, CRUPTOT, DEUPCASH,  CRUPCASH  " );
								InsertSql_mu1.append( "  ) " );
								InsertSql_mu1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+str[2]+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
								InsertSql_mu1.append( " "+dbl[0]+","+dbl[1]+","+dbl[2]+","+dbl[3]+","+dbl[4]+","+dbl[5]+","+dbl[6]+","+dbl[7]+")" ); 

                // logger.dbg.println(this,"InsertSql_mu1"+InsertSql_mu1.toString());

								GauceStatement gsmt_mu1 = conn.getGauceStatement(InsertSql_mu1.toString());
								gsmt_mu1.executeUpdate();
								gsmt_mu1.close();	
							}//if rs_u1
						}
					}//while rs_d


				/************************************************************************************
				 @ 관리항목집계(월별)
				*************************************************************************************/
				  StringBuffer sql_mu2 = new StringBuffer();
					Statement stmt_mu2 = null;
					ResultSet rs_mu2 = null;
					
					logger.dbg.println(this,"월별관리항목집계1");
					sql_mu2.append( " SELECT A.FDCODE,  A.ACTYYMM, B.ATUPCODE, A.COCODE, A.DIVCD, ");
					sql_mu2.append( "        A.DEPTCD,  A.FSREFCD, A.FSREFVAL,                   ");
					sql_mu2.append( "        SUM(A.DETOT)    AS DETOT,                           ");
					sql_mu2.append( "        SUM(A.CRTOT)    AS CRTOT,                           ");
					sql_mu2.append( "        SUM(A.DEUPTOT)  AS DEUPTOT,                         ");
					sql_mu2.append( "        SUM(A.CRUPTOT)  AS CRUPTOT                          ");
					sql_mu2.append( "   FROM ACCOUNT.MFSREFTOT A,ACCOUNT.ACTCODE B                ");
					sql_mu2.append( "  WHERE A.ATCODE = B.ATCODE                                 ");
					sql_mu2.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0)                  ");
					sql_mu2.append( "    AND SUMLEVEL ='"+strlevel+"'                            ");
					sql_mu2.append( "  GROUP BY A.FDCODE, A.ACTYYMM, B.ATUPCODE, A.COCODE,A.DIVCD,");
					sql_mu2.append( "           A.DEPTCD,A.FSREFCD, A.FSREFVAL                   ");
			
			    //logger.dbg.println(this,"sql_mu2"+sql_mu2.toString());
					stmt_mu2 = conn.createStatement();
					rs_mu2 = stmt_mu2.executeQuery(sql_mu2.toString());
				
					while(rs_mu2.next())	{
						//logger.dbg.println(this,"월별관리항목집계2");
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
             
          
						if(dbl3[2]+dbl3[3]!=0){
              //logger.dbg.println(this,"월별관리항목집계222");
							StringBuffer sql_mu3 = new StringBuffer();
							Statement stmt_mu3 = null;
							ResultSet rs_mu3 = null;
							
							sql_mu3.append( " SELECT DETOT, CRTOT, DEUPTOT, CRUPTOT  ");
							sql_mu3.append( "   FROM ACCOUNT.MFSREFTOT     	");
							sql_mu3.append( "  WHERE FDCODE ='"+str3[0]+"'  ");
							sql_mu3.append( "    AND ACTYYMM ='"+str3[1]+"'  ");
							sql_mu3.append( "    AND ATCODE ='"+str3[2]+"'  ");
							sql_mu3.append( "    AND COCODE ='"+str3[3]+"'  ");
							sql_mu3.append( "    AND DIVCD  ='"+str3[4]+"'  ");
							sql_mu3.append( "    AND DEPTCD ='"+str3[5]+"'  ");
							sql_mu3.append( "    AND FSREFCD  ='"+str3[6]+"'  ");
							sql_mu3.append( "    AND FSREFVAL ='"+str3[7]+"'  ");

							//logger.dbg.println(this,"sql_mu3"+sql_mu3.toString());
							stmt_mu3 = conn.createStatement();
							rs_mu3 = stmt_mu3.executeQuery(sql_mu3.toString());

							if(!rs_mu3.equals(null)){                         //update 
								while(rs_mu3.next())	{
									//logger.dbg.println(this,"월별관리항목집계333");
									dbl4[0]=rs_mu3.getDouble(1);
									dbl4[1]=rs_mu3.getDouble(2);
									dbl4[2]=rs_mu3.getDouble(3);
									dbl4[3]=rs_mu3.getDouble(4);
									
                  //기존금액 Sum
                  dbl_sum3[0] = dbl3[0] + dbl4[0];
									dbl_sum3[1] = dbl3[1] + dbl4[1];
									dbl_sum3[2] = dbl3[0];
									dbl_sum3[3] = dbl3[1];
                  //logger.dbg.println(this,"월별관리항목집계444");
								  //Update
                  StringBuffer UpdateSql_mu3 = null;
				          UpdateSql_mu3 = new StringBuffer();
									UpdateSql_mu3.append( " UPDATE ACCOUNT.MFSREFTOT SET " );
									UpdateSql_mu3.append( "        DETOT = "+dbl_sum3[0]+"," );
									UpdateSql_mu3.append( "        CRTOT = "+dbl_sum3[1]+"," );
									UpdateSql_mu3.append( "        DEUPTOT = "+dbl_sum3[2]+"," );
									UpdateSql_mu3.append( "        CRUPTOT = "+dbl_sum3[3]+"" );
									UpdateSql_mu3.append( "  WHERE FDCODE='"+str3[0]+"'" );
									UpdateSql_mu3.append( "    AND ACTYYMM='"+str3[1]+"'" );
									UpdateSql_mu3.append( "    AND ATCODE='"+str3[2]+"'" );
									UpdateSql_mu3.append( "    AND COCODE='"+str3[3]+"'" );
									UpdateSql_mu3.append( "    AND DIVCD='"+str3[4]+"'" );
									UpdateSql_mu3.append( "    AND DEPTCD='"+str3[5]+"'" );
									UpdateSql_mu3.append( "    AND FSREFCD='"+str3[6]+"'" );
									UpdateSql_mu3.append( "    AND FSREFVAL='"+str3[7]+"'" );

									//logger.dbg.println(this,"UpdateSql_mu3"+UpdateSql_mu3.toString());

									GauceStatement gsmt_mu3 = conn.getGauceStatement(UpdateSql_mu3.toString());
									gsmt_mu3.executeUpdate();
									gsmt_mu3.close();	
								}//while rs_u1
							}else{                 //Insert
								
								//관리항목집계(월별)
									//logger.dbg.println(this,"월별관리항목집계555");
									StringBuffer InsertSql_mu3 = null;
									InsertSql_mu3 = new StringBuffer();
									InsertSql_mu3.append( " INSERT INTO ACCOUNT.MFSREFTOT (" );
									InsertSql_mu3.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD," );
									InsertSql_mu3.append( " DEPTCD,  FSREFCD, FSREFVAL , DETOT,  CRTOT," );
									InsertSql_mu3.append( " DEUPTOT,  CRUPTOT" );
									InsertSql_mu3.append( "  ) " );
									InsertSql_mu3.append( " VALUES ( '"+str3[0]+"','"+str3[1]+"','"+str3[2]+"','"+str3[3]+"','"+str3[4]+"','"+str3[5]+"', " ); 
									InsertSql_mu3.append( " '"+str3[6]+"','"+str3[7]+"',"+dbl3[0]+","+dbl3[1]+","+dbl3[0]+","+dbl3[1]+")" ); 
									
									//logger.dbg.println(this,"InsertSql_mu3"+InsertSql_mu3.toString());
									GauceStatement gsmt_mu3 = conn.getGauceStatement(InsertSql_mu3.toString());
									gsmt_mu3.executeUpdate();
									gsmt_mu3.close();
							}//if rs_u1

						} //if rs_mu3

					}//while rs_d
				  logger.dbg.println(this,"end j::"+ j);
				}//for j

       logger.dbg.println(this,"END");
				//update 
        
			} catch(Exception e) {
				 logger.dbg.println(this,"Catch");
		  	logger.err.println(this,e);
				conn.rollback();
		
		  } finally {
				 logger.dbg.println(this,"finally");
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

      //logger.dbg.println(this,"commit");
			conn.commit();
			//logger.dbg.println(this,"flush");
		  dSet.flush();
      //logger.dbg.println(this,"GauceRes.commit");
		  GauceRes.commit();
			//logger.dbg.println(this,"GauceRes.close");
		  GauceRes.close();

		} catch (Exception e) {

			//logger.dbg.println(this,"Exception");
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			//logger.dbg.println(this,"finally");
			//loader.restoreService(service);
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
  	}
	}
}