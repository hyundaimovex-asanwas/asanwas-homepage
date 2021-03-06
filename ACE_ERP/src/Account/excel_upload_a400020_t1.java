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

public class excel_upload_a400020_t1 extends HttpServlet{
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
				o_name = System.currentTimeMillis()+".xls";
				//fExcelFilePath = "/HdAsan/Account/file/excel" + o_name;	
				
				//로컬
				fExcelFilePath = "D:/myWorks/HDAsan/WebContent/Account/file/excel/"+ o_name;
				
				//서버
				//fExcelFilePath = "/asanwas/account/excel/"+ o_name;
				
				
				//o_name = "temp201401180415.xls";
				//fExcelFilePath = "../Account/file/" + o_name;		
				//fExcelFilePath = "D:/"+o_name;
				//fExcelFilePath = "D:/"+o_name;
				
				//app/src/erpApp/Sales/file/excel
				
				
				System.out.println("step3");
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
					System.out.println("=========ROW11:"+sheet0.getRows()); 
					String arr[][] = new String[sheet0.getRows()][60];
					
					for (int row = 0; row < sheet0.getRows(); row++) {		 
						// 숫자타입
						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							
							System.out.println("=========column:"+column+"::"+sheet0.getCell(column,row).getType()); 
							
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
					   
					ds2.addDataColumn(new GauceDataColumn("ACCTNO",   GauceDataColumn.TB_STRING,30));       //계좌번호   1
					ds2.addDataColumn(new GauceDataColumn("DEALDT",   GauceDataColumn.TB_STRING,20));       //거래일시   2
					
					ds2.addDataColumn(new GauceDataColumn("REMARK",   GauceDataColumn.TB_STRING,100));      //적요         4
					ds2.addDataColumn(new GauceDataColumn("CURUNIT",  GauceDataColumn.TB_STRING,6));        //통화명      11
					
					ds2.addDataColumn(new GauceDataColumn("INAMT",    GauceDataColumn.TB_DECIMAL,15,2));    //입금액      5
					ds2.addDataColumn(new GauceDataColumn("OUTAMT",   GauceDataColumn.TB_DECIMAL,15,2));    //출금액      6
					ds2.addDataColumn(new GauceDataColumn("BALAMT",   GauceDataColumn.TB_DECIMAL,15,2));    //잔액         7
					ds2.addDataColumn(new GauceDataColumn("FINAMT",   GauceDataColumn.TB_DECIMAL,15,2));    //외화입금액8   
					ds2.addDataColumn(new GauceDataColumn("FOUTAMT",  GauceDataColumn.TB_DECIMAL,15,2));    //외화출금액9  
					ds2.addDataColumn(new GauceDataColumn("FBALAMT",  GauceDataColumn.TB_DECIMAL,15,2));    //외화잔액   10      
					
					ds2.addDataColumn(new GauceDataColumn("EXRATE",   GauceDataColumn.TB_DECIMAL,6,2));     //환율         12
					ds2.addDataColumn(new GauceDataColumn("TRISSUE",  GauceDataColumn.TB_STRING,60));       //특이사항   13
					ds2.addDataColumn(new GauceDataColumn("DEDATE",   GauceDataColumn.TB_STRING,8));        //거래일자   14 
					ds2.addDataColumn(new GauceDataColumn("DETIME",   GauceDataColumn.TB_STRING,8));        //거래시간   15
					ds2.addDataColumn(new GauceDataColumn("RESULT",   GauceDataColumn.TB_STRING,10));       //실적구분   16
					ds2.addDataColumn(new GauceDataColumn("RSTREMARK",GauceDataColumn.TB_STRING,60));       //실적적요   17
					ds2.addDataColumn(new GauceDataColumn("RSTSEQ",   GauceDataColumn.TB_DECIMAL,3,0));     //실적순서   18
					ds2.addDataColumn(new GauceDataColumn("TEAM",     GauceDataColumn.TB_STRING,10));       //사용팀      19
					ds2.addDataColumn(new GauceDataColumn("INRATE",   GauceDataColumn.TB_DECIMAL,4,2));     //이자율      20
					ds2.addDataColumn(new GauceDataColumn("WRID",     GauceDataColumn.TB_STRING,10));       //입력자      21
					ds2.addDataColumn(new GauceDataColumn("ACCTCD",   GauceDataColumn.TB_STRING,10));       //계좌코드   3
					ds2.addDataColumn(new GauceDataColumn("COSTCD",   GauceDataColumn.TB_STRING,10));       //원가코드   10
					ds2.addDataColumn(new GauceDataColumn("COSTNM",   GauceDataColumn.TB_STRING,100));      //원가명    100
					

					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */

					for (int row = 2; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							//System.out.println("row::"+row+"::column::"+column);
							System.out.println("row::"+row+"::column::"+column+":::::"+arr[row][column]);
							
							if(arr[row][4]!="WON"){
								//arr[row][8] =arr[row][5];
								//arr[row][9] =arr[row][6];
								//arr[row][10]=arr[row][7];
							}
							
							switch(column){
								case 5:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 6:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 7:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 8:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 9:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 10:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 12:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;
								case 18:
									gRow.addColumnValue(Double.parseDouble(arr[row][column]));
									break;	
								case 20:
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