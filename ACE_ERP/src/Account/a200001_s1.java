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
public class a200001_s1 extends HttpServlet {
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
				String []  str	= new String [7];
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//����
				str[2] = req.getParameter("v_str3");	//��������fr
				str[3] = req.getParameter("v_str4");	//��������to
				str[4] = req.getParameter("v_str5");	//�����
				str[5] = req.getParameter("v_str6");	//�����ڵ�
				str[6] = req.getParameter("v_str7");	//ó������

				for(int i=0;i<=6;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE", "ATCODE", "FUNDDIV", "BANCOD", "REFCODE2", 
					"GETDATE", "GETMEN", "BCDIV", "STDIV", "STDATE",
					"BANNAM"
				}; 

				int[] intArrCN = new int[] {
					2, 7, 2, 6, 30, 
					8, 20, 1, 1, 8,
				 66
				}; 
			
				int[] intArrCN2 = new int[]{
					-1, -1, -1, -1, -1, 
					-1, -1, -1, -1, -1,
					-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT												\n");
						sql.append( " RTRIM(A.FDCODE)   FDCODE,			\n");
						sql.append( " RTRIM(A.ATCODE)   ATCODE,			\n");
						sql.append( " RTRIM(A.FUNDDIV)  FUNDDIV,		\n");
						sql.append( " RTRIM(A.BANCOD)   BANCOD,			\n");
						sql.append( " RTRIM(A.REFCODE2) REFCODE2,   \n");
						sql.append( " RTRIM(A.GETDATE)  GETDATE,		\n");
						sql.append( " RTRIM(A.GETMEN)   GETMEN,			\n");
						sql.append( " RTRIM(A.BCDIV)    BCDIV,      \n");
						sql.append( " RTRIM(A.STATDIV)  STDIV,			\n");
						sql.append( " RTRIM(A.STDATE)   STDATE,			\n");;
						sql.append( " RTRIM(B.CDNAM)    BANNAM			\n");;
						sql.append( " FROM ACCOUNT.ABILLCHK A,ACCOUNT.COMMDTIL B				\n");
						sql.append( " WHERE A.BANCOD=B.CDCODE AND B.CMTYPE='0022'				\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'	\n");	//����
						if(!str[1].equals("")) sql.append( " AND A.BCDIV  ='"+str[1]+"' \n");	//����
						if(!str[2].equals("")) sql.append( " AND A.GETDATE BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//��������
						if(!str[4].equals("")) sql.append( " AND B.CDNAM LIKE '"+str[4]+"%'	\n");	//�����
						if(!str[5].equals("")) sql.append( " AND A.BANCOD='"+str[5]+"'			\n");	//�����ڵ�
						if(!str[6].equals("")) sql.append( " AND A.STATDIV='"+str[6]+"'			\n");	//ó������
						
						//logger.dbg.println(this,sql.toString());
						//System.out.println("a200001_s1: \n" + sql.toString());
/*********************************************************************************************/
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);

					logger.dbg.println( this, sql.toString() );
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