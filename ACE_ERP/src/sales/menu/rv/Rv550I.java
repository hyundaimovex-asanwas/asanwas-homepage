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

public class Rv550I extends SuperServlet {

	
    public void makeSql(){
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
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
		//StringUtil.printMsg("# Command","����ȸ",this);

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
								//StringUtil.printMsg("IMAGE","HEAD CREATE",this);
								ds1.flush();									
							}
							if(gauceName.equals("CLIENTINFO")){
								//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
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
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","��ȸ",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// �˻��� ����
			String 	sClientSid	= HDUtil.nullCheckStr(req.getParameter("sClientSid"));
			String 	sStatusCd	= HDUtil.nullCheckStr(req.getParameter("sStatusCd"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));			
			
			//StringUtil.printMsg("sClientSid",sClientSid,this);
			//StringUtil.printMsg("sStatusCd",sStatusCd,this);			
			//StringUtil.printMsg("sBgnDate",sBgnDate,this);
			//StringUtil.printMsg("sEndDate",sEndDate,this);			

			// dataset ���� param
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
								//StringUtil.printMsg("call","SALES.PR_RV550i_01",this);
								cstmt = conn.prepareCall("{call SALES.PR_RV550I_01(?, ?, ?, ?) }");
								cstmt.setInt(1, Integer.parseInt(sClientSid));								
								cstmt.setString(2, sStatusCd);
								cstmt.setString(3, sBgnDate);
								cstmt.setString(4, sEndDate); 								
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
		
							//StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
							break;
					}
				}
				ds1.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�.				
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
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet reqNoDS = req.getGauceDataSet("reqNoDS");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;		
		String reqNo="";
		ResultSet rs = null;
		boolean fail=false;		
	
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
                
				int colNm_ReqNo                 = inputDs.indexOfColumn("REQ_NO");
				int colNm_ClientSid             = inputDs.indexOfColumn("CLIENT_SID");
				int colNm_AcceptDate            = inputDs.indexOfColumn("ACCEPT_DATE");
				int colNm_StatusCd              = inputDs.indexOfColumn("STATUS_CD");
				int colNm_ClientDamNm                  = inputDs.indexOfColumn("CLIENT_DAM_NM");
				int colNm_MobileNo              = inputDs.indexOfColumn("MOBILE_NO");
				int colNm_DepartDate            = inputDs.indexOfColumn("DEPART_DATE");
				int colNm_AcceptSid             = inputDs.indexOfColumn("ACCEPT_SID");
				int colNm_AcceptNo              = inputDs.indexOfColumn("ACCEPT_NO");
				int colNm_CardSid               = inputDs.indexOfColumn("CARD_SID");
				int colNm_PayManageNo                  = inputDs.indexOfColumn("PAY_MANAGE_NO");
				int colNm_CardNo                = inputDs.indexOfColumn("CARD_NO");
				int colNm_IssueCompanyNm               = inputDs.indexOfColumn("ISSUE_COMPANY_NM");
				int colNm_AgreeNo               = inputDs.indexOfColumn("AGREE_NO");
				int colNm_PayDate               = inputDs.indexOfColumn("PAY_DATE");
				int colNm_Reason                = inputDs.indexOfColumn("REASON");
				int colNm_Desc                  = inputDs.indexOfColumn("DESC");				
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//�޽���ó��
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				

				//��Ϲ�ȣ
				res.enableFirstRow(reqNoDS);
				reqNoDS.addDataColumn(new GauceDataColumn("req_no", GauceDataColumn.TB_STRING));
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","SALES.PR_RV550i_02-INSERT",this);
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						//StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						//StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						//StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						//StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						//StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						//StringUtil.printMsg("colNm_Reason",rows[i].getString(colNm_Reason),this);
						//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);						
						cstmt = conn.prepareCall("{call SALES.PR_RV550i_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_StatusCd));
						cstmt.setString(5, rows[i].getString(colNm_ClientDamNm));
						cstmt.setString(6, rows[i].getString(colNm_MobileNo));
						cstmt.setString(7, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(8, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(9, rows[i].getInt(colNm_CardSid));
						cstmt.setString(10, rows[i].getString(colNm_Reason));
						cstmt.setString(11, rows[i].getString(colNm_Desc));						
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "1");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						GauceDataRow row = reqNoDS.newDataRow();
						row.addColumnValue(cstmt.getString(1));						
						reqNoDS.addDataRow(row);
						
						//�޽���ó��
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								//StringUtil.printMsg("�����޽���",cstmt.getString(17),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(17));
								msgDS.addDataRow(row2);
							}
						} else {
							//StringUtil.printMsg("���и޽���",cstmt.getString(17),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(17));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 	
						
						if(cstmt!=null) cstmt.close();		
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RV550i_02-UPDATE",this);
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						//StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						//StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						//StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						//StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						//StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						//StringUtil.printMsg("colNm_Reason",rows[i].getString(colNm_Reason),this);
						//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);						
						cstmt = conn.prepareCall("{call SALES.PR_RV550i_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_StatusCd));
						cstmt.setString(5, rows[i].getString(colNm_ClientDamNm));
						cstmt.setString(6, rows[i].getString(colNm_MobileNo));
						cstmt.setString(7, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(8, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(9, rows[i].getInt(colNm_CardSid));
						cstmt.setString(10, rows[i].getString(colNm_Reason));
						cstmt.setString(11, rows[i].getString(colNm_Desc));						
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "3");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//�޽���ó��
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								//StringUtil.printMsg("�����޽���",cstmt.getString(17),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(17));
								msgDS.addDataRow(row2);
							}
						} else {
							//StringUtil.printMsg("���и޽���",cstmt.getString(17),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(17));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 		
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","SALES.PR_RV550i_02-DELETE",this);
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						//StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						//StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						//StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						//StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						//StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						//StringUtil.printMsg("colNm_Reason",rows[i].getString(colNm_Reason),this);
						//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);						
						cstmt = conn.prepareCall("{call SALES.PR_RV550i_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_StatusCd));
						cstmt.setString(5, rows[i].getString(colNm_ClientDamNm));
						cstmt.setString(6, rows[i].getString(colNm_MobileNo));
						cstmt.setString(7, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(8, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(9, rows[i].getInt(colNm_CardSid));
						cstmt.setString(10, rows[i].getString(colNm_Reason));
						cstmt.setString(11, rows[i].getString(colNm_Desc));						
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "2");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//�޽���ó��
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								//StringUtil.printMsg("�����޽���",cstmt.getString(17),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(17));
								msgDS.addDataRow(row2);
							}
						} else {
							//StringUtil.printMsg("���и޽���",cstmt.getString(17),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(17));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 	
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				reqNoDS.flush();
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			msgDS.flush();
			if( fail == true ) throw new Exception("");			
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

}
