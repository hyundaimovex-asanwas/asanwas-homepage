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
public class a300010_s4 extends HttpServlet {
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
				String []  str	= new String [3];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//만기일자
				str[2] = req.getParameter("v_str3");	//거래처
			
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE", "FSDAT",  "FSNBR",  "FSSEQ", "ATCODE",
					"PAYDT",  "ENDDT",  "REMARK", "DEAMT", "CRAMT",
					"SSDAT",  "SSNBR",  "VEND_CD","VEND_NM", "JANAMT"	}; 

				int[] intArrCN = new int[] { 
					 2,   9,   6,   5,   7,
					 8,	  8, 100,  15,  15,   
					 9,	  6,  10,  60,  15
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,   0,   0,
					-1,  -1,  -1,  -1,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT  X.FDCODE , X.FSDAT, X.FSNBR, X.FSSEQ, F.ATCODE,                        \n");	
						sql.append( "         X.PAYDT,   X.ENDDT, F.REMARK,X.DEAMT, X.CRAMT,                         \n");	
						sql.append( "         F.SSDAT, F.SSNBR, X.VEND_CD, G.VEND_NM, X.JANAMT                       \n");	
						sql.append( "   FROM                                                                         \n");	
						sql.append( "      (                                                                         \n");	
						sql.append( "         SELECT A.FDCODE, A.FSDAT, A.FSNBR, A.FSSEQ, B.FSREFVAL AS ENDDT,       \n");	
						sql.append( "                C.FSREFVAL AS PAYDT, A.DEAMT, A.CRAMT, D.FSREFVAL AS VEND_CD,   \n");	
						sql.append( "                A.DEAMT AS JANAMT                                               \n");
						sql.append( "           FROM ACCOUNT.GENENLED A,                                             \n");	
						sql.append( "                ACCOUNT.GENENREF B,                                             \n");	
						sql.append( "                ACCOUNT.GENENREF C,                                             \n");	
						sql.append( "                ACCOUNT.GENENREF D                                              \n");	
						sql.append( "          WHERE 1=1                                                             \n");	
						if(!str[0].equals("")) sql.append( "  AND A.FDCODE ='"+str[0]+"'                             \n");	
						sql.append( "            AND A.ATCODE IN ('1110320')                                         \n"); //받을어음.
						sql.append( "            AND A.FDCODE = B.FDCODE                                             \n");	
						sql.append( "            AND A.FSDAT  = B.FSDAT                                              \n");	
						sql.append( "            AND A.FSNBR  = B.FSNBR                                              \n");	
						sql.append( "            AND A.FSSEQ  = B.FSSEQ                                              \n");	
						sql.append( "            AND B.FSREFCD='0969' -- 만기일자                                                                           \n");	
						if(!str[1].equals("")) sql.append( "   AND B.FSREFVAL>='"+str[1] +"'                         \n");	
						sql.append( "            AND A.FDCODE = C.FDCODE                                             \n");	
						sql.append( "            AND A.FSDAT  = C.FSDAT                                              \n");	
						sql.append( "            AND A.FSNBR  = C.FSNBR                                              \n");	
						sql.append( "            AND A.FSSEQ  = C.FSSEQ                                              \n");	
						sql.append( "            AND C.FSREFCD='0968'  -- 발행일자                                                                          \n");	
						sql.append( "            AND A.FDCODE = D.FDCODE                                             \n");	
						sql.append( "            AND A.FSDAT  = D.FSDAT                                              \n");	
						sql.append( "            AND A.FSNBR  = D.FSNBR                                              \n");	
						sql.append( "            AND A.FSSEQ  = D.FSSEQ                                              \n");	
						sql.append( "            AND D.FSREFCD='0020'  -- 거래처                                                                           \n");	
						if(!str[2].equals("")) sql.append( "   AND D.FSREFVAL='"+str[2] +"'                          \n");
						sql.append( "            AND A.ACTDAT>='20160101'                                            \n");
						sql.append( "            AND A.FSDAT NOT LIKE '%00'                                          \n");
						//sql.append( "            AND A.ACTDAT BETWEEN '20160101' AND '20161231'                      \n");	
						sql.append( "       ) X, ACCOUNT.FSLIPDTL F , ACCOUNT.GCZM_VENDER G                          \n");	
						sql.append( " WHERE X.FDCODE = F.FDCODE                                                      \n");	
						sql.append( "   AND X.FSDAT = F.FSDAT                                                        \n");	
						sql.append( "   AND X.FSNBR = F.FSNBR                                                        \n");	
						sql.append( "   AND X.FSSEQ = F.FSSEQ                                                        \n");	
						sql.append( "   AND X.VEND_CD = G.VEND_CD(+)                                                 \n");	
						sql.append( " ORDER BY X.ENDDT, G.VEND_NM \n");
						
						/*
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'							\n");	//지점
						if(!str[1].equals("")) sql.append( " AND A.FUNDDIV='"+str[1]+"' 							\n");	//자금구분
						if(!str[2].equals("")) sql.append( " AND A.ENDDATE BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//만기일자
						if(!str[4].equals("")) sql.append( " AND C.CDNAM LIKE '"+str[4]+"%'						\n");	//은행명
						*/

						System.out.println("# a300010_s4 Query : \n" + sql);
						
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