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

public class p030009i extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// �⺻���� ���̺�  ���� ��ȸ
		arr_sql[0].append("{CALL PAYROLL.PR_P030009S (?,?) }");

		// ����/����(13��)
		arr_sql[1].append("{CALL PAYROLL.PR_P030009I (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

		// �����ٹ��� ���̺�  ���� ��ȸ
		arr_sql[2].append("{CALL PAYROLL.PR_P030009S1 (?,?) }");

		// �������� ���̺�  ���� ��ȸ
		arr_sql[3].append("{CALL PAYROLL.PR_P030009S2 (?,?) }");
	
		// ��α� ���̺�  ���� ��ȸ
		arr_sql[4].append("{CALL PAYROLL.PR_P030009S3 (?,?) }");
		
		// �������� ���̺�  ���� ����
		arr_sql[5].append("{CALL PAYROLL.PR_P030009I3 (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

        //�������� �ٷμҵ�����Ű� ��¹� ���� Start
		// �������� 
		arr_sql[6].append("{CALL PAYROLL.PR_P030009S10 (?,?) }");

		// �⺻
		arr_sql[7].append("{CALL PAYROLL.PR_P030009S11 (?,?) }");
		//�������� �ٷμҵ�����Ű� ��¹� ���� End

        //��������
        arr_sql[8].append("{CALL PAYROLL.PR_P030009I99 (?,?,?,?,?,?) }");

		//������ȸ
        arr_sql[9].append("{CALL PAYROLL.PR_P030009S99 (?,?) }");
		
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("p030009i.java ", "����", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* �˻��� �ʿ��� ����  --------------------------------------------------------------- */
		String eyy 		        = HDUtil.nullCheckStr(req.getParameter("eyy"));	      // �ͼӳ⵵
		String eno	            = HDUtil.nullCheckStr(req.getParameter("eno"));	      // ��� 
		//String eName	        = HDUtil.nullCheckStr(req.getParameter("eName"));	  // �������̸�
		//int    eRelation	    = HDUtil.nullCheckNum(req.getParameter("eRelation")); // �����ڰ���
		//String eJuno	        = HDUtil.nullCheckStr(req.getParameter("eJuno"));	  // �������ֹ�
		/* �˻��� �ʿ��� ����  --------------------------------------------------------------- */		
		
		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				//StringUtil.printMsg("���콺����", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {	//�⺻���� ��ȸ
						stmt = conn.getGauceStatement(arr_sql[0].toString());							
						//StringUtil.printMsg("��ȸ DS1-sdh", arr_sql[0].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}
					
					if ("DS2".equals(gauceName)) {	//�����ٹ��� ��ȸ
						stmt = conn.getGauceStatement(arr_sql[2].toString());							
						//StringUtil.printMsg("��ȸ DS2-sdh", arr_sql[2].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}
					
					if ("DS3".equals(gauceName)) {	//�����ٹ��� ��ȸ
						stmt = conn.getGauceStatement(arr_sql[3].toString());							
						//StringUtil.printMsg("��ȸ DS3-sdh", arr_sql[3].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}
					

					if ("DS4".equals(gauceName)) {	//��α� ��ȸ
						stmt = conn.getGauceStatement(arr_sql[4].toString());							
						//StringUtil.printMsg("��ȸ DS3-sdh", arr_sql[4].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}


					if ("DS5".equals(gauceName)) {	//�������� �ٷμӵ�����Ű� ��������
						stmt = conn.getGauceStatement(arr_sql[6].toString());							
						//StringUtil.printMsg("��ȸ DS5-jys", arr_sql[6].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					if ("DS6".equals(gauceName)) {	//�������� �ٷμӵ�����Ű�  �⺻
						stmt = conn.getGauceStatement(arr_sql[7].toString());							
						//StringUtil.printMsg("��ȸ DS6-jys", arr_sql[7].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					if ("DS9".equals(gauceName)) {	//�������ⱸ����ȸ
						stmt = conn.getGauceStatement(arr_sql[9].toString());							
						//StringUtil.printMsg("��ȸ DS6-jys", arr_sql[7].toString(), this);

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					rs = stmt.executeQuery();
					getDataSet(rs, ds1).flush();

					if(rs!=null) rs.close();
					if(stmt!=null) stmt.close();
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
				//StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
				
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
						int colNm_APPDT   		= ds1.indexOfColumn("APPDT");	//�ͼӳ⵵         
						int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");	//���             
						int colNm_HOUAMT01	  	= ds1.indexOfColumn("HOUAMT01");	//���ø��������            
						int colNm_HOUAMT02	  	= ds1.indexOfColumn("HOUAMT02");	//�������Աݻ�ȯ            
						int colNm_HOUAMT03	  	= ds1.indexOfColumn("HOUAMT03");	//������������6             
						int colNm_HOUAMT04	  	= ds1.indexOfColumn("HOUAMT04");	//������������10 
						int colNm_HOUAMT05	  	= ds1.indexOfColumn("HOUAMT05");	//������������15  //09.12.23. ���ϳ� �߰�
						int colNm_ETCAMT011A   	= ds1.indexOfColumn("ETCAMT011A");	//���ο���                  
						int colNm_ETCAMT01A	  	= ds1.indexOfColumn("ETCAMT01A");	//��������	                
						int colNm_DEDAMT03	  	= ds1.indexOfColumn("DEDAMT03");	//�������Ա�(���װ���)      
						int colNm_MARCNT01    	= ds1.indexOfColumn("MARCNT01");	//ȥ��Ƚ��                  
						int colNm_MARCNT02	  	= ds1.indexOfColumn("MARCNT02");	//���Ƚ��	                
						int colNm_MARCNT03	  	= ds1.indexOfColumn("MARCNT03");	//�̻�Ƚ��

						//2009.01.06�߰�
						int colNm_FNDAMT01	  	= ds1.indexOfColumn("FNDAMT01");	//����ֽ�������ҵ�1�������Ծ�
						int colNm_FNDAMT02	  	= ds1.indexOfColumn("FNDAMT02");	//����ֽ�������ҵ�2�������Ծ�
						int colNm_FNDAMT03	  	= ds1.indexOfColumn("FNDAMT03");	//����ֽ�������ҵ�3�������Ծ�
						int colNm_ETCAMT05	  	= ds1.indexOfColumn("ETCAMT05");	//��������


						for(int i=0; i<rows.length; i++){
							job_cd = "1";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:	// �ű����̸�
									//StringUtil.printMsg("DS TYPE:::","�μ�Ʈ",this);
									job_cd = "1";
									break;
								case GauceDataRow.TB_JOB_DELETE:
									//StringUtil.printMsg("DS TYPE:::","����Ʈ",this);
									job_cd = "2";
									break;
								case GauceDataRow.TB_JOB_UPDATE:
									//StringUtil.printMsg("DS TYPE2:::","������",this);
									job_cd = "3";
									break;
							} //switch
							//StringUtil.printMsg("job_cd: ",job_cd,this);
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
						
							//StringUtil.printMsg("01�⺻����", "ļļ" ,this);
 								
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );//�ͼӳ⵵      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );//���
							cstmt.setInt   ( 3,rows[i].getInt   (colNm_HOUAMT01	   ) );//���ø��������           
							cstmt.setInt   ( 4,rows[i].getInt   (colNm_HOUAMT02	   ) );//�������Աݻ�ȯ           
							cstmt.setInt   ( 5,rows[i].getInt   (colNm_HOUAMT03	   ) );//������������6            
							cstmt.setInt   ( 6,rows[i].getInt   (colNm_HOUAMT04	   ) );//������������10 
							cstmt.setInt   ( 7,rows[i].getInt   (colNm_HOUAMT05	   ) );//������������15  							
							cstmt.setInt   ( 8,rows[i].getInt   (colNm_ETCAMT011A   ) );//���ο���                 
							cstmt.setInt   ( 9,rows[i].getInt   (colNm_ETCAMT01A	   ) );//��������	              
							cstmt.setInt   ( 10,rows[i].getInt   (colNm_DEDAMT03	   ) );//�������Ա�(���װ���)     
							cstmt.setInt   ( 11,rows[i].getInt   (colNm_MARCNT01	   ) );//ȥ��Ƚ��    
							cstmt.setInt   ( 12,rows[i].getInt   (colNm_MARCNT02	   ) );//���Ƚ��    
							cstmt.setInt   ( 13,rows[i].getInt   (colNm_MARCNT03	   ) );//�̻�Ƚ��    
                            //2009.01.06�߰�
							cstmt.setInt   ( 14,rows[i].getInt   (colNm_FNDAMT01	   ) );//����ֽ�������ҵ�1�������Ծ�  
							cstmt.setInt   ( 15,rows[i].getInt   (colNm_FNDAMT02	   ) );//����ֽ�������ҵ�2�������Ծ�  
							cstmt.setInt   ( 16,rows[i].getInt   (colNm_FNDAMT03	   ) );//����ֽ�������ҵ�3�������Ծ�  
							cstmt.setInt   ( 17,rows[i].getInt   (colNm_ETCAMT05	   ) );//��������


							cstmt.setString(18,job_cd                           );	//��������1: INSERT, 2: DELETE, 3: UPDATE
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

					if ("DS3".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
						int colNm_APPDT   		= ds1.indexOfColumn("APPDT");	//�ͼӳ⵵         
						int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");	//���
						int colNm_RELAT1	  	= ds1.indexOfColumn("RELAT1");	//'����'		
						int colNm_FAMNM1	 	= ds1.indexOfColumn("FAMNM1");	//'����'		
						int colNm_REF1	      	= ds1.indexOfColumn("REF1");	//'�ܱ���'	    
						int colNm_RESINO1    	= ds1.indexOfColumn("RESINO1");	//'�ֹι�ȣ'	
						int colNm_REF2	      	= ds1.indexOfColumn("REF2");	//'100��'	    
						int colNm_REF3	     	= ds1.indexOfColumn("REF3");	//'�����'	    
						int colNm_REF4	      	= ds1.indexOfColumn("REF4");	//'�ڳ�'		
						int colNm_REF5	     	= ds1.indexOfColumn("REF5");	//'���'		
						int colNm_REF6	     	= ds1.indexOfColumn("REF6");	//'�γ���'
						int colNm_REF7	     	= ds1.indexOfColumn("REF7");	//'���ڳ�YN'
						int colNm_REF8	     	= ds1.indexOfColumn("REF8");	//'����Ծ�' 2008.12.29 �߰�

						for(int i=0; i<rows.length; i++){
							job_cd = "1";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:	// �ű����̸�
									//StringUtil.printMsg("DS TYPE:::","�μ�Ʈ",this);
									job_cd = "1";
									break;
								case GauceDataRow.TB_JOB_DELETE:
									//StringUtil.printMsg("DS TYPE:::","����Ʈ",this);
									job_cd = "2";
									break;
								case GauceDataRow.TB_JOB_UPDATE:
									//StringUtil.printMsg("DS TYPE2:::","������",this);
									job_cd = "3";
									break;
							} //switch
							//StringUtil.printMsg("job_cd: ",job_cd,this);
							
							cstmt = conn.prepareCall(arr_sql[5].toString());
												
							//StringUtil.printMsg("ds3 ������������", "��������" ,this);
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );//�ͼӳ⵵      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );//���          
							cstmt.setString( 3,rows[i].getString(colNm_FAMNM1) );//'����'
							cstmt.setInt   ( 4,rows[i].getInt   (colNm_RELAT1) );//'����'	
							cstmt.setString( 5,rows[i].getString(colNm_RESINO1) );//'�ֹι�ȣ'	
							cstmt.setString( 6,rows[i].getString(colNm_REF1) );//'�ܱ���'	
							cstmt.setString( 7,rows[i].getString(colNm_REF2) );//'100��'	
							cstmt.setString( 8,rows[i].getString(colNm_REF3) );//'�����'	
							cstmt.setString( 9,rows[i].getString(colNm_REF4) );//'�ڳ�'	
							cstmt.setString(10,rows[i].getString(colNm_REF5) );//'���'
							cstmt.setString(11,rows[i].getString(colNm_REF6) );//'�γ���
							cstmt.setString(12,rows[i].getString(colNm_REF7) );//'���ڳ�YN'
							cstmt.setString(13,rows[i].getString(colNm_REF8) );//'����Ծ�'
							cstmt.setString(14,job_cd                             );//��������1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	
								
							cstmt.executeUpdate();
							
							r_s_yn		= cstmt.getString(15);
							r_msg_cd	= cstmt.getString(16);
							r_msg		= cstmt.getString(17);
							
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
					}; 	//if ("DS3".equals(gauceName)) {

          if ("DS7".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] cols = ds1.getDataColumns();
					
						int colNm_APPDT   	= ds1.indexOfColumn("APPDT");	//�ͼӳ⵵         
						int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");	//���
						
						for(int i=0; i<rows.length; i++){
							job_cd = "3"; //�׻� ������Ʈ
							cstmt = conn.prepareCall(arr_sql[8].toString());
												
							//StringUtil.printMsg("ds7 ��������", "������Ʈ" ,this);
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );//�ͼӳ⵵      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );//���          
							cstmt.setString( 3,job_cd                             );//��������1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	
								
							cstmt.executeUpdate();
							
							r_s_yn		= cstmt.getString(4);
							r_msg_cd	= cstmt.getString(5);
							r_msg		= cstmt.getString(6);
							
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
					}; 	//if ("DS3".equals(gauceName)) {					
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
