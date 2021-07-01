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
public class a040065_s2 extends HttpServlet {
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
				String []  str	= new String [13];
				str[0] = req.getParameter("v_str1");		//지점
				str[1] = req.getParameter("v_str2");		//사업자등록번호 ( 사업소 코드에 의해 결정됨 )
				str[2] = req.getParameter("v_str3");		//계산서기간 from
				str[3] = req.getParameter("v_str4");		//계산서기간 to
				str[4] = req.getParameter("v_str5");		//사업자등록번호
				str[5] = req.getParameter("v_str6");		//거래처명
				str[6] = req.getParameter("v_str7");		//거래처코드
				str[7] = req.getParameter("v_str8");		//발행구분 2 - 정발행 , 1 -역발행
				str[8] = req.getParameter("v_str9");		//상태
				str[9] = req.getParameter("v_str10");		//id
				str[10] = req.getParameter("v_str11");  //참조가능사번
				str[11] = req.getParameter("v_str12");  //참조가능부서
				str[12] = req.getParameter("v_str13"); //관리자 구분 ( M 관리자) 

				for (int s=0;s<=12;s++) {
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
					"RETURN_CODE",     "RETURN_DESCRIPTION",  "SBDESCRIPTION"
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
					  5, 2000, 70
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
					-1,  -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT 'F' CHK,                                                                                             \n");	
						sql.append( "        A.CONVERSATION_ID, A.SUPBUY_TYPE,    A.DIRECTION,       COALESCE(A.INTERFACE_BATCH_ID,'0')INTERFACE_BATCH_ID, A.DTI_WDATE,          \n");
						sql.append( "        COALESCE(A.BLANK_CNT,0)BLANK_CNT,    A.DTI_TYPE,       A.TAX_DEMAND,      A.SUP_COM_ID,         A.SUP_COM_REGNO,      \n");
						sql.append( "        A.SUP_REP_NAME,    A.SUP_COM_NAME,   A.SUP_COM_TYPE,    A.SUP_COM_CLASSIFY,   A.SUP_COM_ADDR,       \n");
						sql.append( "        A.SUP_DEPT_NAME,   A.SUP_EMP_NAME,   A.SUP_TEL_NUM,     A.SUP_EMAIL,          A.BYR_COM_ID,         \n");
						sql.append( "        A.BYR_COM_REGNO,   A.BYR_REP_NAME,   A.BYR_COM_NAME,    A.BYR_COM_TYPE,       A.BYR_COM_CLASSIFY,   \n");
						sql.append( "        A.BYR_COM_ADDR,    A.BYR_DEPT_NAME,  A.BYR_EMP_NAME,    A.BYR_TEL_NUM,        A.BYR_EMAIL,          \n");	
						sql.append( "        A.SUP_AMOUNT,      A.TAX_AMOUNT,     A.TOTAL_AMOUNT,    A.DTT_YN,             C.DTI_STATUS,         \n");
						sql.append( "        COALESCE(C.RETURN_CODE,'')RETURN_CODE,    COALESCE(C.RETURN_DESCRIPTION,'')RETURN_DESCRIPTION ,     \n");
						sql.append( "        COALESCE(C.SBDESCRIPTION,'')SBDESCRIPTION                                                           \n");
						sql.append( "   FROM HDASAN_EDI.XXSB_DTI_MAIN A, HDASAN_EDI.XXSB_DTI_STATUS C                                            \n");
						sql.append( "   LEFT JOIN ACCOUNT.ATTAXMST T ON T.CONVERSATION_ID=A.CONVERSATION_ID AND T.SUPBUY_TYPE=A.SUPBUY_TYPE      \n");
						sql.append( "                               AND T.DIRECTION= A.DIRECTION                                                 \n");
						sql.append( "   LEFT JOIN PAYROLL.V_HIPERSON V ON UPPER(V.EMAIL) = UPPER(A.SUP_EMAIL)                                    \n");
						sql.append( "  WHERE A.CONVERSATION_ID = C.CONVERSATION_ID                                                               \n");
						sql.append( "    AND A.SUPBUY_TYPE = C.SUPBUY_TYPE                                                                       \n");
						sql.append( "    AND A.DIRECTION = C.DIRECTION                                                                           \n");
						sql.append( "    AND A.SUPBUY_TYPE = 'AR'                                                                                \n");
																		
						if(str[7].equals("2")&&!str[8].equals("O"))sql.append( " AND T.FDCODE ='"+str[0]+"' \n");  //역발행일 경우 지점 체크 안함. (
						if(!str[1].equals(""))sql.append( "    AND A.SUP_COM_REGNO ='"+str[1]+"'       \n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( "  AND A.DTI_WDATE BETWEEN '"+str[2]+"'  AND '"+str[3]+"'  \n");
						if(!str[4].equals(""))sql.append( "    AND A.BYR_COM_REGNO ='"+str[4]+"'      \n");
						if(!str[5].equals(""))sql.append( "    AND RTRIM(A.BYR_COM_NAME) LIKE '"+str[5]+"%' 	\n");
						if(!str[7].equals(""))sql.append( "    AND A.DIRECTION = '"+str[7]+"' 	\n");
						if(!str[8].equals(""))sql.append( "    AND C.DTI_STATUS = '"+str[8]+"' 	\n");
						if(!str[12].equals("M")){
							if(str[10].equals("")&&str[11].equals(""))sql.append( " AND(T.EMPNO='"+str[9]+"' OR V.EMPNO IN ('"+str[9]+"') )	\n");
							if(!str[10].equals("")&&!str[11].equals(""))sql.append( " AND(T.EMPNO='"+str[9]+"' OR V.EMPNO IN ('"+str[10]+"') OR T.DEPTCD IN ('"+str[11]+"'))	\n");
							if(!str[10].equals("")&&str[11].equals(""))sql.append( " AND(T.EMPNO='"+str[9]+"' OR V.EMPNO IN ('"+str[10]+"'))	\n");
							if(str[10].equals("")&&!str[11].equals(""))sql.append( " AND(T.EMPNO='"+str[9]+"' OR T.DEPTCD IN ('"+str[11]+"'))	\n");
						}

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