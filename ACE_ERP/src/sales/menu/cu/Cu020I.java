package sales.menu.cu;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;


public class Cu020I extends SuperServlet {

	private static final long serialVersionUID = 1L;
	
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		
		arr_sql[1].append("CALL SALES.PR_RV250B_01(?,?,  ?)");	// ��ȸ
		
		arr_sql[2].append("CALL SALES.PR_RV250B_02(" +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?" +
				")");	// ����
		
		arr_sql[3].append("CALL SALES.PR_RV250B_03(?,?,?,?,?,  ?,?,?)"); // �ڷ�Ȯ��
		
		arr_sql[4].append("CALL SALES.PR_RV250B_04(?,?,?,?,?,  ?,?,?)"); // �ڷ��̰�
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            	
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//	"JSP(O:EXCELDS=tempExcelDs)",
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
		
		String[] 			columnName 	= null;
		
		/* DataSet */
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//��������; 
		GauceDataSet ds2 		= gis.read("EXCELDS"); 		//��������;
		GauceDataSet ds3 		= gis.read("MAIN_DS"); 		//������ȸ;
		GauceDataSet ds03 		= gis.read("DS03"); // �ڷ��̰� 
		GauceDataSet ds04 		= gis.read("DS04"); // �ڷ��̰�
		GauceDataSet ds_result 	= gis.read("RESULT");
		
		/* �޼��� ó�� */
		if(ds_result!=null){
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		
		try {
			/* �˻��� �ʿ��� ���� */
			int sClientSid = HDUtil.nullCheckNum(greq.getParameter("sClientSid")); 
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
        		//GauceDataSet ds3 		= gis.read("MAIN_DS"); 		//������ȸ;

				//��ȸ;      	//O:MAIN_DS=excelDs
				if (ds3 != null) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					//StringUtil.printMsg("�Ϲ� ��ȸ ",this);
					//StringUtil.printMsg("����ó ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"1" );

					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds3));
				}
				
            	//�׼����� JSP (I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs)
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
					
					fExcelFilePath = "d:/myWorks/HDAsan/WebContent/Sales/file/excel/acct/" + o_name;//���ÿ�
					//fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;	//������
					
					//StringUtil.printMsg("���� �������� ���:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}


				
				
				
				// ���� �б�
				if (ds2 != null) {
					//StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�

					Sheet sheet0 = workbook.getSheet("Sheet1"); // Sheet�� 
					
					StringUtil.printMsg("�׼��б� ====ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][600];	//�迭��ü�� ��Ʈ���̳׿�..
					
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
					
					ds2.addDataColumn(new GauceDataColumn("UPLOAD_MSG",   GauceDataColumn.TB_STRING, 200)); // 0
					ds2.addDataColumn(new GauceDataColumn("SEQ",      	  GauceDataColumn.TB_STRING, 10));  // 1
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
					ds2.addDataColumn(new GauceDataColumn("COL13",        GauceDataColumn.TB_STRING, 60)); // 2�ּ�2
					ds2.addDataColumn(new GauceDataColumn("COL14",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL15",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL16",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL17",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL18",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL19",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("YN",			  GauceDataColumn.TB_STRING, 10)); 
					/*
					 * ������ �����Ͱ� �ִ� ������ �о �� �ʵ��� ���� üũ�� �Ѵ� 
					 * ����üũ�� �ϱ�鼭 ������ �ִ°�쿡�� ȭ�鿡 ������ ǥ�ø� ���ش� 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							//StringUtil.printMsg("����Ÿ",arr[row][column], this);
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // �б� ����, ���� �÷��׷� ���
						ds2.addDataRow(gRow);
					}
					
					//StringUtil.printMsg("ī��Ʈ == " , ds2.getDataRowCnt(), this);
					gos.write(ds2);		//3.x������ ds2.flush()�� �ش�	//ds2.flush();	
					
					
					//StringUtil.printMsg("���� ������",this);
					deleteExcelFile(fExcelFilePath);
				}
						

				
				if (ds03 != null) {
					cstmt = conn.prepareCall(arr_sql[3].toString());
					//StringUtil.printMsg("�ڷ�Ȯ�� ",this);
					//StringUtil.printMsg("sClientSid ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"1" );
					cstmt.setString(3, fParamEmpno);
					cstmt.setString(4, fParamIp);
					cstmt.setString(5, "3");
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
					
					
					cstmt.executeUpdate();		//�̰� ������Ʈ��
					
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
					cstmt = conn.prepareCall(arr_sql[4].toString());
					StringUtil.printMsg("�ڷ��̰� ",this);
					StringUtil.printMsg("sClientSid ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"1" );
					cstmt.setString(3, fParamEmpno);
					cstmt.setString(4, fParamIp);
					cstmt.setString(5, "3");
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
					cstmt.executeUpdate();		//�̰� ������Ʈ��
					
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
            }
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			gos.close();
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
		 * */
		StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;

		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds_xls 	= gis.read("EXCELDS");
		GauceDataSet ds_result	= gis.read("RESULT");

		int sClientSid = HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
		String uploadType = "1";
		String v_edit_styatus = "";										//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
		
		try {
			if (ds_xls != null) {
				
				GauceDataRow[] 		rows = ds_xls.getDataRows();
				GauceDataColumn[] 	cols = ds_xls.getDataColumns();
						
			
				StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				int colNm_Seq     = ds_xls.indexOfColumn("SEQ");
				int colNm_Col01	  = ds_xls.indexOfColumn("COL01");
				int colNm_Col02	  = ds_xls.indexOfColumn("COL02");
				int colNm_Col03	  = ds_xls.indexOfColumn("COL03");
				int colNm_Col04	  = ds_xls.indexOfColumn("COL04");
				int colNm_Col05	  = ds_xls.indexOfColumn("COL05");
				int colNm_Col06	  = ds_xls.indexOfColumn("COL06");
				int colNm_Col07	  = ds_xls.indexOfColumn("COL07");
				int colNm_Col08	  = ds_xls.indexOfColumn("COL08");
				int colNm_Col09	  = ds_xls.indexOfColumn("COL09");
				int colNm_Col10	  = ds_xls.indexOfColumn("COL10");
				int colNm_Col11	  = ds_xls.indexOfColumn("COL11");
				int colNm_Col12	  = ds_xls.indexOfColumn("COL12");
				int colNm_Col13	  = ds_xls.indexOfColumn("COL13");
				int colNm_Col14	  = ds_xls.indexOfColumn("COL14");
				int colNm_Col15	  = ds_xls.indexOfColumn("COL15");
				int colNm_Col16	  = ds_xls.indexOfColumn("COL16");
				int colNm_Col17	  = ds_xls.indexOfColumn("COL17");
				int colNm_Col18	  = ds_xls.indexOfColumn("COL18");
				int colNm_Col19	  = ds_xls.indexOfColumn("COL19");
						
				for(int i=0; i<rows.length; i++){
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
					} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
						
					}
					
					//StringUtil.printMsg("INSERT",this);
					//StringUtil.printMsg("v_edit_styatus",v_edit_styatus, this);
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
					
					cstmt.setString(20, rows[i].getString(colNm_Col17));
					cstmt.setString(21, rows[i].getString(colNm_Col18));
					cstmt.setString(22, rows[i].getString(colNm_Col19));
					
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
//							
				}
			}
		}catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			gos.close();

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
			System.err.println("Unable to delete " + filePath + "(" + e.getMessage() + ")");
		}


	}	
}
