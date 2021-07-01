package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class comm_upatcode_t1 extends HttpServlet{
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

			int strlevel = 0;
			String strGubun_1 ="0";
			String strGubun_2 ="0";
      
			//�հ��ܾ�
			String [] str = new String [6];
			
			//��ȭ
			double [] dbl = new double [10];
      double [] dbl2 = new double [10];
			double [] dbl_sum = new double [10];
	     		
      //��ȭ
			double [] dbl_fo = new double [10];
      double [] dbl2_fo = new double [10];
			double [] dbl_sum_fo = new double [10];

			//�����׸�����
      String [] str3 = new String [8];
			double [] dbl3 = new double [4];
			double [] dbl4 = new double [4];
			double [] dbl_sum3 = new double [4];

			//��ȭ
			double [] dbl3_fo = new double [4];
			double [] dbl4_fo = new double [4];
			double [] dbl_sum3_fo = new double [4];


			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

        /************************************************************************************
         @ �Ϻ��հ��ܾ� / �Ϻ������׸����� / �����հ��ܾ� / ���������׸�����
         //���ݵ���� ��� ���� ���� ���� ��.==>���� �ʵ� ����.
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				//logger.dbg.println(this,"start");
        
				for (int j=5;j>1;j--){
        
					///logger.dbg.println(this,"j::"+j);
					//���� �ʱ�ȭ
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
					 @ �հ��ܾ�(�Ϻ�)
					*************************************************************************************/
					//logger.dbg.println(this,"�Ϻ��հ��ܾ�");
					StringBuffer sql_d = new StringBuffer();
					Statement stmt_d = null;
					ResultSet rs_d = null;

					strlevel = j;

					///logger.dbg.println(this,"�հ��ܾ�");
          //�����ݾ� ����
					sql_d.append( " SELECT A.FDCODE,  A.ACTDAT, B.ATUPCODE, A.COCODE, A.DIVCD,  ");
					sql_d.append( "        A.DEPTCD,                                            ");
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
					
					sql_d.append( "   FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B             ");
					sql_d.append( "  WHERE A.ATCODE = B.ATCODE                              ");
					sql_d.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0                  ");
					sql_d.append( "     OR A.DEUPCASH <> 0 OR A.CRUPCASH <> 0)                ");
					sql_d.append( "    AND B.SUMLEVEL ='"+strlevel+"'                         ");
					sql_d.append( "  GROUP BY A.FDCODE, A.ACTDAT, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD");
					
					///logger.dbg.println(this,"sql_d" +sql_d.toString() );
					stmt_d = conn.createStatement();
					rs_d = stmt_d.executeQuery(sql_d.toString());

          ///logger.dbg.println(this,"getRow" +rs_d.getRow() ); 
					
          ///logger.dbg.println(this,"�հ��ܾ�2");
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

            ///logger.dbg.println(this,"�հ��ܾ�3");
						if(dbl[4]+dbl[5]+dbl[6]+dbl[7]!=0){
             // logger.dbg.println(this,"�հ��ܾ�33");
							StringBuffer sql_u1 = new StringBuffer();
							Statement stmt_u1 = null;
							ResultSet rs_u1 = null;
							
							sql_u1.append( " SELECT DETOT,  CRTOT,  DECASH,  CRCASH,  DEUPTOT,  CRUPTOT,  DEUPCASH,  CRUPCASH,  EDECASH,  ECRCASH, ");
							sql_u1.append( "        FODETOT,FOCRTOT,FODECASH,FOCRCASH,FODEUPTOT,FOCRUPTOT,FODEUPCASH,FOCRUPCASH,FOEDECASH,FOECRCASH ");
							sql_u1.append( "   FROM ACCOUNT.TOTALBAL     	");
							sql_u1.append( "  WHERE FDCODE ='"+str[0]+"'  ");
							sql_u1.append( "    AND ACTDAT ='"+str[1]+"'  ");
							sql_u1.append( "    AND ATCODE ='"+str[2]+"'  ");
							sql_u1.append( "    AND COCODE ='"+str[3]+"'  ");
							sql_u1.append( "    AND DIVCD  ='"+str[4]+"'  ");
							sql_u1.append( "    AND DEPTCD ='"+str[5]+"'  ");

							///logger.dbg.println(this,sql_u1.toString());
							
							stmt_u1 = conn.createStatement();
							rs_u1 = stmt_u1.executeQuery(sql_u1.toString());

						  strGubun_1="0";
							while(rs_u1.next())	{
								//logger.dbg.println(this,"�հ��ܾ�4");
								strGubun_1="1";
								//��ȭ
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
                
								//��ȭ
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

								//�����ݾ� Sum
								//��ȭ
								dbl_sum[0] = dbl[4] + dbl2[0];     
								dbl_sum[1] = dbl[5] + dbl2[1];
								dbl_sum[2] = dbl[6] + dbl2[2];
								dbl_sum[3] = dbl[7] + dbl2[3];

								dbl_sum[4] = dbl[4];
								dbl_sum[5] = dbl[5];
								dbl_sum[6] = dbl[6];
								dbl_sum[7] = dbl[7];

                //��ȭ
								dbl_sum_fo[0] = dbl_fo[4] + dbl2_fo[0];     
								dbl_sum_fo[1] = dbl_fo[5] + dbl2_fo[1];
								dbl_sum_fo[2] = dbl_fo[6] + dbl2_fo[2];
								dbl_sum_fo[3] = dbl_fo[7] + dbl2_fo[3];

								dbl_sum_fo[4] = dbl_fo[4];
								dbl_sum_fo[5] = dbl_fo[5];
								dbl_sum_fo[6] = dbl_fo[6];
								dbl_sum_fo[7] = dbl_fo[7];

								//logger.dbg.println(this,"�հ��ܾ�5");

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
								UpdateSql_u1.append( "        CRUPCASH= "+dbl_sum[7]+"," );
                
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
								UpdateSql_u1.append( "    AND ATCODE='"+str[2]+"'" );
								UpdateSql_u1.append( "    AND COCODE='"+str[3]+"'" );
								UpdateSql_u1.append( "    AND DIVCD='"+str[4]+"'" );
								UpdateSql_u1.append( "    AND DEPTCD='"+str[5]+"'" );


								//logger.dbg.println(this,"UpdateSql_u1"+UpdateSql_u1.toString());
								GauceStatement gsmt_u1 = conn.getGauceStatement(UpdateSql_u1.toString());
								gsmt_u1.executeUpdate();
								gsmt_u1.close();	
							}//while rs_u1

							if(strGubun_1.equals("0")){  //Insert 
							            
								//logger.dbg.println(this,"�հ��ܾ�6");
								///�հ��ܾ�(�Ϻ�)
								StringBuffer InsertSql_u1 = null;
				        InsertSql_u1 = new StringBuffer();
								InsertSql_u1.append( " INSERT INTO ACCOUNT.TOTALBAL (" );
								InsertSql_u1.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD," );
								InsertSql_u1.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH," );
								InsertSql_u1.append( " DEUPTOT, CRUPTOT, DEUPCASH,  CRUPCASH,  " );
								InsertSql_u1.append( " FODETOT,   FOCRTOT,   FODECASH,   FOCRCASH,  " );
								InsertSql_u1.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH  " );
								InsertSql_u1.append( "  ) " );
								InsertSql_u1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+str[2]+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
								InsertSql_u1.append( " "+dbl[0]+","+dbl[1]+","+dbl[2]+","+dbl[3]+","+dbl[4]+","+dbl[5]+","+dbl[6]+","+dbl[7]+"," ); 
								InsertSql_u1.append( " "+dbl_fo[0]+","+dbl_fo[1]+","+dbl_fo[2]+","+dbl_fo[3]+"," );
								InsertSql_u1.append( " "+dbl_fo[4]+","+dbl_fo[5]+","+dbl_fo[6]+","+dbl_fo[7]+")" ); 

                //logger.dbg.println(this,"InsertSql_u1"+InsertSql_u1.toString());
								GauceStatement gsmt_u1 = conn.getGauceStatement(InsertSql_u1.toString());
								gsmt_u1.executeUpdate();
								gsmt_u1.close();	
							}//if rs_u1
						
						 ///logger.dbg.println(this,"�հ��ܾ�7");
						} //dbl[4]+dbl[5]+dbl[6]+dbl[7]!
             
           /// logger.dbg.println(this,"�հ��ܾ�8");
					}//while rs_d


				/************************************************************************************
				 @ �����׸�����(�Ϻ�)
				*************************************************************************************/
					//logger.dbg.println(this,"�Ϻ������׸�");
				  StringBuffer sql_u2 = new StringBuffer();
					Statement stmt_u2 = null;
					ResultSet rs_u2 = null;
					//logger.dbg.println(this,"�����׸�����1");
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
					sql_u2.append( "    AND B.SUMLEVEL ='"+strlevel+"'                            ");
					sql_u2.append( "  GROUP BY A.FDCODE, A.ACTDAT, B.ATUPCODE, A.COCODE,A.DIVCD,");
					sql_u2.append( "           A.DEPTCD,A.FSREFCD, A.FSREFVAL                   ");
			
			    ///logger.dbg.println(this,"sql_u2" + sql_u2.toString());
					stmt_u2 = conn.createStatement();
					rs_u2 = stmt_u2.executeQuery(sql_u2.toString());
				  ///logger.dbg.println(this,"�����׸�����2");
					while(rs_u2.next())	{
	         /// logger.dbg.println(this,"�����׸�����22");					
  
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

						//logger.dbg.println(this,"�����׸�����3");

						if(dbl3[2]+dbl3[3]!=0){

							StringBuffer sql_u3 = new StringBuffer();
							Statement stmt_u3 = null;
							ResultSet rs_u3 = null;

							///logger.dbg.println(this,"�����׸�����4");
							
							sql_u3.append( " SELECT DETOT,   CRTOT,   DEUPTOT,   CRUPTOT,  ");
							sql_u3.append( "        FODETOT, FOCRTOT, FODEUPTOT, FOCRUPTOT  ");
							sql_u3.append( "   FROM ACCOUNT.FSREFTOT     	");
							sql_u3.append( "  WHERE FDCODE ='"+str3[0]+"'  ");
							sql_u3.append( "    AND ACTDAT ='"+str3[1]+"'  ");
							sql_u3.append( "    AND ATCODE ='"+str3[2]+"'  ");
							sql_u3.append( "    AND COCODE ='"+str3[3]+"'  ");
							sql_u3.append( "    AND DIVCD  ='"+str3[4]+"'  ");
							sql_u3.append( "    AND DEPTCD ='"+str3[5]+"'  ");
							sql_u3.append( "    AND FSREFCD  ='"+str3[6]+"'  ");
							sql_u3.append( "    AND FSREFVAL ='"+str3[7]+"'  ");

							///logger.dbg.println(this,"sql_u3" + sql_u3.toString());
							
							stmt_u3 = conn.createStatement();
							rs_u3 = stmt_u3.executeQuery(sql_u3.toString());
              
							strGubun_2="0";

							while(rs_u3.next())	{
								//logger.dbg.println(this,"�����׸�����5");
								strGubun_2="1";
								dbl4[0]=rs_u3.getDouble(1);
								dbl4[1]=rs_u3.getDouble(2);
								dbl4[2]=rs_u3.getDouble(3);
								dbl4[3]=rs_u3.getDouble(4);

								dbl4_fo[0]=rs_u3.getDouble(5);
								dbl4_fo[1]=rs_u3.getDouble(6);
								dbl4_fo[2]=rs_u3.getDouble(7);
								dbl4_fo[3]=rs_u3.getDouble(8);
								
								//�����ݾ� Sum
								//��ȭ
								dbl_sum3[0] = dbl4[0]+ dbl3[2]; 
								dbl_sum3[1] = dbl4[1]+ dbl3[3];
								dbl_sum3[2] = dbl3[2];
								dbl_sum3[3] = dbl3[3];

                //��ȭ
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
								UpdateSql_u3.append( "    AND ATCODE='"+str3[2]+"'" );
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
								
							 //logger.dbg.println(this,"�����׸�����6");
							//�����׸�����(�Ϻ�)
								StringBuffer InsertSql_u3 = null;
								InsertSql_u3 = new StringBuffer();
								InsertSql_u3.append( " INSERT INTO ACCOUNT.FSREFTOT (" );
								InsertSql_u3.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD," );
								InsertSql_u3.append( " DEPTCD,  FSREFCD, FSREFVAL , " );
								InsertSql_u3.append( " DETOT,   CRTOT,   DEUPTOT,   CRUPTOT," );
								InsertSql_u3.append( " FODETOT, FOCRTOT, FODEUPTOT, FOCRUPTOT" );
								InsertSql_u3.append( "  ) " );
								InsertSql_u3.append( " VALUES ( '"+str3[0]+"','"+str3[1]+"','"+str3[2]+"','"+str3[3]+"','"+str3[4]+"'," ); 
								InsertSql_u3.append( " '"+str3[5]+"','"+str3[6]+"','"+str3[7]+"'," ); 
								InsertSql_u3.append( " "+dbl3[0]+","+dbl3[1]+","+dbl3[0]+","+dbl3[1]+","); 
								InsertSql_u3.append( " "+dbl3_fo[0]+","+dbl3_fo[1]+","+dbl3_fo[0]+","+dbl3_fo[1]+")" ); 
								
								///logger.dbg.println(this,"InsertSql_u3" + InsertSql_u3.toString());
								GauceStatement gsmt_u3 = conn.getGauceStatement(InsertSql_u3.toString());
								gsmt_u3.executeUpdate();
								gsmt_u3.close();
							}//if rs_u1
						}
					}//while rs_d

          //=======================================================================
					//���� �ʱ�ȭ
					//=======================================================================
					//���� �ʱ�ȭ
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
					 @ �հ��ܾ�(����)
					*************************************************************************************/
					StringBuffer sql_md = new StringBuffer();
					Statement stmt_md = null;
					ResultSet rs_md = null;

					 //logger.dbg.println(this,"�����հ��ܾ�1");

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
           
					sql_md.append( "   FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B           ");
					sql_md.append( "  WHERE A.ATCODE = B.ATCODE                            ");
					sql_md.append( "    AND (A.DEUPTOT <> 0 OR A.CRUPTOT <> 0                  ");
					sql_md.append( "     OR A.DEUPCASH <> 0 OR A.CRUPCASH <> 0)                ");
					sql_md.append( "    AND B.SUMLEVEL ='"+strlevel+"'                              ");
					sql_md.append( "  GROUP BY A.FDCODE, A.ACTYYMM, B.ATUPCODE, A.COCODE,A.DIVCD,A.DEPTCD");
					
				 
					//logger.dbg.println(this,"sql_md" +sql_md.toString());
					stmt_md = conn.createStatement();
					rs_md = stmt_md.executeQuery(sql_md.toString());

					while(rs_md.next())	{
					//logger.dbg.println(this,"�����հ��ܾ�2");

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

						if(dbl[4]+dbl[5]+dbl[6]+dbl[7]!=0){
              // logger.dbg.println(this,"�����հ��ܾ�3");

							StringBuffer sql_mu1 = new StringBuffer();
							Statement stmt_mu1 = null;
							ResultSet rs_mu1 = null;
							
							sql_mu1.append( " SELECT DETOT,  CRTOT,  DECASH,  CRCASH,  DEUPTOT,  CRUPTOT,  DEUPCASH,  CRUPCASH,  EDECASH,  ECRCASH, ");
							sql_mu1.append( "        FODETOT,FOCRTOT,FODECASH,FOCRCASH,FODEUPTOT,FOCRUPTOT,FODEUPCASH,FOCRUPCASH,FOEDECASH,FOECRCASH ");
							sql_mu1.append( "   FROM ACCOUNT.MTOTALBAL     	");
							sql_mu1.append( "  WHERE FDCODE ='"+str[0]+"'  ");
							sql_mu1.append( "    AND ACTYYMM ='"+str[1]+"'  ");
							sql_mu1.append( "    AND ATCODE ='"+str[2]+"'  ");
							sql_mu1.append( "    AND COCODE ='"+str[3]+"'  ");
							sql_mu1.append( "    AND DIVCD  ='"+str[4]+"'  ");
							sql_mu1.append( "    AND DEPTCD ='"+str[5]+"'  ");
							
							/// logger.dbg.println(this,"sql_mu1"+sql_mu1.toString());

							stmt_mu1 = conn.createStatement();
							rs_mu1 = stmt_mu1.executeQuery(sql_mu1.toString());

							strGubun_1="0";
							while(rs_mu1.next())	{
							///	logger.dbg.println(this,"�����հ��ܾ�4");
                strGubun_1="1";

								//��ȭ
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
                
								//��ȭ
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
								
								//�����ݾ� Sum
								//��ȭ
								dbl_sum[0] = dbl[4] + dbl2[0];
								dbl_sum[1] = dbl[5] + dbl2[1];
								dbl_sum[2] = dbl[6] + dbl2[2];
								dbl_sum[3] = dbl[7] + dbl2[3];
								dbl_sum[4] = dbl[4] ;
								dbl_sum[5] = dbl[5] ;
								dbl_sum[6] = dbl[6] ;
								dbl_sum[7] = dbl[7] ;

						
                //��ȭ
								dbl_sum_fo[0] = dbl_fo[4] + dbl2_fo[0];     
								dbl_sum_fo[1] = dbl_fo[5] + dbl2_fo[1];
								dbl_sum_fo[2] = dbl_fo[6] + dbl2_fo[2];
								dbl_sum_fo[3] = dbl_fo[7] + dbl2_fo[3];
								dbl_sum_fo[4] = dbl_fo[4] ;
								dbl_sum_fo[5] = dbl_fo[5] ;
								dbl_sum_fo[6] = dbl_fo[6] ;
								dbl_sum_fo[7] = dbl_fo[7] ;

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
								UpdateSql_mu1.append( "        CRUPCASH= "+dbl_sum[7]+"," );

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
								UpdateSql_mu1.append( "    AND ATCODE='"+str[2]+"'" );
								UpdateSql_mu1.append( "    AND COCODE='"+str[3]+"'" );
								UpdateSql_mu1.append( "    AND DIVCD='"+str[4]+"'" );
								UpdateSql_mu1.append( "    AND DEPTCD='"+str[5]+"'" );
								
								/// logger.dbg.println(this,"UpdateSql_mu1" + UpdateSql_mu1.toString());

								GauceStatement gsmt_mu1 = conn.getGauceStatement(UpdateSql_mu1.toString());
								gsmt_mu1.executeUpdate();
								gsmt_mu1.close();	
							}//while rs_u1

							if(strGubun_1.equals("0")){                          //Insert
								//�հ��ܾ�(�Ϻ�)
								// logger.dbg.println(this,"�����հ��ܾ�6");

								StringBuffer InsertSql_mu1 = null;
				        InsertSql_mu1 = new StringBuffer();
								InsertSql_mu1.append( " INSERT INTO ACCOUNT.MTOTALBAL (" );
								InsertSql_mu1.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD," );
								InsertSql_mu1.append( " DEPTCD,  " );
								InsertSql_mu1.append( " DETOT,     CRTOT,     DECASH,     CRCASH," );
								InsertSql_mu1.append( " DEUPTOT,   CRUPTOT,   DEUPCASH,   CRUPCASH,  " );
								InsertSql_mu1.append( " FODETOT,   FOCRTOT,   FODECASH,   FOCRCASH,  " );
								InsertSql_mu1.append( " FODEUPTOT, FOCRUPTOT, FODEUPCASH, FOCRUPCASH  " );
								InsertSql_mu1.append( "  ) " );
								InsertSql_mu1.append( " VALUES ( '"+str[0]+"','"+str[1]+"','"+str[2]+"','"+str[3]+"','"+str[4]+"','"+str[5]+"', " ); 
								InsertSql_mu1.append( " "+dbl[0]+","+dbl[1]+","+dbl[2]+","+dbl[3]+","+dbl[4]+","+dbl[5]+","+dbl[6]+","+dbl[7]+"," ); 
							  InsertSql_mu1.append( " "+dbl_fo[0]+","+dbl_fo[1]+","+dbl_fo[2]+","+dbl_fo[3]+"," );
								InsertSql_mu1.append( " "+dbl_fo[4]+","+dbl_fo[5]+","+dbl_fo[6]+","+dbl_fo[7]+")" ); 

                /// logger.dbg.println(this,"InsertSql_mu1"+InsertSql_mu1.toString());

								GauceStatement gsmt_mu1 = conn.getGauceStatement(InsertSql_mu1.toString());
								gsmt_mu1.executeUpdate();
								gsmt_mu1.close();	
							}//if rs_u1
						}
					}//while rs_d


				/************************************************************************************
				 @ �����׸�����(����)
				*************************************************************************************/
				  StringBuffer sql_mu2 = new StringBuffer();
					Statement stmt_mu2 = null;
					ResultSet rs_mu2 = null;
					
					//logger.dbg.println(this,"���������׸�����1");
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
					sql_mu2.append( "    AND SUMLEVEL ='"+strlevel+"'                            ");
					sql_mu2.append( "  GROUP BY A.FDCODE, A.ACTYYMM, B.ATUPCODE, A.COCODE,A.DIVCD,");
					sql_mu2.append( "           A.DEPTCD,A.FSREFCD, A.FSREFVAL                   ");
			
			   /// logger.dbg.println(this,"sql_mu2"+sql_mu2.toString());
					stmt_mu2 = conn.createStatement();
					rs_mu2 = stmt_mu2.executeQuery(sql_mu2.toString());
				
					while(rs_mu2.next())	{
						//logger.dbg.println(this,"���������׸�����2");
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
             
          
						if(dbl3[2]+dbl3[3]!=0){
             /// logger.dbg.println(this,"���������׸�����222");
							StringBuffer sql_mu3 = new StringBuffer();
							Statement stmt_mu3 = null;
							ResultSet rs_mu3 = null;
							
							sql_mu3.append( " SELECT DETOT,   CRTOT,   DEUPTOT,   CRUPTOT,  ");
							sql_mu3.append( "        FODETOT, FOCRTOT, FODEUPTOT, FOCRUPTOT  ");
							sql_mu3.append( "   FROM ACCOUNT.MFSREFTOT     	");
							sql_mu3.append( "  WHERE FDCODE ='"+str3[0]+"'  ");
							sql_mu3.append( "    AND ACTYYMM ='"+str3[1]+"'  ");
							sql_mu3.append( "    AND ATCODE ='"+str3[2]+"'  ");
							sql_mu3.append( "    AND COCODE ='"+str3[3]+"'  ");
							sql_mu3.append( "    AND DIVCD  ='"+str3[4]+"'  ");
							sql_mu3.append( "    AND DEPTCD ='"+str3[5]+"'  ");
							sql_mu3.append( "    AND FSREFCD  ='"+str3[6]+"'  ");
							sql_mu3.append( "    AND FSREFVAL ='"+str3[7]+"'  ");

							///logger.dbg.println(this,"sql_mu3"+sql_mu3.toString());
							stmt_mu3 = conn.createStatement();
							rs_mu3 = stmt_mu3.executeQuery(sql_mu3.toString());

              strGubun_2="0";
							
							while(rs_mu3.next())	{
								//logger.dbg.println(this,"���������׸�����333");
								strGubun_2="1";
								dbl4[0]=rs_mu3.getDouble(1);
								dbl4[1]=rs_mu3.getDouble(2);
								dbl4[2]=rs_mu3.getDouble(3);
								dbl4[3]=rs_mu3.getDouble(4);

								dbl4_fo[0]=rs_mu3.getDouble(5);
								dbl4_fo[1]=rs_mu3.getDouble(6);
								dbl4_fo[2]=rs_mu3.getDouble(7);
								dbl4_fo[3]=rs_mu3.getDouble(8);
								
								//�����ݾ� Sum
								//��ȭ
								dbl_sum3[0] = dbl4[0]+ dbl3[2]; 
								dbl_sum3[1] = dbl4[1]+ dbl3[3];
								dbl_sum3[2] = dbl3[2];
								dbl_sum3[3] = dbl3[3];

                //��ȭ
								dbl_sum3_fo[0] = dbl4_fo[0]+ dbl3_fo[2]; 
								dbl_sum3_fo[1] = dbl4_fo[1]+ dbl3_fo[3];
								dbl_sum3_fo[2] = dbl3_fo[2];
								dbl_sum3_fo[3] = dbl3_fo[3];



								///logger.dbg.println(this,"���������׸�����444");
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
								UpdateSql_mu3.append( "    AND ATCODE='"+str3[2]+"'" );
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
								//�����׸�����(����)
									//logger.dbg.println(this,"���������׸�����555");
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
							}//if rs_u1

						} //if rs_mu3

					}//while rs_d
				  ///logger.dbg.println(this,"end j::"+ j);
				}//for j

        /***********************************************************
					�ܾװ��� �ʵ� ��� 0 ���� ������.
				************************************************************/
        String  sql9 = " UPDATE  ACCOUNT.TOTALBAL SET "
										 + "         DEUPTOT = 0,  CRUPTOT = 0,  DEUPCASH =0,  CRUPCASH=0, "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0,FODEUPCASH =0,FOCRUPCASH=0 "
										 + "  WHERE  DEUPTOT !=0 OR CRUPTOT !=0 OR DEUPCASH !=0 OR CRUPCASH!=0 ";
										
				GauceStatement gsmt9 = conn.getGauceStatement(sql9);
				gsmt9.executeUpdate();
				gsmt9.close();

				String  sql91 = " UPDATE  ACCOUNT.FSREFTOT SET "
										 + "         DEUPTOT = 0,  CRUPTOT = 0, "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0 "
										 + "  WHERE  DEUPTOT !=0 OR CRUPTOT !=0";
										
				GauceStatement gsmt91 = conn.getGauceStatement(sql91);
				gsmt91.executeUpdate();
				gsmt91.close();

        String  sql92 = " UPDATE  ACCOUNT.MTOTALBAL SET "
										 + "         DEUPTOT = 0,  CRUPTOT = 0,  DEUPCASH =0,  CRUPCASH=0, "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0,FODEUPCASH =0,FOCRUPCASH=0 "
										 + "  WHERE  DEUPTOT !=0 OR CRUPTOT !=0 OR DEUPCASH !=0 OR CRUPCASH!=0 ";
										
				GauceStatement gsmt92 = conn.getGauceStatement(sql92);
				gsmt92.executeUpdate();
				gsmt92.close();

				String  sql93 = " UPDATE  ACCOUNT.MFSREFTOT SET "
										 + "         DEUPTOT = 0,  CRUPTOT = 0, "
										 + "         FODEUPTOT = 0,FOCRUPTOT = 0 "
										 + "  WHERE  DEUPTOT !=0 OR CRUPTOT !=0";
										
				GauceStatement gsmt93 = conn.getGauceStatement(sql93);
				gsmt93.executeUpdate();
				gsmt93.close();

       ///logger.dbg.println(this,"END");
				//update 

			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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