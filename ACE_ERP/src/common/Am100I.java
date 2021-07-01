package common;
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

public class Am100I extends SuperServlet {

	public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
	}
		
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			int 		sITEM_SID		= HDUtil.nullCheckNum(req.getParameter("sITEM_SID"));
			String  		sEMPNO			= HDUtil.nullCheckStr(req.getParameter("sEMPNO"));		
			String 		sEMPNMK		= HDUtil.nullCheckStr(req.getParameter("sEMPNMK"));
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
							res.enableFirstRow(ds1);
							cstmt = conn.prepareCall("{call SALES.PR_AM100I_01(?, ?, ?) }");
							cstmt.setInt(1, sITEM_SID);
							cstmt.setString(2, sEMPNO);
							cstmt.setString(3, sEMPNMK);
							rs = cstmt.executeQuery();							
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
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * 기능 :
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;
		boolean fail=false;			

		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
				
				
				
				
				int colNm_ITEM_SID             	= inputDs.indexOfColumn("ITEM_SID");
				int colNm_EMPNO					= inputDs.indexOfColumn("EMPNO");
				int colNm_EMPNMK         		= inputDs.indexOfColumn("EMPNMK");
				int colNm_MODEL_NM             = inputDs.indexOfColumn("MODEL_NM");
				int colNm_MADE_COMPANY    = inputDs.indexOfColumn("MADE_COMPANY");
				int colNm_CPU              			= inputDs.indexOfColumn("CPU");
				int colNm_HDD              			= inputDs.indexOfColumn("HDD");
				int colNm_RAM                 		= inputDs.indexOfColumn("RAM");
				int colNm_GRAPHIC             	= inputDs.indexOfColumn("GRAPHIC");
				int colNm_PURCHASE_DATE    = inputDs.indexOfColumn("PURCHASE_DATE");
				int colNm_RETURN_DATE        = inputDs.indexOfColumn("RETURN_DATE");
				int colNm_DONE_DATE         	= inputDs.indexOfColumn("DONE_DATE");
				int colNm_REMARKS             	= inputDs.indexOfColumn("REMARKS");
				//int colNm_IP             				= inputDs.indexOfColumn("IP");
				
				StringUtil.printMsg("colNm_ITEM_SID",colNm_ITEM_SID,this);
				StringUtil.printMsg("colNm_EMPNO",colNm_EMPNO,this);
				StringUtil.printMsg("colNm_EMPNMK",colNm_EMPNMK,this);
				StringUtil.printMsg("colNm_MODEL_NM",colNm_MODEL_NM,this);
				StringUtil.printMsg("colNm_MADE_COMPANY",colNm_MADE_COMPANY,this);
				StringUtil.printMsg("colNm_CPU",colNm_CPU,this);
				StringUtil.printMsg("colNm_HDD",colNm_HDD,this);
				StringUtil.printMsg("colNm_RAM",colNm_RAM,this);
				StringUtil.printMsg("colNm_GRAPHIC",colNm_GRAPHIC,this);
				StringUtil.printMsg("colNm_PURCHASE_DATE",colNm_PURCHASE_DATE,this);
				StringUtil.printMsg("colNm_RETURN_DATE",colNm_RETURN_DATE,this);
				StringUtil.printMsg("colNm_DONE_DATE",colNm_DONE_DATE,this);
				StringUtil.printMsg("colNm_REMARKS",colNm_REMARKS,this);
				//StringUtil.printMsg("colNm_IP",colNm_IP,this);
								
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
				
				inner : {
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
							//인서트
							case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall("{call SALES.PR_AM100I_02( ?,?,?,?,?  ,?,?,?,?,?  ,?,?,?,?,?   ,?,?,?,? ) }");						
							cstmt.setInt(1, rows[i].getInt(colNm_ITEM_SID));
							cstmt.setString(2, rows[i].getString(colNm_EMPNO));
							cstmt.setString(3, rows[i].getString(colNm_EMPNMK));
							cstmt.setString(4, rows[i].getString(colNm_MODEL_NM));
							cstmt.setString(5, rows[i].getString(colNm_MADE_COMPANY));
							cstmt.setString(6, rows[i].getString(colNm_CPU));
							cstmt.setString(7, rows[i].getString(colNm_HDD));
							cstmt.setString(8, rows[i].getString(colNm_RAM));
							cstmt.setString(9, rows[i].getString(colNm_GRAPHIC));
							cstmt.setString(10, rows[i].getString(colNm_PURCHASE_DATE));
							cstmt.setString(11, rows[i].getString(colNm_RETURN_DATE));
							cstmt.setString(12, rows[i].getString(colNm_DONE_DATE));
							cstmt.setString(13, rows[i].getString(colNm_REMARKS));
							//cstmt.setString(14, rows[i].getString(colNm_IP));
							cstmt.setString(14, iParamEmpno);
							cstmt.setString(15, iParamIp);
							cstmt.setString(16, "1");
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR); 						
							cstmt.executeUpdate();


							
							
								//메시지처리
								 if (cstmt.getString(17).equals("Y") ) {
									if ( !cstmt.getString(18).equals("0000") ) {
										StringUtil.printMsg("성공메시지",cstmt.getString(19),this);
										GauceDataRow row = msgDS.newDataRow();
										row.addColumnValue(cstmt.getString(18));								
										msgDS.addDataRow(row);
									}
								 } else {
									StringUtil.printMsg("실패메시지",cstmt.getString(19),this);								
									conn.rollback();
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(18));							
									msgDS.addDataRow(row);
									fail = true;
									break inner;						
								}  		
								if(cstmt!=null) cstmt.close();
								break;
							//업데이트
							case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall("{call SALES.PR_AM100I_02( ?,?,?,?,?  ,?,?,?,?,?, ?,?,?,?,?,  ?,?,?,? ) }");						
							
							cstmt.setInt(1, rows[i].getInt(colNm_ITEM_SID));
							cstmt.setString(2, rows[i].getString(colNm_EMPNO));
							cstmt.setString(3, rows[i].getString(colNm_EMPNMK));
							cstmt.setString(4, rows[i].getString(colNm_MODEL_NM));
							cstmt.setString(5, rows[i].getString(colNm_MADE_COMPANY));
							cstmt.setString(6, rows[i].getString(colNm_CPU));
							cstmt.setString(7, rows[i].getString(colNm_HDD));
							cstmt.setString(8, rows[i].getString(colNm_RAM));
							cstmt.setString(9, rows[i].getString(colNm_GRAPHIC));
							cstmt.setString(10, rows[i].getString(colNm_PURCHASE_DATE));
							cstmt.setString(11, rows[i].getString(colNm_RETURN_DATE));
							cstmt.setString(12, rows[i].getString(colNm_DONE_DATE));
							cstmt.setString(13, rows[i].getString(colNm_REMARKS));
							cstmt.setString(14, iParamEmpno);
							cstmt.setString(15, iParamIp);
							cstmt.setString(16, "3");
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR); 						
							cstmt.executeUpdate();
																		
							//메시지처리
						 if (cstmt.getString(17).equals("Y") ) {
							if ( !cstmt.getString(18).equals("0000") ) {
								StringUtil.printMsg("성공메시지",cstmt.getString(19),this);
								GauceDataRow row = msgDS.newDataRow();
								row.addColumnValue(cstmt.getString(18));								
								msgDS.addDataRow(row);
							}
						 } else {
							StringUtil.printMsg("실패메시지",cstmt.getString(19),this);								
							conn.rollback();
							GauceDataRow row = msgDS.newDataRow();
							row.addColumnValue(cstmt.getString(18));							
							msgDS.addDataRow(row);
							fail = true;
							break inner;						
						}  		
								if(cstmt!=null) cstmt.close();
								break;
										//DELETE
							case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall("{call SALES.PR_AM100I_02( ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?   ) }");						
							
							cstmt.setInt(1, rows[i].getInt(colNm_ITEM_SID));
							cstmt.setString(2, rows[i].getString(colNm_EMPNO));
							cstmt.setString(3, rows[i].getString(colNm_EMPNMK));
							cstmt.setString(4, rows[i].getString(colNm_MODEL_NM));
							cstmt.setString(5, rows[i].getString(colNm_MADE_COMPANY));
							cstmt.setString(6, rows[i].getString(colNm_CPU));
							cstmt.setString(7, rows[i].getString(colNm_HDD));
							cstmt.setString(8, rows[i].getString(colNm_RAM));
							cstmt.setString(9, rows[i].getString(colNm_GRAPHIC));
							cstmt.setString(10, rows[i].getString(colNm_PURCHASE_DATE));
							cstmt.setString(11, rows[i].getString(colNm_RETURN_DATE));
							cstmt.setString(12, rows[i].getString(colNm_DONE_DATE));
							cstmt.setString(13, rows[i].getString(colNm_REMARKS));
							cstmt.setString(14, iParamEmpno);
							cstmt.setString(15, iParamIp);
							cstmt.setString(16, "2");
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR); 	
													
							cstmt.executeUpdate();
																		
							//메시지처리
						 if (cstmt.getString(17).equals("Y") ) {
							if ( !cstmt.getString(18).equals("0000") ) {
								StringUtil.printMsg("성공메시지",cstmt.getString(19),this);
								GauceDataRow row = msgDS.newDataRow();
								row.addColumnValue(cstmt.getString(18));								
								msgDS.addDataRow(row);
							}
						 } else {
							StringUtil.printMsg("실패메시지",cstmt.getString(19),this);								
							conn.rollback();
							GauceDataRow row = msgDS.newDataRow();
							row.addColumnValue(cstmt.getString(18));							
							msgDS.addDataRow(row);
							fail = true;
							break inner;						
						}  		
								if(cstmt!=null) cstmt.close();
								break;						
						}
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			msgDS.flush();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}
}
