package sales.menu.cu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;

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

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;


public class Cu020I extends SuperServlet {

	private static final long serialVersionUID = 1L;
	
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		
		arr_sql[1].append("CALL SALES.PR_RV250B_01(?,?,  ?)");	// 조회
		
		arr_sql[2].append("CALL SALES.PR_RV250B_02(" +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?,?,?,?," +
				"?,?,?" +
				")");	// 저장
		
		arr_sql[3].append("CALL SALES.PR_RV250B_03(?,?,?,?,?,  ?,?,?)"); // 자료확인
		
		arr_sql[4].append("CALL SALES.PR_RV250B_04(?,?,?,?,?,  ?,?,?)"); // 자료이관
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            	
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//	"JSP(O:EXCELDS=tempExcelDs)",
            	if(dSets[i].getName().equals("tempExcelDs")){
					GauceDataSet ds1 = gis.read("EXCELDS");

					ds1.addDataColumn(new GauceDataColumn("EXCEL_INFO", GauceDataColumn.TB_STRING));
					ds1.addDataColumn(new GauceDataColumn("EXCEL_URL", GauceDataColumn.TB_URL, 1024));
					gos.write(ds1);
				}
			}
            gos.close();
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
	}

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("============================", "", this);
		/* 2014.01.12 심동현
		 * 여기는 액셀을 로드하는 화면이므로 
		 * 	파일 업로드, 엑셀읽기, db에서 조회하기 3가지를 수행함.
		 * 
		 * */
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();		
		
		String[] 			columnName 	= null;
		
		/* DataSet */
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//엑셀파일; 
		GauceDataSet ds2 		= gis.read("EXCELDS"); 		//엑셀적용;
		GauceDataSet ds3 		= gis.read("MAIN_DS"); 		//메인조회;
		GauceDataSet ds03 		= gis.read("DS03"); // 자료이관 
		GauceDataSet ds04 		= gis.read("DS04"); // 자료이관
		GauceDataSet ds_result 	= gis.read("RESULT");
		
		/* 메세지 처리 */
		if(ds_result!=null){
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		
		try {
			/* 검색시 필요한 조건 */
			int sClientSid = HDUtil.nullCheckNum(greq.getParameter("sClientSid")); 
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
        		//GauceDataSet ds3 		= gis.read("MAIN_DS"); 		//메인조회;

				//조회;      	//O:MAIN_DS=excelDs
				if (ds3 != null) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					//StringUtil.printMsg("일반 조회 ",this);
					//StringUtil.printMsg("매출처 ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"1" );

					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds3));
				}
				
            	//액셀적용 JSP (I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs)
    			// 파일 업로드 
				if (excelDs != null) {
					GauceDataRow[] 		excelRow = excelDs.getDataRows();
					GauceDataColumn[] 	excelCol = excelDs.getDataColumns();
					
					int data_name = excelDs.indexOfColumn("EXCEL_INFO");
					int data_url  = excelDs.indexOfColumn("EXCEL_URL");
					//StringUtil.printMsg("data_name==",data_name, this);
					//StringUtil.printMsg("data_url==",data_url, this);
					
					String d_name = excelRow[0].getString(data_name);
					String o_name = excelRow[0].getString(0).trim();
					
					o_name = System.currentTimeMillis()+".xls";
					//StringUtil.printMsg("엑셀 생성파일명:",o_name, this);
					
					fExcelFilePath = "d:/myWorks/HDAsan/WebContent/Sales/file/excel/acct/" + o_name;//로컬용
					//fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;	//서버용
					
					//StringUtil.printMsg("엑셀 생성파일 경로:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}


				
				
				
				// 엑셀 읽기
				if (ds2 != null) {
					//StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명

					Sheet sheet0 = workbook.getSheet("Sheet1"); // Sheet명 
					
					StringUtil.printMsg("액셀읽기 ====ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][600];	//배열자체가 스트링이네요..
					
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
					
					ds2.addDataColumn(new GauceDataColumn("UPLOAD_MSG",   GauceDataColumn.TB_STRING, 200)); // 0
					ds2.addDataColumn(new GauceDataColumn("SEQ",      	  GauceDataColumn.TB_STRING, 10));  // 1
					ds2.addDataColumn(new GauceDataColumn("COL01",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL02",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL03",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL04",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL05",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL06",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL07",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL08",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL09",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL10",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL11",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL12",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL13",        GauceDataColumn.TB_STRING, 60)); // 2주소2
					ds2.addDataColumn(new GauceDataColumn("COL14",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL15",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL16",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL17",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL18",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL19",        GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("YN",			  GauceDataColumn.TB_STRING, 10)); 
					/*
					 * 고객정보 데이터가 있는 엑셀을 읽어서 각 필드의 오류 체크를 한다 
					 * 오류체크를 하기면서 오류가 있는경우에는 화면에 색으로 표시를 해준다 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
							//StringUtil.printMsg("데이타",arr[row][column], this);
							gRow.addColumnValue(arr[row][column]);
						}
						
						gRow.addColumnValue("Y"); // 읽기 수정, 등의 플래그로 사용
						ds2.addDataRow(gRow);
					}
					
					//StringUtil.printMsg("카운트 == " , ds2.getDataRowCnt(), this);
					gos.write(ds2);		//3.x버전의 ds2.flush()에 해당	//ds2.flush();	
					
					
					//StringUtil.printMsg("엑셀 삭제전",this);
					deleteExcelFile(fExcelFilePath);
				}
						

				
				if (ds03 != null) {
					cstmt = conn.prepareCall(arr_sql[3].toString());
					//StringUtil.printMsg("자료확인 ",this);
					//StringUtil.printMsg("sClientSid ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"1" );
					cstmt.setString(3, fParamEmpno);
					cstmt.setString(4, fParamIp);
					cstmt.setString(5, "3");
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
					
					
					cstmt.executeUpdate();		//이건 업데이트임
					
					if(!cstmt.getString(6).equals("Y"))
						throw new Exception (cstmt.getString(8));
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(6));
						row1.addColumnValue(cstmt.getString(7));
						row1.addColumnValue(cstmt.getString(8));
						
						ds_result.addDataRow(row1);
					}
				}

				if (ds04 != null) {
					cstmt = conn.prepareCall(arr_sql[4].toString());
					StringUtil.printMsg("자료이관 ",this);
					StringUtil.printMsg("sClientSid ",sClientSid,this);
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,"1" );
					cstmt.setString(3, fParamEmpno);
					cstmt.setString(4, fParamIp);
					cstmt.setString(5, "3");
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
					cstmt.executeUpdate();		//이건 업데이트임
					
					if(!cstmt.getString(6).equals("Y"))
						throw new Exception (cstmt.getString(8));
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(6));
						row1.addColumnValue(cstmt.getString(7));
						row1.addColumnValue(cstmt.getString(8));
						
						ds_result.addDataRow(row1);
					}
					
				}
				if(ds_result!=null) ds_result.flush();
            }
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			gos.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* 2013.10.22 심동현
		 * 이렇게 TR을 호출합니다. 
		 * 		 * JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)"
		 * 	따라서 gis.read로 가져오면 됨.
		 * 
		 * */
		StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;

		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds_xls 	= gis.read("EXCELDS");
		GauceDataSet ds_result	= gis.read("RESULT");

		int sClientSid = HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
		String uploadType = "1";
		String v_edit_styatus = "";										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
		
		try {
			if (ds_xls != null) {
				
				GauceDataRow[] 		rows = ds_xls.getDataRows();
				GauceDataColumn[] 	cols = ds_xls.getDataColumns();
						
			
				StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				int colNm_Seq     = ds_xls.indexOfColumn("SEQ");
				int colNm_Col01	  = ds_xls.indexOfColumn("COL01");
				int colNm_Col02	  = ds_xls.indexOfColumn("COL02");
				int colNm_Col03	  = ds_xls.indexOfColumn("COL03");
				int colNm_Col04	  = ds_xls.indexOfColumn("COL04");
				int colNm_Col05	  = ds_xls.indexOfColumn("COL05");
				int colNm_Col06	  = ds_xls.indexOfColumn("COL06");
				int colNm_Col07	  = ds_xls.indexOfColumn("COL07");
				int colNm_Col08	  = ds_xls.indexOfColumn("COL08");
				int colNm_Col09	  = ds_xls.indexOfColumn("COL09");
				int colNm_Col10	  = ds_xls.indexOfColumn("COL10");
				int colNm_Col11	  = ds_xls.indexOfColumn("COL11");
				int colNm_Col12	  = ds_xls.indexOfColumn("COL12");
				int colNm_Col13	  = ds_xls.indexOfColumn("COL13");
				int colNm_Col14	  = ds_xls.indexOfColumn("COL14");
				int colNm_Col15	  = ds_xls.indexOfColumn("COL15");
				int colNm_Col16	  = ds_xls.indexOfColumn("COL16");
				int colNm_Col17	  = ds_xls.indexOfColumn("COL17");
				int colNm_Col18	  = ds_xls.indexOfColumn("COL18");
				int colNm_Col19	  = ds_xls.indexOfColumn("COL19");
						
				for(int i=0; i<rows.length; i++){
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
					} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
						
					}
					
					//StringUtil.printMsg("INSERT",this);
					//StringUtil.printMsg("v_edit_styatus",v_edit_styatus, this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2, uploadType);
					
					cstmt.setString(3, rows[i].getString(colNm_Seq));
					cstmt.setString(4, rows[i].getString(colNm_Col01));
					cstmt.setString(5, rows[i].getString(colNm_Col02));
					cstmt.setString(6, rows[i].getString(colNm_Col03));
					cstmt.setString(7, rows[i].getString(colNm_Col04));
					
					cstmt.setString(8, rows[i].getString(colNm_Col05));
					cstmt.setString(9, rows[i].getString(colNm_Col06));
					cstmt.setString(10, rows[i].getString(colNm_Col07));
					cstmt.setString(11, rows[i].getString(colNm_Col08));
					cstmt.setString(12, rows[i].getString(colNm_Col09));
					
					cstmt.setString(13, rows[i].getString(colNm_Col10));
					cstmt.setString(14, rows[i].getString(colNm_Col11));
					cstmt.setString(15, rows[i].getString(colNm_Col12));
					cstmt.setString(16, rows[i].getString(colNm_Col13));
					cstmt.setString(17, rows[i].getString(colNm_Col14));
					
					cstmt.setString(18, rows[i].getString(colNm_Col15));
					cstmt.setString(19, rows[i].getString(colNm_Col16));
					
					cstmt.setString(20, rows[i].getString(colNm_Col17));
					cstmt.setString(21, rows[i].getString(colNm_Col18));
					cstmt.setString(22, rows[i].getString(colNm_Col19));
					
					cstmt.setString(23, "");
					cstmt.setString(24, "");
					cstmt.setString(25, "");
					cstmt.setString(26, "");
					cstmt.setString(27, "");
					cstmt.setString(28, "");
					cstmt.setString(29, "");
					cstmt.setString(30, "");
					cstmt.setString(31, "");
					cstmt.setString(32, "");
					cstmt.setString(33, "");
					
					cstmt.setString(34, fParamEmpno);
					cstmt.setString(35, fParamIp);
					cstmt.setString(36, v_edit_styatus);
					
					cstmt.registerOutParameter(37, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(38, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(39, java.sql.Types.VARCHAR);
					// 쿼리실행
					cstmt.executeUpdate();
//							
				}
			}
		}catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			gos.close();

			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
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
			System.err.println("Unable to delete " + filePath + "(" + e.getMessage() + ")");
		}


	}	
}
