package pms.menu.pu;


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

public class Pu032I extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//레벨1 목록
		arr_sql[0].append ("SELECT MENU_IDX, SCDNM         \n")     
				  .append ("  FROM COMMON.MENU_MASTER   \n")     
				  .append (" WHERE LEVEL  = 1           \n")     
				  .append ("   AND FLAG = 'T'           \n")
				  .append (" ORDER BY SEQ ASC           \n");    
		//레벨2 목록		
		arr_sql[1].append ("SELECT MENU_IDX, SCDNM         \n")     
				  .append ("  FROM COMMON.MENU_MASTER   \n")     
				  .append (" WHERE LEVEL  = 2           \n")     
				  .append ("   AND PARENT_IDX = ?           \n")
				  .append ("   AND FLAG = 'T'           \n")     
				  .append (" ORDER BY SEQ ASC	        \n");    
		//레벨3 목록		
		arr_sql[2].append ("SELECT MENU_IDX, SCDNM         \n")                                             
				  .append ("  FROM COMMON.MENU_MASTER   \n")     
				  .append (" WHERE LEVEL  = 3           \n")     
				  .append ("   AND PARENT_IDX = ?           \n")
				  .append ("   AND FLAG = 'T'           \n")     
				  .append (" ORDER BY SEQ ASC	        \n");                       

		//레벨4 조회
		arr_sql[3].append ("SELECT PGM_IDX, PARENT_IDX, PGMNM, SYSID, UPMENUID, RPGMID, FLAG, SEQ, OLDPGMID, PAGETYPE, STRDATE, ENDDATE  \n")
				  .append ("  FROM COMMON.MENU_DETAIL                       \n")
				  .append (" WHERE PARENT_IDX = ? 	                         \n")
				  .append (" ORDER BY SEQ ASC    	                         \n");
		
		//레벨4 수정
		arr_sql[4].append ("UPDATE COMMON.MENU_DETAIL                        \n")
				  .append ("   SET  PGMNM  = ?                               \n")
				  .append ("   		,RPGMID = ?                              \n")
				  .append ("   		,FLAG = ?                                \n")
				  .append ("        ,SEQ = ?                                 \n")				  
				  .append (" WHERE PGM_IDX = ? 	                             \n");

		//레벨4 삭제 
		arr_sql[5].append ("DELETE FROM COMMON.MENU_DETAIL                  \n")
				  .append (" WHERE PGM_IDX = ? 	                             \n");
		
		//레벨4 추가
		arr_sql[6].append ("INSERT INTO COMMON.MENU_DETAIL (PARENT_IDX, PGMNM, RPGMID, FLAG, SEQ , PAGETYPE, \n")
				  .append (" STRDATE, ENDDATE, REGMAN, MODMAN)           \n")
				  .append (" VALUES (?,?,?,?,?,  ?,?,?,?,?  )                         \n");

   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		int menu_idx = HDUtil.nullCheckNum(req.getParameter("menu_idx"));
		String sUpjangSid = HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));		
		String sHead = HDUtil.nullCheckStr(req.getParameter("sHead"));		
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS2")){//레벨1 조회
								//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[0].toString());
							}
							
							if(gauceName.equals("DS3")){//레벨2 조회
								//StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								
								if (menu_idx != 0 ) 
									stmt.setInt(1, menu_idx);								
							} 							
							
							if(gauceName.equals("DS4")){//레벨3 조회
								//StringUtil.printMsg("arr_sql[2]",arr_sql[2].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[2].toString());
								
								if (menu_idx != 0 ) 
									stmt.setInt(1, menu_idx);								
							} 							
							
							/*
							if(gauceName.equals("DS5")){
								StringUtil.printMsg("arr_sql[3]",arr_sql[3].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[3].toString());
							} 												
							if(gauceName.equals("DS_DONG")){
								if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid)) {
									arr_sql[8].append("AND UPJANG_SID = ? 			\n");
								}
								
								arr_sql[8].append ("ORDER BY DONG_SID													\n");									
								StringUtil.printMsg("arr_sql[8]",arr_sql[8].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[8].toString());
								
								if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid))
									stmt.setString(1, sUpjangSid);	
							} */																			
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
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			int menu_idx = HDUtil.nullCheckNum(req.getParameter("menu_idx"));
			//String 	upmenuid	= HDUtil.nullCheckStr(req.getParameter("upmenuid"));
			
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

							//StringUtil.printMsg("arr_sql[3]",arr_sql[3].toString(),this);							
							//StringUtil.printMsg("param_upmenuid",upmenuid,this);
							stmt = conn.getGauceStatement(arr_sql[3].toString());
							if (menu_idx != 0 ) 
								stmt.setInt(1, menu_idx);	
		
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
							}//End of while
							if(rs!=null) rs.close();
							if(stmt!=null) stmt.close();
		
							//StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
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
		GauceDataSet inputDs = req.getGauceDataSet("DS1");
		GauceStatement stmt = null;

		int menu_idx = HDUtil.nullCheckNum(req.getParameter("menu_idx"));
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
				int colNm_PARENT_IDX		= inputDs.indexOfColumn("PARENT_IDX");
				int colNm_PGMNM				= inputDs.indexOfColumn("PGMNM");
				int colNm_RPGMID			= inputDs.indexOfColumn("RPGMID");
				int colNm_FLAG				= inputDs.indexOfColumn("FLAG");
				int colNm_SEQ				= inputDs.indexOfColumn("SEQ");
				int colNm_PAGETYPE			= inputDs.indexOfColumn("PAGETYPE");
				int colNm_STRDATE			= inputDs.indexOfColumn("STRDATE");
				int colNm_ENDDATE			= inputDs.indexOfColumn("ENDDATE");
				int colNm_PGM_IDX			= inputDs.indexOfColumn("PGM_IDX");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						
						//StringUtil.printMsg("arr_sql[6]",arr_sql[5].toString(),this);		
						stmt = conn.getGauceStatement(arr_sql[6].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_PARENT_IDX);
						stmt.bindColumn(j++, colNm_PGMNM);
						stmt.bindColumn(j++, colNm_RPGMID);
						stmt.bindColumn(j++, colNm_FLAG);
						stmt.bindColumn(j++, colNm_SEQ);
						stmt.bindColumn(j++, colNm_PAGETYPE);
						stmt.bindColumn(j++, colNm_STRDATE);
						stmt.bindColumn(j++, colNm_ENDDATE);
						stmt.setString(j++, iParamEmpno);
						stmt.setString(j++, iParamEmpno);						
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
						//객실정보 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);						
						stmt = conn.getGauceStatement(arr_sql[4].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_PGMNM);
						stmt.bindColumn(j++, colNm_RPGMID);
						stmt.bindColumn(j++, colNm_FLAG);
						stmt.bindColumn(j++, colNm_SEQ);
						stmt.bindColumn(j++, colNm_PGM_IDX);
						/*if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							stmt.setString(j++, "Y");
						} else {
							stmt.setString(j++, "N");							
						}						*/
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:

						//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);						
						stmt = conn.getGauceStatement(arr_sql[5].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_PGM_IDX);
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
