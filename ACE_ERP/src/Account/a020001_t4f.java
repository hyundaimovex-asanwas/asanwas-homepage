package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020001_t4f extends HttpServlet{
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
			String strErrorNo ="";
			String strFsnbr="";
			int intChk=0;
			
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();


        /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        @ 전표번호 생성하기
	      >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String strFdcode = reqGauce.getParameter("v_str1");    //지점
				String strFsdat  = reqGauce.getParameter("v_str2");    //회계일자
				String strFdcode2 = reqGauce.getParameter("v_str3");   //로그인 ID에 따른 지점 
				String strUserid  = reqGauce.getParameter("v_str4");   //userid 
				String strDate    = reqGauce.getParameter("v_str5");   //date
				String strPyo     = reqGauce.getParameter("v_str6");   //수정분개전표때는 A

				logger.dbg.println(this,"strFdcode"+strFdcode+"strFsdat"+strFsdat+"strFdcode2"+strFdcode2+"strUserid"+strUserid+"strDate"+strDate);

				if (userSet != null) {
					GauceDataRow[] rows = userSet.getDataRows();

					intChk=0;
					Statement stmt33 = conn.createStatement();
					String sql33 = " SELECT COUNT(*) FROM ACCOUNT.SLIPNOINF "
											+ "	 WHERE FDCODE ='"+strFdcode+"'" 
											+ "	   AND	SPDAT='"+strFsdat+"'" ;
					ResultSet rs33 = stmt33.executeQuery(sql33); 
					
					if(rs33.next()){
						 intChk= rs33.getInt(1);
					}
		
					if(!strPyo.equals("U")) {
						double dblcnt=0;
						if (strFdcode.equals(strFdcode2)){
							Statement stmt = conn.createStatement();
							String sql = " SELECT NVL(MAX(SPNO1),0)+1 FROM ACCOUNT.SLIPNOINF "
									   + "	WHERE FDCODE ='"+strFdcode+"'" 
									   + "	  AND	SPDAT='"+strFsdat+"'" ;
              
							ResultSet rs = stmt.executeQuery(sql); 
							
							//logger.dbg.println(this,"getString::");
							if(rs.next()){
								 //logger.dbg.println(this,"rs.getString(1):"+rs.getString(1));
								 strFsnbr= rs.getString(1);
							}

							//logger.dbg.println(this,"strFsnbr::"+strFsnbr);

							int ichk = Integer.parseInt(strFsnbr);
							if(ichk<10) strFsnbr = "00000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "0000"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="000"+strFsnbr;
							else if(ichk>=1000 && ichk<10000)strFsnbr = "00"+strFsnbr;
							else if(ichk>=10000 && ichk<100000) strFsnbr = "0"+strFsnbr;

							//logger.dbg.println(this,"strFsnbr::"+strFsnbr);

							if(intChk==0){  //insert
								String  sql2 = " INSERT INTO  ACCOUNT.SLIPNOINF ( "
											 + " FDCODE,	SPDAT,	SPNO1,	SPNO2, SPNO3,	"
											 + " WRDT, WRID "
											 + " ) "
											 + " VALUES ( "
											 + " '"+strFdcode+"',"
											 + " '"+strFsdat+"',"
											 + " '"+strFsnbr+"',"
											 + " '500000',"
											 + " '900000',"
											 + " '"+strDate+"',"
											 + " '"+strUserid+"')";
				
								GauceStatement gsmt2 = conn.getGauceStatement(sql2);
								gsmt2.executeUpdate();
								gsmt2.close();
							}else{       //update

							//logger.dbg.println(this,"bb::");
								String  sql2 = " UPDATE ACCOUNT.SLIPNOINF SET "
														 + "  SPNO1 = '"+strFsnbr+"',"
														 + "  UPDT = '"+strDate+"',"
														 + "  UPID = '"+strUserid+"'"
														 + "  WHERE FDCODE ='"+strFdcode+"'" 
														 + "	  AND	SPDAT='"+strFsdat+"'" ;
														
								GauceStatement gsmt2 = conn.getGauceStatement(sql2);
								gsmt2.executeUpdate();
								gsmt2.close();
							} //if(ichk==1){ 

						}else{ //본사에서 금강산, 개성 전표를 입력할 경우
							Statement stmt3 = conn.createStatement();
							String sql3 = " SELECT NVL(MAX(SPNO2),0)+1 FROM ACCOUNT.SLIPNOINF "
									    + "	 WHERE FDCODE ='"+strFdcode+"'" 
									    + "	   AND	SPDAT='"+strFsdat+"'" ;
							ResultSet rs3 = stmt3.executeQuery(sql3); 
							
							if(rs3.next()){
								 strFsnbr= rs3.getString(1);
							}

							int ichk = Integer.parseInt(strFsnbr);
							if(ichk<10) strFsnbr = "50000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "5000"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="500"+strFsnbr;
							else if(ichk>=1000 && ichk<10000)strFsnbr = "50"+strFsnbr;
							else if(ichk>=10000 && ichk<100000) strFsnbr = "5"+strFsnbr;

							if(intChk==0){  //insert
								String  sql4 = " INSERT INTO  ACCOUNT.SLIPNOINF ( "
											 + " FDCODE,	SPDAT,	SPNO1,	SPNO2, SPNO3,	"
											 + " WRDT, WRID "
											 + " ) "
											 + " VALUES ( "
											 + " '"+strFdcode+"',"
											 + " '"+strFsdat+"',"
											 + " '000000',"
											 + " '"+strFsnbr+"',"
											 + " '900000',"
											 + " '"+strDate+"',"
											 + " '"+strUserid+"')";

												
								GauceStatement gsmt4 = conn.getGauceStatement(sql4);
								gsmt4.executeUpdate();
								gsmt4.close();
							}else{       //update
								String  sql4 = " UPDATE ACCOUNT.SLIPNOINF SET "
											 + "  SPNO2 = '"+strFsnbr+"',"
											 + "  UPDT = '"+strDate+"',"
											 + "  UPID = '"+strUserid+"'"
											 + "  WHERE FDCODE ='"+strFdcode+"'" 
											 + "	  AND	SPDAT='"+strFsdat+"'" ;
														
								GauceStatement gsmt4 = conn.getGauceStatement(sql4);
								gsmt4.executeUpdate();
								gsmt4.close();
							} //(ichk==1)
						}// if (strFdcode.equals(strFdcode2))
					
					} else {  //if strpyo(수정분개)

						  	Statement stmt5 = conn.createStatement();
							
							String sql5 = " SELECT NVL(MAX(SPNO3),0)+1 FROM ACCOUNT.SLIPNOINF "
									    + "	 WHERE FDCODE ='"+strFdcode+"'" 
									    + "	   AND	SPDAT='"+strFsdat+"'" ;
							ResultSet rs5 = stmt5.executeQuery(sql5); 
							
							
							if(rs5.next()){
								 strFsnbr= rs5.getString(1);
							}


							int ichk = Integer.parseInt(strFsnbr);
							if(ichk<10) strFsnbr = "90000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "9000"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="900"+strFsnbr;
							else if(ichk>=1000 && ichk<10000)strFsnbr = "90"+strFsnbr;
							else if(ichk>=10000 && ichk<100000) strFsnbr = "9"+strFsnbr;

							
							if(intChk==0){  //insert
								String  sql6 = " INSERT INTO  ACCOUNT.SLIPNOINF ( "
											 + " FDCODE,	SPDAT,SPNO1,SPNO2,	SPNO3,	"
											 + " WRDT, WRID "
											 + " ) "
											 + " VALUES ( "
											 + " '"+strFdcode+"',"
											 + " '"+strFsdat+"',"
											 + " '000000',"
											 + " '500000',"
											 + " '"+strFsnbr+"',"
											 + " '"+strDate+"',"
											 + " '"+strUserid+"')";

								GauceStatement gsmt6 = conn.getGauceStatement(sql6);
								gsmt6.executeUpdate();
								gsmt6.close();
							}else{       //update
								String  sql6 = " UPDATE ACCOUNT.SLIPNOINF SET "
											 + "  SPNO3 = '"+strFsnbr+"',"
											 + "  UPDT = '"+strDate+"',"
											 + "  UPID = '"+strUserid+"'"
											 + "  WHERE FDCODE ='"+strFdcode+"'" 
											 + "  AND	SPDAT='"+strFsdat+"'" ;
														
								GauceStatement gsmt6 = conn.getGauceStatement(sql6);
								gsmt6.executeUpdate();
								gsmt6.close();
				    	}// if(ichk==1)

					 }//if(!strPyo.equals("U")) {
					 /************************************************************************************
							 @ return값
						*************************************************************************************/
					  //logger.dbg.println(this,"step2" ); 
						resGauce.enableFirstRow(userSet);
					
					    if(!strPyo.equals("U")) {
							if(strFdcode==strFdcode2){
								userSet.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING));
							}else{
								userSet.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING));
							}
						}else{
							userSet.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING));
						}
	
						GauceDataRow row = null;
						row = userSet.newDataRow();
						row.addColumnValue(strFsnbr);
						userSet.addDataRow(row);
						userSet.flush();
						//logger.dbg.println(this,"end" ); 
						
				}//if
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
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}