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
public class a080003_s3 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//��û����ȣ

				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","BGTRQNO","BGTAMT","REBGTAMT",
					"RESULTAMT","REMAINTAMT","BGTRQAMT","WHYRQNOTE"
				}; 

				int[] intArrCN = new int[] { 
					2,  12,  15,  15,  
				 15, 	15,  15,  60 
				}; 
			
				int[] intArrCN2 = new int[]{ 
				  -1,  -1,	 0,   0,   
					 0,   0,   0,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT              																					\n");	
						sql.append( "			RTRIM(A.FDCODE) FDCODE,								/*��������*/      		\n");	
						sql.append( "			RTRIM(A.BGTRQNO) BGTRQNO,						/*��û����ȣ*/    	\n");	
						sql.append( "			COALESCE(A.BGTAMT,0) BGTAMT,					/*������*/				\n");
						sql.append( "			COALESCE(A.REBGTAMT,0) REBGTAMT,			/*�������*/			\n");
						sql.append( "			COALESCE(A.RESULTAMT,0) RESULTAMT,			/*�����ഩ���*/		\n");
						sql.append( "			COALESCE(A.REMAINTAMT,0) REMAINTAMT,		/*�������ܾ�*/		\n");
						sql.append( "			COALESCE(A.BGTRQAMT,0) BGTRQAMT,			/*��û��*/				\n");
						sql.append( "			RTRIM(A.WHYRQNOTE) WHYRQNOTE          		/*��û����*/			\n");
						sql.append( " FROM ACCOUNT.BGTRQDTL2	A																				\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																				\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'										\n");	//�����ڵ�
						if(!str[1].equals("")) sql.append( " AND A.BGTRQNO = '"+str[1]+"'									\n");	//��û����ȣ

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