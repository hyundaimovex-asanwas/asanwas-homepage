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
public class commdtil_s3f extends HttpServlet {
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
				String [] str =new String[4];
				str[0] = req.getParameter("v_str1");
				str[1] = req.getParameter("v_str2");
				str[2] = req.getParameter("v_str3");
				str[3] = req.getParameter("v_str4"); //GBCD
				
				for (int s=0;s<=3;s++ ){
					if(str[s]==null) str[s]="";
				}
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CMTYPE",	"CDCODE", "CDNAM",	"CDREMARK",	
				                                  "WRDT",   "WRID",  	"UPDT",	  "UPID",	"DSUDT", "GBCD", "PSEQ" }; 

				int[] intArrCN = new int[]{ 4, 20, 40, 60, 
					                          8,  7,  8,  7, 8, 6, 5}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT CMTYPE, CDCODE, LTRIM(RTRIM(CDNAM))CDNAM, CDREMARK,	 " );
					sql.append( "        WRDT,  WRID,	UPDT,	 UPID, RTRIM(DSUDT)DSUDT, GBCD,PSEQ " );
					sql.append( " FROM ACCOUNT.COMMDTIL " );
				    sql.append( " WHERE CMTYPE = '" + str[0] + "'" );
					if (!str[1].equals(""))sql.append( " AND ( CDCODE LIKE '%"+str[1]+"%' OR CDNAM LIKE '%"+str[1]+"%')"  );
					if (!str[2].equals(""))sql.append( " AND ( CDREMARK LIKE '%"+str[2]+"%')"  );
					
					if(str[0].equals("0003")){
						//if(!str[3].equals(""))sql.append( " AND ( GBCD ='"+str[3]+"' OR GBCD='1000'  ) ");
						//2010.01.08 JYS 추가 
						if(!str[3].equals(""))sql.append( " AND ( GBCD ='"+str[3]+"' OR GBCD='1000' OR ( '"+str[3]+"'='1200' AND CDCODE='2415')) ");
						sql.append( " AND (SUBSTR(CDCODE,3,2)!='00' OR CDCODE='1600')"  );
						//2008.01.21 추가 - 폐기일자 없는건만
						//sql.append( " AND (RTRIM(DSUDT)='' OR DSUDT IS NULL)"  );
						sql.append( " AND RTRIM(DSUDT) IS NULL"  );
					}else{
						if (!str[3].equals(""))sql.append( " AND ( GBCD ='"+str[3]+"' OR GBCD='1000')"  );
            
						//2010.03.18. JYS 추가 
						//if(str[0].equals("0997"))sql.append( " AND ( DSUDT IS NULL OR TRIM(DSUDT) ='')"  );
						if(str[0].equals("0997")||str[0].equals("0023")||str[0].equals("0022"))sql.append( " AND  RTRIM(DSUDT) IS NULL "  );  //2016.06.10 jys 0023 추가

					}
					 sql.append( " ORDER BY CDCODE" );
					//logger.dbg.println(this,"::"+sql.toString());
					//System.out.println("commdtil_s3f::"+sql.toString());
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