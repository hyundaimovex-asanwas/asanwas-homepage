package Account.menu.tp;
//
//20160421	�ɵ���	ã���� �ݾ� �÷� ���� ���ص� ���ε�ǰ� �÷� ����
//					�׼��� �ݾ׶� , �� ���ڿ��̾ ġȯ�ϰ� ����
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;

import javax.servlet.ServletException;

import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;

import sales.common.HDConstant;		//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.HDUtil;			//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.StringUtil;		//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.SuperServlet;	//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿�(import)�ϴ� �ɷ�
public class Tp010I extends SuperServlet {
	private static final long serialVersionUID = 1L;
	private String fExcelFilePath = "";
	public void makeSql() {

		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_AC080I_01(?,?,?,?, ?)");	// ��ȸ
		arr_sql[2].append("CALL SALES.PR_AC080I_02(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,   ?,?,? )");	// ����
		
	}

	
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;


		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            	
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:EXCELDS=tempExcelDs
            	if(dSets[i].getName().equals("tempExcelDs")){
					GauceDataSet ds1 = gis.read("EXCELDS");

					ds1.addDataColumn(new GauceDataColumn("EXCEL_INFO", GauceDataColumn.TB_STRING));
					ds1.addDataColumn(new GauceDataColumn("EXCEL_URL", GauceDataColumn.TB_URL, 1024));
					gos.write(ds1);
				}
			}
            gos.close();
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
	}

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("============================", "", this);
		/* 2014.01.12 �ɵ���
		 * ����� �׼��� �ε��ϴ� ȭ���̹Ƿ� 
		 * 	���� ���ε�, �����б�, db���� ��ȸ�ϱ� 3������ ������.
		 * 
		 * */
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();		
		
		
		/* DataSet I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs,O:MAIN_DS=excelDs */
		GauceDataSet ds1 		= gis.read("MAIN_DS");		//������ȸ
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//��������; 
		GauceDataSet ds2 		= gis.read("EXCELDS"); 		//��������;
		GauceDataSet ds_result 	= gis.read("RESULT");

		if(ds_result!=null){
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		try {
			String sBgnDate = HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String sEndDate = HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String sAcctGu  = HDUtil.nullCheckStr(greq.getParameter("sAcctGu"));
			String sTr_Sum  = HDUtil.nullCheckStr(greq.getParameter("sTr_Sum"));
			
			
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput();

            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		

				//��ȸ;            	//O:MAIN_DS=excelDs
				if (ds1 != null) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					/*StringUtil.printMsg("�Ϲ� ��ȸ ",this);
					StringUtil.printMsg("������  ",arr_sql[1].toString(),this);
					StringUtil.printMsg("�ŷ����� ����== ",sBgnDate,this);
					StringUtil.printMsg("�ŷ����� ��   == ",sEndDate,this);
					StringUtil.printMsg("�����ڵ�   == ",sAcctGu,this);
					StringUtil.printMsg("����   == ",sTr_Sum,this);*/
					cstmt.setString(1,sBgnDate );
					cstmt.setString(2,sEndDate );
					cstmt.setString(3,sAcctGu );
					cstmt.setString(4,sTr_Sum );
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
				
            	//�׼����� JSP (I:TEMP_EXCEL=tempExcelDs)
    			// ���� ���ε� 
				if (excelDs != null) {
					GauceDataRow[] 		excelRow = excelDs.getDataRows();
					GauceDataColumn[] 	excelCol = excelDs.getDataColumns();
					
					int data_name = excelDs.indexOfColumn("EXCEL_INFO");
					int data_url  = excelDs.indexOfColumn("EXCEL_URL");
					//StringUtil.printMsg("data_name==",data_name, this);
					//StringUtil.printMsg("data_url==",data_url, this);
					
					String d_name = excelRow[0].getString(data_name);
					String o_name = excelRow[0].getString(0).trim();
					
					o_name = System.currentTimeMillis()+".xls";
					//StringUtil.printMsg("���� �������ϸ�:",o_name, this);
					
					//fExcelFilePath = "d:/myWorks/HDAsan/WebContent/Sales/file/excel/acct/" + o_name;//���ÿ�
					fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;	//������

					//StringUtil.printMsg("���� �������� ���:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}				

				// ���� �о �׸���� �Ѹ��� O:EXCELDS=excelDs
				if (ds2 != null) {
					//gres.enableFirstRow(ds2);
					
					//StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�
					
					Sheet sheet0 = workbook.getSheet("Sheet"); // Sheet�� : Sheet�� ����160421 

					//StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][60];	//�迭��ü�� ��Ʈ���̳׿�..
					
					for (int row = 0; row < sheet0.getRows(); row++) {	

						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							//StringUtil.printMsg("�׼� �� Ÿ�� ==",sheet0.getCell(column,row).getType().toString(), this);

							// ����Ÿ��							
							if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
								NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
								content = numberCell.getValue()+""; 
								//StringUtil.printMsg("�׼���Ʈ ����==","row="+row+"::column="+column+"::��="+content, this);
								arr[row][column+1] = content;
							// ����Ÿ��		
							} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
								LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
								content = labelCell.getContents();
								//StringUtil.printMsg("�׼���Ʈ ����==","row="+row+"::column="+column+"::��="+content, this);
								arr[row][column+1] = content;
							// ��¥ Ÿ�� 		
							} else if(sheet0.getCell(column,row).getType() == CellType.DATE)	{
								DateCell dateCell = (DateCell) sheet0.getCell(column,row);
								content = dateCell.getDate()+"";
								//StringUtil.printMsg("�׼���Ʈ ��¥==","row="+row+"::column="+column+"::��="+content, this);
								arr[row][column+1] = content;
							} 
							//���⼭�� �Ҽ��� �� ������ �ɴϴ�. 2011-03-02
						}
					}
							
					/*
					 * DataSet Header
					 */
					ds2.addDataColumn(new GauceDataColumn("COL01",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL02",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL03",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL04",    GauceDataColumn.TB_DECIMAL, 10)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL05",    GauceDataColumn.TB_DECIMAL, 10)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL06",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("TR_SID",	  GauceDataColumn.TB_DECIMAL, 10)); 
					ds2.addDataColumn(new GauceDataColumn("TR_ACCT_CD",	GauceDataColumn.TB_STRING, 2 ));
					ds2.addDataColumn(new GauceDataColumn("VEND_NM",	GauceDataColumn.TB_STRING, 62 ));
					ds2.addDataColumn(new GauceDataColumn("VEND_CD",	GauceDataColumn.TB_STRING, 13 ));
					
					/*
					 * temp�� �ִ� �ҷ��� �����͸� ds2�� �Ѹ��� �κ�
					 * 
					 * 20160421	�ɵ���
					 * 0�� = �������̴� 1����� ���� ����
					 * �������� = �հ����̴� �����ϱ� 
					 */
					for (int row = 1; row < sheet0.getRows()-1; row++) {
						GauceDataRow gRow = ds2.newDataRow();
						//StringUtil.printMsg("����ȯ===",arr[row][4],this);
						////StringUtil.printMsg("����ȯ===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("�����ڵ�   == ",sAcctGu,this);
						gRow.addColumnValue(arr[row][1]);	//�ٿ�ε� ������ �ŷ�����
						gRow.addColumnValue(arr[row][2]);	// �ŷ�����
						gRow.addColumnValue(arr[row][3]);	//����
						gRow.addColumnValue(Double.parseDouble(arr[row][5].replaceAll(",", "")));	//number	�ñ�� �ݾ�
						gRow.addColumnValue(Double.parseDouble(arr[row][6].replaceAll(",", "")));	//number	���� �ݾ�
						gRow.addColumnValue(arr[row][7]);	//�����
						gRow.addColumnValue(111); 		// TR_SID �÷� : �⺻�� ���� 1�� �� �Ŀ� ȭ�鿡�� 0���� ���� (���� �Է½�)
						gRow.addColumnValue(sAcctGu);	// �����ڵ� �÷�
						gRow.addColumnValue("");	// �ŷ�ó��
						gRow.addColumnValue("");	// �ŷ�ó�ڵ�
						
						//StringUtil.printMsg("�ŷ����� == ",arr[row][2],this);
						// �ŷ������� ��ü�� ��� �ε����� ����	20160422 �ɵ���
						if(!arr[row][2].equals("��ü") ){
							ds2.addDataRow(gRow);
						}
					}
					//StringUtil.printMsg("ī��Ʈ == " , ds2.getDataRowCnt(), this);
					
					gos.write(ds2);	//3.x������ ds2.flush()�� �ش�
					
					//StringUtil.printMsg("���� ������",this);
					deleteExcelFile(fExcelFilePath);
				}            
            
            }
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* 2013.10.22 �ɵ���
		 * �̷��� TR�� ȣ���մϴ�. 
		 * 		 * JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)"
		 * 	���� gis.read�� �������� ��.
		 * 
		 * 2015.06.03 �ɵ���
		 * �ŷ�ó �÷��� �߰� ������ �� �ְ� ����
		 * */
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet I:EXCELDS=excelDs,O:RESULT=ds_result */
		GauceDataSet ds_xls 	= gis.read("EXCELDS");
		GauceDataSet ds_result	= gis.read("RESULT");
		
		
		String uploadType = "1";
		String v_edit_styatus = "";										//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
		try {
			
			if (ds_xls != null) {
				
				GauceDataRow[] 		rows = ds_xls.getDataRows();
				GauceDataColumn[] 	cols = ds_xls.getDataColumns();
						
				//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				
				int colNm_Col01	  = ds_xls.indexOfColumn("COL01");
				int colNm_Col02	  = ds_xls.indexOfColumn("COL02");
				int colNm_Col03	  = ds_xls.indexOfColumn("COL03");	//����
				int colNm_Col04	  = ds_xls.indexOfColumn("COL04");
				int colNm_Col05	  = ds_xls.indexOfColumn("COL05");
				int colNm_Col06	  = ds_xls.indexOfColumn("COL06");
				int colNm_TR_SID  = ds_xls.indexOfColumn("TR_SID");
				int colNm_TR_ACCT_CD = ds_xls.indexOfColumn("TR_ACCT_CD");
				int colNm_VEND_CD = ds_xls.indexOfColumn("VEND_CD"); //�ŷ�ó�ڵ�
				int colNm_VEND_NM = ds_xls.indexOfColumn("VEND_NM");	//�ŷ�ó��
				
				
				
				
												
				for(int i=0; i<rows.length; i++){
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
					} 
					
					//StringUtil.printMsg("INSERT "+i+"�� ========================",this);
					//StringUtil.printMsg("EDIT_STATUS �� == ", v_edit_styatus,this);	//���ν��� �������� ��.
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					//StringUtil.printMsg("INSERT 0= ",rows[i].getInt(colNm_TR_SID),this);	//�Ϸù�ȣ
					//StringUtil.printMsg("INSERT 1= ",rows[i].getString(colNm_Col01),this);	//�ŷ��Ͻ� (���࿡�� ����)
					//StringUtil.printMsg("INSERT 2= ",rows[i].getString(colNm_Col02),this);
					//StringUtil.printMsg("INSERT 3= ",rows[i].getString(colNm_Col03),this);
					//StringUtil.printMsg("INSERT 4= ",rows[i].getString(colNm_Col04),this);
					//StringUtil.printMsg("INSERT 5= ",rows[i].getString(colNm_Col05),this);
					//StringUtil.printMsg("INSERT 6= ",rows[i].getString(colNm_Col06),this);
					//StringUtil.printMsg("INSERT 7= ","***"+rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/","")+"***",this);	//�ŷ�����
					//StringUtil.printMsg("INSERT 8= ","***"+rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":","")+"***",this);	//�ŷ��ð�
					//StringUtil.printMsg("================ �� ===============",this);
					
					cstmt.setInt(1, rows[i].getInt(colNm_TR_SID));
					cstmt.setString(2, rows[i].getString(colNm_Col01));
					cstmt.setString(3, rows[i].getString(colNm_Col02));
					cstmt.setString(4, HDUtil.nullCheckStr(rows[i].getString(colNm_Col03)) );//���䰡 ��ĭ�� ���=��ü
					cstmt.setInt(5, rows[i].getInt(colNm_Col04));
					cstmt.setInt(6, rows[i].getInt(colNm_Col05));
					cstmt.setString(7, rows[i].getString(colNm_Col06));
					//cstmt.setString(8, rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/",""));
					cstmt.setString(8, rows[i].getString(colNm_Col01).substring(0,4)+rows[i].getString(colNm_Col01).substring(5,7)+rows[i].getString(colNm_Col01).substring(8,10) );
					//cstmt.setString(9, rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":",""));
					cstmt.setString(9, rows[i].getString(colNm_Col01).substring(11,13)+rows[i].getString(colNm_Col01).substring(14,16) );
					cstmt.setString(10, rows[i].getString(colNm_TR_ACCT_CD));
					cstmt.setString(11, rows[i].getString(colNm_VEND_CD));
					cstmt.setString(12, rows[i].getString(colNm_VEND_NM));
					cstmt.setString(13, fParamEmpno);
					cstmt.setString(14, fParamIp);
					cstmt.setString(15, v_edit_styatus);
					
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
					// ��������
					cstmt.executeUpdate();
				}
			}
			gos.close();
		}catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	
	/*
	 * ���ϻ���
	 */
	private void deleteExcelFile(String filePath) {
		File target = new File(filePath);
		try {
	        if (!target.exists()) {
	                //System.err.println(filePath + " �������� �ʽ��ϴ�...");
	                return;
	        }
	
	        // ������ �մϴ�... Ȥ�� �÷����� ���� 
	        //�۹̼� ����(SecurityException)�� ���� �� �ֽ��ϴ�....
	        if (target.delete()) {
	                //System.err.println("** Deleted " + filePath + " **");
	        } else {
	                //System.err.println("Failed to delete " + filePath);
	        }
		} catch (SecurityException e) {        
			System.err.println("Unable to delete " + filePath +"(" + e.getMessage() + ")");
		}

	}	
}
