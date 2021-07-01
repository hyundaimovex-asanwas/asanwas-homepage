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

public class tr00101_s6 extends HttpServlet {
 
	public void doGet(HttpServletRequest request, HttpServletResponse response) {

	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String filepath = "\\Root\\HdAsan\\upload_file\\";
	String filename = "Packing List";

	String query = "";
	String vdate = "";
	String edate = "";

	String gorder_no	= request.getParameter("v_str1").trim();
	String sdate			= request.getParameter("v_str2").trim();
	String setd_date	= request.getParameter("v_str3").trim();
	String stype			= request.getParameter("v_str4").trim();

	if (gorder_no==null) gorder_no = "";
	if (sdate!=null && !sdate.equals(""))	vdate = Integer.parseInt(sdate.substring(4,6)) + "월" + sdate.substring(6,8) + "일";
	if (setd_date!=null && !setd_date.equals(""))	edate = setd_date.substring(0,4) + "년 " + Integer.parseInt(setd_date.substring(4,6)) + "월 " + setd_date.substring(6,8) + "일";
	if (stype==null && stype.equals(""))	stype = "A";
	
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

		sheet01.setColumnWidth((short)0,(short)1300);
		sheet01.setColumnWidth((short)1,(short)4000);
		sheet01.setColumnWidth((short)2,(short)4000);
		sheet01.setColumnWidth((short)3,(short)4000);
		sheet01.setColumnWidth((short)4,(short)4000);
		sheet01.setColumnWidth((short)5,(short)5000);
		sheet01.setColumnWidth((short)6,(short)6000);

		if (stype.equals("A")) sheet01.setColumnWidth((short)7,(short)0);
		else sheet01.setColumnWidth((short)7,(short)4000);

		sheet01.setColumnWidth((short)8,(short)3000);
		sheet01.setColumnWidth((short)9,(short)5000);
		sheet01.setColumnWidth((short)10,(short)4500);
		sheet01.setColumnWidth((short)11,(short)6000);
		sheet01.setColumnWidth((short)12,(short)3500);
		sheet01.setColumnWidth((short)13,(short)3500);
		sheet01.setColumnWidth((short)14,(short)3500);
		sheet01.setColumnWidth((short)15,(short)4000);
		sheet01.setColumnWidth((short)16,(short)5000);
		sheet01.setColumnWidth((short)17,(short)5000);
		sheet01.setColumnWidth((short)18,(short)5000);
		sheet01.setColumnWidth((short)19,(short)5000);
		sheet01.setColumnWidth((short)20,(short)5500);
		sheet01.setColumnWidth((short)21,(short)5500);

		if (stype.equals("A")) workbook.setSheetName(0 , "대북 반출 신청서" ,HSSFWorkbook.ENCODING_UTF_16);
		else workbook.setSheetName(0 , "대북 반입 신청서" ,HSSFWorkbook.ENCODING_UTF_16);

		////////////////////////////////////////////////////////////////////////////////////////
		//타이틀
		////////////////////////////////////////////////////////////////////////////////////////
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

		//Cell의 Font 설정
		HSSFFont font01 = workbook.createFont();
		font01.setFontHeightInPoints((short)17);
		font01.setFontName("굴림체");
		font01.setBoldweight(font01.BOLDWEIGHT_BOLD); 

		HSSFFont font02 = workbook.createFont();
		font02.setFontHeightInPoints((short)10);
		font02.setFontName("굴림체");

		HSSFFont font03 = workbook.createFont();
		font03.setFontHeightInPoints((short)10);
		font03.setFontName("굴림체");
		font03.setBoldweight(font03.BOLDWEIGHT_BOLD); 

		HSSFFont font04 = workbook.createFont();
		font04.setFontHeightInPoints((short)12);
		font04.setFontName("굴림체");
		font04.setBoldweight(font01.BOLDWEIGHT_BOLD); 

		HSSFFont font05 = workbook.createFont();
		font05.setFontHeightInPoints((short)8);
		font05.setFontName("굴림체");
		font05.setBoldweight(font01.BOLDWEIGHT_BOLD); 

		//Cell의 Align 속성
    style01.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style01.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

	  style02.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style02.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style02.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style02.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style02.setLeftBorderColor(HSSFColor.BLACK.index);
		style02.setTopBorderColor(HSSFColor.BLACK.index);
		style02.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style02.setBorderTop(HSSFCellStyle.BORDER_THIN);

	  style03.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style03.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style03.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style03.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style03.setTopBorderColor(HSSFColor.BLACK.index);
		style03.setBottomBorderColor(HSSFColor.BLACK.index);
		style03.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style03.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style04.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style04.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style04.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style04.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style04.setRightBorderColor(HSSFColor.BLACK.index);
		style04.setLeftBorderColor(HSSFColor.BLACK.index);
		style04.setTopBorderColor(HSSFColor.BLACK.index);
		style04.setBottomBorderColor(HSSFColor.BLACK.index);
		style04.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style04.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style04.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style04.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style05.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style05.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style05.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style05.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style05.setRightBorderColor(HSSFColor.BLACK.index);
		style05.setLeftBorderColor(HSSFColor.BLACK.index);
		style05.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style05.setBorderLeft(HSSFCellStyle.BORDER_THIN);

	  style06.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style06.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style06.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style06.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style06.setRightBorderColor(HSSFColor.BLACK.index);
		style06.setLeftBorderColor(HSSFColor.BLACK.index);
		style06.setBottomBorderColor(HSSFColor.BLACK.index);
		style06.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style06.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style06.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		style07.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style07.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style07.setLeftBorderColor(HSSFColor.BLACK.index);
		style07.setRightBorderColor(HSSFColor.BLACK.index);
		style07.setBottomBorderColor(HSSFColor.BLACK.index);
		style07.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style07.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style07.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style08.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style08.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style08.setRightBorderColor(HSSFColor.BLACK.index);
		style08.setLeftBorderColor(HSSFColor.BLACK.index);
		style08.setBottomBorderColor(HSSFColor.BLACK.index);
		style08.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style08.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style08.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style09.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style09.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

	  style10.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style10.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style10.setRightBorderColor(HSSFColor.BLACK.index);
		style10.setLeftBorderColor(HSSFColor.BLACK.index);
		style10.setBottomBorderColor(HSSFColor.BLACK.index);
		style10.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style10.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style10.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style11.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style11.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style11.setRightBorderColor(HSSFColor.BLACK.index);
		style11.setLeftBorderColor(HSSFColor.BLACK.index);
		style11.setBottomBorderColor(HSSFColor.BLACK.index);
		style11.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style11.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style11.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style11.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));

	  style12.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style12.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style12.setRightBorderColor(HSSFColor.BLACK.index);
		style12.setLeftBorderColor(HSSFColor.BLACK.index);
		style12.setBottomBorderColor(HSSFColor.BLACK.index);
		style12.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style12.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style12.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style12.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.000"));

	  style13.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style13.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style13.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style13.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style13.setRightBorderColor(HSSFColor.BLACK.index);
		style13.setLeftBorderColor(HSSFColor.BLACK.index);
		style13.setBottomBorderColor(HSSFColor.BLACK.index);
		style13.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style13.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style13.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style13.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));

	  style14.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style14.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style14.setRightBorderColor(HSSFColor.BLACK.index);
		style14.setLeftBorderColor(HSSFColor.BLACK.index);
		style14.setBottomBorderColor(HSSFColor.BLACK.index);
		style14.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style14.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style14.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style14.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.0"));

		style15.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style15.setFillForegroundColor(HSSFColor.BLACK.index);
		style15.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style15.setLeftBorderColor(HSSFColor.BLACK.index);
		style15.setTopBorderColor(HSSFColor.BLACK.index);
		style15.setBottomBorderColor(HSSFColor.BLACK.index);
		style15.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style15.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style15.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style16.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style16.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style16.setTopBorderColor(HSSFColor.BLACK.index);
		style16.setBottomBorderColor(HSSFColor.BLACK.index);
		style16.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style16.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style17.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style17.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style17.setTopBorderColor(HSSFColor.BLACK.index);
		style17.setRightBorderColor(HSSFColor.BLACK.index);
		style17.setBottomBorderColor(HSSFColor.BLACK.index);
		style17.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style17.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style17.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style18.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style18.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style18.setTopBorderColor(HSSFColor.BLACK.index);
		style18.setLeftBorderColor(HSSFColor.BLACK.index);
		style18.setRightBorderColor(HSSFColor.BLACK.index);
		style18.setBottomBorderColor(HSSFColor.BLACK.index);
		style18.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style18.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style18.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style18.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style19.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style19.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style19.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style19.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style19.setLeftBorderColor(HSSFColor.BLACK.index);
		style19.setTopBorderColor(HSSFColor.BLACK.index);
		style19.setBottomBorderColor(HSSFColor.BLACK.index);
		style19.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style19.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style19.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style20.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style20.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style20.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style20.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style20.setRightBorderColor(HSSFColor.BLACK.index);
		style20.setLeftBorderColor(HSSFColor.BLACK.index);
		style20.setBottomBorderColor(HSSFColor.BLACK.index);
		style20.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style20.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style20.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		//Cell Font
		style01.setFont(font01);
		style02.setFont(font03);
		style03.setFont(font03);
		style04.setFont(font03);
		style05.setFont(font03);
		style06.setFont(font03);
		style07.setFont(font02);
		style08.setFont(font02);
		style09.setFont(font03);
		style10.setFont(font02);
		style11.setFont(font02);
		style12.setFont(font02);
		style13.setFont(font02);
		style14.setFont(font02);
		style18.setFont(font03);
		style19.setFont(font03);
		style20.setFont(font05);
		
		//Cell 병합 
		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet01.addMergedRegion(new Region(0,(short)5,0,(short)8)); 
		sheet01.addMergedRegion(new Region(2,(short)6,2,(short)8)); 
		sheet01.addMergedRegion(new Region(3,(short)6,3,(short)8)); 
		sheet01.addMergedRegion(new Region(4,(short)6,4,(short)8)); 

		sheet01.addMergedRegion(new Region(6,(short)12,6,(short)14)); 

		sheet01.addMergedRegion(new Region(6,(short)0,7,(short)0)); 

		for (int k=3; k<12; k++ ) sheet01.addMergedRegion(new Region(6,(short)k,7,(short)k)); 

		sheet01.addMergedRegion(new Region(6,(short)15,7,(short)15)); 
		sheet01.addMergedRegion(new Region(6,(short)16,7,(short)16)); 
		sheet01.addMergedRegion(new Region(6,(short)17,7,(short)17)); 
		sheet01.addMergedRegion(new Region(6,(short)20,7,(short)20)); 
		sheet01.addMergedRegion(new Region(6,(short)21,7,(short)21)); 

		///////////////////////////////////////////////////////////////////////////////////////////////
		// 1st Sheet ( 화물 인수증 )
		///////////////////////////////////////////////////////////////////////////////////////////////

		//Cell 생성
		HSSFRow row00 = sheet01.createRow(0);
		row00.setHeight ((short) 0x260); // row 높이 설정

		HSSFCell cell00 = row00.createCell((short)5);
		cell00.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell00.setCellStyle(style01);
		cell00.setCellValue("대북 반입신청서");

		HSSFRow row01 = sheet01.createRow(1);
		row01.setHeight ((short) 0x200); // row 높이 설정

		HSSFRow row02 = sheet01.createRow(2);
		row02.setHeight ((short) 0x200); // row 높이 설정

		HSSFCell cell0200 = row02.createCell((short)5);
		cell0200.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0200.setCellStyle(style18);
		cell0200.setCellValue("신청업체");

		cell0200 = row02.createCell((short)6);
		cell0200.setCellStyle(style16);
		cell0200 = row02.createCell((short)7);
		cell0200.setCellStyle(style16);
		cell0200 = row02.createCell((short)8);
		cell0200.setCellStyle(style17);

		HSSFRow row03 = sheet01.createRow(3);
		row03.setHeight ((short) 0x200); // row 높이 설정

		HSSFCell cell0300 = row03.createCell((short)5);
		cell0300.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0300.setCellStyle(style18);
		cell0300.setCellValue("담당자/전화번호");

		cell0300 = row03.createCell((short)6);
		cell0300.setCellStyle(style16);
		cell0300 = row03.createCell((short)7);
		cell0300.setCellStyle(style16);
		cell0300 = row03.createCell((short)8);
		cell0300.setCellStyle(style17);

		HSSFRow row04 = sheet01.createRow(4);
		row04.setHeight ((short) 0x200); // row 높이 설정

		HSSFCell cell0400 = row04.createCell((short)5);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style18);
		cell0400.setCellValue("반입일자");

		cell0400 = row04.createCell((short)6);
		cell0400.setCellStyle(style16);
		cell0400 = row04.createCell((short)7);
		cell0400.setCellStyle(style16);
		cell0400 = row04.createCell((short)8);
		cell0400.setCellStyle(style17);

		HSSFRow row06 = sheet01.createRow(6);
		row06.setHeight ((short) 0x260); // row 높이 설정

		cell0400 = row06.createCell((short)0);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("NO");

		cell0400 = row06.createCell((short)1);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("상차지");

		cell0400 = row06.createCell((short)2);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("하차지");

		cell0400 = row06.createCell((short)3);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("영문명");

		cell0400 = row06.createCell((short)4);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("HS CODE");

		cell0400 = row06.createCell((short)5);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("품명");

		cell0400 = row06.createCell((short)6);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("규격\n(건설기계\n:차대번호 기재)");

		cell0400 = row06.createCell((short)7);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("반출일자\n(필수항목)");

		cell0400 = row06.createCell((short)8);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("수량\n단위");

		cell0400 = row06.createCell((short)9);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("수량");

		cell0400 = row06.createCell((short)10);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("단위포장별\n수량");

		cell0400 = row06.createCell((short)11);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("단위포장별\n무게(KG)");

		cell0400 = row06.createCell((short)12);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style19);
		cell0400.setCellValue("단위포장별(Pallet 등)\n용적 Size");

		cell0400 = row06.createCell((short)13);
		cell0400.setCellStyle(style03);
		cell0400 = row06.createCell((short)14);
		cell0400.setCellStyle(style04);

		cell0400 = row06.createCell((short)15);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("단가\n(원)");

		cell0400 = row06.createCell((short)16);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("금액\n(원)");

		cell0400 = row06.createCell((short)17);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("비고\n(차량:\n차량넘버기재)");

		cell0400 = row06.createCell((short)18);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("단위포장별\n용적");

		cell0400 = row06.createCell((short)19);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("단위포장별\n총수량");

		cell0400 = row06.createCell((short)20);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style02);
		cell0400.setCellValue("총용적\n(CBM)");

		cell0400 = row06.createCell((short)21);
		cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0400.setCellStyle(style04);
		cell0400.setCellValue("총무게\n(KG)");

		HSSFRow row07 = sheet01.createRow(7);
		row07.setHeight ((short) 0x220); // row 높이 설정

		for (int k=0; k<22; k++)	{
			cell0400 = row07.createCell((short)k);
			cell0400.setCellStyle(style06);

			if (k==1) {
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellValue("예) 개성공단\n근로자숙소현장");
				cell0400.setCellStyle(style20);
			} else if (k==2) {
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellValue("예) 파주물류센타\n예) 인천 검단");
				cell0400.setCellStyle(style20);
			} else if (k==12) {
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellValue("길이\n(CM)");
			} else if (k==13) {
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellValue("폭\n(CM)");
			} else if (k==14) {
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellValue("높이\n(CM)");
			} else if (k==18) {
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellValue("(길이*폭*높이\n: CBM)");
				cell0400.setCellStyle(style20);
			} else if (k==19) {
				cell0400.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell0400.setCellValue("(수량/\n단위포장별 수량)");
				cell0400.setCellStyle(style20);
			}
		}

		String sqlSheet = "";
		sqlSheet = " SELECT IFNULL(A.ENG_ARTCNM,'') ENG_ARTCNM, A.ARTC_NM, RTRIM(A.STN_SZNM) STN_SZNM, RTRIM(B.MINORNM) MINORNM, A.ARTC_CNT, A.UNIT_PRICE, A.PRICE, \n"
						 + "        A.PUNIT_CNT, A.PUNIT_WGHT, A.PKG_LNGTH, A.PKG_HEIGHT, A.PKG_WIDTH, \n"
						 + "        ROUND(A.PKG_LNGTH*A.PKG_HEIGHT*A.PKG_WIDTH/1000000,3) CBM, \n"
						 + "        ROUND(A.ARTC_CNT/A.PUNIT_CNT,2) P_CNT, \n"
						 + "        ROUND(ROUND(A.ARTC_CNT/A.PUNIT_CNT,1)*PKG_CBM,1) TOT_CBM, \n"
						 + "        ROUND(A.ARTC_CNT/A.PUNIT_CNT*A.PUNIT_WGHT,0) TOT_WGHT, A.CANCLE_STS \n"
						 + "   FROM TRANSFER.LTORDERDTL A, \n"
						 + "        TRANSFER.LTLCODE B \n"
						 + "  WHERE A.ORDER_NO = '" + gorder_no + "' \n"
						 + "    AND A.ARTC_UNIT = B.MINORCD \n"
						 + "    AND B.MAJORCD = '0008' ";

		int row = 8;
		int s_cnt = 0;
		int s_price = 0;
		double d_tcnt = 0.0;
		double d_tcbm = 0.0;
		double d_tkg = 0.0;
		int icnt = 1;

		row07 = null;

		HSSFCell cell1000 = null;

		if (!gorder_no.equals("")) {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet);

			while(rs.next()) {

				row07 = sheet01.createRow(row);
				row07.setHeight ((short) 0x160); // row 높이 설정

				cell1000 = row07.createCell((short)0);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style08);
				cell1000.setCellValue(icnt);

				cell1000 = row07.createCell((short)1);
				cell1000.setCellStyle(style08);
				cell1000 = row07.createCell((short)2);
				cell1000.setCellStyle(style08);

				cell1000 = row07.createCell((short)3);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style10);
				cell1000.setCellValue(rs.getString(1));

				cell1000 = row07.createCell((short)4);
				cell1000.setCellStyle(style08);

				cell1000 = row07.createCell((short)5);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style10);
				cell1000.setCellValue(rs.getString(2));

				cell1000 = row07.createCell((short)6);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style08);
				cell1000.setCellValue(rs.getString(3));

				cell1000 = row07.createCell((short)7);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style08);
				cell1000.setCellValue(rs.getString(17));

				cell1000 = row07.createCell((short)8);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style08);
				cell1000.setCellValue(rs.getString(4));

				cell1000 = row07.createCell((short)8);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style10);
				cell1000.setCellValue(rs.getString(4));

				cell1000 = row07.createCell((short)9);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(5));

				cell1000 = row07.createCell((short)10);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(8));

				cell1000 = row07.createCell((short)11);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(9));

				cell1000 = row07.createCell((short)12);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(10));

				cell1000 = row07.createCell((short)13);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(11));

				cell1000 = row07.createCell((short)14);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(12));

				cell1000 = row07.createCell((short)15);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(6));

				cell1000 = row07.createCell((short)16);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(rs.getInt(7));

				cell1000 = row07.createCell((short)17);
				cell1000.setCellStyle(style11);

				cell1000 = row07.createCell((short)18);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style13);
				cell1000.setCellValue(rs.getDouble(13));

				cell1000 = row07.createCell((short)19);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style13);
				cell1000.setCellValue(rs.getDouble(14));

				cell1000 = row07.createCell((short)20);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style13);
				cell1000.setCellValue(rs.getDouble(15));

				cell1000 = row07.createCell((short)21);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style13);
				cell1000.setCellValue(rs.getDouble(16));

				s_cnt = s_cnt + rs.getInt(5);
				s_price = s_price + rs.getInt(8);
				d_tcnt = d_tcnt + rs.getDouble(14);
				d_tcbm = d_tcbm + rs.getDouble(15);
				d_tkg = d_tkg + rs.getDouble(16);

				icnt++;
				row++;
			}

			stmt = null;
			rs = null;
		}

		for (int s=0; s<5; s++)	{
			row07 = sheet01.createRow(row);
			row07.setHeight ((short) 0x160); // row 높이 설정

			for (int k=0; k<22 ; k++)	{
				cell1000 = row07.createCell((short)k);
				cell1000.setCellStyle(style08);

				if (k==0) cell1000.setCellValue(icnt);
				else if (k>17) cell1000.setCellStyle(style13);

			}

			icnt++;
			row++;
		}

		row07 = sheet01.createRow(row);
		row07.setHeight ((short) 0x160); // row 높이 설정

		for (int k=0; k<22 ; k++)	{
			cell1000 = row07.createCell((short)k);
			cell1000.setCellStyle(style08);

			if (k==0) {
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellValue("합계");
			} else if (k==9) {
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(s_cnt);
			} else if (k==16) {
				cell1000.setCellStyle(style11);
				cell1000.setCellValue(s_price);
			} else if (k==19) {
				cell1000.setCellStyle(style13);
				cell1000.setCellValue(d_tcnt);
			} else if (k==20) {
				cell1000.setCellStyle(style13);
				cell1000.setCellValue(d_tcbm);
			} else if (k==21) {
				cell1000.setCellStyle(style13);
				cell1000.setCellValue(d_tkg);
			} else cell1000.setCellStyle(style15);
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

 
