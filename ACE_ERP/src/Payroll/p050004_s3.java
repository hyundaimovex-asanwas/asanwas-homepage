package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p050004_s3 extends HttpServlet {

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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//기준년월
				str[1]	= req.getParameter("v_str2");		//사번

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* 사번 */
				"APPYM",       /*년월*/
				"FAMNM",       /*가족성명*/
				"RESINO",      /*가족주민번호*/
				"SCHYEAR",      /*학년*/
				"SCHNM",	   /* 학교명 */
				"APPDT",       /*신청일*/
				"APPAMT",      /*신청금액*/
				"REQREM",      /*신청내역*/

				"PAYAMT",      /*확정금액*/
				"REFCDNM",      /*가족관계*/
				"LSTEDCNM"      /*학력사항*/
				};

				int[] intArrCN = new int[]{  
					7, 	
					6,
					20,
					13, 	
					1,
					40,
					8, 	
					7,
					40,
					7,
					30,
					30

            	}; 

				int[] intArrCN2 = new int[]{
				-1,	   /* 사번 */
				-1,       /*년월*/
				-1,       /*가족성명*/
				-1,      /*가족주민번호*/
				-1,      /*학년*/
				-1,	   /* 학교명 */
				-1,       /*신청일*/
				0,      /*신청금액*/
				-1,      /*신청내역*/
				0,     /*확정금액*/
				-1,	   /* 학교명 */
				-1       /*신청일*/
                    }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  ");
					sql.append( "  A.EMPNO, ");	  
					sql.append( "  A.APPYM, ");	  
					sql.append( " (CASE   WHEN COALESCE(B.FAMNM,'0') = '0'   THEN C.EMPNMK  ELSE B.FAMNM  END) AS FAMNM, ");	  
					sql.append( "  A.RESINO, ");   
					sql.append( "  A.SCHYEAR, ");	  
					sql.append( "  A.SCHNM, ");	  
					sql.append( "  A.APPDT, ");   
					sql.append( "  A.APPAMT, ");	  
					sql.append( "  A.REQREM, ");   
					sql.append( "  A.PAYAMT, ");   
					sql.append( "  D.MINORNM AS  REFCDNM,");  //가족관계
					sql.append( "  E.MINORNM AS  LSTEDCNM");  //학력사항
					sql.append( " from  PAYROLL.PWSCHREQ A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIFAMILY B ON  A.EMPNO = B.EMPNO  AND A.RESINO = B.RESINO    ");
			        sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON C ON  A.EMPNO = C.EMPNO     AND A.RESINO = C.RESINO ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE D ON  B.REFCD = D.MINORCD  AND D.MAJORCD = '1132'   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE E ON  B.LSTEDC = E.MINORCD  AND E.MAJORCD = '1137'  ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");

					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND A.APPYM  = '"  + str[0] + "' \n");    //기준년월
					if ( !str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND A.EMPNO  = '"  + str[1] + "'  \n");    //사번
						sql.append( " ORDER BY B.SEQ ASC ");

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