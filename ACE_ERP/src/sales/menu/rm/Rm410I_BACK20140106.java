package sales.menu.rm;

import sales.common.SuperServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDCookieManager;
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


public class Rm410I_BACK20140106 extends HttpServlet {
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
		//StringUtil.printMsg("##############################################","RM410I",this);
		
		// 항상 콜 
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {
			init(req, res);			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// 저장, 삭제, 수정 
			if (dsNum == 1) {
				apply(req, res);
			}
		} 
	}
	
	/*****************************************************************************
	 * Gauce Object 설정
	 * Select 에 들어갈 Project Name , Project Id를 조회한다
	 * 페이지 로딩시에 초기화 작업이다 
	 *****************************************************************************/
	public void init(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		//StringUtil.printMsg("# Command","선조회",this);
	
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
					int sCnt1 = 1;					
					gceRes.enableFirstRow(ds2);
					
					query   += "" 		
						+ "\n\t" + "SELECT 0 saup_sid, '' saup_nm FROM SYSIBM.SYSDUMMY1 	"
						+ "\n\t" + "UNION ALL	"
						+ "\n\t" + "SELECT " 									
						+ "\n\t" + "	saup_sid, " 
						+ "\n\t" + "	saup_nm " 
						+ "\n\t" + "FROM "
						+ "\n\t" + "	SALES.TSY200 "; 
				
				 /**********************************************************************************
				 * DataSet 초기화 
				 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
				 **********************************************************************************/					
				ds2.addDataColumn(new GauceDataColumn("saup_sid",		GauceDataColumn.TB_INT, 10));
				ds2.addDataColumn(new GauceDataColumn("saup_nm",		GauceDataColumn.TB_STRING, 20));

				// 쿼리 실행
				stmt = conn.getGauceStatement(query); 
				
				if (!"".equals(sDetail)) {	
					stmt.setString(sCnt1++, sDetail);
				}	
				stmt.executeQuery(ds2); // DataSet set

				//StringUtil.printMsg("# Query",query,this);
				//StringUtil.printMsg("# ResultSet Total Count ",ds2.getDataRowCnt(),this);				
		
				stmt.close();
				break;
				
			}
			 ds2.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
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
		//StringUtil.printMsg("# Command","조회",this);		
		
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
			ds1 = new GauceDataSet(); 
		
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// 검색시 조건
			String sGoodsSid = HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));				// 사업소
			String sGoodsCd	 = HDUtil.nullCheckStr(req.getParameter("sGoodsCd"));				// 영업장
			String sGoodsNm	 = HDUtil.nullCheckStr(req.getParameter("sGoodsNm"));				// 관리일자
			String sUseYn	 = HDUtil.nullCheckStr(req.getParameter("sUseYn"));					// 사용유무
			String sSaupSid	 = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));					// 사용유무
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
 					query   += ""  					
 						+ "\n\t" + "SELECT "
 						+ "\n\t" + "			goods_sid, " 
 						+ "\n\t" + "			goods_cd, "
 						+ "\n\t" + "			goods_nm, "
 						+ "\n\t" + "			eng_nm, "
 						+ "\n\t" + "			short_nm, " 						
 						+ "\n\t" + "			course, "     
 						+ "\n\t" + "			nights, "
 						+ "\n\t" + "			days, "
 						+ "\n\t" + "			saup_sid, " 						
 						+ "\n\t" + "			theme_cd, "
 						+ "\n\t" + "			display_seq, "
 						+ "\n\t" + "			(CASE WHEN use_yn = 'Y' THEN 'T' ELSE 'F' END) AS use_yn "
 						+ "\n\t" + "FROM SALES.TRM200 A "
 						+ "\n\t" + "WHERE 1=1";
								
					if (!"".equals(sGoodsSid)) {
						whereQuery += ""
							   + "\n\t" + " AND goods_sid = '" + sGoodsSid + "'";
					}
					if (!"".equals(sSaupSid)) {
										whereQuery += ""
											   + "\n\t" + " AND saup_sid = '" + sSaupSid + "'";
									}
					
					if (!"".equals(sUseYn)) {
						whereQuery += ""
							   + "\n\t" + " AND use_yn = '" + sUseYn + "'";
					}
 					
					query += whereQuery
									+ "\n\t" + "ORDER BY goods_cd "; 

