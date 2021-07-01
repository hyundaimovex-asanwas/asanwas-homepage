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
public class a030023_s1 extends HttpServlet {
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
				str[4] = req.getParameter("v_str5");	//계정과목from 
				str[5] = req.getParameter("v_str6");	//계정과목to  
				str[6] = str[1].substring(4,6);  //01
				str[7] = str[1].substring(0,4);  //2008              

				int str7   =  Integer.parseInt(str[6]);  //1
				int str10  =  Integer.parseInt(str[7]);	 //2008
				str7 = str7 - 1; //0
				String str8 = String.valueOf(str7); //0
				String str9 = "";
				if(0 < str7 && str7 <= 9) { //01
					str8 = "0" + str7;
					str9 = str[7] + str8;
				}else if(str7 == 0){
					str10 = str10 - 1; //2008-1 = 2007
					String str11 = String.valueOf(str10); //2007
					str7 = 12;
					str9 = str11 + str7; //기간 from 전달 //200712
				}

				for(int i=0;i<=7;i++) {
					if(str[i] == null) str[i] = ""; 
				}

		        String beforefrom = "";
		        String beforeto = "";
		        String strmm ="";
		        int intmm   =  Integer.parseInt(str[6]);
		        beforefrom = str[7]+"00";
		        if(str[6].equals("01")){
		          beforeto = str[7]+"00";
		          //logger.dbg.println(this,"a: "+beforeto);
		        }else{
				      intmm = intmm - 1;
							if(intmm>0&&intmm<=9){
		             strmm = "0"+ intmm;  
							}else{
		             strmm = intmm +"";  
		          }
		          beforeto = str[7]+strmm;
		          //logger.dbg.println(this,"b: "+beforeto);
		        }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "ATCODE", "ATKORNAM", "BEVAL", "DETOT", "CRTOT", "SLPVAL", "ATDECR" }; 
				int[] intArrCN = new int[] {  7,   66,   15,   15,  15,  15,  1 }; 
				int[] intArrCN2 = new int[]{  -1,   -1,   0,   0,   0,   0,  -1 }; 

				for (int i=0; i<strArrCN.length; i++) { 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT B.ATCODE ATCODE,                                                                              \n" );
					sql.append( "      B.ATKORNAM ATKORNAM,                                                                            \n" );
					sql.append( "      nvl(SUM(CASE WHEN A.ACTYYMM >= '"+beforefrom+"' AND A.ACTYYMM <= '"+beforeto+"' THEN       \n " );
					sql.append( "           CASE WHEN B.ATDECR = '1'  THEN A.DETOT - A.CRTOT ELSE A.CRTOT - A.DETOT END                     \n " );
					sql.append( "           ELSE 0 END),0) BEVAL,                                                                            \n " );
					sql.append( "      nvl(SUM(CASE WHEN A.ACTYYMM >= '"+str[1]+"' AND A.ACTYYMM <= '"+str[2]+"'  THEN                    \n " );
					sql.append( "           A.DETOT ELSE 0 END),0) DETOT,                                                                    \n " );
					sql.append( "      nvl(SUM(CASE WHEN A.ACTYYMM >= '"+str[1]+"' AND A.ACTYYMM <= '"+str[2]+"'  THEN                    \n  " );
					sql.append( "           A.CRTOT ELSE 0 END),0) CRTOT,                                                                     \n " );
					sql.append( "      nvl(SUM(CASE WHEN B.ATDECR = '1'  THEN  A.DETOT - A.CRTOT ELSE A.CRTOT - A.DETOT END),0) SLPVAL,     \n " );
					sql.append( "      B.ATDECR ATDECR                                                                                      \n " ); 
					sql.append( " FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B                                         \n " );
					sql.append( " WHERE A.ATCODE = B.ATCODE                                                                         \n" );
					if(!str[0].equals("")) sql.append( " AND A.FDCODE = '"+str[0]+"'                                                  \n " );
					sql.append( "  AND A.ACTYYMM BETWEEN '"+beforefrom+"'  AND '"+str[2]+"'                                  \n " );
					if(!str[4].equals(""))sql.append( "  AND A.ATCODE BETWEEN '" +str[4]+ "'  AND '" +str[5]+ "'           \n " );
					sql.append( "  AND A.FSREFCD = '0020'                                                                               	\n  " );
					if(!str[3].equals(""))sql.append( "      AND A.FSREFVAL = '" +str[3]+ "'                                          \n" );
					sql.append( "  AND B.ATUSEYN = 'Y'                                                                                   	\n " );
					sql.append( " GROUP BY B.ATCODE, B.ATKORNAM, B.ATDECR                                                  \n" );
					sql.append( " ORDER BY 1                                                                                                  	\n " );

					//System.out.println("# Query : " + sql);
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