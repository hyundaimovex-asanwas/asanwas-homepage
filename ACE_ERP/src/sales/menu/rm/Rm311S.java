package sales.menu.rm;


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

public class Rm311S extends SuperServlet {

	
    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
	
		//사업소
		arr_sql[3].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
		
		//영업장
		arr_sql[4].append ("SELECT										\n")
					.append ("	0 UPJANG_SID, '전체' UPJANG_NM, 0 DISPLAY_SEQ    \n")
					.append ("FROM SYSIBM.SYSDUMMY1                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT UPJANG_SID,				\n")		
					.append ("			UPJANG_NM,				\n")
					.append ("			DISPLAY_SEQ				\n")					
					.append ("FROM SALES.TRM010				\n")
					.append ("WHERE SAUP_SID    =  ?				\n")
					.append ("	AND UPJANG_TYPE = '10'				\n")
					.append ("	AND USE_YN      = 'Y'				\n")
					.append ("ORDER BY DISPLAY_SEQ					\n");
		
		//객실타입
		arr_sql[5].append ("SELECT										\n")
					.append ("	'' ROOM_TYPE_SID, '전체' ROOM_TYPE_CD, 0 DISPLAY_SEQ    \n")
		  			.append ("FROM SYSIBM.SYSDUMMY1                       \n")
		  			.append ("UNION ALL                                   \n")		
		  			.append ("SELECT 															\n")                                    
					.append ("		ROOM_TYPE_SID,                       															\n")                
					.append ("		ROOM_TYPE_CD,                                      											\n")
					.append ("		DISPLAY_SEQ                                      											\n")					
					.append ("FROM SALES.TRM030															\n")
					.append ("WHERE USE_YN='Y'															\n");
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		String 	sUpjangSid	= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));		
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS3")){
								//StringUtil.printMsg("arr_sql[3]",arr_sql[3].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[3].toString());
							} 
							if(gauceName.equals("DS4")){
								//StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[4].toString());
								stmt.setString(1, sSaupSid);								
							} 							
							if(gauceName.equals("DS5")){
								if ( !sUpjangSid.equals("") && !sUpjangSid.equals("0") )
									arr_sql[5].append("AND UPJANG_SID = ?										\n");
								arr_sql[5].append ("ORDER BY DISPLAY_SEQ													\n");
								
								//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[5].toString());
								if ( !sUpjangSid.equals("") && !sUpjangSid.equals("0") )
									stmt.setInt(1, Integer.parseInt(sUpjangSid) );								
							} 														
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
									while ( rs.next()) {
										GauceDataRow row = ds1.newDataRow();
										
										for(int i=0; i<columnName.length; i++) {
											if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
												row.addColumnValue(rs.getInt(columnName[i]));
											else
												row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
										}
		
										ds1.addDataRow(row);
						                v_rowcnt++ ;
									}//End of while
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
		//StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));
			String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
			String 	sUpjangSid	= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));
			String 	sRoomTypeSid	= HDUtil.nullCheckStr(req.getParameter("sRoomTypeSid"));			
			
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
								//StringUtil.printMsg("call SALES.PR_RM311S_01","",this);
								cstmt = conn.prepareCall("{call SALES.PR_RM311S_01(?, ?, ?, ?, ?) }");
								cstmt.setInt(1, Integer.parseInt(sSaupSid));
								cstmt.setInt(2, Integer.parseInt(sUpjangSid));
								cstmt.setInt(3, Integer.parseInt(sRoomTypeSid));
								cstmt.setString(4, sBgnDate);
								cstmt.setString(5, sEndDate);
							}
							if ( gauceName.equals("DS2")) {
								//StringUtil.printMsg("call SALES.PR_RM311S_02","",this);
								cstmt = conn.prepareCall("{call SALES.PR_RM311S_02(?, ?, ?, ?, ?) }");
								cstmt.setInt(1, Integer.parseInt(sSaupSid));
								cstmt.setInt(2, Integer.parseInt(sUpjangSid));
								cstmt.setInt(3, Integer.parseInt(sRoomTypeSid));
								cstmt.setString(4, sBgnDate);
								cstmt.setString(5, sEndDate);								
							}							
						
							rs = cstmt.executeQuery(); // DataSet set
							rsmd = rs.getMetaData();
							columnName = new String[rsmd.getColumnCount()];
							ds1.addDataColumn(new GauceDataColumn("select_div", GauceDataColumn.TB_STRING,1));							
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));										
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));										
							}
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();
								row.addColumnValue("N");								
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
		
							//StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
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
