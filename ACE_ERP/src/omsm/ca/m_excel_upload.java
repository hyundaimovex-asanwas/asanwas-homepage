package omsm.ca;

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
import jxl.NumberFormulaCell;
import jxl.Sheet;
import jxl.Workbook;

public class m_excel_upload extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
		//System.out.println("step00000");
		
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
				
				//System.out.println("step1");
				
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
				
				//System.out.println("step2");

				///////////////////////////////////////////////////////////////////////////////
                //���Ϻ���
                //������ ���� ��
				o_name = System.currentTimeMillis()+".xls";
				//fExcelFilePath = "/HdAsan/Account/file/excel" + o_name;	
				
				//����
				//fExcelFilePath = "D:/myWorks/HDAsan/WebContent/Omsm/file/excel/"+ o_name;
				
				//����
				fExcelFilePath = "/asanwas/account/excel/"+ o_name;
				
				//o_name = "temp201401180415.xls";
				//fExcelFilePath = "../Account/file/" + o_name;		
				//fExcelFilePath = "D:/"+o_name;
				//fExcelFilePath = "D:/"+o_name;
				
				//app/src/erpApp/Sales/file/excel
				
				//System.out.println("step3");
                //logger.dbg.println(this,"���� �������� ���:"+fExcelFilePath); 
				InputStream is = (InputStream)excelRow[0].getInputStream(idxEXCEL_URL);
				FileOutputStream os = new FileOutputStream(fExcelFilePath);
				int size = 1024*1024*10 ;   
				copy(is, os, size );
				is.close();
				os.close();
				
				//���� ���� ��.
        ////////////////////////////////////////////////////////////////////////////// 
				//System.out.println("step4");
				if (ds2 != null) {
					resGauce.enableFirstRow(ds2);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�
					Sheet sheet0 = workbook.getSheet(0); // Sheet�� 
					//System.out.println("=========ROW:"+sheet0.getRows()); 
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
   
							} else if(sheet0.getCell(column,row).getType() == CellType.NUMBER_FORMULA)	{
								NumberFormulaCell numberformulaCell = (NumberFormulaCell) sheet0.getCell(column,row);
								content = numberformulaCell.getValue()+""; 
								arr[row][column+1] = content; 
							}
							
							//System.out.println("content:"+content); 
 
						}
					}
					//System.out.println("step5");
							
					/******************************************************************************************
					 * DataSet Header
					 ******************************************************************************************/
					   
					ds2.addDataColumn(new GauceDataColumn("CA_SID",         GauceDataColumn.TB_DECIMAL, 10,0));  // ����SID            
					ds2.addDataColumn(new GauceDataColumn("CA_MONTH",       GauceDataColumn.TB_STRING, 6));      // ������           
					ds2.addDataColumn(new GauceDataColumn("INOUT_DATE",     GauceDataColumn.TB_STRING, 8));      // ����������         
					ds2.addDataColumn(new GauceDataColumn("LOGIS_GB",       GauceDataColumn.TB_STRING, 1));      // ��������           
					ds2.addDataColumn(new GauceDataColumn("INOUT_GB",       GauceDataColumn.TB_STRING, 1));      // �����Ա���         
					ds2.addDataColumn(new GauceDataColumn("ITEM_NAME",      GauceDataColumn.TB_STRING, 60));     // ��ǥǰ��           
					ds2.addDataColumn(new GauceDataColumn("CAR_KIND",       GauceDataColumn.TB_STRING, 2));      // ��������           
					ds2.addDataColumn(new GauceDataColumn("CAR_NO",         GauceDataColumn.TB_STRING, 20));     // ������ȣ           
					ds2.addDataColumn(new GauceDataColumn("DRV_ID",         GauceDataColumn.TB_STRING, 5));      // ������             
					ds2.addDataColumn(new GauceDataColumn("START_ADDR",     GauceDataColumn.TB_STRING, 6));      // ������             
					ds2.addDataColumn(new GauceDataColumn("START_NAME",     GauceDataColumn.TB_STRING, 20));     // ��������           
					ds2.addDataColumn(new GauceDataColumn("END_ADDR",       GauceDataColumn.TB_STRING, 6));      // ������             
					ds2.addDataColumn(new GauceDataColumn("END_NAME",       GauceDataColumn.TB_STRING, 20));     // ��������           
					ds2.addDataColumn(new GauceDataColumn("OUT_TIME",       GauceDataColumn.TB_STRING, 4));      // ���ð�           
					ds2.addDataColumn(new GauceDataColumn("IN_TIME",        GauceDataColumn.TB_STRING, 4));      // �԰�ð�           
					ds2.addDataColumn(new GauceDataColumn("UNIT",           GauceDataColumn.TB_STRING, 2));      // ����               
					ds2.addDataColumn(new GauceDataColumn("QTY",            GauceDataColumn.TB_DECIMAL, 3,0));   // ����               
					ds2.addDataColumn(new GauceDataColumn("UNIT_PRICE",     GauceDataColumn.TB_DECIMAL, 10,0));  // �ܰ�               
					ds2.addDataColumn(new GauceDataColumn("SUP_AMT",        GauceDataColumn.TB_DECIMAL, 15,0));  // �ݾ�               
					ds2.addDataColumn(new GauceDataColumn("SHIP_CRNO",      GauceDataColumn.TB_STRING, 15));     // ȭ�ֻ���ڵ�Ϲ�ȣ 
					ds2.addDataColumn(new GauceDataColumn("SHIP_COMPANY",   GauceDataColumn.TB_STRING, 60));     // ȭ�ֻ���ڸ�       
					ds2.addDataColumn(new GauceDataColumn("REMARK",         GauceDataColumn.TB_STRING, 100));    // ���               
					ds2.addDataColumn(new GauceDataColumn("SHIP_UNIT_PRICE",GauceDataColumn.TB_DECIMAL, 10,0));  // ȭ�ִܰ�           
					ds2.addDataColumn(new GauceDataColumn("SHIP_SUP_AMT",   GauceDataColumn.TB_DECIMAL, 15,0));  // ȭ�ְ��ޱݾ�       
					ds2.addDataColumn(new GauceDataColumn("SHIP_SUP_VAT",   GauceDataColumn.TB_DECIMAL, 13,0));  // ȭ�ְ��޼���       
					ds2.addDataColumn(new GauceDataColumn("SHIP_DMD_AMT",   GauceDataColumn.TB_DECIMAL, 15,0));  // ȭ��û���ݾ�       
					ds2.addDataColumn(new GauceDataColumn("CA_STS",         GauceDataColumn.TB_STRING, 1));      // ����               
					ds2.addDataColumn(new GauceDataColumn("WORK_CD",        GauceDataColumn.TB_STRING, 1));      // �����      
					ds2.addDataColumn(new GauceDataColumn("COST_GB",        GauceDataColumn.TB_STRING, 1));      // �������� (�߰��÷�)
					ds2.addDataColumn(new GauceDataColumn("CUST_GB",        GauceDataColumn.TB_STRING, 1));      // ������ (�߰��÷�)
					ds2.addDataColumn(new GauceDataColumn("CREATE_ID",      GauceDataColumn.TB_STRING, 10));     // �Է���ID           
					ds2.addDataColumn(new GauceDataColumn("CREATE_DATE",    GauceDataColumn.TB_STRING, 6));      // �Է�����           
					ds2.addDataColumn(new GauceDataColumn("UPDATE_ID",      GauceDataColumn.TB_STRING, 10));     // ������ID           
					ds2.addDataColumn(new GauceDataColumn("UPDATE_DATE",    GauceDataColumn.TB_STRING, 6));      // ��������          
					//System.out.println("step6");
					/*
					 * ������ �����Ͱ� �ִ� ������ �о �� �ʵ��� ���� üũ�� �Ѵ� 
					 * ����üũ�� �ϱ�鼭 ������ �ִ°�쿡�� ȭ�鿡 ������ ǥ�ø� ���ش� 
					 */

					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
              //StringUtil.printMsg("arr["+row+"]["+column+"]", arr[row][column], this);
							switch(column){
							    case 1:
								gRow.addColumnValue(Double.parseDouble(arr[row][column]));
								break;
							
							    case 17:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 18:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 19:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 23:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;	
								case 24:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 25:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;	
								case 26:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;		
								default:
									gRow.addColumnValue(arr[row][column]);
								  //logger.dbg.println(this,"row::"+row+"::column::"+column+":::::"+arr[row][column]);
									break;
							}
						}

						//gRow.addColumnValue("Y"); // �б� ����, ���� �÷��׷� ���
						ds2.addDataRow(gRow);

                        //StringUtil.printMsg("row value ["+ row + "]", row, this);
					}
					//System.out.println("step7");
					ds2.flush();
					//System.out.println("step8");
				}

			}
			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
			deleteExcelFile(fExcelFilePath);
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
			System.out.println("step99999");
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