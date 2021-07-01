package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h090004_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");	//��û�� from
				String  str2	= req.getParameter("v_str2");	//��û�� to
				String  str3	= req.getParameter("v_str3");	//����[A:���� B:�̰��� C:������� D:��ü]
				String  str4	= req.getParameter("v_str4");	//�����ڻ��
				String  str5	= req.getParameter("v_str5");	//�μ�

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",		"APPDT",  "LAZCD",  "LAZNM" ,		"EMPNO",	"EMPNMK", 
																					"FRDT",		"FRTIME", "TODT",		"TOTIME",		"SGDT",
																					"SGNM",		"SGNID",	"AGRDT",	"AGNM",			"AGRID",  
																					"DTYREM", "DEPTNM"
																				}; 

				int[] intArrCN = new int[]{ 1,	8,  4,  30, 7, 20, 
																		8,	6,  8,  6,  8, 
																	 20,	7,	8, 20,	7, 
																	 40, 50
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, 
																		 -1, -1, -1, -1, -1, 
																	   -1, -1, -1, -1, -1, 
																		 -1, -1
																	}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT \n");
					sql.append( " 'F' as CHK, RTRIM(D.APPDT) APPDT, RTRIM(D.LAZCD) LAZCD, RTRIM(F.MINORNM) LAZNM, RTRIM(D.EMPNO) EMPNO, \n");
					sql.append( " RTRIM(A.EMPNMK) EMPNMK,  RTRIM(D.FRDT) FRDT, RTRIM(D.FRTIME) FRTIME, RTRIM(D.TODT) TODT, \n");
					sql.append( " RTRIM(D.TOTIME) TOTIME, RTRIM(D.SGDT) SGDT,  B.EMPNMK AS SGNM, \n");
					sql.append( " RTRIM(D.SGNID) SGNID, RTRIM(D.AGRDT) AGRDT,  C.EMPNMK AS AGNM, \n");
					sql.append( " RTRIM(D.AGRID) AGRID, RTRIM(D.DTYREM) DTYREM, RTRIM(E.DEPTNM) DEPTNM \n");
					sql.append( " FROM PAYROLL.HLDUTY D \n");
					sql.append( "	LEFT JOIN PAYROLL.T_HIPERSON A ON A.EMPNO  =  D.EMPNO \n");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO  =  D.SGNID \n");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON C ON C.EMPNO  =  D.AGRID \n");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT	 E ON E.DEPTCD =  A.DEPTCD \n");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE  F ON F.MINORCD = D.LAZCD AND F.MAJORCD = '1124' \n");
					sql.append( " WHERE APPDT BETWEEN '"+str1+"' AND '"+str2+"' \n");
					//sql.append( " AND A.USESTS = '1' ");	//����
					
					if (str3.equals("A"))  {	sql.append( " AND ((SGDT is not null || SGDT = '') AND SGDT != '99999999') \n" );	//����
					}else if (str3.equals("B"))  {	sql.append( " AND (SGDT is null || SGDT = '') \n" );	  			//�̰���
					}else if (str3.equals("C"))  {	sql.append( " AND SGDT = '99999999' \n"); }									//�������
					
					if (!str4.equals(""))  {	sql.append( " AND D.SGNID = '"+str4+"' \n"); }	//�����ڸ�
					
					if (str5.equals("A000")||str5.equals("")) {		//��ü�μ�
						sql.append( " ORDER BY APPDT, EMPNO \n");
					} else {
						sql.append( " AND D.DEPTCD = '"+str5+"' "); 		
						sql.append( " ORDER BY APPDT, EMPNO \n");
					}

					//logger.dbg.println(this, sql.toString());
					
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