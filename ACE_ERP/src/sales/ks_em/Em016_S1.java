package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em016_S1 extends HttpServlet {

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
				String [] str = new String[9];
        str[0] =  req.getParameter("v_str1"); // 부서 
				str[1] =  req.getParameter("v_str2"); // 소속   
				str[2] =  req.getParameter("v_str3"); // 사번
				str[3] =  req.getParameter("v_str4");	// 성명
				str[4] =  req.getParameter("v_str5");	// 계약구분      
				str[5] =  req.getParameter("v_str6"); // 계약만료년월
				str[6] =  req.getParameter("v_str7");	// 계약일자_fr     
				str[7] =  req.getParameter("v_str8"); // 계약일자_to
				str[8] =  req.getParameter("v_str9"); // 마감구분
				
        for(int i=0;i<=8;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "EMPNO","EMPNMK", "SEQ", "CUST_SID",
                                           "JOB_CD", "JOB_NM","VEND_CD","VEND_NM",
					                                 "DEPT_CD","DEPT_NM","TEAM_CD","TEAM_NM",
					                                 "WORK_CD","WORK_NM","CONT_GB","CONT_NM",
                                           "START_DT","END_DT",
					                                 "C_EMPNO","C_EMPNMK","C_POSI_CD","C_POSI_NM","C_OPI",
					                                 "T_EMPNO","T_EMPNMK","T_POSI_CD","T_POSI_NM","T_OPI",
                                           "REMARK",
                                           "CHK", "I_EMPNO","U_EMPNO","I_DATE","U_DATE",
					                                 "REWARD_YM" , "PAYGBNM", "CON_YEAR" , "SKILL_CD","B_PAY0","BON_YM", "CLOSE_YN"                                 
																		  	}; //

				int[] intArrCN = new int[] { 10, 30, 2, 10,
					                            5, 50,10, 50, 
																		  5, 50, 5, 50,
					                            5, 50, 3, 50,
                                      8,  8,
					                           10, 30, 3, 30, 60,
					                           10, 30, 3, 30, 60,
					                           40, 
					                            1, 10,10, 10, 10,
					                            6, 10, 2 ,3,  10, 6, 1
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, 0, 0,
					                           -1,-1, 0,-1,
					                           -1,-1,-1,-1,
					                           -1,-1,-1,-1,
					                           -1,-1,  
					                           -1,-1,-1,-1,-1,
					                           -1,-1,-1,-1,-1,
					                           -1,
					                           -1,-1,-1,-1,-1,
					                           -1,-1, 0,-1, 2, -1, -1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	 SELECT A.EMPNO, RTRIM(H.EMPNMK) EMPNMK,                         \n");
						sql.append( "	        A.SEQ,   COALESCE(A.CUST_SID,0)CUST_SID,  A.JOB_CD, G.DETAIL_NM AS JOB_NM,   \n");
						sql.append( "	        A.VEND_CD, RTRIM(B.DETAIL_NM) AS VEND_NM,                \n");
						sql.append( "	        A.DEPT_CD, RTRIM(C.DETAIL_NM) AS DEPT_NM,                \n");
						sql.append( "	        A.TEAM_CD, RTRIM(D.DETAIL_NM) AS TEAM_NM,                \n");
						sql.append( "	        A.WORK_CD, RTRIM(E.DETAIL_NM) AS WORK_NM,                \n");
						sql.append( "	        A.CONT_GB, RTRIM(F.DETAIL_NM) AS CONT_NM,                \n");
						sql.append( "	        A.START_DT,A.END_DT,                                     \n");
						sql.append( "	        A.C_EMPNO, RTRIM(I.EMPNMK) AS C_EMPNMK, A.C_POSI_CD, RTRIM(L.MINORNM) AS C_POSI_NM, A.C_OPI,   \n");
						sql.append( "	        A.T_EMPNO, RTRIM(K.EMPNMK) AS T_EMPNMK, A.T_POSI_CD, RTRIM(M.MINORNM) AS T_POSI_NM, A.T_OPI,   \n");
						sql.append( "	        A.REMARK,                                                \n");
						sql.append( "	        ''CHK,  A.I_EMPNO, A.I_DATE,  A.U_EMPNO, A.U_DATE, A.REWARD_YM,   \n");
						sql.append( "	        CASE WHEN A.PAY_GB = 'Y' THEN '지급' ELSE '미지급' END  PAYGBNM, A.CON_YEAR ,H.SKILL_CD,A.B_PAY0, A.BON_YM, A.CLOSE_YN \n");
						sql.append( "	   FROM SALES.TCM345 A                                           \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.VEND_CD) AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''  \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.DEPT_CD) AND C.HEAD='CM006' AND RTRIM(C.DETAIL)<>''  \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.TEAM_CD) AND D.HEAD='CM003' AND RTRIM(D.DETAIL)<>''  \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.WORK_CD) AND E.HEAD='CM007' AND RTRIM(E.DETAIL)<>''  \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.CONT_GB) AND F.HEAD='CM015' AND RTRIM(F.DETAIL)<>''  \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.JOB_CD)  AND G.HEAD='CM004' AND RTRIM(G.DETAIL)<>''  \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TCM300 H ON RTRIM(H.EMPNO) = RTRIM(A.EMPNO)                                                \n");
						sql.append( "	   LEFT OUTER JOIN PAYROLL.CIPERSON I ON RTRIM(I.EMPNO) = RTRIM(A.C_EMPNO)                                          \n");
						sql.append( "	   LEFT OUTER JOIN PAYROLL.CIPERSON K ON RTRIM(K.EMPNO) = RTRIM(A.T_EMPNO)                                          \n");
						sql.append( "	   LEFT OUTER JOIN PAYROLL.HCLCODE  L ON RTRIM(L.MINORCD) = RTRIM(A.C_POSI_CD) AND L.MAJORCD='2002'  \n");
						sql.append( "	   LEFT OUTER JOIN PAYROLL.HCLCODE  M ON RTRIM(M.MINORCD) = RTRIM(A.T_POSI_CD) AND M.MAJORCD='2002'    \n");
						sql.append( "	   WHERE 1=1 \n");						
						if(!str[0].equals(""))sql.append( "	  AND A.DEPT_CD = '"+str[0]+"'    \n");
						if(!str[1].equals(""))sql.append( "	  AND A.TEAM_CD = '"+str[1]+"' \n");
						if(!str[2].equals(""))sql.append( "	  AND A.EMPNO = '"+str[2]+"' \n");
						if(!str[3].equals(""))sql.append( "	  AND H.EMPNMK LIKE '"+str[3]+"%' \n");
						if(!str[4].equals(""))sql.append( "	  AND A.CONT_GB = '"+str[4]+"' \n");
						if(!str[5].equals(""))sql.append( "	  AND A.END_DT LIKE '"+str[5]+"%' \n");
						if(!str[6].equals("")&&!str[7].equals(""))sql.append( "	  AND ( (A.START_DT BETWEEN '"+str[6]+"' AND '"+str[7]+"') \n");
						if(!str[6].equals("")&&!str[7].equals(""))sql.append( "	     OR (A.END_DT BETWEEN '"+str[6]+"' AND '"+str[7]+"'))\n");
						if(str[8].equals("N"))sql.append( "	AND (A.CLOSE_YN <>'Y' OR A.CLOSE_YN IS NULL) \n");
						if(str[8].equals("Y"))sql.append( "	AND A.CLOSE_YN = 'Y' \n");
						logger.dbg.println(this,sql.toString());
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