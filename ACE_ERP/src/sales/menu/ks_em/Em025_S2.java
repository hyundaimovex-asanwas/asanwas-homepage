package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em025_S2 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";} //급여년월 
				String  str2	= req.getParameter("v_str2"); if (str2==null) {str2="";} //지급구분 
				String  str3	= req.getParameter("v_str3"); if (str3==null) {str3="";} //소속     
				String  str4	= req.getParameter("v_str4"); if (str4==null) {str4="";} //부서     
				String  str5	= req.getParameter("v_str5"); if (str5==null) {str5="";} //사번     
				String  str6	= req.getParameter("v_str6"); if (str6==null) {str6="";} //대리점   
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "VEND_CD",   "VEND_NM",   "PAY_YM",    "GROUP",     "GROUPNM",      "BASIC_TOT",  "O_TIME_TOT",
                                          "RET_PAY",   "REWARD_PAY","BON_PAY",      "LST_PAY",
					                                "PAY_SUM",   "TEL_PAY",   "ADV_PAY",      "TELUBO_PAY", "TELSAVE_PAY",
					                                "ETC_PAY",   "DEDUCT_SUM","REAL_PAY_SUM", "SEQ"
																			  };

				int[] intArrCN = new int[] { 10, 50,  6,  3, 50, 10, 10,
					                           10, 10, 10, 10,
					                           10, 10, 10, 10, 10,
					                           10, 10, 10,  3
                                    
																	 }; 
			
				int[] intArrCN2 = new int[]{  0, -1, -1, -1, -1, 2, 2,
					                            2,  2,  2, 2,
					                            2,  2,  2, 2, 2,
					                            2,  2,  2, 0
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {		

							StringBuffer sql = new StringBuffer();
							
							sql.append( "	SELECT A.VEND_CD, D.DETAIL_NM AS VEND_NM, A.PAY_YM, IFNULL(B.ITEM2,'') AS GROUP, IFNULL(C.DETAIL_NM,'') AS GROUPNM, \n");
							sql.append( "	       SUM(IFNULL(A.BASIC_TOT,0))BASIC_TOT,                                            \n");
							sql.append( "	       SUM(IFNULL(A.O_TIME_TOT,0))O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))RET_PAY,          \n");
							sql.append( "	       SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))REWARD_PAY,     \n");
							sql.append( "	       SUM(IFNULL(A.BON_PAY,0))BON_PAY,                                                \n");
							sql.append( "	       SUM(IFNULL(A.LST_PAY,0))LST_PAY,SUM(IFNULL(A.PAY_SUM,0))PAY_SUM,                \n");
							sql.append( "	       SUM(IFNULL(A.TEL_PAY,0))TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))ADV_PAY,                \n");
							sql.append( "	       SUM(IFNULL(A.TELUBO_PAY,0))TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))TELSAVE_PAY,  \n");
							sql.append( "	       SUM(IFNULL(A.ETC_PAY,0))ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))DEDUCT_SUM,          \n");
							sql.append( "	       SUM(IFNULL(A.REAL_PAY_SUM,0))REAL_PAY_SUM , IFNULL(C.ITEM2,999) AS SEQ          \n");
							sql.append( "	  FROM SALES.TCM400 A                                                                  \n");
							sql.append( "	  LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.TEAM_CD AND B.HEAD='CM003'                    \n");
							sql.append( "	  LEFT JOIN SALES.TSY010 C ON C.DETAIL=B.ITEM2 AND C.HEAD='CM022' AND RTRIM(C.DETAIL_NM)<>'' AND RTRIM(B.ITEM2)<>''  \n");
							sql.append( "	  LEFT JOIN SALES.TSY010 D ON RTRIM(D.DETAIL)=RTRIM(A.VEND_CD) AND D.HEAD='CM019' AND RTRIM(D.DETAIL_NM)<>''  \n");
							sql.append( "	 WHERE A.PAY_YM='"+str1+"'                      \n");
							if(!str2.equals(""))sql.append( "	AND A.PAY_DIV='"+str2+"'    \n");
							if(!str3.equals(""))sql.append( "	AND A.TEAM_CD='"+str3+"'    \n");
							if(!str4.equals(""))sql.append( "	AND A.DEPT_CD='"+str4+"'    \n");
							if(!str5.equals(""))sql.append( "	AND A.EMPNO = '"+str5+"'    \n");
							if(!str6.equals(""))sql.append( "	AND A.AGENCY_CD ='"+str6+"' \n");
							sql.append( "	 GROUP BY A.VEND_CD,D.DETAIL_NM, A.PAY_YM, B.ITEM2, C.DETAIL_NM ,C.ITEM2   \n");
							sql.append( "	 ORDER BY A.VEND_CD, INTEGER(C.ITEM2)                          \n");

							logger.dbg.println(this,"총계"+sql.toString());
							stmt = conn.getGauceStatement(sql.toString());
							stmt.executeQuery(dSet);
					}
				
/*********************************************************************************************/

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