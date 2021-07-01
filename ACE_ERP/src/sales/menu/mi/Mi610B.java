package sales.menu.mi;


import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.SuperServlet;
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

public class Mi610B extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");
		CallableStatement cstmt = null;		
		boolean fail=false;		
		
		String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));					
				
				StringUtil.printMsg("call SALES.PR_MI610B_01","call SALES.PR_MI610B_01",this);						
				cstmt = conn.prepareCall("{call SALES.PR_MI610B_01(?, ?, ?, ?, ?, ?) }");						
				
				cstmt.setString(1, sBgnDate);						
				cstmt.setString(2, iParamEmpno);
				cstmt.setString(3, iParamIp);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.executeUpdate();
				
				//메시지처리
				if (cstmt.getString(4).equals("Y") ) {
					if ( !cstmt.getString(5).equals("0000") ) {
						StringUtil.printMsg("성공메시지",cstmt.getString(6),this);
						GauceDataRow row2 = msgDS.newDataRow();									
						row2.addColumnValue(cstmt.getString(6));
						msgDS.addDataRow(row2);
					}
				} else {
					StringUtil.printMsg("실패메시지",cstmt.getString(6),this);								
					conn.rollback();
					GauceDataRow row2 = msgDS.newDataRow();								
					row2.addColumnValue(cstmt.getString(6));
					msgDS.addDataRow(row2);
					fail = true;
				}  

				if(cstmt!=null) cstmt.close();
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			msgDS.flush();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}

}
