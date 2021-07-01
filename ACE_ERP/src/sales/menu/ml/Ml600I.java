package sales.menu.ml;

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



public class Ml600I extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_ML600I_01(?,?,?,?,? )");	// ��ȸ
		
		arr_sql[2].append("CALL SALES.PR_ML600I_02(?,?,?,?,?	, ?,?,?,?,?,	?,?,?,?,?,  ?,?,?,?,?,	?,?,?,?,? )");	// ���� 25
		
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try {
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
			throw e;
		} finally {
			if(rs!=null) rs.close();

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
		
				
		/* DataSet */
		GauceDataSet ds1 		= gis.read("MAIN_DS");				//������ȸ
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//��������; 
		GauceDataSet ds2 		= gis.read("EXCELDS"); 		//��������;
		GauceDataSet ds_result 	= gis.read("RESULT");

		/* �޼��� ó�� */
		if(ds_result!=null){
			//gres.enableFirstRow(ds_result);
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		

		try {
			/* �˻��� �ʿ��� ���� */
			String sBgnDate 	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String sEndDate 	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String sTrGu  		= HDUtil.nullCheckStr(greq.getParameter("sTrGu"));
			String sTr_OrderNm  = HDUtil.nullCheckStr(greq.getParameter("sTr_OrderNm"));

			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
        		//GauceDataSet ds3 = gis.read("MAIN_DS");

				//��ȸ;            	//O:MAIN_DS=excelDs
				if (ds1 != null) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1,sBgnDate );	//�ŷ����� ����
					cstmt.setString(2,sEndDate );	//�ŷ����� ��
					cstmt.setString(3,sTrGu );		//�ŷ����� 01(����������) ����)
					cstmt.setString(4,sTr_OrderNm );//�ֹ�
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
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
					//gres.enableFirstRow(ds2);
					
					//StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�
					
					Sheet sheet0 = workbook.getSheet("kaesong"); // Sheet�� 
					
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
					ds2.addDataColumn(new GauceDataColumn("COL00",    GauceDataColumn.TB_STRING,  2)); // '�ŷ�����'
					ds2.addDataColumn(new GauceDataColumn("COL01",    GauceDataColumn.TB_STRING, 10)); // '����ó'    	
					ds2.addDataColumn(new GauceDataColumn("COL02",    GauceDataColumn.TB_STRING, 12)); // '�ֹ���ȣ'    
					ds2.addDataColumn(new GauceDataColumn("COL03",    GauceDataColumn.TB_STRING,  8)); // '�ֹ�����'    
					ds2.addDataColumn(new GauceDataColumn("COL04",    GauceDataColumn.TB_STRING,  4)); // '�Ϸù�ȣ'    
					ds2.addDataColumn(new GauceDataColumn("COL05",    GauceDataColumn.TB_STRING, 20)); // '�ֹ��ڸ�'    
					ds2.addDataColumn(new GauceDataColumn("COL06",    GauceDataColumn.TB_STRING, 13)); // '����ó1'
					ds2.addDataColumn(new GauceDataColumn("EXCH_RATE",GauceDataColumn.TB_DECIMAL,10)); // 'ȯ��' 	
					ds2.addDataColumn(new GauceDataColumn("COL08",    GauceDataColumn.TB_DECIMAL,10)); // '�̿밡��' 	
					ds2.addDataColumn(new GauceDataColumn("COL09",    GauceDataColumn.TB_STRING, 10)); // '���� ���'   

					ds2.addDataColumn(new GauceDataColumn("COL10",    GauceDataColumn.TB_STRING,  1)); // '���� ����'   
					ds2.addDataColumn(new GauceDataColumn("COL11",    GauceDataColumn.TB_DECIMAL,10)); // '���� �ݾ�' 	
					ds2.addDataColumn(new GauceDataColumn("COL12",    GauceDataColumn.TB_STRING,  8)); // 'ī���'      
					ds2.addDataColumn(new GauceDataColumn("COL13",    GauceDataColumn.TB_STRING, 20)); // 'ī���ȣ'    
					ds2.addDataColumn(new GauceDataColumn("COL14",    GauceDataColumn.TB_STRING,  4)); // '��ȿ�Ⱓ'    
					
					ds2.addDataColumn(new GauceDataColumn("COL15",    GauceDataColumn.TB_STRING,  2)); // '�Һΰ�����'  
					ds2.addDataColumn(new GauceDataColumn("COL16",    GauceDataColumn.TB_STRING, 14)); // '�����Ͻ�'    
					ds2.addDataColumn(new GauceDataColumn("COL17",    GauceDataColumn.TB_STRING,  8)); // '���ι�ȣ'
					ds2.addDataColumn(new GauceDataColumn("ORDER_SID",GauceDataColumn.TB_DECIMAL,10)); // '�ŷ�SID'
					/*
					 * temp�� �ִ� �ҷ��� �����͸� ds2�� �Ѹ��� �κ� 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						//StringUtil.printMsg("����ȯ===",arr[row][4],this);
						////StringUtil.printMsg("����ȯ===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("�����ڵ�   == ",sAcctGu,this);
						
						gRow.addColumnValue(arr[row][1]);
						gRow.addColumnValue(arr[row][2]);
						gRow.addColumnValue(arr[row][3]);
						gRow.addColumnValue(arr[row][4]);
						gRow.addColumnValue(arr[row][5]);
						gRow.addColumnValue(arr[row][6]);
						gRow.addColumnValue(arr[row][7]);
						gRow.addColumnValue(Double.parseDouble(arr[row][8]));	//number
						gRow.addColumnValue(Double.parseDouble(arr[row][9]));	//number
						gRow.addColumnValue(arr[row][10]);
						
						gRow.addColumnValue(arr[row][11]);
						gRow.addColumnValue(Double.parseDouble(arr[row][12]));	//number
						gRow.addColumnValue(arr[row][13]);
						gRow.addColumnValue(arr[row][14]);
						gRow.addColumnValue(arr[row][15]);
						
						gRow.addColumnValue(arr[row][16]);
						gRow.addColumnValue(arr[row][17]);
						gRow.addColumnValue(arr[row][18]);
						gRow.addColumnValue(10); 		// ORDER_SID �÷� : �⺻�� ���� 1�� �� �Ŀ� ȭ�鿡�� 0���� ���� (���� �Է½�)
						ds2.addDataRow(gRow);
						
						/*for (int column = 1; column < sheet0.getColumns()+1; column++) {
						////StringUtil.printMsg("����Ÿ",arr[row][column], this);
						gRow.addColumnValue(arr[row][column]);
						}*/

					}
					//StringUtil.printMsg("ī��Ʈ == " , ds2.getDataRowCnt(), this);
					
					gos.write(ds2);	//3.x������ ds2.flush()�� �ش�
					
					//StringUtil.printMsg("���� ������",this);
					deleteExcelFile(fExcelFilePath);
				}
				
            }
				
			if(ds_result!=null) ds_result.flush();
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
		 * */
		//StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds_xls 	= gis.read("EXCELDS");
		GauceDataSet ds_result	= gis.read("RESULT");
		
		
		String uploadType = "1";
		String v_edit_styatus = "";										//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
		try {
			if (ds_xls != null) {
			
				GauceDataRow[] 		rows = ds_xls.getDataRows();
				GauceDataColumn[] 	cols = ds_xls.getDataColumns();
						
				//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				
				int colNm_Col00	  = ds_xls.indexOfColumn("COL00");
				int colNm_Col01	  = ds_xls.indexOfColumn("COL01");
				int colNm_Col02	  = ds_xls.indexOfColumn("COL02");
				int colNm_Col03	  = ds_xls.indexOfColumn("COL03");
				int colNm_Col04	  = ds_xls.indexOfColumn("COL04");
				int colNm_Col05	  = ds_xls.indexOfColumn("COL05");
				int colNm_Col06	  = ds_xls.indexOfColumn("COL06");
				int colNm_Col07	  = ds_xls.indexOfColumn("EXCH_RATE");
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
				int colNm_ORDER_SID  = ds_xls.indexOfColumn("ORDER_SID");
						
												
						
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
					
					StringUtil.printMsg("�ֹ���ȣ==",""+rows[i].getString(colNm_Col02),this);	//�ֹ���ȣ
					//StringUtil.printMsg("ȯ��... ",""+rows[i].getDouble(colNm_Col07),this);	//ȯ��
					//StringUtil.printMsg("�̿밡��= ",""+rows[i].getInt(colNm_Col08),this);	
					//StringUtil.printMsg("���αݾ�= ",""+rows[i].getInt(colNm_Col11),this);
					//StringUtil.printMsg("INSERT 3= ",rows[i].getString(colNm_Col03),this);
					//StringUtil.printMsg("INSERT 4= ",rows[i].getString(colNm_Col04),this);
					//StringUtil.printMsg("INSERT 5= ",rows[i].getString(colNm_Col05),this);
					//StringUtil.printMsg("INSERT 6= ",rows[i].getString(colNm_Col06),this);
					//StringUtil.printMsg("INSERT 7= ","***"+rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/","")+"***",this);	//�ŷ�����
					//StringUtil.printMsg("INSERT 8= ","***"+rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":","")+"***",this);	//�ŷ��ð�
					//StringUtil.printMsg("================ �� ===============",this);
					cstmt.setString(1, rows[i].getString(colNm_Col00));
					cstmt.setString(2, rows[i].getString(colNm_Col01));
					cstmt.setString(3, rows[i].getString(colNm_Col02));
					cstmt.setString(4, rows[i].getString(colNm_Col03));
					cstmt.setString(5, rows[i].getString(colNm_Col04));
					cstmt.setString(6, rows[i].getString(colNm_Col05));
					cstmt.setString(7, rows[i].getString(colNm_Col06));
					cstmt.setDouble(8, rows[i].getDouble(colNm_Col07));
					cstmt.setInt(9, rows[i].getInt(colNm_Col08));
					cstmt.setString(10, rows[i].getString(colNm_Col09));
					cstmt.setString(11, rows[i].getString(colNm_Col10));
					cstmt.setInt(12, rows[i].getInt(colNm_Col11));
					cstmt.setString(13, rows[i].getString(colNm_Col12));
					cstmt.setString(14, rows[i].getString(colNm_Col13));
					cstmt.setString(15, rows[i].getString(colNm_Col14));
					cstmt.setString(16, rows[i].getString(colNm_Col15));
					cstmt.setString(17, rows[i].getString(colNm_Col16));
					cstmt.setString(18, rows[i].getString(colNm_Col17));
					cstmt.setInt(19, rows[i].getInt(colNm_ORDER_SID));
					cstmt.setString(20, fParamEmpno);
					cstmt.setString(21, fParamIp);
					cstmt.setString(22, v_edit_styatus);
					
					cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
					// ��������
					cstmt.executeUpdate();
//							
				}
			}
			gos.close();
		}catch (SQLException sqle){
			sqle.printStackTrace();
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
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
