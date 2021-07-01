package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020001_t7 extends HttpServlet{
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

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				//String str1 = reqGauce.getParameter("v_str1");
				//String str2 = reqGauce.getParameter("v_str2");
				//String str3 = reqGauce.getParameter("v_str3");
    
				//logger.dbg.println(this,"step1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE     = userSet.indexOfColumn("FDCODE");
				int idxFSDAT      = userSet.indexOfColumn("FSDAT");
				int idxFSNBR      = userSet.indexOfColumn("FSNBR");
				int idxSEQ        = userSet.indexOfColumn("SEQ");
				int idxACCSGNID   = userSet.indexOfColumn("ACCSGNID");
				int idxEMPNO      = userSet.indexOfColumn("EMPNO");
				int idxACCSGNDAT  = userSet.indexOfColumn("ACCSGNDAT");
				int idxACCSGNEND  = userSet.indexOfColumn("ACCSGNEND");
				int idxFROMGB     = userSet.indexOfColumn("FROMGB");
				int idxTOGB       = userSet.indexOfColumn("TOGB");
				int idxBIGO       = userSet.indexOfColumn("BIGO");
				int idxBGTGB      = userSet.indexOfColumn("BGTGB");
				int idxWRDT       = userSet.indexOfColumn("WRDT");
				int idxWRID       = userSet.indexOfColumn("WRID");
				int idxUPDT       = userSet.indexOfColumn("UPDT");
				int idxUPID       = userSet.indexOfColumn("UPID");				

				//logger.dbg.println(this,"step2");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				//StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACTSGNSTS (  " );
				InsertSql.append( " FDCODE,    FSDAT,     FSNBR,   SEQ,  ACCSGNID, EMPNO,  " );
				InsertSql.append( " ACCSGNDAT, ACCSGNEND, FROMGB,  TOGB, BIGO, BGTGB, WRDT,   WRID )" );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE  ACCOUNT.FSLIPMST SET  " );
				UpdateSql.append( "         FSSTAT =? ,           " );
				UpdateSql.append( "         UPDT =? ,           " );
				UpdateSql.append( "         UPID =?             " );
				UpdateSql.append( "  WHERE  FDCODE =?             " );
				UpdateSql.append( "    AND  FSDAT =?              " );
				UpdateSql.append( "    AND  FSNBR =?              " );
			
				String strGubun="";
				String strGubun1="";
				String strGubun2="";
				String strGubun3="";
				String strEmpno="";
				String strTogb="";
				String strBgtgb="";
				String strcnt="0";
				for (int j = 0; j < rows.length; j++){
					
					Statement stmt00 = conn.createStatement();
					String sql00 = " SELECT DISTINCT CASE WHEN A.FSWRKDIV = '02' THEN '01BGT' "
											 + "                      WHEN B.FUNDIV IS NOT NULL THEN '02FUN' "
											 + "                      ELSE '03ACC' END GUBUN "
											 + "   FROM ACCOUNT.FSLIPDTL A, ACCOUNT.ACTCODE B "
										     + "	WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'"
										     + "	  AND FSDAT='"+rows[j].getString(idxFSDAT)+"'"
										     + "	  AND FSNBR='"+rows[j].getString(idxFSNBR)+"'"
											 + "  ORDER BY GUBUN " ; 
					ResultSet rs00 = stmt00.executeQuery(sql00); 

					if(rs00.next()){
					  strGubun= rs00.getString(1);
						if(strGubun.equals("01BGT")){
							strGubun1 = "BGT";
						}else if(strGubun.equals("02FUN")){
							strGubun2 = "FUN";
						}else if(strGubun.equals("03ACC")){
							strGubun3 = "ACC";
						}
					}
					rs00.close();

					if(strGubun1.equals("BGT")){         //예산
						Statement stmt001 = conn.createStatement();	
						String sql001 = " SELECT CDCODE AS EMPNO FROM ACCOUNT.COMMDTIL "
						              		+ " WHERE CMTYPE='0900' AND GBCD = '02'  ";
						ResultSet rs001 = stmt001.executeQuery(sql001);    
						if(rs001.next()){
							strEmpno=rs001.getString(1);
						}

						strTogb="02";
						strBgtgb="Y";
					}else if(strGubun1.equals("FUN")){   //자금
						Statement stmt002 = conn.createStatement();	
						String sql002 = " SELECT CDCODE AS EMPNO FROM ACCOUNT.COMMDTIL "
						              	+ " WHERE CMTYPE='0900' AND GBCD = '03'  ";
						ResultSet rs002 = stmt002.executeQuery(sql002);    
						if(rs002.next()){
							strEmpno=rs002.getString(1);	
						}
						strTogb="06";
					}else if(strGubun1.equals("ACC")){   //회계
						Statement stmt003 = conn.createStatement();	
						String sql003 = " SELECT CDCODE AS EMPNO FROM ACCOUNT.COMMDTIL "
						              + " WHERE CMTYPE='0900' AND GBCD = '01'  ";
						ResultSet rs003 = stmt003.executeQuery(sql003);    
						if(rs003.next()){
							strEmpno=rs003.getString(1);
						}
						strTogb="03";
					}
     
					Statement stmt0 = conn.createStatement();
					String sql0 = " SELECT COALESCE(MAX(SEQ),0)+1 FROM ACCOUNT.ACTSGNSTS "
										  + "	 WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'"
										  + "	   AND FSDAT='"+rows[j].getString(idxFSDAT)+"'"
										  + "	   AND FSNBR='"+rows[j].getString(idxFSNBR)+"'"; 
					ResultSet rs0 = stmt0.executeQuery(sql0); 

					if(rs0.next()){
					  strcnt= rs0.getString(1);
					}

					int ichk = Integer.parseInt(strcnt);
					if(ichk<10) strcnt = "0"+strcnt;
					
					rows[j].setString(idxSEQ,strcnt);
					rows[j].setString(idxACCSGNID,strEmpno);
					rows[j].setString(idxTOGB,strTogb);
					rows[j].setString(idxBGTGB,strBgtgb);

					GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
					gsmt.setGauceDataRow(rows[j]);
					gsmt.bindColumn(1,idxFDCODE);
					gsmt.bindColumn(2,idxFSDAT);
					gsmt.bindColumn(3,idxFSNBR);
					gsmt.bindColumn(4,idxSEQ);
					gsmt.bindColumn(5,idxACCSGNID);
					gsmt.bindColumn(6,idxEMPNO);
					gsmt.bindColumn(7,idxACCSGNDAT);
					gsmt.bindColumn(8,idxACCSGNEND);
					gsmt.bindColumn(9,idxFROMGB);
					gsmt.bindColumn(10,idxTOGB);
					gsmt.bindColumn(11,idxBIGO);
					gsmt.bindColumn(12,idxBGTGB);
					gsmt.bindColumn(13,idxWRDT);
					gsmt.bindColumn(14,idxWRID);

					//logger.dbg.println(this,"step555555");

					gsmt.executeUpdate();
					gsmt.close();

					GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());

					gsmt2.setGauceDataRow(rows[j]);
					gsmt2.bindColumn(1,idxACCSGNEND);
					gsmt2.bindColumn(2,idxUPDT);
					gsmt2.bindColumn(3,idxUPID);
					gsmt2.bindColumn(4,idxFDCODE);
					gsmt2.bindColumn(5,idxFSDAT);
					gsmt2.bindColumn(6,idxFSNBR);
				
					gsmt2.executeUpdate();
					gsmt2.close();

				}//for
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

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