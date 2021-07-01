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

public class Pu031I_131031 extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//룩업용 : 메뉴명 불러오기
		arr_sql[0].append ("SELECT CODE_NO, CODE_NM ||'(' || LEVEL ||')' AS CODE_NM	\n")     
				  .append ("  FROM PMS.TPU011   							\n")
		  		  .append (" ORDER BY LEVEL, P_CODE 						\n");		
				      
		//마스터 추가		
		arr_sql[1].append ("INSERT INTO PMS.TPU011 (CODE_NO,P_CODE, CODE_NM,  LEVEL)  \n")     
				  .append ("  				        VALUES (?, ?, ?, ?) \n") ;    

		//마스터 조회
		arr_sql[3].append ("SELECT M01.CODE_NO, M01.P_CODE, M01.CODE_NM, M01.LEVEL \n")
				  .append ("  FROM PMS.TPU011  AS M01                      \n")
				  .append (" WHERE M01.LEVEL = ? 	                         \n")
				  .append (" ORDER BY M01.P_CODE  ASC    	                         \n");

		//마스터 수정
		arr_sql[4].append ("UPDATE PMS.TPU011                        \n")
				  .append ("   SET  P_CODE = ?                                   \n")
				  .append ("       ,CODE_NM = ?                                \n")
				  .append (" WHERE CODE_NO = ? 	                         \n");				  

		//마스터 삭제 
		arr_sql[5].append ("DELETE FROM PMS.TPU010                  \n")
				  .append (" WHERE ITEM_SID = ? 	                             \n");
		

		
		
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
		int menu_level = HDUtil.nullCheckNum(req.getParameter("menu_level"));
		
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS_MENU")){//레벨1 조회
								//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[0].toString());
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
			int menu_level = HDUtil.nullCheckNum(req.getParameter("menu_level"));
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
							if (menu_level != 0 ) 
								stmt.setInt(1, menu_level);	
		
							rs = stmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();							

							if(rs!=null) rs.close();
							if(stmt!=null) stmt.close();
		
							//StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
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

				int colNm_CODE_NO			= inputDs.indexOfColumn("CODE_NO");
				int colNm_P_CODE				= inputDs.indexOfColumn("P_CODE");
				int colNm_CODE_NM			= inputDs.indexOfColumn("CODE_NM");
				int colNm_LEVEL					= inputDs.indexOfColumn("LEVEL");
								
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					// 마스터 추가
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);		
						stmt = conn.getGauceStatement(arr_sql[1].toString());
						stmt.setGauceDataRow(rows[i]);

/*
						StringUtil.printMsg("colNm_PARENT_IDX",rows[i].getString(colNm_PARENT_IDX),this);
						StringUtil.printMsg("colNm_SCDNM",rows[i].getString(colNm_SCDNM),this);
						StringUtil.printMsg("colNm_SEQ",rows[i].getString(colNm_SEQ),this);
						StringUtil.printMsg("colNm_LEVEL",rows[i].getString(colNm_LEVEL),this);
						StringUtil.printMsg("colNm_DIRPATH",rows[i].getString(colNm_DIRPATH),this);
*/						
						stmt.bindColumn(j++, colNm_CODE_NO);
						stmt.bindColumn(j++, colNm_P_CODE);
						stmt.bindColumn(j++, colNm_CODE_NM);
						stmt.bindColumn(j++, colNm_LEVEL);
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;

					// 마스터 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);						
						stmt = conn.getGauceStatement(arr_sql[4].toString());
						
						int colNm_CODE_NO2                   = inputDs.indexOfColumn("CODE_NO");
						int colNm_LEVEL2                   = inputDs.indexOfColumn("LEVEL");
						int colNm_P_CODE2                   = inputDs.indexOfColumn("P_CODE");
						int colNm_CODE_NM2                   = inputDs.indexOfColumn("CODE_NM");
						
						//StringUtil.printMsg("colNm_idx",""+rows[i].getInt(colNm_idx),this);
						//StringUtil.printMsg("colNm_lvl",rows[i].getString(colNm_lvl),this);
						//StringUtil.printMsg("colNm_pid",""+rows[i].getInt(colNm_pid),this);
						//StringUtil.printMsg("colNm_snm",rows[i].getString(colNm_snm),this);
						//StringUtil.printMsg("colNm_seq",rows[i].getString(colNm_seq),this);
						//StringUtil.printMsg("colNm_dir",rows[i].getString(colNm_dir),this);
						
						stmt.setString(1, rows[i].getString(colNm_CODE_NO2));
						//stmt.setString(2, rows[i].getString(colNm_LEVEL2));
						stmt.setString(2, rows[i].getString(colNm_P_CODE2));
						stmt.setString(3, rows[i].getString(colNm_CODE_NM2));
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:

						//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);						
						stmt = conn.getGauceStatement(arr_sql[5].toString());
						stmt.setGauceDataRow(rows[i]);
						
						//stmt.bindColumn(j++, colNm_PGM_IDX);
						//stmt.execute();
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
