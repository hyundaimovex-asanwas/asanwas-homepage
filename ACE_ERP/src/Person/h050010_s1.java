/* 전체 조회 */
package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h050010_s1 extends HttpServlet {

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
        String [] str = new String[10];
        str[0] =  req.getParameter("v_str1"); // from 일자 
				str[1] =  req.getParameter("v_str2"); // to 일자   
				str[2] =  req.getParameter("v_str3"); // from 사번 
				str[3] =  req.getParameter("v_str4");	// to 사번   
				str[4] =  req.getParameter("v_str5");	// 성명      
				str[5] =  req.getParameter("v_str6"); // 근태구분  
				str[6] =  req.getParameter("v_str7"); // 부서   //부서는 여러개를 가지고 옴    
				str[7] =  req.getParameter("v_str8"); // 직위			
				str[8] =  req.getParameter("v_str9"); // 결재상태			
				str[9] =  req.getParameter("v_str10"); // 구분 - R:정규직, T:계약직			


        for(int i=0;i<=9;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{ "CHK",     "APPDT",	    "EMPNO",  "LAZCD",	 "FRDT",	  "TODT",
																					"DIVCD",	 "DEPTCD",		"PAYGRD", "OBJECT",	 "TRIPOBJ",	
																					"CARAMT",	 "OVRATEGB",	"OVRATE", "OVDSAMT", "OVWNAMT", "OVETC",	
																					"INTRDAY", "APPLYID",  	"CLOSYN", 
																				  "WRDT",	   "WRID",	    "UPDT",   "UPID",
					                                "EMPNMK",	 "PAYGRDNM",	"DEPTNM", "LAZCDNM", "ORGFRDT",	"ORGTODT",
					                                "MEMO",    "DIVNM",     "OVFDAMT", "HLNO",   "REMARK1", "REMARK2"
																					}; 

				int[] intArrCN = new int[]{ 1,  8,  7,  4,  8,   8,
																		4,  4,  4, 30,  50,
																		7,  4,  7,  7,   7, 100,
																		2,  7,  1,
																		8, 10,  8, 10,
					                         20, 30, 50, 30, 8, 8,
					                         30, 50,  7, 14, 130, 130
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		  0, -1,  4,  0,  0, -1,
																		  0, -1, -1,
																		 -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, -1,
					                           -1, -1,  0, -1, -1, -1
																	}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT '' CHK, A.APPDT,A.EMPNO,A.LAZCD,A.FRDT,A.TODT,          \n");
					sql.append( " 			 A.DIVCD,A.DEPTCD,A.PAYGRD,A.OBJECT,A.TRIPOBJ,   \n");
					sql.append( " 			 A.CARAMT,A.OVRATEGB,A.OVRATE,A.OVDSAMT,A.OVWNAMT,A.OVETC, \n");
					sql.append( " 			 A.INTRDAY,A.APPLYID,A.CLOSYN,               \n");
					sql.append( " 			 A.WRDT,A.WRID,A.UPDT,A.UPID,                  \n");
					sql.append( " 			 CASE WHEN RTRIM(B.EMPNMK)='' OR B.EMPNMK IS NULL THEN C.EMPNMK ELSE B.EMPNMK END EMPNMK,  \n");
					sql.append( " 			 D.MINORNM AS PAYGRDNM, E.DEPTNMK AS DEPTNM, F.MINORNM AS LAZCDNM,   \n");
					sql.append( " 			 A.FRDT ORGFRDT, A.TODT ORGTODT, RTRIM(D.MEMO)MEMO, G.DEPTNMK AS DIVNM, A.OVFDAMT, A.HLNO,   \n");
					sql.append( " 			 RTRIM(A.REMARK1)REMARK1, RTRIM(A.REMARK2)REMARK2    \n");
					sql.append( "   FROM PAYROLL.HLOTMST A                      \n");
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO \n");
					sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON C ON A.EMPNO = C.EMPNO \n");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD='2002' \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON A.DEPTCD = E.DEPTCD  \n");
					sql.append( "                             AND E.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT \n");
					sql.append( "                                            WHERE CHGYM <= A.FRDT )  \n");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON A.LAZCD = F.MINORCD AND F.MAJORCD='1124'  \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT G ON SUBSTR(E.TREECD,1,6)||'00' = G.TREECD \n");
					sql.append( "                             AND G.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT \n");
					sql.append( "                                            WHERE CHGYM <=A.FRDT) \n");
	        sql.append( "   WHERE ((A.FRDT >='"+str[0]+"' AND A.FRDT <='"+str[1]+"')                       \n");
					sql.append( "      OR  (A.TODT >='"+str[0]+"' AND A.TODT <='"+str[1]+"'))                      \n");
					if(!str[2].equals("")&&!str[3].equals(""))sql.append( " AND A.EMPNO BETWEEN '"+str[2]+"' AND '"+str[3]+"' \n");
					if(!str[4].equals(""))sql.append( " AND (B.EMPNMK LIKE '"+str[4]+"%' OR C.EMPNMK LIKE '"+str[4]+"%') \n");
					if(!str[5].equals(""))sql.append( " AND A.LAZCD ='"+str[5]+"'                               \n");
					if(!str[6].equals(""))sql.append( " AND A.DEPTCD IN "+str[6]+"                              \n");
					if(!str[7].equals(""))sql.append( " AND A.PAYGRD ='"+str[7]+"'                              \n");
					if(!str[8].equals(""))sql.append( " AND A.CLOSYN ='"+str[8]+"'                              \n");
          
					if(str[9].equals("R"))sql.append( " AND SUBSTR(A.EMPNO,1,1) IN ('1','2')   \n");
          if(str[9].equals("T"))sql.append( " AND SUBSTR(A.EMPNO,1,1) NOT IN ('1','2')   \n");
					 
					sql.append( "   ORDER BY A.APPDT, A.DEPTCD, D.SEQ, A.EMPNO, A.FRDT \n");

					//logger.dbg.println(this, sql.toString());

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