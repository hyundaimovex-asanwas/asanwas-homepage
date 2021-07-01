package sales.menu.sy;

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

public class Sy511B extends SuperServlet {
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_SY510B_01(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?)");
		
		arr_sql[2].append("CALL SALES.PR_SY510B_02(?,?,?,?,?,")
				  .append(                        "?,?,")
				  .append(                        "?,?)");
		
		arr_sql[3].append("CALL SALES.PR_SY510B_03(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?)");
		
		arr_sql[4].append("CALL SALES.PR_SY510B_04(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?)");
		
		arr_sql[5].append("CALL SALES.PR_SY510B_05(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,")
				  .append(                        "?,?)");
		
		arr_sql[6].append("CALL SALES.PR_SY510B_06(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?)");
		arr_sql[7].append("CALL SALES.PR_SY510B_07(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?)");
		arr_sql[8].append("CALL SALES.PR_SY510B_08(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,?,?,?)");
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
//		StringUtil.printMsg("DS TYPE","선조회",this);
		
		System.out.println("# Command : 선조회");

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

//StringUtil.printMsg("============================", "", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		ResultSetMetaData rsmd = null;
		
		String[] 			columnName 	= null;
		
		/* DataSet */
		GauceDataSet excelDs = req.getGauceDataSet("TEMP_EXCEL");//엑셀파일; 
		
		GauceDataSet ds1 = req.getGauceDataSet("EXCELDS1"); //엑셀적용;
		GauceDataSet ds2 = req.getGauceDataSet("EXCELDS2"); //엑셀적용;
		GauceDataSet ds3 = req.getGauceDataSet("EXCELDS3"); //엑셀적용;
		GauceDataSet ds4 = req.getGauceDataSet("EXCELDS4"); //엑셀적용;
		GauceDataSet ds5 = req.getGauceDataSet("EXCELDS5"); //엑셀적용;
		GauceDataSet ds6 = req.getGauceDataSet("EXCELDS6"); //엑셀적용;
		GauceDataSet ds7 = req.getGauceDataSet("EXCELDS7"); //엑셀적용;
		GauceDataSet ds8 = req.getGauceDataSet("EXCELDS8"); //엑셀적용;
		
