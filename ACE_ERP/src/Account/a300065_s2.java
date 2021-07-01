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
public class a300065_s2 extends HttpServlet {
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
				String []  str	= new String [4];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//신청일
				str[2] = req.getParameter("v_str3");	//요청일
				str[3] = req.getParameter("v_str4");	//처리자
				
			
				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"APPDATE", "REQDATE",  "PAYDATE",
						"ATCODE",  "ATKORNAM", "VENDCD",  "VENDNM",
						"SUPAMT",  "SUPVATAMT","APPAMT",  "REMARK",    "PAYGB",     "PAYGBNM", 
						
						"APPFSDAT","APPFSNBR", 
						"APPEMPNO"
						
				}; 

				int[] intArrCN = new int[] { 
					     8,  8,   8,
					     7, 100, 13, 62,
					    15,  13, 15,100,  1, 20, 
					    
					     9,   6,  
					    10, 
				};      
			
				int[] intArrCN2 = new int[]{ 
						-1,  -1,  -1,
					    -1,  -1,  -1,  -1,
					     0,   0,   0,  -1,  -1,  -1,   
					    
					    -1,  -1,  
					    -1, 
				 	 
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT A.APPDATE,A.REQDATE, A.PAYDATE,                     \n");
						sql.append( "        CASE WHEN SUBSTR(A.ATCODE,1,2)='44' THEN  '2100510' \n");
						sql.append( "             ELSE '2100110' END  ATCODE,                    \n");
						sql.append( "        CASE WHEN SUBSTR(A.ATCODE,1,2)='44' THEN  '미지급금'  \n");
						sql.append( "              ELSE '외상매입금' END  ATKORNAM,                \n");
						sql.append( "        A.VENDCD,  A.VENDNM,                                \n");
						sql.append( "        (A.SUPAMT)SUPAMT,  (A.SUPVATAMT)SUPVATAMT,\n");
						sql.append( "        (A.SUPAMT)+(A.SUPVATAMT) AS APPAMT,       \n");
						sql.append( "        A.REMARK, A.PAYGB,                      \n");
						sql.append( "         CASE WHEN A.PAYGB='1' THEN '보통예금'    \n");
						sql.append( "              WHEN A.PAYGB='2' THEN '현금'       \n");
						sql.append( "              WHEN A.PAYGB='3' THEN '외화보토예금' \n");
						sql.append( "              ELSE 'XXXX' END AS PAYGBNM,       \n");
						sql.append( "        A.APPFSDAT,A.APPFSNBR, A.APPEMPNO       \n");
						sql.append( "   FROM ACCOUNT.ACAPPFUND A, ACCOUNT.ACTCODE B                      \n");
						sql.append( "  WHERE A.ATCODE = B.ATCODE(+) AND B.ATUSEYN(+) ='Y'                  \n");
						if(!str[0].equals(""))sql.append( "    AND A.FDCODE  ='"+str[0]+"'       \n");
						if(!str[1].equals(""))sql.append( "    AND A.APPDATE ='"+str[1]+"'       \n");
						if(!str[2].equals(""))sql.append( "    AND A.REQDATE ='"+str[2]+"'       \n");
						if(!str[3].equals(""))sql.append( "    AND A.APPEMPNO='"+str[3]+"'       \n");
						
						//sql.append( "  GROUP BY A.APPDATE, A.REQDATE, A.PAYDATE, A.VENDCD, A.VENDNM, A.ATCODE, A.PAYGB, A.REMARK, A.APPFSDAT, A.APPFSNBR, A.APPEMPNO                \n");
						
						/*
						if(!str[0].equals(""))sql.append( "   AND A.FDCODE ='"+str[0]+"'                   \n");	
						if(!str[1].equals(""))sql.append( "   AND A.VENDCD ='"+str[1]+"'                   \n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( "   AND A.FULDAT >='"+str[2]+"' AND A.FULDAT<='"+str[3]+"'  --만기일자   \n");
						else if(!str[2].equals("")&&str[3].equals(""))sql.append( "   AND A.FULDAT >='"+str[2]+"' --만기일자   \n");
						
						if(!str[4].equals("")&&!str[5].equals(""))sql.append( "   AND A.PAYDAT >='"+str[4]+"' AND A.PAYDAT<='"+str[5]+"'  --발행일자   \n");	
						else if(!str[4].equals("")&&str[5].equals(""))sql.append( "   AND A.PAYDAT >='"+str[4]+"'   --발행일자   \n");	
						if(!str[7].equals(""))sql.append( "   AND B.EMPNO IN ('"+str[7]+"')                \n");	
						sql.append( "   ORDER BY A.FULDAT, A.PAYDAT, C.VEND_NM                             \n");
						*/
						/*
						if(!str[0].equals(""))sql.append( "    AND X.FDCODE ='"+str[0]+"'       \n");
						if(!str[1].equals(""))sql.append( "    AND X.VENDCD ='"+str[1]+"'       \n");
						if(!str[2].equals(""))sql.append( "    AND X.ENDDT >='"+str[2]+"'       \n");
						if(!str[3].equals(""))sql.append( "    AND X.JOBDT='"+str[3]+"'         \n");
						sql.append( "  ORDER BY X.JOBDT, X.ENDDT, G.VEND_NM \n");
						*/
						/*
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'							\n");	//지점
						if(!str[1].equals("")) sql.append( " AND A.FUNDDIV='"+str[1]+"' 							\n");	//자금구분
						if(!str[2].equals("")) sql.append( " AND A.ENDDATE BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//만기일자
						if(!str[4].equals("")) sql.append( " AND C.CDNAM LIKE '"+str[4]+"%'						\n");	//은행명
						*/

						System.out.println("# a300060_s1 Query : \n" + sql);
						
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