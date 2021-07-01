package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class comm_bgt_result_t1 extends HttpServlet{
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

		  String [] str = new String [8];
			
			double [] dbl = new double [3];
			double [] dbl_sum = new double [2];

			String strGubun="";
	  

      ///////////////////////////////////
			//예산실적 데이타 반영
      ///////////////////////////////////
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
        //logger.dbg.println(this,"start");
				if (userSet != null) {

					int idxSYEAR     = userSet.indexOfColumn("SYEAR");
					int idxSFRMM     = userSet.indexOfColumn("SFRMM");
					int idxSTOMM     = userSet.indexOfColumn("STOMM");
					GauceDataRow[] rows = userSet.getDataRows();

					for (int c=0;c<rows.length;c++){
					/************************************************************************************
					 @ 예산실적 테이블 조히
					*************************************************************************************/
						StringBuffer sql_d = new StringBuffer();
						Statement stmt_d = null;
						ResultSet rs_d = null;

						sql_d.append( " SELECT FDCODE,  BGTYY,   BGTMM,   BGTDIV,  BGTDPT,  ");
						sql_d.append( "        ATCODE,  FSREFCD, SATCODE, RESULTS           ");
						sql_d.append( "   FROM ACCOUNT.T_BRESULT                            ");
						sql_d.append( "  WHERE STATUS ='N'                              ");
						sql_d.append( "    AND BGTYY = '"+rows[c].getString(idxSYEAR)+"'    ");
						sql_d.append( "    AND BGTMM >='"+rows[c].getString(idxSFRMM)+"' AND BGTMM <='"+rows[c].getString(idxSTOMM)+"' ");
						
						//logger.dbg.println(this,"sql_d.toString()::" +sql_d.toString());
						stmt_d = conn.createStatement();
						rs_d = stmt_d.executeQuery(sql_d.toString());


						while(rs_d.next())	{		//
							for (int s=0;s<=7;s++) {
								str[s] = "";
							}

							for (int s=0;s<=2;s++) {
								dbl[s] = 0;
						  }

							for (int s=0;s<=1;s++) {
								dbl_sum[s] = 0;
						  }


							//loop돌기
							str[0]=rs_d.getString(1);  //FDCODE
							str[1]=rs_d.getString(2);  //BGTYY
							str[2]=rs_d.getString(3);  //BGTMM
							str[3]=rs_d.getString(4);  //BGTDIV
							str[4]=rs_d.getString(5);  //BGTDPT
							str[5]=rs_d.getString(6);  //ATCODE
							str[6]=rs_d.getString(7);  //FSREFCD
							str[7]=rs_d.getString(8);  //SATCODE
							dbl[0]=rs_d.getDouble(9);  //RESULTS

							StringBuffer sql_u1 = new StringBuffer();
							Statement stmt_u1 = null;
							ResultSet rs_u1 = null;
							
							sql_u1.append( " SELECT RESULTS ");
							sql_u1.append( "   FROM ACCOUNT.BGTDTL ");
							sql_u1.append( "  WHERE FDCODE ='"+str[0]+"'");
							sql_u1.append( "    AND BGTYY = '"+str[1]+"'  ");
							sql_u1.append( "    AND BGTMM ='"+str[2]+"'   ");
							sql_u1.append( "    AND BGTDIV = '"+str[3]+"' ");
							sql_u1.append( "    AND BGTDPT = '"+str[4]+"' ");
							sql_u1.append( "    AND ATCODE = '"+str[5]+"' ");
							sql_u1.append( "    AND FSREFCD = '"+str[6]+"'");
							sql_u1.append( "    AND SATCODE ='"+str[7]+"' ");

							//logger.dbg.println(this,"sql_u1.toString()::" +sql_u1.toString());
						
							stmt_u1 = conn.createStatement();
							rs_u1 = stmt_u1.executeQuery(sql_u1.toString());


              strGubun = "";
							while(rs_u1.next())	{
								
                //데이타 존재구분
								strGubun="Y";

								//dtl 실적
								dbl[1]=rs_u1.getDouble(1);
								dbl_sum[0] = dbl[0] + dbl[1];     
							
								//Update
								StringBuffer UpdateSql_u1 = null;
								UpdateSql_u1 = new StringBuffer();
								UpdateSql_u1.append( " UPDATE ACCOUNT.BGTDTL SET " );
								UpdateSql_u1.append( "        RESULTS = "+dbl_sum[0]+"" );
								UpdateSql_u1.append( "  WHERE FDCODE ='"+str[0]+"'");
								UpdateSql_u1.append( "    AND BGTYY = '"+str[1]+"'  ");
								UpdateSql_u1.append( "    AND BGTMM ='"+str[2]+"'   ");
								UpdateSql_u1.append( "    AND BGTDIV = '"+str[3]+"' ");
								UpdateSql_u1.append( "    AND BGTDPT = '"+str[4]+"' ");
								UpdateSql_u1.append( "    AND ATCODE = '"+str[5]+"' ");
								UpdateSql_u1.append( "    AND FSREFCD = '"+str[6]+"'");
								UpdateSql_u1.append( "    AND SATCODE ='"+str[7]+"' ");

								//logger.dbg.println(this,"sUpdateSql_u1.toString()::" +UpdateSql_u1.toString());
						
								GauceStatement gsmt_u1 = conn.getGauceStatement(UpdateSql_u1.toString());
								gsmt_u1.executeUpdate();
								gsmt_u1.close();	

							}//while rs_u1
							rs_u1.close();
							
              //신규건은 INSERT
							if(!strGubun.equals("Y")){

								StringBuffer InsertSql_i1 = null;
								InsertSql_i1 = new StringBuffer();
								InsertSql_i1.append( "  INSERT INTO ACCOUNT.BGTDTL ( " );
								InsertSql_i1.append( "  FDCODE,	  BGTYY,	  BGTMM,	  BGTDIV,	 BGTDPT,  " );
								InsertSql_i1.append( "  ATCODE,	  FSREFCD,	SATCODE,	BGTTYPE, BGTMACT, " );
								InsertSql_i1.append( "  INITMAN,  INITBGT,	CHGMAN,	  CHGBGT,	 BASICBGT,  " );
								InsertSql_i1.append( "  ADDBGT,	  CHGABGT,	CHGTBGT,	REALBGT, RESULTS,  " );
								InsertSql_i1.append( "  BRESULTS,	APPROVAL,	CHGAPPROV,REMARK,	 DEPTBGT  " );
								InsertSql_i1.append( "  )  ");
								InsertSql_i1.append( "  VALUES (  '"+str[0]+"','"+str[1]+"','"+str[2]+"','"+str[3]+"','"+str[4]+"',");
								InsertSql_i1.append( "  '"+str[5]+"','"+str[6]+"','"+str[7]+"','1','01',  ");
								InsertSql_i1.append( "  0, 0, 0, 0, 0, ");
								InsertSql_i1.append( "  0, 0, 0, 0,"+dbl[0]+", ");
								InsertSql_i1.append( "  0,'Y','','',0 )");

								//logger.dbg.println(this,"sInsertSql_i1.toString()::" +InsertSql_i1.toString());
						
								GauceStatement gsmt_i1 = conn.getGauceStatement(InsertSql_i1.toString());
								gsmt_i1.executeUpdate();
								gsmt_i1.close();	
							}

              /**************************************************************************
							StringBuffer sql_u2 = new StringBuffer();
							Statement stmt_u2 = null;
							ResultSet rs_u2 = null;
							
							sql_u2.append( " SELECT RESULTS ");
							sql_u2.append( "   FROM ACCOUNT.BGTMST ");
							sql_u2.append( "  WHERE FDCODE ='"+str[0]+"'");
							sql_u2.append( "    AND BGTYY = '"+str[1]+"'  ");
							sql_u2.append( "    AND BGTDIV = '"+str[3]+"' ");
							sql_u2.append( "    AND BGTDPT = '"+str[4]+"' ");
							sql_u2.append( "    AND ATCODE = '"+str[5]+"' ");
							sql_u2.append( "    AND FSREFCD = '"+str[6]+"'");
							sql_u2.append( "    AND SATCODE ='"+str[7]+"' ");
						 
						  logger.dbg.println(this,"sql_u2.toString())::" +sql_u2.toString());
							stmt_u2 = conn.createStatement();
							rs_u2 = stmt_u2.executeQuery(sql_u2.toString());

							while(rs_u2.next())	{
								
								//mst
								dbl[2]=rs_u2.getDouble(1);
								dbl_sum[1] = dbl[0] + dbl[2];     
							
								//Update
								StringBuffer UpdateSql_u2 = null;
								UpdateSql_u2 = new StringBuffer();
								UpdateSql_u2.append( " UPDATE ACCOUNT.BGTMST SET " );
								UpdateSql_u2.append( "        RESULTS = "+dbl_sum[1]+"" );
								UpdateSql_u2.append( "  WHERE FDCODE ='"+str[0]+"'");
								UpdateSql_u2.append( "    AND BGTYY = '"+str[1]+"'  ");
								UpdateSql_u2.append( "    AND BGTDIV = '"+str[3]+"' ");
								UpdateSql_u2.append( "    AND BGTDPT = '"+str[4]+"' ");
								UpdateSql_u2.append( "    AND ATCODE = '"+str[5]+"' ");
								UpdateSql_u2.append( "    AND FSREFCD = '"+str[6]+"'");
								UpdateSql_u2.append( "    AND SATCODE ='"+str[7]+"' ");

								logger.dbg.println(this,"UpdateSql_u2.toString()::" +UpdateSql_u2.toString());
						
								GauceStatement gsmt_u2 = conn.getGauceStatement(UpdateSql_u2.toString());
								gsmt_u2.executeUpdate();
								gsmt_u2.close();	

							}//while rs_u1
							rs_u2.close(); 
							******************************************************************************/
						}//while rs_d
						rs_d.close();
            
            //실적데이타 상태변경
            // logger.dbg.println(this,"END::");
						StringBuffer UpdateSql_u3 = null;
						UpdateSql_u3 = new StringBuffer();
						UpdateSql_u3.append( " UPDATE ACCOUNT.T_BRESULT SET " );
						UpdateSql_u3.append( "        STATUS = 'Y'" );
						UpdateSql_u3.append( "  WHERE STATUS ='N' ");
						UpdateSql_u3.append( "    AND BGTYY = '"+rows[c].getString(idxSYEAR)+"'  ");
						UpdateSql_u3.append( "    AND BGTMM >='"+rows[c].getString(idxSFRMM)+"' ");
						UpdateSql_u3.append( "    AND BGTMM <='"+rows[c].getString(idxSTOMM)+"' ");

						//logger.dbg.println(this,"UpdateSql_u3.toString()::" +UpdateSql_u3.toString());
				
						GauceStatement gsmt_u3 = conn.getGauceStatement(UpdateSql_u3.toString());
						gsmt_u3.executeUpdate();
						gsmt_u3.close();	


					}//FOR
				}//USERSET
			} //try
			catch(Exception e){

        //logger.dbg.println(this,"FDCODE::" +str[0]+"BGTYY::" +str[1]+"BGTMM::" +str[2]+"BGTDIV::" +str[3]+"BGTDPT::" +str[4]+"ATCODE::" +str[5]+"FSREFCD::" +str[6]+"SATCODE::" +str[7]);

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