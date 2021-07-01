package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
  
public class Ac910I extends SuperServlet {
	                                       
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC910I_01(?,?)"); // ��ȸ1
		
		arr_sql[2].append("CALL SALES.PR_AC910I_02(?,?)"); // ��ȸ2
		
		arr_sql[3].append("CALL SALES.PR_AC910I_03(?,?,?,?,?, ?,?,?)");	// ����
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String sFr_date 	= HDUtil.nullCheckStr(req.getParameter("sFr_date"));	// ��������
		String sTo_date 	= HDUtil.nullCheckStr(req.getParameter("sTo_date")); 	// ��������
		
		StringUtil.printMsg("��������",sFr_date+"",this);
		StringUtil.printMsg("��������",sTo_date+"",this);
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				//StringUtil.printMsg("�̸� ", "---"+gauceName+"===" ,this);
				ds1 = req.getGauceDataSet(gauceName);
				
				if ("DS1".equals(gauceName)) {
					if(ds1!=null){
						switch(dsType){
							case 1:
								res.enableFirstRow(ds1);
								
								cstmt = conn.prepareCall(arr_sql[1].toString());
								cstmt.setString(1,sFr_date);
								cstmt.setString(2,sTo_date);
								rs = cstmt.executeQuery();							
								
								getDataSet(rs, ds1).flush();
								break;
							case 2:
								break;
							case 3:
								break;
						}
					}
				} else if ("DS2".equals(gauceName)){
					if(ds1!=null){
						switch(dsType){
							case 1:
								res.enableFirstRow(ds1);
								
								cstmt = conn.prepareCall(arr_sql[2].toString());
								cstmt.setString(1,sFr_date);
								cstmt.setString(2,sTo_date);
								rs = cstmt.executeQuery();							
								
								getDataSet(rs, ds1).flush();
								break;
							case 2:
								break;
							case 3:
								break;
						}
					}					
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
//		String sCaln_date 	= HDUtil.nullCheckStr(req.getParameter("sCaln_date"));	// �������
//		String sClose_yn 	= HDUtil.nullCheckStr(req.getParameter("sClose_yn"));	// ��������
//		StringUtil.printMsg("�������",sCaln_date+"",this);
//		StringUtil.printMsg("��������",sClose_yn+"",this);
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
//		if (iParamIp.length() > 13) {
//			 iParamIp = "AC900I IP".substring(0,13);	
//		}
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						int colNm_CalnDate    = ds1.indexOfColumn("DEPART_DATE");
						int colNm_GoodsSid    = ds1.indexOfColumn("GOODS_SID");
						int colNm_CloseYn	  = ds1.indexOfColumn("CLOSE_YN");

						//StringUtil.printMsg("�����",colNm_CalnDate+"",this);
						//StringUtil.printMsg("��ǰ",colNm_GoodsSid+"",this);
						//StringUtil.printMsg("��������",colNm_CloseYn+"",this);
						
						
						 
						for(int i=0; i<rows.length; i++){
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_UPDATE:
								
								cstmt = conn.prepareCall(arr_sql[3].toString());
								
								//StringUtil.printMsg("=============================== ������ �ű� =========================",this);
								
								cstmt.setString(1, rows[i].getString(colNm_CalnDate));
								cstmt.setInt(2, rows[i].getInt(colNm_GoodsSid));
								cstmt.setString(3, rows[i].getString(colNm_CloseYn));
								cstmt.setString(4, iParamEmpno);
								cstmt.setString(5, iParamIp);
								cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
								// ��������
								cstmt.executeUpdate();
								
								break;
							}
						}
					}
				}
			}
		}catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}
}
