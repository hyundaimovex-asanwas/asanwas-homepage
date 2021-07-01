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
public class a010047_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //거래처 코드 
				String  str2	= req.getParameter("v_str2"); //거래처명
				String  str3	= req.getParameter("v_str3"); //사업자등록번호 
				String  str4	= req.getParameter("v_str4"); //담당자명
				String  str5	= req.getParameter("v_str5"); //사용구분 
				String  str6	= req.getParameter("v_str6"); //상태
				String  str7	= req.getParameter("v_str7"); //상태

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
					
				GauceRes.enableFirstRow(dSet);
	
				String[] strArrCN = new String[]{ "CHK","SEQ", "VEND_CD",   "VEND_NM",  "VEND_ID",	 "EMPNM",   
												  "DEPTNM", "EMAIL", "HPNO", "TELNO", "ENDDT","BSNS_CND","BSNS_KND",
											   	  "USEGB", "STATUS", "VEND_ID_LEN", "SB_REASON"
														}; 

				int[] intArrCN = new int[]{ 1, 2, 13, 62, 15, 30,
											30, 40, 15, 15, 8,
											62,62,1, 1, 2, 100}; 

				int[] intArrCN2 = new int[]{  -1, 0, -1, -1, -1, -1,
												-1, -1, -1, -1, -1,
												-1,-1,-1, -1, 0, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT 'F' CHK, SEQ, RTRIM(C.VEND_CD) VEND_CD, RTRIM(G.VEND_NM) VEND_NM,  \n");
					sql.append( "		 C.VEND_ID, C.EMPNM, C.DEPTNM, C.EMAIL,   	 				  \n");
					sql.append( "		 C.HPNO, C.TELNO, C.ENDDT, C.USEGB,     					  \n");
					sql.append( "		 RTRIM(G.BSNS_CND)BSNS_CND,RTRIM(G.BSNS_KND)BSNS_KND,C.STATUS, \n");
					sql.append( "		 LENGTH(C.VEND_ID) VEND_ID_LEN, C.SB_REASON  \n");
					
					sql.append( "   FROM ACCOUNT.CUSTOMER C, ACCOUNT.GCZM_VENDER G 					  \n");
					sql.append( "  WHERE C.VEND_CD = G.VEND_CD 										  \n");
					sql.append( "    AND C.VEND_CD IS NOT NULL 										  \n");
					if (!str1.equals("")) sql.append( " AND C.VEND_CD LIKE '%" + str1 + "%'			  \n");
					if (!str2.equals("")) sql.append( " AND G.VEND_NM LIKE '%" + str2 + "%'			  \n");
					if (!str3.equals("")) sql.append( " AND C.VEND_ID LIKE '%" + str3 + "%'			  \n");
					if (!str4.equals("")) sql.append( " AND C.EMPNM LIKE   '%" + str4 + "%'			  \n");
					if (!str5.equals("A"))sql.append( " AND C.USEGB  = '"+str5+"'					  \n");
					if (!str6.equals("")) sql.append( " AND C.STATUS = '"+str6+"'					  \n");
					if (str7.equals("1")) sql.append( " AND LENGTH(C.VEND_ID)=10 					  \n");
					if (str7.equals("2")) sql.append( " AND LENGTH(C.VEND_ID)=13 					  \n");
					sql.append( " ORDER by VEND_CD 													  \n");
					
					//System.out.println("# a010047_s1 : " + sql);
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