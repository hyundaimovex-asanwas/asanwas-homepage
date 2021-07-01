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
import jxl.Sheet;
import jxl.Workbook; 
import jxl.read.biff.BiffException;

public class excel_upload_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				GauceDataSet excelDs = reqGauce.getGauceDataSet("USER");  //INPUT
				GauceDataSet ds2 = reqGauce.getGauceDataSet("USER2");     //OUTPUT 
				
				//데이타셋의 ROWS
				GauceDataRow[] 		excelRow = excelDs.getDataRows();    
				//데이타셋의 COLS
				GauceDataColumn[] 	excelCol = excelDs.getDataColumns();

				int idxEXCEL_INFO = excelDs.indexOfColumn("EXCEL_INFO");
				int idxEXCEL_URL  = excelDs.indexOfColumn("EXCEL_URL");
  
				String d_name = excelRow[0].getString(idxEXCEL_INFO);
				String o_name = excelRow[0].getString(0).trim();
				///////////////////////////////////////////////////////////////////////////////
				
				//파일복사
				//복사할 파일 명
				o_name = "tempbincomefile001.xls";
				
				File saveDir = new File("C:/temp");
				if(!saveDir.exists()){
					saveDir.mkdirs();
				}
				fExcelFilePath = saveDir+"/"+o_name;
				
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
					Workbook workbook1 = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명  워크북생성					
					Sheet sheet0 = workbook1.getSheet(0); // Sheet명
					String arr[][] = new String[sheet0.getRows()][60];
					
					for (int row = 0; row < sheet0.getRows(); row++) {		 
						// 숫자타입
						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							
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
					ds2.addDataColumn(new GauceDataColumn("VEND_CD",     GauceDataColumn.TB_STRING, 13)); // 
					ds2.addDataColumn(new GauceDataColumn("VEND_NM",     GauceDataColumn.TB_STRING, 62)); // 
					ds2.addDataColumn(new GauceDataColumn("VEND_ID",     GauceDataColumn.TB_STRING, 15)); // 
					ds2.addDataColumn(new GauceDataColumn("VEND_NO",     GauceDataColumn.TB_STRING, 13)); // 
					ds2.addDataColumn(new GauceDataColumn("VD_DIRECT",   GauceDataColumn.TB_STRING, 62)); // 
					ds2.addDataColumn(new GauceDataColumn("BSNS_CND",    GauceDataColumn.TB_STRING, 62)); // 
					ds2.addDataColumn(new GauceDataColumn("BSNS_KND",    GauceDataColumn.TB_STRING, 62)); // 
					ds2.addDataColumn(new GauceDataColumn("VD_TELNO",    GauceDataColumn.TB_STRING, 32)); // 
					ds2.addDataColumn(new GauceDataColumn("VD_FAXNO",    GauceDataColumn.TB_STRING, 32)); // 
					ds2.addDataColumn(new GauceDataColumn("POST_NO1",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("POST_NO2",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("ADDRESS1",    GauceDataColumn.TB_STRING, 132));// 
					ds2.addDataColumn(new GauceDataColumn("ADDRESS2",    GauceDataColumn.TB_STRING, 72)); // 
					ds2.addDataColumn(new GauceDataColumn("C_BANKCD",    GauceDataColumn.TB_STRING, 5));  // 
					ds2.addDataColumn(new GauceDataColumn("C_ACCTNO",    GauceDataColumn.TB_STRING, 22)); // 
					ds2.addDataColumn(new GauceDataColumn("C_ACCTNO_NM", GauceDataColumn.TB_STRING, 32)); // 
					ds2.addDataColumn(new GauceDataColumn("C_ACCTNM",    GauceDataColumn.TB_STRING, 32)); // 
					ds2.addDataColumn(new GauceDataColumn("B_BANKCD",    GauceDataColumn.TB_STRING, 5));  // 
					ds2.addDataColumn(new GauceDataColumn("B_ACCTNO",    GauceDataColumn.TB_STRING, 22)); // 
					ds2.addDataColumn(new GauceDataColumn("B_ACCTNO_NM", GauceDataColumn.TB_STRING, 32)); // 
					ds2.addDataColumn(new GauceDataColumn("B_ACCTNM",    GauceDataColumn.TB_STRING, 32)); // 
					ds2.addDataColumn(new GauceDataColumn("O_VENDGB",    GauceDataColumn.TB_STRING, 1));  // 
					ds2.addDataColumn(new GauceDataColumn("O_VENDCD",    GauceDataColumn.TB_STRING, 13)); // 
					ds2.addDataColumn(new GauceDataColumn("VEND_MAG",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("USE_TAG",     GauceDataColumn.TB_STRING, 1));  // 
					ds2.addDataColumn(new GauceDataColumn("REMARK",      GauceDataColumn.TB_STRING, 66)); // 
					ds2.addDataColumn(new GauceDataColumn("CREAT_DT",    GauceDataColumn.TB_STRING, 12)); // 
					ds2.addDataColumn(new GauceDataColumn("CREAT_NM",    GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("MSN",         GauceDataColumn.TB_STRING, 13)); // 
					ds2.addDataColumn(new GauceDataColumn("MPWD",        GauceDataColumn.TB_STRING, 20)); // 
					ds2.addDataColumn(new GauceDataColumn("COCOMYN",     GauceDataColumn.TB_STRING, 1));  // 
					ds2.addDataColumn(new GauceDataColumn("H_VEND_CD",   GauceDataColumn.TB_STRING, 13));  // 
					ds2.addDataColumn(new GauceDataColumn("H_VEND_NM",   GauceDataColumn.TB_STRING, 62)); // 
					ds2.addDataColumn(new GauceDataColumn("IUGB",        GauceDataColumn.TB_STRING, 1)); // 
					ds2.addDataColumn(new GauceDataColumn("WRDT",        GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("WRID",        GauceDataColumn.TB_STRING, 13)); // 
					ds2.addDataColumn(new GauceDataColumn("UPDT",        GauceDataColumn.TB_STRING, 10)); // 
					ds2.addDataColumn(new GauceDataColumn("UPID",        GauceDataColumn.TB_STRING, 13));  //

					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
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

						//gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds2.addDataRow(gRow);
            //StringUtil.printMsg("row value ["+ row + "]", row, this);
					}
					ds2.flush();
				}

			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				System.out.println("e11:"+e.getMessage());
				
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
			
			deleteExcelFile(fExcelFilePath);
			
		}
		catch (Exception e) {
			System.out.println("e12:"+e.getMessage());
			//System.err.println(e.toString());
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