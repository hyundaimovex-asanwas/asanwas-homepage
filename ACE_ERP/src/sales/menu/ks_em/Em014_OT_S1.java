package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em014_OT_S1 extends HttpServlet {

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
				String [] str = new String[1];
        str[0] =  req.getParameter("v_str1"); // 년월 

				for(int i=0;i<=0;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

      
				String[] strArrCN = new String[]{  "EMPNO", "ATT_YM", 
					                                 "D_01",	"D_02",	"D_03",	"D_04",	"D_05",	"D_06",	"D_07",	"D_08",	"D_09",	"D_10",
                                           "D_11",	"D_12",	"D_13",	"D_14",	"D_15",	"D_16",	"D_17",	"D_18",	"D_19",	"D_20",
					                                 "D_21",	"D_22",	"D_23",	"D_24",	"D_25",	"D_26",	"D_27",	"D_28",	"D_29",	"D_30",	"D_31"
																		  	 }; //

				int[] intArrCN = new int[] { 10, 6,
					                            4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
					                            4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
					                            4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,
					                            1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					                            1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
					                            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "	SELECT EMPNO,   ATT_YM,                                    \n");
					sql.append( "	       D_01,    D_02,    D_03,    D_04,    D_05,           \n");
					sql.append( "	       D_06,    D_07,    D_08,    D_09,    D_10,           \n");
					sql.append( "	       D_11,    D_12,    D_13,    D_14,    D_15,           \n");
					sql.append( "	       D_16,    D_17,    D_18,    D_19,    D_20,           \n");
					sql.append( "	       D_21,    D_22,    D_23,    D_24,    D_25,           \n");
					sql.append( "	       D_26,    D_27,    D_28,    D_29,    D_30,    D_31   \n");
					sql.append( "	  FROM SALES.TCM_OT_TEMP                                   \n");
					sql.append( "	 WHERE ATT_YM ='"+str[0]+"'                                \n");
					//sql.append( "	   AND EMPNO  IN ('9010001','9010002')                      \n");

					//logger.dbg.println(this,";;"+sql.toString());
									
					stmt = conn.getGauceStatement(sql.toString());

					stmt.executeQuery(dSet);
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