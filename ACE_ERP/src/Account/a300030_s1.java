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
public class a300030_s1 extends HttpServlet {
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
				String []  str	= new String [8];
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//�ŷ�ó
				str[2] = req.getParameter("v_str3");	//��������_fr
				str[3] = req.getParameter("v_str4");	//��������_to
				str[4] = req.getParameter("v_str5");	//��������_fr
				str[5] = req.getParameter("v_str6");	//��������_to
				str[6] = req.getParameter("v_str7");	//��������
				str[7] = req.getParameter("v_str8");	//�����
				
			
				for(int i=0;i<=7;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"PAYDAT", "FULDAT",  "REMARK",  "VENDCD", "VEND_NM",
					"JANAMT", "EMPNO",   "ENO_NM" }; 

				int[] intArrCN = new int[] { 
					 8,   8, 100,  10,  60,
					15,	 10,  20
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
				 	 0,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( "  SELECT A.PAYDAT, A.FULDAT, A.REMARK, A.VENDCD,C.VEND_NM,            \n");	
						sql.append( "         A.JANAMT, B.EMPNO,D.ENO_NM                                   \n");	
						sql.append( "    FROM ACCOUNT.ACUSTPAY A,                                          \n");	
						sql.append( "         ACCOUNT.FSLIPMST B,                                          \n");	
						sql.append( "         ACCOUNT.GCZM_VENDER C,                                       \n");	
						sql.append( "         ASNHR.T_CM_PERSON D                                          \n");	
						sql.append( "   WHERE A.FDCODE = B.FDCODE                                          \n");	
						sql.append( "     AND A.TSDAT  = B.FSDAT                                           \n");	
						sql.append( "     AND A.TSNBR  = B.FSNBR                                           \n");	
						sql.append( "     AND A.VENDCD = C.VEND_CD(+)                                      \n");	
						sql.append( "     AND B.EMPNO= D.ENO_NO(+)                                         \n");	
						sql.append( "     AND A.CHKBILL ='T'                                               \n");
						if(!str[0].equals(""))sql.append( "   AND A.FDCODE ='"+str[0]+"'                   \n");	
						if(!str[1].equals(""))sql.append( "   AND A.VENDCD ='"+str[1]+"'                   \n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( "   AND A.FULDAT >='"+str[2]+"' AND A.FULDAT<='"+str[3]+"'  --��������   \n");
						else if(!str[2].equals("")&&str[3].equals(""))sql.append( "   AND A.FULDAT >='"+str[2]+"' --��������   \n");
						
						if(!str[4].equals("")&&!str[5].equals(""))sql.append( "   AND A.PAYDAT >='"+str[4]+"' AND A.PAYDAT<='"+str[5]+"'  --��������   \n");	
						else if(!str[4].equals("")&&str[5].equals(""))sql.append( "   AND A.PAYDAT >='"+str[4]+"'   --��������   \n");	
						if(!str[7].equals(""))sql.append( "   AND B.EMPNO IN ('"+str[7]+"')                \n");	
						sql.append( "   ORDER BY A.FULDAT, A.PAYDAT, C.VEND_NM                             \n");
						
						/*
						if(!str[0].equals(""))sql.append( "    AND X.FDCODE ='"+str[0]+"'       \n");
						if(!str[1].equals(""))sql.append( "    AND X.VENDCD ='"+str[1]+"'       \n");
						if(!str[2].equals(""))sql.append( "    AND X.ENDDT >='"+str[2]+"'       \n");
						if(!str[3].equals(""))sql.append( "    AND X.JOBDT='"+str[3]+"'         \n");
						sql.append( "  ORDER BY X.JOBDT, X.ENDDT, G.VEND_NM \n");
						*/
						/*
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'							\n");	//����
						if(!str[1].equals("")) sql.append( " AND A.FUNDDIV='"+str[1]+"' 							\n");	//�ڱݱ���
						if(!str[2].equals("")) sql.append( " AND A.ENDDATE BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//��������
						if(!str[4].equals("")) sql.append( " AND C.CDNAM LIKE '"+str[4]+"%'						\n");	//�����
						*/

						//System.out.println("# a300030_s1 Query : \n" + sql);
						
/*********************************************************************************************/
					
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  	System.err.println(e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			System.err.println(e);
			//logger.dbg.println(this,e.toString());
			
		} finally {
			loader.restoreService(service);
  	}
	}
}