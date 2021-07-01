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

public class p030010i_03 extends SuperServlet {
	
	public void makeSql() {

		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// �Ƿ�� ���̺�  ���� ��ȸ
		arr_sql[0].append("{CALL PAYROLL.PR_P030010I_03S (?,?,?) }");

		// ����/����
		arr_sql[1].append("{CALL PAYROLL.PR_P030010I_03I (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("START ", "����", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* �˻��� �ʿ��� ����  --------------------------------------------------------------- */
		String eyy 		    = HDUtil.nullCheckStr(req.getParameter("eyy"));	      // �ͼӳ⵵
		String eno	            = HDUtil.nullCheckStr(req.getParameter("eno"));	      // ��� 
		String eJuno	        = HDUtil.nullCheckStr(req.getParameter("eJuno"));	  // �������ֹ�
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
						//StringUtil.printMsg("��ȸ SQL-sdh", arr_sql[0].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
                        stmt.setString(3, eJuno	    );

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
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 	rows		= ds1.getDataRows();
						GauceDataColumn[] 	cols	= ds1.getDataColumns();
						int colNm_APPDT   			= ds1.indexOfColumn("APPDT");			//�ͼӳ⵵         
						int colNm_EMPNO  			= ds1.indexOfColumn("EMPNO");			//���             
						int colNm_FAMNMK			= ds1.indexOfColumn("FAMNMK");		//������� �̸�    
						int colNm_FAMRELA_CD	= ds1.indexOfColumn("FAMRELA_CD");  //������� ���� (MI
						int colNm_FAMJUNO			= ds1.indexOfColumn("FAMJUNO");		//������� �ֹι�ȣ
						int colNm_REF1   				= ds1.indexOfColumn("REF1");				//�ܱ���YN         
						int colNm_REF2   				= ds1.indexOfColumn("REF2");				//100��������YN    
						int colNm_REF3   				= ds1.indexOfColumn("REF3");				//�����YN         
						int colNm_REF4   				= ds1.indexOfColumn("REF4");				//�ڳ�YN           
						int colNm_REF5   				= ds1.indexOfColumn("REF5");				//���YN    
						int colNm_INDNO				= ds1.indexOfColumn("INDNO");			//����ڵ�Ϲ�ȣ	 
						int colNm_INDNAME			= ds1.indexOfColumn("INDNAME");		//�Ƿ�����	

						int colNm_CASHCNTA	  	= ds1.indexOfColumn("CASHCNTA");	//����û���ݰǼ�	  
						int colNm_CASHAMTA	  	= ds1.indexOfColumn("CASHAMTA");	//����û����	      
     
						int colNm_CASHCNTB	  	= ds1.indexOfColumn("CASHCNTB");	//���ݰǼ���	      
						int colNm_CASHAMTB	  	= ds1.indexOfColumn("CASHAMTB");	//���ݿ�

						int colNm_PRFCD 				= ds1.indexOfColumn("PRFCD");			//�Ƿ�������ڵ�
						int colNm_FLAGCOL 			= ds1.indexOfColumn("FLAGCOL");		//�÷��� �÷�
						
						
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
									};
									break;
							} //switch

							
							cstmt = conn.prepareCall(arr_sql[1].toString());
						

 								
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );			//�ͼӳ⵵      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );			//���          
							cstmt.setString( 3,rows[i].getString(colNm_FAMNMK) );		//������� �̸�              
							cstmt.setInt   ( 4,rows[i].getInt   (colNm_FAMRELA_CD) );	//������� ���� (MINOR_CD)   
							cstmt.setString( 5,rows[i].getString(colNm_FAMJUNO) );		//������� �ֹι�ȣ       
							cstmt.setString( 6,rows[i].getString(colNm_REF1) );				//�ܱ���YN
							cstmt.setString( 7,rows[i].getString(colNm_REF2) );				//100��������YN
							cstmt.setString( 8,rows[i].getString(colNm_REF3) );				//�����YN
							cstmt.setString( 9,rows[i].getString(colNm_REF4) );				//�ڳ�YN
							cstmt.setString(10,rows[i].getString(colNm_REF5) );			//���YN
							cstmt.setString(11,rows[i].getString(colNm_INDNO	)  );		//����ڵ�Ϲ�ȣ	 
							cstmt.setString(12,rows[i].getString(colNm_INDNAME	)  );  //�Ƿ�����	

							cstmt.setInt   (13,rows[i].getInt    (colNm_CASHCNTA)  );		//����û���ݰǼ�	  
							cstmt.setInt   (14,rows[i].getInt    (colNm_CASHAMTA)  );	//����û����	      
  
							cstmt.setInt   (15,rows[i].getInt    (colNm_CASHCNTB)  );		//���ݰǼ���	      
							cstmt.setInt   (16,rows[i].getInt    (colNm_CASHAMTB)  );	//���ݿ�

							cstmt.setString(17,rows[i].getString(colNm_PRFCD)  );			//�Ƿ�������ڵ�	
							cstmt.setString(18,job_cd                           );						//��������1: INSERT, 2: DELETE, 3: UPDATE

							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);	
							

							cstmt.executeUpdate();
						
							r_s_yn		= cstmt.getString(19);
							r_msg_cd	= cstmt.getString(20);
							r_msg		= cstmt.getString(21);
							
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
						};	//for(int i=0; i<rows.length; i++){
					}; 	//if ("DS1".equals(gauceName)) {					
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
