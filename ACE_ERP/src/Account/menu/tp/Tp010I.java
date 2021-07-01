package Account.menu.tp;
//
//20160421	심동현	찾으신 금액 컬럼 삭제 안해도 업로드되게 컬럼 조정
//					액셀에 금액란 , 들어간 문자열이어도 치환하게 수정
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

import sales.common.HDConstant;		//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.HDUtil;			//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.StringUtil;		//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.SuperServlet;	//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용(import)하는 걸로
public class Tp010I extends SuperServlet {
	private static final long serialVersionUID = 1L;
	private String fExcelFilePath = "";
	public void makeSql() {

		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_AC080I_01(?,?,?,?, ?)");	// 조회
		arr_sql[2].append("CALL SALES.PR_AC080I_02(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,   ?,?,? )");	// 저장
		
	}

	
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;


		try{
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
		
		
		/* DataSet I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs,O:MAIN_DS=excelDs */
		GauceDataSet ds1 		= gis.read("MAIN_DS");		//메인조회
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//엑셀파일; 
		GauceDataSet ds2 		= gis.read("EXCELDS"); 		//엑셀적용;
		GauceDataSet ds_result 	= gis.read("RESULT");

		if(ds_result!=null){
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		/*
		 * 검색시 필요한 조건
		 */
		try {
			String sBgnDate = HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String sEndDate = HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String sAcctGu  = HDUtil.nullCheckStr(greq.getParameter("sAcctGu"));
			String sTr_Sum  = HDUtil.nullCheckStr(greq.getParameter("sTr_Sum"));
			
			
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput();

            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		

				//조회;            	//O:MAIN_DS=excelDs
				if (ds1 != null) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					/*StringUtil.printMsg("일반 조회 ",this);
					StringUtil.printMsg("쿼리는  ",arr_sql[1].toString(),this);
					StringUtil.printMsg("거래일자 시작== ",sBgnDate,this);
					StringUtil.printMsg("거래일자 끝   == ",sEndDate,this);
					StringUtil.printMsg("계좌코드   == ",sAcctGu,this);
					StringUtil.printMsg("적요   == ",sTr_Sum,this);*/
					cstmt.setString(1,sBgnDate );
					cstmt.setString(2,sEndDate );
					cstmt.setString(3,sAcctGu );
					cstmt.setString(4,sTr_Sum );
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
				
            	//액셀적용 JSP (I:TEMP_EXCEL=tempExcelDs)
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
					
					//fExcelFilePath = "d:/myWorks/HDAsan/WebContent/Sales/file/excel/acct/" + o_name;//로컬용
					fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_EXCEL_COST + o_name;	//서버용

					//StringUtil.printMsg("엑셀 생성파일 경로:",fExcelFilePath, this);
					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}				

				// 엑셀 읽어서 그리드로 뿌리기 O:EXCELDS=excelDs
				if (ds2 != null) {
					//gres.enableFirstRow(ds2);
					
					//StringUtil.printMsg("EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet("Sheet"); // Sheet명 : Sheet로 수정160421 

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
					ds2.addDataColumn(new GauceDataColumn("COL01",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL02",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL03",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL04",    GauceDataColumn.TB_DECIMAL, 10)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL05",    GauceDataColumn.TB_DECIMAL, 10)); // 2
					ds2.addDataColumn(new GauceDataColumn("COL06",    GauceDataColumn.TB_STRING, 30)); // 2
					ds2.addDataColumn(new GauceDataColumn("TR_SID",	  GauceDataColumn.TB_DECIMAL, 10)); 
					ds2.addDataColumn(new GauceDataColumn("TR_ACCT_CD",	GauceDataColumn.TB_STRING, 2 ));
					ds2.addDataColumn(new GauceDataColumn("VEND_NM",	GauceDataColumn.TB_STRING, 62 ));
					ds2.addDataColumn(new GauceDataColumn("VEND_CD",	GauceDataColumn.TB_STRING, 13 ));
					
					/*
					 * temp에 있는 불러온 데이터를 ds2로 뿌리는 부분
					 * 
					 * 20160421	심동현
					 * 0행 = 제목줄이니 1행부터 루프 시작
					 * 마지막행 = 합계줄이니 제외하기 
					 */
					for (int row = 1; row < sheet0.getRows()-1; row++) {
						GauceDataRow gRow = ds2.newDataRow();
						//StringUtil.printMsg("형변환===",arr[row][4],this);
						////StringUtil.printMsg("형변환===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("계좌코드   == ",sAcctGu,this);
						gRow.addColumnValue(arr[row][1]);	//다운로드 파일의 거래일자
						gRow.addColumnValue(arr[row][2]);	// 거래구분
						gRow.addColumnValue(arr[row][3]);	//적요
						gRow.addColumnValue(Double.parseDouble(arr[row][5].replaceAll(",", "")));	//number	맡기신 금액
						gRow.addColumnValue(Double.parseDouble(arr[row][6].replaceAll(",", "")));	//number	남은 금액
						gRow.addColumnValue(arr[row][7]);	//취급점
						gRow.addColumnValue(111); 		// TR_SID 컬럼 : 기본값 세팅 1로 준 후에 화면에서 0으로 업뎃 (최초 입력시)
						gRow.addColumnValue(sAcctGu);	// 계좌코드 컬럼
						gRow.addColumnValue("");	// 거래처명
						gRow.addColumnValue("");	// 거래처코드
						
						//StringUtil.printMsg("거래구분 == ",arr[row][2],this);
						// 거래구분이 대체인 경우 로드하지 않음	20160422 심동현
						if(!arr[row][2].equals("대체") ){
							ds2.addDataRow(gRow);
						}
					}
					//StringUtil.printMsg("카운트 == " , ds2.getDataRowCnt(), this);
					
					gos.write(ds2);	//3.x버전의 ds2.flush()에 해당
					
					//StringUtil.printMsg("엑셀 삭제전",this);
					deleteExcelFile(fExcelFilePath);
				}            
            
            }
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
		 * 2015.06.03 심동현
		 * 거래처 컬럼을 추가 저장할 수 있게 수정
		 * */
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet I:EXCELDS=excelDs,O:RESULT=ds_result */
		GauceDataSet ds_xls 	= gis.read("EXCELDS");
		GauceDataSet ds_result	= gis.read("RESULT");
		
		
		String uploadType = "1";
		String v_edit_styatus = "";										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
		try {
			
			if (ds_xls != null) {
				
				GauceDataRow[] 		rows = ds_xls.getDataRows();
				GauceDataColumn[] 	cols = ds_xls.getDataColumns();
						
				//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				
				int colNm_Col01	  = ds_xls.indexOfColumn("COL01");
				int colNm_Col02	  = ds_xls.indexOfColumn("COL02");
				int colNm_Col03	  = ds_xls.indexOfColumn("COL03");	//적요
				int colNm_Col04	  = ds_xls.indexOfColumn("COL04");
				int colNm_Col05	  = ds_xls.indexOfColumn("COL05");
				int colNm_Col06	  = ds_xls.indexOfColumn("COL06");
				int colNm_TR_SID  = ds_xls.indexOfColumn("TR_SID");
				int colNm_TR_ACCT_CD = ds_xls.indexOfColumn("TR_ACCT_CD");
				int colNm_VEND_CD = ds_xls.indexOfColumn("VEND_CD"); //거래처코드
				int colNm_VEND_NM = ds_xls.indexOfColumn("VEND_NM");	//거래처명
				
				
				
				
												
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
					
					//StringUtil.printMsg("INSERT 0= ",rows[i].getInt(colNm_TR_SID),this);	//일련번호
					//StringUtil.printMsg("INSERT 1= ",rows[i].getString(colNm_Col01),this);	//거래일시 (은행에서 받은)
					//StringUtil.printMsg("INSERT 2= ",rows[i].getString(colNm_Col02),this);
					//StringUtil.printMsg("INSERT 3= ",rows[i].getString(colNm_Col03),this);
					//StringUtil.printMsg("INSERT 4= ",rows[i].getString(colNm_Col04),this);
					//StringUtil.printMsg("INSERT 5= ",rows[i].getString(colNm_Col05),this);
					//StringUtil.printMsg("INSERT 6= ",rows[i].getString(colNm_Col06),this);
					//StringUtil.printMsg("INSERT 7= ","***"+rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/","")+"***",this);	//거래일자
					//StringUtil.printMsg("INSERT 8= ","***"+rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":","")+"***",this);	//거래시각
					//StringUtil.printMsg("================ 끝 ===============",this);
					
					cstmt.setInt(1, rows[i].getInt(colNm_TR_SID));
					cstmt.setString(2, rows[i].getString(colNm_Col01));
					cstmt.setString(3, rows[i].getString(colNm_Col02));
					cstmt.setString(4, HDUtil.nullCheckStr(rows[i].getString(colNm_Col03)) );//적요가 빈칸일 경우=대체
					cstmt.setInt(5, rows[i].getInt(colNm_Col04));
					cstmt.setInt(6, rows[i].getInt(colNm_Col05));
					cstmt.setString(7, rows[i].getString(colNm_Col06));
					//cstmt.setString(8, rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/",""));
					cstmt.setString(8, rows[i].getString(colNm_Col01).substring(0,4)+rows[i].getString(colNm_Col01).substring(5,7)+rows[i].getString(colNm_Col01).substring(8,10) );
					//cstmt.setString(9, rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":",""));
					cstmt.setString(9, rows[i].getString(colNm_Col01).substring(11,13)+rows[i].getString(colNm_Col01).substring(14,16) );
					cstmt.setString(10, rows[i].getString(colNm_TR_ACCT_CD));
					cstmt.setString(11, rows[i].getString(colNm_VEND_CD));
					cstmt.setString(12, rows[i].getString(colNm_VEND_NM));
					cstmt.setString(13, fParamEmpno);
					cstmt.setString(14, fParamIp);
					cstmt.setString(15, v_edit_styatus);
					
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
					// 쿼리실행
					cstmt.executeUpdate();
				}
			}
			gos.close();
		}catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
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
