package sales.menu.sy;

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

public class Sy710I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_SY710I_01(?,?)");						//��ȸ�ϱ�
		arr_sql[2].append("CALL SALES.PR_SY710I_02(?,?)");	//delete
		arr_sql[3].append("CALL SALES.PR_SY710I_03(?,?)");	//insert

	
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
		

		/* DataSet */
		GauceDataSet ds1 = null; // 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		 
		 String 	v_empno	    			= HDUtil.nullCheckStr(req.getParameter("v_empno"));	
		 int 		v_research_cd		= HDUtil.nullCheckNum(req.getParameter("v_research_cd"));

		 
		 //StringUtil.printMsg("v_empno=", v_empno, this);
		 //StringUtil.printMsg("v_research_cd", v_research_cd, this);
	
	
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
				   IN    pEMPNO       VARCHAR(7),       -- ���
				   IN    pRESEARCH_SUB   NUMERIC(1,0),       --�����ڵ�
				 
						 */
						 						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(sCnt1++, v_empno);
						//StringUtil.printMsg("sCnt1++=", sCnt1++, this);
						cstmt.setInt(sCnt1++, v_research_cd);												
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
				
				String 	v_empno	    			= HDUtil.nullCheckStr(req.getParameter("v_empno"));	
				int 		colNm_research_seq	=ds1.indexOfColumn("RESEARCH_SEQ");       //����ġ ����seq
			//	int 		v_research_cd		= HDUtil.nullCheckNum(req.getParameter("v_research_cd"));				
				
				
				
				for(int i = 0; i < rows.length; i++) {
				 //StringUtil.printMsg("job=", rows[i].getJobType(), this);
//					StringUtil.printMsg("����ġ ����seq       - "," i::"+ i+"::"+rows[i].getInt(colNm_research_seq)	, this); 
	
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {													
						//if(i==0){						
						if ( rows[i].getString(ds1.indexOfColumn("RS_YN")).equals("F") ) {		// ����  F üũ�� delete
							//	StringUtil.printMsg("update type=", "1", this);		
								cstmt = conn.prepareCall(arr_sql[2].toString());
							//	StringUtil.printMsg("�Է��ڻ��       - ",rows[i].getString(colNm_empno)	, this); 
							//	StringUtil.printMsg("����ġ ����seq       - ",rows[i].getInt(colNm_research_seq)	, this); 
							//	StringUtil.printMsg("����ġ ����       - ",v_research_cd, this); 					
								cstmt.setString(1, v_empno);		
								cstmt.setInt(2, rows[i].getInt(colNm_research_seq));
								//cstmt.setInt(2, v_research_cd);
								cstmt.executeUpdate();
								if(cstmt!=null) cstmt.close();	
						}// ����  F üũ�� delete

						if ( rows[i].getString(ds1.indexOfColumn("RS_YN")).equals("T") ) { //����  T üũ�� insert
						//	StringUtil.printMsg("update type=", "2", this);			
							cstmt = conn.prepareCall(arr_sql[3].toString());									
						//	StringUtil.printMsg("����ġ ����seq       - ",rows[i].getInt(colNm_research_seq)	, this); 
							cstmt.setString(1, v_empno);		
							cstmt.setInt(2, rows[i].getInt(colNm_research_seq));
						//	cstmt.setInt(3, v_research_cd);
							cstmt.executeUpdate();
						} //����  T üũ�� insert
					} //if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
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
