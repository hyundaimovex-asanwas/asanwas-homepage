package sales.menu.ac;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac120I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC120I_01(?,?,?,?,?,?)");
		arr_sql[2].append("CALL SALES.PR_AC120I_02(?)");
		arr_sql[3].append("CALL SALES.PR_AC120I_03(?,?,?,?,?,?,?,?,?)");
		
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt			= null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid"));
		int sGoodsSid = HDUtil.nullCheckNum(req.getParameter("sGoodsSid"));
		String sSDate = HDUtil.nullCheckStr(req.getParameter("sSDate"));
		String sEDate = HDUtil.nullCheckStr(req.getParameter("sEDate"));
		String sAcceptNo = HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
		String sCustNm = HDUtil.nullCheckStr(req.getParameter("sCustNm"));
		
		int sRsvSid = HDUtil.nullCheckNum(req.getParameter("sRsvSid"));
		
		
		StringUtil.printMsg("RSV_SID", sRsvSid, this);
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					
					StringUtil.printMsg("GauceName",gauceName,this);
					
					
					if ("DS1".equals(gauceName)) {
							res.enableFirstRow(ds1);
						
							StringUtil.printMsg("조회--",arr_sql[1].toString(),this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setInt(1,sClientSid);
							cstmt.setInt(2, sGoodsSid);
							cstmt.setString(3, sSDate);
							cstmt.setString(4, sEDate);
							cstmt.setString(5, sAcceptNo);
							cstmt.setString(6, sCustNm);
							rs = cstmt.executeQuery();			
							getDataSet(rs, ds1).flush();			
		
						
					} else if ("DS2".equals(gauceName)) {
						
						StringUtil.printMsg("arr_sql[2]", arr_sql[2].toString(),this);
							res.enableFirstRow(ds1);
						
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setInt(1,sRsvSid);
							
							rs = cstmt.executeQuery();							
							getDataSet(rs, ds1).flush();
		
					}	
				}
			}
							
			
		}catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null)cstmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					if ("DS2".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						int colNm_RsvSid      	= ds1.indexOfColumn("RSV_SID"); 	// 예약SID
						int colNm_UseDate      	= ds1.indexOfColumn("USE_DATE");	// 사용일자
						int colNm_KeySeq		= ds1.indexOfColumn("KEY_SEQ");		// 순번
						int colNm_UseAmt		= ds1.indexOfColumn("USE_AMT");		// 판매가
						 
						for(int i=0; i<rows.length; i++){
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_UPDATE:
								
								cstmt = conn.prepareCall(arr_sql[3].toString());
								
								StringUtil.printMsg("=============================== 마스터 신규 =========================",this);
								
								cstmt.setInt(1, Integer.parseInt(rows[i].getString(colNm_RsvSid)));
								cstmt.setString(2, rows[i].getString(colNm_UseDate));
								cstmt.setInt(3, Integer.parseInt(rows[i].getString(colNm_KeySeq)));
								cstmt.setInt(4, rows[i].getInt(colNm_UseAmt));
								cstmt.setString(5, iParamEmpno);
								cstmt.setString(6, iParamIp);
								cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
								// 쿼리실행
								cstmt.executeUpdate();
								
								break;
							}
						}
					}
				}
			}
		}catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}


}
