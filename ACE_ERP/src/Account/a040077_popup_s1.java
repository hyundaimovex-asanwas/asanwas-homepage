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
public class a040077_popup_s1 extends HttpServlet {
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
				String []  str	= new String [5];
				str[0] = req.getParameter("v_str1");		//작성일자 fr 
				str[1] = req.getParameter("v_str2");		//작성일자 to
				str[2] = req.getParameter("v_str3");		//거래처명
				str[3] = req.getParameter("v_str4");		//거래처코드 
				str[4] = req.getParameter("v_str5");		//사번 
				
				for (int s=0;s<=4;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK",               "APPROVE_ID",    "DTI_WDATE",         "SUP_COM_REGNO",    "SUP_COM_NAME",       "SUP_TEL_NUM",
					"SUP_EMP_NAME",      "SUP_EMAIL",     "BYR_COM_REGNO",     "BYR_COM_NAME",     "SUP_AMOUNT",       
					"TAX_AMOUNT",        "TOTAL_AMOUNT",  "DTI_TYPE",          "DTI_STATUS",       "BYR_COM_REGNO_LEN",
					"ORI_BYR_COM_REGNO", "DTI_TYPE_NM",   "BYR_EMP_NAME",      "BYR_EMAIL",        "EMPNO",
					"REMARK" ,           "ENO_NM",        "VEND_CD",           "VEND_ID",          "VEND_NM" 
					
				}; 

				int[] intArrCN = new int[] { 
					 1,  24,  10,   10,  35,  20, 
					35,  70,  13,   70,  18,  
					11,  18,   3,    1,   2,
					13,  10,  35,   70,   7,
				   132,  30,  10,   13,  50 	
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1, -1, 
					-1,  -1,  -1,  -1,   0,   
					 0,   0,  -1,  -1,   0,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT 'F' CHK, A.APPROVE_ID, A.DTI_WDATE,                                                	\n");
					sql.append( "        A.SUP_COM_REGNO, A.SUP_COM_NAME, A.SUP_TEL_NUM,  A.SUP_EMP_NAME, A.SUP_EMAIL,         	\n");
					sql.append( "        CASE WHEN LENGTH (A.BYR_COM_REGNO)=10 THEN A.BYR_COM_REGNO                         	\n");
					sql.append( "             WHEN LENGTH (A.BYR_COM_REGNO)=13 THEN SUBSTR(A.BYR_COM_REGNO,1,7)||'******'   	\n");
					sql.append( "             ELSE 'xxxxxxx' END BYR_COM_REGNO,                                             	\n");
					sql.append( "        A.BYR_COM_NAME,                                                                    	\n");
					sql.append( "        A.SUP_AMOUNT, A.TAX_AMOUNT, A.TOTAL_AMOUNT, A.DTI_TYPE , B.DTI_STATUS,              	\n");
					sql.append( "        LENGTH(A.BYR_COM_REGNO) BYR_COM_REGNO_LEN , A.BYR_COM_REGNO AS ORI_BYR_COM_REGNO,      \n");
					sql.append( "        CASE WHEN A.DTI_TYPE ='01' AND A.TAX_AMOUNT!=0 THEN '과세'                              \n");
					sql.append( "             WHEN A.DTI_TYPE ='01' AND A.TAX_AMOUNT=0  THEN '영세'                              \n"); 
					sql.append( "             WHEN A.DTI_TYPE ='02' THEN '면세' END DTI_TYPE_NM,                                 \n"); 
					sql.append( "        A.BYR_EMP_NAME, A.BYR_EMAIL,  C.EMPNO, C.REMARK ,E.ENO_NM,                             \n"); 
					sql.append( "        C.VEND_CD, D.VEND_ID, D.VEND_NM                                                        \n");
					sql.append( "   FROM HDASAN_EDI.XXSB_DTI_MAIN A, HDASAN_EDI.XXSB_DTI_STATUS B,                           	\n");
					sql.append( "        ACCOUNT.ATTAXMST C, ACCOUNT.GCZM_VENDER D, ASNHR.T_CM_PERSON E                        	\n");
					sql.append( "  WHERE A.CONVERSATION_ID = B.CONVERSATION_ID                                              	\n");
					sql.append( "    AND A.SUPBUY_TYPE = B.SUPBUY_TYPE                                                      	\n");
					sql.append( "    AND A.DIRECTION = B.DIRECTION                                                          	\n");
					sql.append( "    AND A.DTI_WDATE BETWEEN '"+str[0]+"' AND '"+str[1]+"'                                      \n");
					sql.append( "    AND A.SUPBUY_TYPE ='AR'                                                                	\n");
					sql.append( "    AND B.DTI_STATUS IN ('I','C') --수신미승인, 수신승인건만                                                                            	\n");
					sql.append( "    AND A.CONVERSATION_ID = C.CONVERSATION_ID(+)  \n");
					sql.append( "    AND A.SUPBUY_TYPE = C.SUPBUY_TYPE(+)          \n");
					sql.append( "    AND A.DIRECTION = C.DIRECTION(+)              \n");
					sql.append( "    AND C.VEND_CD = D.VEND_CD(+)                  \n");
					sql.append( "    AND C.EMPNO = E.ENO_NO(+)                     \n");
											
					if(!str[3].equals(""))sql.append( " AND C.VEND_CD ='"+str[3]+"'             \n");
					if(!str[2].equals(""))sql.append( " AND RTRIM(D.VEND_NM) LIKE '"+str[2]+"%' \n");
					if(!str[4].equals(""))sql.append( " AND C.EMPNO  IN ( '"+str[4]+"')			\n");
					
					sql.append( "  ORDER BY A.DTI_WDATE,A.BYR_COM_REGNO  \n");
					
					//System.out.println("a040077_popup_s1::"+sql.toString());
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