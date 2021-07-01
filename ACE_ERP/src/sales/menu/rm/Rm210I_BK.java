package sales.menu.rm;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

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


public class Rm210I_BK extends HttpServlet {
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
		// 업무 구분 파라미터
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum"));
		//StringUtil.printMsg("############################################## ","command",this);
		
		// 항상 콜 
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {
			init(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// 저장, 삭제, 수정 
			apply1(req, res);
		} 
	}
	
	/*****************************************************************************
	 * Gauce Object 설정
	 * Select 에 들어갈 Project Name , Project Id를 조회한다
	 * 페이지 로딩시에 초기화 작업이다 
	 *****************************************************************************/
	public void init(HttpServletRequest req, HttpServletResponse res)  throws ServletException {

		//StringUtil.printMsg("# Command ","선조회",this);
		
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
		GauceDataSet ds2 = null;
		GauceDataSet ds3 = null;
		GauceDataSet ds4 = null;		
		
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
			ds2 = new GauceDataSet(); 
			ds3 = new GauceDataSet();
			ds4 = new GauceDataSet();			
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			String sSaupSid = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));		// 사업소코드
			String sHead = HDUtil.nullCheckStr(req.getParameter("sHead"));		// Head			
			String sDetail = HDUtil.nullCheckStr(req.getParameter("sDetail"));		// Detail	
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds2);
					
					// 프로젝트명을 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	saup_sid, " 
							+ "\n\t" + "	saup_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY200 " 
							+ "\n\t" + "ORDER BY saup_sid ";
					
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("saup_sid", GauceDataColumn.TB_STRING, 10));
					ds2.addDataColumn(new GauceDataColumn("saup_nm", GauceDataColumn.TB_STRING, 20));
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
				
					stmt.executeQuery(ds2); // DataSet set
					
					//StringUtil.printMsg("# Query ",query,this);
					//StringUtil.printMsg("# ResultSet Total Count ",ds2.getDataRowCnt(),this);					
				
					stmt.close();
					break;
					
				case 2 :
					int sCnt2 = 1;					
					gceRes.enableFirstRow(ds3);
					
					// 프로젝트명을 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	upjang_sid, " 
							+ "\n\t" + "	upjang_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TRM010 " 
							+ "\n\t" + "WHERE upjang_type='10' "; 
				
					if (!"".equals(sSaupSid)) {
						whereQuery += ""
								   + "\n\t" + " AND saup_sid =? ";
						}
					query += whereQuery;
					query += "\n\t" + " ORDER BY  upjang_sid ";	
					
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds3.addDataColumn(new GauceDataColumn("upjang_sid", GauceDataColumn.TB_STRING, 10));
					ds3.addDataColumn(new GauceDataColumn("upjang_nm", GauceDataColumn.TB_STRING, 30));
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
				
					if (!"".equals(sSaupSid)) {
						stmt.setString(sCnt2++, sSaupSid);
					}
					
					stmt.executeQuery(ds3); // DataSet set

					//StringUtil.printMsg("# Query ",query,this);
					//StringUtil.printMsg("# ResultSet Total Count ",ds3.getDataRowCnt(),this);
				
					stmt.close();
					break;		
					
				case 3:
					int sCnt3 = 1;
					gceRes.enableFirstRow(ds4);
					
					// 모든 사업장 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	head, " 
							+ "\n\t" + "	detail, " 
							+ "\n\t" + "	detail_nm, " 
							+ "\n\t" + "	item1, " 
							+ "\n\t" + "	item2, "
							
							+ "\n\t" + "	item3, "
							+ "\n\t" + "	item4, "
							+ "\n\t" + "	item5, "
							+ "\n\t" + "	item6, "
							+ "\n\t" + "	item7, "
							
							+ "\n\t" + "	item8, "
							+ "\n\t" + "	item9, "
							+ "\n\t" + "	item10, "
							+ "\n\t" + "	item11, "
							+ "\n\t" + "	item12, "
							
							+ "\n\t" + "	item13, "
							+ "\n\t" + "	item14, "
							+ "\n\t" + "	item15, "
							+ "\n\t" + "	u_empno, " 
							+ "\n\t" + "	char(u_date) u_date, " 
							
							+ "\n\t" + "	u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY010 " 
							+ "\n\t" + "WHERE 1=1 ";

					whereQuery += "\n\t" + " AND head=? ";
					if (!"".equals(sDetail)) {
					whereQuery 	+= ""
								+ "\n\t" + " AND detail= ? ";
					}
					whereQuery	+= " ORDER BY detail ";
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds4.addDataColumn(new GauceDataColumn("head", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("detail", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("detail_nm", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item1", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item2", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item3", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item4", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item5", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item6", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item7", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item8", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item9", 			GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item10", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item11", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item12", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item13", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item14", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("item15", 		GauceDataColumn.TB_STRING, 16));
					ds4.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 8));
					ds4.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds4.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 15));
					
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					stmt.setString(sCnt3++, sHead);
					if (!"".equals(sDetail)) {
						stmt.setString(sCnt3++, sDetail);
					}
					
					stmt.executeQuery(ds4); // DataSet set
					
					////StringUtil.printMsg("# Query ",query,this);
					//StringUtil.printMsg("# ResultSet Total Count ",ds4.getDataRowCnt(),this);					
				
					stmt.close();
					
					break;					
			
			}
			 ds2.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.			
			 ds3.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
			 ds4.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.			 
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
	
	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		
		//StringUtil.printMsg("# Command ","조회",this);
		
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
			ds1 = new GauceDataSet(); // Dataset TSY410
		
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// 검색시 조건
			String sSaupSid 	 = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));					// 사업소
			String sUpjangSid	 = HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));			// 영업장
			String sBgnUseDate	 = HDUtil.nullCheckStr(req.getParameter("sBgnUseDate"));		// 관리일자
			String sEndUseDate	 = HDUtil.nullCheckStr(req.getParameter("sEndUseDate"));		// 관리일자			
		
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					query   += ""  					
						+ "\n\t" + "SELECT "
						+ "\n\t" + "		saup_sid,  "
						+ "\n\t" + "		upjang_sid,  " 						
						+ "\n\t" + "		SALES.FN_UPJANG_NM(upjang_sid, '') AS upjang_nm, "
						+ "\n\t" + "		use_date AS use_date, "
						+ "\n\t" + "		SUBSTRING(DAYNAME(SALES.FN_DATE(use_date)), 1, 3)	AS day_nm, "
						+ "\n\t" + "		season_cd	AS season_cd , "
						+ "\n\t" + "		SALES.FN_DETAIL_NM('RM006', season_cd) AS season_nm, "
						+ "\n\t" + "		season_cd_stu	AS season_cd_stu , "
						+ "\n\t" + "		SALES.FN_DETAIL_NM('RM006', season_cd_stu) AS season_nm_stu "
						+ "\n\t" + "FROM SALES.TRM100 "
						+ "\n\t" + "		WHERE 1=1 ";
								
					if (!"".equals(sSaupSid)) {
						whereQuery += ""
							   + "\n\t" + " AND saup_sid =  " + sSaupSid;
					}
					
					if (!"".equals(sUpjangSid)) {
						whereQuery += ""
							   + "\n\t" + " AND upjang_sid =  " + sUpjangSid;
					}
					
					if (!"".equals(sBgnUseDate) && !"".equals(sEndUseDate) ) {
						whereQuery += ""
							   + "\n\t" + " AND use_date >=  " + sBgnUseDate
							   + "\n\t" + " AND use_date <=  " + sEndUseDate;						
						}					
					
					query += whereQuery
									+ "\n\t" + "ORDER BY upjang_sid, use_date "; 

