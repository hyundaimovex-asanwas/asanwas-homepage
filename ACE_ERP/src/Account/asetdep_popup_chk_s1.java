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
public class asetdep_popup_chk_s1 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //�Ҽ�
				String  str2 = req.getParameter("v_str2");    //����

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CNT"
				                                };  

				int[] intArrCN = new int[]{ 2
					                        }; 
					
				int[] intArrCN2 = new int[]{0
				                            }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					
					sql.append( " SELECT COUNT(*) CNT        																								\n");
					sql.append( "   FROM ACCOUNT.ASTYEPR A   																							\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMOVINGN C ON C.FDCODE = A.FDCODE AND C.ATCODE = A.ATCODE 	\n");  //��ü��Ų ���� ��ü ���� üũ
					sql.append( "                                 AND C.AST1ST = A.AST1ST AND C.AST2ND = A.AST2ND 				\n");
					sql.append( "                                 AND C.AST3RD = A.AST3RD AND C.ASTSEQ = A.ASTSEQ 			\n");
					sql.append( "                                 AND C.FDCODE ='" + str1 + "'                    \n");
					sql.append( "                                 AND C.ASTGUBUN='8'                              \n");
					sql.append( "  WHERE 1=1 																			\n");
					sql.append( "    AND A.REGIGB <>'2' 																\n"); //��ü�󰢵�� ���� �ƴѰ�츸 üũ��.
					sql.append( "    AND NOT EXISTS ( SELECT *                       							\n"); //�Ű�,���ǵ� ���ܽ�Ŵ.
					sql.append( "    				   FROM ACCOUNT.ASTCHG B                 	\n"); 
					sql.append( "    				  WHERE B.FDCODE =A.FDCODE               \n"); 
					sql.append( "    				    AND B.ATCODE = A.ATCODE              	\n"); 
					sql.append( "    				    AND B.AST1ST = A.AST1ST              		\n"); 
					sql.append( "    				    AND B.AST2ND = A.AST2ND              		\n"); 
					sql.append( "    				    AND B.AST3RD = A.AST3RD              	\n"); 
					sql.append( "    				    AND B.ASTSEQ = A.ASTSEQ              	\n"); 
					sql.append( "    				    AND B.CHGTYPE IN ( '1','2')          		\n"); 
					sql.append( "    				    AND B.CHGDATE >=A.ASTYM||'31'        \n"); 
					sql.append( "    				 )                                       					\n"); 
					sql.append( "    AND C.MOVDATE <='"+str2+"'||'31'                			\n"); 
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "'  			\n" );
					if (!str2.equals("")) sql.append( " AND A.ASTYM  = '" + str2 + "'  			\n" );
		
					//logger.dbg.println( this, sql.toString() );
					//System.out.println("asetdep_popup_chk_s1 \n"+sql.toString() );
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