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

public class p030010i_07 extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// ī��/���� ���̺�  ���� ��ȸ
		arr_sql[0].append("{CALL PAYROLL.PR_P030010I_06s (?,?) }");

		// ����/����
		arr_sql[1].append("{CALL PAYROLL.PR_P030010I_07i (?,?,?,?,?,?,?,?,?,?,  ?,?,?,?,?,?,?,?,?,?) }");
	
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
						
						//StringUtil.printMsg("��ȸ SQL-sdh", arr_sql[0].toString(), this);

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
			String givtype = "";

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				//StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
							int colNm_APPDT   		= ds1.indexOfColumn("APPDT");	//�ͼӳ⵵         
							int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");	//���             
							int colNm_GIVYEAR     	= ds1.indexOfColumn("GIVYEAR");	//��γ�

							int colNm_GIVCOD	  	= ds1.indexOfColumn("GIVCOD");	//�ڵ�          
							int colNm_GIVTYPE     	= ds1.indexOfColumn("GIVTYPE");	//����  
							int colNm_GIVPRCD		= ds1.indexOfColumn("GIVPRCD");//����� ����
							int colNm_GIVPRNM		= ds1.indexOfColumn("GIVPRNM");//����� ����
							int colNm_GIVPRNO		= ds1.indexOfColumn("GIVPRNO");//����� �ֹι�ȣ       
							int colNm_GIVJYO	  		= ds1.indexOfColumn("GIVJYO");	//����          
							int colNm_GIVCOMP     	= ds1.indexOfColumn("GIVCOMP");	//��ȣ          
							int colNm_GIVSAUP     	= ds1.indexOfColumn("GIVSAUP");	//����ڹ�ȣ    
							int colNm_GIVAMT1     	= ds1.indexOfColumn("GIVAMT1");	//�ݾ�-����û   
							int colNm_GIVCNT1     	= ds1.indexOfColumn("GIVCNT1");	//�Ǽ�          
							int colNm_GIVAMT2     	= ds1.indexOfColumn("GIVAMT2");	//�ݾ�-�׹���   
							int colNm_GIVCNT2     	= ds1.indexOfColumn("GIVCNT2");	//�Ǽ�   		

							int colNm_GIVAMT22     	= ds1.indexOfColumn("GIVAMT2");	//�ݾ�-�׹��� ���װ��� ���� 
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
									};
									break;
							} //switch

							
							cstmt = conn.prepareCall(arr_sql[1].toString());

							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );//�ͼӳ⵵      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );//���
							cstmt.setString( 3,rows[i].getString(colNm_GIVYEAR));//��γ��      
							cstmt.setString( 4,rows[i].getString(colNm_GIVCOD));//�ڵ�

							if ("10".equals(rows[i].getString(colNm_GIVCOD))){
								givtype = "������α�";
							}else if ("20".equals(rows[i].getString(colNm_GIVCOD))) {
								givtype = "��ġ�ڱ�";
							}else if ("30".equals(rows[i].getString(colNm_GIVCOD))) {
								givtype = "Ư�ʱ�α�";
							}else if ("31".equals(rows[i].getString(colNm_GIVCOD))) {
								givtype = "���͹��α�ν�Ź��α�";	
							}else if ("40".equals(rows[i].getString(colNm_GIVCOD))) {
								givtype = "������ü��������α�";
							}else if ("41".equals(rows[i].getString(colNm_GIVCOD))) {
								givtype = "������ü������α�";	
							}else if ("42".equals(rows[i].getString(colNm_GIVCOD))) {
								givtype = "�츮��������";									
							};

							cstmt.setString( 5, givtype						  );//����            

							cstmt.setString( 6,rows[i].getString(colNm_GIVPRCD));//����� ����						
							cstmt.setString( 7,rows[i].getString(colNm_GIVPRNM));//����� ����
							cstmt.setString( 8,rows[i].getString(colNm_GIVPRNO));//����� �ֹι�ȣ 
							cstmt.setString( 9,rows[i].getString(colNm_GIVJYO));//����            
							cstmt.setString( 10,rows[i].getString(colNm_GIVCOMP));//��ȣ            
							cstmt.setString( 11,rows[i].getString(colNm_GIVSAUP));//����ڹ�ȣ      
							cstmt.setInt   ( 12,rows[i].getInt   (colNm_GIVAMT1));//�ݾ�-����û     
							cstmt.setInt   (13,rows[i].getInt   (colNm_GIVCNT1));//�Ǽ�            
							cstmt.setInt   (14,rows[i].getInt   (colNm_GIVAMT2));//�ݾ�-�׹���   
							cstmt.setInt   (15,rows[i].getInt   (colNm_GIVCNT2));//�Ǽ�   		

							cstmt.setInt   (16,rows[i].getInt   (colNm_GIVAMT2));//�ݾ�-�׹���   ���װ���
							cstmt.setString(17,job_cd                           );	//��������1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);		
							

	
							cstmt.executeUpdate();


							
							r_s_yn		= cstmt.getString(18);
							r_msg_cd	= cstmt.getString(19);
							r_msg		= cstmt.getString(20);
							
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