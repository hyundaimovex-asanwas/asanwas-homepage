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
public class p040004_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//퇴사일자부터
				str[1]	= req.getParameter("v_str2");		//퇴사일자까지
				str[2]	= req.getParameter("v_str3");		//성명

				for (int s=0;s<3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{

				"EMPNO",	/* 사번 */
				"APPYM",	/* 년월 */
				"PAYDIV",	/*  지급구분*/
				"PAYDIVNM",	/* 지급구분명*/
				"PAYDT",    /*  퇴직급여정산일*/
				"ENDDT",	/* 퇴사일 */

				"DUYEAR",	/*  근무년수*/
				"DUYMM",	/*  근무월수 */
				"DUDAY",	/*  근무일수 */

				"P10000",	/*  기본급여*/
				"P11000",	/*  직책수당 */
				"P12000",	/*  시간외수당*/
				"P21000",	/*  근속수당*/
				"P22000",	/*  자기계발비*/
				"P23000",	/*  부양가족수당*/

				"P25000",	/*  출납수당*/
				"P27000",	/*  연장수당*/
				"P28000",	/*  자격수당*/
				"P29000",	/*  남북경협수당*/
				"P30000",	/*  사장단수당*/

				"P31000",	/*  특수지수당*/
				"P32000",	/*  지역근무수당*/

		    "P34000",	/*  연차수당*/	
				"P35000",	/*  상여금*/	
				"P38000",	/*  임원직책수당*/	
				"TOTSUM"	/*  지급합계*/	
				};

				int[] intArrCN = new int[]{  
					7, 	  /* 사번 */          
					6,	  /* 년월 */          
					4,	  /*  지급구분*/      
					30,	  /* 지급구분명*/       
					8,	  /*  지급일*/
					8,	  /* 퇴사일 */        
					2,	  /*  근무년수*/      
					2,	  /*  근무월수 */     
					2,	  /*  근무일수 */     
					9,	  /*  기본급여*/      
					9,	  /*  직책수당 */     
					9,	  /*  시간외수당*/    
					9,	  /*  근속수당*/      
					9,	  /*  자기계발비*/    
					9,	  /*  부양가족수당*/  
					9,	  /*  출납수당*/      
					9,	  /*  연장수당*/      
					9,	  /*  자격수당*/      
					9,	  /*  남북경협수당*/  
					9,	  /*  사장단수당*/    
					9,	  /*  특수지수당*/    
					9,	  /*  지역근무수당*/  
					9,	  /*  연차수당*/	    
					9,	  /*  상여금*/	    
					9, 	  /*  임원직책수당*/	
					9 	  /*  지급합계*/	
         }; 

				int[] intArrCN2 = new int[]{
					-1,   /* 사번 */            
					-1,	  /* 년월 */            
					-1,   /*  지급구분*/        
					-1,	  /* 지급구분명*/         
					-1,   /*  지급일*/  
					-1,	  /* 퇴사일 */          
					0,   /*  근무년수*/        
					0,	  /*  근무월수 */       
					0,	  /*  근무일수 */       
					0,   /*  기본급여*/        
					0,	  /*  직책수당 */       
					0,	  /*  시간외수당*/      
					0,	  /*  근속수당*/        
					0,	  /*  자기계발비*/      
					0,	  /*  부양가족수당*/    
					0,    /*  출납수당*/        
					0,	  /*  연장수당*/        
					0,	  /*  자격수당*/        
					0,	  /*  남북경협수당*/    
					0,	  /*  사장단수당*/      
					0,	  /*  특수지수당*/      
					0,	  /*  지역근무수당*/    
					0,	  /*  연차수당*/	    
					0,	  /*  상여금*/	        
					0,	  /*  임원직책수당*/	
					0	  /*  지급합계*/	
          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT                                                                         ");
					sql.append(" G.EMPNO,   G.APPYM,   G.PAYDIV ,   G.PAYDIV, D.MINORNM AS PAYDIVNM, G.PAYDT,   ");
					sql.append(" G.ENDDT,   G.DUYEAR,   G.DUYMM ,   G.DUDAY,                                    ");
					sql.append(" G.P10000, G.P11000, G.P12000, G.P21000, G.P22000,                              ");
					sql.append(" G.P23000, G.P25000, G.P27000, G.P28000, G.P29000,                              ");
					sql.append(" G.P30000, G.P31000, G.P32000, G.P34000, G.P35000,G.P38000,											");
					sql.append(" ( G.P10000+ G.P11000+ G.P12000+ G.P21000+ G.P22000+  G.P23000+									");
					sql.append(" G.P25000+ G.P27000+ G.P28000+ G.P29000+ G.P30000+ G.P31000+										");
					sql.append(" G.P32000+ G.P34000+ G.P35000+G.P38000) AS TOTSUM																");
					sql.append(" FROM PAYROLL.PRAVGPAY G                                                        ");
					sql.append(" LEFT JOIN PAYROLL.HCLCODE D ON G.PAYDIV =D.MINORCD AND D.MAJORCD = '1120'			");
					sql.append(" LEFT OUTER JOIN PAYROLL.HIPERSON A ON  G.EMPNO = A.EMPNO												");
					sql.append(" WHERE RTRIM(G.EMPNO) <> ' '																										");

					if ( !str[0].equals("")&&!str[0].equals("0") )
						sql.append( " AND G.EMPNO =  '"  + str[0] + "'  ");    //사번
					if (!str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND G.APPYM =  '" + str[1]+ "' ");     //년월

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