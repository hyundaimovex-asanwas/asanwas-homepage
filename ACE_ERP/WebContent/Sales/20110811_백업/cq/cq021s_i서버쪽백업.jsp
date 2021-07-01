<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 개성 사진명단 액셀로 출력
 * 프로그램ID 	: CQ021S
 * J  S  P		: cq021s
 * 서 블 릿		: Cq021S
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-11-28
 * 기능정의		: 개성쪽 사진명단 조회,출력.. (__) 제길!
 * [수  정   일  자][수정자] 내용
 * [2007-11-29][심동현] beans 을 통해 리스트를 불러와서 액셀로 출력.
 *						값 불러오는 것까지 성공.
 * [2007-12-04][심동현] 액셀로 값 출력 성공. 조건에 따른 출력값 조정 / 사진 조정 후 완료~!
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>

<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>

<%@ page import="sales.common.*"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.menu.cq.Cq025Manager" %>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>

<%@ page import="org.apache.poi.poifs.filesystem.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem.*" %>
<%@ page import="org.apache.poi.poifs.eventfilesystem.*" %>
<%@ page import="org.apache.poi.poifs.dev.*" %>
<%@ page import="org.apache.poi.hssf.record.*" %>
<%@ page import="org.apache.poi.hssf.record.formula.*" %>
<%@ page import="org.apache.poi.hssf.model.*" %>
<%@ page import="org.apache.poi.hssf.record.PageBreakRecord" %>
<%@ page import="org.apache.poi.hssf.usermodel.*" %>
<%@ page import="org.apache.poi.hssf.util.*" %>


<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<%	// 파라미터 받기.
    SmartRequest sr = new SmartRequest(request);	
    
    String sSaupSid, sDepartDate, sDepartTime, sGoodsSid, sClass, sTeams, sPageNo, sCustGu, sBizChk ;
	sSaupSid	= sr.getString("sSaupSid");
	sDepartDate = sr.getString("sDepartDate");
	sDepartTime = sr.getString("sDepartTime");
	sGoodsSid   = sr.getString("sGoodsSid");
	sClass      = sr.getString("sClass");
	sTeams      = sr.getString("sTeams");
	sPageNo     = sr.getString("sPageNo");
	sCustGu     = sr.getString("sCustGu");
	sBizChk		= sr.getString("sBizChk");
	
	ArrayList data = new ArrayList();
	int len3;
	BaseDataClass bean3;
   
	sr.setObject("sSaupSid",(Object)sSaupSid);
	sr.setObject("sDepartDate",(Object)sDepartDate);
	sr.setObject("sDepartTime",(Object)sDepartTime);
	sr.setObject("sGoodsSid",(Object)sGoodsSid);
	sr.setObject("sClass",(Object)sClass);
	sr.setObject("sTeams",(Object)sTeams);
	sr.setObject("sPageNo",(Object)sPageNo);
	sr.setObject("sCustGu",(Object)sCustGu);	
	sr.setObject("sBizChk",(Object)sBizChk);	  
   
	Cq025Manager manager = new Cq025Manager();
	data = manager.list(sr);
	manager.close();
  
  
  	len3 = data.size();	//결과의 행수.

