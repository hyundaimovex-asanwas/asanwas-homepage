package sales.menu.rv;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;

import sales.common.HDConstant;
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

public class Rv250B extends SuperServlet {
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		 
		arr_sql[1].append("CALL SALES.PR_RV250B_01(?,?)");	// ��ȸ
		
		arr_sql[2].append("CALL SALES.PR_RV250B_02(" +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?" +
				")");	// ����
		
		arr_sql[3].append("CALL SALES.PR_RV250B_03(?,?,?,?,?,?,?,?)"); // �ڷ�Ȯ��
		
		arr_sql[4].append("CALL SALES.PR_RV250B_04(?,?,?,?,?,?,?,?)"); // �ڷ��̰�
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
		
		System.out.println("# Command : ����ȸ");

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							
							if(gauceName.equals("EXCELDS")){
								ds1.addDataColumn(new GauceDataColumn("EXCEL_INFO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("EXCEL_URL", GauceDataColumn.TB_URL, 1024));
							}
							if(!gauceName.equals("EXCELDS")){
								rs = stmt.executeQuery(); // DataSet set
								rsmd = rs.getMetaData();
								columnName = new String[rsmd.getColumnCount()];
								for(int i=0; i<columnName.length; i++){
									columnName[i] = rsmd.getColumnName(i+1);
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
									else
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
								}
							}

							ds1.flush();
							break;
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}		
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

StringUtil.printMsg("============================", "", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		ResultSetMetaData rsmd = null;
		
		String[] 			columnName 	= null;
		
		/* DataSet */
		GauceDataSet excelDs = req.getGauceDataSet("TEMP_EXCEL");//��������; 
		GauceDataSet ds2 = req.getGauceDataSet("EXCELDS"); //��������;
		GauceDataSet ds3 = req.getGauceDataSet("MAIN_DS"); //��ȸ;
		
		GauceDataSet ds03 = req.getGauceDataSet("DS03"); // �ڷ��̰� 
		GauceDataSet ds04 = req.getGauceDataSet("DS04"); // �ڷ��̰�
		
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");
		
		if(ds_result!=null){
			res.enableFirstRow(ds_result);
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid")); 
		try {
				
			// ���� ���ε� 
				if (excelDs != null) {
						
//					GauceDataSet excelDs = req.getGauceDataSet("TEMP_EXCEL");
					GauceDataRow[] 		excelRow = excelDs.getDataRows();
					GauceDataColumn[] 	excelCol = excelDs.getDataColumns();
					
					int data_name = excelDs.indexOfColumn("EXCEL_INFO");
					int data_url  = excelDs.indexOfColumn("EXCEL_URL");
					
					String d_name = excelRow[0].getString(data_name);
					
					String o_name = excelRow[0].getString(0).trim();
					
					o_name = System.currentTimeMillis()+".xls";
					fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;
					
					StringUtil.printMsg("���� �������� ���:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}
				
				// ���� �б�
				if (ds2 != null) {
					res.enableFirstRow(ds2);
					
					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�
					
					Sheet sheet0 = workbook.getSheet("Sheet1"); // Sheet�� 
					
					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][60];
					
					for (int row = 0; row < sheet0.getRows(); row++) {	
						 
						// ����Ÿ��
						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							
							if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
								
								NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
								content = numberCell.getValue()+""; 
								
								arr[row][column+1] = content;
						// ����Ÿ��		
							} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
						
								LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
								content = labelCell.getString()+"";
								
								arr[row][column+1] = content;
						// ���� Ÿ�� 		
							} else if(sheet0.getCell(column,row).getType() == CellType.DATE)	{
							
								DateCell dateCell = (DateCell) sheet0.getCell(column,row);
								content = dateCell.getDate()+"";
								
								arr[row][column+1] = content;
							} 
						}
						
					}
							
					/*
					 * DataSet Header
					 */
					
					ds2.addDataColumn(new GauceDataColumn("UPLOAD_MSG",      GauceDataColumn.TB_STRING, 5)); // 0
					ds2.addDataColumn(new GauceDataColumn("SEQ",      	GauceDataColumn.TB_STRING, 10));  // 1
					ds2.addDataColumn(new GauceDataColumn("COL01",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL02",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL03",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL04",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL05",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL06",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL07",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL08",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL09",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL10",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL11",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL12",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL13",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL14",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL15",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL16",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("YN",			  GauceDataColumn.TB_STRING, 10)); 
					/*
					 * ������ �����Ͱ� �ִ� ������ �о �� �ʵ��� ���� üũ�� �Ѵ� 
					 * ����üũ�� �ϱ�鼭 ������ �ִ°�쿡�� ȭ�鿡 ������ ǥ�ø� ���ش� 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							StringUtil.printMsg("����Ÿ",arr[row][column], this);
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // �б� ����, ���� �÷��׷� ���
						ds2.addDataRow(gRow);
					}
					
					StringUtil.printMsg("ī��Ʈ == " , ds2.getDataRowCnt(), this);
					ds2.flush();
					
					
					StringUtil.printMsg("���� ������",this);
					deleteExcelFile(fExcelFilePath);
				}
						
				if (ds3 != null) {
					res.enableFirstRow(ds3);
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					StringUtil.printMsg("�Ϲ� ��ȸ ",this);
					StringUtil.printMsg("����ó ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"2" );
					rs = cstmt.executeQuery();							
					
					getDataSet(rs,ds3).flush();
					
				}
				
				
				
				if (ds03 != null) {
					res.enableFirstRow(ds03);
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					StringUtil.printMsg("�ڷ�Ȯ�� ",this);
					StringUtil.printMsg("sClientSid ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"2" );
					cstmt.setString(3, fParamEmpno);
					cstmt.setString(4, fParamIp);
					cstmt.setString(5, "3");
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
					cstmt.executeUpdate();		
					
					if(!cstmt.getString(6).equals("Y"))
						throw new Exception (cstmt.getString(8));
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(6));
						row1.addColumnValue(cstmt.getString(7));
						row1.addColumnValue(cstmt.getString(8));
						
						ds_result.addDataRow(row1);
					}
				}

				if (ds04 != null) {
					res.enableFirstRow(ds04);
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					StringUtil.printMsg("�ڷ��̰� ",this);
					StringUtil.printMsg("sClientSid ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"2" );
					cstmt.setString(3, fParamEmpno);
					cstmt.setString(4, fParamIp);
					cstmt.setString(5, "3");
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
					cstmt.executeUpdate();		
					
					if(!cstmt.getString(6).equals("Y"))
						throw new Exception (cstmt.getString(8));
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(6));
						row1.addColumnValue(cstmt.getString(7));
						row1.addColumnValue(cstmt.getString(8));
						
						ds_result.addDataRow(row1);
					}
					
				}
				if(ds_result!=null) ds_result.flush();
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
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
		GauceDataSet ds1 = null; 
		
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid"));
		String uploadType = "2";
		String v_edit_styatus = "";										//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
		try {
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("EXCELDS".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						int colNm_Seq      = ds1.indexOfColumn("SEQ");
						int colNm_Col01	  = ds1.indexOfColumn("COL01");
						int colNm_Col02	  = ds1.indexOfColumn("COL02");
						int colNm_Col03	  = ds1.indexOfColumn("COL03");
						int colNm_Col04	  = ds1.indexOfColumn("COL04");
						int colNm_Col05	  = ds1.indexOfColumn("COL05");
						int colNm_Col06	  = ds1.indexOfColumn("COL06");
						int colNm_Col07	  = ds1.indexOfColumn("COL07");
						int colNm_Col08	  = ds1.indexOfColumn("COL08");
						int colNm_Col09	  = ds1.indexOfColumn("COL09");
						int colNm_Col10	  = ds1.indexOfColumn("COL10");
						int colNm_Col11	  = ds1.indexOfColumn("COL11");
						int colNm_Col12	  = ds1.indexOfColumn("COL12");
						int colNm_Col13	  = ds1.indexOfColumn("COL13");
						int colNm_Col14	  = ds1.indexOfColumn("COL14");
						int colNm_Col15	  = ds1.indexOfColumn("COL15");
						int colNm_Col16	  = ds1.indexOfColumn("COL16");
						
						
						for(int i=0; i<rows.length; i++){
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
								v_edit_styatus = "1";
							} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
								v_edit_styatus = "2";
							} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
								v_edit_styatus = "3";
								
							}
						
								StringUtil.printMsg("INSERT",this);
								cstmt = conn.prepareCall(arr_sql[2].toString());
								
								cstmt.setInt(1, sClientSid);
								cstmt.setString(2, uploadType);
								
								cstmt.setString(3, rows[i].getString(colNm_Seq));
								cstmt.setString(4, rows[i].getString(colNm_Col01));
								cstmt.setString(5, rows[i].getString(colNm_Col02));
								cstmt.setString(6, rows[i].getString(colNm_Col03));
								cstmt.setString(7, rows[i].getString(colNm_Col04));
								
								cstmt.setString(8, rows[i].getString(colNm_Col05));
								cstmt.setString(9, rows[i].getString(colNm_Col06));
								cstmt.setString(10, rows[i].getString(colNm_Col07));
								cstmt.setString(11, rows[i].getString(colNm_Col08));
								cstmt.setString(12, rows[i].getString(colNm_Col09));
								
								cstmt.setString(13, rows[i].getString(colNm_Col10));
								cstmt.setString(14, rows[i].getString(colNm_Col11));
								cstmt.setString(15, rows[i].getString(colNm_Col12));
								cstmt.setString(16, rows[i].getString(colNm_Col13));
								cstmt.setString(17, rows[i].getString(colNm_Col14));
								
								cstmt.setString(18, rows[i].getString(colNm_Col15));
								cstmt.setString(19, rows[i].getString(colNm_Col16));
								
								cstmt.setString(20, "");
								cstmt.setString(21, "");
								cstmt.setString(22, "");
								cstmt.setString(23, "");
								cstmt.setString(24, "");
								cstmt.setString(25, "");
								cstmt.setString(26, "");
								cstmt.setString(27, "");
								cstmt.setString(28, "");
								cstmt.setString(29, "");
								cstmt.setString(30, "");
								cstmt.setString(31, "");
								cstmt.setString(32, "");
								cstmt.setString(33, "");
								
								cstmt.setString(34, fParamEmpno);
								cstmt.setString(35, fParamIp);
								cstmt.setString(36, v_edit_styatus);
								
								cstmt.registerOutParameter(37, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(38, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(39, java.sql.Types.VARCHAR);
								// ��������
								cstmt.executeUpdate();
								

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
	
	
	/*
	 * ���ϻ���
	 */
	private void deleteExcelFile(String filePath) {
		File target = new File(filePath);
		try {
	        if (!target.exists()) {
	                System.err.println(filePath + " �������� �ʽ��ϴ�...");
	                return;
	        }
	
	        // ������ �մϴ�... Ȥ�� �÷����� ���� 
	        //�۹̼� ����(SecurityException)�� ���� �� �ֽ��ϴ�....
	        if (target.delete()) {
	                System.err.println("** Deleted " + filePath + " **");
	        } else {
	                System.err.println("Failed to delete " + filePath);
	        }
		} catch (SecurityException e) {        
			System.err.println("Unable to delete " + filePath +
                "(" + e.getMessage() + ")");
		}


	}	
}
