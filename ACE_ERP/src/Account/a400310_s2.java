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
public class a400310_s2 extends HttpServlet {
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
				String []  str	= new String [2];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//신청번호
			 
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						 "APPNO",  "APPSEQ",  "FDCODE",   "ATCODE",   "ATKORNAM", 
						 "COSTGB", "COSTCT",  "COSTCTNM", "SUPAMT",   "FOUTAMT",
						 "WRID",   "WRDT",    "UPID",     "UPDT",
						 "AP_STATUS_M",       "PAYGB",    "APPFSDAT"
						
				}; 

				int[] intArrCN = new int[] { 
					     14,  2,   2,  7,  100,
					      1, 10, 100, 15,   15,
					     10, 10,  10, 10,
					      1,  1,   9
				};      
			
				int[] intArrCN2 = new int[]{ 
						 -1,  0,  -1,  -1,  -1,
						 -1, -1,  -1,   0,   2,
						 -1, -1,  -1,  -1,  
						 -1, -1,  -1
					  
	
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT A.APPNO,A.APPSEQ,A.FDCODE,A.ATCODE, B.ATKORNAM,                    \n");
						sql.append( "        A.COSTGB,A.COSTCT,                                                 \n");
						sql.append( "        CASE WHEN A.COSTGB ='1' THEN C.CDNAM                               \n");
						sql.append( "             WHEN A.COSTGB ='2' THEN D.CDNAM                               \n");
						sql.append( "             ELSE '' END COSTCTNM,                                         \n");
						sql.append( "        A.SUPAMT,A.FOUTAMT,                                                \n");
						sql.append( "        A.WRID,A.WRDT,A.UPID,A.UPDT,                                       \n");
						sql.append( "         NVL(H.AP_STATUS_M,'0') AP_STATUS_M, F.PAYGB, F.APPFSDAT           \n");
						sql.append( "   FROM ACCOUNT.ACAPPCOST A, ACCOUNT.ACAPPFUND F, COMMON.APPROVE_MASTER H, \n");
						sql.append( "        ACCOUNT.ACTCODE B,   ACCOUNT.COMMDTIL C,  ACCOUNT.COMMDTIL D       \n");
						sql.append( "  WHERE A.APPNO = F.APPNO(+) AND A.FDCODE = F.FDCODE(+)                    \n");
						sql.append( "    AND A.ATCODE = B.ATCODE(+) AND B.ATUSEYN(+) ='Y'                       \n");
						sql.append( "    AND A.COSTCT= C.CDCODE(+) AND C.CMTYPE(+) ='0030'                      \n");
						sql.append( "    AND A.COSTCT= D.CDCODE(+) AND D.CMTYPE(+) ='0003'                      \n");
						sql.append( "    AND F.AP_M_SID = H.AP_M_SID(+)                                         \n");
						sql.append( "    AND A.APPNO   ='"+str[1]+"'                                            \n");
						
						if(!str[0].equals(""))sql.append( "    AND A.FDCODE  ='"+str[0]+"'                     \n");
						sql.append( "  ORDER BY A.APPNO, A.APPSEQ    \n");

					    //System.out.println("# a400310_s2 Query : \n" + sql);
						
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