// 이 앞에 사이즈 체크한다.  
if(data == null || data.size() < 1 ) {
%>
	데이터가 없습니다.
<%
}else{
	bean3 = (BaseDataClass)data.get(0);// bean init.

	String filename    = "ks_pic_list("+ sDepartDate +").xls";	//파일네임 결정
	String sheetname   = "ks_pic_list";		//시트네임 결정
	String doc_title   = "";										//제목 타이틀 
	int totalCount     = len3;	//아래 소스 고치기 귀차나서 이렇게 함..

	//제목결정////////////////////////////////////////////////////////////////////////////////////
	if(sBizChk.equals("true") ){
		doc_title = "개성 당일 관광 보장성원 명단 " + bean3.get("title_date");
	}else{
		if (!"".equals(sTeams)) {	// 전체선택이 아닌 경우
			doc_title = "개성 당일 관광객 명단 " + bean3.get("title_class")+" "+ bean3.get("title_date");
		}else{
			doc_title = "개성 당일 관광 명단 " + bean3.get("title_date");
		}
	}


	try {
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();

		HSSFRow    row  = null;
		HSSFCell   cell   = null;
	
		short        rowNum = 0;
	
		HSSFPatriarch    patriarch 	= null;
		HSSFClientAnchor anchor    	= null;
	
		//액셀의 스타일을 세팅해주는 부분.
		HSSFFont fontH = wb.createFont();
		fontH.setFontHeightInPoints((short) 17);
		fontH.setFontName("바탕");
		fontH.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		fontH.setUnderline(HSSFFont.U_SINGLE);
	
		//기본 폰트 : 각 셀의 기본 값
		HSSFFont font = wb.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("바탕");
	
		HSSFFont fontG = wb.createFont();
		fontG.setFontHeightInPoints((short) 12.5);
		fontG.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		
		fontG.setFontName("궁서");
	
	
		HSSFCellStyle styleH = wb.createCellStyle();
		styleH.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleH.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		styleH.setFont(fontH);
	
		HSSFCellStyle styleHL = wb.createCellStyle();
		styleHL.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleHL.setFillBackgroundColor(HSSFColor.BLACK.index);
		styleHL.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	
/*		HSSFCellStyle styleT = wb.createCellStyle();
		styleT.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleT.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleT.setBottomBorderColor(HSSFColor.BLACK.index);
		styleT.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleT.setLeftBorderColor(HSSFColor.BLACK.index);
		styleT.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleT.setRightBorderColor(HSSFColor.BLACK.index);
		styleT.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleT.setTopBorderColor(HSSFColor.BLACK.index);
		styleT.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleT.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		styleT.setFont(font);*/
		//styleT.setFillBackgroundColor(HSSFColor.TURQUOISE.index);
		//styleT.setFillPattern(HSSFCellStyle.NO_FILL);
	
		//이것만 쓰자....
		HSSFCellStyle styleC = wb.createCellStyle();
		styleC.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleC.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleC.setBottomBorderColor(HSSFColor.BLACK.index);
		styleC.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleC.setLeftBorderColor(HSSFColor.BLACK.index);
		styleC.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleC.setRightBorderColor(HSSFColor.BLACK.index);
		styleC.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleC.setTopBorderColor(HSSFColor.BLACK.index);
		styleC.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		styleC.setFont(font);
	
		HSSFCellStyle styleG = wb.createCellStyle();
		styleG.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleG.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleG.setBottomBorderColor(HSSFColor.BLACK.index);
		styleG.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleG.setLeftBorderColor(HSSFColor.BLACK.index);
		styleG.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleG.setRightBorderColor(HSSFColor.BLACK.index);
		styleG.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleG.setTopBorderColor(HSSFColor.BLACK.index);
		styleG.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		styleG.setFont(fontG);
	
		//시트네임 세팅
		wb.setSheetName(0, sheetname, HSSFWorkbook.ENCODING_UTF_16);
	
	
		//컬럼 width 설정
		sheet.setColumnWidth( (short)0, (short) ( 25.5 * 55) ); // ( 3.57) short column, short width
		sheet.setColumnWidth( (short)1, (short) ( 76.5 * 55) ); // (15   ) short column, short width
		sheet.setColumnWidth( (short)2, (short) ( 50 * 55) ); // ( 9.29) short column, short width
		sheet.setColumnWidth( (short)3, (short) (110.5 * 55) ); // (25.71) short column, short width
		sheet.setColumnWidth( (short)4, (short) ( 42.5 * 55) ); // ( 9.29) short column, short width
		sheet.setColumnWidth( (short)5, (short) (119   * 55) ); // (25.71) short column, short width

//		sheet.setColumnWidth( (short)0, (short) ( 30 * 55) ); // ( 3.57) short column, short width
///		sheet.setColumnWidth( (short)1, (short) ( 90 * 55) ); // (15   ) short column, short width
//		sheet.setColumnWidth( (short)2, (short) ( 70 * 55) ); // ( 9.29) short column, short width
//		sheet.setColumnWidth( (short)3, (short) (110 * 55) ); // (25.71) short column, short width
//		sheet.setColumnWidth( (short)4, (short) ( 70 * 55) ); // ( 9.29) short column, short width
//		sheet.setColumnWidth( (short)5, (short) (110 * 55) ); // (25.71) short column, short width

	
		
		row = sheet.createRow(rowNum);
		row.setHeightInPoints( (float)27 );
		for(int j=0 ; j<6; j++){
			cell = row.createCell((short)j);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellStyle(styleH);
			cell.setCellValue("");
		}
		cell = row.getCell((short) 0);
		cell.setCellValue(""+ doc_title );// 1페이지 제목줄 
		sheet.addMergedRegion(new Region(rowNum, (short) 0, rowNum, (short) 5));
	
		
		rowNum++;	
		row = sheet.createRow(rowNum);
		row.setHeightInPoints( (float)1.5 );
		for(int j=0 ; j<6; j++){
			cell = row.createCell((short)j);
			cell.setCellStyle(styleH);
			cell.setCellValue("");
		}
		sheet.addMergedRegion(new Region(rowNum, (short) 0, rowNum, (short) 5));
		patriarch = sheet.createDrawingPatriarch();
		
		
		for(int i=1; i<=totalCount; i++){	//루프돌기.
			bean3 = (BaseDataClass)data.get(i-1); // i=1부터 시작  bean은 0부터.. bean init.

			rowNum++; // 공백 Line
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)13 );
	
			rowNum++; // 이름, 생년월일
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)27 );
			for(int j=0 ; j<6; j++){
				cell = row.createCell((short)j);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(styleC);	// 여기가 1번 관광객의 최상단 행인듯..
				cell.setCellValue("");
			}
			cell = row.getCell((short) 0);
			cell.setCellStyle(styleC);
			cell.setCellValue(i);
			
			//사진 파일이 존재하면! 인데.. 흐음.. 이것 참...
			if (!bean3.get("manage_no").equals("")) {
				cell = row.getCell((short) 1);
//				cell.setCellValue("사 진");	//여기가 사진 파일 떨어뜨리는 부분....흐음;;
		
				anchor    = new HSSFClientAnchor(20,20,1003,235,(short)1,rowNum,(short)1,rowNum+4); // 최대크기 : (0,0)-(1023,255)
				anchor.setAnchorType(2);        // 0 = Move and size with Cells, 2 = Move but don't size with cells, 3 = Don't move or size with cells.
	
				FileInputStream       fis = null;
				ByteArrayOutputStream bos = null;
				int pictureIndex;
				int c;
	
				String path = request.getRealPath("/Sales/file/photo/cust/" + bean3.get("manage_no") + ".JPG");	//사진경로
				String pathDefault = request.getRealPath("/Sales/file/photo/cust/default.JPG");	//디폴트 사진
				try {
				    File f = new File(path);				
					if(f.isFile()){ //파일이 있으면?
						fis = new FileInputStream( path );
					}else{
						fis = new FileInputStream( pathDefault );					
					}

					bos = new ByteArrayOutputStream();
					while ( (c = fis.read()) != -1) {
						bos.write( c );
					}
					pictureIndex = wb.addPicture( bos.toByteArray(), HSSFWorkbook.PICTURE_TYPE_JPEG );
				} finally {
					if (fis != null) fis.close();
					if (bos != null) bos.close();
				}
				patriarch.createPicture(anchor, pictureIndex);
			}
	
			cell = row.getCell((short) 2);
			cell = row.getCell((short) 2);
			cell.setCellValue("이름");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleG);
			cell.setCellValue(" "+ bean3.get("cust_nm1") );	//여기가 이름값 세팅하는 부분
				//
			cell = row.getCell((short) 4);
			cell.setCellValue("생년월일");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("birthday") );
	
			rowNum++; // 성별,직장/직위
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)28 );
			for(int j=0 ; j<6; j++){
				cell = row.createCell((short)j);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(styleC);
				cell.setCellValue("");
			}
			cell = row.getCell((short) 2);
			cell.setCellValue("성별");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("gender_nm") );
			cell = row.getCell((short) 4);
			cell.setCellValue("직장/직위");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("comp_nm1") );
	
			rowNum++; // 출입목적
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)24 );
			for(int j=0 ; j<6; j++){
				cell = row.createCell((short)j);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(styleC);
				cell.setCellValue("");
			}
			cell = row.getCell((short) 2);
			cell.setCellValue("출입목적");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("north_purpose") );	// 임시로 고정값을 박아 넣음. 2007-12-04 심동현
	
			rowNum++; // 성별,성별
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)24 );
			for(int j=0 ; j<6; j++){
				cell = row.createCell((short)j);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(styleC);
				cell.setCellValue("");
			}
			cell = row.getCell((short) 2);
			cell.setCellValue("출입차량");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("tour_no") );	//tour_no
			cell = row.getCell((short) 4);
			cell.setCellValue("도착날자");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("sn_datetime") );
	
			rowNum++; // 거주지
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)28);
			for(int j=0 ; j<6; j++){
				cell = row.createCell((short)j);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(styleC);
				cell.setCellValue("");
			}
			cell = row.getCell((short) 2);
			cell.setCellValue("거주지");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("address1") );
			cell = row.getCell((short) 4);
			cell.setCellValue("출발날자");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("ns_datetime") );
	
			sheet.addMergedRegion(new Region(rowNum - 4, (short) 0, rowNum, (short) 0));
			sheet.addMergedRegion(new Region(rowNum - 4, (short) 1, rowNum, (short) 1));
			sheet.addMergedRegion(new Region(rowNum - 2, (short) 3, rowNum - 2, (short) 5));