		/*
		 * 검색시 필요한 조건
		 */
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid")); 
		try {
				
			// 파일 업로드 
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
					
//					StringUtil.printMsg("엑셀 생성파일 경로:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}
				
				// 영업장정보
				if (ds1 != null) {
					res.enableFirstRow(ds1);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(0); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					ds1.addDataColumn(new GauceDataColumn("UPJANG_SID",      	GauceDataColumn.TB_DECIMAL)); // 0
					ds1.addDataColumn(new GauceDataColumn("UPJANG_CD",      	GauceDataColumn.TB_STRING, 10));  // 1
					ds1.addDataColumn(new GauceDataColumn("UPJANG_NM",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds1.addDataColumn(new GauceDataColumn("UPJANG_ENG_NM",      GauceDataColumn.TB_STRING, 30)); // 2
					ds1.addDataColumn(new GauceDataColumn("UPJANG_SHORT_NM",    GauceDataColumn.TB_STRING, 30)); // 2
					ds1.addDataColumn(new GauceDataColumn("UPJANG_TYPE",        GauceDataColumn.TB_STRING, 30)); // 2
					ds1.addDataColumn(new GauceDataColumn("DIRECT_YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds1.addDataColumn(new GauceDataColumn("USE_YN",        		GauceDataColumn.TB_STRING, 30)); // 2
					ds1.addDataColumn(new GauceDataColumn("DISPLAY_SEQ",        GauceDataColumn.TB_DECIMAL)); // 2
					ds1.addDataColumn(new GauceDataColumn("REMARKS",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds1.addDataColumn(new GauceDataColumn("SAUP_SID",        	GauceDataColumn.TB_DECIMAL)); // 2
					
					ds1.addDataColumn(new GauceDataColumn("YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds1.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds1.addDataRow(gRow);
					}
					ds1.flush();
				}
				
				// 동정보
				if (ds2 != null) {
					res.enableFirstRow(ds2);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(1); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					ds2.addDataColumn(new GauceDataColumn("DONG_SID",      	GauceDataColumn.TB_DECIMAL)); // 0
					ds2.addDataColumn(new GauceDataColumn("DONG_CD",      	GauceDataColumn.TB_STRING, 10));  // 1
					ds2.addDataColumn(new GauceDataColumn("DONG_NM",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("DONG_ENG_NM",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("DONG_SHORT_NM",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("UPJANG_SID",    	GauceDataColumn.TB_DECIMAL)); // 2
					
					ds2.addDataColumn(new GauceDataColumn("YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
//							StringUtil.printMsg("Value = " , arr[row][column], this);
							gRow.addColumnValue(arr[row][column]);
						}
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds2.addDataRow(gRow);
					}
					ds2.flush();
				}				
				
				// 엑셀 읽기
				if (ds3 != null) {
					res.enableFirstRow(ds3);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(2); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					
           			
					ds3.addDataColumn(new GauceDataColumn("ROOM_TYPE_SID",      GauceDataColumn.TB_DECIMAL)); // 0
					ds3.addDataColumn(new GauceDataColumn("UPJANG_SID",      	GauceDataColumn.TB_DECIMAL));  // 1
					ds3.addDataColumn(new GauceDataColumn("ROOM_GRADE_CD",      GauceDataColumn.TB_STRING, 30)); // 2
					ds3.addDataColumn(new GauceDataColumn("BED_TYPE_CD",      	GauceDataColumn.TB_STRING, 30)); // 2
					ds3.addDataColumn(new GauceDataColumn("ROOM_TYPE_CD",    	GauceDataColumn.TB_STRING, 30)); // 2
					ds3.addDataColumn(new GauceDataColumn("ROOM_TYPE_NM",       GauceDataColumn.TB_STRING, 30)); // 2
					ds3.addDataColumn(new GauceDataColumn("PYUNG",        		GauceDataColumn.TB_STRING, 30)); // 2
					ds3.addDataColumn(new GauceDataColumn("STD_PERSONS",       	GauceDataColumn.TB_DECIMAL)); // 2
					ds3.addDataColumn(new GauceDataColumn("MAX_PERSONS",        GauceDataColumn.TB_DECIMAL)); // 2
					ds3.addDataColumn(new GauceDataColumn("DISPLAY_SEQ",       	GauceDataColumn.TB_DECIMAL)); // 2
					ds3.addDataColumn(new GauceDataColumn("USE_YN",        		GauceDataColumn.TB_STRING, 30)); // 2
					
					ds3.addDataColumn(new GauceDataColumn("YN",        			GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds3.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							gRow.addColumnValue(arr[row][column]);
						}
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds3.addDataRow(gRow);
					}
					ds3.flush();
				}				
				
				// 엑셀 읽기
				if (ds4 != null) {
					res.enableFirstRow(ds4);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(3); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					ds4.addDataColumn(new GauceDataColumn("ROOM_SID",      	GauceDataColumn.TB_DECIMAL)); // 0
					ds4.addDataColumn(new GauceDataColumn("ROOM_NO",      	GauceDataColumn.TB_STRING, 10));  // 1
					ds4.addDataColumn(new GauceDataColumn("BGN_DATE",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds4.addDataColumn(new GauceDataColumn("END_DATE",      GauceDataColumn.TB_STRING, 30)); // 2
					ds4.addDataColumn(new GauceDataColumn("ROOM_VIEW_CD",    GauceDataColumn.TB_STRING, 30)); // 2
					ds4.addDataColumn(new GauceDataColumn("FLOORS",        		GauceDataColumn.TB_STRING, 30)); // 2
					ds4.addDataColumn(new GauceDataColumn("USE_YN",        GauceDataColumn.TB_STRING, 30)); // 2
					ds4.addDataColumn(new GauceDataColumn("UPJANG_SID",        	GauceDataColumn.TB_DECIMAL)); // 2
					ds4.addDataColumn(new GauceDataColumn("DONG_SID",        	GauceDataColumn.TB_DECIMAL)); // 2
					ds4.addDataColumn(new GauceDataColumn("ROOM_TYPE_SID",        	GauceDataColumn.TB_DECIMAL)); // 2
					ds4.addDataColumn(new GauceDataColumn("REMARKS",        	GauceDataColumn.TB_STRING, 30)); // 2
					
					ds4.addDataColumn(new GauceDataColumn("YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds4.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds4.addDataRow(gRow);
					}
					ds4.flush();
				}				
				
				// 엑셀 읽기
				if (ds5 != null) {
					res.enableFirstRow(ds5);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(4); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					ds5.addDataColumn(new GauceDataColumn("GOODS_SID",      	GauceDataColumn.TB_DECIMAL)); // 0
					ds5.addDataColumn(new GauceDataColumn("GOODS_CD",      	GauceDataColumn.TB_STRING, 10));  // 1
					ds5.addDataColumn(new GauceDataColumn("GOODS_NM",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds5.addDataColumn(new GauceDataColumn("ENG_NM",      GauceDataColumn.TB_STRING, 30)); // 2
					ds5.addDataColumn(new GauceDataColumn("COURSE",    GauceDataColumn.TB_STRING, 30)); // 2
					ds5.addDataColumn(new GauceDataColumn("NIGHTS",        GauceDataColumn.TB_DECIMAL)); // 2
					ds5.addDataColumn(new GauceDataColumn("DAYS",        	GauceDataColumn.TB_DECIMAL)); // 2
					ds5.addDataColumn(new GauceDataColumn("USE_YN",        		GauceDataColumn.TB_STRING, 30)); // 2
					
					ds5.addDataColumn(new GauceDataColumn("YN",        		GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds5.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds5.addDataRow(gRow);
					}
					ds5.flush();
				}			

				// 엑셀 읽기
				if (ds6 != null) {
					res.enableFirstRow(ds6);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(5); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					ds6.addDataColumn(new GauceDataColumn("HEAD",      	GauceDataColumn.TB_STRING, 5)); // 0
					ds6.addDataColumn(new GauceDataColumn("DETAIL",      	GauceDataColumn.TB_STRING, 10));  // 1
					ds6.addDataColumn(new GauceDataColumn("DETAIL_NM",        	GauceDataColumn.TB_STRING, 50)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM1",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM2",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM3",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM4",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM5",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM6",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM7",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM8",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM9",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM10",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM11",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM12",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM13",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM14",      GauceDataColumn.TB_STRING, 16)); // 2
					ds6.addDataColumn(new GauceDataColumn("ITEM15",      GauceDataColumn.TB_STRING, 16)); // 2
					
					ds6.addDataColumn(new GauceDataColumn("YN",      GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds6.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds6.addDataRow(gRow);
					}
					ds6.flush();
				}		
				// 엑셀 읽기
				if (ds7 != null) {
					res.enableFirstRow(ds7);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(6); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					ds7.addDataColumn(new GauceDataColumn("CLIENT_SID",      	GauceDataColumn.TB_DECIMAL)); // 0
					ds7.addDataColumn(new GauceDataColumn("VEND_CD",      	GauceDataColumn.TB_STRING, 10));  // 1
					ds7.addDataColumn(new GauceDataColumn("CLIENT_CD",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("CLIENT_NM",      GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("CLIENT_GU",    GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("AGEN_GU",        GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("DIR_YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("AREA_CD",        		GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("SAL_DAM_SID",        GauceDataColumn.TB_DECIMAL)); // 2
					ds7.addDataColumn(new GauceDataColumn("CLIENT_DAM_NM",        	GauceDataColumn.TB_STRING, 30)); // 2
					
					ds7.addDataColumn(new GauceDataColumn("TEL_NO",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("MOBILE_NO",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("FAX_NO",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("E_MAIL",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("ZIP_CD",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("ADDRESS1",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("ADDRESS2",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("COMMI_RATE",        	GauceDataColumn.TB_DECIMAL)); // 2
					ds7.addDataColumn(new GauceDataColumn("CUNT_STATUS",        	GauceDataColumn.TB_STRING, 30)); // 2
					
					ds7.addDataColumn(new GauceDataColumn("BANCOD",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("BANK_ACC_NO",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("BANK_ACCT_NM",        	GauceDataColumn.TB_STRING, 30)); // 2
					ds7.addDataColumn(new GauceDataColumn("USE_YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					
					ds7.addDataColumn(new GauceDataColumn("YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds7.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds7.addDataRow(gRow);
					}
					ds7.flush();
				}
				
				// 영업장정보
				if (ds8 != null) {
					res.enableFirstRow(ds8);
					
//					StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(7); // Sheet명 
					
//					StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
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
							
					/*
					 * DataSet Header
					 */
					
					ds8.addDataColumn(new GauceDataColumn("MENU_SID", 		GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("MENU_CD", 		GauceDataColumn.TB_STRING, 13));
					ds8.addDataColumn(new GauceDataColumn("MENU_GUBUN_CD", 	GauceDataColumn.TB_STRING, 2));
					ds8.addDataColumn(new GauceDataColumn("MENU_ITEM1", 	GauceDataColumn.TB_STRING, 5));
					ds8.addDataColumn(new GauceDataColumn("MENU_ITEM2", 	GauceDataColumn.TB_STRING, 5));
					
					ds8.addDataColumn(new GauceDataColumn("MENU_ITEM3", 	GauceDataColumn.TB_STRING, 5));
					ds8.addDataColumn(new GauceDataColumn("MENU_ITEM4", 	GauceDataColumn.TB_STRING, 5));
					ds8.addDataColumn(new GauceDataColumn("MENU_ITEM5", 	GauceDataColumn.TB_STRING, 5));
					ds8.addDataColumn(new GauceDataColumn("BGN_DATE", 		GauceDataColumn.TB_STRING, 8));
					ds8.addDataColumn(new GauceDataColumn("END_DATE", 		GauceDataColumn.TB_STRING, 8));
					
					ds8.addDataColumn(new GauceDataColumn("BGN_PERSONS", 	GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("END_PERSONS", 	GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("MENU_NM", 		GauceDataColumn.TB_STRING, 50));
					ds8.addDataColumn(new GauceDataColumn("MENU_ENG_NM", 	GauceDataColumn.TB_STRING, 30));
					ds8.addDataColumn(new GauceDataColumn("MENU_SHORT_NM", 	GauceDataColumn.TB_STRING, 12));
					
					ds8.addDataColumn(new GauceDataColumn("TAX_YN", 		GauceDataColumn.TB_STRING, 1));
					ds8.addDataColumn(new GauceDataColumn("TAX_CALCU_CD", 	GauceDataColumn.TB_STRING, 1));
					ds8.addDataColumn(new GauceDataColumn("UNIT_AMT", 		GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("NET_AMT", 		GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("VAT_AMT", 		GauceDataColumn.TB_DECIMAL));
					
					ds8.addDataColumn(new GauceDataColumn("EXCISE_AMT", 	GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("EDU_AMT", 		GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("VILLAGE_AMT", 	GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("SPORTS_AMT", 	GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("TOUR_AMT", 		GauceDataColumn.TB_DECIMAL));
					
					ds8.addDataColumn(new GauceDataColumn("ASSOC_AMT", 		GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("TIP_AMT", 		GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("CURRENCY_CD", 	GauceDataColumn.TB_STRING, 3));
					ds8.addDataColumn(new GauceDataColumn("OPTION_YN", 		GauceDataColumn.TB_STRING, 1));
					ds8.addDataColumn(new GauceDataColumn("OPTION_VIEW_CD", 	GauceDataColumn.TB_STRING, 1));
					
					ds8.addDataColumn(new GauceDataColumn("DISPLAY_SEQ", 	GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("USE_YN", 		GauceDataColumn.TB_STRING, 1));
					ds8.addDataColumn(new GauceDataColumn("SAUP_SID", 		GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("UPJANG_SID", 	GauceDataColumn.TB_DECIMAL));
					ds8.addDataColumn(new GauceDataColumn("REMARKS", 		GauceDataColumn.TB_STRING, 100));
					
					ds8.addDataColumn(new GauceDataColumn("YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds8.newDataRow();
						StringUtil.printMsg("ttttt",this);
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							StringUtil.printMsg("ttttt", arr[row][column], this);
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds8.addDataRow(gRow);
					}
					ds8.flush();
				}
				
				deleteExcelFile(fExcelFilePath);
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
	GauceDataSet ds_result = req.getGauceDataSet("RESULT");
		
		if(ds_result!=null){
			res.enableFirstRow(ds_result);
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		try {
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("EXCELDS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						
						int colNm_UpjangSid  		= ds1.indexOfColumn("UPJANG_SID");
						int colNm_UpjangCd  		= ds1.indexOfColumn("UPJANG_CD");
						int colNm_UpjangNm  		= ds1.indexOfColumn("UPJANG_NM");
						int colNm_UpjangEng_nm  	= ds1.indexOfColumn("UPJANG_ENG_NM");
						int colNm_UpjangShort_nm  	= ds1.indexOfColumn("UPJANG_SHORT_NM");
						int colNm_UpjangType  		= ds1.indexOfColumn("UPJANG_TYPE");
						int colNm_DirectYn  		= ds1.indexOfColumn("DIRECT_YN");
						int colNm_UseYn  			= ds1.indexOfColumn("USE_YN");
						int colNm_Remarks  			= ds1.indexOfColumn("REMARKS");
						int colNm_DisplaySeq  		= ds1.indexOfColumn("DISPLAY_SEQ");
						int colNm_SaupSid  			= ds1.indexOfColumn("SAUP_SID");
						
						for(int i=0; i<rows.length; i++){
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
								
//								StringUtil.printMsg("INSERT",this);
								cstmt = conn.prepareCall(arr_sql[1].toString());
								
								cstmt.setInt(1, rows[i].getInt(colNm_UpjangSid));// 업장 sid
								
								cstmt.setString(2, rows[i].getString(colNm_UpjangCd));		// 업장코드
								cstmt.setString(3, rows[i].getString(colNm_UpjangNm));		// 업장명
								cstmt.setString(4, rows[i].getString(colNm_UpjangEng_nm));		// 업장영문명
								cstmt.setString(5, rows[i].getString(colNm_UpjangShort_nm));		// 업장단축명
								
								cstmt.setString(6, rows[i].getString(colNm_UpjangType));		// 업장타입
								cstmt.setString(7, rows[i].getString(colNm_DirectYn));		// 직영여부
								cstmt.setString(8, "");	// 마감일자
								cstmt.setString(9, rows[i].getString(colNm_UseYn));	// 사용여부
								cstmt.setString(10, rows[i].getString(colNm_Remarks));	// 참고사항
								
								cstmt.setInt(11, rows[i].getInt(colNm_SaupSid));	// 사업소sid
								
								cstmt.setInt(12, rows[i].getInt(colNm_DisplaySeq));	// 출력순서
								cstmt.setString(13, "");	// 반
								
								cstmt.registerOutParameter(14, java.sql.Types.VARCHAR); // 성공YN
								cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); // 메세지 코드
								cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//메세지
								// 쿼리실행
								cstmt.executeUpdate();
								
								if(!cstmt.getString(14).equals("Y"))
									throw new Exception (cstmt.getString(16));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(14));
									row1.addColumnValue(cstmt.getString(15));
									row1.addColumnValue(cstmt.getString(16));
									
									ds_result.addDataRow(row1);
								}
							}
						}
					}
				
					
                    
					if ("EXCELDS2".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						GauceDataColumn[] 	cols = ds1.getDataColumns();                                   
						                                                                                   
						int colNm_DongSid  			= ds1.indexOfColumn("DONG_SID");		// 동sid       
						int colNm_DongCd  			= ds1.indexOfColumn("DONG_CD");			// 동코드      
						int colNm_DongNm  			= ds1.indexOfColumn("DONG_NM");			// 동이름      
						int colNm_DongEng_nm  		= ds1.indexOfColumn("DONG_ENG_NM");		// 영문명      
						int colNm_DongShort_nm  	= ds1.indexOfColumn("DONG_SHORT_NM");	// 단축명      
						int colNm_UpjangSid  		= ds1.indexOfColumn("UPJANG_SID");		// 업장 sid    
						                                                                                   
						                                                                                   
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
						                                                                                   
//								StringUtil.printMsg("INSERT",this);                                        
								cstmt = conn.prepareCall(arr_sql[2].toString());                           
								                                                                           
								cstmt.setInt(1, rows[i].getInt(colNm_DongSid));                            
								cstmt.setString(2, rows[i].getString(colNm_DongCd));                       
								cstmt.setString(3, rows[i].getString(colNm_DongNm));                       
								cstmt.setString(4, rows[i].getString(colNm_DongEng_nm));                   
								cstmt.setString(5, rows[i].getString(colNm_DongShort_nm));        
								
								cstmt.setInt(6, rows[i].getInt(colNm_UpjangSid));                          

								cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); // 성공YN          
								cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); // 메세지 코드     
								cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//메세지           
								// 쿼리실행                                                                
								cstmt.executeUpdate();       
								
								if(!cstmt.getString(7).equals("Y"))
									throw new Exception (cstmt.getString(9));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(7));
									row1.addColumnValue(cstmt.getString(8));
									row1.addColumnValue(cstmt.getString(9));
									
									ds_result.addDataRow(row1);
								}
							}                                                                              
						}                                                                                  
					}                                                                                      
					
					if ("EXCELDS3".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						GauceDataColumn[] 	cols = ds1.getDataColumns();                                   
						 
//						StringUtil.printMsg("DS3 컬럼 ", cols.length, this);
						int colNm_RoomType_sid  	= ds1.indexOfColumn("ROOM_TYPE_SID");	// 객실타입sid 
						int colNm_UpjangSid  		= ds1.indexOfColumn("UPJANG_SID");		// 업장 sid    
						int colNm_RoomGrade_cd  	= ds1.indexOfColumn("ROOM_GRADE_CD");	// 객실등급코드
						int colNm_BedType_cd  		= ds1.indexOfColumn("BED_TYPE_CD");		// 배드타입    
						int colNm_RoomType_cd  		= ds1.indexOfColumn("ROOM_TYPE_CD");	// 객실타입    
						
						int colNm_RoomType_nm  		= ds1.indexOfColumn("ROOM_TYPE_NM");	// 객실타입명  
						int colNm_Pyung  			= ds1.indexOfColumn("PYUNG");			// 평형        
						int colNm_StdPersons  		= ds1.indexOfColumn("STD_PERSONS");		// 최소인원    
						int colNm_MaxPersons  		= ds1.indexOfColumn("MAX_PERSONS");		// 최대인원    
						int colNm_DisplaySeq  		= ds1.indexOfColumn("DISPLAY_SEQ");		// 화면표시순서
						
						int colNm_UseYn  			= ds1.indexOfColumn("USE_YN");			// 사용여부    
						                                                  
						
					
						                                                                                   
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
								
								cstmt = conn.prepareCall(arr_sql[3].toString());                           
								                                                                           
								cstmt.setInt(1, rows[i].getInt(colNm_RoomType_sid)); 
								cstmt.setInt(2, rows[i].getInt(colNm_UpjangSid));
								cstmt.setString(3, rows[i].getString(colNm_RoomGrade_cd));
								cstmt.setString(4, rows[i].getString(colNm_BedType_cd));
								cstmt.setString(5, rows[i].getString(colNm_RoomType_cd));   
								
								cstmt.setString(6, rows[i].getString(colNm_RoomType_nm));
								cstmt.setString(7, rows[i].getString(colNm_Pyung));
								cstmt.setInt(8, rows[i].getInt(colNm_StdPersons));
								cstmt.setInt(9, rows[i].getInt(colNm_MaxPersons));
								cstmt.setInt(10, rows[i].getInt(colNm_DisplaySeq));         
								
								cstmt.setString(11, rows[i].getString(colNm_UseYn));                       
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); // 성공YN          
								cstmt.registerOutParameter(13, java.sql.Types.VARCHAR); // 메세지 코드
								cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);	//메세지
								// 쿼리실행                                                                
								cstmt.executeUpdate();   
								
								if(!cstmt.getString(12).equals("Y"))
									throw new Exception (cstmt.getString(14));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(12));
									row1.addColumnValue(cstmt.getString(13));
									row1.addColumnValue(cstmt.getString(14));
									
									ds_result.addDataRow(row1);
								}
							}                                                                              
						}                                                                                  
					}  
					
					
					if ("EXCELDS4".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						GauceDataColumn[] 	cols = ds1.getDataColumns();                                   
						                                                                                   
						int colNm_RoomSid  		= ds1.indexOfColumn("ROOM_SID");			// 객실sid	   
						int colNm_RoomNo  		= ds1.indexOfColumn("ROOM_NO");				// 객실번호    
						int colNm_BgnDate  		= ds1.indexOfColumn("BGN_DATE");			// 시작일자    
						int colNm_EndDate  		= ds1.indexOfColumn("END_DATE");			// 종료일자    
						int colNm_RoomView_cd  	= ds1.indexOfColumn("ROOM_VIEW_CD");		// 객실전망 
						                                                                                   
						int colNm_Floors  		= ds1.indexOfColumn("FLOORS");				// 객실층      
						int colNm_UseYn  		= ds1.indexOfColumn("USE_YN");				// 사용여부    
						int colNm_UpjangSid  	= ds1.indexOfColumn("UPJANG_SID");			// 사업장 sid  
						int colNm_DongSid  		= ds1.indexOfColumn("DONG_SID");			// 동 sid      
						int colNm_RoomType_sid  = ds1.indexOfColumn("ROOM_TYPE_SID");		// 객실타입 sid
						
						int colNm_Remarks  		= ds1.indexOfColumn("REMARKS");				// 참고사항    
	                                                                                                       
						                                                                                   
						                                                                                   
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
//								StringUtil.printMsg("INSERT",this);                                        
								cstmt = conn.prepareCall(arr_sql[4].toString());                           
								                                                                           
								                                                                           
								cstmt.setInt(1, rows[i].getInt(colNm_RoomSid));                            
								cstmt.setString(2, rows[i].getString(colNm_RoomNo));                       
								cstmt.setString(3, rows[i].getString(colNm_BgnDate));                      
								cstmt.setString(4, rows[i].getString(colNm_EndDate));                      
								cstmt.setString(5, rows[i].getString(colNm_RoomView_cd));                  
								                                                                           
								cstmt.setString(6, "");                  
								cstmt.setString(7, "");                   
								cstmt.setString(8, rows[i].getString(colNm_Floors));                       
								cstmt.setString(9, rows[i].getString(colNm_UseYn));                        
								cstmt.setInt(10, rows[i].getInt(colNm_UpjangSid));                         
								                                                                           
								cstmt.setInt(11, rows[i].getInt(colNm_DongSid));                           
								cstmt.setInt(12, rows[i].getInt(colNm_RoomType_sid));                      
								cstmt.setString(13, rows[i].getString(colNm_Remarks));                     
								                                                                           
								cstmt.registerOutParameter(14, java.sql.Types.VARCHAR); // 성공YN          
								cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); // 메세지 코드     
								cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//메세지           
								// 쿼리실행                                                                
								cstmt.executeUpdate();             
								
								if(!cstmt.getString(14).equals("Y"))
									throw new Exception (cstmt.getString(16));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(14));
									row1.addColumnValue(cstmt.getString(15));
									row1.addColumnValue(cstmt.getString(16));
									
									ds_result.addDataRow(row1);
								}
							}                                                                                  
						}                                                                                      
					}                                                                                      
					     
					if ("EXCELDS5".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						GauceDataColumn[] 	cols = ds1.getDataColumns();                                   
						                                                                                   
						int colNm_GoodsSid  	= ds1.indexOfColumn("GOODS_SID");		// 상품 sid        
						int colNm_GoodsCd  		= ds1.indexOfColumn("GOODS_CD");		// 상품코드        
						int colNm_GoodsNm  		= ds1.indexOfColumn("GOODS_NM");		// 상품명          
						int colNm_Course  		= ds1.indexOfColumn("COURSE");			// 기본경로        
						int colNm_Nights  		= ds1.indexOfColumn("NIGHTS");			// 박수            
						                                                                                   
						int colNm_UseYn  		= ds1.indexOfColumn("USE_YN");			// 사용여부        
						int colNm_Days  		= ds1.indexOfColumn("DAYS");			// 일수            
						int colNm_EngNm  		= ds1.indexOfColumn("ENG_NM");			// 영문상품명      
	                                                                                                       
					                        
						                                                                                   
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
								                                                                           
//								StringUtil.printMsg("INSERT",this);                                        
								cstmt = conn.prepareCall(arr_sql[5].toString());                           
								                                                                           
								cstmt.setInt(1, rows[i].getInt(colNm_GoodsSid));                           
								cstmt.setString(2, rows[i].getString(colNm_GoodsCd));                      
								cstmt.setString(3, rows[i].getString(colNm_GoodsNm));                      
								cstmt.setString(4, rows[i].getString(colNm_Course));                       
								cstmt.setInt(5, rows[i].getInt(colNm_Nights));                             
								                                                                           
								cstmt.setString(6, rows[i].getString(colNm_UseYn));                        
								cstmt.setInt(7, rows[i].getInt(colNm_Days));                              
//								cstmt.setInt(8, rows[i].getInt(colNm_SaupSid));                           
								cstmt.setInt(8, 0);
								cstmt.setString(9, rows[i].getString(colNm_EngNm));                       
								
								cstmt.setString(10, "");        
								
								cstmt.setInt(11, 0);                        
								                                                                           
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);                    
								cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);                    
								cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);                    
								// 쿼리실행                                                                
								cstmt.executeUpdate();         
								
								if(!cstmt.getString(12).equals("Y"))
									throw new Exception (cstmt.getString(14));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(12));
									row1.addColumnValue(cstmt.getString(13));
									row1.addColumnValue(cstmt.getString(14));
									
									ds_result.addDataRow(row1);
								}
							}                                                                              
						}                                                                                  
					}                                                                                      
					
					if ("EXCELDS6".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						GauceDataColumn[] 	cols = ds1.getDataColumns();                                   
						                                                                                   
						int colNm_Head  		= ds1.indexOfColumn("HEAD");       	 // 대분류                       
						int colNm_Detail  		= ds1.indexOfColumn("DETAIL");       // 소분류              
						int colNm_DetailNm  	= ds1.indexOfColumn("DETAIL_NM");    // 소분류명                  
						int colNm_Item1  		= ds1.indexOfColumn("ITEM1");        // 속성1                      
						int colNm_Item2  		= ds1.indexOfColumn("ITEM2");                      
						
						int colNm_Item3  		= ds1.indexOfColumn("ITEM3");                              
						int colNm_Item4  		= ds1.indexOfColumn("ITEM4");                              
						int colNm_Item5  		= ds1.indexOfColumn("ITEM5");                              
						int colNm_Item6  		= ds1.indexOfColumn("ITEM6");                              
						int colNm_Item7  		= ds1.indexOfColumn("ITEM7");                              
						
						int colNm_Item8  		= ds1.indexOfColumn("ITEM8");                              
						int colNm_Item9  		= ds1.indexOfColumn("ITEM9");                              
						int colNm_Item10  		= ds1.indexOfColumn("ITEM10");                             
						int colNm_Item11  		= ds1.indexOfColumn("ITEM11");                             
						int colNm_Item12  		= ds1.indexOfColumn("ITEM12");                             
						
						int colNm_Item13  		= ds1.indexOfColumn("ITEM13");                             
						int colNm_Item14  		= ds1.indexOfColumn("ITEM14");                         
						int colNm_Item15  		= ds1.indexOfColumn("ITEM15");        // 속성15                        
	           			
	           			
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
								                                                                           
//								StringUtil.printMsg("INSERT",this);                                        
								cstmt = conn.prepareCall(arr_sql[6].toString());                           
								
								cstmt.setString(1, rows[i].getString(colNm_Head));    
								cstmt.setString(2, rows[i].getString(colNm_Detail));    
								cstmt.setString(3, rows[i].getString(colNm_DetailNm));    
								cstmt.setString(4, rows[i].getString(colNm_Item1));    
								cstmt.setString(5, rows[i].getString(colNm_Item2));   
								
								cstmt.setString(6, rows[i].getString(colNm_Item3));    
								cstmt.setString(7, rows[i].getString(colNm_Item4));    
								cstmt.setString(8, rows[i].getString(colNm_Item5));    
								cstmt.setString(9, rows[i].getString(colNm_Item6));    
								cstmt.setString(10, rows[i].getString(colNm_Item7));    
								
								cstmt.setString(11, rows[i].getString(colNm_Item8));    
								cstmt.setString(12, rows[i].getString(colNm_Item9));    
								cstmt.setString(13, rows[i].getString(colNm_Item10));    
								cstmt.setString(14, rows[i].getString(colNm_Item11));                      
								cstmt.setString(15, rows[i].getString(colNm_Item12));    

								
								cstmt.setString(16, rows[i].getString(colNm_Item13));   
								cstmt.setString(17, rows[i].getString(colNm_Item14));   
								cstmt.setString(18, rows[i].getString(colNm_Item15));   
								                                                                      
								
								cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);        
								cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);      
								cstmt.registerOutParameter(21, java.sql.Types.VARCHAR); 
								// 쿼리실행                                                                
								cstmt.executeUpdate();                
								
								if(!cstmt.getString(19).equals("Y"))
									throw new Exception (cstmt.getString(21));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(19));
									row1.addColumnValue(cstmt.getString(20));
									row1.addColumnValue(cstmt.getString(21));
									
									ds_result.addDataRow(row1);
								}
							}                                                                              
						}                                                                                  
					}                                                 					
					
					if ("EXCELDS7".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						GauceDataColumn[] 	cols = ds1.getDataColumns();                                   
						                                                                                   
						int colNm_ClientSid  	= ds1.indexOfColumn("CLIENT_SID");
						int colNm_VendCd  		= ds1.indexOfColumn("VEND_CD");
						int colNm_ClientCd  	= ds1.indexOfColumn("CLIENT_CD");
						int colNm_ClientNm  	= ds1.indexOfColumn("CLIENT_NM");
						int colNm_ClientGu  	= ds1.indexOfColumn("CLIENT_GU");
						
						int colNm_AgenGu  		= ds1.indexOfColumn("AGEN_GU");
						int colNm_DirYn  		= ds1.indexOfColumn("DIR_YN");
						int colNm_AreaCd  		= ds1.indexOfColumn("AREA_CD");
						int colNm_SalDam_sid  	= ds1.indexOfColumn("SAL_DAM_SID");
						int colNm_ClientDam_nm  = ds1.indexOfColumn("CLIENT_DAM_NM");
						
						int colNm_TelNo  		= ds1.indexOfColumn("TEL_NO");
						int colNm_MobileNo  	= ds1.indexOfColumn("MOBILE_NO");
						int colNm_FaxNo  		= ds1.indexOfColumn("FAX_NO");
						int colNm_EMail  		= ds1.indexOfColumn("E_MAIL");
						int colNm_ZipCd  		= ds1.indexOfColumn("ZIP_CD");
						
						int colNm_Address1  	= ds1.indexOfColumn("ADDRESS1");
						int colNm_Address2  	= ds1.indexOfColumn("ADDRESS2");
						int colNm_CommiRate  	= ds1.indexOfColumn("COMMI_RATE");
						int colNm_CuntStatus  	= ds1.indexOfColumn("CUNT_STATUS");
						int colNm_Bancod  		= ds1.indexOfColumn("BANCOD");
						int colNm_BankAcc_no  	= ds1.indexOfColumn("BANK_ACC_NO");
						int colNm_BankAcct_nm  	= ds1.indexOfColumn("BANK_ACCT_NM");
						int colNm_UseYn  		= ds1.indexOfColumn("USE_YN");
						int colNm_Remarks  		= ds1.indexOfColumn("REMARKS");
                  
						                                                                                   
						                                                                                   
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
								                                                                           
//								StringUtil.printMsg("INSERT",this);                                        
								cstmt = conn.prepareCall(arr_sql[7].toString());                           
								                                                                           
								cstmt.setInt(1, rows[i].getInt(colNm_ClientSid));    
								cstmt.setString(2, rows[i].getString(colNm_VendCd));    
								cstmt.setString(3, rows[i].getString(colNm_ClientCd));    
								cstmt.setString(4, rows[i].getString(colNm_ClientNm));    
								cstmt.setString(5, rows[i].getString(colNm_ClientGu));   
								
								cstmt.setString(6, rows[i].getString(colNm_AgenGu));    
								cstmt.setString(7, rows[i].getString(colNm_DirYn));    
								cstmt.setString(8, rows[i].getString(colNm_AreaCd));    
								cstmt.setInt(9, rows[i].getInt(colNm_SalDam_sid));    
								cstmt.setString(10, rows[i].getString(colNm_ClientDam_nm));    
								
								cstmt.setString(11, rows[i].getString(colNm_TelNo));    
								cstmt.setString(12, rows[i].getString(colNm_MobileNo));    
								cstmt.setString(13, rows[i].getString(colNm_FaxNo));    
								cstmt.setString(14, rows[i].getString(colNm_EMail));                      
								cstmt.setString(15, rows[i].getString(colNm_ZipCd));    

								cstmt.setString(16, rows[i].getString(colNm_Address1));   
								cstmt.setString(17, rows[i].getString(colNm_Address2));   
								cstmt.setInt(18, rows[i].getInt(colNm_CommiRate));   
								cstmt.setString(19, rows[i].getString(colNm_CuntStatus));   
								cstmt.setString(20, rows[i].getString(colNm_Bancod));   
								
								cstmt.setString(21, rows[i].getString(colNm_BankAcc_no));   
								cstmt.setString(22, rows[i].getString(colNm_BankAcct_nm));   
								cstmt.setString(23, rows[i].getString(colNm_UseYn));   
								                                                                           
								cstmt.setString(24, "");                                                    
								cstmt.setString(25, "");                                 
								
								cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);                    
								cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);                    
								cstmt.registerOutParameter(28, java.sql.Types.VARCHAR); 
								// 쿼리실행                                                                
								cstmt.executeUpdate();                                  
								
								if(!cstmt.getString(26).equals("Y"))
									throw new Exception (cstmt.getString(28));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(26));
									row1.addColumnValue(cstmt.getString(27));
									row1.addColumnValue(cstmt.getString(28));
									
									ds_result.addDataRow(row1);
								}
							}                                                                              
						}                                                                                  
					}       
					
					
					if ("EXCELDS8".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						
						int colNm_MenuSid  			= ds1.indexOfColumn("MENU_SID");
						int colNm_MenuCd  			= ds1.indexOfColumn("MENU_CD");
						int colNm_MenuGubun_cd  	= ds1.indexOfColumn("MENU_GUBUN_CD");
						int colNm_MenuItem1  		= ds1.indexOfColumn("MENU_ITEM1");
						int colNm_MenuItem2  		= ds1.indexOfColumn("MENU_ITEM2");
						int colNm_MenuItem3  		= ds1.indexOfColumn("MENU_ITEM3");
						int colNm_MenuItem4  		= ds1.indexOfColumn("MENU_ITEM4");
						int colNm_MenuItem5  		= ds1.indexOfColumn("MENU_ITEM5");
						int colNm_BgnDate  			= ds1.indexOfColumn("BGN_DATE");
						int colNm_EndDate  			= ds1.indexOfColumn("END_DATE");
						int colNm_BgnPersons  		= ds1.indexOfColumn("BGN_PERSONS");
						int colNm_EndPersons  		= ds1.indexOfColumn("END_PERSONS");
						int colNm_MenuNm  			= ds1.indexOfColumn("MENU_NM");
						int colNm_MenuEng_nm  		= ds1.indexOfColumn("MENU_ENG_NM");
						int colNm_MenuShort_nm  	= ds1.indexOfColumn("MENU_SHORT_NM");
						int colNm_TaxYn  			= ds1.indexOfColumn("TAX_YN");
						int colNm_TaxCalcu_cd  		= ds1.indexOfColumn("TAX_CALCU_CD");
						int colNm_UnitAmt  			= ds1.indexOfColumn("UNIT_AMT");
						int colNm_NetAmt  			= ds1.indexOfColumn("NET_AMT");
						int colNm_VatAmt  			= ds1.indexOfColumn("VAT_AMT");
						int colNm_ExciseAmt  		= ds1.indexOfColumn("EXCISE_AMT");
						int colNm_EduAmt  			= ds1.indexOfColumn("EDU_AMT");
						int colNm_VillageAmt  		= ds1.indexOfColumn("VILLAGE_AMT");
						int colNm_SportsAmt  		= ds1.indexOfColumn("SPORTS_AMT");
						int colNm_TourAmt  			= ds1.indexOfColumn("TOUR_AMT");
						int colNm_AssocAmt  		= ds1.indexOfColumn("ASSOC_AMT");
						int colNm_TipAmt  			= ds1.indexOfColumn("TIP_AMT");
						int colNm_CurrencyCd  		= ds1.indexOfColumn("CURRENCY_CD");
						int colNm_OptionYn  		= ds1.indexOfColumn("OPTION_YN");
						int colNm_OptionView_cd  	= ds1.indexOfColumn("OPTION_VIEW_CD");
						int colNm_DisplaySeq  		= ds1.indexOfColumn("DISPLAY_SEQ");
						int colNm_UseYn  			= ds1.indexOfColumn("USE_YN");
						int colNm_SaupSid  			= ds1.indexOfColumn("SAUP_SID");
						int colNm_UpjangSid  		= ds1.indexOfColumn("UPJANG_SID");
						int colNm_Remarks  			= ds1.indexOfColumn("REMARKS");

						
						for(int i=0; i<rows.length; i++){
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
								
//								StringUtil.printMsg("INSERT",this);
								cstmt = conn.prepareCall(arr_sql[8].toString());
							

								cstmt.setInt(1, rows[i].getInt(colNm_MenuSid));  		
								cstmt.setString(2, rows[i].getString(colNm_MenuCd));  		
								cstmt.setString(3, rows[i].getString(colNm_MenuGubun_cd)); 
								cstmt.setString(4, rows[i].getString(colNm_MenuItem1));  		
								cstmt.setString(5, rows[i].getString(colNm_MenuItem2));  		
								cstmt.setString(6, rows[i].getString(colNm_MenuItem3));  		
								cstmt.setString(7, rows[i].getString(colNm_MenuItem4));  		
								cstmt.setString(8, rows[i].getString(colNm_MenuItem5));  		
								cstmt.setString(9, rows[i].getString(colNm_BgnDate));  		
								cstmt.setString(10, rows[i].getString(colNm_EndDate));  		
								cstmt.setInt(11, rows[i].getInt(colNm_BgnPersons));  	
								cstmt.setInt(12, rows[i].getInt(colNm_EndPersons));  	
								cstmt.setString(13, rows[i].getString(colNm_MenuNm));  		
								cstmt.setString(14, rows[i].getString(colNm_MenuEng_nm));  	
								cstmt.setString(15, rows[i].getString(colNm_MenuShort_nm)); 
								cstmt.setString(16, rows[i].getString(colNm_TaxYn));  			
								cstmt.setString(17, rows[i].getString(colNm_TaxCalcu_cd));  
								cstmt.setInt(18, rows[i].getInt(colNm_UnitAmt));  		
								cstmt.setInt(19, rows[i].getInt(colNm_NetAmt));  		
								cstmt.setInt(20, rows[i].getInt(colNm_VatAmt));  		
								cstmt.setInt(21, rows[i].getInt(colNm_ExciseAmt));  		
								cstmt.setInt(22, rows[i].getInt(colNm_EduAmt));  		
								cstmt.setInt(23, rows[i].getInt(colNm_VillageAmt));  	
								cstmt.setInt(24, rows[i].getInt(colNm_SportsAmt));  		
								cstmt.setInt(25, rows[i].getInt(colNm_TourAmt));  		
								cstmt.setInt(26, rows[i].getInt(colNm_AssocAmt));  		
								cstmt.setInt(27, rows[i].getInt(colNm_TipAmt));  		
								cstmt.setString(28, rows[i].getString(colNm_CurrencyCd));  	
								cstmt.setString(29, rows[i].getString(colNm_OptionYn));  		
								cstmt.setString(30, rows[i].getString(colNm_OptionView_cd));
								cstmt.setInt(31, rows[i].getInt(colNm_DisplaySeq));  	
								cstmt.setString(32, rows[i].getString(colNm_UseYn));  			
								cstmt.setInt(33, rows[i].getInt(colNm_SaupSid));  		
								cstmt.setInt(34, rows[i].getInt(colNm_UpjangSid));  	 
								cstmt.setString(35, rows[i].getString(colNm_Remarks));  	 

								
								cstmt.registerOutParameter(36, java.sql.Types.VARCHAR); // 성공YN
								cstmt.registerOutParameter(37, java.sql.Types.VARCHAR); // 메세지 코드
								cstmt.registerOutParameter(38, java.sql.Types.VARCHAR);	//메세지
								// 쿼리실행
								cstmt.executeUpdate();
								
								if(!cstmt.getString(36).equals("Y"))
									throw new Exception (cstmt.getString(38));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(36));
									row1.addColumnValue(cstmt.getString(37));
									row1.addColumnValue(cstmt.getString(38));
									
									ds_result.addDataRow(row1);
								}
							}
						}
					}					
					
					
				}
			}	
			if(ds_result!=null) ds_result.flush();
		} catch (SQLException sqle){
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
	 * 파일삭제
	 */
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
