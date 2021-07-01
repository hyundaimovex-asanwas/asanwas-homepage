package sales.menu.rm;


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

public class Rm530I extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
    	arr_sql[0].append ("SELECT						\n") 
					.append ("		CUST_RATE_TYPE,	\n") 
					.append ("		BGN_RATE, 				\n")
					.append ("		END_RATE, 				\n")
					.append ("		REFUND_RATE			\n")
					.append ("FROM SALES.TRM072		\n")
					.append ("WHERE 1=1						\n");    	
		
		arr_sql[1].append ("INSERT INTO SALES.TRM072														\n")
				  .append ("       (CUST_RATE_TYPE, BGN_RATE, END_RATE, REFUND_RATE)		  \n")
				  .append ("VALUES (?, ?, ?, ?)                                 \n");
		
		arr_sql[2].append ("UPDATE  SALES.TRM072								\n")
				  .append ("   		SET  END_RATE          = ?,                     \n")
				  .append ("        			REFUND_RATE    = ?                     \n")
				  .append ("WHERE   CUST_RATE_TYPE = ?                      \n")
				  .append ("		AND   BGN_RATE         = ?                      \n");		

		arr_sql[3].append ("DELETE FROM SALES.TRM072 WHERE CUST_RATE_TYPE = ? AND BGN_RATE = ?	\n");
		
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		System.out.println("# Command : 조회");

		/* DataBase */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		try {
			// 검색시 조건
			String 	sCustRateType	= HDUtil.nullCheckStr(req.getParameter("sCustRateType"));

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
							System.out.println("코드="+sCustRateType);
							if (!"".equals(sCustRateType)) 
								arr_sql[0].append (" AND CUST_RATE_TYPE LIKE ? \n");
							arr_sql[0].append (" ORDER BY CUST_RATE_TYPE							\n ");							
							
							System.out.println(arr_sql[0].toString());
							stmt = conn.getGauceStatement(arr_sql[0].toString());
		
							if (!"".equals(sCustRateType))
								stmt.setString(sCnt1++, "%"+sCustRateType+"%");
		
							rs = stmt.executeQuery(); // DataSet set
							rsmd = rs.getMetaData();
							columnName = new String[rsmd.getColumnCount()];
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC")) {
									if ( columnName[i].equals("CUST_RATE_TYPE") || columnName[i].equals("BGN_RATE") ) 
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1),0,GauceDataColumn.TB_KEY));
									else
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));										
								} else {
									if ( columnName[i].equals("CUST_RATE_TYPE") || columnName[i].equals("BGN_RATE") )									
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1),0,GauceDataColumn.TB_KEY));
									else
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));										
								}
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
							if(stmt!=null) stmt.close();
		
							System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
							break;
					}
				}
			}
			ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
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

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceStatement stmt = null;

		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						System.out.println(arr_sql[1].toString());
						stmt = conn.getGauceStatement(arr_sql[1].toString());
						stmt.setString(j++, rows[i].getString(0).trim());
						stmt.setInt(j++, rows[i].getInt(1));
						stmt.setInt(j++, rows[i].getInt(2));
						stmt.setInt(j++, rows[i].getInt(3));
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						System.out.println(arr_sql[2].toString());						
						stmt = conn.getGauceStatement(arr_sql[2].toString());
						stmt.setInt(j++, rows[i].getInt(2));
						stmt.setInt(j++, rows[i].getInt(3));
						stmt.setString(j++, rows[i].getString(0).trim());
						stmt.setInt(j++, rows[i].getInt(1));						
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:
						System.out.println(arr_sql[3].toString());						
						stmt = conn.getGauceStatement(arr_sql[3].toString());
						stmt.setString(j++, rows[i].getString(0).trim());
						stmt.setInt(j++, rows[i].getInt(1));	
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;						
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(stmt!=null) stmt.close();
		}
	}

}
