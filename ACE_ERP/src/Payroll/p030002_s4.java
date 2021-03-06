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
public class p030002_s4 extends HttpServlet {

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
				str[1]  = req.getParameter("v_str2");		//귀속년도
				str[2]  = req.getParameter("v_str3");		//작성일자

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{		
					"YYYY",				/*귀속연도*/
					"EMPNO",			/*사번*/
					"EMPNMK",			/*성명*/
					"RESINO",			/*주민번호1*/
					"ADDNM",			/*주소*/
					"INDNO",			/*의료기관코드*/
					"INDNAME",		/*의료기관명*/
					"CARDCNT",		/*카드건수*/
					"CARDAMT",		/*카드금액*/
					"RELATION",		/*관계*/
					"JUMINNO",		/*주민번호2*/
					"EMPCHK",			/*본인여부*/
					"CURDT"				/*작성일자*/
				};

				int[] intArrCN = new int[]{  
						4,						/*귀속연도*/                
						7,        		/*사번*/        
						20,	      		/*성명*/
						13,	      		/*주민번호1*/
						100,					/*주소*/
						11,       		/*의료기관코드*/
						100,      		/*의료기관명*/  
						2, 	      		/*카드건수*/    
						9, 	      		/*카드금액*/    
						1,	      		/*관계*/        
						13,	      		/*주민번호2*/    
						1, 	      		/*본인여부*/         			
						8							/*작성일자*/
         }; 
				
				int[] intArrCN2 = new int[]{ 
					  -1,						/*귀속연도*/                      
						-1,           /*사번*/                        
						-1,           /*성명*/
						-1,						/*주민번호*/
						-1,           /*주소*/     
						-1,           /*의료기관코드*/                
						-1,           /*의료기관명*/                  
						 0,           /*카드건수*/                    
						 0,           /*카드금액*/                    
						-1,						/*관계*/        
						-1,						/*주민번호*/    
						-1,						/*본인여부*/    
						-1						/*작성일자*/
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT																							\n");
						sql.append(" RTRIM(A.YYYY) YYYY,							/*귀속연도*/			\n");
						sql.append(" RTRIM(A.EMPNO) EMPNO,						/*사번*/					\n");
						sql.append(" RTRIM(B.EMPNMK) EMPNMK,					/*성명*/					\n");
						sql.append(" RTRIM(B.RESINO) RESINO,					/*주민등록번호*/	\n");
						sql.append(" RTRIM(B.CADDR01) || ' ' || RTRIM(B.CADDR02) ADDNM,		/*주소*/	\n");
						sql.append(" RTRIM(A.INDNO) INDNO,						/*의료기관코드*/	\n");
						sql.append(" RTRIM(A.INDNAME) INDNAME,				/*의료기관명*/		\n");
						sql.append(" COALESCE(A.CARDCNT+A.CASHCNT,0) CARDCNT,		/*카드+현금건수*/	\n");
						sql.append(" COALESCE(A.CARDAMT+A.CASHAMT,0) CARDAMT,		/*카드+현금금액*/	\n");
						sql.append(" RTRIM(A.RELATION) RELATION,			/*관계*/					\n");
						sql.append(" RTRIM(A.JUMINNO) JUMINNO,				/*주민번호*/			\n");
						sql.append(" RTRIM(A.EMPCHK) EMPCHK,					/*본인여부*/			\n");
						sql.append(" '"+str[2]+"' AS CURDT						/*작성일자*/			\n");
						sql.append(" FROM PAYROLL.YCINDIPN A					/*의료비명세서*/	\n");
						sql.append(" LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO  \n");
						sql.append(" WHERE RTRIM(A.EMPNO) <> ''													\n");
						
						//if (!str[0].equals("")) sql.append(" AND A.EMPNO = '"+str[0]+"'	\n");
						if (!str[0].equals("")) sql.append(" AND B.EMPNMK LIKE '"+str[0]+"%'	\n"); 
						if (!str[1].equals("")) sql.append(" AND A.YYYY	 = '"+str[1]+"'	\n");

						sql.append(" ORDER BY EMPNMK																		\n");

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