//			if (!"".equals(sTeams)) {	// 전체선택이 아닌 경우 -> 2페이지부터 제목줄 표시

			//언제나 제목줄 반복 2008-10-13 심동현. (with 김주현, 권미정)	
			//첫줄만 제목줄 생성 2008-10-20	심동현
/*			if ( (i%5) == 0 && (totalCount - i) > 0 ) { 
	
			sheet.addMergedRegion(new Region(rowNum - 4, (short) 0, rowNum, (short) 0));
			sheet.addMergedRegion(new Region(rowNum - 4, (short) 1, rowNum, (short) 1));
			sheet.addMergedRegion(new Region(rowNum - 2, (short) 3, rowNum - 2, (short) 5));
				
				rowNum++;
				row = sheet.createRow(rowNum);
				row.setHeightInPoints( (float)27 );
				for(int j=0 ; j<6; j++){
					cell = row.createCell((short)j);
					cell.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellStyle(styleH);
					cell.setCellValue("");
				}
				cell = row.getCell((short) 0);
				cell.setCellValue(""+doc_title); //반복 페이지 제목줄..
				sheet.addMergedRegion(new Region(rowNum, (short) 0, rowNum, (short) 5));
	
			}*/
//			}
	
	
	
		}	//for(int i=1; i<=totalCount; i++){	//루프돌기.
	
		response.setHeader("Content-Disposition", "attachment;filename="+filename);
	    response.setHeader("Content-type", "application/vnd.ms-excel");
	    response.setHeader("Content-type", "application/x-msexcel");	    
	    
	    
		OutputStream excelOut = response.getOutputStream();
		wb.write(excelOut);
		excelOut.flush();


		
	} catch( Exception e) {
		e.printStackTrace();
		throw e;
	} finally {
		response.getOutputStream().close();
	}
	
} //if(data == null || data.size() < 1 ) {
%>
