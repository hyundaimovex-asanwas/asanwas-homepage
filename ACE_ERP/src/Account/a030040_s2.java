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
public class a030040_s2 extends HttpServlet {
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
				// 전체조회
				String  str1  = req.getParameter("v_str1");  //지점
				String  str2  = req.getParameter("v_str2");  //회계년월
				String  str3  = req.getParameter("v_str3");  //계정코드
				String  str4  = req.getParameter("v_str4");  //관리항목
				String  str5  = req.getParameter("v_str5");  //관리항목값
				
				String  stryyyy  = "";
				String  stryymmdd="";	

				stryyyy = str2.substring(0,4);
			
				if(str1 == null) str1 = ""; //지점       
				if(str2 == null) str2 = ""; //회계년월   
				if(str3 == null) str3 = ""; //계정코드       
				if(str4 == null) str4 = ""; //관리항목
				if(str5 == null) str5 = ""; //관리항목값

				//회계년월의 월이 00 일때 TOTALBAL 와 GENENLED	다른 조회일자적용		
				if(str2.substring(4,6).equals("00")){
					stryymmdd = stryyyy+"0100";
				}else{
					stryymmdd = str2+"31";
				}			        

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FSREFVAL", "COSTNM","ATCODE","ATKORNAM", "FDEAMT", "FCRAMT", "DEAMT", "CRAMT","DETOT","CRTOT", "MDETOT", "MCRTOT"
																						
				}; 

				int[] intArrCN = new int[]{ 15,100, 15,100, 15, 15, 15, 15, 15, 15, 15, 15
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					
					sql.append(" SELECT X.FSREFVAL, Z.CDNAM AS COSTNM, X.ATCODE,  Y.ATKORNAM,         \n");
					sql.append(" 	SUM(X.FDEAMT) FDEAMT, SUM(X.FCRAMT)FCRAMT,						  \n");
					sql.append(" 	SUM(X.DEAMT) DEAMT, SUM(X.CRAMT)CRAMT,							  \n");
					sql.append(" 	SUM(X.DETOT)DETOT,  SUM(X.CRTOT)CRTOT,							  \n");
					sql.append(" 	SUM(X.MDETOT)MDETOT,SUM(X.MCRTOT)MCRTOT							  \n");
					sql.append(" FROM (                                                                                       \n");
					sql.append(" 	SELECT C.FSREFVAL, B.ATCODE,                                                              \n");
					sql.append(" 	       SUM(CASE WHEN B.ATDECR ='1' THEN B.FSAMT ELSE 0 END) FDEAMT,                       \n");
					sql.append(" 	       SUM(CASE WHEN B.ATDECR ='2' THEN B.FSAMT ELSE 0 END) FCRAMT,                       \n");
					sql.append(" 	       0 DEAMT, 0 CRAMT, 0 DETOT, 0 CRTOT, 0 MDETOT, 0 MCRTOT                             \n");
					sql.append(" 	  FROM ACCOUNT.FSLIPMST A , ACCOUNT.FSLIPDTL B , ACCOUNT.FSLIPREF C                       \n");
					sql.append(" 	 WHERE A.FDCODE= B.FDCODE                                                                 \n");
					sql.append("       AND A.FSDAT = B.FSDAT                                                                  \n");
					sql.append(" 	   AND A.FSNBR = B.FSNBR                                                                  \n");
					sql.append(" 	   AND B.FDCODE= C.FDCODE                                                                 \n");
					sql.append(" 	   AND B.FSDAT = C.FSDAT                                                                  \n");
					sql.append(" 	   AND B.FSNBR = C.FSNBR                                                                  \n");
					sql.append(" 	   AND B.FSSEQ = C.FSSEQ                                                                  \n");
					sql.append(" 	   AND A.FSSTAT ='Y'                                                                      \n");
					if(!str4.equals(""))sql.append(" AND C.FSREFCD ='"+str4+"'                                                \n");
					if(!str1.equals(""))sql.append(" AND A.FDCODE ='"+str1+"'                                                 \n");
					if(!str5.equals(""))sql.append(" AND C.FSREFVAL='"+str5+"'                                                \n");
					if(!str3.equals(""))sql.append(" AND B.ATCODE ='"+str3+"'                                                 \n");
					if(!str2.equals(""))sql.append(" AND A.ACTDAT BETWEEN '"+str2+"01' AND '"+stryymmdd+"'                    \n");
					sql.append(" 	GROUP BY C.FSREFVAL, B.ATCODE                                                             \n");
					sql.append(" 	UNION ALL                                                                                 \n");
					sql.append(" 	SELECT C.FSREFVAL, A.ATCODE, 0 FDAMT, 0 FCRAMT,                                           \n");
					sql.append(" 	       (SUM(A.DEAMT)) DEAMT, (SUM(A.CRAMT))CRAMT, 0 DETOT, 0 CRTOT, 0 MDETOT, 0 MCRTOT    \n");
					sql.append(" 	  FROM ACCOUNT.GENENLED A, ACCOUNT.GENENREF C,                                            \n");
					sql.append(" 	       ACCOUNT.ACTCODE B                                                                  \n");
					sql.append(" 	 WHERE A.ATCODE = B.ATCODE                                                                \n");
					sql.append(" 	   AND A.FDCODE = C.FDCODE                                                                \n");
					sql.append(" 	   AND A.FSDAT = C.FSDAT                                                                  \n");
					sql.append(" 	   AND A.FSNBR = C.FSNBR                                                                  \n");
					sql.append(" 	   AND A.FSSEQ = C.FSSEQ                                                                  \n");
					if(!str4.equals(""))sql.append(" AND C.FSREFCD ='"+str4+"'                                                \n");
					if(!str1.equals(""))sql.append(" AND A.FDCODE ='"+str1+"'                                                 \n");
					sql.append(" 	   AND B.ATUSEYN='Y'                                                                      \n");
					if(!str3.equals(""))sql.append(" AND A.ATCODE ='"+str3+"'                                                 \n");
					if(!str5.equals(""))sql.append(" AND C.FSREFVAL ='"+str5+"'                                               \n");
					if(!str2.equals(""))sql.append(" AND A.ACTDAT BETWEEN '"+str2+"01' AND '"+stryymmdd+"'                    \n");
					sql.append(" 	GROUP BY C.FSREFVAL, A.ATCODE                                                             \n");
					sql.append(" 	 UNION ALL                                                                                \n");
					sql.append(" 	SELECT C.FSREFVAL, A.ATCODE, 0 FDEAMT, 0 FCRAMT, 0 DEAMT, 0 CRAMT,                        \n");
					sql.append(" 	       SUM(C.DETOT)DETOT, SUM(C.CRTOT)CRTOT, 0 MDETOT, 0 MCRTOT                           \n");
					sql.append(" 	  FROM ACCOUNT.TOTALBAL A, ACCOUNT.FSREFTOT C,                                            \n");
					sql.append(" 	 ACCOUNT.ACTCODE B                                                                        \n");
					sql.append(" 	 WHERE A.ATCODE = B.ATCODE                                                                \n");
					sql.append(" 	AND A.FDCODE = C.FDCODE                                                                   \n");
					sql.append(" 	AND A.ACTDAT = C.ACTDAT                                                                   \n");
					sql.append(" 	AND A.ATCODE = C.ATCODE                                                                   \n");
					sql.append(" 	AND A.COCODE = C.COCODE                                                                   \n");
					sql.append(" 	AND A.DIVCD = C.DIVCD                                                                     \n");
					sql.append(" 	AND A.DEPTCD = C.DEPTCD                                                                   \n");
					if(!str4.equals(""))sql.append(" AND C.FSREFCD ='"+str4+"'                                                \n");
					if(!str1.equals(""))sql.append(" AND A.FDCODE ='"+str1+"'                                                 \n");
					sql.append(" 	   AND B.ATUSEYN='Y'                                                                      \n");
					if(!str3.equals(""))sql.append(" AND A.ATCODE ='"+str3+"'                                                 \n");
					if(!str5.equals(""))sql.append(" AND C.FSREFVAL ='"+str5+"'                                               \n");
					if(!str2.equals(""))sql.append(" AND A.ACTDAT BETWEEN '"+str2+"01' AND '"+stryymmdd+"'                    \n");
					sql.append(" 	GROUP BY C.FSREFVAL, A.ATCODE                                                             \n");
					sql.append(" 	 UNION ALL                                                                                \n");
					sql.append(" 	SELECT C.FSREFVAL, A.ATCODE,  0 FDEAMT, 0 FCRAMT, 0 DEAMT, 0 CRAMT,                       \n");
					sql.append(" 	       0 DETOT, 0 CRTOT, SUM(C.DETOT)MDETOT, SUM(C.CRTOT) MCRTOT                          \n");
					sql.append(" 	  FROM ACCOUNT.MTOTALBAL A, ACCOUNT.MFSREFTOT C,                                          \n");
					sql.append(" 	 ACCOUNT.ACTCODE B                                                                        \n");
					sql.append(" 	 WHERE A.ATCODE = B.ATCODE                                                                \n");
					sql.append(" 	AND A.FDCODE = C.FDCODE                                                                   \n");
					sql.append(" 	AND A.ACTYYMM = C.ACTYYMM                                                                 \n");
					sql.append(" 	AND A.ATCODE = C.ATCODE                                                                   \n");
					sql.append(" 	AND A.COCODE = C.COCODE                                                                   \n");
					sql.append(" 	AND A.DIVCD = C.DIVCD                                                                     \n");
					sql.append(" 	AND A.DEPTCD = C.DEPTCD                                                                   \n");
					if(!str4.equals(""))sql.append(" AND C.FSREFCD ='"+str4+"'                                                \n");
					if(!str1.equals(""))sql.append(" AND A.FDCODE ='"+str1+"'                                                 \n");
					sql.append(" 	   AND B.ATUSEYN='Y'                                                                      \n");
					if(!str3.equals(""))sql.append(" AND A.ATCODE ='"+str3+"'                                                 \n");
					if(!str5.equals(""))sql.append(" AND C.FSREFVAL ='"+str5+"'                                               \n");
					if(!str2.equals(""))sql.append(" AND A.ACTYYMM BETWEEN '"+str2+"' AND '"+str2+"'                          \n");
					sql.append(" 	GROUP BY C.FSREFVAL, A.ATCODE                                                             \n");
					sql.append(" )X , ACCOUNT.ACTCODE Y ,ACCOUNT.COMMDTIL Z                                                   \n");
					sql.append(" WHERE X.ATCODE =Y.ATCODE                                                                     \n");
					sql.append("   AND  Z.CMTYPE='0030' AND Z.CDCODE = X.FSREFVAL(+)                                          \n");
					sql.append(" GROUP BY X.FSREFVAL, Z.CDNAM, X.ATCODE, Y.ATKORNAM                                           \n");
					sql.append(" ORDER BY X.FSREFVAL, X.ATCODE                                                                \n");

					//System.out.println("a030040_s2"+sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 				stmt.executeQuery(dSet);
				}
				
			} catch(Exception e) {
		  	   //logger.err.println(this,e);
			   System.out.println("err1:::"+e);	
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
			System.out.println("err2:::"+e);	
		} finally {
			loader.restoreService(service);
  	}
	}
}