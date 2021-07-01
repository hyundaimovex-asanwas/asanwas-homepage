package sales.menu.cq;

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

public class Cq570S extends SuperServlet {
	
	public void makeSql() {
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		StringUtil.printMsg("# Command","조회",this);

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));
			
			StringUtil.printMsg("sSaupSid",sSaupSid,this);
			StringUtil.printMsg("sBgnDate",sBgnDate,this);
			StringUtil.printMsg("sDepartTime",sDepartTime,this);
			StringUtil.printMsg("sGoodsSid",sGoodsSid,this);			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);

							if ( gauceName.equals("DS1")) {
								StringUtil.printMsg("call","SALES.PR_CQ580S_01",this);
//								cstmt = conn.prepareCall("{call SALES.PR_CQ520S_01(1, 0, '20060717', '') }");
								cstmt = conn.prepareCall("{call SALES.PR_CQ570S_01(?, ?, ?, ?) }");
								cstmt.setInt(1, Integer.parseInt(sSaupSid));
								cstmt.setInt(2, Integer.parseInt(sGoodsSid));								
								cstmt.setString(3, sBgnDate);
								cstmt.setString(4, sDepartTime); 
							}
							
							rs = cstmt.executeQuery(); // DataSet set
							rsmd = rs.getMetaData();
							
							columnName = new String[rsmd.getColumnCount()];
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));										
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));										
							}
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();
								for(int i=0; i<columnName.length; i++) {
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										row.addColumnValue(rs.getInt(columnName[i]));
									else
										row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								}
								ds1.addDataRow(row);
							}//End of while
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
		
							StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
							break;
					}
				}
				ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.				
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

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
