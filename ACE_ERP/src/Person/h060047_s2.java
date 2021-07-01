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
public class h060047_s2 extends HttpServlet {

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

				String [] str = new String [1];
				String strGb="";

				str[0]	= req.getParameter("v_str1");		//고과년월
				for (int s=0;s<=0;s++) {
					if (str[s]==null) str[s] = "";
				}

       	int intyymm=0;
				if(!str[0].equals("")) intyymm = Integer.parseInt(str[0]);	

				if (intyymm>200801){
					strGb="A";
				}else{
          strGb="B";
				}
       
			
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EVAYM",	 "EMPNO", "EMPNMK", "DEPTCD", "DEPTNMK",
					                                "PAYGRD",	 "PAYGRDNM"
																				 }; 

				int[] intArrCN = new int[] {  6,   7,  30,  4,  60,  
					                            4,  20 
				                           }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					

					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.EVAYM, A.EMPNO, B.EMPNMK, A.DEPTCD, C.DEPTNMK,                     ");
					sql.append( "        A.PAYGRD, D.MINORNM AS PAYGRDNM                                      ");
					sql.append( "   FROM PAYROLL.HVEMPS A                                                     ");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO = B.EMPNO                         ");
					
					if(strGb.equals("A")){
            sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD                       ");
					}else{  
            sql.append( "   LEFT JOIN PAYROLL.HCDEPT_99 C ON A.DEPTCD = C.DEPTCD                    ");
					}
					
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD='2002'  ");
          if(!str[0].equals(""))sql.append( "  WHERE EVAYM ='"+str[0]+"'                            ");				
					
					//logger.dbg.println(this,sql.toString());
					
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