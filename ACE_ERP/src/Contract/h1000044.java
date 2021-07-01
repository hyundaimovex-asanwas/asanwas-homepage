
package contract;


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

public class h1000044 extends SuperServlet {


   
	public void makeSql(){

			arr_sql[0] = new StringBuffer();

		arr_sql[0].append("{call SALES.PR_P020002S( ?, ?, ?, ?, ?, ? ) }");
		

	}
    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}	


	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
	
	}	
	

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet gcds_data = null; // 급여계산
		//StringUtil.printMsg("어플라이는??)", "",this);

		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

	
		String 	pPAYDIV	= HDUtil.nullCheckStr(req.getParameter("str2"));
		String	pAPPDT  = HDUtil.nullCheckStr(req.getParameter("str1"));
		String	pPAYDT	= HDUtil.nullCheckStr(req.getParameter("str3"));

		
		try {
			GauceDataSet ds_result 		= req.getGauceDataSet("DS_RESULT");	//송신 결과			

			//내부 변수
			String r_s_yn		= "";
			String r_msg_cd		= "";
			String r_msg		= "";
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				gcds_data = req.getGauceDataSet(gauceName);
				
				if(gcds_data!=null){
					if ("gcds_data".equals(gauceName)) {

						if(ds_result!=null){
							res.enableFirstRow(ds_result);
							ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						}

	
							//StringUtil.printMsg("실명확인 송~:)", "슝",this);
							cstmt = conn.prepareCall(arr_sql[0].toString());

							cstmt.setString     (1, pPAYDIV);
							cstmt.setString     (2, pAPPDT);
							cstmt.setString     (3, pPAYDT);
							cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
						
							r_s_yn 		= cstmt.getString(4);
							r_msg_cd 	= cstmt.getString(5);
							r_msg 		= cstmt.getString(6);
						
							if(!r_s_yn.equals("Y")){
								res.writeException("ERROR", r_msg_cd, r_msg);
							}
						
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
							
								ds_result.addDataRow(row1);
							}
						
							if(ds_result!=null) ds_result.flush();													  
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
			if(stmt!=null) stmt.close();
		}
	}


}
