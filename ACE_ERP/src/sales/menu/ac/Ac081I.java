package sales.menu.ac;

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

public class Ac081I extends SuperServlet {
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		
		arr_sql[1].append("CALL SALES.PR_AC081I_01(?,?,?,?)");	// 조회
		
		arr_sql[2].append("CALL SALES.PR_AC081I_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,? )");	// 저장
		
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
		
		//System.out.println("# Command : 선조회");

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
							
							//StringUtil.printMsg("-------- INIT --------------",this);
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
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		ResultSetMetaData rsmd = null;
		
		String[] 			columnName 	= null;
		
		/* DataSet */
		GauceDataSet excelDs = req.getGauceDataSet("TEMP_EXCEL");//엑셀파일; 
		GauceDataSet ds2 = req.getGauceDataSet("EXCELDS"); //엑셀적용;
		GauceDataSet ds3 = req.getGauceDataSet("MAIN_DS"); //조회;
		

		
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");
		
		if(ds_result!=null){
			res.enableFirstRow(ds_result);
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		/*
		 * 검색시 필요한 조건
		 */
		try {
			String sBgnDate = HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String sEndDate = HDUtil.nullCheckStr(req.getParameter("sEndDate"));
			String sSiteCode  = HDUtil.nullCheckStr(req.getParameter("sSiteCode"));
			String sTr_Order_Nm  = HDUtil.nullCheckStr(req.getParameter("sTr_Order_Nm"));
			
			
			
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
					//StringUtil.printMsg("엑셀 생성파일명:",o_name, this);
					
					//fExcelFilePath = "d:/myWorks/HDASan/WebContent/Sales/file/excel/acct/" + o_name;//로컬용
					fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;	//서버용..
					
					
					//StringUtil.printMsg("엑셀 생성파일 경로:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}
				
				// 엑셀 읽기
				if (ds2 != null) {
					res.enableFirstRow(ds2);
					
					//StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet("가상계좌 매입마감내역(전체기준)"); // Sheet명 
					
					//StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][50];	//배열자체가 스트링이네요.. 하루에 150건도 나온다 함..
					
					for (int row = 0; row < sheet0.getRows(); row++) {	

						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							
							//StringUtil.printMsg("액셀 셀 타입 ==",sheet0.getCell(column,row).getType().toString(), this);

							// 숫자타입							
							if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
								NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
								content = numberCell.getValue()+""; 
								////StringUtil.printMsg("액셀시트 숫자==","row="+row+"::column="+column+"::값="+content, this);
								arr[row][column+1] = content;
						    // 문자타입		
							} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
								LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
								content = labelCell.getContents();
								////StringUtil.printMsg("액셀시트 문자==","row="+row+"::column="+column+"::값="+content, this);
								arr[row][column+1] = content;
						    // 날짜 타입 		
							} else if(sheet0.getCell(column,row).getType() == CellType.DATE)	{
								DateCell dateCell = (DateCell) sheet0.getCell(column,row);
								content = dateCell.getDate()+"";
								////StringUtil.printMsg("액셀시트 날짜==","row="+row+"::column="+column+"::값="+content, this);
								arr[row][column+1] = content;
							} 
						}
					}
							
					/*
					 * DataSet Header
					 */
					ds2.addDataColumn(new GauceDataColumn("COL01",    GauceDataColumn.TB_DECIMAL, 2)); 
					ds2.addDataColumn(new GauceDataColumn("COL02",    GauceDataColumn.TB_STRING, 5)); 
					ds2.addDataColumn(new GauceDataColumn("COL03",    GauceDataColumn.TB_STRING, 30)); 
					ds2.addDataColumn(new GauceDataColumn("COL04",    GauceDataColumn.TB_STRING, 20));
					ds2.addDataColumn(new GauceDataColumn("COL05",    GauceDataColumn.TB_STRING, 10));
					ds2.addDataColumn(new GauceDataColumn("COL06",    GauceDataColumn.TB_STRING, 20)); 
					ds2.addDataColumn(new GauceDataColumn("COL07",    GauceDataColumn.TB_STRING, 16)); 
					ds2.addDataColumn(new GauceDataColumn("COL08",    GauceDataColumn.TB_DECIMAL, 10)); 
					ds2.addDataColumn(new GauceDataColumn("COL09",    GauceDataColumn.TB_DECIMAL, 10)); 
					ds2.addDataColumn(new GauceDataColumn("COL10",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL11",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL12",    GauceDataColumn.TB_STRING, 16)); 
					ds2.addDataColumn(new GauceDataColumn("COL13",    GauceDataColumn.TB_STRING, 16)); 
					ds2.addDataColumn(new GauceDataColumn("COL14",    GauceDataColumn.TB_STRING, 10)); 
					ds2.addDataColumn(new GauceDataColumn("COL15",    GauceDataColumn.TB_STRING, 10)); 
					ds2.addDataColumn(new GauceDataColumn("COL16",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL17",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL18",    GauceDataColumn.TB_STRING, 30)); 
					ds2.addDataColumn(new GauceDataColumn("COL19",    GauceDataColumn.TB_STRING, 20)); 
					ds2.addDataColumn(new GauceDataColumn("TR_SID",	  GauceDataColumn.TB_DECIMAL, 10));
					