//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					ds1.addDataColumn(new GauceDataColumn("saup_sid",       GauceDataColumn.TB_STRING, 10));
					ds1.addDataColumn(new GauceDataColumn("upjang_sid",     GauceDataColumn.TB_STRING, 10));					
					ds1.addDataColumn(new GauceDataColumn("upjang_nm",      GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("use_date",       GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("day_nm",         GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("season_cd",      GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("season_nm",      GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("season_cd_stu",  GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("season_nm_stu",  GauceDataColumn.TB_STRING, 50));
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
					////StringUtil.printMsg("# Query ",query,this);
					//StringUtil.printMsg("# ResultSet Total Count ",ds1.getDataRowCnt(),this);					
				
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

	// 마스터 입력, 수정, 삭제
	public void apply1(HttpServletRequest req, HttpServletResponse res) {
		
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
			
			GauceDataSet codeDs = gceReq.getGauceDataSet("INPUT_DATA");  
		
			/*
			 * Request Parameter
			 */
			
			int colNm_SaupSid 		= codeDs.indexOfColumn("saup_sid");	
			int colNm_UpjangSid 	= codeDs.indexOfColumn("upjang_sid");	
			int colNm_UseDate 		= codeDs.indexOfColumn("use_date");	
			int colNm_SeasonCd 		= codeDs.indexOfColumn("season_cd");
			int colNm_SeasonCdStu 	= codeDs.indexOfColumn("season_cd_stu");

			GauceDataRow[] rows = codeDs.getDataRows();
			//이거를 프로시저로 고쳐야 오류 안날듯..: java.io.IOException: Transaction is committed already!
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TRM100"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		season_cd     = ? ,"
						+ "\n\t" + "		season_cd_stu = ?  "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND saup_sid=?"
						+ "\n\t" + "	AND upjang_sid=?"
						+ "\n\t" + "	AND use_date=?";			
			
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					StringUtil.printMsg("시즌",rows[i].getInt(colNm_SeasonCd), this);
					StringUtil.printMsg("사업",rows[i].getInt(colNm_SaupSid), this);
					StringUtil.printMsg("업장",rows[i].getInt(colNm_UpjangSid), this);
					StringUtil.printMsg("일자",rows[i].getInt(colNm_UseDate), this);

					
					stmt.bindColumn(uCnt++, colNm_SeasonCd);	
					stmt.bindColumn(uCnt++, colNm_SeasonCdStu);
					stmt.bindColumn(uCnt++, colNm_SaupSid);	
					stmt.bindColumn(uCnt++, colNm_UpjangSid);	
					stmt.bindColumn(uCnt++, colNm_UseDate);	
					
										
					stmt.executeUpdate();
					stmt.close();
				}
				
				gceRes.flush();
				gceRes.commit();
				gceRes.close();
			}
		} catch (Exception e) {
			gceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			loader.restoreService(service);
		}
	}

}
