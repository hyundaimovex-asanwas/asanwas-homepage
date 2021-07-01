package sales.menu.cu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;


public class Cu071S extends SuperServlet {

	
	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		// 조회
		arr_sql[0].append ("{call SALES.PR_CU071S_01(?, ?, ?, ? )}");
		//	IN  pEDUC_PLAN_DT		 VARCHAR(8)     -- 01.교육일자
		// ,IN  pSAUP_SID  			 NUMERIC(2)     -- 02.사업소 SID
		// ,IN  pVISIT_OBJECT_CD	 VARCHAR(2)	    -- 03.방북목적코드
		// ,IN 	pN_JOB_GU		 	 VARCHAR(1)	 	-- 04.박북신청작업구분 CU015 (최초/추가/재/이전)
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}
    
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		
		//StringUtil.printMsg("DS TYPE","걍 조회",this);

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement 	cstmt 	= null;
		ResultSet rs = null;
		String[] columnName = null;

		try {
			// 검색시 조건
			String  sReqDt 	= HDUtil.nullCheckStr(req.getParameter("sReqDt"));
			int 	sSaupSid	 	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
			String  sVisitObjCd  = HDUtil.nullCheckStr(req.getParameter("sVisitObjCd"));
			String  sNJobGu			= HDUtil.nullCheckStr(req.getParameter("sNJobGu"));
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							cstmt = conn.prepareCall(arr_sql[0].toString());
							//StringUtil.printMsg("query",arr_sql[0].toString(),this);
							cstmt.setString(1, sReqDt);		
							cstmt.setInt   (2, sSaupSid);
							cstmt.setString(3, sVisitObjCd);
							cstmt.setString(4, sNJobGu);		
							rs = cstmt.executeQuery();		// Query 실행
							getDataSet(rs, ds1).flush();
							
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}

}
