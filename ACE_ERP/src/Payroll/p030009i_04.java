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

public class p030009i_04 extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// ��������� ���̺�  ���� ��ȸ
		arr_sql[0].append("{CALL PAYROLL.PR_P030009I_04s (?,?,?) }");

		// ����/����
		arr_sql[1].append("{CALL PAYROLL.PR_P030009I_04i (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("START ", "��������", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* �˻��� �ʿ��� ����  --------------------------------------------------------------- */
		String eyy 		        = HDUtil.nullCheckStr(req.getParameter("eyy"));	      // �ͼӳ⵵
		String eno	            = HDUtil.nullCheckStr(req.getParameter("eno"));	      // ��� 
		String eJuno	        = HDUtil.nullCheckStr(req.getParameter("eJuno"));	  // �������ֹ�

		/* �˻��� �ʿ��� ����  --------------------------------------------------------------- */		
		
		/*StringUtil.printMsg("�����eyy: ", eyy, this);		
		StringUtil.printMsg("�����eno: ", eno, this);
		StringUtil.printMsg("�����eName: ", eName, this);
		StringUtil.printMsg("�����eRelation: ", eRelation, this);
		StringUtil.printMsg("�����eJuno: ", eJuno, this);*/
		
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
				//StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
						int colNm_APPDT   		= ds1.indexOfColumn("APPDT");	//�ͼӳ⵵         
						int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");	//���             
						int colNm_FAMNMK		= ds1.indexOfColumn("FAMNMK");  //������� �̸�    
						int colNm_FAMRELA_CD	= ds1.indexOfColumn("FAMRELA_CD");  //������� ���� (MI
						int colNm_FAMJUNO		= ds1.indexOfColumn("FAMJUNO");	//������� �ֹι�ȣ
						int colNm_REF1   		= ds1.indexOfColumn("REF1");	//�ܱ���YN         
						int colNm_REF2   		= ds1.indexOfColumn("REF2");	//100��������YN    
						int colNm_REF3   		= ds1.indexOfColumn("REF3");	//�����YN         
						int colNm_REF4   		= ds1.indexOfColumn("REF4");	//�ڳ�YN           
						int colNm_REF5   		= ds1.indexOfColumn("REF5");	//���YN    
						int colNm_EDU10			= ds1.indexOfColumn("EDU10");	//   ����û��ġ����
						int colNm_EDU11			= ds1.indexOfColumn("EDU11");	//   ����û�ʱ�����
						int colNm_EDU12			= ds1.indexOfColumn("EDU12");	//   ����û�뱳����
						int colNm_EDU13			= ds1.indexOfColumn("EDU13");	//   ����û�屳����
						int colNm_EDU20			= ds1.indexOfColumn("EDU20");	//   ��ġ�����
						int colNm_EDU21			= ds1.indexOfColumn("EDU21");	//   �ʱ������    
						int colNm_EDU22			= ds1.indexOfColumn("EDU22");	//   �뱳�����    
						int colNm_EDU23			= ds1.indexOfColumn("EDU23");	//   �屳�����    
						int colNm_FLAGCOL 		= ds1.indexOfColumn("FLAGCOL");	//�÷��� ��
						
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
									String temp1 =rows[i].getString(colNm_FLAGCOL) ;	//��ȸ ���ν������� ������ ���� �÷���
									if("U".equals(temp1)) {	//������Ʈ��..
										//StringUtil.printMsg("DS TYPE2:::","������",this);
										job_cd = "3";
									} else {	//���� �μ�Ʈ��;;
										//StringUtil.printMsg("DS TYPE2:::","�μ�Ʈ",this);
										job_cd = "1";
									};
									break;
							} //switch
							//StringUtil.printMsg("job_cd: ",job_cd,this);
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
						
							//StringUtil.printMsg("02���� ����", "��������" ,this);
 								
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );//�ͼӳ⵵      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );//���          
							cstmt.setString( 3,rows[i].getString(colNm_FAMNMK) );//������� �̸�              
							cstmt.setInt   ( 4,rows[i].getInt   (colNm_FAMRELA_CD) );//������� ���� (MINOR_CD)   
							cstmt.setString( 5,rows[i].getString(colNm_FAMJUNO) );//������� �ֹι�ȣ       
							cstmt.setString( 6,rows[i].getString(colNm_REF1) );//�ܱ���YN
							cstmt.setString( 7,rows[i].getString(colNm_REF2) );//100��������YN
							cstmt.setString( 8,rows[i].getString(colNm_REF3) );//�����YN
							cstmt.setString( 9,rows[i].getString(colNm_REF4) );//�ڳ�YN
							cstmt.setString(10,rows[i].getString(colNm_REF5) );//���YN
							cstmt.setInt   (11,rows[i].getInt   (colNm_EDU10) );//����û�ʱ�����
							cstmt.setInt   (12,rows[i].getInt   (colNm_EDU11) );//����û�ʱ�����
							cstmt.setInt   (13,rows[i].getInt   (colNm_EDU12) );//����û�뱳����
							cstmt.setInt   (14,rows[i].getInt   (colNm_EDU13) );//����û�屳����
							cstmt.setInt   (15,rows[i].getInt   (colNm_EDU20) );//�ʱ������    
							cstmt.setInt   (16,rows[i].getInt   (colNm_EDU21) );//�ʱ������    
							cstmt.setInt   (17,rows[i].getInt   (colNm_EDU22) );//�뱳�����    
							cstmt.setInt   (18,rows[i].getInt   (colNm_EDU23) );//�屳�����    
							cstmt.setString(19,job_cd                           );	//��������1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);				
							cstmt.executeUpdate();
							
							r_s_yn		= cstmt.getString(20);
							r_msg_cd	= cstmt.getString(21);
							r_msg		= cstmt.getString(22);
							
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
