package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030007_t5 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");			//사번
				int idxAPPDT			= userSet.indexOfColumn("APPDT");			//귀속년도
				int idxRELAT1		= userSet.indexOfColumn("RELAT1");			//본인여부
				int idxFAMNM1		= userSet.indexOfColumn("FAMNM1");		//성명
				int idxRESINO1     = userSet.indexOfColumn("RESINO1");		//주민번호

				int idxRELATION    = userSet.indexOfColumn("RELATION");		//관계
				int idxINDNO		= userSet.indexOfColumn("INDNO");			//의료기관코드
				int idxINDNAME  = userSet.indexOfColumn("INDNAME");			//의료기관명

				int idxCARDCNTA  = userSet.indexOfColumn("CARDCNTA");		//카드건수
				int idxCARDAMTA  = userSet.indexOfColumn("CARDAMTA");		//카드금액
				int idxCASHCNTA  = userSet.indexOfColumn("CASHCNTA");		//현금건수
				int idxCASHAMTA  = userSet.indexOfColumn("CASHAMTA");		//현금금액

				int idxCARDCNTB  = userSet.indexOfColumn("CARDCNTB");		//카드건수
				int idxCARDAMTB  = userSet.indexOfColumn("CARDAMTB");		//카드금액
				int idxCASHCNTB  = userSet.indexOfColumn("CASHCNTB");		//현금건수
				int idxCASHAMTB  = userSet.indexOfColumn("CASHAMTB");		//현금금액

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.YCPRSNY ( ");
				InsertSql.append( " EMPNO,	  APPDT,		RELAT1,  FAMNM1, RESINO1, ");
				InsertSql.append( " RELATION,  INDNO,		INDNAME, ");
				InsertSql.append( " CARDCNTA, CARDAMTA, CASHCNTA, CASHAMTA,    ");
				
				InsertSql.append( " CARDCNTB, CARDAMTB,  CASHCNTB,  CASHAMTB   ");
				InsertSql.append( ") VALUES( " );

				InsertSql.append( " ?,	  ?,	?,  ?, ?, ");
				InsertSql.append( " ?,  ?,	 ?, ");
				InsertSql.append( " ?,	 ?,	 ?, ?,    ");
				InsertSql.append( " ?, ?,  ?,  ? )   ");
			  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.YCPRSNY SET ");
				UpdateSql.append( " RELAT1 = ?, ");
				UpdateSql.append( " FAMNM1 = ?, ");
				UpdateSql.append( " RELATION = ?, ");
				UpdateSql.append( " INDNAME = ?, ");

				UpdateSql.append( " CARDCNTA = ?, ");
				UpdateSql.append( " CARDAMTA = ?, ");
				UpdateSql.append( " CASHCNTA = ?, ");
				UpdateSql.append( " CASHAMTA = ?, ");

				UpdateSql.append( " CARDCNTB = ?, ");
				UpdateSql.append( " CARDAMTB = ?, ");
				UpdateSql.append( " CASHCNTB = ?, ");
				UpdateSql.append( " CASHAMTB = ?  ");

		
				UpdateSql.append( " WHERE EMPNO = ? AND APPDT = ? AND RESINO1 = ? AND INDNO = ?");

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.YCPRSNY WHERE EMPNO = ? AND APPDT = ? AND RESINO1 = ? AND INDNO = ? ");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

			
						gsmt.bindColumn(1,  idxEMPNO);
						gsmt.bindColumn(2,  idxAPPDT);
						gsmt.bindColumn(3,  idxRELAT1);
						gsmt.bindColumn(4,  idxFAMNM1);
						gsmt.bindColumn(5,  idxRESINO1);

						gsmt.bindColumn(6,  idxRELATION);
						gsmt.bindColumn(7,  idxINDNO);
						gsmt.bindColumn(8,  idxINDNAME);

						gsmt.bindColumn(9,  idxCARDCNTA);
						gsmt.bindColumn(10,  idxCARDAMTA);
						gsmt.bindColumn(11,  idxCASHCNTA);
						gsmt.bindColumn(12,  idxCASHAMTA);

						gsmt.bindColumn(13,  idxCARDCNTB);
						gsmt.bindColumn(14,  idxCARDAMTB);
						gsmt.bindColumn(15,  idxCASHCNTB);
						gsmt.bindColumn(16,  idxCASHAMTB);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxRELAT1);
						gsmt.bindColumn(2,  idxFAMNM1);
						gsmt.bindColumn(3,  idxRELATION);
						gsmt.bindColumn(4,  idxINDNAME);
						gsmt.bindColumn(5,  idxCARDCNTA);
						gsmt.bindColumn(6,  idxCARDAMTA);
						gsmt.bindColumn(7,  idxCASHCNTA);
						gsmt.bindColumn(8,  idxCASHAMTA);

						gsmt.bindColumn(9,  idxCARDCNTB);
						gsmt.bindColumn(10,  idxCARDAMTB);
						gsmt.bindColumn(11,  idxCASHCNTB);
						gsmt.bindColumn(12,  idxCASHAMTB);


						gsmt.bindColumn(13,   idxEMPNO);
						gsmt.bindColumn(14, idxAPPDT);
						gsmt.bindColumn(15, idxRESINO1);
						gsmt.bindColumn(16, idxINDNO);
					
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxEMPNO);
						gsmt.bindColumn(2,  idxAPPDT);
						gsmt.bindColumn(3,  idxRESINO1);
						gsmt.bindColumn(4,  idxINDNO);
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