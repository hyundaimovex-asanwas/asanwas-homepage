package pms.menu.cat;
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

import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;

import pms.common.HDConstant;		//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.HDUtil;			//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import sales.common.StringUtil;		//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로
import pms.common.SuperServlet;		//회계 메뉴 안에 관광스타일 메뉴는 관광쪽 이용하는 걸로

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;


public class Cat011I extends SuperServlet {
	private static final long serialVersionUID = 1L;
	private String fExcelFilePath = "";
	public void makeSql() {

		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL PMS.PR_CAT010I_01(?,?,?,?,?,  ?,?,?,?,? )");	// 조회
		arr_sql[2].append("CALL PMS.PR_CAT010I_02(?,? )");	// 조회2
		arr_sql[3].append("CALL PMS.PR_CAT010I_03(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,? )");	// 저장1
		arr_sql[4].append("CALL PMS.PR_CAT010I_04(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,   ?)");	// 저장2
		
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
		
        GauceDataSet sel_dsM 		= gis.read("MAIN_DSM");		//메인 조회
        GauceDataSet sel_ds 		= gis.read("MAIN_DS");		//디테일조회
		
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//엑셀파일; 
		GauceDataSet ds_xlD 	= gis.read("EXCELDS"); 		//엑셀적용 detail;
		GauceDataSet ds_xlM 	= gis.read("EXCELDSM"); 	//엑셀적용 master
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
			int v_ot_sid = HDUtil.nullCheckNum(greq.getParameter("v_ot_sid"));
			
			
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput();

            //StringUtil.printMsg(" 컴포넌트의 데이터셋 갯수 ",dSets.length,this);
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 "+i+"번째 데이터셋 네임 ",dSets[i].getName(),this);		

            	
				//마스터 조회;            	//O:MAIN_DSM=excelDsM
				if (sel_dsM != null) {
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
					cstmt.setString(5,sEndDate );
					cstmt.setString(6,sAcctGu );
					cstmt.setString(7,sTr_Sum );
					cstmt.setString(8,sAcctGu );
					cstmt.setString(9,sTr_Sum );
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 					
					gos.write(getDataSet(rs, sel_dsM));
				}
				//디테일 ;            	//O:MAIN_DS=excelDs
				if (sel_ds != null) {
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1,v_ot_sid );
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, sel_ds));
				}
				
				

				// * 디테일일때만 한번만 실행되게.. 조건절 수정				
				//액셀적용 JSP (I:TEMP_EXCEL=tempExcelDs)
    			// 파일 업로드 
				if (excelDs != null && dSets[i].getName().equals("excelDs")) {
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
					
					fExcelFilePath = "D:/myWorks1/HDAsan/WebContent/Pms/file/" + o_name;//로컬용
					//fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_FILE + o_name;	//서버용
					//StringUtil.printMsg("업로드된 액셀 파일의 경로:",fExcelFilePath, this);

					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}				

				// * 디테일일때만 한번만 실행되게.. 조건절 수정
				// 엑셀 읽어서 그리드로 뿌리기 O:EXCELDS=excelDs
				if (ds_xlD != null && dSets[i].getName().equals("excelDs")) {
					//gres.enableFirstRow(ds_xlD);
					
					//StringUtil.printMsg("읽을 EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// 읽어올 파일명
					
					Sheet sheet0 = workbook.getSheet("All_company_list"); // Sheet명 : Sheet로 수정160421 

					//StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][60];	//배열자체가 스트링이네요..
					
					for (int row = 0; row < sheet0.getRows(); row++) {	

						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							//StringUtil.printMsg("액셀 셀 타입 ==",sheet0.getCell(column,row).getType().toString(), this);

							// 숫자타입							
							if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
								//NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
								//content = numberCell.getValue()+"";
								
								Cell cell = sheet0.getCell(column,row);
								content = cell.getContents();	
								//그냥 cell로 받으면 안에 있는 값 그대로 받아온다. ex)  값=681,509,000 콤마까지 포함해서.
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
					 * Detail DataSet Header
					 */
					ds_xlD.addDataColumn(new GauceDataColumn("OT_RANK",    GauceDataColumn.TB_DECIMAL, 10)); // 1
					ds_xlD.addDataColumn(new GauceDataColumn("COMPANY_NM",    GauceDataColumn.TB_STRING, 60)); // 2
					ds_xlD.addDataColumn(new GauceDataColumn("BIZREGI_NO",    GauceDataColumn.TB_STRING, 10)); // 3
					ds_xlD.addDataColumn(new GauceDataColumn("EXC_MAN",    GauceDataColumn.TB_STRING, 20)); // 4
					ds_xlD.addDataColumn(new GauceDataColumn("AMT_TENDER",    GauceDataColumn.TB_DECIMAL, 22)); // 5
					ds_xlD.addDataColumn(new GauceDataColumn("RATE_EXPECT",	  GauceDataColumn.TB_DECIMAL, 10)); 
					ds_xlD.addDataColumn(new GauceDataColumn("RATE_BASE",	GauceDataColumn.TB_DECIMAL, 10 ));
					ds_xlD.addDataColumn(new GauceDataColumn("RATE_SHOOT",	GauceDataColumn.TB_DECIMAL, 10 ));
					ds_xlD.addDataColumn(new GauceDataColumn("DATE_TENDER",	GauceDataColumn.TB_STRING, 20 ));
					ds_xlD.addDataColumn(new GauceDataColumn("AMT_DIFF_MIN",	GauceDataColumn.TB_DECIMAL, 22 ));
					ds_xlD.addDataColumn(new GauceDataColumn("OT_REMARK",	GauceDataColumn.TB_STRING, 100 ));
					ds_xlD.addDataColumn(new GauceDataColumn("OT_SID",    GauceDataColumn.TB_DECIMAL, 10)); // 12
					ds_xlD.addDataColumn(new GauceDataColumn("DT_SID",    GauceDataColumn.TB_DECIMAL, 10)); // 13
					/*
					 * Master DataSet Header
					 */
					ds_xlM.addDataColumn(new GauceDataColumn("OT_NO",    GauceDataColumn.TB_STRING, 14)); // 1
					ds_xlM.addDataColumn(new GauceDataColumn("OT_NM",    GauceDataColumn.TB_STRING, 100)); // 2
					ds_xlM.addDataColumn(new GauceDataColumn("ORDERER_NM",    GauceDataColumn.TB_STRING, 100)); // 2
					ds_xlM.addDataColumn(new GauceDataColumn("OT_DATE",    GauceDataColumn.TB_STRING, 20)); // 2
					ds_xlM.addDataColumn(new GauceDataColumn("AMT_BASE",	GauceDataColumn.TB_DECIMAL, 22 ));
					ds_xlM.addDataColumn(new GauceDataColumn("AMT_WIN",	GauceDataColumn.TB_DECIMAL, 22 ));
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN01",    GauceDataColumn.TB_STRING, 2)); // 면허
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN02",    GauceDataColumn.TB_STRING, 2)); // 발주유형
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN03",    GauceDataColumn.TB_STRING, 2)); // 지역
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN04",    GauceDataColumn.TB_STRING, 2)); // 사정구간
					ds_xlM.addDataColumn(new GauceDataColumn("OT_SID",    GauceDataColumn.TB_DECIMAL, 10)); // 12
					
					/*
					 * temp에 있는 불러온 데이터를 ds_xlM, ds_xlD로 뿌리는 부분
					 * 20170629	심동현
					 */
					
					//값=공고번호	row=0::column=1::값= 20160438092-00                           
					//값=공사명		row=1::column=1::값=홍천군 환경기초시설 개선사업 (긴급공고)   
					//값=발주처		row=2::column=1::값=한국환경공단                              
					//값=입찰일		row=3::column=1::값=2016-05-09 16:00:00                       
					//값=기초금액	row=4::column=1::값=767,105,000                               
					//값=1순위 낙찰금액	row=5::column=1::값=681,509,000                               

					// 마스터 데이터 부분
					GauceDataRow gRowM = ds_xlM.newDataRow();
					gRowM.addColumnValue(arr[0][2]);	//공고번호
					gRowM.addColumnValue(arr[1][2]);	//공사명
					gRowM.addColumnValue(arr[2][2]);	//발주처
					gRowM.addColumnValue(arr[3][2]);	//입찰일
					gRowM.addColumnValue(Double.parseDouble(arr[4][2].replaceAll(",", "")) );	//기초금액
					gRowM.addColumnValue(Double.parseDouble(arr[5][2].replaceAll(",", "")) );	//낙찰금액
					gRowM.addColumnValue(" "); 		// 면허
					gRowM.addColumnValue(" "); 		// 발주유형
					gRowM.addColumnValue(" "); 		// 지역
					gRowM.addColumnValue(" "); 		// 지역
					gRowM.addColumnValue(111); 		// OT_SID 컬럼 : 기본값 세팅 1로 준 후에 화면에서 0으로 업뎃 (최초 입력시)
					ds_xlM.addDataRow(gRowM);
					//StringUtil.printMsg("ds_xlM카운트 == " , ds_xlM.getDataRowCnt(), this);
					gos.write(ds_xlM);	//3.x버전의 ds_xlD.flush()에 해당
										
					// 디테일데이터 부분 : 8행부터 입찰 디테일 데이터 루프 시작
					for (int row = 8; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds_xlD.newDataRow();
						//StringUtil.printMsg("형변환===",arr[row][4],this);
						////StringUtil.printMsg("형변환===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("계좌코드   == ",sAcctGu,this);
						// 투찰금액= null 로드하지 않음	20160422 심동현
						if(arr[row][5] != null ){
							gRow.addColumnValue(arr[row][1]);	//순위
							gRow.addColumnValue(arr[row][2]);	//업체명
							gRow.addColumnValue(arr[row][3]);	//사업자번호
							gRow.addColumnValue(arr[row][4]);	//대표자
							gRow.addColumnValue(Double.parseDouble(arr[row][5].replaceAll(",", "")));	//number	투찰금액
							gRow.addColumnValue(arr[row][6]);	//number	예갸대비 투찰율
							gRow.addColumnValue(arr[row][7]);	//number	기초대비 투찰율
							gRow.addColumnValue(arr[row][8]);	//number	기초대비 사정율
							gRow.addColumnValue(arr[row][10]);	//투찰일시
							gRow.addColumnValue(arr[row][11]);	//number	낙찰하한가 차이
							gRow.addColumnValue(arr[row][12]);	//비고
							gRow.addColumnValue(111); 		// OT_SID 컬럼 : 기본값 세팅 1로 준 후에 화면에서 0으로 업뎃 (최초 입력시)
							gRow.addColumnValue(222);		// DT_SID  컬럼 : 기본값 세팅 1로 준 후에 화면에서 0으로 업뎃 (최초 입력시)
							ds_xlD.addDataRow(gRow);
						}
						
					}
					//StringUtil.printMsg("카운트 == " , ds_xlD.getDataRowCnt(), this);
					
					gos.write(ds_xlD);	//3.x버전의 ds_xlD.flush()에 해당
					
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
		 * 		 * JSP(I:EXCELDSM=excelDsM,I:EXCELDS=excelDs,O:RESULT=ds_result)"
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
        GauceDataSet ds_xlsM 	= gis.read("EXCELDSM");
        GauceDataSet ds_xls 	= gis.read("EXCELDS");
		GauceDataSet ds_result	= gis.read("RESULT");
		
		
		String uploadType = "1";
		String v_edit_styatus = "";										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
		int	v_ot_sid = 0;
		try {

			// 1 마스터 정보 입력 + 마스터sid 받아오기
			if (ds_xlsM != null) {
				
				GauceDataRow[] 		rows = ds_xlsM.getDataRows();
				GauceDataColumn[] 	cols = ds_xlsM.getDataColumns();
						
				//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				int colNm_OT_SID	  = ds_xlsM.indexOfColumn("OT_SID");
				int colNm_OT_NO	  = ds_xlsM.indexOfColumn("OT_NO");
				int colNm_OT_NM	  = ds_xlsM.indexOfColumn("OT_NM");
				int colNm_ORDERER_NM	  = ds_xlsM.indexOfColumn("ORDERER_NM");	//적요
				int colNm_OT_DATE	  = ds_xlsM.indexOfColumn("OT_DATE");
				int colNm_AMT_BASE	  = ds_xlsM.indexOfColumn("AMT_BASE");
				int colNm_AMT_WIN	  = ds_xlsM.indexOfColumn("AMT_WIN");
				int colNm_GUBN1	  = ds_xlsM.indexOfColumn("GUBN01");
				int colNm_GUBN2  = ds_xlsM.indexOfColumn("GUBN02");
				int colNm_GUBN3  = ds_xlsM.indexOfColumn("GUBN03");
				int colNm_GUBN4  = ds_xlsM.indexOfColumn("GUBN04");
				
				cstmt = conn.prepareCall(arr_sql[3].toString());
				
				cstmt.setInt(1, rows[0].getInt(colNm_OT_SID));
				cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
				cstmt.setString(2, rows[0].getString(colNm_OT_NO));
				cstmt.setString(3, rows[0].getString(colNm_OT_NM));
				cstmt.setString(4, rows[0].getString(colNm_ORDERER_NM));
				cstmt.setString(5, rows[0].getString(colNm_OT_DATE));
				cstmt.setInt(6, rows[0].getInt(colNm_AMT_BASE));
				cstmt.setInt(7, rows[0].getInt(colNm_AMT_WIN));
				cstmt.setString(8, rows[0].getString(colNm_GUBN1));
				cstmt.setString(9, rows[0].getString(colNm_GUBN2));
				cstmt.setString(10, rows[0].getString(colNm_GUBN3));
				cstmt.setString(11, rows[0].getString(colNm_GUBN4));
				cstmt.setString(12, fParamEmpno);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
				cstmt.executeUpdate();
				
				//공고SID = OT_SID 받아오기
				if (cstmt.getString(13).equals("Y") ) {
					//StringUtil.printMsg("성공메시지",cstmt.getString(15),this);
					v_ot_sid = cstmt.getInt(1);
					//StringUtil.printMsg("취득SID",cstmt.getInt(1),this);
					
				} else {
					StringUtil.printMsg("실패메시지",cstmt.getString(15),this);
					conn.rollback();
				}				
				
				if(cstmt!=null) cstmt.close();	
			}
			

			
			// 2 디테일 정보 입력
			if (ds_xls != null) {
				GauceDataRow[] 		rows = ds_xls.getDataRows();
				GauceDataColumn[] 	cols = ds_xls.getDataColumns();
						
				//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				
				int colNm_OT_RANK	  = ds_xls.indexOfColumn("OT_RANK");
				int colNm_COMPANY_NM	  = ds_xls.indexOfColumn("COMPANY_NM");
				int colNm_BIZREGI_NO	  = ds_xls.indexOfColumn("BIZREGI_NO");
				int colNm_EXC_MAN	  = ds_xls.indexOfColumn("EXC_MAN");
				int colNm_AMT_TENDER	  = ds_xls.indexOfColumn("AMT_TENDER");
				int colNm_RATE_EXPECT	  = ds_xls.indexOfColumn("RATE_EXPECT");
				int colNm_RATE_BASE	  = ds_xls.indexOfColumn("RATE_BASE");
				int colNm_RATE_SHOOT	  = ds_xls.indexOfColumn("RATE_SHOOT");
				int colNm_DATE_TENDER	  = ds_xls.indexOfColumn("DATE_TENDER");
				int colNm_AMT_DIFF_MIN	  = ds_xls.indexOfColumn("AMT_DIFF_MIN");
				int colNm_OT_REMARK	  = ds_xls.indexOfColumn("OT_REMARK");
				
												
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("INSERT "+i+"행 ========================",this);
					//StringUtil.printMsg("rows[i].getJobType() 값 == ", rows[i].getJobType() ,this);	//프로시져 편집상태 값.
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
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
					
					cstmt.setInt(1, v_ot_sid);
					cstmt.setInt(2, rows[i].getInt(colNm_OT_RANK));
					cstmt.setString(3, rows[i].getString(colNm_COMPANY_NM));
					cstmt.setString(4, rows[i].getString(colNm_BIZREGI_NO));
					cstmt.setString(5, rows[i].getString(colNm_EXC_MAN));
					cstmt.setInt(6, rows[i].getInt(colNm_AMT_TENDER) );
					cstmt.setInt(7, rows[i].getInt(colNm_RATE_EXPECT) );
					cstmt.setInt(8, rows[i].getInt(colNm_RATE_BASE) );
					cstmt.setInt(9, rows[i].getInt(colNm_RATE_SHOOT) );
					cstmt.setString(10, rows[i].getString(colNm_DATE_TENDER));
					cstmt.setInt(11, rows[i].getInt(colNm_AMT_DIFF_MIN) );
					cstmt.setString(12, HDUtil.nullCheckStr(rows[i].getString(colNm_OT_REMARK)) );	//비고가 빈칸일 경우=대체
					cstmt.setString(13, fParamEmpno);
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
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
