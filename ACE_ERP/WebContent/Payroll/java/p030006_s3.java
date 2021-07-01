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
public class p030006_s3 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//사번

				for (int s=0;s<=0;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{
						
						"CEONM","CEONO","HYCOUNT","JOCOUNT","PB10000",
						"PB41000","PB42000","PB43000","SUMAMT"
				};

				int[] intArrCN = new int[]{  

					 20,	//대표자      
					 20,	//법인번호    
						9,	//현인원수	  
						9,	//종전인원수	
						9,	//소득금액총계
						9,	//결정소득세	
						9,	//결정주민세	
						9,	//결정농특세	
						9		//결정세합계	
         }; 
				
				int[] intArrCN2 = new int[]{ 

					 -1,	//대표자
				 	 -1,	//법인번호
						0,	//현인원수	
						0,	//종전인원수		
						0,	//소득금액총계		
						0,	//결정소득세	
						0,	//결정주민세		
						0,	//결정농특세		
						0		//결정세합계								
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT																																										\n"); 
						sql.append(" '윤만준' AS CEONM,                                         /*대표자*/										\n"); 
						sql.append(" '111-01-00111' AS CEONO,                                   /*법인번호*/									\n"); 
						sql.append(" (SELECT COUNT(*) FROM PAYROLL.YCPAYCOL) AS HYCOUNT,        /*현인원수*/									\n"); 
						sql.append(" (SELECT COUNT(*) FROM PAYROLL.YCBEFOFF) AS JOCOUNT,        /*종전인원수*/								\n"); 
						sql.append(" A.PB10000,                                                 /*소득금액총계*/							\n"); 
						sql.append(" (SELECT SUM(PB41000) FROM PAYROLL.YCPAYCOL ) AS PB41000,   /*결정소득세*/								\n"); 
						sql.append(" (SELECT SUM(PB42000) FROM PAYROLL.YCPAYCOL ) AS PB42000,   /*결정주민세*/								\n"); 
						sql.append(" (SELECT SUM(PB43000) FROM PAYROLL.YCPAYCOL ) AS PB43000,   /*결정농특세*/								\n"); 
						sql.append(" (SELECT SUM(PB41000+PB42000+PB43000) FROM PAYROLL.YCPAYCOL ) AS SUMAMT   /*결정세합계*/	\n"); 
						sql.append(" FROM PAYROLL.YCPAYCOL A  /*소득자별근로소득원천징수*/																		\n"); 
						sql.append(" LEFT JOIN PAYROLL.YCBEFOFF B ON A.EMPNO = B.EMPNO  /*종전근무지관리*/										\n"); 
						sql.append(" WHERE B.EMPNO = '2000001'																																\n"); 

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