package sales.menu.cu;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

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

public class Cu070S extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		/*
		 * 메인조회
		 * //매출처 SID,한글성명,주민/여권번호, 교육일자, 방북목적코드, 사업소 SID, 방북증 승인번호, 방북교육신청번호   
		 */
		arr_sql[0].append("{call SALES.PR_CU070S_01( ?, ?, ?, ?, ?,   ?, ?, ? ) }");	 
		 
    }
    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataBase */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							stmt = conn.getGauceStatement(arr_sql[0].toString());
							rs = stmt.executeQuery(); // DataSet set
							rsmd = rs.getMetaData();
							columnName = new String[rsmd.getColumnCount()];
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
							}

							if(rs!=null) rs.close();
							if(stmt!=null) stmt.close();
							ds1.flush();
							break;
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
			if(stmt!=null) stmt.close();
		}
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		StringUtil.printMsg("# Command : 조회","", this);

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		// 검색시 조건
		int	   sClientSid  	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));	// 거래처 아이디
		String sCustNm    	= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// 고객명 
		String sManageNo 	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));	// 주민/여권번호
		String sEducPlanDt	= HDUtil.nullCheckStr(req.getParameter("sEducPlanDt"));	// 교육일자
		String sVisitObjCd	= HDUtil.nullCheckStr(req.getParameter("sVisitObjCd"));// 방북목적코드
		int	   sSaupSid 	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));	// 사업소 SID
		String sEducNo    	= HDUtil.nullCheckStr(req.getParameter("sEducNo"));	// 방북증 승인번호
		String sEducReqNo   = HDUtil.nullCheckStr(req.getParameter("sEducReqNo"));		// 방북교육신청번호


		try {
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				StringUtil.printMsg("가우스명 - ", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						//조회쿼리
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt   (1, sClientSid);		//IN 
						cstmt.setString(2, sCustNm);		//IN
						cstmt.setString(3, sManageNo);		//IN
						cstmt.setString(4, sEducPlanDt);		//IN
						cstmt.setString(5, sVisitObjCd);		//IN
						cstmt.setInt   (6, sSaupSid);		//IN 
						cstmt.setString(7, sEducNo);		//IN
						cstmt.setString(8, sEducReqNo);		//IN						
						
						rs = cstmt.executeQuery();
						
						//업뎃쿼리
						//cstmt = conn.prepareCall(arr_sql[1].toString());
						//cstmt.setString(1, s_manage_no);
						//cstmt.executeUpdate();						
					}
					getDataSet(rs, ds1).flush();

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
