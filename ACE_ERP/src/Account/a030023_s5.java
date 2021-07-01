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
public class a030023_s5 extends HttpServlet {
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
				str[3] = req.getParameter("v_str4");	//거래처
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

				String[] strArrCN = new String[]{  "FSREFVAL", "CDNAM", "VAL1", "VAL2", "VAL3", "VAL4", "VAL5",
																						"SUM1", "VAL6", "VAL7", "VAL8", "VAL9", "VAL10", "SUM2", "CHAI"
				}; 
				int[] intArrCN = new int[] {  20,  40,   15,   15,  15,  15,  15,
					                            15,  15,   15,   15,  15,  15,  15,  15
				}; 
				int[] intArrCN2 = new int[]{  -1,  -1,    0,    0,   0,   0,   0,
					                             0,   0,    0,    0,   0,   0,   0,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT C.FSREFVAL AS FSREFVAL, " );
					sql.append( "        D.CDNAM    AS CDNAM, " );
					sql.append( "        nvl(C.VAL1,0)     AS VAL1,       nvl(C.VAL2,0)     AS VAL2, " );
					sql.append( "        nvl(C.VAL3,0)     AS VAL3,       nvl(C.VAL4,0)     AS VAL4, " );
					sql.append( "        nvl(C.VAL5,0)     AS VAL5, " );
					sql.append( "        nvl(C.VAL1 + C.VAL2 + C.VAL3 + C.VAL4 + C.VAL5,0) AS SUM1, " );
					sql.append( "        nvl(C.VAL6,0)     AS VAL6,       nvl(C.VAL7,0)     AS VAL7, " );
					sql.append( "        nvl(C.VAL8,0)     AS VAL8,       nvl(C.VAL9,0)     AS VAL9, " );
					sql.append( "        nvl(C.VAL10,0)    AS VAL10, " );
					sql.append( "        nvl(C.VAL6 + C.VAL7 + C.VAL8 + C.VAL9 + C.VAL10,0) AS SUM2, " );
					sql.append( "        nvl((C.VAL1 + C.VAL2 + C.VAL3 + C.VAL4 + C.VAL5) - (C.VAL6 + C.VAL7 + C.VAL8 + C.VAL9 + C.VAL10),0) AS CHAI " );
					sql.append( " FROM ( " );
					sql.append( "     SELECT A.FSREFVAL   AS FSREFVAL, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '1110601' THEN A.DETOT ELSE 0 END) VAL1, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '1111400' THEN A.DETOT ELSE 0 END) VAL2, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '1112101' THEN A.DETOT ELSE 0 END) VAL3, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '1111200' THEN A.DETOT ELSE 0 END) VAL4, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '1110602' THEN A.DETOT ELSE 0 END) VAL5, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '2100101' THEN A.CRTOT ELSE 0 END) VAL6, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '2100301' THEN A.CRTOT ELSE 0 END) VAL7, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '2100400' THEN A.CRTOT ELSE 0 END) VAL8, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '2100405' THEN A.CRTOT ELSE 0 END) VAL9, " );
					sql.append( "     SUM(CASE WHEN A.ATCODE = '2100102' OR A.ATCODE = '2100303' THEN A.CRTOT ELSE 0 END) VAL10 " );
					sql.append( "     FROM ACCOUNT.MFSREFTOT A,ACCOUNT.ACTCODE B " );
					sql.append( "     WHERE A.ATCODE = B.ATCODE " );
					if(!str[0].equals(""))sql.append( "   AND A.FDCODE = '"+str[0]+"' " );
					sql.append( "     AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"' " );
					sql.append( "     AND A.ATCODE IN ('1110601','1111400','1112101','1111200','1110602','2100101','2100301','2100400','2100405','2100102','2100303') " );
					sql.append( "     AND A.FSREFCD = '0020' " );
					if(!str[3].equals(""))sql.append( "   AND A.FSREFVAL = '"+str[3]+"' " );
					sql.append( "     AND B.ATUSEYN = 'Y' " );
					sql.append( "     GROUP BY A.FSREFVAL " );
					sql.append( " ) C LEFT JOIN ACCOUNT.COMMDTIL D " );
					sql.append( " ON C.FSREFVAL = CDCODE   AND D.CMTYPE = '0020' " );
					sql.append( " ORDER BY 1 " );

					// logger.dbg.println(this, sql.toString());
						
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