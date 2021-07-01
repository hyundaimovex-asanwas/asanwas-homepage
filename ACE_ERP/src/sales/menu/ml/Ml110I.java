package sales.menu.ml;
/*
 * 아직 100% 수정한 케이스가 아닙니다. -_-
 * */
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

public class Ml110I extends SuperServlet {
	private String fExcelFilePath = "";
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append ("SELECT  \n")           
					  .append (" CATE1 AS COL01 , CATE2 AS COL02 , BRAND AS COL03 , ITEM_NM AS COL04 \n")
					  .append (" ,MAKER AS  COL05, MADEIN AS COL06, CASE WHEN DSP_YN='Y' THEN 'T' ELSE 'F' END COL07      \n")
					  .append (" ,CASE WHEN USE_YN='Y' THEN 'T' ELSE 'F' END COL08        \n")
					  .append (" ,SELLER_CD AS COL09, SELLER_SID AS COL10, CASE WHEN TAX_YN='Y' THEN 'T' ELSE 'F' END COL11, CURRENCY_CD AS COL12           \n")
					  .append (" ,AMT_UNIT AS COL13, AMT_NET AS COL14, AMT_VAT AS COL15, AMT_EMP  AS COL16                \n")
					  .append (" ,ML_GUBN AS COL17 ,AMT_COST AS COL18, REMARKS AS COL19, ML_GUBN2 AS COL20, GARBAGE_SID  AS  GARBAGE_SID	\n")
					  .append (" FROM SALES.TML100	\n");
				  	  		
