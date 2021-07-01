package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a040010_s2 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// ���������� ���� ���۹���� Post Ÿ���� ���
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

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [3];
				str[0]	= req.getParameter("v_str1");		//�����ڵ�
				str[1]	= req.getParameter("v_str2");		//��ǥ����
				str[2]	= req.getParameter("v_str3");		//��ǥ��ȣ

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE", "FSDAT", "FSNBR", "FSSEQ", "ATCODE",
																					"ATKORNAM", "ATDECR", "CHAAMT", "DAEAMT", "FSAMT", "REMARK",
																					"FSREFSEQ01", "FSREFCD01", "FSREFVAL01", "FSREFVAL", "FSREFNM01", "FSRVALNM01",
																					"WRDT", "WRID", "UPDT", "UPID","FSSTAT", "FSNUM"
				}; 

				int[] intArrCN = new int[]{		2,  9,  6,  5, 7,
																		 66,  1, 15, 15, 15, 135,
					                            2,  4, 20, 40, 40, 40,
					                            8,  7,  8,  7, 1,  3
				}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																			-1, -1, 0, 0, 0, -1,
																			-1, -1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.FDCODE FDCODE, A.FSDAT FSDAT, A.FSNBR FSNBR, A.FSSEQ FSSEQ, A.ATCODE ATCODE, " );
					sql.append( "				 B.ATKORNAM ATKORNAM, A.ATDECR ATDECR, CASE WHEN A.ATDECR='1' THEN A.FSAMT ELSE 0 END AS CHAAMT, " );
					sql.append( "        CASE WHEN A.ATDECR='2' THEN A.FSAMT ELSE 0 END AS DAEAMT, nvl(A.FSAMT,0) FSAMT, A.REMARK REMARK, " );
					sql.append( "        '01' FSREFSEQ01, '0030' FSREFCD01, A.PRIMCOST FSREFVAL01, C.CDNAM FSREFVAL, '�����ڵ�' FSREFNM01, '����' FSRVALNM01, " );
					sql.append( "        A.WRDT WRDT, A.WRID WRID, A.UPDT UPDT, A.UPID UPID, D.FSSTAT FSSTAT, A.FSNUM " );
					sql.append( " FROM ACCOUNT.MFSLIPDTL A  " );
					sql.append( " LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE " );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.PRIMCOST = C.CDCODE AND C.CMTYPE='0030' " );
					sql.append( " LEFT JOIN ACCOUNT.MFSLIPMST D ON A.FDCODE=D.FDCODE AND A.FSDAT=D.FSDAT AND A.FSNBR=D.FSNBR ");
					sql.append( " WHERE 'Y'='Y' " );
					if(!str[0].equals(""))	sql.append( " AND A.FDCODE = '"+str[0]+"' " );
					if(!str[1].equals(""))	sql.append( " AND A.FSDAT = '"+str[1]+"' " );
					if(!str[2].equals(""))	sql.append( " AND A.FSNBR = '"+str[2]+"' " );
					sql.append( " ORDER BY A.FSNUM " );
				
/*********************************************************************************************/
					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}