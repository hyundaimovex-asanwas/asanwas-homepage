package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv910S extends SuperServlet {

	public void makeSql() {   
		// TODO Auto-generated method stub
		//Master
		arr_sql[0].append("{call SALES.PR_RV910I_01 (?, ?, ?, ?, ?, ? ) }");

		//Detail
		arr_sql[1].append("{call SALES.PR_RV910I_02 (? ) }");
		
		
		//기간조회
		arr_sql[2].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");
		
		//Master update
		arr_sql[3].append("{call SALES.PR_RV910I_03 (?,?,?,?,?, ?,?,? ) }");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		CallableStatement cstmt = null;		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int    s_client_sid		= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	// 대리점sid
		String s_cond_gu    	= HDUtil.nullCheckStr(req.getParameter("v_cond_gu"));	// 검색조건 
		String s_depart_date1	= HDUtil.nullCheckStr(req.getParameter("v_depart_date1"));	// 기간1 
		String s_depart_date2	= HDUtil.nullCheckStr(req.getParameter("v_depart_date2")); // 기간2		
		String s_accept_no		= HDUtil.nullCheckStr(req.getParameter("v_accept_no")); // 신청서번호
		String s_cust_nm 		= HDUtil.nullCheckStr(req.getParameter("v_cust_nm")); // 예약자명
		int    s_accept_sid		= HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	// 대리점sid
		
		/*
		StringUtil.printMsg("대리점sid - ", s_client_sid, this);
		StringUtil.printMsg("검색조건 - ", s_cond_gu, this);
		StringUtil.printMsg("기간1- ", s_depart_date1, this);
		StringUtil.printMsg("기간2- ", s_depart_date2, this);
		StringUtil.printMsg("신청서번 - ", s_accept_no, this);
		StringUtil.printMsg("예약자명- ", s_cust_nm, this);
		StringUtil.printMsg("신청서sid - ", s_accept_sid, this);
		*/
		
		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				StringUtil.printMsg("가우스명 - ", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						//StringUtil.printMsg("온란예약마스터 쿼리",arr_sql[0].toString(), this);
						cstmt = conn.prepareCall(arr_sql[0].toString());

						cstmt.setInt(1, s_client_sid);		//IN 
						cstmt.setString(2, s_cond_gu);		//IN 
						cstmt.setString(3, s_depart_date1);	//IN 
						cstmt.setString(4, s_depart_date2);	//IN 
						cstmt.setString(5, s_accept_no);	//IN 
						cstmt.setString(6, s_cust_nm);		//IN 

						rs = cstmt.executeQuery();
					}

					if ("DETAIL".equals(gauceName)) {
						//StringUtil.printMsg("온란예약디테일 쿼리",arr_sql[1].toString(), this);
						cstmt = conn.prepareCall(arr_sql[1].toString());

						cstmt.setInt(1, s_accept_sid);		//IN 

						rs = cstmt.executeQuery();
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
			if(stmt!=null) stmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("MAIN");
		CallableStatement cstmt = null;
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				StringUtil.printMsg("가우스명 - ", gauceName, this);
									
				if(ds1!=null){
					GauceDataRow[] 		rows = ds1.getDataRows();
				
					if(gauceName.equals("MAIN")){
						for(int i=0; i<rows.length; i++){
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_UPDATE:
									cstmt = conn.prepareCall(arr_sql[3].toString());
									
//								여기서의 배열 순번은 PR_RV910I_01 에서 select 하는 ds_main의 컬럼순서다.
									cstmt.setString(1, rows[i].getString(0));//-- 1신청서번호
									cstmt.setString(2, rows[i].getString(7));//-- 2상태
									cstmt.setString(3, fParamEmpno);
									cstmt.setString(4, fParamIp);
									cstmt.setString(5, "3");
									cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
									cstmt.executeUpdate();
						
									String r_s_yn		= cstmt.getString(6);
									String r_msg_cd	 	= cstmt.getString(7);
									String r_msg		= cstmt.getString(8);
									
									if(!r_s_yn.equals("Y"))
										throw new Exception(r_msg);
									
									if(ds_result!=null){
										GauceDataRow row1 = ds_result.newDataRow();
										row1.addColumnValue(r_s_yn);
										row1.addColumnValue(r_msg_cd);
										row1.addColumnValue(r_msg);
										
										ds_result.addDataRow(row1);
									}
									if(cstmt!=null) cstmt.close();
									
									break;
							}//switch(rows[i].getJobType()) the end...
						}//for(int i=0; i<rows.length; i++) the end...
					}//if(gauceName.equals("MASTER")) the end...
					
					
				}//if(ds1!=null) the end...
			}
			if(ds_result!=null) ds_result.flush();
		} catch (SQLException sqle){
			throw sqle;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}


}
