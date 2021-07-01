package Account;

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

public class excel_upload_xat1004_t1 extends HttpServlet{
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
		    
		    //System.out.println("���ε����");
		    
			try {
				
				
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

                //����Ÿ�� ����
				GauceDataSet excelDs = reqGauce.getGauceDataSet("USER");  //INPUT
				GauceDataSet ds2 = reqGauce.getGauceDataSet("USER2");     //OUTPUT

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
				
				//System.out.println("���ϸ� o_name::"+o_name);
				
				//fExcelFilePath = "/HdAsan/Account/file/excel" + o_name;	
				
				//����
				//fExcelFilePath = "D:/myWorks/HDAsan/WebContent/Account/file/excel/"+ o_name;
				
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

				if (ds2 != null) {
					resGauce.enableFirstRow(ds2);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�
					Sheet sheet0 = workbook.getSheet(0); // Sheet�� 
					//System.out.println("=========ROW11:"+sheet0.getRows()); 
					String arr[][] = new String[sheet0.getRows()][60];
					
					for (int row = 0; row < sheet0.getRows(); row++) {		 
						// ����Ÿ��
						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							
							//System.out.println("=========column:"+column+"::"+sheet0.getCell(column,row).getType()); 
							
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
 
						}
					}

							
					/******************************************************************************************
					 * DataSet Header
					 ******************************************************************************************/
					
					ds2.addDataColumn(new GauceDataColumn("DFSCD",       GauceDataColumn.TB_STRING,6));       //�鼼�������ڵ� 1 0
					ds2.addDataColumn(new GauceDataColumn("SALEDT",      GauceDataColumn.TB_STRING,8));       //��������          2 1
					ds2.addDataColumn(new GauceDataColumn("POSNO",       GauceDataColumn.TB_STRING,2));       //������ȣ          3 2
					ds2.addDataColumn(new GauceDataColumn("RECNO",       GauceDataColumn.TB_STRING,4));       //��������ȣ        4 3
					ds2.addDataColumn(new GauceDataColumn("GUBUN",       GauceDataColumn.TB_STRING,4));       //����                 5 4
					ds2.addDataColumn(new GauceDataColumn("GUBUN2",      GauceDataColumn.TB_STRING,6));       //����2       6 5 
 					ds2.addDataColumn(new GauceDataColumn("ORDTM",       GauceDataColumn.TB_STRING,8));       //�����ֹ��ð�    7 6
					ds2.addDataColumn(new GauceDataColumn("APPTM",       GauceDataColumn.TB_STRING,8));       //�����ð�          8 7
					ds2.addDataColumn(new GauceDataColumn("GOODCD",      GauceDataColumn.TB_STRING,26));       //��ǰ�ڵ�         9 8
					ds2.addDataColumn(new GauceDataColumn("BARCD",       GauceDataColumn.TB_STRING,26));       //���ڵ�           10 9
					ds2.addDataColumn(new GauceDataColumn("GOODNM",      GauceDataColumn.TB_STRING,50));       //��ǰ��           11 10
					ds2.addDataColumn(new GauceDataColumn("GOODCNT",     GauceDataColumn.TB_DECIMAL,9,0));     //����             12  11
					ds2.addDataColumn(new GauceDataColumn("BUYAMT",      GauceDataColumn.TB_DECIMAL,10,0));    //���԰�           13  12
					ds2.addDataColumn(new GauceDataColumn("TSALAMT",     GauceDataColumn.TB_DECIMAL,12,0));    //�Ѹ����         14  13 
					ds2.addDataColumn(new GauceDataColumn("DISCAMT",     GauceDataColumn.TB_DECIMAL,12,0));    //���ξ�           15   14
					ds2.addDataColumn(new GauceDataColumn("DISGB",       GauceDataColumn.TB_STRING,8 ));       //���α���         16   15
					ds2.addDataColumn(new GauceDataColumn("SALAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //�Ǹ����         17   16
					ds2.addDataColumn(new GauceDataColumn("PRIAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //����             18    17 
					ds2.addDataColumn(new GauceDataColumn("VATAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //�ΰ���           19    18
					ds2.addDataColumn(new GauceDataColumn("ADJAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //������           20    19
					ds2.addDataColumn(new GauceDataColumn("APPSUM",      GauceDataColumn.TB_DECIMAL,12,0));    //�����հ�         21    20
					ds2.addDataColumn(new GauceDataColumn("WONAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //��ȭ             22    21
					ds2.addDataColumn(new GauceDataColumn("CARDAMT",     GauceDataColumn.TB_DECIMAL,12,0));    //�ſ�ī��         23   22
					ds2.addDataColumn(new GauceDataColumn("CASHAMT",     GauceDataColumn.TB_DECIMAL,12,0));    //���ݿ�ȭ         24   23
					
					ds2.addDataColumn(new GauceDataColumn("USDAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //�޷�             27    26
					ds2.addDataColumn(new GauceDataColumn("UWONAMT",     GauceDataColumn.TB_DECIMAL,12,0));    //�޷���ȭ         28   27
					ds2.addDataColumn(new GauceDataColumn("CNYAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //����             25    24
					ds2.addDataColumn(new GauceDataColumn("CWONAMT",     GauceDataColumn.TB_DECIMAL,12,0));    //���ȿ�ȭ         26   25 
					ds2.addDataColumn(new GauceDataColumn("PNTAMT",      GauceDataColumn.TB_DECIMAL,12,0));    //����Ʈ           29   28
					ds2.addDataColumn(new GauceDataColumn("CARDCD",      GauceDataColumn.TB_STRING,3));        //ī���ڵ�         30  29
					ds2.addDataColumn(new GauceDataColumn("CARDNM",      GauceDataColumn.TB_STRING,30));       //ī���           31   30
					//ds2.addDataColumn(new GauceDataColumn("FDCODE",      GauceDataColumn.TB_STRING,2));        //����             32
					//ds2.addDataColumn(new GauceDataColumn("FSDAT",       GauceDataColumn.TB_STRING,9));        //��������         33
					//ds2.addDataColumn(new GauceDataColumn("FSNBR",       GauceDataColumn.TB_STRING,6));        //������ȣ         34
					ds2.addDataColumn(new GauceDataColumn("CREATE_ID",   GauceDataColumn.TB_STRING,10));       //�Է���           35
					//ds2.addDataColumn(new GauceDataColumn("CREATE_DATE", GauceDataColumn.TB_STRING,10));       //�Է��Ͻ�         36
					//ds2.addDataColumn(new GauceDataColumn("UPDATE_ID",   GauceDataColumn.TB_STRING,10));       //������           37
					//ds2.addDataColumn(new GauceDataColumn("UPDATE_DATE", GauceDataColumn.TB_STRING,10));       //��������         38
					
					
					
					/*   
					ds2.addDataColumn(new GauceDataColumn("ACCTNO",   GauceDataColumn.TB_STRING,30));       //���¹�ȣ   1
					ds2.addDataColumn(new GauceDataColumn("DEALDT",   GauceDataColumn.TB_STRING,20));       //�ŷ��Ͻ�   2
					
					ds2.addDataColumn(new GauceDataColumn("REMARK",   GauceDataColumn.TB_STRING,100));      //����         4
					ds2.addDataColumn(new GauceDataColumn("CURUNIT",  GauceDataColumn.TB_STRING,6));        //��ȭ��      11
					
					ds2.addDataColumn(new GauceDataColumn("INAMT",    GauceDataColumn.TB_DECIMAL,15,2));    //�Աݾ�      5
					ds2.addDataColumn(new GauceDataColumn("OUTAMT",   GauceDataColumn.TB_DECIMAL,15,2));    //��ݾ�      6
					ds2.addDataColumn(new GauceDataColumn("BALAMT",   GauceDataColumn.TB_DECIMAL,15,2));    //�ܾ�         7
					ds2.addDataColumn(new GauceDataColumn("FINAMT",   GauceDataColumn.TB_DECIMAL,15,2));    //��ȭ�Աݾ�8   
					ds2.addDataColumn(new GauceDataColumn("FOUTAMT",  GauceDataColumn.TB_DECIMAL,15,2));    //��ȭ��ݾ�9  
					ds2.addDataColumn(new GauceDataColumn("FBALAMT",  GauceDataColumn.TB_DECIMAL,15,2));    //��ȭ�ܾ�   10      
					
					ds2.addDataColumn(new GauceDataColumn("EXRATE",   GauceDataColumn.TB_DECIMAL,6,2));     //ȯ��         12
					ds2.addDataColumn(new GauceDataColumn("TRISSUE",  GauceDataColumn.TB_STRING,60));       //Ư�̻���   13
					ds2.addDataColumn(new GauceDataColumn("DEDATE",   GauceDataColumn.TB_STRING,8));        //�ŷ�����   14 
					ds2.addDataColumn(new GauceDataColumn("DETIME",   GauceDataColumn.TB_STRING,8));        //�ŷ��ð�   15
					ds2.addDataColumn(new GauceDataColumn("RESULT",   GauceDataColumn.TB_STRING,10));       //��������   16
					ds2.addDataColumn(new GauceDataColumn("RSTREMARK",GauceDataColumn.TB_STRING,60));       //��������   17
					ds2.addDataColumn(new GauceDataColumn("RSTSEQ",   GauceDataColumn.TB_DECIMAL,3,0));     //��������   18
					ds2.addDataColumn(new GauceDataColumn("TEAM",     GauceDataColumn.TB_STRING,10));       //�����      19
					ds2.addDataColumn(new GauceDataColumn("INRATE",   GauceDataColumn.TB_DECIMAL,4,2));     //������      20
					ds2.addDataColumn(new GauceDataColumn("WRID",     GauceDataColumn.TB_STRING,10));       //�Է���      21
					ds2.addDataColumn(new GauceDataColumn("ACCTCD",   GauceDataColumn.TB_STRING,10));       //�����ڵ�   3
					ds2.addDataColumn(new GauceDataColumn("COSTCD",   GauceDataColumn.TB_STRING,10));       //�����ڵ�   10
					ds2.addDataColumn(new GauceDataColumn("COSTNM",   GauceDataColumn.TB_STRING,100));      //������    100
					*/

					/*
					 * ������ �����Ͱ� �ִ� ������ �о �� �ʵ��� ���� üũ�� �Ѵ� 
					 * ����üũ�� �ϱ�鼭 ������ �ִ°�쿡�� ȭ�鿡 ������ ǥ�ø� ���ش� 
					 */

					for (int row = 5; row < sheet0.getRows(); row++) {  //6��° row ���� : �÷� ��� ����
						
						
						//System.out.println("arr[row][1]::"+arr[row][1]+"::");
						
						if(arr[row][1].equals("�հ�")){
							//System.out.println(" �̰� ��Ÿ�� arr[row][1]::"+arr[row][1]+"::");
						}else{
							GauceDataRow gRow = ds2.newDataRow();
							
							for (int column = 1; column < sheet0.getColumns()+1; column++) {
								//System.out.println("row::"+row+"::column::"+column);
								//System.out.println("row::"+row+"::column::"+column+":::::"+arr[row][column]);
														
								switch(column){
									case 12:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;
									case 13:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;
									case 14:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;
									case 15:
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
									case 20:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;	
									case 21:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;
									case 22:
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
									case 27:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;
									case 28:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;									
									case 29:
										gRow.addColumnValue(Double.parseDouble(arr[row][column]));
										break;									
									default:
										gRow.addColumnValue(arr[row][column]);
									    //System.out.println("row::"+row+"::column::"+column+":::::"+arr[row][column]);
										break;
								}
								
							}
							ds2.addDataRow(gRow);
						}

						//gRow.addColumnValue("Y"); // �б� ����, ���� �÷��׷� ���
						
					}
					ds2.flush();
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