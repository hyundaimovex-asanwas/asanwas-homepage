package sales.menu.help;
/**********************************************************************************
 * ���ڰ��� - ���� ��û 
 **********************************************************************************/

import java.io.File;
import java.sql.*;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.StringUtil;
import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;

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

public class My400H_20131125 extends SuperServlet {
	   
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// ���� ������ ���� ��ȸ	
		arr_sql[0].append ("{call SALES.PR_MY400H_01(?) }");

		// ���� ������ ���� ��ȸ	
		arr_sql[1].append ("{call SALES.PR_MY400H_02(?) }");	//
		
		// ���缱 ���� ��ȸ	
		arr_sql[2].append ("{call COMMON.PR_AP001S_01(?, ?) }");	//COMMON.PR_AP001S_01(1,'1');
		
		// ���� ����	
		arr_sql[3].append ("{call SALES.PR_MY400I_02(?,?,?,?,?,    ?,?,?) }");
				
    }
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		//System.out.println("# Command : ����ȸ");
		//StringUtil.printMsg("s_ap_m_sid", "s_ap_m_sid", this);

	}
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//System.out.println("# Command : ��ȸ");
		//StringUtil.printMsg("s_ap_m_sid","s_ap_m_sid", this);
		GauceStatement stmt = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds_master = null;
		GauceDataSet ds_detail = null;
		GauceDataSet ds_line = null;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter ����
		 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
		 **********************************************************************************/
  
		// �˻��� ����
		int s_ap_m_sid			= HDUtil.nullCheckNum(req.getParameter("s_ap_m_sid"));
		String s_ap_gu			= HDUtil.nullCheckStr(req.getParameter("s_ap_gu"));
		
		//StringUtil.printMsg("s_ap_m_sid", s_ap_m_sid+"", this);
		//StringUtil.printMsg("s_ap_gu", s_ap_gu+"", this);
		
		try{
			ds_master = req.getGauceDataSet("AP_MASTER_DS");
			ds_detail = req.getGauceDataSet("AP_DETAIL_DS");
			ds_line = req.getGauceDataSet("AP_LINE_DS");
			
			if(ds_master!=null){
				//StringUtil.printMsg("ds_master", "ds_master", this);
				res.enableFirstRow(ds_master);
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt(1, s_ap_m_sid);
				
				rs = cstmt.executeQuery(); // DataSet set
				getDataSet(rs, ds_master).flush();
			}

			if(ds_detail!=null){
				//StringUtil.printMsg("ds_detail", "ds_detail", this);
				res.enableFirstRow(ds_detail);
				cstmt = conn.prepareCall(arr_sql[1].toString());
				cstmt.setInt(1, s_ap_m_sid);
				
				rs = cstmt.executeQuery(); // DataSet set
				getDataSet(rs, ds_detail).flush();
			}

			if(ds_line!=null){
				//StringUtil.printMsg("ds_line", "ds_line", this);
				res.enableFirstRow(ds_line);
				//stmt = conn.getGauceStatement(arr_sql[0].toString());
				cstmt = conn.prepareCall(arr_sql[2].toString());
				cstmt.setInt(1, s_ap_m_sid);
				cstmt.setString(2, s_ap_gu);
				
				rs = cstmt.executeQuery(); // DataSet set
				getDataSet(rs, ds_line).flush();
			}
			
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//	���� method
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����",this);
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = null;
		GauceDataSet reqNoDS = req.getGauceDataSet("reqNoDS");	
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;		
		GauceStatement stmt = null;		
		ResultSet rs = null;
		boolean fail=false;
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					//StringUtil.printMsg("gauceName::::::::::::::::::::::::::::",gauceName,this);
					res.enableFirstRow(ds1);
					if(gauceName.equals("AP_LINE_DS")){
						int s_ap_m_sid	= HDUtil.nullCheckNum(req.getParameter("s_ap_m_sid"));
						String s_empnmk	= "";//HDUtil.nullCheckStr(req.getParameter("sEmpNmk"));
						
						/*
						StringUtil.printMsg("Draft:::::::::::::::::::::::::::::","Draft::::::::::::::::::::::::",this);
						StringUtil.printMsg("s_ap_m_sid",s_ap_m_sid,this);
						StringUtil.printMsg("s_empnmk",s_empnmk,this);
						StringUtil.printMsg("s_empno",s_empno,this);
						*/
						GauceDataRow[]       rows = ds1.getDataRows();
						GauceDataColumn[]  cols = ds1.getDataColumns();
						//�޽���ó��
						res.enableFirstRow(msgDS);
						msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
						   int j=1;
							  cstmt = conn.prepareCall(arr_sql[3].toString());
							  cstmt.setInt(1, s_ap_m_sid);
		  					  cstmt.setString(2, s_empnmk);
							  cstmt.setString(3, fParamEmpno);
							  cstmt.setString(4, iParamEmpno);
							  cstmt.setString(5, iParamIp);
							  cstmt.registerOutParameter(6,  java.sql.Types.VARCHAR);
							  cstmt.registerOutParameter(7,  java.sql.Types.VARCHAR);
							  cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);

							  cstmt.executeUpdate();
			
							  //�޽���ó��
							  if (cstmt.getString(6).equals("Y") ) {
								 if ( !cstmt.getString(7).equals("0000") ) {
									GauceDataRow row2 = msgDS.newDataRow();
									row2.addColumnValue(cstmt.getString(8));
									msgDS.addDataRow(row2);
								 }
							  if(cstmt!=null) cstmt.close();
						   }
					}
				}
				//reqNoDS.flush();
				}
				  if(ds_result!=null) ds_result.flush();
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
