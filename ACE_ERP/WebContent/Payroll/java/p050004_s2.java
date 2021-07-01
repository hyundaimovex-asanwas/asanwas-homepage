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
public class p050004_s2 extends HttpServlet {

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


//DROP TABLE HIFAMILY;			
//CREATE TABLE HIFAMILY (			
//EMPNO	CHAR(7)	NOT NULL,	/*사번*/
//SEQ	NUMERIC(2, 0)	NOT NULL,	/*순번*/
//RESINO	CHAR(13)	,	/*주민번호*/
//FAMNM	VARCHAR(20)	,	/*성명*/
//REFCD	VARCHAR(4)	,	/*가족관계*/
//SCHNM	VARCHAR(40)	,	/*최종학교명*/
//CMPNM	VARCHAR(60)	,	/*현직업*/
//LSTEDC	VARCHAR(4)	,	/*학력코드*/
//LIVEYN	CHAR(1)	,	/*동거여부*/
//GETYN	CHAR(1)	,	/*소득여부*/
//PAYYN	CHAR(1)	,	/*수당지급*/
//DISYN	CHAR(1)	,	/*가족장애*/
//SPTYN	CHAR(1)	,	/*피부양자*/
//MEDINYN	CHAR(1)	,	/*의료비유무*/
//EDUEXYN	CHAR(1)	,	/*학자금유무*/
/* Primary key Define */			
//       CONSTRAINT HIFAMILYPK PRIMARY KEY (EMPNO, SEQ));			






				for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"FAMNM",	   /* 가족성명 */
				"RESINO",       /*가족주민*/
				"REFCDNM",      /*가족관계*/
				"LSTEDCNM"    /*학력사항*/


				};

				int[] intArrCN = new int[]{  
					20, 	
					13,
					30,
					30

            	}; 

				int[] intArrCN2 = new int[]{
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
					sql.append( "  A.FAMNM, ");	  
					sql.append( "  A.RESINO, ");   
					sql.append( "  D.MINORNM AS  REFCDNM,");  //가족관계
					sql.append( "  E.MINORNM AS  LSTEDCNM ");  //학력사항


					sql.append( " from  PAYROLL.HIFAMILY A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE D ON  A.REFCD = D.MINORCD  AND D.MAJORCD = '1132'   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE E ON  A.LSTEDC = E.MINORCD  AND E.MAJORCD = '1137'  ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND A.EMPNO  = '"  + str[0] + "' ");    //사번
					sql.append( " ORDER BY A.SEQ ASC ");
					//logger.err.println(this,sql.toString());
/*********************************************************************************************/
                     // System.out.println(sql);
						//logger.err.println(this,"1");
					stmt = conn.getGauceStatement(sql.toString());

	 		    stmt.executeQuery(dSet);
					//logger.err.println(this,"2");

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