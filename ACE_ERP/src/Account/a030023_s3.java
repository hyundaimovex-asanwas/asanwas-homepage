package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a030023_s3 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//기간 from
				str[2] = req.getParameter("v_str3");	//기간 to
				str[3] = req.getParameter("v_str4");	//거래처 from
				str[4] = req.getParameter("v_str5");	//거래처 to 
				str[5] = req.getParameter("v_str6");	//계정과목  
				str[6] = str[1].substring(4,6);  //01
				str[7] = str[1].substring(0,4);  //2006              

				int str7   =  Integer.parseInt(str[6]);
				int str10  =  Integer.parseInt(str[7]);	
        		str7 = str7 - 1; //01
				String str8 = String.valueOf(str7);
                String str9 = "";
				if(0 < str7 && str7 <= 9) { //01
					str8 = "0" + str7;
					str9 = str[7] + str8;
				}else if(str7 == 0){
					str10 = str10 - 1;
					String str11 = String.valueOf(str10);
					str7 = 12;
					str9 = str11 + str7; //기간 from 전달
				}

				for(int i=0;i<=7;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FSREFVAL", "CDNAM", "BEVAL", "DETOT", "CRTOT", "SLPVAL", "ATDECR" }; 
				int[] intArrCN = new int[] {  20,  40,   15,   15,  15,  15,  1 }; 
				int[] intArrCN2 = new int[]{  -1,  -1,   0,   0,   0,   0,  -1 }; 

				for (int i=0; i<strArrCN.length; i++) { 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT C.FSREFVAL AS FSREFVAL, D.CDNAM AS CDNAM, C.BEVAL AS BEVAL, " );
					sql.append( "        C.DETOT AS DETOT, C.CRTOT AS CRTOT, C.SLPVAL AS SLPVAL, C.ATDECR AS ATDECR " );
					sql.append( " FROM ( " );
					sql.append( "		SELECT A.FSREFVAL   AS FSREFVAL, " );
					sql.append( "        nvl(SUM(CASE WHEN A.ACTYYMM >= '"+str[7]+"01' AND A.ACTYYMM <= '"+str9+"' THEN " );
					sql.append( "        CASE WHEN B.ATDECR = '1'  THEN A.DETOT - A.CRTOT ELSE A.CRTOT - A.DETOT END " );
					sql.append( "        ELSE 0 END),0) AS BEVAL, " );
					sql.append( "        nvl(SUM(CASE WHEN A.ACTYYMM >= '"+str[1]+"' AND A.ACTYYMM <= '"+str[2]+"' THEN " );
					sql.append( "        A.DETOT ELSE 0 END),0) AS DETOT, " );
					sql.append( "        nvl(SUM(CASE WHEN A.ACTYYMM >= '"+str[1]+"' AND A.ACTYYMM <= '"+str[2]+"' THEN " );
					sql.append( "        A.CRTOT ELSE 0 END),0) AS CRTOT, " );
					sql.append( "        nvl(SUM(CASE WHEN B.ATDECR = '1'  THEN  A.DETOT - A.CRTOT ELSE  A.CRTOT - A.DETOT END),0) AS SLPVAL, " );
					sql.append( "        B.ATDECR AS ATDECR " );
					sql.append( "   FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B " );
					sql.append( "   WHERE A.ATCODE = B.ATCODE " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"' " );
					sql.append( "   AND A.ACTYYMM BETWEEN '"+str[7]+"01'  AND '"+str[2]+"' " );
					if(!str[5].equals(""))sql.append( " AND A.ATCODE = '" +str[5]+ "' " );
					sql.append( "   AND A.FSREFCD = '0020' " );
					if(!str[3].equals(""))sql.append( " AND A.FSREFVAL >= '" +str[3]+ "' AND A.FSREFVAL <= '" +str[4]+ "' " );
					sql.append( "   AND B.ATUSEYN = 'Y' " );
					sql.append( "   GROUP BY A.FSREFVAL, B.ATDECR " );
					sql.append( " ) C LEFT JOIN ACCOUNT.COMMDTIL D " );
					sql.append( " ON C.FSREFVAL = CDCODE   AND D.CMTYPE = '0020' ORDER BY 1 " );

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