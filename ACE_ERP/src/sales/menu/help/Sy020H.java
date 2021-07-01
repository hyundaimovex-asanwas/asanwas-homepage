package sales.menu.help;


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

public class Sy020H extends HttpServlet {
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
		/*
		 * Parameter : proType (업무 구분 파라미터)
		 */
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum"));
		//System.out.println("#################################### " + this.getClass() + " Message ####################################\n");
		
		/*
		 * DESC :  업무구분 
		 */
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// 초기화
			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// 적용 (저장, 삭제, 수정) 
			//apply(req, res);
		} 
	}

	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");
		
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
			ds1 = new GauceDataSet(); // Dataset(TSY010) 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			// 검색시 조건
			String  sEmpno		= HDUtil.nullCheckStr(req.getParameter("sEmpno"));			
//			String  sEmpnmk		= HDUtil.nullCheckStr(req.getParameter("sEmpnmk"));
			
			//System.out.println("1111"+s_Item1);
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			//첫번째,두번째 그리드
			//detail이 공백이 아닌 경우 dsType=1, 공백인 경우 dsType=2

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// 모든 사원정보 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t"+      "T1.empno,"
							+ "\n\t"+      "T1.empnmk,"
							+ "\n\t"+      "T1.deptcd,"
							+ "\n\t"+      "T2.deptnm,"
							+ "\n\t"+      "T1.regdiv "	
							+ "\n\t" + "FROM "
							+ "\n\t" + "PAYROLL.HIPERSON T1 LEFT OUTER JOIN  PAYROLL.HCDEPT   T2 "
							+ "\n\t" + "ON T1.DEPTCD = T2.DEPTCD "
							+ "\n\t" + "WHERE T1.empno LIKE '%"+sEmpno.trim()+"%' "
							+ "\n\t" + "OR T1.empnmk LIKE '%"+sEmpno.trim()+"%' "
							+ "\n\t" + "ORDER BY T1.empno ASC ";					

					query += whereQuery;
					//System.out.println("# Command4 : 조회");
					//System.out.println(query);

					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("empno",  GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("empnmk",         GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("deptcd",         GauceDataColumn.TB_STRING, 4));
					ds1.addDataColumn(new GauceDataColumn("deptnm",         GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("regdiv",         GauceDataColumn.TB_STRING, 4));					
					
					// 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
					//System.out.println("# Query : " + query);
					//System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
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
					//stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
					loader.restoreService(service);
				}
			}
		}
	}
	
}
