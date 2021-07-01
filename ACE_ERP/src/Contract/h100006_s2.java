package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h100006_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//부서
				str[1]	= req.getParameter("v_str2");		//성명
				str[2]	= req.getParameter("v_str3");		//사번-급여 명세서 출력시 사용
				str[3]	= req.getParameter("v_str4");		//최종불입월

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"DEPTNM",	   /* 부서 */
					"EMPNO",     /*사번*/
					"EMPNMK",    /*성명*/
					"FRDT",      /*가입일*/
					"TODT",      /*종료일*/
					"DIV",       /*연금코드*/
					"DIVNM",     /*연금종류*/
					"INSUR",     /*금융기관*/
					"INSURNM",   /*금융기관이름*/
					"TOTDAY",    /*총불입기간*/
					"TOTCNT",    /*누계횟수*/
					"PERAMT",    /*본인부담*/
					"SUPAMT",    /*회사지원*/
					"TOTAMT",    /*누계액*/
					"LASTMON",   /*누계액*/
					"RESINO"     /*주민번호*/
				};

				int[] intArrCN = new int[]{  
					50,					 /* 부서 */      	
					7,	 				 /*사번*/        
					20,	 				 /*성명*/        
					8, 	 				 /*가입일*/      
					8, 	 				 /*종료일*/      
					4,	 				 /*연금코드*/    
					30,	 				 /*연금종류*/    
					4, 	 				 /*금융기관*/    
					30,	 				 /*금융기관이름*/
					10, 	  		 /*총불입기간*/  
					5,	 				 /*누계횟수*/    
					9, 	 				 /*본인부담*/    
					9,	 				 /*회사지원*/    
					12, 	  		 /*누계액*/      
					6,	 				 /*누계액*/      
					13	 				 /*주민번호*/    
         }; 

				int[] intArrCN2 = new int[]{
					-1,					 /* 부서 */      
					-1,	 				 /*사번*/        
					-1,  				 /*성명*/        
					-1,  				 /*가입일*/      
					-1,	 				 /*종료일*/      
					-1,	 				 /*연금코드*/    
					-1,	 				 /*연금종류*/    
					-1,	 				 /*금융기관*/    
					-1,	 				 /*금융기관이름*/
					-1,  				 /*총불입기간*/  
					0,   				 /*누계횟수*/    
					0,	 				 /*본인부담*/    
					0,	 				 /*회사지원*/    
					0,	 				 /*누계액*/      
					-1,	 				 /*누계액*/      
					-1	 				 /*주민번호*/    
         }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  ");
					sql.append( " RTRIM(C.DEPTNM) AS DEPTNM, ");	  
					sql.append( " RTRIM(A.EMPNO) EMPNO, ");   
					sql.append( " RTRIM(B.EMPNMK) EMPNMK, ");  
					sql.append( " A.FRDT, ");   
					sql.append( " A.TODT, ");   
					sql.append( " A.DIV, ");   
					sql.append( " D.MINORNM AS DIVNM, ");  
					sql.append( " A.INSUR, ");   
					sql.append( " F.MINORNM AS INSURNM, ");  
					sql.append( " A.TOTDAY, ");   
					sql.append( " A.TOTCNT, ");   
					sql.append( " A.PERAMT, ");   
					sql.append( " A.SUPAMT, ");   
					sql.append( " A.TOTAMT, ");   
					sql.append( " A.LASTMON, ");  
					sql.append( " B.RESINO ");  
					sql.append( " FROM PAYROLL.PWINDPEN A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.T_HIPERSON B ON  A.EMPNO = B.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
          sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  A.DIV = D.MINORCD  AND D.MAJORCD = '1170' \n");
          sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON  A.INSUR = F.MINORCD  AND F.MAJORCD = '1171' \n");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ''  \n ");
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND B.DEPTCD  = '"  + str[0] + "' ");    //부서
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[1]+ "%' ");   //성명
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.EMPNO = '" + str[2]+ "' ");				//사번
					if (!str[3].equals("")) sql.append( " AND A.LASTMON = '" + str[3] + "' ");													//지급일자

					sql.append( " ORDER BY B.DEPTCD  ASC , A.EMPNO ASC ");
					
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