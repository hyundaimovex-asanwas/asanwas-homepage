package sales.menu.ml;

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



public class Ml600I extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_ML600I_01(?,?,?,?,? )");	// 조회
		
		arr_sql[2].append("CALL SALES.PR_ML600I_02(?,?,?,?,?	, ?,?,?,?,?,	?,?,?,?,?,  ?,?,?,?,?,	?,?,?,?,? )");	// 저장 25
		
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
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
		
				
		/* DataSet */
		GauceDataSet ds1 		= gis.read("MAIN_DS");				//메인조회
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//엑셀파일; 
		GauceDataSet ds2 		= gis.read("EXCELDS"); 		//엑셀적용;
		GauceDataSet ds_result 	= gis.read("RESULT");

		/* 메세지 처리 */
		if(ds_result!=null){
			//gres.enableFirstRow(ds_result);
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		

		try {
			/* 검색시 필요한 조건 */
			String sBgnDate 	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String sEndDate 	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String sTrGu  		= HDUtil.nullCheckStr(greq.getParameter("sTrGu"));
			String sTr_OrderNm  = HDUtil.nullCheckStr(greq.getParameter("sTr_OrderNm"));

			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
        		//GauceDataSet ds3 = gis.read("MAIN_DS");

				//조회;            	//O:MAIN_DS=excelDs
				if (ds1 != null) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1,sBgnDate );	//거래일자 시작
					cstmt.setString(2,sEndDate );	//거래일자 끝
					cstmt.setString(3,sTrGu );		//거래구분 01(개성현지불) 고정)
					cstmt.setString(4,sTr_OrderNm );//주문
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
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
					//gres.enableFirstRow(ds2);
					
					//StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet("kaesong"); // Sheet명 
					
					//StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][60];	//배열자체가 스트링이네요..
					
					for (int row = 0; row < sheet0.getRows(); row++) {	

						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							//StringUtil.printMsg("액셀 셀 타입 ==",sheet0.getCell(column,row).getType().toString(), this);

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
							//여기서는 소숫점 잘 가지고 옵니다. 2011-03-02
						}
					}
							
					/*
					 * DataSet Header
					 */
					ds2.addDataColumn(new GauceDataColumn("COL00",    GauceDataColumn.TB_STRING,  2)); // '거래구분'
					ds2.addDataColumn(new GauceDataColumn("COL01",    GauceDataColumn.TB_STRING, 10)); // '매출처'    	
					ds2.addDataColumn(new GauceDataColumn("COL02",    GauceDataColumn.TB_STRING, 12)); // '주문번호'    
					ds2.addDataColumn(new GauceDataColumn("COL03",    GauceDataColumn.TB_STRING,  8)); // '주문일자'    
					ds2.addDataColumn(new GauceDataColumn("COL04",    GauceDataColumn.TB_STRING,  4)); // '일련번호'    
					ds2.addDataColumn(new GauceDataColumn("COL05",    GauceDataColumn.TB_STRING, 20)); // '주문자명'    
					ds2.addDataColumn(new GauceDataColumn("COL06",    GauceDataColumn.TB_STRING, 13)); // '연락처1'
					ds2.addDataColumn(new GauceDataColumn("EXCH_RATE",GauceDataColumn.TB_DECIMAL,10)); // '환율' 	
					ds2.addDataColumn(new GauceDataColumn("COL08",    GauceDataColumn.TB_DECIMAL,10)); // '이용가격' 	
					ds2.addDataColumn(new GauceDataColumn("COL09",    GauceDataColumn.TB_STRING, 10)); // '결제 방법'   

					ds2.addDataColumn(new GauceDataColumn("COL10",    GauceDataColumn.TB_STRING,  1)); // '승인 여부'   
					ds2.addDataColumn(new GauceDataColumn("COL11",    GauceDataColumn.TB_DECIMAL,10)); // '승인 금액' 	
					ds2.addDataColumn(new GauceDataColumn("COL12",    GauceDataColumn.TB_STRING,  8)); // '카드사'      
					ds2.addDataColumn(new GauceDataColumn("COL13",    GauceDataColumn.TB_STRING, 20)); // '카드번호'    
					ds2.addDataColumn(new GauceDataColumn("COL14",    GauceDataColumn.TB_STRING,  4)); // '유효기간'    
					
					ds2.addDataColumn(new GauceDataColumn("COL15",    GauceDataColumn.TB_STRING,  2)); // '할부개월수'  
					ds2.addDataColumn(new GauceDataColumn("COL16",    GauceDataColumn.TB_STRING, 14)); // '승인일시'    
					ds2.addDataColumn(new GauceDataColumn("COL17",    GauceDataColumn.TB_STRING,  8)); // '승인번호'
					ds2.addDataColumn(new GauceDataColumn("ORDER_SID",GauceDataColumn.TB_DECIMAL,10)); // '거래SID'
					/*
					 * temp에 있는 불러온 데이터를 ds2로 뿌리는 부분 
					 */
					for (int row = 1; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds2.newDataRow();
						//StringUtil.printMsg("형변환===",arr[row][4],this);
						////StringUtil.printMsg("형변환===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("계좌코드   == ",sAcctGu,this);
						
						gRow.addColumnValue(arr[row][1]);
						gRow.addColumnValue(arr[row][2]);
						gRow.addColumnValue(arr[row][3]);
						gRow.addColumnValue(arr[row][4]);
						gRow.addColumnValue(arr[row][5]);
						gRow.addColumnValue(arr[row][6]);
						gRow.addColumnValue(arr[row][7]);
						gRow.addColumnValue(Double.parseDouble(arr[row][8]));	//number
						gRow.addColumnValue(Double.parseDouble(arr[row][9]));	//number
						gRow.addColumnValue(arr[row][10]);
						
						gRow.addColumnValue(arr[row][11]);
						gRow.addColumnValue(Double.parseDouble(arr[row][12]));	//number
						gRow.addColumnValue(arr[row][13]);
						gRow.addColumnValue(arr[row][14]);
						gRow.addColumnValue(arr[row][15]);
						
						gRow.addColumnValue(arr[row][16]);
						gRow.addColumnValue(arr[row][17]);
						gRow.addColumnValue(arr[row][18]);
						gRow.addColumnValue(10); 		// ORDER_SID 컬럼 : 기본값 세팅 1로 준 후에 화면에서 0으로 업뎃 (최초 입력시)
						ds2.addDataRow(gRow);
						
						/*for (int column = 1; column < sheet0.getColumns()+1; column++) {
						////StringUtil.printMsg("데이타",arr[row][column], this);
						gRow.addColumnValue(arr[row][column]);
						}*/

					}
					//StringUtil.printMsg("카운트 == " , ds2.getDataRowCnt(), this);
					
					gos.write(ds2);	//3.x버전의 ds2.flush()에 해당
					
					//StringUtil.printMsg("엑셀 삭제전",this);
					deleteExcelFile(fExcelFilePath);
				}
				
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
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds_xls 	= gis.read("EXCELDS");
		GauceDataSet ds_result	= gis.read("RESULT");
		
		
		String uploadType = "1";
		String v_edit_styatus = "";										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
		try {
			if (ds_xls != null) {
			
				GauceDataRow[] 		rows = ds_xls.getDataRows();
				GauceDataColumn[] 	cols = ds_xls.getDataColumns();
						
				//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				
				int colNm_Col00	  = ds_xls.indexOfColumn("COL00");
				int colNm_Col01	  = ds_xls.indexOfColumn("COL01");
				int colNm_Col02	  = ds_xls.indexOfColumn("COL02");
				int colNm_Col03	  = ds_xls.indexOfColumn("COL03");
				int colNm_Col04	  = ds_xls.indexOfColumn("COL04");
				int colNm_Col05	  = ds_xls.indexOfColumn("COL05");
				int colNm_Col06	  = ds_xls.indexOfColumn("COL06");
				int colNm_Col07	  = ds_xls.indexOfColumn("EXCH_RATE");
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
				int colNm_ORDER_SID  = ds_xls.indexOfColumn("ORDER_SID");
						
												
						
				for(int i=0; i<rows.length; i++){
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
					} 
					
					//StringUtil.printMsg("INSERT "+i+"행 ========================",this);
					//StringUtil.printMsg("EDIT_STATUS 값 == ", v_edit_styatus,this);	//프로시져 편집상태 값.
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					StringUtil.printMsg("주문번호==",""+rows[i].getString(colNm_Col02),this);	//주문번호
					//StringUtil.printMsg("환율... ",""+rows[i].getDouble(colNm_Col07),this);	//환율
					//StringUtil.printMsg("이용가격= ",""+rows[i].getInt(colNm_Col08),this);	
					//StringUtil.printMsg("승인금액= ",""+rows[i].getInt(colNm_Col11),this);
					//StringUtil.printMsg("INSERT 3= ",rows[i].getString(colNm_Col03),this);
					//StringUtil.printMsg("INSERT 4= ",rows[i].getString(colNm_Col04),this);
					//StringUtil.printMsg("INSERT 5= ",rows[i].getString(colNm_Col05),this);
					//StringUtil.printMsg("INSERT 6= ",rows[i].getString(colNm_Col06),this);
					//StringUtil.printMsg("INSERT 7= ","***"+rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/","")+"***",this);	//거래일자
					//StringUtil.printMsg("INSERT 8= ","***"+rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":","")+"***",this);	//거래시각
					//StringUtil.printMsg("================ 끝 ===============",this);
					cstmt.setString(1, rows[i].getString(colNm_Col00));
					cstmt.setString(2, rows[i].getString(colNm_Col01));
					cstmt.setString(3, rows[i].getString(colNm_Col02));
					cstmt.setString(4, rows[i].getString(colNm_Col03));
					cstmt.setString(5, rows[i].getString(colNm_Col04));
					cstmt.setString(6, rows[i].getString(colNm_Col05));
					cstmt.setString(7, rows[i].getString(colNm_Col06));
					cstmt.setDouble(8, rows[i].getDouble(colNm_Col07));
					cstmt.setInt(9, rows[i].getInt(colNm_Col08));
					cstmt.setString(10, rows[i].getString(colNm_Col09));
					cstmt.setString(11, rows[i].getString(colNm_Col10));
					cstmt.setInt(12, rows[i].getInt(colNm_Col11));
					cstmt.setString(13, rows[i].getString(colNm_Col12));
					cstmt.setString(14, rows[i].getString(colNm_Col13));
					cstmt.setString(15, rows[i].getString(colNm_Col14));
					cstmt.setString(16, rows[i].getString(colNm_Col15));
					cstmt.setString(17, rows[i].getString(colNm_Col16));
					cstmt.setString(18, rows[i].getString(colNm_Col17));
					cstmt.setInt(19, rows[i].getInt(colNm_ORDER_SID));
					cstmt.setString(20, fParamEmpno);
					cstmt.setString(21, fParamIp);
					cstmt.setString(22, v_edit_styatus);
					
					cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
					// 쿼리실행
					cstmt.executeUpdate();
//							
				}
			}
			gos.close();
		}catch (SQLException sqle){
			sqle.printStackTrace();
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		} finally {
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
