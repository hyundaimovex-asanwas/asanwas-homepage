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
public class p050004_s1 extends HttpServlet {

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
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//부서
				str[1]	= req.getParameter("v_str2");		//성명
				str[2]	= req.getParameter("v_str3");		//LEVEL
				str[3]	= req.getParameter("v_str4");		//TREECD

				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* 부서 */
				"EMPNO",       /*사번*/
				"EMPNMK",
				"RESINO",
				"EDCCDNM",       /*사번*/
				"EDCDIVNM",
				"SCHNM"
				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20,
					13,
					30,
					30,
					60
            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,   
					-1,
					-1,
					-1,
					-1
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
					sql.append( "  C.DEPTNM AS DEPTNM, ");	  
					sql.append( "  A.EMPNO, ");   
					sql.append( "  A.EMPNMK, ");  
					sql.append( "  A.RESINO, ");  
					sql.append( "  E.MINORNM AS EDCCDNM, ");  
					sql.append( "  F.MINORNM AS EDCDIVNM, ");  
					sql.append( "  RTRIM(D.SCHNM) AS SCHNM ");  
					sql.append( " FROM  PAYROLL.HIPERSON A  "); 
					sql.append( " LEFT OUTER JOIN (SELECT EMPNO,MAX(STRYY) AS STRYY  FROM PAYROLL.HIEDUC GROUP BY EMPNO) B ON  A.EMPNO = B.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  A.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HIEDUC D ON  A.EMPNO = D.EMPNO AND D.STRYY=B.STRYY  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE E ON  D.EDCCD = E.MINORCD  AND E.MAJORCD = '1115'  ");  //학교
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE F ON  D.EDCDIV = F.MINORCD  AND F.MAJORCD = '1118'  ");  //졸업구분
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE G ON  A.PAYGRD = G.MINORCD  AND G.MAJORCD = '2002'  ");  //직위
					sql.append( " WHERE  A.USESTS='1'  \n ");
					//if ( !str[0].equals("")&&!str[0].equals("0"))
					//	sql.append( " AND A.DEPTCD  = '"  + str[0] + "'");    //부서
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[1]+ "%' ");     //성명
						
				  if (str[2].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[3] +"'");
					if (str[2].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[3] + "'");
					if (str[2].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[3]+"'");
					if (str[2].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[3] + "'");
						
						sql.append( " ORDER BY C.TREECD  ASC , G.SEQ ASC ");

					logger.dbg.println(this,sql.toString());
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