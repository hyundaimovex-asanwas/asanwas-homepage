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
public class a040120_s1 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");		//계산서번호
				

				for (int s=0;s<=0;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK",     "SLIPNO",    "VEND_CD",   "VEND_NM",   "VEND_ID",    "VEND_ID_LEN",
					"TAXSUM",  "TAXVATAMT", "TAXTOT",    "REMARK",    "TAXNBR",     "CONVERSATION_ID", "SUPBUY_TYPE","DIRECTION", "DTI_STATUS",
					"EMPNO",   "EMAIL",     "FDCODE",    "TAXDAT",    "AMEND_CODE", "AMEND_REMARK"
				}; 


				int[] intArrCN = new int[] { 
					 1,  15,  13,    60,  15, 2,
					 11, 11,  11,   132,  11, 35, 2, 1, 1,
					 7,  70,   2,     8,   2, 100
				}; 

			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,  0,
					 0,   0,   0,  -1,  -1, -1, -1,-1,-1,
					-1,  -1,  -1,  -1,  -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT 'F' AS CHK,                                      	\n");	
						sql.append( "        G.SSDAT || G.SSNBR AS SLIPNO,                    	\n");
						sql.append( "        RTRIM(A.VEND_CD) VEND_CD,                        	\n");
						sql.append( "        RTRIM(B.VEND_NM) VEND_NM,                        	\n");
						sql.append( "        RTRIM(B.VEND_ID) VEND_ID,                        	\n");
						sql.append( "        LENGTH(B.VEND_ID) VEND_ID_LEN,                   	\n");
						sql.append( "        COALESCE(A.TAXSUM,0) TAXSUM,                     	\n");
						sql.append( "        COALESCE(A.TAXVATAMT,0) TAXVATAMT,                 \n");	
						sql.append( "        COALESCE(A.TAXTOT,0) TAXTOT,                     	\n");
						sql.append( "        RTRIM(A.REMARK) REMARK , A.TAXNBR , \n");
						sql.append( "        CASE WHEN S.CONVERSATION_ID IS NOT NULL THEN S.CONVERSATION_ID ELSE '' END CONVERSATION_ID, \n");
						sql.append( "        CASE WHEN S.SUPBUY_TYPE IS NOT NULL THEN S.SUPBUY_TYPE ELSE '' END SUPBUY_TYPE,  \n");
						sql.append( "        CASE WHEN S.DIRECTION IS NOT NULL THEN S.DIRECTION ELSE '' END DIRECTION,  \n");
						sql.append( "        S.DTI_STATUS, \n");
						sql.append( "        A.EMPNO, COALESCE(D.EMAIL,'') EMAIL,  A.FDCODE, A.TAXDAT, COALESCE(A.AMEND_CODE,'')AMEND_CODE,COALESCE(A.AMEND_REMARK,'')AMEND_REMARK \n");
						sql.append( "   FROM ACCOUNT.ATTAXMST A                               	\n");
						sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD=B.VEND_CD	\n");
						sql.append( "   LEFT JOIN ACCOUNT.FSLIPMST G ON A.FDCODE=G.FDCODE     	\n");
						sql.append( "                               AND A.FSDAT=G.FSDAT       	\n");	
						sql.append( "                               AND A.FSNBR=G.FSNBR       	\n");
						sql.append( "   LEFT JOIN HDASAN_EDI.XXSB_DTI_STATUS S ON A.CONVERSATION_ID = S.CONVERSATION_ID \n");
						sql.append( "                                         AND A.SUPBUY_TYPE = S.SUPBUY_TYPE         \n");
						sql.append( "                                         AND A.DIRECTION = S.DIRECTION             \n");
						sql.append( "   LEFT JOIN ACCOUNT.CUSTOMER D ON D.VEND_CD = A.VEND_CD AND D.SEQ = A.SEQ         \n");
						sql.append( "  WHERE A.TAXNBR ='"+str[0]+"'      				    \n");
						sql.append( "    AND ( S.DTI_STATUS IS NULL OR S.DTI_STATUS ='S' )  \n");
						sql.append( "    AND A.EXTCHK <>'1'   \n");  //외부발행이 아닌건
						
						//System.out.println("a040120_s1: \n" + sql.toString());
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