//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					ds1.addDataColumn(new GauceDataColumn("goods_sid",      GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("goods_cd",       GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("goods_nm",       GauceDataColumn.TB_STRING, 40));
					ds1.addDataColumn(new GauceDataColumn("eng_nm",         GauceDataColumn.TB_STRING, 40));
					ds1.addDataColumn(new GauceDataColumn("short_nm",       GauceDataColumn.TB_STRING, 12));
					ds1.addDataColumn(new GauceDataColumn("course",         GauceDataColumn.TB_STRING, 300));
					ds1.addDataColumn(new GauceDataColumn("nights",         GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("days",   		GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("saup_sid",       GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("theme_cd",       GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("display_seq",    GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("use_yn",         GauceDataColumn.TB_STRING, 1));

					//StringUtil.printMsg("query",query,this);
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
					//StringUtil.printMsg("# Query",query,this);					
					//StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
				
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
	public void apply(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 				// Log 

		GauceRequest gceReq = null; 	// Request
		GauceResponse gceRes = null; 	// Response

		/* DataBase */
		GauceDBConnection conn = null; 	// Database Connection
		GauceStatement stmt = null;
		

		HDCookieManager  hdCookie = new HDCookieManager(req, res);
		String vusrid = hdCookie.getCookieValue("vusrid",req); // empno
		
		String fParamEmpno = "";
		String fParamIp = "";
		if (vusrid != null || !vusrid.equals("") ||  vusrid.length() > 0) {
			fParamEmpno = vusrid;
		} else {
			fParamEmpno = "tester";
		}

		 fParamIp = req.getRemoteAddr();
		
		 String iParamEmpno = fParamEmpno;
		 String iParamIp = fParamIp;
		
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
			int colNm_GoodsSid 	= codeDs.indexOfColumn("goods_sid");	
			int colNm_GoodsCd 	= codeDs.indexOfColumn("goods_cd");	
			int colNm_GoodsNm 	= codeDs.indexOfColumn("goods_nm");
			int colNm_EngNm 	= codeDs.indexOfColumn("eng_nm");
			int colNm_ShortNm 	= codeDs.indexOfColumn("short_nm");			
			int colNm_Course 	= codeDs.indexOfColumn("course");
			int colNm_Nights 	= codeDs.indexOfColumn("nights");
			int colNm_Days 		= codeDs.indexOfColumn("days");
			int colNm_SaupSid 	= codeDs.indexOfColumn("saup_sid");			
			int colNm_ThemeCd 	= codeDs.indexOfColumn("theme_cd");
			int colNm_DisplaySeq = codeDs.indexOfColumn("display_seq");
			int colNm_UseYn 	 = codeDs.indexOfColumn("use_yn");
			int colNm_UEmpno 	 = codeDs.indexOfColumn("u_empno");
			int colNm_UIp 		 = codeDs.indexOfColumn("u_ip");			
			
			GauceDataRow[] rows = codeDs.getDataRows();
			
			insertQuery += "\n" 		
				+ "\n\t" + "INSERT INTO SALES.TRM200 "
				+ "\n\t" + "	("
				+ "\n\t" + "		goods_cd, " 
				+ "\n\t" + "		goods_nm, "
				+ "\n\t" + "		eng_nm,  "
				+ "\n\t" + "		short_nm,  "				
				+ "\n\t" + "		course,  "
				+ "\n\t" + "		nights,  "
				+ "\n\t" + "		days,  "
				+ "\n\t" + "		saup_sid,  "
				+ "\n\t" + "		theme_cd,  "
				+ "\n\t" + "		display_seq,  "
				+ "\n\t" + "		use_yn, "
				+ "\n\t" + "		u_empno, "
				+ "\n\t" + "		u_ip "				
				+ "\n\t" + "	)"
				+ "\n\t" + "VALUES ("
				+ "\n\t" + "    		?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? "
				+ "\n\t" + "       )"
				+ "\n";

			updateQuery += "\n" 		
				+ "\n\t" + "UPDATE SALES.TRM200"
				+ "\n\t" + "	SET"
				+ "\n\t" + "		goods_cd = ?, "
				+ "\n\t" + "		goods_nm = ?, "
				+ "\n\t" + "		eng_nm = ?, "
				+ "\n\t" + "		short_nm = ?, "				
				+ "\n\t" + "		course = ?, "
				+ "\n\t" + "		nights = ?, "
				+ "\n\t" + "		days = ?, "
				+ "\n\t" + "		saup_sid = ?, "	
				+ "\n\t" + "		theme_cd = ?, "				
				+ "\n\t" + "		display_seq = ?, "
				+ "\n\t" + "		use_yn = ?, "
				+ "\n\t" + "		u_empno = ?, "
				+ "\n\t" + "		u_date = current timestamp, "
				+ "\n\t" + "		u_ip = ? "				
				+ "\n\t" + "WHERE 1=1 "
				+ "\n\t" + "	AND goods_sid=?";
			
			deleteQuery += "\n" 		
				+ "\n\t" + "DELETE FROM SALES.TRM200 "
				+ "\n\t" + "WHERE goods_sid    =  ? "
				+ "\n";			
			
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// 입력
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					//StringUtil.printMsg("# Command","삭제",this);
					//StringUtil.printMsg("# Query",deleteQuery,this);					
					stmt = conn.getGauceStatement(insertQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_GoodsCd);
					stmt.bindColumn(iCnt++, colNm_GoodsNm);
					stmt.bindColumn(iCnt++, colNm_EngNm);
					stmt.bindColumn(iCnt++, colNm_ShortNm);					
					stmt.bindColumn(iCnt++, colNm_Course);
					stmt.bindColumn(iCnt++, colNm_Nights);
					stmt.bindColumn(iCnt++, colNm_Days);
					stmt.bindColumn(iCnt++, colNm_SaupSid);
					stmt.bindColumn(iCnt++, colNm_ThemeCd);
					stmt.bindColumn(iCnt++, colNm_DisplaySeq);
					if ( rows[i].getString(colNm_UseYn).equals("T") ) 
						stmt.setString(iCnt++, "Y");
					else
						stmt.setString(iCnt++, "N");				
					stmt.setString(iCnt++, iParamEmpno);
					stmt.setString(iCnt++, iParamIp);					

					stmt.executeUpdate();
					stmt.close();
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					//StringUtil.printMsg("# Command","수정",this);
					//StringUtil.printMsg("# Query",updateQuery,this);					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_GoodsCd);	
					stmt.bindColumn(uCnt++, colNm_GoodsNm);	
					stmt.bindColumn(uCnt++, colNm_EngNm);
					stmt.bindColumn(uCnt++, colNm_ShortNm);					
					stmt.bindColumn(uCnt++, colNm_Course);	
					stmt.bindColumn(uCnt++, colNm_Nights);
					stmt.bindColumn(uCnt++, colNm_Days);
					stmt.bindColumn(uCnt++, colNm_SaupSid);	
					stmt.bindColumn(uCnt++, colNm_ThemeCd);
					stmt.bindColumn(uCnt++, colNm_DisplaySeq);
					//StringUtil.printMsg("사용 값??????",rows[i].getString(colNm_UseYn),this);	
					if ( rows[i].getString(colNm_UseYn).equals("T") ) 
						stmt.setString(uCnt++, "Y");
					else
						stmt.setString(uCnt++, "N");
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);							
					stmt.bindColumn(uCnt++, colNm_GoodsSid);					
					
					stmt.executeUpdate();
					stmt.close();
				}
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					//StringUtil.printMsg("# Command","삭제",this);
					//StringUtil.printMsg("# Query",deleteQuery,this);
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
					stmt.bindColumn(dCnt++, colNm_GoodsSid);	
					
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
