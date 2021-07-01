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
public class p030007_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//귀속년도
				str[1]  = req.getParameter("v_str2");		//성명

				for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
						"YYYY",			/*귀속연도*/
						"EMPNO",    /*사번*/
						"EMPNMK",		/*성명*/
						"RESINO",   /*주민번호*/
						"GIVDATE",	/*기부년월*/		
						"GIVCOD",		/*코드*/
						"GIVTYPE",	/*유형*/
						"GIVGMOK",	/*과목*/
						"GIVJYO",		/*적요*/
						"GIVCOMP",	/*상호*/
						"GIVSAUP",	/*사업자번호*/
						"GIVAMT",		/*금액*/			
						"GIVCNT",   /*건수*/
						"GIVREF"		/*비고*/
						
				};

				int[] intArrCN = new int[]{  
						4,					/*귀속연도*/               
						7,					/*사번*/             
						20,					/*성명*/ 
						13,					/*주민번호*/
						6,					/*기부년월*/         
						2,					/*코드*/               
						50,					/*유형*/             
						50,					/*과목*/             
						50,					/*적요*/             
						100,				/*상호*/                    			
						11,					/*사업자번호*/  
						9,					/*금액*/	
						2,          /*건수*/
						100					/*비고*/        
         		
				};
				
				int[] intArrCN2 = new int[]{ 
					  -1,					/*귀속연도*/                       
						-1,         /*사번*/                         
						-1,         /*성명*/   
						-1,         /*주민번호*/    
						-1,         /*기부년월*/                     
						-1,         /*코드*/        
						-1,					/*유형*/        
						-1,					/*과목*/        
						-1,					/*적요*/        
						-1,					/*상호*/        
						-1,					/*사업자번호*/  
						 0,					/*금액*/
						 0,         /*건수*/
						-1					/*비고*/        
						
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT																																		\n");
						sql.append(" RTRIM(A.YYYY) YYYY,																	/*귀속연도*/				\n");
						sql.append(" RTRIM(A.EMPNO) EMPNO,																/*사번*/						\n");
						sql.append(" RTRIM(B.EMPNMK) EMPNMK,															/*성명*/						\n");
						sql.append(" RTRIM(B.RESINO) RESINO,															/*주민번호*/				\n");
						sql.append(" RTRIM(A.GIVDATE) GIVDATE,														/*기부년월*/				\n");
						sql.append(" RTRIM(A.GIVCOD) GIVCOD,															/*코드*/						\n");
						sql.append(" RTRIM(A.GIVTYPE) GIVTYPE,														/*유형*/						\n");
						sql.append(" RTRIM(A.GIVGMOK) GIVGMOK,														/*과목*/						\n");
						sql.append(" RTRIM(A.GIVJYO) GIVJYO,															/*적요*/						\n");
						sql.append(" RTRIM(A.GIVCOMP) GIVCOMP,														/*상호*/						\n");
						sql.append(" RTRIM(A.GIVSAUP) GIVSAUP,														/*사업자번호*/			\n");
						sql.append(" COALESCE(A.GIVAMT,0) GIVAMT,													/*금액*/						\n");
						sql.append(" COALESCE(A.GIVCNT,0) GIVCNT,													/*금액*/						\n");
						sql.append(" RTRIM(A.GIVREF) GIVREF 															/*비고*/						\n");
						sql.append(" FROM PAYROLL.YCGIBU A																/*기부금명세서*/		\n");	
						sql.append(" LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO		/*인사기본정보*/		\n");
						sql.append(" WHERE RTRIM(A.EMPNO) <> ''																								\n");
						if (!str[0].equals(""))	{	sql.append(" AND RTRIM(A.YYYY)		= '"+str[0]+"'	\n"); }
						if (!str[1].equals(""))	{	sql.append(" AND RTRIM(B.EMPNMK) LIKE '"+str[1]+"%'	\n");	}

						sql.append(" ORDER BY EMPNMK \n");

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