					//ds2.addDataColumn(new GauceDataColumn("TR_ACCT_CD",	GauceDataColumn.TB_STRING, 2 ));

					/*
					 * temp에 있는 불러온 데이터를 ds2로 뿌리는 부분 
					 */
					// row=1부터 돌아가는데 이게 제목줄 제외 아닐까;; 흐음..
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						//StringUtil.printMsg("형변환===",arr[row][4],this);
						////StringUtil.printMsg("형변환===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("계좌코드   == ",sSiteCode,this);
						gRow.addColumnValue(Double.parseDouble(arr[row][1]));	//number
						gRow.addColumnValue(arr[row][2]);
						gRow.addColumnValue(arr[row][3]);
						gRow.addColumnValue(arr[row][4]);
						gRow.addColumnValue(arr[row][5]);
						gRow.addColumnValue(arr[row][6]);
						gRow.addColumnValue(arr[row][7]);						
						gRow.addColumnValue(Double.parseDouble(arr[row][8]));	//number
						gRow.addColumnValue(Double.parseDouble(arr[row][9]));	//number
						gRow.addColumnValue(Double.parseDouble(arr[row][10]));	//number
						gRow.addColumnValue(Double.parseDouble(arr[row][11]));	//number
						gRow.addColumnValue(arr[row][12]);
						gRow.addColumnValue(arr[row][13]);
						gRow.addColumnValue(arr[row][14]);
						gRow.addColumnValue(arr[row][15]);
						gRow.addColumnValue(Double.parseDouble(arr[row][16]));	//number
						gRow.addColumnValue(Double.parseDouble(arr[row][17]));	//number
						gRow.addColumnValue(arr[row][18]);
						gRow.addColumnValue(arr[row][19]);
						gRow.addColumnValue(1); 		// TR_SID 컬럼 : 기본값 세팅 1로 준 후에 화면에서 0으로 업뎃 (최초 입력시)
						//gRow.addColumnValue(sSiteCode);	// 계좌코드 컬럼 						
						ds2.addDataRow(gRow);
						
