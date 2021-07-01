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

public class Sy521B extends SuperServlet {
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_SY520B_01(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?)");
		
		arr_sql[2].append("CALL SALES.PR_SY520B_02(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?)");
		
		arr_sql[3].append("CALL SALES.PR_SY520B_03(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?)");
		arr_sql[4].append("CALL SALES.PR_SY520B_04(?,?,?,?,?,")
				  .append(                        "?,?,?,?,?,")
				  .append(                        "?,?,?)");
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
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
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}		
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		/* DataSet */
		GauceDataSet excelDs = req.getGauceDataSet("TEMP_EXCEL");//엑셀파일; 
		
		GauceDataSet ds1 = req.getGauceDataSet("EXCELDS1"); //엑셀적용;
		GauceDataSet ds2 = req.getGauceDataSet("EXCELDS2"); //엑셀적용;
		GauceDataSet ds3 = req.getGauceDataSet("EXCELDS3"); //엑셀적용;
		GauceDataSet ds4 = req.getGauceDataSet("EXCELDS4"); //엑셀적용;
		
		/*
		 * 검색시 필요한 조건
		 */
		try {
				
			// 파일 업로드 
				if (excelDs != null) {
						
					GauceDataRow[] 		excelRow = excelDs.getDataRows();
					
					int data_url  = excelDs.indexOfColumn("EXCEL_URL");
					
					String o_name = excelRow[0].getString(0).trim();
					
					o_name = System.currentTimeMillis()+".xls";
					fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;
					
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}
				
				// 
				if (ds1 != null) {
					res.enableFirstRow(ds1);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet(0); // Sheet명 
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
					
					ds1.addDataColumn(new GauceDataColumn("CUST_SID", 	GauceDataColumn.TB_DECIMAL));
					ds1.addDataColumn(new GauceDataColumn("GROUP_CD", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("MANAGE_NO", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("GROUP_GU", 	GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("REGI_NO", 	GauceDataColumn.TB_STRING, 13));
					ds1.addDataColumn(new GauceDataColumn("REGI_YN", 	GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("CUST_GU", 	GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("COUNTRY_GU", GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("SAUP_GU", 	GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("CUST_TYPE", 	GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("CUST_NM", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("LAST_NM", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("FIRST_NM", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("COUNTRY_CD",	GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("NATION_CD", 	GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("BIRTHDAY", 	GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("SEX", 		GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("TEL_NO", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("MOBILE_NO", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("E_MAIL", 	GauceDataColumn.TB_STRING, 40));
					ds1.addDataColumn(new GauceDataColumn("FAX_NO", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("ZIP_SID", 	GauceDataColumn.TB_DECIMAL));
					ds1.addDataColumn(new GauceDataColumn("ZIP_CD", 	GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("ADDRESS1", 	GauceDataColumn.TB_STRING, 80));
					ds1.addDataColumn(new GauceDataColumn("ADDRESS2", 	GauceDataColumn.TB_STRING, 80));
					ds1.addDataColumn(new GauceDataColumn("ENG_ZIP_CD", 	GauceDataColumn.TB_STRING, 10));
					ds1.addDataColumn(new GauceDataColumn("ENG_ADDR1", 	GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("ENG_ADDR2", 	GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("PASS_TYPE", 	GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("PASS_NO", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("PASS_EXPIRE_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("PASS_ISSUE_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("PASS_AREA", 	GauceDataColumn.TB_STRING, 22));
					ds1.addDataColumn(new GauceDataColumn("COMPANY_NM", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("POSITIONS", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("ENG_COMPANY_NM", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("ENG_POSITION", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("NORTH_CNT", 	GauceDataColumn.TB_DECIMAL));
					ds1.addDataColumn(new GauceDataColumn("CLIENT_SID", 	GauceDataColumn.TB_DECIMAL));
					ds1.addDataColumn(new GauceDataColumn("HEIGHT", 	GauceDataColumn.TB_DECIMAL));
					ds1.addDataColumn(new GauceDataColumn("EDUC_YN", 	GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("EDUC_SAUP_SID", 	GauceDataColumn.TB_DECIMAL));
					ds1.addDataColumn(new GauceDataColumn("EDUC_DT", 	GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("WORK_NO", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("JOB_CD", 	GauceDataColumn.TB_STRING, 2));

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
					
					ds2.addDataColumn(new GauceDataColumn("ACCEPT_SID", 	GauceDataColumn.TB_DECIMAL));
					ds2.addDataColumn(new GauceDataColumn("ACCEPT_NO", 	GauceDataColumn.TB_STRING, 14));
					ds2.addDataColumn(new GauceDataColumn("ACCEPT_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds2.addDataColumn(new GauceDataColumn("DEPART_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds2.addDataColumn(new GauceDataColumn("SAUP_SID", 	GauceDataColumn.TB_DECIMAL));
					ds2.addDataColumn(new GauceDataColumn("GOODS_SID", 	GauceDataColumn.TB_DECIMAL));
					ds2.addDataColumn(new GauceDataColumn("CLIENT_SID", 	GauceDataColumn.TB_DECIMAL));
					ds2.addDataColumn(new GauceDataColumn("EVENT_SID", 	GauceDataColumn.TB_DECIMAL));
					ds2.addDataColumn(new GauceDataColumn("JOB_GUBUN", 	GauceDataColumn.TB_STRING, 1));

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
					
					
           			
					ds3.addDataColumn(new GauceDataColumn("RSV_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("M_RSV_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("KEY_MAN", 	GauceDataColumn.TB_STRING, 13));
					ds3.addDataColumn(new GauceDataColumn("ACCEPT_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("UPJANG_SID", 	GauceDataColumn.TB_DECIMAL));
					
					ds3.addDataColumn(new GauceDataColumn("A_ROOM_TYPE_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("A_ROOM_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("ROOM_TYPE_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("ROOM_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("OLD_ROOM_NO", 	GauceDataColumn.TB_STRING, 5));
					
					ds3.addDataColumn(new GauceDataColumn("BLOCK_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("RSV_TYPE", 	GauceDataColumn.TB_STRING, 1));
					ds3.addDataColumn(new GauceDataColumn("STATUS_CD", 	GauceDataColumn.TB_STRING, 2));
					ds3.addDataColumn(new GauceDataColumn("DEPART_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds3.addDataColumn(new GauceDataColumn("DEPART_TIME", 	GauceDataColumn.TB_STRING, 4));
					
					ds3.addDataColumn(new GauceDataColumn("NIGHTS", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("ARRIVE_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds3.addDataColumn(new GauceDataColumn("ARRIVE_TIME", 	GauceDataColumn.TB_STRING, 4));
					ds3.addDataColumn(new GauceDataColumn("CUST_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("CUST_TYPE", 	GauceDataColumn.TB_STRING, 3));
					
					ds3.addDataColumn(new GauceDataColumn("CUST_GU", 	GauceDataColumn.TB_STRING, 1));
					ds3.addDataColumn(new GauceDataColumn("SAUP_GU", 	GauceDataColumn.TB_STRING, 2));
					ds3.addDataColumn(new GauceDataColumn("AGE_CD", 	GauceDataColumn.TB_STRING, 2));
					ds3.addDataColumn(new GauceDataColumn("JOIN_CD", 	GauceDataColumn.TB_STRING, 2));
					ds3.addDataColumn(new GauceDataColumn("MOBILE_NO", 	GauceDataColumn.TB_STRING, 15));
					
					ds3.addDataColumn(new GauceDataColumn("COMPANY_NM", 	GauceDataColumn.TB_STRING, 30));
					ds3.addDataColumn(new GauceDataColumn("POSITIONS", 	GauceDataColumn.TB_STRING, 30));
					ds3.addDataColumn(new GauceDataColumn("ZIP_SID", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("ZIP_CD", 	GauceDataColumn.TB_STRING, 6));
					ds3.addDataColumn(new GauceDataColumn("ADDRESS1", 	GauceDataColumn.TB_STRING, 60));
					
					ds3.addDataColumn(new GauceDataColumn("CLASS", 	GauceDataColumn.TB_STRING, 3));
					ds3.addDataColumn(new GauceDataColumn("TEAMS", 	GauceDataColumn.TB_STRING, 3));
					ds3.addDataColumn(new GauceDataColumn("PAGE_NO", 	GauceDataColumn.TB_DECIMAL));
					ds3.addDataColumn(new GauceDataColumn("NORTH_PURPOSE", 	GauceDataColumn.TB_STRING, 62));
					ds3.addDataColumn(new GauceDataColumn("DRIVE_YN", 	GauceDataColumn.TB_STRING, 1));
					
					ds3.addDataColumn(new GauceDataColumn("CANCEL_CD", 	GauceDataColumn.TB_STRING, 2));
					ds3.addDataColumn(new GauceDataColumn("TOUR_NO", 	GauceDataColumn.TB_STRING, 20));
					ds3.addDataColumn(new GauceDataColumn("MOJ_CHECK_YN", 	GauceDataColumn.TB_STRING, 1));
					ds3.addDataColumn(new GauceDataColumn("EDUC_FINISH_YN", 	GauceDataColumn.TB_STRING, 1));
					ds3.addDataColumn(new GauceDataColumn("ORG_SUBMIT_DATE", 	GauceDataColumn.TB_STRING, 8));
					
					ds3.addDataColumn(new GauceDataColumn("UNITY_NO", 	GauceDataColumn.TB_STRING, 12));
					ds3.addDataColumn(new GauceDataColumn("SOUTH_PERMIT_YN", 	GauceDataColumn.TB_STRING, 1));
					ds3.addDataColumn(new GauceDataColumn("NORTH_SUBMIT_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds3.addDataColumn(new GauceDataColumn("NORTH_SUBMIT_TIME", 	GauceDataColumn.TB_STRING, 4));
					ds3.addDataColumn(new GauceDataColumn("NORTH_PERMIT_YN", 	GauceDataColumn.TB_STRING, 1));
					
					ds3.addDataColumn(new GauceDataColumn("RSV_WAY_CD", 	GauceDataColumn.TB_STRING, 1));
					ds3.addDataColumn(new GauceDataColumn("REMARKS", 	GauceDataColumn.TB_STRING, 200));
//					ds3.addDataColumn(new GauceDataColumn("GOODS_SID", 	GauceDataColumn.TB_NUMBER));
					
					
					ds3.addDataColumn(new GauceDataColumn("YN",        	GauceDataColumn.TB_STRING, 30)); // 2

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
				
				// 동정보
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
					
					ds4.addDataColumn(new GauceDataColumn("RSV_SID", 	GauceDataColumn.TB_DECIMAL));
					ds4.addDataColumn(new GauceDataColumn("USE_DATE", 	GauceDataColumn.TB_STRING, 8));
					ds4.addDataColumn(new GauceDataColumn("KEY_SEQ", 	GauceDataColumn.TB_DECIMAL));
					ds4.addDataColumn(new GauceDataColumn("MENU_SID", 	GauceDataColumn.TB_DECIMAL));
					ds4.addDataColumn(new GauceDataColumn("STD_AMT", 	GauceDataColumn.TB_DECIMAL));
					ds4.addDataColumn(new GauceDataColumn("USE_AMT", 	GauceDataColumn.TB_DECIMAL));
					ds4.addDataColumn(new GauceDataColumn("SALE_QTY", 	GauceDataColumn.TB_DECIMAL));
					ds4.addDataColumn(new GauceDataColumn("OPTION_YN", 	GauceDataColumn.TB_STRING, 1));
					ds4.addDataColumn(new GauceDataColumn("RSV_PAY_YN", 	GauceDataColumn.TB_STRING, 1));
					ds4.addDataColumn(new GauceDataColumn("REMARKS", 	GauceDataColumn.TB_STRING, 100));

					ds4.addDataColumn(new GauceDataColumn("YN",        	GauceDataColumn.TB_STRING, 30)); // 2
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds4.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							StringUtil.printMsg("Value = " , arr[row][column], this);
							gRow.addColumnValue(arr[row][column]);
						}
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds4.addDataRow(gRow);
					}
					ds4.flush();
				}	
				
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
						
						
						int colNm_CustSid  			= ds1.indexOfColumn("CUST_SID");
						int colNm_GroupCd  			= ds1.indexOfColumn("GROUP_CD");
						int colNm_ManageNo  		= ds1.indexOfColumn("MANAGE_NO");
						int colNm_GroupGu  			= ds1.indexOfColumn("GROUP_GU");
						int colNm_RegiNo  			= ds1.indexOfColumn("REGI_NO");
						
						int colNm_RegiYn  			= ds1.indexOfColumn("REGI_YN");
						int colNm_CustGu  			= ds1.indexOfColumn("CUST_GU");
						int colNm_CountryGu  		= ds1.indexOfColumn("COUNTRY_GU");
						int colNm_SaupGu  			= ds1.indexOfColumn("SAUP_GU");
						int colNm_CustType  		= ds1.indexOfColumn("CUST_TYPE");
						
						int colNm_CustNm  			= ds1.indexOfColumn("CUST_NM");
						int colNm_LastNm  			= ds1.indexOfColumn("LAST_NM");
						int colNm_FirstNm  			= ds1.indexOfColumn("FIRST_NM");
						int colNm_CountryCd  		= ds1.indexOfColumn("COUNTRY_CD");
						int colNm_NationCd  		= ds1.indexOfColumn("NATION_CD");
						
						int colNm_Birthday  		= ds1.indexOfColumn("BIRTHDAY");
						int colNm_Sex  				= ds1.indexOfColumn("SEX");
						int colNm_TelNo  			= ds1.indexOfColumn("TEL_NO");
						int colNm_MobileNo  		= ds1.indexOfColumn("MOBILE_NO");
						int colNm_EMail  			= ds1.indexOfColumn("E_MAIL");
						
						int colNm_FaxNo  			= ds1.indexOfColumn("FAX_NO");
						int colNm_ZipSid  			= ds1.indexOfColumn("ZIP_SID");
						int colNm_ZipCd  			= ds1.indexOfColumn("ZIP_CD");
						int colNm_Address1  		= ds1.indexOfColumn("ADDRESS1");
						int colNm_Address2  		= ds1.indexOfColumn("ADDRESS2");

						int colNm_EngZip_cd  		= ds1.indexOfColumn("ENG_ZIP_CD");
						int colNm_EngAddr1  		= ds1.indexOfColumn("ENG_ADDR1");
						int colNm_EngAddr2  		= ds1.indexOfColumn("ENG_ADDR2");
						int colNm_PassType  		= ds1.indexOfColumn("PASS_TYPE");
						int colNm_PassNo  			= ds1.indexOfColumn("PASS_NO");
						
						int colNm_PassExpire_date  	= ds1.indexOfColumn("PASS_EXPIRE_DATE");
						int colNm_PassIssue_date  	= ds1.indexOfColumn("PASS_ISSUE_DATE");
						int colNm_PassArea  		= ds1.indexOfColumn("PASS_AREA");
						int colNm_CompanyNm  		= ds1.indexOfColumn("COMPANY_NM");
						int colNm_Positions  		= ds1.indexOfColumn("POSITIONS");

						int colNm_EngCompany_nm  	= ds1.indexOfColumn("ENG_COMPANY_NM");
						int colNm_EngPosition  		= ds1.indexOfColumn("ENG_POSITION");
						int colNm_NorthCnt  		= ds1.indexOfColumn("NORTH_CNT");
						int colNm_ClientSid  		= ds1.indexOfColumn("CLIENT_SID");
						int colNm_Height  			= ds1.indexOfColumn("HEIGHT");
						
						int colNm_EducYn  			= ds1.indexOfColumn("EDUC_YN");
						int colNm_EducSaup_sid  	= ds1.indexOfColumn("EDUC_SAUP_SID");
						int colNm_EducDt  			= ds1.indexOfColumn("EDUC_DT");
						int colNm_WorkNo  			= ds1.indexOfColumn("WORK_NO");
						int colNm_JobCd  			= ds1.indexOfColumn("JOB_CD");

						for(int i=0; i<rows.length; i++){
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
								
//								StringUtil.printMsg("INSERT ["+ i + " ] " + rows[i].getInt(colNm_CustSid),this);
								cstmt = conn.prepareCall(arr_sql[1].toString());
								
								cstmt.setInt(1, rows[i].getInt(colNm_CustSid));  
								cstmt.setString(2, rows[i].getString(colNm_GroupCd));  
								cstmt.setString(3, rows[i].getString(colNm_ManageNo)); 
								cstmt.setString(4, rows[i].getString(colNm_GroupGu));  			
								cstmt.setString(5, rows[i].getString(colNm_RegiNo));  	
								
								cstmt.setString(6, rows[i].getString(colNm_RegiYn));  			
								cstmt.setString(7, rows[i].getString(colNm_CustGu));  			
								cstmt.setString(8, rows[i].getString(colNm_CountryGu));  		
								cstmt.setString(9, rows[i].getString(colNm_SaupGu));  			
								cstmt.setString(10, rows[i].getString(colNm_CustType));  		

								cstmt.setString(11, rows[i].getString(colNm_CustNm));  			
								cstmt.setString(12, rows[i].getString(colNm_LastNm));  			
								cstmt.setString(13, rows[i].getString(colNm_FirstNm));  			
								cstmt.setString(14, rows[i].getString(colNm_CountryCd));  		
								cstmt.setString(15, rows[i].getString(colNm_NationCd));  		

								cstmt.setString(16, rows[i].getString(colNm_Birthday));  		
								cstmt.setString(17, rows[i].getString(colNm_Sex));  				
								cstmt.setString(18, rows[i].getString(colNm_TelNo));  			
								cstmt.setString(19, rows[i].getString(colNm_MobileNo));  		
								cstmt.setString(20, rows[i].getString(colNm_EMail));  			

								cstmt.setString(21, rows[i].getString(colNm_FaxNo));  			
								cstmt.setInt(22, rows[i].getInt(colNm_ZipSid));  			
								cstmt.setString(23, rows[i].getString(colNm_ZipCd));  			
								cstmt.setString(24, rows[i].getString(colNm_Address1));  		
								cstmt.setString(25, rows[i].getString(colNm_Address2));  		

								cstmt.setString(26, rows[i].getString(colNm_EngZip_cd));  		
								cstmt.setString(27, rows[i].getString(colNm_EngAddr1));  		
								cstmt.setString(28, rows[i].getString(colNm_EngAddr2));  		
								cstmt.setString(29, rows[i].getString(colNm_PassType));  		
								cstmt.setString(30, rows[i].getString(colNm_PassNo));  			
								
								cstmt.setString(31, rows[i].getString(colNm_PassExpire_date));  	
								cstmt.setString(32, rows[i].getString(colNm_PassIssue_date));  	
								cstmt.setString(33, rows[i].getString(colNm_PassArea));  		
								cstmt.setString(34, rows[i].getString(colNm_CompanyNm));  		
								cstmt.setString(35, rows[i].getString(colNm_Positions));  		
								
								cstmt.setString(36, rows[i].getString(colNm_EngCompany_nm));  	
								cstmt.setString(37, rows[i].getString(colNm_EngPosition));  		
								cstmt.setInt(38, rows[i].getInt(colNm_NorthCnt));  		
								cstmt.setInt(39, rows[i].getInt(colNm_ClientSid));  		
								cstmt.setInt(40, rows[i].getInt(colNm_Height));  			
								
								cstmt.setString(41, rows[i].getString(colNm_EducYn));  			
								cstmt.setInt(42, rows[i].getInt(colNm_EducSaup_sid));  	
								cstmt.setString(43, rows[i].getString(colNm_EducDt));  			
								cstmt.setString(44, rows[i].getString(colNm_WorkNo));  			
								cstmt.setString(45, rows[i].getString(colNm_JobCd));  	
							
								
								cstmt.registerOutParameter(46, java.sql.Types.VARCHAR); // 성공YN
								cstmt.registerOutParameter(47, java.sql.Types.VARCHAR); // 메세지 코드
								cstmt.registerOutParameter(48, java.sql.Types.VARCHAR);	//메세지
								// 쿼리실행
								cstmt.executeUpdate();
								
								if(!cstmt.getString(46).equals("Y"))
									throw new Exception (cstmt.getString(48));
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(cstmt.getString(46));
									row1.addColumnValue(cstmt.getString(47));
									row1.addColumnValue(cstmt.getString(48));
									
									ds_result.addDataRow(row1);
								}								
							}
						}
					}
				
					
                    
					if ("EXCELDS2".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      

						int colNm_AcceptSid  		= ds1.indexOfColumn("ACCEPT_SID");
						int colNm_AcceptNo  		= ds1.indexOfColumn("ACCEPT_NO");
						int colNm_AcceptDate  		= ds1.indexOfColumn("ACCEPT_DATE");
						int colNm_DepartDate  		= ds1.indexOfColumn("DEPART_DATE");
						int colNm_SaupSid  			= ds1.indexOfColumn("SAUP_SID");
						int colNm_GoodsSid  		= ds1.indexOfColumn("GOODS_SID");
						int colNm_ClientSid  		= ds1.indexOfColumn("CLIENT_SID");
						int colNm_EventSid  		= ds1.indexOfColumn("EVENT_SID");
						int colNm_JobGubun  		= ds1.indexOfColumn("JOB_GUBUN");
//						int colNm_PriceCalc_yn  		= ds1.indexOfColumn("PRICE_CALC_YN");
						
						
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
						                                                                                   
//								StringUtil.printMsg("INSERT",this);                                        
								cstmt = conn.prepareCall(arr_sql[2].toString());                           
								                                                                           
								cstmt.setInt(1, rows[i].getInt(colNm_AcceptSid));
								cstmt.setString(2, rows[i].getString(colNm_AcceptNo));
								cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
								cstmt.setString(4, rows[i].getString(colNm_DepartDate));
								cstmt.setInt(5, rows[i].getInt(colNm_SaupSid));
								cstmt.setInt(6, rows[i].getInt(colNm_GoodsSid));
								cstmt.setInt(7, rows[i].getInt(colNm_ClientSid));
								cstmt.setInt(8, rows[i].getInt(colNm_EventSid));
								cstmt.setString(9, rows[i].getString(colNm_JobGubun));
								cstmt.setString(10, "");

								cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); // 성공YN          
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); // 메세지 코드     
								cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);	//메세지           
								// 쿼리실행                                                                
								cstmt.executeUpdate();                                                     
							}                                                                              
						}                                                                                  
					}                                                                                      
					
					if ("EXCELDS3".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						 
						int colNm_RsvSid  		= ds1.indexOfColumn("RSV_SID");
						int colNm_MRsv_sid  		= ds1.indexOfColumn("M_RSV_SID");
						int colNm_KeyMan  		= ds1.indexOfColumn("KEY_MAN");
						int colNm_AcceptSid  		= ds1.indexOfColumn("ACCEPT_SID");
						int colNm_UpjangSid  		= ds1.indexOfColumn("UPJANG_SID");
						
						int colNm_ARoom_type_sid  		= ds1.indexOfColumn("A_ROOM_TYPE_SID");
						int colNm_ARoom_sid  		= ds1.indexOfColumn("A_ROOM_SID");
						int colNm_RoomType_sid  		= ds1.indexOfColumn("ROOM_TYPE_SID");
						int colNm_RoomSid  		= ds1.indexOfColumn("ROOM_SID");
						int colNm_OldRoom_no  		= ds1.indexOfColumn("OLD_ROOM_NO");
						
						int colNm_BlockSid  		= ds1.indexOfColumn("BLOCK_SID");
						int colNm_RsvType  		= ds1.indexOfColumn("RSV_TYPE");
						int colNm_StatusCd  		= ds1.indexOfColumn("STATUS_CD");
						int colNm_DepartDate  		= ds1.indexOfColumn("DEPART_DATE");
						int colNm_DepartTime  		= ds1.indexOfColumn("DEPART_TIME");
						
						int colNm_Nights  		= ds1.indexOfColumn("NIGHTS");
						int colNm_ArriveDate  		= ds1.indexOfColumn("ARRIVE_DATE");
						int colNm_ArriveTime  		= ds1.indexOfColumn("ARRIVE_TIME");
						int colNm_CustSid  		= ds1.indexOfColumn("CUST_SID");
						int colNm_CustType  		= ds1.indexOfColumn("CUST_TYPE");
						
						int colNm_CustGu  		= ds1.indexOfColumn("CUST_GU");
						int colNm_SaupGu  		= ds1.indexOfColumn("SAUP_GU");
						int colNm_AgeCd  		= ds1.indexOfColumn("AGE_CD");
						int colNm_JoinCd  		= ds1.indexOfColumn("JOIN_CD");
						int colNm_MobileNo  		= ds1.indexOfColumn("MOBILE_NO");
						
						int colNm_CompanyNm  		= ds1.indexOfColumn("COMPANY_NM");
						int colNm_Positions  		= ds1.indexOfColumn("POSITIONS");
						int colNm_ZipSid  		= ds1.indexOfColumn("ZIP_SID");
						int colNm_ZipCd  		= ds1.indexOfColumn("ZIP_CD");
						int colNm_Address1  		= ds1.indexOfColumn("ADDRESS1");
						
						int colNm_Class  		= ds1.indexOfColumn("CLASS");
						int colNm_Teams  		= ds1.indexOfColumn("TEAMS");
						int colNm_PageNo  		= ds1.indexOfColumn("PAGE_NO");
						int colNm_NorthPurpose  = ds1.indexOfColumn("NORTH_PURPOSE");
						int colNm_DriveYn  		= ds1.indexOfColumn("DRIVE_YN");
						
						int colNm_CancelCd  		= ds1.indexOfColumn("CANCEL_CD");
						int colNm_TourNo  		= ds1.indexOfColumn("TOUR_NO");
						int colNm_MojCheck_yn  		= ds1.indexOfColumn("MOJ_CHECK_YN");
						int colNm_EducFinish_yn  		= ds1.indexOfColumn("EDUC_FINISH_YN");
						int colNm_OrgSubmit_date  		= ds1.indexOfColumn("ORG_SUBMIT_DATE");
						
						int colNm_UnityNo  		= ds1.indexOfColumn("UNITY_NO");
						int colNm_SouthPermit_yn  		= ds1.indexOfColumn("SOUTH_PERMIT_YN");
						int colNm_NorthSubmit_date  		= ds1.indexOfColumn("NORTH_SUBMIT_DATE");
						int colNm_NorthSubmit_time  		= ds1.indexOfColumn("NORTH_SUBMIT_TIME");
						int colNm_NorthPermit_yn  		= ds1.indexOfColumn("NORTH_PERMIT_YN");
						
						int colNm_RsvWay_cd  		= ds1.indexOfColumn("RSV_WAY_CD");
						int colNm_Remarks  		= ds1.indexOfColumn("REMARKS");
//						int colNm_GoodsSid  		= ds1.indexOfColumn("GOODS_SID");
						                                                                                   
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
								
								cstmt = conn.prepareCall(arr_sql[3].toString());                           
								
								cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
								cstmt.setInt(2,  rows[i].getInt(colNm_MRsv_sid));
								cstmt.setString(3,  rows[i].getString(colNm_KeyMan));
								cstmt.setInt(4,  rows[i].getInt(colNm_AcceptSid));
								cstmt.setInt(5,  rows[i].getInt(colNm_UpjangSid));
								
								cstmt.setInt(6,  rows[i].getInt(colNm_ARoom_type_sid));
								cstmt.setInt(7,  rows[i].getInt(colNm_ARoom_sid));
								cstmt.setInt(8,  rows[i].getInt(colNm_RoomType_sid));
								cstmt.setInt(9,  rows[i].getInt(colNm_RoomSid));
								cstmt.setString(10,  rows[i].getString(colNm_OldRoom_no));
								
								
								cstmt.setInt(11,  rows[i].getInt(colNm_BlockSid));
								cstmt.setString(12,  rows[i].getString(colNm_RsvType));
								cstmt.setString(13,  rows[i].getString(colNm_StatusCd));
								cstmt.setString(14,  rows[i].getString(colNm_DepartDate));
								cstmt.setString(15,  rows[i].getString(colNm_DepartTime));
								
								cstmt.setInt(16,  rows[i].getInt(colNm_Nights));
								cstmt.setString(17,  rows[i].getString(colNm_ArriveDate));
								cstmt.setString(18,  rows[i].getString(colNm_ArriveTime));
								cstmt.setInt(19,  rows[i].getInt(colNm_CustSid));
								cstmt.setString(20,  rows[i].getString(colNm_CustType));
								
								
								cstmt.setString(21,  rows[i].getString(colNm_CustGu));
								cstmt.setString(22,  rows[i].getString(colNm_SaupGu));
								cstmt.setString(23,  rows[i].getString(colNm_AgeCd));
								cstmt.setString(24,  rows[i].getString(colNm_JoinCd));
								cstmt.setString(25,  rows[i].getString(colNm_MobileNo));
								
								
								cstmt.setString(26,  rows[i].getString(colNm_CompanyNm));
								cstmt.setString(27,  rows[i].getString(colNm_Positions));
								cstmt.setInt(28,  rows[i].getInt(colNm_ZipSid));
								cstmt.setString(29,  rows[i].getString(colNm_ZipCd));
								cstmt.setString(30,  rows[i].getString(colNm_Address1));
								
								
								cstmt.setString(31,  rows[i].getString(colNm_Class));
								cstmt.setString(32,  rows[i].getString(colNm_Teams));
								cstmt.setInt(33, rows[i].getInt(colNm_PageNo));
								cstmt.setString(34,  rows[i].getString(colNm_NorthPurpose));
								cstmt.setString(35,  rows[i].getString(colNm_DriveYn));
								
								cstmt.setString(36,  rows[i].getString(colNm_CancelCd));
								cstmt.setString(37,  rows[i].getString(colNm_TourNo));
								cstmt.setString(38,  rows[i].getString(colNm_MojCheck_yn));
								cstmt.setString(39,  rows[i].getString(colNm_EducFinish_yn));
								cstmt.setString(40,  rows[i].getString(colNm_OrgSubmit_date));
								
								cstmt.setString(41,  rows[i].getString(colNm_UnityNo));
								cstmt.setString(42,  rows[i].getString(colNm_SouthPermit_yn));
								cstmt.setString(43,  rows[i].getString(colNm_NorthSubmit_date));
								cstmt.setString(44,  rows[i].getString(colNm_NorthSubmit_time));
								cstmt.setString(45,  rows[i].getString(colNm_NorthPermit_yn));
								
								cstmt.setString(46,  rows[i].getString(colNm_RsvWay_cd));
								cstmt.setString(47,  rows[i].getString(colNm_Remarks));
								cstmt.setInt(48,  0);

								cstmt.registerOutParameter(49, java.sql.Types.VARCHAR); // 성공YN          
								cstmt.registerOutParameter(50, java.sql.Types.VARCHAR); // 메세지 코드     
								cstmt.registerOutParameter(51, java.sql.Types.VARCHAR);	//메세지                         
								
								// 쿼리실행                                                                
								cstmt.executeUpdate();                                                     
							}                                                                              
						}                                                                                  
					}  
					
					if ("EXCELDS4".equals(gauceName)) {                                                    
						GauceDataRow[] 		rows = ds1.getDataRows();                                      
						GauceDataColumn[] 	cols = ds1.getDataColumns();                                   

						int colNm_RsvSid  		= ds1.indexOfColumn("RSV_SID");
						int colNm_UseDate  		= ds1.indexOfColumn("USE_DATE");
						int colNm_KeySeq  		= ds1.indexOfColumn("KEY_SEQ");
						int colNm_MenuSid  		= ds1.indexOfColumn("MENU_SID");
						int colNm_StdAmt  		= ds1.indexOfColumn("STD_AMT");
						int colNm_UseAmt  		= ds1.indexOfColumn("USE_AMT");
						int colNm_SaleQty  		= ds1.indexOfColumn("SALE_QTY");
						int colNm_OptionYn  		= ds1.indexOfColumn("OPTION_YN");
						int colNm_RsvPay_yn  		= ds1.indexOfColumn("RSV_PAY_YN");
						int colNm_Remarks  		= ds1.indexOfColumn("REMARKS");

//						int colNm_PriceCalc_yn  		= ds1.indexOfColumn("PRICE_CALC_YN");
						
						
						for(int i=0; i<rows.length; i++){                                                  
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {                         
						                                                                                   
//								StringUtil.printMsg("INSERT",this);                                        
								cstmt = conn.prepareCall(arr_sql[4].toString());                           
								                                                                           
								cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
								cstmt.setString(2, rows[i].getString(colNm_UseDate));
								cstmt.setInt(3, rows[i].getInt(colNm_KeySeq));
								cstmt.setInt(4, rows[i].getInt(colNm_MenuSid));
								cstmt.setInt(5, rows[i].getInt(colNm_StdAmt));
								cstmt.setInt(6, rows[i].getInt(colNm_UseAmt));
								cstmt.setInt(7, rows[i].getInt(colNm_SaleQty));
								cstmt.setString(8, rows[i].getString(colNm_OptionYn));
								cstmt.setString(9, rows[i].getString(colNm_RsvPay_yn));
								cstmt.setString(10, rows[i].getString(colNm_RsvPay_yn));

								cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); // 성공YN          
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); // 메세지 코드     
								cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);	//메세지           
								// 쿼리실행                                                                
								cstmt.executeUpdate();                                                     
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
