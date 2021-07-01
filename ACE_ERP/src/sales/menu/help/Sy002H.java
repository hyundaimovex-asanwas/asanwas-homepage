package sales.menu.help;

import java.sql.PreparedStatement;

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


public class Sy002H extends HttpServlet {
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
	
	public void command(HttpServletRequest req, HttpServletResponse res) {
		// 업무 구분 파라미터
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
	
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
		if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {			// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// 저장, 삭제, 수정 
			modify(req, res);
		} 
	}
	
	// 입력 , 수정 , 삭제 method
	
	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("# Command : 조회");
		
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 				// Log 

		GauceRequest gceReq = null; 	// Request
		GauceResponse gceRes = null; 	// Response

		/* DataBase */
		GauceDBConnection conn = null; 	// Database Connection
		GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		String query = "";
		String whereQuery =  "";
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset 1번 
			
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// 검색시 조건
			String sKeyWord = HDUtil.nullCheckStr(req.getParameter("sKeyWord"));
			
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);

					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	ZIP_SID, ZIP_CD, (ADDRESS1 || ' ' || ADDRESS2 || ' ' || ADDRESS3) AS ADDRESS , POST_BOX "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY110 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n" ;
					
					if (!"".equals(sKeyWord)) {
						whereQuery +=  " 		AND (address2 LIKE ? OR address3 LIKE ?)";
					}
						whereQuery += " order by address";
					query += whereQuery;
					
//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					ds1.addDataColumn(new GauceDataColumn("zip_sid", 		GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("zip_cd", 		GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("ADDRESS",	 	GauceDataColumn.TB_STRING, 90));
					ds1.addDataColumn(new GauceDataColumn("POST_BOX",	 	GauceDataColumn.TB_STRING, 20));
					
//					 쿼리 실행
					
					stmt = conn.getGauceStatement(query); 
					
					if (!"".equals(sKeyWord)) {
						
						stmt.setString(sCnt1++, "%"+ sKeyWord+"%");
						stmt.setString(sCnt1++, "%"+ sKeyWord+"%");
					}
					stmt.executeQuery(ds1); // DataSet set
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
					stmt.close();
					
					break;
			}
			

			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
			 gceRes.commit();
			 gceRes.close();
			  
			 
		} catch (Exception e) {
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
	
	public void modify(HttpServletRequest req, HttpServletResponse res) {
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 				// Log 

		GauceRequest gceReq = null; 	// Request
		GauceResponse gceRes = null; 	// Response

		/* DataBase */
		GauceDBConnection conn = null; 	// Database Connection
		GauceStatement stmt = null;
		
		String insertQuery = "";
		String updateQuery = "";
		String deleteQuery = "";
		
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			GauceDataSet inputDs = gceReq.getGauceDataSet("INPUT_DATA");  
			
			int colNm_Zip_Sid	= inputDs.indexOfColumn("zip_sid");
			int colNm_Zip_Cd 	= inputDs.indexOfColumn("zip_cd");		// 환경변수코드
			int colNm_Address1 	= inputDs.indexOfColumn("address1");		// 환경설명
			int colNm_Address2 	= inputDs.indexOfColumn("address2"); 	// 환경값
			int colNm_Address3 	= inputDs.indexOfColumn("address3");		// 환경비고사항 
			int colNm_Post_Box 	= inputDs.indexOfColumn("post_box");	
			GauceDataRow[] rows = inputDs.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY110 "
						+ "\n\t" + "	("
						+ "\n\t" + "		 zip_cd, address1, address2, address3, post_box "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?, ? ,? ,?  "
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY110"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		zip_cd	 = ?,"
						+ "\n\t" + "		address1 = ?,"
						+ "\n\t" + "		address2 = ?,"
						+ "\n\t" + "		address3 = ?,"
						+ "\n\t" + "		post_box = ?"
						+ "\n\t" + " WHERE 1=1 "
						+ "\n";		
			updateQuery +="\n\t" + "	AND zip_sid=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY110 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n";			
			deleteQuery += "\n\t" + "	AND zip_sid=?";	
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + insertQuery);
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_Zip_Cd);
					stmt.bindColumn(iCnt++, colNm_Address1);
					stmt.bindColumn(iCnt++, colNm_Address2);
					stmt.bindColumn(iCnt++, colNm_Address3);
					stmt.bindColumn(iCnt++, colNm_Post_Box);
				
					stmt.executeUpdate();
					stmt.close();
				}
				// 수정
				
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					System.out.println("# Command : 수정");
					System.out.println("# Query : " + updateQuery);
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_Zip_Cd);
					stmt.bindColumn(uCnt++, colNm_Address1);
					stmt.bindColumn(uCnt++, colNm_Address2);
					stmt.bindColumn(uCnt++, colNm_Address3);
					stmt.bindColumn(uCnt++, colNm_Post_Box);
					stmt.bindColumn(uCnt++, colNm_Zip_Sid);
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제");
					System.out.println("# Query : " + deleteQuery);
					
					stmt = conn.getGauceStatement(deleteQuery);
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(dCnt++, colNm_Zip_Sid);
					
					stmt.executeUpdate();
					stmt.close();					
				}
			}
			gceRes.flush();
			gceRes.commit();
			gceRes.close();

		} catch (Exception e) {
			gceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					try {
						conn.close(true);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				loader.restoreService(service);
				
			////
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("\n\n");
	}	
}