						/*for (int column = 1; column < sheet0.getColumns()+1; column++) {
						////StringUtil.printMsg("데이타",arr[row][column], this);
						gRow.addColumnValue(arr[row][column]);
						}*/

					}
										
					//StringUtil.printMsg("카운트 == " , ds2.getDataRowCnt(), this);
					ds2.flush();
					
					//StringUtil.printMsg("엑셀 삭제전",this);
					deleteExcelFile(fExcelFilePath);
				}
						
				if (ds3 != null) {
					res.enableFirstRow(ds3);
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					/*StringUtil.printMsg("일반 조회 ",this);
					StringUtil.printMsg("쿼리는  ",arr_sql[1].toString(),this);
					StringUtil.printMsg("거래일자 시작== ",sBgnDate,this);
					StringUtil.printMsg("거래일자 끝   == ",sEndDate,this);
					StringUtil.printMsg("계좌코드   == ",sSiteCode,this);
					StringUtil.printMsg("적요   == ",sTr_Order_Nm,this);*/
					
					cstmt.setString(1,sBgnDate );
					cstmt.setString(2,sEndDate );
					cstmt.setString(3,sSiteCode );
					cstmt.setString(4,sTr_Order_Nm );
					rs = cstmt.executeQuery();							
					
					getDataSet(rs,ds3).flush();
					
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
		
		String uploadType = "1";
		String v_edit_styatus = "";										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
		try {
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("EXCELDS".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
						
						int colNm_Col01	  = ds1.indexOfColumn("COL01");
						int colNm_Col02	  = ds1.indexOfColumn("COL02");
						int colNm_Col03	  = ds1.indexOfColumn("COL03");
						int colNm_Col04	  = ds1.indexOfColumn("COL04");
						int colNm_Col05	  = ds1.indexOfColumn("COL05");
						int colNm_Col06	  = ds1.indexOfColumn("COL06");
						int colNm_Col07	  = ds1.indexOfColumn("COL07");
						int colNm_Col08	  = ds1.indexOfColumn("COL08");
						int colNm_Col09	  = ds1.indexOfColumn("COL09");
						int colNm_Col10	  = ds1.indexOfColumn("COL10");
						int colNm_Col11	  = ds1.indexOfColumn("COL11");
						int colNm_Col12	  = ds1.indexOfColumn("COL12");
						int colNm_Col13	  = ds1.indexOfColumn("COL13");
						int colNm_Col14	  = ds1.indexOfColumn("COL14");
						int colNm_Col15	  = ds1.indexOfColumn("COL15");
						int colNm_Col16	  = ds1.indexOfColumn("COL16");
						int colNm_Col17	  = ds1.indexOfColumn("COL17");
						int colNm_Col18	  = ds1.indexOfColumn("COL18");
						int colNm_Col19	  = ds1.indexOfColumn("COL19");		
						int colNm_TR_SID  = ds1.indexOfColumn("TR_SID");
						
												
						
						for(int i=0; i<rows.length; i++){
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
								v_edit_styatus = "1";
							} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
								v_edit_styatus = "2";
							} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
								v_edit_styatus = "3";
								
							} 
							
								//StringUtil.printMsg("INSERT 1행 ========================",this);
								//StringUtil.printMsg("EDIT_STATUS 값 == ", v_edit_styatus,this);	//프로시져 편집상태 값.
								cstmt = conn.prepareCall(arr_sql[2].toString());
								//StringUtil.printMsg("INSERT 0= ",rows[i].getInt(colNm_TR_SID),this);	//일련번호
								//StringUtil.printMsg("INSERT 1= ",rows[i].getString(colNm_Col01),this);	//거래일시 (은행에서 받은)
								//StringUtil.printMsg("INSERT 2= ",rows[i].getString(colNm_Col02),this);
								//StringUtil.printMsg("INSERT 3= ",rows[i].getString(colNm_Col03),this);
								//StringUtil.printMsg("INSERT 4= ",rows[i].getString(colNm_Col04),this);
								//StringUtil.printMsg("INSERT 5= ",rows[i].getString(colNm_Col05),this);
								//StringUtil.printMsg("INSERT 6= ",rows[i].getString(colNm_Col06),this);
								
								//StringUtil.printMsg("INSERT 21= ","***"+rows[i].getString(colNm_Col14).toString().trim().replaceAll("\\.","") +"***2",this);	//dot의 변환 !!! 주의하자!!!!!!!!!!!!								
								//StringUtil.printMsg("INSERT 22= ","***"+rows[i].getString(colNm_Col04).substring(11,16).replaceAll(":","").toString()+"***4",this);	//거래시각
								
								//StringUtil.printMsg("================ 끝 ===============",this);
								
								cstmt.setInt(1, rows[i].getInt(colNm_TR_SID));
								cstmt.setInt(2, rows[i].getInt(colNm_Col01));
								cstmt.setString(3, rows[i].getString(colNm_Col02));
								cstmt.setString(4, rows[i].getString(colNm_Col03));
								cstmt.setString(5, rows[i].getString(colNm_Col04));
								cstmt.setString(6, rows[i].getString(colNm_Col05));
								cstmt.setString(7, rows[i].getString(colNm_Col06));
								cstmt.setString(8, rows[i].getString(colNm_Col07));
								cstmt.setInt(9, rows[i].getInt(colNm_Col08));
								cstmt.setInt(10, rows[i].getInt(colNm_Col09));
								cstmt.setInt(11, rows[i].getInt(colNm_Col10));
								cstmt.setInt(12, rows[i].getInt(colNm_Col11));
								cstmt.setString(13, rows[i].getString(colNm_Col12));
								cstmt.setString(14, rows[i].getString(colNm_Col13));
								cstmt.setString(15, rows[i].getString(colNm_Col14));
								cstmt.setString(16, rows[i].getString(colNm_Col15));
								cstmt.setInt(17, rows[i].getInt(colNm_Col16));
								cstmt.setInt(18, rows[i].getInt(colNm_Col17));
								cstmt.setString(19, rows[i].getString(colNm_Col18));
								cstmt.setString(20, rows[i].getString(colNm_Col19));
								//cstmt.setString(21, rows[i].getString(colNm_Col14).replace( "\\.","") );
								cstmt.setString(21, rows[i].getString(colNm_Col14).substring(0,4)+rows[i].getString(colNm_Col14).substring(5,7)+rows[i].getString(colNm_Col14).substring(8,10) );
								//cstmt.setString(22, rows[i].getString(colNm_Col04).substring(11,16).replaceAll(":","") );
								cstmt.setString(22, rows[i].getString(colNm_Col04).substring(11,13)+rows[i].getString(colNm_Col04).substring(14,16) );
								cstmt.setString(23, fParamEmpno);
								cstmt.setString(24, fParamIp);
								cstmt.setString(25, v_edit_styatus);
								
								cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(28, java.sql.Types.VARCHAR);
								// 쿼리실행
								cstmt.executeUpdate();

						}
					}
				}
			}
		}catch (SQLException sqle){
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
	                //System.err.println(filePath + " 존재하지 않습니다...");
	                return;
	        }
	
	        // 삭제를 합니다... 혹시 플랫폼에 따라 
	        //퍼미션 오류(SecurityException)가 나올 수 있습니다....
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
