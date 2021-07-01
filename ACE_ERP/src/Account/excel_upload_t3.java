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

public class excel_upload_t3 extends HttpServlet{
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

				///////////////////////////////////////////////////////////////////////////////
                //파일복사
                //복사할 파일 명
				o_name = System.currentTimeMillis()+".xls";
				//fExcelFilePath = "/HdAsan/Account/file/excel" + o_name;	
				
				//로컬
				//fExcelFilePath = "D:/myWorks/HDAsan/WebContent/Account/file/excel/"+ o_name;
				
				//서버
				fExcelFilePath = "/asanwas/account/excel/"+ o_name;
				
				
				//o_name = "temp201401180415.xls";
				//fExcelFilePath = "../Account/file/" + o_name;		
				//fExcelFilePath = "D:/"+o_name;
				//fExcelFilePath = "D:/"+o_name;
				
				//app/src/erpApp/Sales/file/excel
				
				
				//System.out.println("step3");
                //logger.dbg.println(this,"엑셀 생성파일 경로:"+fExcelFilePath); 
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
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					Sheet sheet0 = workbook.getSheet(0); // Sheet명 
					//System.out.println("=========ROW11:"+sheet0.getRows()); 
					String arr[][] = new String[sheet0.getRows()][60];
					
					for (int row = 0; row < sheet0.getRows(); row++) {		 
						// 숫자타입
						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							
							//System.out.println("=========column:"+column+"::"+sheet0.getCell(column,row).getType()); 
							
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
					   
					ds2.addDataColumn(new GauceDataColumn("COMPLEX",        GauceDataColumn.TB_STRING,20));       // 동  
					ds2.addDataColumn(new GauceDataColumn("FLOOR",          GauceDataColumn.TB_STRING,10));       // 층      
					ds2.addDataColumn(new GauceDataColumn("FR_NO",          GauceDataColumn.TB_STRING,10));       // 호수      
					ds2.addDataColumn(new GauceDataColumn("AREA",           GauceDataColumn.TB_DECIMAL,10,2));    // 임대면적          
					ds2.addDataColumn(new GauceDataColumn("HI_NM",          GauceDataColumn.TB_STRING,30));       // 상호      
					ds2.addDataColumn(new GauceDataColumn("HI_CRNO",        GauceDataColumn.TB_STRING,13));       // 사업자등록번호     
					ds2.addDataColumn(new GauceDataColumn("RE_IN_DT",       GauceDataColumn.TB_STRING,8));        // 입주일   
					ds2.addDataColumn(new GauceDataColumn("UP_DT",          GauceDataColumn.TB_STRING,8));        // 갱신일      
					ds2.addDataColumn(new GauceDataColumn("RE_OUT_DT",      GauceDataColumn.TB_STRING,8));        // 퇴거일      
					ds2.addDataColumn(new GauceDataColumn("RE_DEP_AMT",     GauceDataColumn.TB_DECIMAL,13,0));    // 보증금      
					ds2.addDataColumn(new GauceDataColumn("RE_MON_AMT",     GauceDataColumn.TB_DECIMAL,13,0));    // 월임대료      
					ds2.addDataColumn(new GauceDataColumn("RE_SUM_AMT",     GauceDataColumn.TB_DECIMAL,13,0));    // 임대수입금액합계
					ds2.addDataColumn(new GauceDataColumn("RE_DEP_INT_AMT", GauceDataColumn.TB_DECIMAL,13,0));    // 보증금이자계
					ds2.addDataColumn(new GauceDataColumn("RE_INCOME_AMT",  GauceDataColumn.TB_DECIMAL,13,0));    // 월임대료계
					
					ds2.addDataColumn(new GauceDataColumn("FDCODE",         GauceDataColumn.TB_STRING,2));        // 지점
					ds2.addDataColumn(new GauceDataColumn("RD_GB",          GauceDataColumn.TB_STRING,2));        // 레코드구분
					ds2.addDataColumn(new GauceDataColumn("YYYY",           GauceDataColumn.TB_STRING,4));        // 귀속년도
					ds2.addDataColumn(new GauceDataColumn("HF_GB",          GauceDataColumn.TB_STRING,1));        // 반기구분
					ds2.addDataColumn(new GauceDataColumn("HF_SEQ",         GauceDataColumn.TB_STRING,1));        // 반기내월 순번
					ds2.addDataColumn(new GauceDataColumn("CO_CRNO",        GauceDataColumn.TB_STRING,10));       // 제출자사업자등록번호
					ds2.addDataColumn(new GauceDataColumn("RD_SEQ_GB",      GauceDataColumn.TB_DECIMAL,6,0));     // 일련번호구분
					ds2.addDataColumn(new GauceDataColumn("RD_SEQ",         GauceDataColumn.TB_DECIMAL,6,0));     // 일련번호
					ds2.addDataColumn(new GauceDataColumn("UND_YN",         GauceDataColumn.TB_STRING,1));        // 지하여부
					ds2.addDataColumn(new GauceDataColumn("MINOR_NO",       GauceDataColumn.TB_DECIMAL,4,0));     // 종사업장일련번호
					ds2.addDataColumn(new GauceDataColumn("SPACE",          GauceDataColumn.TB_STRING,22));       // 공란
					ds2.addDataColumn(new GauceDataColumn("CREATE_ID",      GauceDataColumn.TB_STRING,10));       // 작성자
					ds2.addDataColumn(new GauceDataColumn("UPDATE_ID",      GauceDataColumn.TB_STRING,10));       // 수정자
					
					

					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */

					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 2; column < sheet0.getColumns()+1; column++) {
							//System.out.println("row::"+row+"::column::"+column);
							switch(column){
								case 5:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 11:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
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
								case 22:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 23:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;	
								case 25:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;		
								default:
									gRow.addColumnValue(arr[row][column]);
								    //System.out.println("row::"+row+"::column::"+column+":::::"+arr[row][column]);
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