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

public class Rm271I extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		
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
		String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		String 	sUpjangSid	= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));

	
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
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// �˻��� ����
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sEndDate	     = HDUtil.nullCheckStr(req.getParameter("sEndDate"));
			int 	sSaupSid	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
			int 	sUpjangSid	= HDUtil.nullCheckNum(req.getParameter("sUpjangSid"));
			String 	sRemarks	= HDUtil.nullCheckStr(req.getParameter("sRemarks"));

		
		/*	StringUtil.printMsg("sBgnDate=", sBgnDate, this);
			StringUtil.printMsg("sEndDate=", sEndDate, this);
			StringUtil.printMsg("sSaupSid=", sSaupSid, this);
			StringUtil.printMsg("sUpjangSid=", sUpjangSid, this);
			StringUtil.printMsg("sRemarks=", sRemarks, this);		 
		 		
			*/
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
								//StringUtil.printMsg("call SALES.PR_RM310I_01","",this);
								cstmt = conn.prepareCall("{call SALES.PR_RM271I_01(?, ?, ?, ?, ?) }");
								cstmt.setString(1, sBgnDate);
								cstmt.setString(2, sEndDate);
								cstmt.setInt(3, sSaupSid);
								cstmt.setInt(4, sUpjangSid);
								cstmt.setString(5, sRemarks);																
														
							}															
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();							
							
					}
				}
				//ds1.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�.				
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
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs1 = req.getGauceDataSet("DS1");		

		CallableStatement cstmt = null;
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		boolean fail=false;
		
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{

			if(inputDs1!=null){
				
				
				int colNm_MenuCnt 	= inputDs1.indexOfColumn("MENU_CNT");
				int colNm_UseYn 	= inputDs1.indexOfColumn("USE_YN");		
				int colNm_UseDate 	= inputDs1.indexOfColumn("USE_DATE");							
				int colNm_MenuSid 	= inputDs1.indexOfColumn("MENU_SID");
				int colNm_UseSeq 	= inputDs1.indexOfColumn("USE_SEQ");
		
			
				GauceDataRow[] 		rows2 = inputDs1.getDataRows();
				GauceDataColumn[] 	cols2 = inputDs1.getDataColumns();
				
				inner2:
				
				
				for(int i=0; i<rows2.length; i++){
					int j=1;												
					switch(rows2[i].getJobType()){						
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call SALES.PR_RM310I_04","",this);
							cstmt = conn.prepareCall("{call SALES.PR_RM271I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
						/*	
							StringUtil.printMsg("����",rows2[i].getInt(colNm_MenuCnt),this);
							StringUtil.printMsg("����",rows2[i].getString(colNm_UseYn),this);
							StringUtil.printMsg("EmpNo",iParamEmpno,this);
							StringUtil.printMsg("IP",iParamIp,this);
							StringUtil.printMsg("�̿�����",rows2[i].getString(colNm_UseDate),this);												
							StringUtil.printMsg("�޴�",rows2[i].getInt(colNm_MenuSid),this);
							StringUtil.printMsg("ȸ��",rows2[i].getInt(colNm_UseSeq),this);
							*/			
							cstmt.setInt(1,rows2[i].getInt(colNm_MenuCnt));
							
							if ( rows2[i].getString(colNm_UseYn).equals("") ) 
								cstmt.setString(2, "N");
							else
								cstmt.setString(2, rows2[i].getString(colNm_UseYn));
							cstmt.setString(3, iParamEmpno);
							cstmt.setString(4, iParamIp);														
							cstmt.setString(5, rows2[i].getString(colNm_UseDate));								
							cstmt.setInt(6, rows2[i].getInt(colNm_MenuSid));
							cstmt.setInt(7, rows2[i].getInt(colNm_UseSeq));
							cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();

							//�޽���ó��
							if (cstmt.getString(8).equals("Y") ) {
								if ( !cstmt.getString(9).equals("0000") ) {
									//StringUtil.printMsg("�����޽���",cstmt.getString(15),this);
									GauceDataRow row = msgDS.newDataRow();									
									row.addColumnValue(cstmt.getString(10));
									msgDS.addDataRow(row);
								}
							} else {
								//StringUtil.printMsg("���и޽���",cstmt.getString(15),this);								
								conn.rollback();
								GauceDataRow row = msgDS.newDataRow();								
								row.addColumnValue(cstmt.getString(10));
								msgDS.addDataRow(row);
								fail=true;
								break inner2;						
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
