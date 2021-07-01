package DDms;

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

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.hssf.record.*;
import org.apache.poi.hssf.model.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;


public class excel_upload_t1 extends HttpServlet{
	private String fExcelFilePath = "";
	/*********************************************************************
	* 파일 수신을 위한 함수 : 파일을 복사함.
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

				//데이타셋 받음
				GauceDataSet excelDs = reqGauce.getGauceDataSet("USER");  
				GauceDataSet ds2 = reqGauce.getGauceDataSet("USER2"); 

				 //데이타셋의 ROWS
				GauceDataRow[] 		excelRow = excelDs.getDataRows();    
  				//데이타셋의 COLS
				GauceDataColumn[] 	excelCol = excelDs.getDataColumns();

				int idxEXCEL_INFO = excelDs.indexOfColumn("EXCEL_INFO");
				int idxEXCEL_URL  = excelDs.indexOfColumn("EXCEL_URL");
 
				String d_name = excelRow[0].getString(idxEXCEL_INFO);
				String o_name = excelRow[0].getString(0).trim();

				//System.out.println("엑셀 생성파일 경로::::::::::::::::::::::::::::::::::::::::::::::");
        ///////////////////////////////////////////////////////////////////////////////
        //파일복사
        //복사할 파일 명
				
				
				
				
				
				
				o_name = System.currentTimeMillis()+".xls";  

				File saveDir = new File("C:/temp");
				
				if(!saveDir.exists()){
					
					saveDir.mkdirs();
				}
				
				fExcelFilePath = saveDir+"/"+o_name;				
				
				
				//fExcelFilePath = "http://10.61.108.136/HDAsan/services/" + o_name;	

				//logger.dbg.println(this,"엑셀 생성파일 경로:"+fExcelFilePath); 
				//System.out.println("엑셀 생성파일 경로:" + fExcelFilePath);	
				
				InputStream is = (InputStream)excelRow[0].getInputStream(idxEXCEL_URL);

				FileOutputStream os = new FileOutputStream(fExcelFilePath);

				int size = 1024*1024*10 ;   

				copy(is, os, size );
				
				is.close();
				
				os.close();

				//파일 복사 끝.
        ////////////////////////////////////////////////////////////////////////////// 

				if (ds2 != null) {

					resGauce.enableFirstRow(ds2);
					
					//logger.dbg.println(this,"step7::::fExcelFilePath"+fExcelFilePath);
					//System.out.println("엑셀 생성파일 경로:" + fExcelFilePath);	
					
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					//logger.dbg.println(this,"step8");
					Sheet sheet0 = workbook.getSheet(0); // Sheet명 
					
					//logger.dbg.println(this,"=========ROW:"+sheet0.getRows()); 
					//System.out.println("=========ROW:"+sheet0.getRows()); 		
					
					String arr[][] = new String[sheet0.getRows()][60];
					
					for (int row = 0; row < sheet0.getRows(); row++) {		 

						for (int column =0; column < sheet0.getColumns(); column++)	 {

							String content = "";

						// 숫자타입							
							if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
								NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
								content = numberCell.getValue()+""; 
								
								arr[row][column+1] = content;

						// 문자타입		
							} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
						
								LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
								content = labelCell.getString()+"";
								
								arr[row][column+1] = content;


						// 날자 타입 		
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
					ds2.addDataColumn(new GauceDataColumn("CAR_NO",	     	GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("DRIVE_DT",     	GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("DPT_NM",     		GauceDataColumn.TB_STRING, 20)); // 
					ds2.addDataColumn(new GauceDataColumn("JOB_NM",     		GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("ENO_NM",   		GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("DRIVE_BEFORE",  GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("DRIVE_AFTER",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("MILEAGE",    		GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("FOR_CMMT",    	GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("FOR_BIZ",    		GauceDataColumn.TB_STRING, 10)); // 



					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 2; row < sheet0.getRows(); row++) {
						
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

						//gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds2.addDataRow(gRow);
						//StringUtil.printMsg("row value ["+ row + "]", row, this);
					}
					ds2.flush();
				}

			}
			catch(Exception e){
				logger.dbg.println(this,"step_err");
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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
	 * 서버에 임시로 복사한 파일삭제
	 *************************************************************************/
	private void deleteExcelFile(String filePath) {
		File target = new File(filePath);
		try {
	        if (!target.exists()) {
	                System.err.println(filePath + " 존재하지 않습니다...");
	                return;
	        }
	
	        // 삭제를 합니다... 혹시 플랫폼에 따라 
	        //퍼미션 오류(SecurityException)가 나올 수 있습니다....
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