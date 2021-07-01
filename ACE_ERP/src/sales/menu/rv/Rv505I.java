package sales.menu.rv;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
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

public class Rv505I extends SuperServlet {

	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;
	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append (" SELECT						    		\n")
		  .append ("   T1.CLIENT_SID,                  \n")		
		  .append ("   T1.CLIENT_DAM_NM,                  \n")
		  .append ("   T1.TEL_NO                      \n")
		  .append("	FROM SALES.TCU030	T1		\n");
   	
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		GauceDataSet imgDs = null;
		CallableStatement cstmt = null;		
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			int 	sClientSid	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));
			String 	sStatusCd	= HDUtil.nullCheckStr(req.getParameter("sStatusCd"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));			
			
			StringUtil.printMsg("sClientSid",sClientSid,this);
			StringUtil.printMsg("sStatusCd",sStatusCd,this);			
			StringUtil.printMsg("sBgnDate",sBgnDate,this);
			StringUtil.printMsg("sEndDate",sEndDate,this);			

			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

				ds1 = req.getGauceDataSet("DS1");
				imgDs = req.getGauceDataSet("IMAGE");
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							
							cstmt = conn.prepareCall("{call SALES.PR_RV505I_01(?, ?, ?, ?) }");
							cstmt.setInt(1, sClientSid);								
							cstmt.setString(2, sStatusCd);
							cstmt.setString(3, sBgnDate);
							cstmt.setString(4, sEndDate); 								
							
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();

							break;
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
		GauceStatement stmt = null;		
		String reqNo="";
		ResultSet rs = null;
		boolean fail=false;
	
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
                
				int colNm_ReqNo                 = inputDs.indexOfColumn("REQ_NO");
				int colNm_RsvSid                = inputDs.indexOfColumn("RSV_SID");
				int colNm_mRsvSid               = inputDs.indexOfColumn("M_RSV_SID");
				int colNm_JoinCd                = inputDs.indexOfColumn("JOIN_CD");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
				

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RV510i_02-INSERT",this);
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_RsvSid",rows[i].getString(colNm_RsvSid),this);
						//StringUtil.printMsg("colNm_mRsvSid",rows[i].getString(colNm_mRsvSid),this);
						//StringUtil.printMsg("colNm_JoinCd",rows[i].getString(colNm_JoinCd),this);
						cstmt = conn.prepareCall("{call SALES.PR_RV505i_02(?,?,?,?,?, ?,?,?,?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.setInt(2, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(3, rows[i].getString(colNm_mRsvSid));
						cstmt.setString(4, rows[i].getString(colNm_JoinCd));						
						cstmt.setString(5, iParamEmpno);
						cstmt.setString(6, iParamIp);
						cstmt.setString(7, "3");
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						

						//메시지처리
						if (!cstmt.getString(8).equals("Y") ) 
							throw new Exception(cstmt.getString(10));
						
						if (cstmt.getString(8).equals("Y") ) {
							if ( !cstmt.getString(9).equals("0000") ) {
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(10));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();						
						break;
					}
				}
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			msgDS.flush();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}

}
