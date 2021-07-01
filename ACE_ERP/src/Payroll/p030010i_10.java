package Payroll;

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

public class p030010i_10 extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// �����ڱ� ���̺�  ���� ��ȸ
		arr_sql[0].append("{CALL PAYROLL.PR_P030010I_10s (?,?) }");

		// ����/����
		arr_sql[1].append("{CALL PAYROLL.PR_P030010I_10i (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("START ", "�����Դϴ�.", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* �˻��� �ʿ��� ����  --------------------------------------------------------------- */
		String eyy 		        = HDUtil.nullCheckStr(req.getParameter("eyy"));	      // �ͼӳ⵵
		String eno					= HDUtil.nullCheckStr(req.getParameter("eno"));	      // ��� 
		/* �˻��� �ʿ��� ����  --------------------------------------------------------------- */		
		
		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[0].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );

						rs = stmt.executeQuery();
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
		//StringUtil.printMsg("DS TYPE:::","������Ʈ",this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");
		ResultSetMetaData rsmd = null;
		
		
		try {
			//�޽���ó��
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			String r_s_yn	;
			String r_msg_cd	;
			String r_msg	;
			String job_cd	;	//�μ�Ʈ, ������Ʈ, ����Ʈ ����..
			String givtype=""  ; 	//��������
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				//StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
							int colNm_APPYY   		= ds1.indexOfColumn("APPYY");		//�ͼӳ⵵         
							int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");		//���             
							int colNm_SEQ     			= ds1.indexOfColumn("SEQ");			//��γ�
							int colNm_DUDGB	  		= ds1.indexOfColumn("DUDGB");		//�ڵ�          
							int colNm_FINACD     	= ds1.indexOfColumn("FINACD");		//��������ڵ� 
							int colNm_FINANM			= ds1.indexOfColumn("FINANM");		//���������ȣ
							int colNm_ACCNO			= ds1.indexOfColumn("ACCNO");		//���¹�ȣ
							int colNm_YEARLY			= ds1.indexOfColumn("YEARLY");		//���Կ���
							int colNm_PAYAMT     	= ds1.indexOfColumn("PAYAMT");		//���Աݾ�  
							int colNm_DEDAMT     	= ds1.indexOfColumn("DEDAMT");	//�����ݾ�   
							int colNm_STATDT     	= ds1.indexOfColumn("STATDT");		//������
							int colNm_FLAGCOL 		= ds1.indexOfColumn("FLAGCOL");	//�÷��� ��
						
						for(int i=0; i<rows.length; i++){
							job_cd = "1";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:	// �ű����̸�

									job_cd = "1";
									break;
								case GauceDataRow.TB_JOB_DELETE:

									job_cd = "2";
									break;
								case GauceDataRow.TB_JOB_UPDATE:
									String temp1 =rows[i].getString(colNm_FLAGCOL) ;	//��ȸ ���ν������� ������ ���� �÷���
									if("U".equals(temp1)) {	//������Ʈ��..

										job_cd = "3";
									} else {	//���� �μ�Ʈ��;;

										job_cd = "1";
									}
									break;
							} //switch


							cstmt = conn.prepareCall(arr_sql[1].toString());
						
							cstmt.setString( 1,rows[i].getString(colNm_APPYY) );		//�ͼӳ⵵       
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );		//���             
							cstmt.setString( 3,rows[i].getString(colNm_SEQ));			//��γ�          
							cstmt.setString( 4,rows[i].getString(colNm_DUDGB));		//�ڵ�             
							cstmt.setString( 5,rows[i].getString(colNm_FINACD));		//��������ڵ� 
							cstmt.setString( 6,rows[i].getString(colNm_FINANM));		//���������ȣ 
							cstmt.setString( 7,rows[i].getString(colNm_ACCNO));		//���¹�ȣ       
							cstmt.setInt( 8,rows[i].getInt(colNm_YEARLY));				//���Կ���       
							cstmt.setInt( 9,rows[i].getInt(colNm_PAYAMT));				//���Աݾ�       
							cstmt.setInt( 10,rows[i].getInt(colNm_DEDAMT));				//�����ݾ�       
							cstmt.setString( 11,rows[i].getString(colNm_STATDT));	//������          
							cstmt.setString(12,job_cd                           );					//��������1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);		

							cstmt.executeUpdate();

							r_s_yn		= cstmt.getString(13);
							r_msg_cd	= cstmt.getString(14);
							r_msg		= cstmt.getString(15);
							

							if(!r_s_yn.equals("Y"))
								throw new Exception(r_msg);
							
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
								
								ds_result.addDataRow(row1);	
							}
							if(cstmt!=null) cstmt.close();
						}	
					} 					
				}
			}		
		} catch (SQLException sqle){
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
