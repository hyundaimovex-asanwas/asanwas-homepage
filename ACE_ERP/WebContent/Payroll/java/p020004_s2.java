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
public class p020004_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//급여년월
				str[1]	= req.getParameter("v_str2");		//지급구분
				str[2]	= req.getParameter("v_str3");		//지급일자

/*CREATE TABLE PAYROLL.PCWRKPAY(
    APPDT                CHAR(6) NOT NULL,
    PAYDIV               CHAR(1) NOT NULL,
    PAYDT                CHAR(8) NOT NULL,
    PBDIV                CHAR(1) NOT NULL,
    PAYCD                CHAR(8) NOT NULL,
    FRDT                 CHAR(8),
    FRTM                 CHAR(6),
    TODT                 CHAR(8),
    TOTM                 CHAR(6),
    WRKSTS               CHAR(1),
    MEMO                 VARCHAR(100)
)
GO

ALTER TABLE PAYROLL.PCWRKPAY ADD PRIMARY KEY (APPDT, PAYDIV, PAYDT, PBDIV, PAYCD)
GO

CREATE UNIQUE INDEX PCWRKPAY ON PAYROLL.PCWRKPAY(APPDT, PAYDIV, PAYDT, PBDIV, PAYCD)
GO*/



				for (int s=0;s<3;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"APPDT",  /* 급여년도 */
				"PAYDIV", /*지급구분*/
				"PAYDT",  /*지급일자*/
				"PBDIV" , /* 항목구분 */
				"PAYCD",  /* 급여항목*/
				"FRDT",	  /*  시작일*/
				"FRTM",	  /*  시작시간*/
				"TODT",	  /* 종료일자 */
				"TOTM",	  /*종료시간*/
				"WRKSTS", /* 상태 */
				"MEMO"	  /*  비고*/

				};

				int[] intArrCN = new int[]{
						6,
						30,
						8,
						8,
						8,
						8,
						6,
						8,
						6,
						1,
						100
            	}; 

				int[] intArrCN2 = new int[]{
					    -1,
						-1,
						-1,
						-1,
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
					sql.append(	" RTRIM(A.APPDT) AS APPDT, ");  /* 급여년도 */
					sql.append(	" C.MINORNM AS PAYDIV, "); /*지급구분*/
					sql.append(	" A.PAYDT, "); /*지급일자*/
					sql.append(	" A.PBDIV, ");  /* 항목구분 */
					sql.append(	" A.PAYCD, ");  /* 급여항목*/
					sql.append(	" A.FRDT, ");	  /*  시작일*/
					sql.append(	" A.FRTM, ");	  /*  시작시간*/
					sql.append(	" A.TODT, ");	  /* 종료일자 */
					sql.append(	" A.TOTM, ");	  /*종료시간*/
					sql.append(	" A.WRKSTS, "); /* 상태 */
					sql.append(	" RTRIM(A.MEMO) AS MEMO ");	  /*  비고*/

					sql.append( " from PAYROLL.PCWRKPAY A,  ");
					sql.append( "  PAYROLL.HCLCODE B, ");
					sql.append( "  PAYROLL.HCLCODE C  ");
					 sql.append( " WHERE A.APPDT <> ' ' ");

					sql.append( "        AND RTRIM(A.PAYCD) IN ('P100002','P000006','P000007') ");  //급여세액항목
					sql.append( "        AND A.PBDIV = B.MINORCD ");  //항목구분
					sql.append( "        AND B.MAJORCD = '1126' ");

					sql.append( "        AND A.PAYDIV = C.MINORCD ");  //지급구분
					sql.append( "        AND C.MAJORCD = '1120' ");
					
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.APPDT= '"  + str[0] + "' ");    //급여년월
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.PAYDIV = '" + str[1] + "' ");     //지급구분
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.PAYDT= '"  + str[2] + "' ");   //지급일자
					//logger.err.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
								//		logger.err.println(this,"1");

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