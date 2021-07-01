package sales.menu.rm;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rm270I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_RM270I_01(?,?,?)");						//��ȸ�ϱ�
		arr_sql[2].append("CALL SALES.PR_RM270I_02(?,?,?,?)");	//����� 4��
		arr_sql[3].append("CALL SALES.PR_RM270I_03(?,?,?,?, ?,?)");		//�μ�Ʈ�ϱ�  6��	
	
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
			}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt;
		
		//int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		 int 		v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
		 int		v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		 String	v_menu_cd	 	= HDUtil.nullCheckStr(req.getParameter("v_menu_cd"));
		 
		 StringUtil.printMsg("v_saup_sid=", v_saup_sid, this);
		 StringUtil.printMsg("v_upjang_sid=", v_upjang_sid, this);
		 StringUtil.printMsg("v_menu_cd=", v_menu_cd, this);
	
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				StringUtil.printMsg("gauceName++=", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						/*
				   IN    pSAUP_SID       NUMERIC(10,0),       -- ����� SID
				   IN    pUPJANG_SID   NUMERIC(10,0),       --����SID
				   IN    pMENU_NM       VARCHAR(50)     --  �޴��̸�
						 */
						 						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(sCnt1++, v_saup_sid);
						//StringUtil.printMsg("sCnt1++=", sCnt1++, this);
						cstmt.setInt(sCnt1++, v_upjang_sid);
						cstmt.setString(sCnt1++, v_menu_cd);
						
						
						rs = cstmt.executeQuery();			
					}
									
					getDataSet(rs, ds1).flush();

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
		// TODO Auto-generated method stub

		CallableStatement 	cstmt 		= null;
		ResultSet 			rs 			= null;
		//StringUtil.printMsg("�Է�",this);
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		//String iParamEmpno = fParamEmpno;
		//String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("DEFAULT");	

		try{
			//���� ����
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_use_seq			=ds1.indexOfColumn("USE_SEQ");       
				int colNm_menu_cnt		= ds1.indexOfColumn("MENU_CNT");       
				int colNm_upjang_sid		= ds1.indexOfColumn("UPJANG_SID");							 
				int colNm_menu_sid		= ds1.indexOfColumn("MENU_SID");
				int colNm_bgn_date		=ds1.indexOfColumn("BGN_DATE"); 
				int colNm_end_date		=ds1.indexOfColumn("END_DATE");		     
				//int colNm_U_EMPNO    	=	ds1.indexOfColumn("U_EMPNO");		//���������ڻ��
				//int colNm_U_IP       	=	ds1.indexOfColumn("U_IP");			//��������IP  
				
				for(int i = 0; i < rows.length; i++) {
					//����Ʈ �� ������Ʈ�� ó���Ѵ�.
					//StringUtil.printMsg("job=", rows[i].getJobType(), this);
					
					if ( rows[i].getString(ds1.indexOfColumn("CREATE_YN")).equals("T") ) {		// ���� üũ��					

						if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
							
							StringUtil.printMsg("update type=", "1", this);
					
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							StringUtil.printMsg("�޴�����       - ",rows[i].getString(colNm_menu_sid)	, this); 
							StringUtil.printMsg("ȸ��       - ",rows[i].getString(colNm_use_seq)	, this); 
							StringUtil.printMsg("��������       - ",rows[i].getString(colNm_bgn_date)	, this); 
							StringUtil.printMsg("��������       - ",rows[i].getString(colNm_end_date)	, this); 
													
							
							cstmt.setInt(1, rows[i].getInt(colNm_menu_sid));
							cstmt.setInt(2, rows[i].getInt(colNm_use_seq));
							cstmt.setString(3, rows[i].getString(colNm_bgn_date));		
							cstmt.setString(4, rows[i].getString(colNm_end_date));		
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
							
							
							StringUtil.printMsg("update type=", "2", this);	
							
							cstmt = conn.prepareCall(arr_sql[3].toString());
								
								
							StringUtil.printMsg("ȸ��       - ",rows[i].getString(colNm_use_seq)	, this); 
							StringUtil.printMsg("����       - ",rows[i].getString(colNm_menu_cnt)	, this);
							StringUtil.printMsg("�����       - ",rows[i].getString(colNm_upjang_sid)	, this); 
							StringUtil.printMsg("�޴�����       - ",rows[i].getString(colNm_menu_sid)	, this); 
							StringUtil.printMsg("��������       - ",rows[i].getString(colNm_bgn_date)	, this); 
							StringUtil.printMsg("��������       - ",rows[i].getString(colNm_end_date)	, this); 
							
							
							cstmt.setInt(1, rows[i].getInt(colNm_use_seq));
							cstmt.setInt(2, rows[i].getInt(colNm_menu_cnt));
							cstmt.setInt(3, rows[i].getInt(colNm_upjang_sid));
							cstmt.setInt(4, rows[i].getInt(colNm_menu_sid));
							cstmt.setString(5, rows[i].getString(colNm_bgn_date));		
							cstmt.setString(6, rows[i].getString(colNm_end_date));
							
							cstmt.executeUpdate();
						} //if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
					}//if ( rows[i].getString(ds1.indexOfColumn("CREATE_YN")).equals("T") ) {	
				};//for(int i=0; i<row.length; i++){
	
			}; //if
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		};//try{	

	}

}
