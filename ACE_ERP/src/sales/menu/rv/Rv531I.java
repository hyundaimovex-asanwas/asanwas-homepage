package sales.menu.rv;

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

public class Rv531I extends SuperServlet {

	
    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
    	
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append (" SELECT						    		\n")
		  .append ("   T1.CLIENT_SID,                  \n")		
		  .append ("   T1.CLIENT_DAM_NM,                  \n")
		  .append ("   T1.TEL_NO                      \n")
		  .append("	FROM SALES.TCU030	T1		\n");      	
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("IMAGE")){
								ds1.addDataColumn(new GauceDataColumn("REQ_NO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
								StringUtil.printMsg("IMAGE","HEAD CREATE",this);
								ds1.flush();									
							}
							if(gauceName.equals("CLIENTINFO")){
								StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[0].toString());
								
								rs = stmt.executeQuery(); // DataSet set
								getDataSet(rs, ds1).flush();								
							}							
							break;
					}
				}
			}
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
		StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sSalDamSid	= HDUtil.nullCheckStr(req.getParameter("sSalDamSid"));			
			String 	sClientSid	= HDUtil.nullCheckStr(req.getParameter("sClientSid"));
			String 	sStatusCd	= HDUtil.nullCheckStr(req.getParameter("sStatusCd"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));			
			
			StringUtil.printMsg("sClientSid",sClientSid,this);
			StringUtil.printMsg("sStatusCd",sStatusCd,this);			
			StringUtil.printMsg("sBgnDate",sBgnDate,this);
			StringUtil.printMsg("sEndDate",sEndDate,this);			

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
								StringUtil.printMsg("call","SALES.PR_RV531i_01",this);
//								cstmt = conn.prepareCall("{call SALES.PR_RV531i_01(0, '', '20060101', '20061231') }");
								cstmt = conn.prepareCall("{call SALES.PR_RV531I_01(?, ?, ?, ?, ?) }");
								cstmt.setInt(1, Integer.parseInt(sSalDamSid));								
								cstmt.setInt(2, Integer.parseInt(sClientSid));								
								cstmt.setString(3, sStatusCd);
								cstmt.setString(4, sBgnDate);
								cstmt.setString(5, sEndDate); 								
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
			if(stmt!=null) stmt.close();
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
                
				int colNm_ReqNo                 = inputDs.indexOfColumn("REQ_NO");
				int colNm_StatusCd              = inputDs.indexOfColumn("STATUS_CD");
				int colNm_Desc                  = inputDs.indexOfColumn("DESC");				
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
						StringUtil.printMsg("call","SALES.PR_RV531i_02-UPDATE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV531i_02(?, ?, ?, ?, ?, ?, ?, ?, ?) }");
						
						StringUtil.printMsg("rows[i].getString(colNm_StatusCd)",rows[i].getString(colNm_StatusCd),this);						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.setString(2, rows[i].getString(colNm_StatusCd));
						cstmt.setString(3, rows[i].getString(colNm_Desc));
						cstmt.setString(4, iParamEmpno);
						cstmt.setString(5, iParamIp);
						cstmt.setString(6, "3");
						cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//메시지처리
						if (cstmt.getString(7).equals("Y") ) {
							if ( !cstmt.getString(8).equals("0000") ) {
								StringUtil.printMsg("성공메시지","성공메시지",this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(9));
								msgDS.addDataRow(row2);
							}
						} else {
							StringUtil.printMsg("실패메시지","실패메시지",this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(9));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						}
						
						if(cstmt!=null) cstmt.close();	
						break;
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			msgDS.flush();
			if( fail == true ) throw new Exception("");			
			if(cstmt!=null) cstmt.close();
		}
	}

}
