package sales.menu.ac;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Ac071I extends SuperServlet {
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//탭1 조회
		arr_sql[1].append("CALL SALES.PR_AC071I_01(?,?,?,?)");
		//탭2 조회
		arr_sql[2].append("CALL SALES.PR_AC071I_02(?,?,?,?,?)");
		//탭3 조회 (ERP 결제내역)
		arr_sql[3].append("CALL SALES.PR_AC071I_03(?,?,?,?)");	// 
		
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);

	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		ResultSetMetaData rsmd = null;
		
		String[] 			columnName 	= null;
		
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("MAIN_DS1"); //탭1 조회;
		GauceDataSet ds2 = req.getGauceDataSet("MAIN_DS2"); //탭2 조회;		
		GauceDataSet ds3 = req.getGauceDataSet("MAIN_DS3"); //탭3 조회;		

		
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");
		
		if(ds_result!=null){
			res.enableFirstRow(ds_result);
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		/*
		 * 검색시 필요한 조건
		 */
		try {
			String sBgnDate = HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String sEndDate = HDUtil.nullCheckStr(req.getParameter("sEndDate"));
			String sSiteCode  = HDUtil.nullCheckStr(req.getParameter("sSiteCode"));
			String sTr_Order_Nm  = HDUtil.nullCheckStr(req.getParameter("sTr_Order_Nm"));
			int    sSAUP_SID  = HDUtil.nullCheckNum(req.getParameter("sSAUP_SID"));
		
			if (ds1 != null) {
				res.enableFirstRow(ds1);
				
				cstmt = conn.prepareCall(arr_sql[1].toString());
				//StringUtil.printMsg("DS1 탑니다. ",this);
				/*StringUtil.printMsg("일반 조회 ",this);
				StringUtil.printMsg("쿼리는  ",arr_sql[1].toString(),this);
				StringUtil.printMsg("거래일자 시작== ",sBgnDate,this);
				StringUtil.printMsg("거래일자 끝   == ",sEndDate,this);
				StringUtil.printMsg("계좌코드   == ",sSiteCode,this);
				StringUtil.printMsg("적요   == ",sTr_Order_Nm,this);*/
				
				cstmt.setString(1,sBgnDate );
				cstmt.setString(2,sEndDate );
				cstmt.setString(3,sSiteCode );
				cstmt.setString(4,sTr_Order_Nm );
				rs = cstmt.executeQuery();							
				
				getDataSet(rs,ds1).flush();
				
			}

			
			
			if (ds2 != null) {
				res.enableFirstRow(ds2);
				
				cstmt = conn.prepareCall(arr_sql[2].toString());
//				StringUtil.printMsg("DS2 타냐? ",this);
//				StringUtil.printMsg("DS2 쿼리 ", arr_sql[2].toString() , this);
				
				cstmt.setString(1,sBgnDate );
				cstmt.setString(2,sEndDate );
				cstmt.setString(3,sSiteCode );
				cstmt.setString(4,sTr_Order_Nm );
				cstmt.setInt(5,sSAUP_SID);
				rs = cstmt.executeQuery();							
				
				getDataSet(rs,ds2).flush();
				
			}
		
					
			if (ds3 != null) {
				res.enableFirstRow(ds3);
				
				cstmt = conn.prepareCall(arr_sql[3].toString());
				//StringUtil.printMsg("DS3 타용 ",this);
				//StringUtil.printMsg("DS3 쿼리 ", arr_sql[3].toString() , this);				
				cstmt.setString(1,sBgnDate );
				cstmt.setString(2,sEndDate );
				cstmt.setString(3,sSiteCode );
				cstmt.setString(4,sTr_Order_Nm );
				rs = cstmt.executeQuery();							
				
				getDataSet(rs,ds3).flush();
				
			}
				
				
				
				if(ds_result!=null) ds_result.flush();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
	}
	
}
