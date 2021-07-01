package NewPurch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class np00020_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");   //gclx_usts.bindcolval ��������
				String  str2	= req.getParameter("v_str2");   // gclx_cmsosok.bindcolval �Ҽӱ����̰ڰ�
				String  str3	= req.getParameter("v_str3");   // txt_nm.value  �̸��̰�

				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				if (str3==null) str3=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																				"c_comp_name",	
																				"c_treat_material",	
																				"c_charger",
																				"c_grade",																							
																				"c_phone",
																				
																				"c_hp",	
																				"c_fax",																				
																				"c_section",																				
																				"c_date",   
																
																			}; 	
																					
				int[] intArrCN = new int[] { 
																				40, 100, 
																				
																				20, 20, 20, 20, 				

																				20, 30, 8 																																								 	

																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1, 
																				
																				-1,-1, -1,-1,		
																				
																				-1,-1, -1

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();


						sql.append( "	SELECT  A.c_comp_name, A.c_treat_material,           								\n");
						
						sql.append( "			A.c_charger,  A.c_grade, A.c_phone,  A.c_hp,								\n");

						sql.append( "			A.c_fax,  A.c_section, A.c_date														\n");
						
						sql.append( "		FROM PURCH.TRANCOMPTBL A                                                          \n");
						
						sql.append( "	WHERE 1=1                           																	\n");



		   //				 logger.dbg.println(this,sql.toString());
           
						stmt = conn.getGauceStatement(sql.toString());
						stmt.executeQuery(dSet);
		 				
					}
				
/*********************************************************************************************/

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
