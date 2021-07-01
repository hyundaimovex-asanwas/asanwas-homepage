package sales.menu.rv;

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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv810S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_RV810S_01(?,?,?,?,?, ?,?,?,?)");

		arr_sql[2].append ("SELECT                       		        \n")
				  .append ("	r15.bound_seq, CHAR(r15.bound_seq) AS bound_nm     	\n")
				  .append ("FROM                                    	\n")
				  .append ("	sales.trv010 r1 join sales.trv015 r15 on (r1.accept_sid=r15.accept_sid)                  \n")
				  .append ("WHERE 1=1                           		\n")
				  .append (" AND  r1.ACCEPT_NO = ?              		\n")
				  .append (" ORDER BY r15.bound_seq               		\n")
				  ;
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
		CallableStatement cstmt;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 사업소
		String sDepart_date = HDUtil.nullCheckStr(req.getParameter("sDepart_date")); 	// 출경일자
		String sDepart_time = HDUtil.nullCheckStr(req.getParameter("sDepart_time")); 	// 출경시간 
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));			// 상품SID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// 매출처
		String v_accept_no 		= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	// 신청서번호		
		String sJobsel 		= HDUtil.nullCheckStr(req.getParameter("sJobsel"));	// 고객구분
		int v_bound_seq 		= HDUtil.nullCheckNum(req.getParameter("v_bound_seq"));			// 상품순번.
		int v_event_sid 		= HDUtil.nullCheckNum(req.getParameter("v_event_sid"));			// 단체행사.
		StringUtil.printMsg("사업소",sSaup_sid+"",this);
		StringUtil.printMsg("출경일자",sDepart_date,this);
		StringUtil.printMsg("출경시간",sDepart_time,this);
		StringUtil.printMsg("상품SID",sGoods_sid+"",this);
		StringUtil.printMsg("매출처",sClientSid+"",this);
		StringUtil.printMsg("고객구분", sJobsel,this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2, sGoods_sid);
					cstmt.setInt(3, sClientSid);
					cstmt.setString(4, sDepart_date);
					cstmt.setString(5, sDepart_time);
					cstmt.setString(6,v_accept_no);
					cstmt.setString(7,sJobsel);
					cstmt.setInt(8, v_bound_seq);
					cstmt.setInt(9, v_event_sid);
					
					rs = cstmt.executeQuery();							
					getDataSet(rs, ds1).flush();

				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_accept_no		= HDUtil.nullCheckStr(req.getParameter("v_accept_no")); 		// 신청서번호
		//StringUtil.printMsg("v_accept_no",v_accept_no,this);
		try {
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_BOUND")){
						cstmt = conn.prepareCall(arr_sql[2].toString());
					}
					cstmt.setString(1, v_accept_no);
					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}

