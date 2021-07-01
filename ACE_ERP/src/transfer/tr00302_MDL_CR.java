package transfer;

import java.io.*;
import java.util.*;
import org.apache.poi.poifs.dev.*;
import org.apache.poi.hssf.record.*;
import org.apache.poi.hssf.record.formula.*;
import org.apache.poi.hssf.model.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00302_MDL_CR extends HttpServlet {
 
	public void doGet(HttpServletRequest request, HttpServletResponse response) {

	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String filepath = "\\Root\\HdAsan\\upload_file\\";
	String filename = "MDL_Crossing_Request";

	String query = "";

	String gstr1 = request.getParameter("v_str1").trim();
	String sdate = request.getParameter("v_str2").trim();
	if (gstr1==null) gstr1 = "";
	
	String vdate = "";
	if (sdate!=null && !sdate.equals(""))	{
		vdate = Integer.parseInt(sdate.substring(4,6)) + "월" + sdate.substring(6,8) + "일";
	}
	
	try {

		Class.forName("com.ibm.as400.access.AS400JDBCDriver");
		conn = DriverManager.getConnection("jdbc:as400:203.242.32.198;user=QPILOT;password=PILOT");

		String client = request.getHeader("User-Agent");
    if (client.indexOf("MSIE 5.5") != -1) {
        response.setHeader("Content-Type", "doesn/matter;charset=8859_1");
        response.setHeader("Content-Disposition", "filename="+filename+"_"+sdate+".xls;");
    } else {
			String ss = filename+"_"+sdate+".xls";

			response.setContentType("application/octet-stream"); 
			response.setHeader("Content-Disposition", "attachment;filename="+new String(ss.getBytes("euc-kr"),"8859_1"));
    }

		HSSFWorkbook workbook = new HSSFWorkbook();

		HSSFSheet sheet01 = workbook.createSheet();
		HSSFSheet sheet02 = workbook.createSheet();
		HSSFSheet sheet03 = workbook.createSheet();
		HSSFSheet sheet04 = workbook.createSheet();
		HSSFSheet sheet05 = workbook.createSheet();

		sheet01.setColumnWidth((short)1,(short)3000);
		sheet01.setColumnWidth((short)2,(short)3000);
		sheet01.setColumnWidth((short)3,(short)3000);
		sheet01.setColumnWidth((short)4,(short)3000);
		sheet01.setColumnWidth((short)5,(short)3000);
		sheet01.setColumnWidth((short)6,(short)4000);
		sheet01.setColumnWidth((short)11,(short)6000);

		sheet02.setColumnWidth((short)1,(short)3500);
		sheet02.setColumnWidth((short)2,(short)3000);
		sheet02.setColumnWidth((short)3,(short)3000);
		sheet02.setColumnWidth((short)5,(short)5000);
		sheet02.setColumnWidth((short)6,(short)4500);
		sheet02.setColumnWidth((short)7,(short)3500);

		sheet03.setColumnWidth((short)1,(short)3500);
		sheet03.setColumnWidth((short)2,(short)4500);
		sheet03.setColumnWidth((short)3,(short)4000);
		sheet03.setColumnWidth((short)4,(short)5500);
		sheet03.setColumnWidth((short)5,(short)4000);
		sheet03.setColumnWidth((short)6,(short)3500);

		sheet04.setColumnWidth((short)0,(short)5000);
		sheet04.setColumnWidth((short)1,(short)18000);
		sheet04.setColumnWidth((short)2,(short)7000);

		workbook.setSheetName(0 , "Crossing Request" ,HSSFWorkbook.ENCODING_UTF_16);
		workbook.setSheetName(1 , "Personnel Manifest" ,HSSFWorkbook.ENCODING_UTF_16);
		workbook.setSheetName(2 , "Vehicle Manifest" ,HSSFWorkbook.ENCODING_UTF_16);
		workbook.setSheetName(3 , "Cargo Manifest" ,HSSFWorkbook.ENCODING_UTF_16);
		workbook.setSheetName(4 , vdate + " 북측용" ,HSSFWorkbook.ENCODING_UTF_16);

		////////////////////////////////////////////////////////////////////////////////////////
		//타이틀
		////////////////////////////////////////////////////////////////////////////////////////
		HSSFCellStyle style00 = workbook.createCellStyle();
		HSSFCellStyle style01 = workbook.createCellStyle();
		HSSFCellStyle style02 = workbook.createCellStyle();
		HSSFCellStyle style03 = workbook.createCellStyle();
		HSSFCellStyle style04 = workbook.createCellStyle();
		HSSFCellStyle style05 = workbook.createCellStyle();
		HSSFCellStyle style06 = workbook.createCellStyle();
		HSSFCellStyle style07 = workbook.createCellStyle();
		HSSFCellStyle style08 = workbook.createCellStyle();
		HSSFCellStyle style09 = workbook.createCellStyle();
		HSSFCellStyle style10 = workbook.createCellStyle();
		HSSFCellStyle style11 = workbook.createCellStyle();
		HSSFCellStyle style12 = workbook.createCellStyle();
		HSSFCellStyle style13 = workbook.createCellStyle();
		HSSFCellStyle style14 = workbook.createCellStyle();
		HSSFCellStyle style15 = workbook.createCellStyle();
		HSSFCellStyle style16 = workbook.createCellStyle();
		HSSFCellStyle style17 = workbook.createCellStyle();
		HSSFCellStyle style18 = workbook.createCellStyle();
		HSSFCellStyle style19 = workbook.createCellStyle();
		HSSFCellStyle style20 = workbook.createCellStyle();
		HSSFCellStyle style21 = workbook.createCellStyle();
		HSSFCellStyle style22 = workbook.createCellStyle();
		HSSFCellStyle style23 = workbook.createCellStyle();
		HSSFCellStyle style24 = workbook.createCellStyle();
		HSSFCellStyle style25 = workbook.createCellStyle();

		//Cell의 Font 설정
		HSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short)20);
		font.setFontName("굴림");
		font.setBoldweight(font.BOLDWEIGHT_BOLD); 

		HSSFFont font01 = workbook.createFont();
		font01.setFontHeightInPoints((short)9);
		font01.setFontName("굴림");

		HSSFFont font03 = workbook.createFont();
		font03.setFontHeightInPoints((short)10);
		font03.setFontName("굴림");
		font03.setBoldweight(font03.BOLDWEIGHT_BOLD); 

		HSSFFont font04 = workbook.createFont();
		font04.setFontHeightInPoints((short)10);
		font04.setFontName("굴림");
		font04.setBoldweight(font04.BOLDWEIGHT_BOLD); 

		HSSFFont font05 = workbook.createFont();
		font05.setFontHeightInPoints((short)20);
		font05.setFontName("굴림");
		font05.setBoldweight(font05.BOLDWEIGHT_BOLD); 

		HSSFFont font06 = workbook.createFont();
		font06.setFontHeightInPoints((short)11);
		font06.setFontName("굴림");
		font06.setBoldweight(font.BOLDWEIGHT_BOLD); 

		HSSFFont font07 = workbook.createFont();
		font07.setFontHeightInPoints((short)9);
		font07.setFontName("굴림");

		//Cell의 Align 속성
    style00.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style00.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style01.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style01.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style02.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style02.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style03.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style03.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style04.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style04.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style04.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		style04.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style04.setTopBorderColor(HSSFColor.BLACK.index);
		style04.setRightBorderColor(HSSFColor.BLACK.index);
		style04.setFillForegroundColor(HSSFColor.YELLOW.index);
		style04.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

    style05.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style05.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style05.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		style05.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		style05.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style05.setTopBorderColor(HSSFColor.BLACK.index);
		style05.setLeftBorderColor(HSSFColor.BLACK.index);
		style05.setRightBorderColor(HSSFColor.BLACK.index);
		style05.setFillForegroundColor(HSSFColor.YELLOW.index);
		style05.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

    style06.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style06.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style06.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		style06.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		style06.setTopBorderColor(HSSFColor.BLACK.index);
		style06.setRightBorderColor(HSSFColor.BLACK.index);
		style06.setFillForegroundColor(HSSFColor.YELLOW.index);
		style06.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

    style07.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style07.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style07.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style07.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		style07.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style07.setTopBorderColor(HSSFColor.BLACK.index);
		style07.setLeftBorderColor(HSSFColor.BLACK.index);
		style07.setRightBorderColor(HSSFColor.BLACK.index);

    style08.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style08.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style08.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style08.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style08.setTopBorderColor(HSSFColor.BLACK.index);
		style08.setRightBorderColor(HSSFColor.BLACK.index);
		style08.setWrapText( true ); 

    style09.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style09.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style09.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style09.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		style09.setTopBorderColor(HSSFColor.BLACK.index);
		style09.setRightBorderColor(HSSFColor.BLACK.index);
		style09.setWrapText( true ); 

    style10.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style10.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style10.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style10.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		style10.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style10.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		style10.setTopBorderColor(HSSFColor.BLACK.index);
		style10.setLeftBorderColor(HSSFColor.BLACK.index);
		style10.setRightBorderColor(HSSFColor.BLACK.index);
		style10.setBottomBorderColor(HSSFColor.BLACK.index);

    style11.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style11.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style11.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style11.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style11.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		style11.setTopBorderColor(HSSFColor.BLACK.index);
		style11.setRightBorderColor(HSSFColor.BLACK.index);
		style11.setBottomBorderColor(HSSFColor.BLACK.index);
		style11.setWrapText( true ); 

    style12.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style12.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style12.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style12.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		style12.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		style12.setTopBorderColor(HSSFColor.BLACK.index);
		style12.setRightBorderColor(HSSFColor.BLACK.index);
		style12.setBottomBorderColor(HSSFColor.BLACK.index);
		style12.setWrapText( true ); 

		style13.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		style13.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style13.setLeftBorderColor(HSSFColor.BLACK.index);
		style13.setRightBorderColor(HSSFColor.BLACK.index);

		style14.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style14.setRightBorderColor(HSSFColor.BLACK.index);

		style15.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		style15.setRightBorderColor(HSSFColor.BLACK.index);

    style16.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style16.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style16.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style16.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style16.setTopBorderColor(HSSFColor.BLACK.index);
		style16.setRightBorderColor(HSSFColor.BLACK.index);
		style16.setFillForegroundColor(HSSFColor.YELLOW.index);
		style16.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

    style18.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style18.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style18.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		style18.setTopBorderColor(HSSFColor.BLACK.index);

    style19.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style19.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style19.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		style19.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		style19.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style19.setTopBorderColor(HSSFColor.BLACK.index);
		style19.setLeftBorderColor(HSSFColor.BLACK.index);
		style19.setRightBorderColor(HSSFColor.BLACK.index);

    style20.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style20.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style20.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		style20.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style20.setTopBorderColor(HSSFColor.BLACK.index);
		style20.setRightBorderColor(HSSFColor.BLACK.index);

    style21.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style21.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style21.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		style21.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		style21.setTopBorderColor(HSSFColor.BLACK.index);
		style21.setRightBorderColor(HSSFColor.BLACK.index);

    style22.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style22.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style22.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style22.setTopBorderColor(HSSFColor.BLACK.index);

    style23.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style23.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style23.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style23.setRightBorderColor(HSSFColor.BLACK.index);

    style24.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style24.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style24.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		style24.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style24.setLeftBorderColor(HSSFColor.BLACK.index);
		style24.setRightBorderColor(HSSFColor.BLACK.index);

    style25.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style25.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style25.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		style25.setRightBorderColor(HSSFColor.BLACK.index);

		//Cell 병합 
		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet01.addMergedRegion(new Region(0,(short)0,0,(short)11)); 
		sheet01.addMergedRegion(new Region(1,(short)0,1,(short)11)); 
		sheet01.addMergedRegion(new Region(3,(short)0,3,(short)11)); 

		sheet02.addMergedRegion(new Region(1,(short)0,1,(short)7)); 

		sheet03.addMergedRegion(new Region(0,(short)0,0,(short)6)); 
		sheet03.addMergedRegion(new Region(1,(short)0,1,(short)6)); 
		sheet03.addMergedRegion(new Region(2,(short)0,3,(short)0)); 
		sheet03.addMergedRegion(new Region(2,(short)1,3,(short)1)); 
		sheet03.addMergedRegion(new Region(2,(short)2,3,(short)2)); 
		sheet03.addMergedRegion(new Region(2,(short)3,2,(short)4)); 
		sheet03.addMergedRegion(new Region(2,(short)5,3,(short)5)); 
		sheet03.addMergedRegion(new Region(2,(short)6,3,(short)6)); 

		//Cell Font
		style00.setFont(font06);
		style01.setFont(font01);
		style02.setFont(font);
		style03.setFont(font03);
		style04.setFont(font04);
		style05.setFont(font04);
		style06.setFont(font04);
		style07.setFont(font01);
		style08.setFont(font01);
		style09.setFont(font01);
		style10.setFont(font01);
		style11.setFont(font01);
		style12.setFont(font01);
		style13.setFont(font01);
		style14.setFont(font01);
		style15.setFont(font01);
		style16.setFont(font04);
		style17.setFont(font05);
		style18.setFont(font07);
		style19.setFont(font07);
		style20.setFont(font07);
		style21.setFont(font07);
		style22.setFont(font07);
		style23.setFont(font07);
		style24.setFont(font07);
		style25.setFont(font07);

		///////////////////////////////////////////////////////////////////////////////////////////////
		// 1st Sheet ( Crossing Request )
		///////////////////////////////////////////////////////////////////////////////////////////////

		//Cell 생성
		HSSFRow row00 = sheet01.createRow(0);
		row00.setHeight ((short) 0x160); // row 높이 설정

		HSSFRow row01 = sheet01.createRow(1);
		row01.setHeight ((short) 0x360); // row 높이 설정

		HSSFRow row03 = sheet01.createRow(3);
		row03.setHeight ((short) 0x160); // row 높이 설정

		HSSFCell cell00 = row00.createCell((short)0);
		cell00.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell00.setCellStyle(style01);
		cell00.setCellValue("군사분계선  통행 신청서");

		HSSFCell cell01 = row01.createCell((short)0);
		cell01.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell01.setCellStyle(style02);
		cell01.setCellValue("MDL Crossing Request");

		HSSFCell cell03 = row03.createCell((short)0);
		cell03.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell03.setCellStyle(style03);
		cell03.setCellValue("1. Summary / 요약");

		//Cell 생성
		HSSFRow row04 = sheet01.createRow(4);
		row04.setHeight ((short) 0x560); // row 높이 설정

		HSSFCell cell0400 = row04.createCell((short)0);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style05);
		cell0400.setCellValue("통행\n관리번호\n\nTCN");

		HSSFCell cell0401 = row04.createCell((short)1);
		cell0401.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0401.setCellStyle(style04);
		cell0401.setCellValue("일자\n\nDATE");

		HSSFCell cell0402 = row04.createCell((short)2);
		cell0402.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0402.setCellStyle(style04);
		cell0402.setCellValue("통행시각\n(남-북)\nMDL TIME\n(S-N)");

		HSSFCell cell0403 = row04.createCell((short)3);
		cell0403.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0403.setCellStyle(style04);
		cell0403.setCellValue("방향\n(남-북)\nDIR(S-N)");

		HSSFCell cell0404 = row04.createCell((short)4);
		cell0404.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0404.setCellStyle(style04);
		cell0404.setCellValue("통행시각\n(북-남)\nMDL TIME\n(N-S)");

		HSSFCell cell0405 = row04.createCell((short)5);
		cell0405.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0405.setCellStyle(style04);
		cell0405.setCellValue("방향\n(북-남)\nDIR(N-S)");

		HSSFCell cell0406 = row04.createCell((short)6);
		cell0406.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0406.setCellStyle(style04);
		cell0406.setCellValue("목적\n\nPURPOSE");

		HSSFCell cell0407 = row04.createCell((short)7);
		cell0407.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0407.setCellStyle(style04);
		cell0407.setCellValue("인원\n(남-북)\nPAX\n(S-N)");

		HSSFCell cell0408 = row04.createCell((short)8);
		cell0408.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0408.setCellStyle(style04);
		cell0408.setCellValue("인원\n(북-남)\nPAX\n(N-S)");

		HSSFCell cell0409 = row04.createCell((short)9);
		cell0409.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0409.setCellStyle(style04);
		cell0409.setCellValue("차량\n(남-북)\nVEH\n(S-N)");

		HSSFCell cell0410 = row04.createCell((short)10);
		cell0410.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0410.setCellStyle(style04);
		cell0410.setCellValue("차량\n(북-남)\nVEH\n(N-S)");

		HSSFCell cell0411 = row04.createCell((short)11);
		cell0411.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0411.setCellStyle(style06);
		cell0411.setCellValue("화물\n\nCARGO");


		String sqlSheet1 = "";
		sqlSheet1 = "	SELECT PURPOSE,0 SNPER,0 NSPER,0 SNCAR,0 NSCAR,'' START_DATE,'' START_TIME,'' RTRN_DATE,'' RTRN_TIME, 1 LVL, '' SN_GOODS, '' NS_GOODS FROM TRANSFER.LTACCPLAN WHERE ACCESSNO = '" + gstr1 + "' "
							+ "	 UNION ALL \n"
							+ "	SELECT '' PURPOSE, \n"
							+ "		     0 SNPER, \n"
							+ "        0 NSPER, \n"
							+ "        SUM(CASE WHEN ACCSECTION = 'O' THEN 1 ELSE 0 END) SNCAR, \n"
							+ "        SUM(CASE WHEN ACCSECTION = 'I' THEN 1 ELSE 0 END) NSCAR, \n"
							+ "        MAX(START_DATE), \n"
							+ "        MAX(START_TIME), \n"
							+ "        MAX(RTRN_DATE), \n"
							+ "        MAX(RTRN_TIME), \n"
							+ "        2 LVL, \n"
							+ "				 MAX(CASE WHEN ACCSECTION = 'O' THEN RDS_GOODS END) SN_GOODS, \n"
							+ "				 MAX(CASE WHEN ACCSECTION = 'I' THEN RDS_GOODS END) NS_GOODS \n"
							+ "   FROM TRANSFER.LTACCPLCAR \n"
							+ "  WHERE ACCESS_NO = (SELECT ACCESSNO FROM TRANSFER.LTACCPLAN WHERE ACCESSNO = '" + gstr1 + "') \n"
							+ "  UNION ALL \n"
							+ " SELECT '' PURPOSE, \n"
							+ "        SUM(CASE WHEN ACCSECTION = 'O' THEN 1 ELSE 0 END) SNPER, \n"
							+ "        SUM(CASE WHEN ACCSECTION = 'I' THEN 1 ELSE 0 END) NSPER, \n"
							+ "        0 SNCAR, \n"
							+ "        0 NSCAR, \n"
							+ "        MAX(START_DATE), \n"
							+ "        MAX(START_TIME), \n"
							+ "        MAX(RTRN_DATE), \n"
							+ "        MAX(RTRN_TIME), \n"
							+ "        3 LVL, \n"
							+ "        '' SN_GOODS, \n"
							+ "        '' NS_GOODS \n"
							+ "   FROM TRANSFER.LTPSRNACC \n"
							+ "  WHERE ACCESSNO = (SELECT ACCESSNO FROM TRANSFER.LTACCPLAN WHERE ACCESSNO = '" + gstr1 + "') \n"
							+ "  ORDER BY LVL ";

		String spurpose = "";
		String sndate = "";
		String sntime = "";
		String snper = "";
		String sncar = "";
		String nsdate = "";
		String nstime = "";
		String nsper = "";
		String nscar = "";
		String sngoods = "";
		String nsgoods = "";

		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet1);

			int icnt = 1;
			while(rs.next()) {
				if (icnt==1) {
					spurpose = rs.getString(1);
				} else if (icnt==2) {
					sndate = rs.getString(6);
					if (sndate!=null && !sndate.equals("")) sndate = sndate.substring(0,4) + "/" + sndate.substring(4,6) + "/" + sndate.substring(6,8);
					sntime = rs.getString(7);
					if (sntime!=null && !sntime.equals("")) sntime = sntime.substring(0,2) + ":" + sntime.substring(2,4);
					nsdate = rs.getString(8);
					if (nsdate!=null && !nsdate.equals("")) nsdate = nsdate.substring(0,4) + "/" + nsdate.substring(4,6) + "/" + nsdate.substring(6,8);
					nstime = rs.getString(9);
					if (nstime!=null && !nstime.equals("")) nstime = nstime.substring(0,2) + ":" + nstime.substring(2,4);
					sncar = rs.getString(4);
					nscar = rs.getString(5);
					sngoods = rs.getString(11) + " 외";
					nsgoods = rs.getString(12) + " 외";
				} else if (icnt==3)	{
					snper = rs.getString(2);
					nsper = rs.getString(3);
				}

				icnt++;
			}

			stmt = null;
			rs = null;
		}

		//Cell 생성
		HSSFRow row05 = sheet01.createRow(5);
		row05.setHeight ((short) 0x360); // row 높이 설정

		HSSFCell cell0500 = row05.createCell((short)0);
		cell0500.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0500.setCellStyle(style07);
		cell0500.setCellValue("");

		HSSFCell cell0501 = row05.createCell((short)1);
		cell0501.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0501.setCellStyle(style08);
		cell0501.setCellValue(sndate);

		HSSFCell cell0502 = row05.createCell((short)2);
		cell0502.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0502.setCellStyle(style08);
		cell0502.setCellValue(sntime);

		HSSFCell cell0503 = row05.createCell((short)3);
		cell0503.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0503.setCellStyle(style08);
		cell0503.setCellValue("S-N");

		HSSFCell cell0504 = row05.createCell((short)4);
		cell0504.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0504.setCellStyle(style08);
		cell0504.setCellValue("");

		HSSFCell cell0505 = row05.createCell((short)5);
		cell0505.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0505.setCellStyle(style08);
		cell0505.setCellValue("");

		HSSFCell cell0506 = row05.createCell((short)6);
		cell0506.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0506.setCellStyle(style08);
		cell0506.setCellValue(spurpose);

		HSSFCell cell0507 = row05.createCell((short)7);
		cell0507.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0507.setCellStyle(style08);
		cell0507.setCellValue(snper);

		HSSFCell cell0508 = row05.createCell((short)8);
		cell0508.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0508.setCellStyle(style08);
		cell0508.setCellValue("");

		HSSFCell cell0509 = row05.createCell((short)9);
		cell0509.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0509.setCellStyle(style08);
		cell0509.setCellValue(sncar);

		HSSFCell cell0510 = row05.createCell((short)10);
		cell0510.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0510.setCellStyle(style08);
		cell0510.setCellValue("");

		HSSFCell cell0511 = row05.createCell((short)11);
		cell0511.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0511.setCellStyle(style09);
		cell0511.setCellValue(sngoods);

		//Cell 생성
		HSSFRow row06 = sheet01.createRow(6);
		row06.setHeight ((short) 0x360); // row 높이 설정

		HSSFCell cell0600 = row06.createCell((short)0);
		cell0600.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0600.setCellStyle(style10);
		cell0600.setCellValue("");

		HSSFCell cell0601 = row06.createCell((short)1);
		cell0601.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0601.setCellStyle(style11);
		cell0601.setCellValue(nsdate);

		HSSFCell cell0602 = row06.createCell((short)2);
		cell0602.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0602.setCellStyle(style11);
		cell0602.setCellValue("");

		HSSFCell cell0603 = row06.createCell((short)3);
		cell0603.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0603.setCellStyle(style11);
		cell0603.setCellValue("");

		HSSFCell cell0604 = row06.createCell((short)4);
		cell0604.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0604.setCellStyle(style11);
		cell0604.setCellValue(nstime);

		HSSFCell cell0605 = row06.createCell((short)5);
		cell0605.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0605.setCellStyle(style11);
		cell0605.setCellValue("N-S");

		HSSFCell cell0606 = row06.createCell((short)6);
		cell0606.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0606.setCellStyle(style11);
		cell0606.setCellValue(spurpose);

		HSSFCell cell0607 = row06.createCell((short)7);
		cell0607.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0607.setCellStyle(style11);
		cell0607.setCellValue("");

		HSSFCell cell0608 = row06.createCell((short)8);
		cell0608.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0608.setCellStyle(style11);
		cell0608.setCellValue(nsper);

		HSSFCell cell0609 = row06.createCell((short)9);
		cell0609.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0609.setCellStyle(style11);
		cell0609.setCellValue("");

		HSSFCell cell0610 = row06.createCell((short)10);
		cell0610.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0610.setCellStyle(style11);
		cell0610.setCellValue(nscar);

		HSSFCell cell0611 = row06.createCell((short)11);
		cell0611.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0611.setCellStyle(style12);
		cell0611.setCellValue(nsgoods);

		///////////////////////////////////////////////////////////////////////////////////////////////
		// 2nd Sheet ( Personnel  Manifest )
		///////////////////////////////////////////////////////////////////////////////////////////////

		//Cell 생성
		row01 = sheet02.createRow(1);
		row01.setHeight ((short) 0x160); // row 높이 설정

		cell01 = row01.createCell((short)0);
		cell01.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell01.setCellStyle(style03);
		cell01.setCellValue("2. Personnel Data / 인원 현황");

		//Cell 생성
		HSSFRow row02 = sheet02.createRow(2);
		row02.setHeight ((short) 0x360); // row 높이 설정

		HSSFCell cell0200 = row02.createCell((short)0);
		cell0200.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0200.setCellStyle(style05);
		cell0200.setCellValue("순서\nOrder");

		HSSFCell cell0201 = row02.createCell((short)1);
		cell0201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0201.setCellStyle(style04);
		cell0201.setCellValue("소속\nCompany");

		HSSFCell cell0202 = row02.createCell((short)2);
		cell0202.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0202.setCellStyle(style04);
		cell0202.setCellValue("직위\nTitle");

		HSSFCell cell0203 = row02.createCell((short)3);
		cell0203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0203.setCellStyle(style04);
		cell0203.setCellValue("이름\nName");

		HSSFCell cell0204 = row02.createCell((short)4);
		cell0204.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0204.setCellStyle(style04);
		cell0204.setCellValue("성별\nSex");

		HSSFCell cell0205 = row02.createCell((short)5);
		cell0205.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0205.setCellStyle(style04);
		cell0205.setCellValue("주민등록번호\nKID");

		HSSFCell cell0206 = row02.createCell((short)6);
		cell0206.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0206.setCellStyle(style04);
		cell0206.setCellValue("주소\nAddress");

		HSSFCell cell0207 = row02.createCell((short)7);
		cell0207.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0207.setCellStyle(style06);
		cell0207.setCellValue("복귀일\nReturn Date");

		String sqlSheet2 = "";
		/*
		sqlSheet2 = " SELECT C.MINORNM COMPNM, B.POSITION, B.PSN_KNAME, \n"
				      + "        CASE WHEN B.GENDER = 'M' THEN '남' ELSE '여' END GENDER, \n"
				      + "        CASE WHEN B.REG_NO != '' THEN SUBSTR(B.REG_NO,1,6)||'-'|| SUBSTR(B.REG_NO,7,13) ELSE '' END REG_NO, \n"
				      + "        B.ADDRESS1, \n"
				      + "        CASE WHEN A.RTRN_DATE !='' THEN SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2) ELSE '' END RTRN_DATE \n"
				      + "   FROM TRANSFER.LTPSRNACC A \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTPERSON B ON A.PERSON_NO = B.PERSON_NO \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTLCODE C ON A.PRSN_CMPY = C.MINORCD AND C.MAJORCD = '0015' \n"
				      + "  WHERE A.ACCSECTION = 'O' \n"
				      + "    AND A.ACCESSNO = '" + gstr1 + "' \n";
		*/
		sqlSheet2 = " SELECT C.MINORNM COMPNM, A.JOB_DUTY POSITION, B.PSN_KNAME, \n"
				      + "        CASE WHEN A.GENDER = 'M' THEN '남' ELSE '여' END GENDER, \n"
				      + "        CASE WHEN A.PRSN_REGNO != '' THEN SUBSTR(A.PRSN_REGNO,1,6)||'-'|| SUBSTR(A.PRSN_REGNO,7,13) ELSE '' END REG_NO, \n"
				      + "        B.ADDRESS1, \n"
				      + "        CASE WHEN A.RTRN_DATE !='' THEN SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2) ELSE '' END RTRN_DATE \n"
				      + "   FROM TRANSFER.LTPSRNACC A \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTPERSON B ON A.PERSON_NO = B.PERSON_NO \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTLCODE C ON A.PRSN_CMPY = C.MINORCD AND C.MAJORCD = '0015' \n"
				      + "  WHERE A.ACCSECTION = 'O' \n"
				      + "    AND A.ACCESSNO = '" + gstr1 + "' \n";

		HSSFCell cell0300 = null;
		HSSFCell cell0301 = null;
		HSSFCell cell0302 = null;
		HSSFCell cell0303 = null;
		HSSFCell cell0304 = null;
		HSSFCell cell0305 = null;
		HSSFCell cell0306 = null;
		HSSFCell cell0307 = null;

		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet2);

			int icnt = 3;
			int ipos = 1;
			while(rs.next()) {
				cell0300 = null;
				cell0301 = null;
				cell0302 = null;
				cell0303 = null;
				cell0304 = null;
				cell0305 = null;
				cell0306 = null;
				cell0307 = null;

				//Cell 생성
				row03 = sheet02.createRow(icnt);
				row03.setHeight ((short) 0x230); // row 높이 설정

				cell0300 = row03.createCell((short)0);
				cell0300.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0300.setCellStyle(style07);
				cell0300.setCellValue(ipos);

				cell0301 = row03.createCell((short)1);
				cell0301.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0301.setCellStyle(style08);
				cell0301.setCellValue(rs.getString(1));

				cell0302 = row03.createCell((short)2);
				cell0302.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0302.setCellStyle(style08);
				cell0302.setCellValue(rs.getString(2));

				cell0303 = row03.createCell((short)3);
				cell0303.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0303.setCellStyle(style08);
				cell0303.setCellValue(rs.getString(3));

				cell0304 = row03.createCell((short)4);
				cell0304.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0304.setCellStyle(style08);
				cell0304.setCellValue(rs.getString(4));

				cell0305 = row03.createCell((short)5);
				cell0305.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0305.setCellStyle(style08);
				cell0305.setCellValue(rs.getString(5));

				cell0306 = row03.createCell((short)6);
				cell0306.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0306.setCellStyle(style08);
				cell0306.setCellValue(rs.getString(6));

				cell0307 = row03.createCell((short)7);
				cell0307.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0307.setCellStyle(style09);
				cell0307.setCellValue(rs.getString(7));

				icnt++;
				ipos++;
			}

			stmt = null;
			rs = null;

			//Cell 생성
			row03 = sheet02.createRow(icnt);
			for (int s=0; s<8; s++)	{
				cell0300 = row03.createCell((short)s);
				cell0300.setCellStyle(style18);
			}

		}

		///////////////////////////////////////////////////////////////////////////////////////////////
		// 3th Sheet ( Vehicle Manifest )
		///////////////////////////////////////////////////////////////////////////////////////////////

		//Cell 생성
		row00 = sheet03.createRow(0);
		row00.setHeight ((short) 0x260); // row 높이 설정

		HSSFCell cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style17);
		cell0000.setCellValue("S ⇒ N");
		
		//Cell 생성
		row01 = sheet03.createRow(1);
		row01.setHeight ((short) 0x160); // row 높이 설정

		HSSFCell cell0001 = row01.createCell((short)0);
		cell0001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0001.setCellStyle(style03);
		cell0001.setCellValue("3. Vehicles / 차량 현황");

		//Cell 생성
		row02 = sheet03.createRow(2);
		row02.setHeight ((short) 0x300); // row 높이 설정

		cell0200 = row02.createCell((short)0);
		cell0200.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0200.setCellStyle(style05);
		cell0200.setCellValue("순서\nOrder");

		cell0201 = row02.createCell((short)1);
		cell0201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0201.setCellStyle(style04);
		cell0201.setCellValue("차량유형\nMode");

		cell0202 = row02.createCell((short)2);
		cell0202.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0202.setCellStyle(style04);
		cell0202.setCellValue("차량번호\nVeh #");

		cell0203 = row02.createCell((short)3);
		cell0203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0203.setCellStyle(style04);
		cell0203.setCellValue("내용\nContents");

		cell0204 = row02.createCell((short)4);
		cell0204.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0204.setCellStyle(style04);
		cell0204.setCellValue("");

		cell0205 = row02.createCell((short)5);
		cell0205.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0205.setCellStyle(style04);
		cell0205.setCellValue("운전자\nDriver");

		cell0206 = row02.createCell((short)6);
		cell0206.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0206.setCellStyle(style06);
		cell0206.setCellValue("복귀일\nReturn Date");

		//Cell 생성
		row03 = sheet03.createRow(3);
		row03.setHeight ((short) 0x100); // row 높이 설정

		cell0300 = row03.createCell((short)0);
		cell0300.setCellStyle(style13);
		cell0301 = row03.createCell((short)1);
		cell0301.setCellStyle(style14);
		cell0302 = row03.createCell((short)2);
		cell0302.setCellStyle(style14);
		cell0305 = row03.createCell((short)5);
		cell0305.setCellStyle(style14);
		cell0306 = row03.createCell((short)6);
		cell0306.setCellStyle(style15);

		cell0303 = row03.createCell((short)3);
		cell0303.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0303.setCellStyle(style16);
		cell0303.setCellValue("Pax/인원");

		cell0304 = row03.createCell((short)4);
		cell0304.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0304.setCellStyle(style16);
		cell0304.setCellValue("Cargos/화물");

		String sqlSheet3 = "";
		sqlSheet3 = " SELECT C.CAR_NAME, A.CAR_NO, \n "
							+ "				 CASE WHEN D.CNT=0 THEN 0 ELSE D.CNT-1 END CNT, \n "
							+ "	       A.RDS_GOODS, B.PSN_KNAME, \n "
							+ "       CASE WHEN A.RTRN_DATE !='' THEN SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2) ELSE '' END RTRN_DATE \n "
							+ "   FROM TRANSFER.LTACCPLCAR A, \n "
							+ "        TRANSFER.LTPERSON B, \n "
							+ "        TRANSFER.LTCARTYPE C, \n "
							+ "        (SELECT ACCESSNO, CAR_NO, COUNT(*) CNT FROM TRANSFER.LTPSRNACC WHERE ACCSECTION = 'O' GROUP BY ACCESSNO, CAR_NO) D \n "
							+ "  WHERE A.ACCSECTION = 'O' \n "
							+ "    AND A.ACCESS_NO = '" + gstr1 + "' \n "
							+ "    AND A.PERSON_NO = B.PERSON_NO \n "
							+ "    AND A.CAR_TYPE = C.CAR_TYPE \n"
							+ "    AND A.ACCESS_NO = D.ACCESSNO \n"
							+ "    AND A.CAR_NO = D.CAR_NO \n";

		int icnt = 4;
		int ipos = 1;
		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet3);

			while(rs.next()) {
				//Cell 생성
				row04 = sheet03.createRow(icnt);
				row04.setHeight ((short) 0x200); // row 높이 설정

				cell0400 = row04.createCell((short)0);
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellStyle(style07);
				cell0400.setCellValue(ipos);

				cell0401 = row04.createCell((short)1);
				cell0401.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0401.setCellStyle(style08);
				cell0401.setCellValue(rs.getString(1));

				cell0402 = row04.createCell((short)2);
				cell0402.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0402.setCellStyle(style08);
				cell0402.setCellValue(rs.getString(2));

				cell0403 = row04.createCell((short)3);
				cell0403.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0403.setCellStyle(style08);
				cell0403.setCellValue(rs.getString(3));

				cell0404 = row04.createCell((short)4);
				cell0404.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0404.setCellStyle(style08);
				cell0404.setCellValue(rs.getString(4));

				cell0405 = row04.createCell((short)5);
				cell0405.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0405.setCellStyle(style08);
				cell0405.setCellValue(rs.getString(5));

				cell0406 = row04.createCell((short)6);
				cell0406.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0406.setCellStyle(style09);
				cell0406.setCellValue(rs.getString(6));

				icnt++;
				ipos++;

			}

			stmt = null;
			rs = null;

			//Cell 생성
			row04 = sheet03.createRow(icnt);
			for (int s=0; s<7; s++)	{
				cell0400 = row04.createCell((short)s);
				cell0400.setCellStyle(style18);
			}

		}

		icnt++;
		icnt++;

		sheet03.addMergedRegion(new Region(icnt,(short)0,icnt,(short)6)); 

		//Cell 생성
		row00 = sheet03.createRow(icnt);
		row00.setHeight ((short) 0x260); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style17);
		cell0000.setCellValue("N ⇒ S");

		icnt++;

		sheet03.addMergedRegion(new Region(icnt,(short)0,icnt,(short)6)); 

		//Cell 생성
		row01 = sheet03.createRow(icnt);
		row01.setHeight ((short) 0x160); // row 높이 설정

		cell0001 = row01.createCell((short)0);
		cell0001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0001.setCellStyle(style03);
		cell0001.setCellValue("3. Vehicles / 차량 현황");

		icnt++;

		sheet03.addMergedRegion(new Region(icnt,(short)0,icnt+1,(short)0)); 
		sheet03.addMergedRegion(new Region(icnt,(short)1,icnt+1,(short)1)); 
		sheet03.addMergedRegion(new Region(icnt,(short)2,icnt+1,(short)2)); 
		sheet03.addMergedRegion(new Region(icnt,(short)3,icnt,(short)4)); 
		sheet03.addMergedRegion(new Region(icnt,(short)5,icnt+1,(short)5)); 
		sheet03.addMergedRegion(new Region(icnt,(short)6,icnt+1,(short)6)); 

		//Cell 생성
		row02 = sheet03.createRow(icnt);
		row02.setHeight ((short) 0x300); // row 높이 설정

		cell0200 = row02.createCell((short)0);
		cell0200.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0200.setCellStyle(style05);
		cell0200.setCellValue("순서\nOrder");

		cell0201 = row02.createCell((short)1);
		cell0201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0201.setCellStyle(style04);
		cell0201.setCellValue("차량유형\nMode");

		cell0202 = row02.createCell((short)2);
		cell0202.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0202.setCellStyle(style04);
		cell0202.setCellValue("차량번호\nVeh #");

		cell0203 = row02.createCell((short)3);
		cell0203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0203.setCellStyle(style04);
		cell0203.setCellValue("내용\nContents");

		cell0204 = row02.createCell((short)4);
		cell0204.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0204.setCellStyle(style04);
		cell0204.setCellValue("");

		cell0205 = row02.createCell((short)5);
		cell0205.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0205.setCellStyle(style04);
		cell0205.setCellValue("운전자\nDriver");

		cell0206 = row02.createCell((short)6);
		cell0206.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0206.setCellStyle(style06);
		cell0206.setCellValue("출경일\nLeave Date");

		icnt++;

		//Cell 생성
		row03 = sheet03.createRow(icnt);
		row03.setHeight ((short) 0x100); // row 높이 설정

		cell0300 = row03.createCell((short)0);
		cell0300.setCellStyle(style13);
		cell0301 = row03.createCell((short)1);
		cell0301.setCellStyle(style14);
		cell0302 = row03.createCell((short)2);
		cell0302.setCellStyle(style14);
		cell0305 = row03.createCell((short)5);
		cell0305.setCellStyle(style14);
		cell0306 = row03.createCell((short)6);
		cell0306.setCellStyle(style15);

		cell0303 = row03.createCell((short)3);
		cell0303.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0303.setCellStyle(style16);
		cell0303.setCellValue("Pax/인원");

		cell0304 = row03.createCell((short)4);
		cell0304.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0304.setCellStyle(style16);
		cell0304.setCellValue("Cargos/화물");


		sqlSheet3 = "";
		sqlSheet3 = " SELECT C.CAR_NAME, A.CAR_NO, \n "
							+ "				 CASE WHEN D.CNT=0 THEN 0 ELSE D.CNT-1 END CNT, \n "
							+ "	       A.RDS_GOODS, B.PSN_KNAME, \n "
							+ "       CASE WHEN A.START_DATE !='' THEN SUBSTR(A.START_DATE,5,2)||'.'||SUBSTR(A.START_DATE,7,2) ELSE '' END START_DATE \n "
							+ "   FROM TRANSFER.LTACCPLCAR A, \n "
							+ "        TRANSFER.LTPERSON B, \n "
							+ "        TRANSFER.LTCARTYPE C, \n "
							+ "        (SELECT ACCESSNO, CAR_NO, COUNT(*) CNT FROM TRANSFER.LTPSRNACC WHERE ACCSECTION = 'I' GROUP BY ACCESSNO, CAR_NO) D \n "
							+ "  WHERE A.ACCSECTION = 'I' \n "
							+ "    AND A.ACCESS_NO = '" + gstr1 + "' \n "
							+ "    AND A.PERSON_NO = B.PERSON_NO \n "
							+ "    AND A.CAR_TYPE = C.CAR_TYPE \n"
							+ "    AND A.ACCESS_NO = D.ACCESSNO \n"
							+ "    AND A.CAR_NO = D.CAR_NO \n";

		icnt++;
		ipos = 1;
		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet3);

			while(rs.next()) {
				//Cell 생성
				row04 = sheet03.createRow(icnt);
				row04.setHeight ((short) 0x200); // row 높이 설정

				cell0400 = row04.createCell((short)0);
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellStyle(style07);
				cell0400.setCellValue(ipos);

				cell0401 = row04.createCell((short)1);
				cell0401.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0401.setCellStyle(style08);
				cell0401.setCellValue(rs.getString(1));

				cell0402 = row04.createCell((short)2);
				cell0402.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0402.setCellStyle(style08);
				cell0402.setCellValue(rs.getString(2));

				cell0403 = row04.createCell((short)3);
				cell0403.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0403.setCellStyle(style08);
				cell0403.setCellValue(rs.getString(3));

				cell0404 = row04.createCell((short)4);
				cell0404.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0404.setCellStyle(style08);
				cell0404.setCellValue(rs.getString(4));

				cell0405 = row04.createCell((short)5);
				cell0405.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0405.setCellStyle(style08);
				cell0405.setCellValue(rs.getString(5));

				cell0406 = row04.createCell((short)6);
				cell0406.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0406.setCellStyle(style09);
				cell0406.setCellValue(rs.getString(6));

				icnt++;
				ipos++;

			}

			stmt = null;
			rs = null;

			//Cell 생성
			row04 = sheet03.createRow(icnt);
			for (int s=0; s<7; s++)	{
				cell0400 = row04.createCell((short)s);
				cell0400.setCellStyle(style18);
			}

		}

		///////////////////////////////////////////////////////////////////////////////////////////////
		// 4th Sheet ( Cargo Manifest )
		///////////////////////////////////////////////////////////////////////////////////////////////

		//Cell 생성
		row01 = sheet04.createRow(1);
		row01.setHeight ((short) 0x160); // row 높이 설정

		cell0001 = row01.createCell((short)0);
		cell0001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0001.setCellStyle(style03);
		cell0001.setCellValue("4. Cargos Manifest / 화물목록");

		//Cell 생성
		row02 = sheet04.createRow(2);
		row02.setHeight ((short) 0x300); // row 높이 설정

		cell0200 = row02.createCell((short)0);
		cell0200.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0200.setCellStyle(style05);
		cell0200.setCellValue("방향\nDirection");

		cell0201 = row02.createCell((short)1);
		cell0201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0201.setCellStyle(style04);
		cell0201.setCellValue("자재&장비\nMaterial&Equipment");

		cell0202 = row02.createCell((short)2);
		cell0202.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0202.setCellStyle(style06);
		cell0202.setCellValue("개인소지품\nBelongings");

		String sqlSheet4 = "";
		sqlSheet4 = " SELECT RDS_GOODS FROM TRANSFER.LTACCPLCAR WHERE ACCESS_NO = '" + gstr1 + "' AND ACCSECTION = 'O' \n";

		String sngoods_all = "";
		String nsgoods_all = "";

		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet4);

			int t=1;
			while(rs.next()) {
				if (t==1) sngoods_all = rs.getString(1);
				else sngoods_all = sngoods_all + "," + rs.getString(1);
				t++;
			}
		}
		
		stmt = null;
		rs = null;

		sqlSheet4 = "";
		sqlSheet4 = " SELECT RDS_GOODS FROM TRANSFER.LTACCPLCAR WHERE ACCESS_NO = '" + gstr1 + "' AND ACCSECTION = 'I' \n";

		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet4);

			int t=1;
			while(rs.next()) {
				if (t==1) nsgoods_all = rs.getString(1);
				else nsgoods_all = nsgoods_all + "," + rs.getString(1);
				t++;
			}
		}
		
		stmt = null;
		rs = null;

		//Cell 생성
		row03 = sheet04.createRow(3);
		row03.setHeight ((short) 0x900); // row 높이 설정

		cell0200 = row03.createCell((short)0);
		cell0200.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0200.setCellStyle(style07);
		cell0200.setCellValue("S - N");

		cell0201 = row03.createCell((short)1);
		cell0201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0201.setCellStyle(style08);
		cell0201.setCellValue(sngoods_all);

		cell0202 = row03.createCell((short)2);
		cell0202.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0202.setCellStyle(style09);
		cell0202.setCellValue("");

		//Cell 생성
		row04 = sheet04.createRow(4);
		row04.setHeight ((short) 0x900); // row 높이 설정

		cell0400 = row04.createCell((short)0);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style10);
		cell0400.setCellValue("N - S");

		cell0401 = row04.createCell((short)1);
		cell0401.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0401.setCellStyle(style11);
		cell0401.setCellValue(nsgoods_all);

		cell0402 = row04.createCell((short)2);
		cell0402.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0402.setCellStyle(style12);
		cell0402.setCellValue("");


		///////////////////////////////////////////////////////////////////////////////////////////////
		// 5th Sheet ( North to South )
		///////////////////////////////////////////////////////////////////////////////////////////////

		// 2.통행개요
		sheet05.setColumnWidth((short)0,(short)1500);
		sheet05.setColumnWidth((short)1,(short)1500);
		sheet05.setColumnWidth((short)2,(short)2000);
		sheet05.setColumnWidth((short)3,(short)2000);
		sheet05.setColumnWidth((short)4,(short)2000);
		sheet05.setColumnWidth((short)5,(short)1500);
		sheet05.setColumnWidth((short)6,(short)500);
		sheet05.setColumnWidth((short)7,(short)500);
		sheet05.setColumnWidth((short)8,(short)3000);
		sheet05.setColumnWidth((short)9,(short)1500);
		sheet05.setColumnWidth((short)10,(short)1500);
		sheet05.setColumnWidth((short)11,(short)3000);
		sheet05.setColumnWidth((short)12,(short)3000);

		sheet05.addMergedRegion(new Region(0,(short)0,0,(short)12)); 
		sheet05.addMergedRegion(new Region(1,(short)0,1,(short)12)); 
		sheet05.addMergedRegion(new Region(2,(short)0,2,(short)12)); 
		sheet05.addMergedRegion(new Region(3,(short)0,3,(short)12)); 

		sheet05.addMergedRegion(new Region(4,(short)4,4,(short)7)); 
		sheet05.addMergedRegion(new Region(4,(short)11,4,(short)12)); 
		sheet05.addMergedRegion(new Region(5,(short)4,5,(short)7)); 
		sheet05.addMergedRegion(new Region(5,(short)11,5,(short)12)); 
		sheet05.addMergedRegion(new Region(6,(short)4,6,(short)7)); 
		sheet05.addMergedRegion(new Region(6,(short)11,6,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(0);
		row00.setHeight ((short) 0x260); // row 높이 설정

		cell00 = row00.createCell((short)0);
		cell00.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell00.setCellStyle(style00);
		cell00.setCellValue("군사분계선 통행 계획 (" + vdate + ")");

		row01 = sheet05.createRow(1);
		row01.setHeight ((short) 0x060); // row 높이 설정

		for (int t=3; t<11; t++) {
			cell03 = row01.createCell((short)t);
			cell03.setCellStyle(style18);
		}

		//Cell 생성
		row03 = sheet05.createRow(3);
		row03.setHeight ((short) 0x160); // row 높이 설정

		cell0300 = row03.createCell((short)0);
		cell0300.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0300.setCellStyle(style03);
		cell0300.setCellValue("1. 통행개요");

		//Cell 생성
		row04 = sheet05.createRow(4);
		row04.setHeight ((short) 0x260); // row 높이 설정

		cell0400 = row04.createCell((short)0);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style19);
		cell0400.setCellValue("일자");

		cell0401 = row04.createCell((short)1);
		cell0401.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0401.setCellStyle(style20);
		cell0401.setCellValue("방향");

		cell0402 = row04.createCell((short)2);
		cell0402.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0402.setCellStyle(style20);
		cell0402.setCellValue("지역");

		cell0403 = row04.createCell((short)3);
		cell0403.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0403.setCellStyle(style20);
		cell0403.setCellValue("통과시간");

		cell0404 = row04.createCell((short)4);
		cell0404.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0404.setCellStyle(style18);
		cell0404.setCellValue("목적");

		cell0404 = row04.createCell((short)5);
		cell0404.setCellStyle(style18);
		cell0404 = row04.createCell((short)6);
		cell0404.setCellStyle(style18);
		cell0404 = row04.createCell((short)7);
		cell0404.setCellStyle(style20);

		cell0408 = row04.createCell((short)8);
		cell0408.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0408.setCellStyle(style20);
		cell0408.setCellValue("목적지");

		cell0409 = row04.createCell((short)9);
		cell0409.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0409.setCellStyle(style20);
		cell0409.setCellValue("인원");

		cell0410 = row04.createCell((short)10);
		cell0410.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0410.setCellStyle(style20);
		cell0410.setCellValue("차량");

		cell0411 = row04.createCell((short)11);
		cell0411.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0411.setCellStyle(style20);
		cell0411.setCellValue("비고");

		HSSFCell cell0412 = row04.createCell((short)12);
		cell0412.setCellStyle(style21);

		//Cell 생성
		row05 = sheet05.createRow(5);
		row05.setHeight ((short) 0x260); // row 높이 설정

		cell0500 = row05.createCell((short)0);
		cell0500.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0500.setCellStyle(style07);
		cell0500.setCellValue(Integer.parseInt(sndate.substring(5,7))+"."+sndate.substring(8,10));

		cell0501 = row05.createCell((short)1);
		cell0501.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0501.setCellStyle(style08);
		cell0501.setCellValue("남⇒북");

		cell0502 = row05.createCell((short)2);
		cell0502.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0502.setCellStyle(style08);
		cell0502.setCellValue("동해선");

		cell0503 = row05.createCell((short)3);
		cell0503.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0503.setCellStyle(style08);
		cell0503.setCellValue(sntime);

		cell0504 = row05.createCell((short)4);
		cell0504.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0504.setCellStyle(style22);
		cell0504.setCellValue(spurpose);

		cell0504 = row05.createCell((short)5);
		cell0504.setCellStyle(style22);
		cell0504 = row05.createCell((short)6);
		cell0504.setCellStyle(style22);
		cell0504 = row05.createCell((short)7);
		cell0504.setCellStyle(style08);

		cell0508 = row05.createCell((short)8);
		cell0508.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0508.setCellStyle(style08);
		cell0508.setCellValue("북고성");

		cell0509 = row05.createCell((short)9);
		cell0509.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0509.setCellStyle(style08);
		cell0509.setCellValue(snper);

		cell0510 = row05.createCell((short)10);
		cell0510.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0510.setCellStyle(style08);
		cell0510.setCellValue(sncar);

		cell0511 = row05.createCell((short)11);
		cell0511.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0511.setCellStyle(style22);
		cell0511.setCellValue(sngoods);

		HSSFCell cell0512 = row05.createCell((short)12);
		cell0512.setCellStyle(style09);

		//Cell 생성
		row06 = sheet05.createRow(6);
		row06.setHeight ((short) 0x260); // row 높이 설정

		cell0600 = row06.createCell((short)0);
		cell0600.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0600.setCellStyle(style07);
		cell0600.setCellValue(Integer.parseInt(nsdate.substring(5,7))+"."+nsdate.substring(8,10));

		cell0601 = row06.createCell((short)1);
		cell0601.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0601.setCellStyle(style08);
		cell0601.setCellValue("북⇒남");

		cell0602 = row06.createCell((short)2);
		cell0602.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0602.setCellStyle(style08);
		cell0602.setCellValue("동해선");

		cell0603 = row06.createCell((short)3);
		cell0603.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0603.setCellStyle(style08);
		cell0603.setCellValue(nstime);

		cell0604 = row06.createCell((short)4);
		cell0604.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0604.setCellStyle(style22);
		cell0604.setCellValue(spurpose);

		cell0604 = row06.createCell((short)5);
		cell0604.setCellStyle(style22);
		cell0604 = row06.createCell((short)6);
		cell0604.setCellStyle(style22);
		cell0604 = row06.createCell((short)7);
		cell0604.setCellStyle(style08);

		cell0608 = row06.createCell((short)8);
		cell0608.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0608.setCellStyle(style08);
		cell0608.setCellValue("남고성");

		cell0609 = row06.createCell((short)9);
		cell0609.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0609.setCellStyle(style08);
		cell0609.setCellValue(nsper);

		cell0610 = row06.createCell((short)10);
		cell0610.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0610.setCellStyle(style08);
		cell0610.setCellValue(nscar);

		cell0611 = row06.createCell((short)11);
		cell0611.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0611.setCellStyle(style22);
		cell0611.setCellValue(nsgoods);

		HSSFCell cell0612 = row06.createCell((short)12);
		cell0612.setCellStyle(style09);

		//Cell 생성
		HSSFRow row07 = sheet05.createRow(7);
		for (int s=0; s<13; s++)	{
			HSSFCell cell0700 = row07.createCell((short)s);
			cell0700.setCellStyle(style18);
		}

		// 2.인적사항
		sheet05.addMergedRegion(new Region(8,(short)0,8,(short)12)); 
		sheet05.addMergedRegion(new Region(9,(short)0,9,(short)12)); 
		sheet05.addMergedRegion(new Region(10,(short)0,10,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(8);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue(vdate + " (남 ⇒ 북)");

		//Cell 생성
		row00 = sheet05.createRow(10);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue("2. 인적사항");

		sheet05.addMergedRegion(new Region(11,(short)1,11,(short)2)); 
		sheet05.addMergedRegion(new Region(11,(short)6,11,(short)9)); 
		sheet05.addMergedRegion(new Region(11,(short)10,11,(short)11)); 

		//Cell 생성
		row00 = sheet05.createRow(11);
		row00.setHeight ((short) 0x260); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style19);
		cell0000.setCellValue("순번");

		cell0000 = row00.createCell((short)1);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("소속");

		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("직책");

		cell0000 = row00.createCell((short)4);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("성명");

		cell0000 = row00.createCell((short)5);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("성별");

		cell0000 = row00.createCell((short)6);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("생년월일");

		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)9);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)10);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("주소");

		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)12);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style21);
		cell0000.setCellValue("복귀예정일");

		String sqlSheet5 = "";
		sqlSheet5 = " SELECT SUM(CASE WHEN ACCSECTION = 'O' THEN 1 ELSE 0 END) OCNT, \n"
				      + "        SUM(CASE WHEN ACCSECTION = 'I' THEN 1 ELSE 0 END) ICNT \n"
				      + "   FROM TRANSFER.LTPSRNACC \n"
				      + "  WHERE ACCESSNO = '" + gstr1 + "' \n";

		int o_cnt = 0;
		int i_cnt = 0;
		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet5);

			while(rs.next()) {
				o_cnt = rs.getInt(1);
				i_cnt = rs.getInt(2);
			}

			stmt = null;
			rs = null;

			icnt = 12;
			for (int x=0; x<o_cnt; x++) {
				sheet05.addMergedRegion(new Region(icnt,(short)1,icnt,(short)2)); 
				sheet05.addMergedRegion(new Region(icnt,(short)6,icnt,(short)9)); 
				sheet05.addMergedRegion(new Region(icnt,(short)10,icnt,(short)11)); 
				icnt++;
			}
		}

		sqlSheet5 = "";
		sqlSheet5 = " SELECT C.MINORNM COMPNM, A.JOB_DUTY POSITION, B.PSN_KNAME, \n"
				      + "        CASE WHEN A.GENDER = 'M' THEN '남' ELSE '여' END GENDER, \n"
				      + "        CASE WHEN A.PRSN_REGNO != '' THEN SUBSTR(A.PRSN_REGNO,1,2)||'.'|| SUBSTR(A.PRSN_REGNO,3,2)||'.'|| SUBSTR(A.PRSN_REGNO,5,2) ELSE '' END REG_NO, \n"
				      + "        B.ADDRESS1, \n"
				      + "        CASE WHEN A.RTRN_DATE !='' THEN SUBSTR(A.RTRN_DATE,3,2)||'.'||SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2) ELSE '' END RTRN_DATE \n"
				      + "   FROM TRANSFER.LTPSRNACC A \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTPERSON B ON A.PERSON_NO = B.PERSON_NO \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTLCODE C ON A.PRSN_CMPY = C.MINORCD AND C.MAJORCD = '0015' \n"
				      + "  WHERE A.ACCSECTION = 'O' \n"
				      + "    AND A.ACCESSNO = '" + gstr1 + "' \n";

		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet5);

			icnt = 12;
			ipos = 1;
			while(rs.next()) {

				//Cell 생성
				row00 = sheet05.createRow(icnt);
				row00.setHeight ((short) 0x260); // row 높이 설정

				cell0000 = row00.createCell((short)0);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style07);
				cell0000.setCellValue(ipos);

				cell0000 = row00.createCell((short)1);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(1));

				cell0000 = row00.createCell((short)2);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)3);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(2));

				cell0000 = row00.createCell((short)4);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(3));

				cell0000 = row00.createCell((short)5);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(4));

				cell0000 = row00.createCell((short)6);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(5));

				cell0000 = row00.createCell((short)7);
				cell0000.setCellStyle(style08);
				cell0000 = row00.createCell((short)8);
				cell0000.setCellStyle(style08);
				cell0000 = row00.createCell((short)9);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)10);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(6));

				cell0000 = row00.createCell((short)11);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)12);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style09);
				cell0000.setCellValue(rs.getString(7));
				
				icnt++;
				ipos++;
			}

			//Cell 생성
			row00 = sheet05.createRow(icnt);
			for (int s=0; s<13; s++)	{
				cell0000 = row00.createCell((short)s);
				cell0000.setCellStyle(style18);
			}

			icnt++;
			stmt = null;
			rs = null;
		}

		// 3.차량현황
		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue("3. 차량현황");

		icnt++;
		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt+1,(short)0)); 
		sheet05.addMergedRegion(new Region(icnt,(short)1,icnt+1,(short)2)); 
		sheet05.addMergedRegion(new Region(icnt,(short)3,icnt+1,(short)4)); 
		sheet05.addMergedRegion(new Region(icnt,(short)5,icnt,(short)10)); 
		sheet05.addMergedRegion(new Region(icnt,(short)11,icnt+1,(short)11)); 
		sheet05.addMergedRegion(new Region(icnt,(short)12,icnt+1,(short)12)); 
		sheet05.addMergedRegion(new Region(icnt+1,(short)5,icnt+1,(short)6)); 
		sheet05.addMergedRegion(new Region(icnt+1,(short)7,icnt+1,(short)10)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style19);
		cell0000.setCellValue("순번");

		cell0000 = row00.createCell((short)1);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("차종");

		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("차량번호");

		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)5);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("적재");

		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)9);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)11);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("운전사");

		cell0000 = row00.createCell((short)12);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style21);
		cell0000.setCellValue("복귀예정일");

		icnt++;

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setCellStyle(style24);
		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style23);
		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style23);

		cell0000 = row00.createCell((short)5);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue("인원");

		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)7);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue("화물");

		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)9);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style23);

		cell0000 = row00.createCell((short)12);
		cell0000.setCellStyle(style25);

		sqlSheet5 = "";
		sqlSheet5 = " SELECT SUM(CASE WHEN ACCSECTION = 'O' THEN 1 ELSE 0 END) O_CNT2, \n "
							+ "	       SUM(CASE WHEN ACCSECTION = 'I' THEN 1 ELSE 0 END) I_CNT2 \n "
							+ "   FROM TRANSFER.LTACCPLCAR \n "
							+ "  WHERE ACCESS_NO = '" + gstr1 + "'";

		int o_cnt2 = 0;
		int i_cnt2 = 0;
		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet5);

			while(rs.next()) {
				o_cnt2 = rs.getInt(1);
				i_cnt2 = rs.getInt(2);
			}

			stmt = null;
			rs = null;
			
			int c_cnt = icnt;
			c_cnt++;
			for (int x=0; x<o_cnt2; x++) {
				sheet05.addMergedRegion(new Region(c_cnt,(short)1,c_cnt,(short)2)); 
				sheet05.addMergedRegion(new Region(c_cnt,(short)3,c_cnt,(short)4)); 
				sheet05.addMergedRegion(new Region(c_cnt,(short)5,c_cnt,(short)6)); 
				sheet05.addMergedRegion(new Region(c_cnt,(short)7,c_cnt,(short)10)); 
				c_cnt++;
			}
		}

		sqlSheet5 = "";
		sqlSheet5 = " SELECT C.CAR_NAME, A.CAR_NO, \n "
							+ "				 CASE WHEN D.CNT=0 THEN 0 ELSE D.CNT-1 END CNT, \n "
							+ "	       CASE WHEN RTRIM(A.RDS_GOODS)='' THEN '-' ELSE A.RDS_GOODS END RDS_GOODS, B.PSN_KNAME, \n "
							+ "       CASE WHEN A.RTRN_DATE !='' THEN SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2) ELSE '' END RTRN_DATE \n "
							+ "   FROM TRANSFER.LTACCPLCAR A, \n "
							+ "        TRANSFER.LTPERSON B, \n "
							+ "        TRANSFER.LTCARTYPE C, \n "
							+ "        (SELECT ACCESSNO, CAR_NO, COUNT(*) CNT FROM TRANSFER.LTPSRNACC WHERE ACCSECTION = 'O' GROUP BY ACCESSNO, CAR_NO) D \n "
							+ "  WHERE A.ACCSECTION = 'O' \n "
							+ "    AND A.ACCESS_NO = '" + gstr1 + "' \n "
							+ "    AND A.PERSON_NO = B.PERSON_NO \n "
							+ "    AND A.CAR_TYPE = C.CAR_TYPE \n"
							+ "    AND A.ACCESS_NO = D.ACCESSNO \n"
							+ "    AND A.CAR_NO = D.CAR_NO \n";

		icnt++;
		ipos = 1;
		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet5);

			while(rs.next()) {

				//Cell 생성
				row00 = sheet05.createRow(icnt);
				row00.setHeight ((short) 0x160); // row 높이 설정

				cell0000 = row00.createCell((short)0);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style07);
				cell0000.setCellValue(ipos);

				cell0000 = row00.createCell((short)1);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(1));

				cell0000 = row00.createCell((short)2);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)3);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(2));

				cell0000 = row00.createCell((short)4);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)5);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(3));

				cell0000 = row00.createCell((short)6);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)7);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(4));

				cell0000 = row00.createCell((short)8);
				cell0000.setCellStyle(style22);
				cell0000 = row00.createCell((short)9);
				cell0000.setCellStyle(style22);
				cell0000 = row00.createCell((short)10);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)11);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(5));

				cell0000 = row00.createCell((short)12);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style09);
				cell0000.setCellValue(rs.getString(6));

				icnt++;
				ipos++;

			}

			//Cell 생성
			row00 = sheet05.createRow(icnt);
			for (int s=0; s<13; s++)	{
				cell0000 = row00.createCell((short)s);
				cell0000.setCellStyle(style18);
			}

			icnt++;
			stmt = null;
			rs = null;

		}

		// 4.기타물품
		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue("4. 기타물품");

		icnt++;

		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)2)); 
		sheet05.addMergedRegion(new Region(icnt,(short)3,icnt,(short)8)); 
		sheet05.addMergedRegion(new Region(icnt,(short)9,icnt,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x200); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style19);
		cell0000.setCellValue("구분");

		cell0000 = row00.createCell((short)1);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("적재품");

		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)5);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)9);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("휴대품");

		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)12);
		cell0000.setCellStyle(style21);

		icnt++;

		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)2)); 
		sheet05.addMergedRegion(new Region(icnt,(short)3,icnt,(short)8)); 
		sheet05.addMergedRegion(new Region(icnt,(short)9,icnt,(short)12)); 

		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x300); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style07);
		cell0000.setCellValue("내용");

		cell0000 = row00.createCell((short)1);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue(sngoods_all);

		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)5);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)9);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue("");

		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)12);
		cell0000.setCellStyle(style09);
		
		icnt++;

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		for (int s=0; s<13; s++)	{
			cell0000 = row00.createCell((short)s);
			cell0000.setCellStyle(style18);
		}

		icnt++;

		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)12)); 
		sheet05.addMergedRegion(new Region(icnt+1,(short)0,icnt+1,(short)12)); 
		sheet05.addMergedRegion(new Region(icnt+2,(short)0,icnt+2,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue(vdate + " (북 ⇒ 남)");

		icnt++;
		icnt++;

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue("2-1. 인적사항");

		icnt++;

		sheet05.addMergedRegion(new Region(icnt,(short)1,icnt,(short)2)); 
		sheet05.addMergedRegion(new Region(icnt,(short)6,icnt,(short)9)); 
		sheet05.addMergedRegion(new Region(icnt,(short)10,icnt,(short)11)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x260); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style19);
		cell0000.setCellValue("순번");

		cell0000 = row00.createCell((short)1);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("소속");

		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("직책");

		cell0000 = row00.createCell((short)4);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("성명");

		cell0000 = row00.createCell((short)5);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("성별");

		cell0000 = row00.createCell((short)6);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("생년월일");

		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)9);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)10);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("주소");

		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)12);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style21);
		cell0000.setCellValue("출경일");

		icnt++;

		int h_cnt = icnt;
		for (int x=0; x<i_cnt; x++) {
			sheet05.addMergedRegion(new Region(h_cnt,(short)1,h_cnt,(short)2)); 
			sheet05.addMergedRegion(new Region(h_cnt,(short)6,h_cnt,(short)9)); 
			sheet05.addMergedRegion(new Region(h_cnt,(short)10,h_cnt,(short)11)); 
			h_cnt++;
		}

		sqlSheet5 = "";
		sqlSheet5 = " SELECT C.MINORNM COMPNM, A.JOB_DUTY POSITION, B.PSN_KNAME, \n"
				      + "        CASE WHEN A.GENDER = 'M' THEN '남' ELSE '여' END GENDER, \n"
				      + "        CASE WHEN A.PRSN_REGNO != '' THEN SUBSTR(A.PRSN_REGNO,1,2)||'.'|| SUBSTR(A.PRSN_REGNO,3,2)||'.'|| SUBSTR(A.PRSN_REGNO,5,2) ELSE '' END REG_NO, \n"
				      + "        B.ADDRESS1, \n"
				      + "        CASE WHEN A.START_DATE !='' THEN SUBSTR(A.START_DATE,3,2)||'.'||SUBSTR(A.START_DATE,5,2)||'.'||SUBSTR(A.START_DATE,7,2) ELSE '' END START_DATE \n"
				      + "   FROM TRANSFER.LTPSRNACC A \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTPERSON B ON A.PERSON_NO = B.PERSON_NO \n"
				      + "        LEFT OUTER JOIN TRANSFER.LTLCODE C ON A.PRSN_CMPY = C.MINORCD AND C.MAJORCD = '0015' \n"
				      + "  WHERE A.ACCSECTION = 'I' \n"
				      + "    AND A.ACCESSNO = '" + gstr1 + "' \n";

		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet5);

			ipos = 1;
			while(rs.next()) {

				//Cell 생성
				row00 = sheet05.createRow(icnt);
				row00.setHeight ((short) 0x260); // row 높이 설정

				cell0000 = row00.createCell((short)0);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style07);
				cell0000.setCellValue(ipos);

				cell0000 = row00.createCell((short)1);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(1));

				cell0000 = row00.createCell((short)2);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)3);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(2));

				cell0000 = row00.createCell((short)4);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(3));

				cell0000 = row00.createCell((short)5);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(4));

				cell0000 = row00.createCell((short)6);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(5));

				cell0000 = row00.createCell((short)7);
				cell0000.setCellStyle(style08);
				cell0000 = row00.createCell((short)8);
				cell0000.setCellStyle(style08);
				cell0000 = row00.createCell((short)9);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)10);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(6));

				cell0000 = row00.createCell((short)11);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)12);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style09);
				cell0000.setCellValue(rs.getString(7));
				
				icnt++;
				ipos++;
			}

			//Cell 생성
			row00 = sheet05.createRow(icnt);
			for (int s=0; s<13; s++)	{
				cell0000 = row00.createCell((short)s);
				cell0000.setCellStyle(style18);
			}

			icnt++;
			stmt = null;
			rs = null;
		}

		// 3.차량현황
		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue("3-1. 차량현황");

		icnt++;
		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt+1,(short)0)); 
		sheet05.addMergedRegion(new Region(icnt,(short)1,icnt+1,(short)2)); 
		sheet05.addMergedRegion(new Region(icnt,(short)3,icnt+1,(short)4)); 
		sheet05.addMergedRegion(new Region(icnt,(short)5,icnt,(short)10)); 
		sheet05.addMergedRegion(new Region(icnt,(short)11,icnt+1,(short)11)); 
		sheet05.addMergedRegion(new Region(icnt,(short)12,icnt+1,(short)12)); 
		sheet05.addMergedRegion(new Region(icnt+1,(short)5,icnt+1,(short)6)); 
		sheet05.addMergedRegion(new Region(icnt+1,(short)7,icnt+1,(short)10)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style19);
		cell0000.setCellValue("순번");

		cell0000 = row00.createCell((short)1);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("차종");

		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("차량번호");

		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)5);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("적재");

		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)9);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)11);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style20);
		cell0000.setCellValue("운전사");

		cell0000 = row00.createCell((short)12);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style21);
		cell0000.setCellValue("출경일");

		icnt++;

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setCellStyle(style24);
		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style23);
		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style23);

		cell0000 = row00.createCell((short)5);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue("인원");

		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)7);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue("화물");

		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)9);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style23);

		cell0000 = row00.createCell((short)12);
		cell0000.setCellStyle(style25);

		int c_cnt = icnt;
		c_cnt++;
		for (int x=0; x<i_cnt2; x++) {
			sheet05.addMergedRegion(new Region(c_cnt,(short)1,c_cnt,(short)2)); 
			sheet05.addMergedRegion(new Region(c_cnt,(short)3,c_cnt,(short)4)); 
			sheet05.addMergedRegion(new Region(c_cnt,(short)5,c_cnt,(short)6)); 
			sheet05.addMergedRegion(new Region(c_cnt,(short)7,c_cnt,(short)10)); 
			c_cnt++;
		}

		sqlSheet5 = "";
		sqlSheet5 = " SELECT C.CAR_NAME, A.CAR_NO, \n "
							+ "				 CASE WHEN D.CNT=0 THEN 0 ELSE D.CNT-1 END CNT, \n "
							+ "	       CASE WHEN RTRIM(A.RDS_GOODS)='' THEN '-' ELSE A.RDS_GOODS END RDS_GOODS, B.PSN_KNAME, \n "
							+ "       CASE WHEN A.START_DATE !='' THEN SUBSTR(A.START_DATE,5,2)||'.'||SUBSTR(A.START_DATE,7,2) ELSE '' END START_DATE \n "
							+ "   FROM TRANSFER.LTACCPLCAR A, \n "
							+ "        TRANSFER.LTPERSON B, \n "
							+ "        TRANSFER.LTCARTYPE C, \n "
							+ "        (SELECT ACCESSNO, CAR_NO, COUNT(*) CNT FROM TRANSFER.LTPSRNACC WHERE ACCSECTION = 'I' GROUP BY ACCESSNO, CAR_NO) D \n "
							+ "  WHERE A.ACCSECTION = 'I' \n "
							+ "    AND A.ACCESS_NO = '" + gstr1 + "' \n "
							+ "    AND A.PERSON_NO = B.PERSON_NO \n "
							+ "    AND A.CAR_TYPE = C.CAR_TYPE \n"
							+ "    AND A.ACCESS_NO = D.ACCESSNO \n"
							+ "    AND A.CAR_NO = D.CAR_NO \n";

		icnt++;
		ipos = 1;
		if (!gstr1.equals("")) {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet5);

			while(rs.next()) {

				//Cell 생성
				row00 = sheet05.createRow(icnt);
				row00.setHeight ((short) 0x160); // row 높이 설정

				cell0000 = row00.createCell((short)0);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style07);
				cell0000.setCellValue(ipos);

				cell0000 = row00.createCell((short)1);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(1));

				cell0000 = row00.createCell((short)2);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)3);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(2));

				cell0000 = row00.createCell((short)4);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)5);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(3));

				cell0000 = row00.createCell((short)6);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)7);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style22);
				cell0000.setCellValue(rs.getString(4));

				cell0000 = row00.createCell((short)8);
				cell0000.setCellStyle(style22);
				cell0000 = row00.createCell((short)9);
				cell0000.setCellStyle(style22);
				cell0000 = row00.createCell((short)10);
				cell0000.setCellStyle(style08);

				cell0000 = row00.createCell((short)11);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style08);
				cell0000.setCellValue(rs.getString(5));

				cell0000 = row00.createCell((short)12);
				cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0000.setCellStyle(style09);
				cell0000.setCellValue(rs.getString(6));

				icnt++;
				ipos++;

			}

			//Cell 생성
			row00 = sheet05.createRow(icnt);
			for (int s=0; s<13; s++)	{
				cell0000 = row00.createCell((short)s);
				cell0000.setCellStyle(style18);
			}

			icnt++;
			stmt = null;
			rs = null;

		}

		// 4.기타물품
		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x160); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style03);
		cell0000.setCellValue("4-1. 기타물품");

		icnt++;

		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)2)); 
		sheet05.addMergedRegion(new Region(icnt,(short)3,icnt,(short)8)); 
		sheet05.addMergedRegion(new Region(icnt,(short)9,icnt,(short)12)); 

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x200); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style19);
		cell0000.setCellValue("구분");

		cell0000 = row00.createCell((short)1);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("적재품");

		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)5);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style20);

		cell0000 = row00.createCell((short)9);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style18);
		cell0000.setCellValue("휴대품");

		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style18);
		cell0000 = row00.createCell((short)12);
		cell0000.setCellStyle(style21);

		icnt++;

		sheet05.addMergedRegion(new Region(icnt,(short)0,icnt,(short)2)); 
		sheet05.addMergedRegion(new Region(icnt,(short)3,icnt,(short)8)); 
		sheet05.addMergedRegion(new Region(icnt,(short)9,icnt,(short)12)); 

		row00 = sheet05.createRow(icnt);
		row00.setHeight ((short) 0x300); // row 높이 설정

		cell0000 = row00.createCell((short)0);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style07);
		cell0000.setCellValue("내용");

		cell0000 = row00.createCell((short)1);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)2);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)3);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue(nsgoods_all);

		cell0000 = row00.createCell((short)4);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)5);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)6);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)7);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)8);
		cell0000.setCellStyle(style08);

		cell0000 = row00.createCell((short)9);
		cell0000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0000.setCellStyle(style22);
		cell0000.setCellValue("");

		cell0000 = row00.createCell((short)10);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)11);
		cell0000.setCellStyle(style22);
		cell0000 = row00.createCell((short)12);
		cell0000.setCellStyle(style09);
		
		icnt++;

		//Cell 생성
		row00 = sheet05.createRow(icnt);
		for (int s=0; s<13; s++)	{
			cell0000 = row00.createCell((short)s);
			cell0000.setCellStyle(style18);
		}




		FileOutputStream fs = null;
		String realFileName = filepath+filename+"_"+sdate+".xls";

		fs = new FileOutputStream(realFileName);
		workbook.write(fs);

		if (fs != null) fs.close();

		File file = new File(realFileName);

		BufferedInputStream bytein = null;
		BufferedOutputStream byteos = null;
		try {
		 bytein = new BufferedInputStream(new FileInputStream(file));
		 byteos = new BufferedOutputStream(response.getOutputStream());

		 byte[] buf = new byte[(int)file.length()]; 
		 int read = 0;
		 while ((read = bytein.read(buf)) != -1) 
			byteos.write(buf,0,read);

		} catch (Exception sube) {
		 throw sube;
		} finally {
		 if (byteos != null) byteos.close();
		 if (bytein != null) bytein.close();
		}  


		//다운로드 후 삭제
		if(file.isFile()){
			file.delete();
		}


		if (stmt != null) stmt.close();
		if (rs != null) rs.close();

	} catch (Exception e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}    
	}   
}

 
