package sales.sample;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class CodeGe extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException {
//		 업무 구분 파라미터
		
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
			select(req, res);
	}

	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		System.out.println("# Command : 조회");
		
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		ResultSet rs = null;
		ResultSetMetaData rsm = null;
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// Table
			String tableName = (String)req.getParameter("tableName");
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// 모든 사업장 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT * FROM " + tableName + " WHERE 1=1 "; 								
					
					query += whereQuery;
				
					// 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					rs = stmt.executeQuery(); 
					rsm = rs.getMetaData();
					
					int columnCount = rsm.getColumnCount(); // 컬럼 카운트 
				
					for (int i = 1; i <= columnCount ; i++ ) {
						System.out.println("컬럼명 : ==> " + rsm.getColumnName(i)); // 컬럼명 
						System.out.println("타입 : ==> " + rsm.getColumnTypeName(i)); // 타입 이름
						System.out.println("사이즈 : ==> " + rsm.getColumnDisplaySize(i)); // 컬럼 사이즈 
						
						// HEADER 생성
						if (rsm.getColumnTypeName(i).equals("VARCHAR")) {
							ds1.addDataColumn(new GauceDataColumn(rsm.getColumnName(i), GauceDataColumn.TB_STRING, rsm.getColumnDisplaySize(i)));
							
						//	"	<C> name='분류코드' 	ID='head' 			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=5</C>" +
							
							
						} else if (rsm.getColumnTypeName(i).equals("NUMERIC")) {
							ds1.addDataColumn(new GauceDataColumn(rsm.getColumnName(i), GauceDataColumn.TB_NUMBER, rsm.getColumnDisplaySize(i)));
							
						//	"	<C> name='분류코드' 	ID='head' 			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=5</C>" +
						} else {
							ds1.addDataColumn(new GauceDataColumn(rsm.getColumnName(i), GauceDataColumn.TB_STRING, rsm.getColumnDisplaySize(i)));
							
							//"	<C> name='분류코드' 	ID='head' 			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=5</C>" +
						}
						
						// JSP 사용시 필요한 그리드 초기화
						
							
					}
					stmt.close();
					
					
					stmt.executeQuery(ds1); // DataSet set

					stmt.close();
					break;
					
				
					
			}
			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
			 gceRes.commit();
			 gceRes.close();
		
		}catch (Exception e) {
			e.printStackTrace();
			// Error Log 처리 요망 (log4j 사용여부)
		} finally {
			if (conn != null) {
				try {
					stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
					loader.restoreService(service);
				}
			}
		}
	}
	


}
