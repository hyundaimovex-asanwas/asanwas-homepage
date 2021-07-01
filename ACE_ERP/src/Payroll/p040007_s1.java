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
public class p040007_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//기준년월
				str[1]	= req.getParameter("v_str2");		//부서
				str[2]	= req.getParameter("v_str3");		//직위
				str[3]	= req.getParameter("v_str4");		//성명

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"EMPNMK","APPDT","STRTDT",
					"BASAMT1","BASAMT2","BASAMT3","BASAMT","BASAVG",
					"BUSAMT","BUSAVG","BAEAMT1","BAEAMT2","BAEAMT3","BAEAMT",
					"BAEAVG","YEAPAY","YEAAVG","AVGTOT","DUYEAR",
					"DUYMM","PRGAMT","ENDJAMT","PRGJAMT","PRGADD",
					"PRGTOT","EMPNO","DEPTPRNM","DEPTNM","PAYGNM",
					"RESINO","GRSTRTDT"
				};

				int[] intArrCN = new int[]{  
					  20,  6,  8, 	
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9, 9,
						9,  9,  9,  9,  2,
						2,  9,  9,  9,  9,
						9,  7, 30, 30, 30, 
					 13,	8
        }; 

				int[] intArrCN2 = new int[]{
					-1, -1, -1,   
					 0,  0,  0,  0,  0,
					 0,  0,  0,  0,  0, 0,
					 0,  0,  0,  0,  0,
					 0,  0,  0,  0,  0,
					 0, -1, -1, -1, -1,
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
					sql.append( "  SELECT  ");
					sql.append( "  A.EMPNMK,										\n");	/*한글명*/
					sql.append( "  B.APPDT,											\n");	/*년월*/
					sql.append( "  B.STRTDT,										\n");	/*입사일*/		
					sql.append( "  B.BASAMT1,										\n");	/*기본직책1*/               		
					sql.append( "  B.BASAMT2,										\n");	/*기본직책2*/               		
					sql.append( "  B.BASAMT3,										\n");	/*기본직책3*/               		
					sql.append( "  B.BASAMT,										\n");	/*급여합계(급여계)*/        		
					sql.append( "  B.BASAVG,										\n");	/*평균급여*/                		
					sql.append( "  B.BUSAMT,										\n");	/*상여총액*/ 
					sql.append( "  B.BUSAVG,										\n");	/*평균상여*/
					sql.append( "  B.BAEAMT1,										\n");	/*기타수당1*/               	
					sql.append( "  B.BAEAMT2,										\n");	/*기타수당2*/               		
					sql.append( "  B.BAEAMT3,										\n");	/*기타수당3*/               	
					sql.append( "  B.BAEAMT,										\n");	/*수당합계(수당계)*/        	
					sql.append( "  B.BAEAVG,										\n");	/*평균수당(수당계/91*30)*/  		
					sql.append( "  B.YEAPAY,										\n");	/*년차수당*/                		
					sql.append( "  B.YEAAVG,										\n");	/*평균년차*/                		
					sql.append( "  B.AVGTOT,										\n");	/*평균합계*/                		
					sql.append( "  B.DUYEAR,										\n");	/*근무년수*/                		
					sql.append( "  B.DUYMM,											\n");	/*근무월수*/                		
					sql.append( "  B.PRGAMT,										\n");	/*퇴직금액*/                		
					sql.append( "  B.ENDJAMT,										\n");	/*전기설정*/                		
					sql.append( "  B.PRGJAMT,										\n");	/*퇴사자퇴직금(감소(퇴사))*/		
					sql.append( "  B.PRGADD,										\n");	/*추가설정액*/              	
					sql.append( "  B.PRGTOT,										\n");	/*충당금연말잔액*/          		
					sql.append( "  B.EMPNO,											\n");	/*사번*/                    	
					sql.append( "  RTRIM(E.MINORNM) DEPTPRNM,		\n");	/*근무지*/                  
					sql.append( "  RTRIM(C.DEPTNM) DEPTNM,			\n");	/*부서(소속)*/              
					sql.append( "  RTRIM(D.MINORNM) PAYGNM,			\n");	/*직위*/                    
					sql.append( "  A.RESINO,										\n");	/*주민번호*/                
					sql.append( "  A.GRSTRTDT										\n");	/*그룹입사일*/              
					sql.append( "  FROM  PAYROLL.PRDEVPAY B			\n");	/*퇴직충당금*/ 
					sql.append( "  LEFT OUTER JOIN PAYROLL.HIPERSON A ON A.EMPNO = B.EMPNO\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCDEPT   C ON A.DEPTCD = C.DEPTCD \n");;
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE  D ON D.MINORCD=A.PAYGRD AND D.MAJORCD='2002' \n");	/*직위코드*/
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE  E ON E.MINORCD=C.DEPTPRT AND E.MAJORCD='1111' \n");	/*근무지*/
					sql.append( "  WHERE RTRIM(B.EMPNO) <> '' \n");
					sql.append( "    AND B.DEPTCD <> 'A400'   \n");  //비상근제외
					sql.append( "    AND ( B.ENDDT='' OR B.ENDDT IS NULL OR SUBSTR(B.ENDDT,1,6) > '" + str[0] + "' )\n");  //퇴사자제외
				  sql.append( "    AND B.USESTS IN ( '1','2')   \n");  //정규직 및 휴직자

					if (!str[0].equals("")&&!str[0].equals("0") )sql.append( " AND SUBSTRING(B.APPDT,1,6) = '" + str[0] + "' \n"); //기준년월						
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.DEPTCD ='" + str[1]+ "' \n");				//부서
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.PAYGRD ='" + str[2]+ "' \n");				//직급
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[3]+ "%' \n");		//성명

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