package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;

public class excel_upload_t1 extends HttpServlet{
	private String fExcelFilePath = "";
	/*********************************************************************
	* ���� ������ ���� �Լ� : ������ ������.
	* @param in
	* @param out
	* @param bufferSize
	*********************************************************************/
	private void copy(InputStream in, OutputStream out, int bufferSize) {
		try {
				synchronized (in) {
						synchronized (out) {
								byte[] buffer = new byte[bufferSize];
								while (true) {
										int bytesRead = in.read(buffer);
										System.out.println("bytesRead : " + bytesRead + " : " + buffer.length);
										if (bytesRead == -1) break;
										out.write(buffer, 0, bytesRead);
								}
						}
				}
		} catch (IOException ioe) {
				throw new RuntimeException ("Can not copy stream\n\t"+ioe.toString());
		}
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			GauceStatement stmt =null;
		    GauceDataSet dSet = null;

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				//����Ÿ�� ����
				GauceDataSet excelDs = reqGauce.getGauceDataSet("USER");  
				GauceDataSet ds2 = reqGauce.getGauceDataSet("USER2"); 

				 //����Ÿ���� ROWS
				GauceDataRow[] 		excelRow = excelDs.getDataRows();    
  				//����Ÿ���� COLS
				GauceDataColumn[] 	excelCol = excelDs.getDataColumns();

				int idxEXCEL_INFO = excelDs.indexOfColumn("EXCEL_INFO");
				int idxEXCEL_URL  = excelDs.indexOfColumn("EXCEL_URL");
 
				String d_name = excelRow[0].getString(idxEXCEL_INFO);
				String o_name = excelRow[0].getString(0).trim();


        ///////////////////////////////////////////////////////////////////////////////
        //���Ϻ���
        //������ ���� ��
				o_name = System.currentTimeMillis()+".xls";  

				fExcelFilePath = "/" + o_name;

				//fExcelFilePath = "http://192.168.1.252/services/servlet/file/" + o_name;	

				//logger.dbg.println(this,"���� �������� ���:"+fExcelFilePath); 
				System.out.println("���� �������� ���:" + fExcelFilePath);	
				
				InputStream is = (InputStream)excelRow[0].getInputStream(idxEXCEL_URL);

				FileOutputStream os = new FileOutputStream(fExcelFilePath);

				int size = 1024*1024*10 ;   

				copy(is, os, size );
				is.close();
				os.close();

				//���� ���� ��.
        ////////////////////////////////////////////////////////////////////////////// 

				if (ds2 != null) {

					resGauce.enableFirstRow(ds2);
					//logger.dbg.println(this,"step7::::fExcelFilePath"+fExcelFilePath);
					//System.out.println("���� �������� ���:" + fExcelFilePath);	
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�
					//logger.dbg.println(this,"step8");
					Sheet sheet0 = workbook.getSheet(0); // Sheet�� 
					//logger.dbg.println(this,"=========ROW:"+sheet0.getRows()); 
					//System.out.println("=========ROW:"+sheet0.getRows()); 					
					String arr[][] = new String[sheet0.getRows()][60];
					
					for (int row = 0; row < sheet0.getRows(); row++) {		 

						for (int column =0; column < sheet0.getColumns(); column++)	 {

							String content = "";

						// ����Ÿ��							
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

							
					/******************************************************************************************
					 * DataSet Header
					 ******************************************************************************************/

					ds2.addDataColumn(new GauceDataColumn("EMPNO",     GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("EMPNMK",     GauceDataColumn.TB_STRING, 20)); // 
					ds2.addDataColumn(new GauceDataColumn("A_TM",     		GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("L_TM",   		GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("SAYU_GB",     GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("M_H",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("A_H",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("O_H",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("N1_H",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("N2_H",    GauceDataColumn.TB_STRING, 10)); // 


					/*
					 * ������ �����Ͱ� �ִ� ������ �о �� �ʵ��� ���� üũ�� �Ѵ� 
					 * ����üũ�� �ϱ�鼭 ������ �ִ°�쿡�� ȭ�鿡 ������ ǥ�ø� ���ش� 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 2; column < sheet0.getColumns()+1; column++) {
							//StringUtil.printMsg("arr["+row+"]["+column+"]", arr[row][column], this);
							switch(column){
								//case 1:
								//case 9:
								//case 11:
								//	gRow.addColumnValue(Double.parseDouble(arr[row][column]));
								//	break;
								default:
									gRow.addColumnValue(arr[row][column]);
									break;
							}
						}

						//gRow.addColumnValue("Y"); // �б� ����, ���� �÷��׷� ���
						ds2.addDataRow(gRow);
						 //StringUtil.printMsg("row value ["+ row + "]", row, this);
					}
					ds2.flush();
				}

			}
			catch(Exception e){
				logger.dbg.println(this,"step_err");
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}

            logger.dbg.println(this,"step_s");
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
			deleteExcelFile(fExcelFilePath);
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}



  /*************************************************************************
	 * ������ �ӽ÷� ������ ���ϻ���
	 *************************************************************************/
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