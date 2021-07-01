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
public class Em014_S extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";}
				String  str2	= req.getParameter("v_str2"); if (str2==null) {str2="";}
				String  str3	= req.getParameter("v_str3"); if (str3==null) {str3="";}
				

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
				    "DEPT_CD", "TEAM_CD", "EMPNO","EMPNMK","START_DT","O_TIME_TOT",
					"D01","D02","D03","D04","D05",
					"D06","D07","D08","D09","D10",
					"D11","D12","D13","D14","D15",
					"D16","D17","D18","D19","D20",
					"D21","D22","D23","D24","D25",
					"D26","D27","D28","D29","D30",
					"D31"
										};

				int[] intArrCN = new int[] { 
                                            5,5,10,30,8,5,
                                            5,5,5,5,5,
											5,5,5,5,5,		
											5,5,5,5,5,
											5,5,5,5,5,
											5,5,5,5,5,
											5,5,5,5,5,
											5	
                                            								}; 
			
				int[] intArrCN2 = new int[]{
                                           -1,-1,-1,-1, -1,1,
											-1,-1,-1,-1,-1,
											-1,-1,-1,-1,-1,	
											-1,-1,-1,-1,-1,	
											-1,-1,-1,-1,-1,		
											-1,-1,-1,-1,-1,	
											-1,-1,-1,-1,-1,	
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
					sql.append( "	SELECT X.DEPT_CD, X.TEAM_CD, X.EMPNO, X.EMPNMK, X.START_DT, SUM(X.O_TIME_TOT)O_TIME_TOT,                            \n");
					sql.append( "	       MAX(X.D01)D01, MAX(X.D02)D02, MAX(X.D03)D03, MAX(X.D04)D04, MAX(X.D05)D05,                                      \n");
					sql.append( "	       MAX(X.D06)D06, MAX(X.D07)D07, MAX(X.D08)D08, MAX(X.D09)D09, MAX(X.D10)D10, MAX(X.D11)D11,                                                              \n");
					sql.append( "	       MAX(X.D12)D12, MAX(X.D13)D13, MAX(X.D14)D14, MAX(X.D15)D15, MAX(X.D16)D16, MAX(X.D17)D17,                                                              \n");
					sql.append( "	       MAX(X.D18)D18, MAX(X.D19)D19, MAX(X.D20)D20, MAX(X.D21)D21, MAX(X.D22)D22, MAX(X.D23)D23,                                                              \n");
					sql.append( "	       MAX(X.D24)D24, MAX(X.D25)D25, MAX(X.D26)D26, MAX(X.D27)D27, MAX(X.D28)D28, MAX(X.D29)D29, MAX(X.D30)D30, MAX(X.D31)D31                                                            \n");
					sql.append( "	 FROM(                                                                                                  \n");
					sql.append( "	      SELECT                                                                                            \n");	
					sql.append( "		    A.DEPT_CD,                                                                                  \n");
					sql.append( "		    A.TEAM_CD,                                                                                  \n");
					sql.append( "		    A.EMPNO,                                                                                    \n");
					sql.append( "		    A.WORK_GB,                                                                                  \n");				        
					sql.append( "		    B.EMPNMK,                                                                                   \n");
					sql.append( "		    A.ATT_DT,  B.START_DT,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,1,6)='"+str1+"' AND A.WORK_GB IN ('001','003') THEN SUM(A.O_TIME_TOT) ELSE 0 END O_TIME_TOT,       \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='01' THEN                                                    \n");									       
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");
					sql.append( "		    END D01,                                                                                    \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='02' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D02,                                                                                    \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='03' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");									        
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");
					sql.append( "		    END D03,                                                                                    \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='04' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");									       
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");
					sql.append( "		    END D04,                                                                                    \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='05' THEN                                                    \n");									        
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");
					sql.append( "		    END D05,                                                                                    \n");	   
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='06' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");
					sql.append( "		    END D06,                                                                                    \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='07' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");				        
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");
					sql.append( "		    END D07,                                                                                    \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='08' THEN                                                    \n");
					sql.append( "			 CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5)) \n");
					sql.append( "				WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'   \n");          
					sql.append( "				WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END         \n");                      
					sql.append( "			    END D08 , 	\n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='09' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D09 ,                                                                                   \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='10' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D10 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='11' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D11 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='12' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D12 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='13' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D13 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='14' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D14 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='15' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D15 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='16' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D16 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='17' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D17 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='18' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D18  ,                                                                                 \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='19' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D19 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='20' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D20 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='21' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D21 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='22' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D22 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='23' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D23 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='24' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D24  ,                                                                                 \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='25' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D25 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='26' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D26 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='27' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D27 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='28' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D28  ,                                                                                 \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='29' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D29,                                                                                   \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='30' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D30 ,                                                                                  \n");
					sql.append( "		    CASE WHEN SUBSTR(A.ATT_DT,7,2)='31' THEN                                                    \n");
					sql.append( "			      CASE WHEN A.WORK_GB IN ('001','003') THEN CAST(SUM(A.O_TIME_TOT) AS VARCHAR(5))   \n");
					sql.append( "				   WHEN A.WORK_GB ='002' THEN 'H'  WHEN A.WORK_GB ='004' THEN 'C'               \n");
					sql.append( "				   WHEN A.WORK_GB ='005' THEN 'V'  ELSE '0' END                                 \n");									       
					sql.append( "		    END D31                                                                                  \n");
					sql.append( "	 FROM SALES.TCM350 A                           \n");
				  sql.append( "	 LEFT OUTER JOIN SALES.TCM300 B ON A.EMPNO=B.EMPNO                                    \n");
				  sql.append( "	   WHERE 1=1                                                           \n");
					if(!str1.equals(""))sql.append( "	AND A.ATT_DT BETWEEN '"+str1+"01'   AND '"+str1+"31'   \n");
					if(!str2.equals(""))sql.append( "	AND A.DEPT_CD = '"+str2+"'      \n");
					if(!str3.equals(""))sql.append( "	AND A.TEAM_CD = '"+str3+"'      \n");
					sql.append( "	 GROUP BY A.EMPNO, A.WORK_GB , A.DEPT_CD, A.TEAM_CD, A.EMPNO, B.EMPNMK, A.ATT_DT , B.START_DT                                                                                        \n");
					sql.append( "		  )X                                                                                 \n");
					sql.append( "	GROUP BY X.DEPT_CD, X.TEAM_CD, X.EMPNO, X.EMPNMK, X.START_DT                                                                                \n");
					sql.append( "	ORDER  BY X.START_DT,  X.EMPNMK                                                                                \n");          
					//logger.dbg.println(this,sql.toString());  
					stmt = conn.getGauceStatement(sql.toString());
  				//logger.dbg.println(this,str1);
	 				stmt.executeQuery(dSet);
					//logger.dbg.println(this,"OK_Em010_ED");
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