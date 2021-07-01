package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h050001_t1 extends HttpServlet{

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

			String stryymm="";
			String strEmpno="";
			String strSeq="";
			String strHlno="";

			try {
				String  str1	= req.getParameter("v_str1");   // 신청일자
				String  str2	= req.getParameter("v_str2");   // 사번
				String  str3	= req.getParameter("v_str3");   // 결재자
				String  str4	= req.getParameter("v_str4");   // 승인자

				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPDT  = userSet.indexOfColumn("APPDT");	//신청일자
  			int idxEMPNO  = userSet.indexOfColumn("EMPNO");	//사번
				int idxLAZCD  = userSet.indexOfColumn("LAZCD");
				int idxDEPTCD = userSet.indexOfColumn("DEPTCD");
				int idxPAYSEQ = userSet.indexOfColumn("PAYSEQ");
				int idxFRDT	  = userSet.indexOfColumn("FRDT");
				int idxTODT   = userSet.indexOfColumn("TODT");
				int idxFRTIME = userSet.indexOfColumn("FRTIME");
				int idxTOTIME = userSet.indexOfColumn("TOTIME");
				int idxDTYREM = userSet.indexOfColumn("DTYREM");
			  //	int idxSGDT   = userSet.indexOfColumn("SGDT");
				int idxSGNID  = userSet.indexOfColumn("SGNID");
			  //	int idxAGRDT  = userSet.indexOfColumn("AGRDT");
				//  int idxAGRID  = userSet.indexOfColumn("AGRID");
			  //	int idxPAYDT  = userSet.indexOfColumn("PAYDT");
				int idxAMT    = userSet.indexOfColumn("AMT");
				int idxCLOSYN = userSet.indexOfColumn("CLOSYN");
				int idxHLNO = userSet.indexOfColumn("HLNO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HLDUTY (  ");
				InsertSql.append( " APPDT, EMPNO, LAZCD, DEPTCD, PAYSEQ, ");
				InsertSql.append( " FRDT, TODT, FRTIME, TOTIME, DTYREM,  ");
				InsertSql.append( " SGNID, AMT, CLOSYN, HLNO  ");
				InsertSql.append( ") values (  ");
				InsertSql.append( " '"+str1+"', ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " '"+str3+"',?,?,?) ");
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HLDUTY SET " );
        UpdateSql.append( " DEPTCD = ?, PAYSEQ =?, " );
				UpdateSql.append( " FRDT = ?, TODT =?, FRTIME = ?, TOTIME = ?, DTYREM = ?, SGNID = '"+str3+"', AMT = ? ,CLOSYN=?" );
				UpdateSql.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ?" );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HLDUTY WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //전자결재를 위한 키값생성 HLNO ===============================
			      strEmpno=rows[j].getString(idxEMPNO);
						stryymm=rows[j].getString(idxFRDT);
						stryymm=stryymm.substring(2,6);

            Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( " SELECT COALESCE(MAX(SUBSTR(HLNO,13,2)),0)+1 ");
						sql0.append( "	 FROM PAYROLL.HLDUTY "); 
						sql0.append( "	WHERE SUBSTR(HLNO,2,7)='"+strEmpno+"'");
						sql0.append( "	  AND SUBSTR(HLNO,9,4)='"+stryymm+"'"); 
						sql0.append( "	  AND SUBSTR(HLNO,1,1)='C'"); 

						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							 strSeq= rs0.getString(1);
						}
						rs0.close();
						stmt0.close();

						int ichk = Integer.parseInt(strSeq);
						if(ichk<10) strSeq = "0"+strSeq;
						strHlno = "C"+strEmpno+stryymm+strSeq;
						rows[j].setString(idxHLNO,strHlno);

						//==============================================================
							
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxLAZCD);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxPAYSEQ);
						gsmt.bindColumn(5, idxFRDT);
						gsmt.bindColumn(6, idxTODT);
						gsmt.bindColumn(7, idxFRTIME);
						gsmt.bindColumn(8, idxTOTIME);
						gsmt.bindColumn(9, idxDTYREM);
						gsmt.bindColumn(10,idxAMT);
						gsmt.bindColumn(11,idxCLOSYN);
						gsmt.bindColumn(12,idxHLNO);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxDEPTCD);
						gsmt.bindColumn(2, idxPAYSEQ);
						gsmt.bindColumn(3, idxFRDT);
						gsmt.bindColumn(4, idxTODT);
						gsmt.bindColumn(5, idxFRTIME);
						gsmt.bindColumn(6, idxTOTIME);
						gsmt.bindColumn(7, idxDTYREM);
						gsmt.bindColumn(8, idxAMT);
						gsmt.bindColumn(9, idxCLOSYN);
						gsmt.bindColumn(10, idxAPPDT);
						gsmt.bindColumn(11, idxEMPNO);
						gsmt.bindColumn(12, idxLAZCD);
						gsmt.bindColumn(13, idxFRDT);
						
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPDT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxLAZCD);
						gsmt.bindColumn(4, idxFRDT);

						gsmt.executeUpdate();
						gsmt.close();
					}
				}
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