		arr_sql[2].append("CALL SALES.PR_ML110I_01(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?, ?,?,?,?,?,  ?,?,?,?,?,?)");		//인서트하기 26개	.
		
		
		

	
	}
 
	

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("DS TYPE","선조회",this);

		
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            	
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:EXCELDS=tempExcelDs
            	if(dSets[i].getName().equals("tempExcelDs")){
					GauceDataSet ds1 = gis.read("EXCELDS");

					ds1.addDataColumn(new GauceDataColumn("EXCEL_INFO", GauceDataColumn.TB_STRING));
					ds1.addDataColumn(new GauceDataColumn("EXCEL_URL", GauceDataColumn.TB_URL, 1024));
					gos.write(ds1);
				}
			}
            
            gos.close();
		} catch (Exception e) {
			
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
		GauceDataSet ds3 		= gis.read("MAIN_DS");				//메인조회
		GauceDataSet ds_result 	= gis.read("RESULT");		
		
		
		if(ds_result!=null){
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		
		
		try {
			/* 검색시 필요한 조건*/
			String 		v_cate1		= HDUtil.nullCheckStr(greq.getParameter("v_cate1"));
			String 		sTrGu		= HDUtil.nullCheckStr(greq.getParameter("sTrGu"));
			String 		sTrGu2		= HDUtil.nullCheckStr(greq.getParameter("sTrGu2"));
			


			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
        		//GauceDataSet ds3 = gis.read("MAIN_DS");

				//조회;            	//O:MAIN_DS=excelDs
				if (ds3 != null) {
					if (!"".equals(sTrGu))
						arr_sql[1].append (" WHERE ML_GUBN = ? \n");
					if (!"".equals(sTrGu2))
						arr_sql[1].append (" and ML_GUBN2 = ? \n");
					//if (!"".equals(v_cate1))
						//arr_sql[1].append (" and cate1 = ? \n");
					//StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					if (!"".equals(sTrGu))
					cstmt.setString(1,sTrGu );	//거래일자 시작
					cstmt.setString(2,sTrGu2 );	//거래일자 끝
					//cstmt.setString(3,v_cate1 );		//거래구분 01(개성현지불) 고정)
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds3));
				}
            }

    
	
            
            
            /*
			// 파일 업로드 
				if (excelDs != null) {
					
				//	StringUtil.printMsg("============================", excelDs.getName(), this);
					
					//GauceDataSet excelDs = req.getGauceDataSet("TEMP_EXCEL");
					GauceDataRow[] 		excelRow = excelDs.getDataRows();
					GauceDataColumn[] 	excelCol = excelDs.getDataColumns();
					
					int data_name = excelDs.indexOfColumn("EXCEL_INFO");
					int data_url  = excelDs.indexOfColumn("EXCEL_URL");
					
					String d_name = excelRow[0].getString(data_name);
					String o_name = excelRow[0].getString(0).trim();
					
					o_name = System.currentTimeMillis()+".xls";
					
				//	StringUtil.printMsg("엑셀 생성파일명:",o_name, this);
					
					//fExcelFilePath = "D:/myWorks/HDAsan/WebContent/Sales/file/excel/acct/" + o_name;//로컬용
					fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;	//
					
		    		StringUtil.printMsg("엑셀 생성파일 경로:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}
				
				// 엑셀 읽기
				if (ds2 != null) {
					res.enableFirstRow(ds2);
					
				//	StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet("Sheet1"); // Sheet명 
					
			//		StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][60];	//배열자체가 스트링이네요..
					
					for (int row = 0; row < sheet0.getRows(); row++) {	

						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							
						//	StringUtil.printMsg("액셀 셀 타입 ==",sheet0.getCell(column,row).getType().toString(), this);

							// 숫자타입							
							if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
								NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
								content = numberCell.getValue()+""; 
								//StringUtil.printMsg("액셀시트 숫자==","row="+row+"::column="+column+"::값="+content, this);
								arr[row][column+1] = content;
							// 문자타입		
							} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
								LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
								content = labelCell.getContents();
								//StringUtil.printMsg("액셀시트 문자==","row="+row+"::column="+column+"::값="+content, this);
								arr[row][column+1] = content;
							// 날짜 타입 		
							} else if(sheet0.getCell(column,row).getType() == CellType.DATE)	{
								DateCell dateCell = (DateCell) sheet0.getCell(column,row);
								content = dateCell.getDate()+"";
								//StringUtil.printMsg("액셀시트 날짜==","row="+row+"::column="+column+"::값="+content, this);
								arr[row][column+1] = content;
							} 
						}
					}
							
					//DataSet Header
					 
					 
					ds2.addDataColumn(new GauceDataColumn("COL01",    GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("COL02",    GauceDataColumn.TB_STRING, 10));
					ds2.addDataColumn(new GauceDataColumn("COL03",    GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("COL04",    GauceDataColumn.TB_STRING, 100));
					
					ds2.addDataColumn(new GauceDataColumn("COL05",    GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("COL06",    GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("COL07",    GauceDataColumn.TB_STRING, 1));
					ds2.addDataColumn(new GauceDataColumn("COL08",    GauceDataColumn.TB_STRING, 1));
					ds2.addDataColumn(new GauceDataColumn("COL09",    GauceDataColumn.TB_STRING, 10));
					
					ds2.addDataColumn(new GauceDataColumn("COL10",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL11",    GauceDataColumn.TB_STRING, 1));
					ds2.addDataColumn(new GauceDataColumn("COL12",    GauceDataColumn.TB_STRING, 3));
					ds2.addDataColumn(new GauceDataColumn("COL13",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL14",    GauceDataColumn.TB_DECIMAL, 10));
					
					ds2.addDataColumn(new GauceDataColumn("COL15",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL16",    GauceDataColumn.TB_DECIMAL, 10));
					ds2.addDataColumn(new GauceDataColumn("COL17",    GauceDataColumn.TB_STRING, 2));
					ds2.addDataColumn(new GauceDataColumn("COL18",    GauceDataColumn.TB_DECIMAL, 10));					
					ds2.addDataColumn(new GauceDataColumn("COL19",    GauceDataColumn.TB_STRING, 2000));
					ds2.addDataColumn(new GauceDataColumn("COL20",    GauceDataColumn.TB_STRING, 3));					
					ds2.addDataColumn(new GauceDataColumn("GARBAGE_SID",	  GauceDataColumn.TB_DECIMAL, 10));
					//temp에 있는 불러온 데이터를 ds2로 뿌리는 부분 
					 
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						//StringUtil.printMsg("형변환===",arr[row][4],this);
						//StringUtil.printMsg("형변환===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("계좌코드   == ",sAcctGu,this);
						
						
						gRow.addColumnValue(arr[row][1]);
						gRow.addColumnValue(arr[row][2]);
						gRow.addColumnValue(arr[row][3]);
						gRow.addColumnValue(arr[row][4]);
						
						gRow.addColumnValue(arr[row][5]);
						gRow.addColumnValue(arr[row][6]);
						gRow.addColumnValue(arr[row][7]);
						gRow.addColumnValue(arr[row][8]);
						gRow.addColumnValue(arr[row][9]);
						
						//gRow.addColumnValue(arr[row][10]);	//number	
						gRow.addColumnValue(Double.parseDouble(arr[row][10]));	//number					
						gRow.addColumnValue(arr[row][11]);
						gRow.addColumnValue(arr[row][12]);
						//gRow.addColumnValue(arr[row][13]);	//number
						//gRow.addColumnValue(arr[row][14]);	//number		
						gRow.addColumnValue(Double.parseDouble(arr[row][13]));	//number	
						gRow.addColumnValue(Double.parseDouble(arr[row][14]));	//number
						
						
						//gRow.addColumnValue(arr[row][15]);	//number
						//gRow.addColumnValue(arr[row][16]);	//number		
						gRow.addColumnValue(Double.parseDouble(arr[row][15]));	//number
						gRow.addColumnValue(Double.parseDouble(arr[row][16]));	//number
						gRow.addColumnValue(arr[row][17]);	
						//gRow.addColumnValue(arr[row][18]);														
						gRow.addColumnValue(Double.parseDouble(arr[row][18]));	//number
						gRow.addColumnValue(arr[row][19]);	//	
						gRow.addColumnValue(arr[row][20]);	//	
						gRow.addColumnValue(1); 		// GARBAGE_SID 컬럼 : 기본값 세팅 1로 준 후에 화면에서 0으로 업뎃 (최초 입력시)
						
						ds2.addDataRow(gRow);
						
						for (int column = 1; column < sheet0.getColumns()+1; column++) {
						////StringUtil.printMsg("데이타",arr[row][column], this);
						gRow.addColumnValue(arr[row][column]);
						}
					}
					//StringUtil.printMsg("카운트 == " , ds2.getDataRowCnt(), this);
					ds2.flush();
					
					StringUtil.printMsg("엑셀 삭제전",this);
					deleteExcelFile(fExcelFilePath);
				}

				if(ds_result!=null) ds_result.flush();*/
            
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
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
						int colNm_Col10     = ds1.indexOfColumn("COL10");
						int colNm_Col11	  = ds1.indexOfColumn("COL11");
						int colNm_Col12	  = ds1.indexOfColumn("COL12");
						int colNm_Col13	  = ds1.indexOfColumn("COL13");
						int colNm_Col14	  = ds1.indexOfColumn("COL14");
						int colNm_Col15	  = ds1.indexOfColumn("COL15");
						int colNm_Col16	  = ds1.indexOfColumn("COL16");
						int colNm_Col17	  = ds1.indexOfColumn("COL17");
						int colNm_Col18	  = ds1.indexOfColumn("COL18");
						int colNm_Col19	  = ds1.indexOfColumn("COL19");
						int colNm_Col20	  = ds1.indexOfColumn("COL20");

												
						
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
	
									cstmt.setString(1, rows[i].getString(colNm_Col01));
									cstmt.setString(2, rows[i].getString(colNm_Col02));
									cstmt.setString(3, rows[i].getString(colNm_Col03));									
									cstmt.setString(4, rows[i].getString(colNm_Col04));						
									//cstmt.setString(5, rows[i].getString(colNm_Col05).substring(0,4)+rows[i].getString(colNm_Col05).substring(5,7)+rows[i].getString(colNm_Col05).substring(8,10) );
								
									cstmt.setString(5, rows[i].getString(colNm_Col05));
									cstmt.setString(6, rows[i].getString(colNm_Col06));
									//cstmt.setString(7, rows[i].getString(colNm_Col07));
									
							if (  rows[i].getString(colNm_Col07).equals("T") ) {
								cstmt.setString(7, "Y");
							} else {
								cstmt.setString(7, "N");
							}	
																
							//		cstmt.setString(8, rows[i].getString(colNm_Col08));
									
							if (  rows[i].getString(colNm_Col08).equals("T") ) {
								cstmt.setString(8, "Y");
							} else {
								cstmt.setString(8, "N");
							}	
																
									cstmt.setString(9, rows[i].getString(colNm_Col09));
								
									cstmt.setInt(10, rows[i].getInt(colNm_Col10));
									//cstmt.setString(10, rows[i].getString(colNm_Col10).substring(0,4)+rows[i].getString(colNm_Col10).substring(5,7)+rows[i].getString(colNm_Col10).substring(8,10) );
									cstmt.setString(11, rows[i].getString(colNm_Col11));
									
							if (  rows[i].getString(colNm_Col11).equals("T") ) {
								cstmt.setString(11, "Y");
							} else {
								cstmt.setString(11, "N");
							}	
																							
									cstmt.setString(12, rows[i].getString(colNm_Col12));
									cstmt.setInt(13, rows[i].getInt(colNm_Col13));
									//cstmt.setString(13, rows[i].getString(colNm_Col13).substring(0,4)+rows[i].getString(colNm_Col13).substring(5,7)+rows[i].getString(colNm_Col13).substring(8,10) );
									//cstmt.setString(14, rows[i].getString(colNm_Col14).substring(0,4)+rows[i].getString(colNm_Col14).substring(5,7)+rows[i].getString(colNm_Col14).substring(8,10) );									
									//cstmt.setString(8, rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/",""));
									cstmt.setInt(14, rows[i].getInt(colNm_Col14));
								
									cstmt.setInt(15, rows[i].getInt(colNm_Col15));
									cstmt.setInt(16, rows[i].getInt(colNm_Col16));
									//cstmt.setString(15, rows[i].getString(colNm_Col15).substring(0,4)+rows[i].getString(colNm_Col15).substring(5,7)+rows[i].getString(colNm_Col15).substring(8,10) );		
									//cstmt.setString(16, rows[i].getString(colNm_Col16).substring(0,4)+rows[i].getString(colNm_Col16).substring(5,7)+rows[i].getString(colNm_Col16).substring(8,10) );		
									cstmt.setString(17, rows[i].getString(colNm_Col17));
									cstmt.setInt(18, rows[i].getInt(colNm_Col18));
									//cstmt.setString(18, rows[i].getString(colNm_Col18).substring(0,4)+rows[i].getString(colNm_Col18).substring(5,7)+rows[i].getString(colNm_Col18).substring(8,10) );									
									cstmt.setString(19, rows[i].getString(colNm_Col19));
									cstmt.setString(20, rows[i].getString(colNm_Col20));
									//cstmt.setString(8, rows[i].getString(colNm_Col01).substring(0,4)+rows[i].getString(colNm_Col01).substring(5,7)+rows[i].getString(colNm_Col01).substring(8,10) );
									//cstmt.setString(9, rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":",""));
									//cstmt.setString(9, rows[i].getString(colNm_Col01).substring(11,13)+rows[i].getString(colNm_Col01).substring(14,16) );
								    

								cstmt.setString(21, fParamEmpno);
								cstmt.setString(22, fParamIp);
								cstmt.setString(23, v_edit_styatus);
								
								cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);
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
