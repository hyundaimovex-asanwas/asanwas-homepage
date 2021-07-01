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
public class a300020_s2 extends HttpServlet {
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
				str[2] = req.getParameter("v_str3");	//작업일
			
				for(int i=0;i<=2;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"JOBDT", "ENDYM", "ENDDT",  "REMARK",  "DEAMT", "CRAMT", "FDCODE", "DEAMT_SUM","CRAMT_SUM", "JANAMT", "JANAMT_SUM", "WRID", "UPID", "GUBUN"
			    }; 

				int[] intArrCN = new int[] { 
					8,  6,   8,   100,  15,  15,    
					2,  15,  15,  15,   15,  10,  10 , 1
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,    0,   0,   
					-1,   0,   0,   0,    0,  -1,  -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						
						sql.append( " SELECT X.JOBDT,  X.ENDYM, X.ENDDT,  X.REMARK, X.DEAMT, X.CRAMT,  \n");
						sql.append( "        X.FDCODE, Y.DEAMT_SUM, Y.CRAMT_SUM, X.CRAMT JANAMT, (Y.CRAMT_SUM) JANAMT_SUM, ''WRID, ''UPID ,'1' GUBUN \n");
						sql.append( "   FROM ACCOUNT.ABILLSSUM X,                                      \n");
						sql.append( "        ( SELECT X.JOBDT,  X.ENDYM, X.FDCODE,                     \n");
						sql.append( "                 SUM(X.DEAMT)DEAMT_SUM, SUM(X.CRAMT)CRAMT_SUM     \n");
						sql.append( "             FROM ACCOUNT.ABILLSSUM X                             \n");
						sql.append( "            WHERE 1=1                         \n");
						if(!str[0].equals(""))sql.append( "  AND X.FDCODE ='"+str[0]+"'                \n");
						if(!str[1].equals(""))sql.append( "  AND X.ENDDT >='"+str[1]+"'                \n");
						if(!str[2].equals(""))sql.append( "  AND X.JOBDT ='"+str[2]+"'                 \n");
						sql.append( "            GROUP BY X.FDCODE, X.JOBDT, X.ENDYM                   \n");
						sql.append( "         )Y                                                       \n");
						sql.append( "  WHERE X.DEAMT=0                                                 \n"); //지급어음.
						if(!str[0].equals("")) sql.append( "   AND X.FDCODE ='"+str[0]+"'              \n");
						if(!str[1].equals("")) sql.append( "   AND X.ENDDT >='"+str[1]+"'              \n");
						if(!str[2].equals("")) sql.append( "   AND X.JOBDT ='"+str[2]+"'               \n");
						
						sql.append( "    AND X.FDCODE = Y.FDCODE(+)                                    \n");
						sql.append( "    AND X.JOBDT  = Y.JOBDT(+)                                     \n");
						sql.append( "    AND X.ENDYM  = Y.ENDYM(+)                                     \n");
						sql.append( " ORDER BY X.FDCODE, X.JOBDT, X.ENDYM, X.ENDDT                     \n");
						
						
						/*
						sql.append( " SELECT X.JOBDT,  X.ENDYM,  \n");
						sql.append( "        --DECODE( GROUPING_ID(X.JOBDT, X.ENDYM, X.ENDDT),1, '',X.ENDYM) ENDYM,    \n");
						sql.append( "        DECODE( GROUPING_ID(X.JOBDT, X.ENDYM, X.ENDDT),1, '',X.ENDDT) ENDDT,    \n");
						sql.append( "        DECODE( GROUPING_ID(X.JOBDT, X.ENDYM, X.ENDDT),1, '', MAX(X.REMARK)) REMARK,    \n");
						sql.append( "        SUM(X.DEAMT)DEAMT, SUM(X.CRAMT)CRAMT,  MAX(X.FDCODE) FDCODE, ''WRID, ''UPID   \n");
						
						sql.append( "   FROM ACCOUNT.ABILLSSUM X                                             \n");	
						sql.append(  " WHERE X.FDCODE ='"+str[0]+"'                                          \n");	
						sql.append( "    AND X.JOBDT ='20160929'                                             \n");
						sql.append( "    AND X.ENDDT >='"+str[2]+"'                                          \n");
						if(!str[1].equals(""))sql.append( "    AND X.ATCODE >='"+str[1]+"'                   \n");
						if(!str[3].equals(""))sql.append( "    AND X.VENDCD >='"+str[3]+"'                   \n");
						sql.append( "  GROUP BY ROLLUP (X.JOBDT, X.ENDYM, X.ENDDT )  \n");
						sql.append( " HAVING GROUPING_ID(X.JOBDT, X.ENDYM, X.ENDDT)  IN (0,1)  \n");
						*/
						/*
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'							\n");	//지점
						if(!str[1].equals("")) sql.append( " AND A.FUNDDIV='"+str[1]+"' 							\n");	//자금구분
						if(!str[2].equals("")) sql.append( " AND A.ENDDATE BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//만기일자
						if(!str[4].equals("")) sql.append( " AND C.CDNAM LIKE '"+str[4]+"%'						\n");	//은행명
						*/

						//System.out.println("# a300020_s2 Query : \n" + sql);
						
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