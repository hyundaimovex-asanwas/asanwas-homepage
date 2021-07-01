package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a040120_s2 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String []  str	= new String [1];
				str[0] = req.getParameter("v_str1");	//지점

				for (int s=0;s<=0;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"CHK",
					"CONVERSATION_ID", "SUPBUY_TYPE",    "DIRECTION",       "INTERFACE_BATCH_ID", "DTI_WDATE",         
					"BLANK_CNT",       "DTI_TYPE",       "TAX_DEMAND",      "SUP_COM_ID",         "SUP_COM_REGNO",     
					"SUP_REP_NAME",    "SUP_COM_NAME",   "SUP_COM_TYPE",    "SUP_COM_CLASSIFY",   "SUP_COM_ADDR",      
					"SUP_DEPT_NAME",   "SUP_EMP_NAME",   "SUP_TEL_NUM",     "SUP_EMAIL",          "BYR_COM_ID",        
					"BYR_COM_REGNO",   "BYR_REP_NAME",   "BYR_COM_NAME",    "BYR_COM_TYPE",       "BYR_COM_CLASSIFY",  
					"BYR_COM_ADDR",    "BYR_DEPT_NAME",  "BYR_EMP_NAME",    "BYR_TEL_NUM",        "BYR_EMAIL",         
					"SUP_AMOUNT",      "TAX_AMOUNT",     "TOTAL_AMOUNT",    "DTT_YN",             "DTI_STATUS",
					"RETURN_CODE",     "RETURN_DESCRIPTION",  "SBDESCRIPTION", "AMEND_CODE",      "REMARK"
				}; 
				
				int[] intArrCN = new int[] { 
					  1,  
					 35,   2,   1,    15,   10,
					  2,   3,   2,    20,   10,
					 35,  70,  40,    40,  150,
					 40,  35,  20,    70,   20,
					 13,  35,  70,    40,   40,
					150,  40,  35,    20,   70,
					 12,  12,  12,     1,    1,
					  5, 2000, 70,     2,   100
				}; 

				int[] intArrCN2 = new int[]{ 
					-1, 
					-1,  -1,  -1,   0,  -1, 
					 0,  -1,  -1,  -1,  -1, 
		            -1,  -1,  -1,  -1,  -1, 
		            -1,  -1,  -1,  -1,  -1, 
		            -1,  -1,  -1,  -1,  -1, 
		            -1,  -1,  -1,  -1,  -1, 
		             0,   0,   0,  -1,  -1,
					-1,  -1, -1,   -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT 'F' CHK,                                                                                                         														\n");	
						sql.append( "        A.CONVERSATION_ID, A.SUPBUY_TYPE,    A.DIRECTION,       COALESCE(A.INTERFACE_BATCH_ID,0)INTERFACE_BATCH_ID,  \n");
						sql.append( "        TO_CHAR(DTI_WDATE,'YYYY-MM-DD') DTI_WDATE,     															  \n");
						sql.append( "        NVL(A.BLANK_CNT,0)BLANK_CNT,    A.DTI_TYPE,       A.TAX_DEMAND,      A.SUP_COM_ID,         A.SUP_COM_REGNO,  \n");
						sql.append( "        A.SUP_REP_NAME,    A.SUP_COM_NAME,   A.SUP_COM_TYPE,    A.SUP_COM_CLASSIFY,   A.SUP_COM_ADDR,       	      \n");
						sql.append( "        A.SUP_DEPT_NAME,   A.SUP_EMP_NAME,   A.SUP_TEL_NUM,     A.SUP_EMAIL,          A.BYR_COM_ID,         		  \n");
						sql.append( "        A.BYR_COM_REGNO,   A.BYR_REP_NAME,   A.BYR_COM_NAME,    A.BYR_COM_TYPE,       A.BYR_COM_CLASSIFY,   		  \n");
						sql.append( "        A.BYR_COM_ADDR,    A.BYR_DEPT_NAME,  A.BYR_EMP_NAME,    A.BYR_TEL_NUM,        A.BYR_EMAIL,          		  \n");	
						sql.append( "        A.SUP_AMOUNT,      A.TAX_AMOUNT,     A.TOTAL_AMOUNT,    A.DTT_YN,             C.DTI_STATUS,         		  \n");
						sql.append( "        COALESCE(C.RETURN_CODE,'')RETURN_CODE,    COALESCE(C.RETURN_DESCRIPTION,'')RETURN_DESCRIPTION ,     	      \n");
						sql.append( "        COALESCE(C.SBDESCRIPTION,'')SBDESCRIPTION,                                                          		  \n");
						sql.append( "        A.AMEND_CODE,      A.REMARK                                                                         		  \n");
						sql.append( "   FROM HDASAN_EDI.XXSB_DTI_MAIN A                                            										  \n");
                        sql.append( "   LEFT JOIN HDASAN_EDI.XXSB_DTI_STATUS C ON A.CONVERSATION_ID = C.CONVERSATION_ID      			                  \n");
						sql.append( "    AND A.SUPBUY_TYPE = C.SUPBUY_TYPE                                                                       		  \n");
						sql.append( "    AND A.DIRECTION = C.DIRECTION                                                                           		  \n");
						sql.append( "   LEFT JOIN ACCOUNT.ATTAXMST T ON T.CONVERSATION_ID=A.CONVERSATION_ID AND T.SUPBUY_TYPE=A.SUPBUY_TYPE      	      \n");
						sql.append( "                               AND T.DIRECTION= A.DIRECTION                                                 		  \n");
						sql.append( "   LEFT JOIN PAYROLL.V_HIPERSON V ON UPPER(V.EMAIL) = UPPER(A.SUP_EMAIL)                                    	      \n");
						sql.append( "  WHERE A.SUPBUY_TYPE = 'AR'                                                                                         \n");
						sql.append( "    AND T.TAXNBR = '"+str[0]+"'                                                                                      \n");
						sql.append( "  ORDER BY DTI_WDATE DESC,   A.BYR_COM_REGNO                                                                         \n");
						
						//System.out.println("a040120_s2====>\n"+sql.toString());
						//logger.dbg.println(this,sql.toString()); 

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