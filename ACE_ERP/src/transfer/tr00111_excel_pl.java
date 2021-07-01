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
import java.util.*;

public class tr00111_excel_pl extends HttpServlet {
 
	public void doGet(HttpServletRequest request, HttpServletResponse response) {

	Connection conn = null;
	PreparedStatement stmt = null;

	String filepath = "\\Root\\HdAsan\\upload_file\\";
	String filename = "Packing_List";

	String query = "";

	String gstr1 = request.getParameter("v_str1").trim();
	String sdate = request.getParameter("v_str2").trim();

	try {

		Class.forName("com.ibm.as400.access.AS400JDBCDriver");
		conn = DriverManager.getConnection("jdbc:as400:203.242.32.198;user=QPILOT;password=PILOT");
		//conn = DriverManager.getConnection("jdbc:as400:203.242.32.199;user=QPILOT;password=PILOT");

		String client = request.getHeader("User-Agent");
    if (client.indexOf("MSIE 5.5") != -1) {
        response.setHeader("Content-Type", "doesn/matter;charset=8859_1");
        response.setHeader("Content-Disposition", "filename="+filename+"_"+sdate+".xls;");
    } else {
			String ss = filename+"_"+sdate+".xls";

			response.setContentType("application/octet-stream"); 
			response.setHeader("Content-Disposition", "attachment;filename="+new String(ss.getBytes("euc-kr"),"8859_1"));
    }

		query = " SELECT A.PL_NO, A.IN_OUT, A.PL_SHIPPER, A.PL_SHPPRNM, A.PL_SHPADD1, " +
					  "				 A.PL_SHPADD2, A.PL_SHPADD3, A.PL_SHPTEL, A.PL_CSTM, A.PL_CSTMNM, " +
					  "				 A.PL_CSTADD1, A.PL_CSTADD2, A.PL_CSTADD3, A.PL_CSTTEL, A.PL_BRKR, " +
					  "				 A.PL_BRKRNM, A.PL_BRKADD1, A.PL_BRKADD2, A.PL_BRKADD3, A.PL_BRKTEL, " +
					  "				 '' AS PL_NOTICE, '' AS PLNOTICENM, A.START_LCT, A.REACH_LCT, A.TRANS_CAR, " +
					  "				 A.START_DT, A.INVOICE_NO, A.INVOICE_DT, A.REMARK, A.LCNO, " +
					  "				 A.LCDATE, A.LCBANK, A.WEIGHT, A.T_WEIGHT, A.T_CBM, " +
					  "				 A.GORDER_NO, A.PACKING_CNT, A.PACKING_UNIT, A.PACKING_CBM, A.TELEPHONE, " +
					  "				 A.RPR_GOODS, A.CARGO_TYPE, A.DNG_TYPE, A.CAR_TYPE, A.ORDER_NO, " +
					  "				 A.DCL_DATE, A.DCL_NO, A.CURRENCY, A.CREATE_DT, A.CREATE_USR, " +
						"				 A.UPDATE_DT, A.UPDATE_USR, A.START_TIME, IFNULL(A.LINE_PART,'') AS LINE_PART, B.MINORNM," +
						"				 C.MINORNM " +
					  "		FROM TRANSFER.LTPCKLSCI A, " +
						"				 (SELECT MINORCD, MINORNM FROM TRANSFER.LTLCODE WHERE MAJORCD = '0007') B, " +
						"				 (SELECT MINORCD, MINORNM FROM TRANSFER.LTLCODE WHERE MAJORCD = '0007') C " +
					  "  WHERE A.PL_NO IS NOT NULL " +
						"		 AND A.START_LCT = B.MINORCD " +
						"		 AND A.REACH_LCT = C.MINORCD " +
						"		 AND A.PL_NO = '" + gstr1 + "'";

		stmt = conn.prepareStatement(query);
		ResultSet rs = stmt.executeQuery();

		String[] rst = new String[56];
		
		while(rs.next()) {
			for (int s=0; s<rst.length; s++) {
				rst[s] = rs.getString(s+1);
			}
		}

		
		HSSFWorkbook workbook = new HSSFWorkbook();

		HSSFSheet sheet = workbook.createSheet();

		//cell width 설정
		sheet.setColumnWidth((short)0,(short)7000);
		sheet.setColumnWidth((short)1,(short)7000);
		sheet.setColumnWidth((short)2,(short)4000);
		sheet.setColumnWidth((short)3,(short)4000);
		sheet.setColumnWidth((short)4,(short)4000);
		sheet.setColumnWidth((short)5,(short)4000);

		workbook.setSheetName(0 , "Packing List" ,HSSFWorkbook.ENCODING_UTF_16);

		////////////////////////////////////////////////////////////////////////////////////////
		//타이틀
		////////////////////////////////////////////////////////////////////////////////////////
		HSSFCellStyle style01 = workbook.createCellStyle();
		HSSFCellStyle style02 = workbook.createCellStyle();

		//Cell의 Font 설정
		HSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short)20);
		font.setFontName("굴림");
		//font.setItalic(true);
		//font.setStrikeout(true);

		HSSFFont font01 = workbook.createFont();
		font01.setFontHeightInPoints((short)10);
		font01.setFontName("굴림");

		//Cell의 Align 속성
    style01.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style01.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style02.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style02.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		//Cell 병합 
		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(0,(short)0,0,(short)5)); 

		//Cell Font
		style01.setFont(font);
		style02.setFont(font);

		//Cell 생성
		HSSFRow row00 = sheet.createRow(0);
		row00.setHeight ((short) 0x360); // row 높이 설정

		HSSFCell cell00 = row00.createCell((short)0);
		cell00.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell00.setCellStyle(style01);
		cell00.setCellValue("PACKING LIST");

		//left-0 , top-0 , right-0 , bottom-0
		HSSFCellStyle style0000 = workbook.createCellStyle();
		style0000.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		//left-0 , top-1 , right-0 , bottom-0
		HSSFCellStyle style0100 = workbook.createCellStyle();
		style0100.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style0100.setTopBorderColor(HSSFColor.BLACK.index);
		style0100.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		//left-0 , top-1 , right-1 , bottom-0
		HSSFCellStyle style0110 = workbook.createCellStyle();
		style0110.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style0110.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style0110.setRightBorderColor(HSSFColor.BLACK.index);
		style0110.setTopBorderColor(HSSFColor.BLACK.index);
		style0110.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		//left-1 , top-1 , right-0 , bottom-0
		HSSFCellStyle style1100 = workbook.createCellStyle();
		style1100.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style1100.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style1100.setLeftBorderColor(HSSFColor.BLACK.index);
		style1100.setTopBorderColor(HSSFColor.BLACK.index);
		style1100.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		//left-1 , top-0 , right-0 , bottom-0
		HSSFCellStyle style1000 = workbook.createCellStyle();
		style1000.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style1000.setLeftBorderColor(HSSFColor.BLACK.index);
		style1000.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		//left-0 , top-0 , right-0 , bottom-1
		HSSFCellStyle style0001 = workbook.createCellStyle();
		style0001.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style0001.setBottomBorderColor(HSSFColor.BLACK.index);
		style0001.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		/**************************************************************
			ALIGN RIGHT
		**************************************************************/
		//left-0 , top-0 , right-1 , bottom-0
		HSSFCellStyle style0010_r = workbook.createCellStyle();
		style0010_r.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style0010_r.setRightBorderColor(HSSFColor.BLACK.index);
		style0010_r.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
    style0010_r.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		//left-0 , top-0 , right-0 , bottom-0
		HSSFCellStyle style0000_r = workbook.createCellStyle();
		style0000_r.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
    style0000_r.setAlignment(HSSFCellStyle.ALIGN_RIGHT);

		//left-1 , top-1 , right-0 , bottom-0
		HSSFCellStyle style1100_r = workbook.createCellStyle();
		style1100_r.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style1100_r.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style1100_r.setLeftBorderColor(HSSFColor.BLACK.index);
		style1100_r.setTopBorderColor(HSSFColor.BLACK.index);
    style1100_r.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style1100_r.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		//left-1 , top-0 , right-0 , bottom-0
		HSSFCellStyle style1000_r = workbook.createCellStyle();
		style1000_r.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style1000_r.setLeftBorderColor(HSSFColor.BLACK.index);
		style1000_r.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		/**************************************************************
			ALIGN CENTER
		**************************************************************/
		//left-0 , top-0 , right-0 , bottom-0
		HSSFCellStyle style0000_c = workbook.createCellStyle();
		style0000_c.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
    style0000_c.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		//left-1 , top-1 , right-0 , bottom-0
		HSSFCellStyle style1100_c = workbook.createCellStyle();
		style1100_c.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style1100_c.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style1100_c.setLeftBorderColor(HSSFColor.BLACK.index);
		style1100_c.setTopBorderColor(HSSFColor.BLACK.index);
		style1100_c.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
    style1100_c.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		//left-1 , top-0 , right-0 , bottom-0
		HSSFCellStyle style1000_c = workbook.createCellStyle();
		style1000_c.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style1000_c.setLeftBorderColor(HSSFColor.BLACK.index);
		style1000_c.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
    style1000_c.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		HSSFRow row01 = sheet.createRow(1);
		row01.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell01 = null;

		cell01 = row01.createCell((short)0);
		cell01.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell01.setCellStyle(style0100);
		cell01.setCellValue("1.송하인/수출자");

		cell01 = row01.createCell((short)1);
		cell01.setCellStyle(style0100);

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(1,(short)2,0,(short)5)); 

		cell01 = row01.createCell((short)2);
		cell01.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell01.setCellStyle(style1100);
		cell01.setCellValue("8.송장번호 및 일자");

		cell01 = row01.createCell((short)3);
		cell01.setCellStyle(style0100);
		cell01 = row01.createCell((short)4);
		cell01.setCellStyle(style0100);
		cell01 = row01.createCell((short)5);
		cell01.setCellStyle(style0100);

		HSSFRow row02 = sheet.createRow(2);
		row02.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell02 = null;

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(2,(short)0,2,(short)1)); 
		sheet.addMergedRegion(new Region(2,(short)2,2,(short)3)); 
		sheet.addMergedRegion(new Region(2,(short)4,2,(short)5)); 

		cell02 = row02.createCell((short)0);
		cell02.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell02.setCellStyle(style0000);
		cell02.setCellValue(rst[3]);

		cell02 = row02.createCell((short)2);
		cell02.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell02.setCellStyle(style1000);
		cell02.setCellValue(rst[46]);
		cell02 = row02.createCell((short)4);
		cell02.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell02.setCellStyle(style0000_r);
		cell02.setCellValue(rst[45]);

		HSSFRow row03 = sheet.createRow(3);
		row03.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell03 = null;

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(3,(short)2,3,(short)5)); 
		sheet.addMergedRegion(new Region(3,(short)0,3,(short)1)); 

		cell03 = row03.createCell((short)0);
		cell03.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell03.setCellStyle(style0000);
		cell03.setCellValue(rst[4]);

		cell03 = row03.createCell((short)2);
		cell03.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell03.setCellStyle(style1100);
		cell03.setCellValue("9.비고");

		cell03 = row03.createCell((short)3);
		cell03.setCellStyle(style0100);
		cell03 = row03.createCell((short)4);
		cell03.setCellStyle(style0100);
		cell03 = row03.createCell((short)5);
		cell03.setCellStyle(style0100);

		HSSFRow row04 = sheet.createRow(4);
		row04.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell04 = null;

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(4,(short)2,22,(short)5)); 
		sheet.addMergedRegion(new Region(4,(short)0,4,(short)1)); 

		cell04 = row04.createCell((short)0);
		cell04.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell04.setCellStyle(style0000);
		cell04.setCellValue(rst[5]);

		cell04 = row04.createCell((short)2);
		cell04.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell04.setCellStyle(style1000);
		cell04.setCellValue(rst[28]);

		HSSFRow row05 = sheet.createRow(5);
		row05.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell05 = null;

		sheet.addMergedRegion(new Region(5,(short)0,5,(short)1)); 

		cell05 = row05.createCell((short)0);
		cell05.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell05.setCellStyle(style0000);
		cell05.setCellValue(rst[6]);

		cell05 = row05.createCell((short)2);
		cell05.setCellStyle(style1000);

		HSSFRow row06 = sheet.createRow(6);
		row06.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell06 = null;

		sheet.addMergedRegion(new Region(6,(short)0,6,(short)1)); 

		cell06 = row06.createCell((short)0);
		cell06.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell06.setCellStyle(style0000);
		cell06.setCellValue(rst[7]);

		cell06 = row06.createCell((short)2);
		cell06.setCellStyle(style1000);

		HSSFRow row07 = sheet.createRow(7);
		row07.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell07 = null;

		cell07 = row07.createCell((short)0);
		cell07.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell07.setCellStyle(style0100);
		cell07.setCellValue("2.수하인");

		cell07 = row07.createCell((short)1);
		cell07.setCellStyle(style0100);

		cell07 = row07.createCell((short)2);
		cell07.setCellStyle(style1000);

		HSSFRow row08 = sheet.createRow(8);
		row08.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell08 = null;

		sheet.addMergedRegion(new Region(8,(short)0,8,(short)1)); 

		cell08 = row08.createCell((short)0);
		cell08.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell08.setCellStyle(style0000);
		cell08.setCellValue(rst[9]);

		cell08 = row08.createCell((short)2);
		cell08.setCellStyle(style1000);

		HSSFRow row09 = sheet.createRow(9);
		row09.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell09 = null;

		sheet.addMergedRegion(new Region(9,(short)0,9,(short)1)); 

		cell09 = row09.createCell((short)0);
		cell09.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell09.setCellStyle(style0000);
		cell09.setCellValue(rst[10]);

		cell09 = row09.createCell((short)2);
		cell09.setCellStyle(style1000);

		HSSFRow row10 = sheet.createRow(10);
		row10.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell10 = null;

		sheet.addMergedRegion(new Region(10,(short)0,10,(short)1)); 

		cell10 = row10.createCell((short)0);
		cell10.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell10.setCellStyle(style0000);
		cell10.setCellValue(rst[11]);

		cell10 = row10.createCell((short)2);
		cell10.setCellStyle(style1000);

		HSSFRow row11 = sheet.createRow(11);
		row11.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell11 = null;

		sheet.addMergedRegion(new Region(11,(short)0,11,(short)1)); 

		cell11 = row11.createCell((short)0);
		cell11.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell11.setCellStyle(style0000);
		cell11.setCellValue(rst[12]);

		cell11 = row11.createCell((short)2);
		cell11.setCellStyle(style1000);

		HSSFRow row12 = sheet.createRow(12);
		row12.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell12 = null;

		sheet.addMergedRegion(new Region(12,(short)0,12,(short)1)); 

		cell12 = row12.createCell((short)0);
		cell12.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell12.setCellStyle(style0000);
		cell12.setCellValue(rst[13]);

		cell12 = row12.createCell((short)0);
		cell12.setCellStyle(style0001);
		cell12 = row12.createCell((short)1);
		cell12.setCellStyle(style0001);

		cell12 = row12.createCell((short)2);
		cell12.setCellStyle(style1000);

		HSSFRow row13 = sheet.createRow(13);
		row13.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell13 = null;

		cell13 = row13.createCell((short)0);
		cell13.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell13.setCellStyle(style0100);
		cell13.setCellValue("3.통지선");

		cell13 = row13.createCell((short)1);
		cell13.setCellStyle(style0100);

		cell13 = row13.createCell((short)2);
		cell13.setCellStyle(style1000);

		HSSFRow row14 = sheet.createRow(14);
		row14.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell14 = null;

		sheet.addMergedRegion(new Region(14,(short)0,14,(short)1)); 

		cell14 = row14.createCell((short)0);
		cell14.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell14.setCellStyle(style0000);
		cell14.setCellValue(rst[15]);

		cell14 = row14.createCell((short)2);
		cell14.setCellStyle(style1000);

		HSSFRow row15 = sheet.createRow(15);
		row15.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell15 = null;

		sheet.addMergedRegion(new Region(15,(short)0,15,(short)1)); 

		cell15 = row15.createCell((short)0);
		cell15.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell15.setCellStyle(style0000);
		cell15.setCellValue(rst[16]);

		cell15 = row15.createCell((short)2);
		cell15.setCellStyle(style1000);

		HSSFRow row16 = sheet.createRow(16);
		row16.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell16 = null;

		sheet.addMergedRegion(new Region(16,(short)0,16,(short)1)); 

		cell16 = row16.createCell((short)0);
		cell16.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell16.setCellStyle(style0000);
		cell16.setCellValue(rst[17]);

		cell16 = row16.createCell((short)2);
		cell16.setCellStyle(style1000);

		HSSFRow row17 = sheet.createRow(17);
		row17.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell17 = null;

		sheet.addMergedRegion(new Region(17,(short)0,17,(short)1)); 

		cell17 = row17.createCell((short)0);
		cell17.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell17.setCellStyle(style0000);
		cell17.setCellValue(rst[18]);

		cell17 = row17.createCell((short)2);
		cell17.setCellStyle(style1000);

		HSSFRow row18 = sheet.createRow(18);
		row18.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell18 = null;

		sheet.addMergedRegion(new Region(18,(short)0,18,(short)1)); 

		cell18 = row18.createCell((short)0);
		cell18.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell18.setCellStyle(style0000);
		cell18.setCellValue(rst[19]);

		cell18 = row18.createCell((short)0);
		cell18.setCellStyle(style0001);
		cell18 = row18.createCell((short)1);
		cell18.setCellStyle(style0001);

		cell18 = row18.createCell((short)2);
		cell18.setCellStyle(style1000);

		HSSFRow row19 = sheet.createRow(19);
		row19.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell19 = null;

		cell19 = row19.createCell((short)0);
		cell19.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell19.setCellStyle(style0110);
		cell19.setCellValue("4.출발지");

		cell19 = row19.createCell((short)1);
		cell19.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell19.setCellStyle(style0110);
		cell19.setCellValue("5.목적지");

		cell19 = row19.createCell((short)2);
		cell19.setCellStyle(style1000);

		HSSFRow row20 = sheet.createRow(20);
		row20.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell20 = null;

		cell20 = row20.createCell((short)0);
		cell20.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell20.setCellStyle(style0010_r);
		cell20.setCellValue(rst[54]);

		cell20 = row20.createCell((short)1);
		cell20.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell20.setCellStyle(style0010_r);
		cell20.setCellValue(rst[55]);

		cell20 = row20.createCell((short)2);
		cell20.setCellStyle(style1000);

		HSSFRow row21 = sheet.createRow(21);
		row21.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell21 = null;

		cell21 = row21.createCell((short)0);
		cell21.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell21.setCellStyle(style0110);
		cell21.setCellValue("6.운송차량");

		cell21 = row21.createCell((short)1);
		cell21.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell21.setCellStyle(style0110);
		cell21.setCellValue("7.출발일");

		cell21 = row21.createCell((short)2);
		cell21.setCellStyle(style1000);

		HSSFRow row22 = sheet.createRow(22);
		row22.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell22 = null;

		cell22 = row22.createCell((short)0);
		cell22.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell22.setCellStyle(style0010_r);
		cell22.setCellValue(rst[24]);

		String strdate = rst[25];
		strdate = strdate.substring(0,4)+"."+strdate.substring(4,6)+"."+strdate.substring(6,8);

		cell22 = row22.createCell((short)1);
		cell22.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell22.setCellStyle(style0010_r);
		cell22.setCellValue(strdate);

		cell22 = row22.createCell((short)2);
		cell22.setCellStyle(style1000);

		HSSFRow row23 = sheet.createRow(23);
		row23.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell23 = null;

		cell23 = row23.createCell((short)0);
		cell23.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell23.setCellStyle(style0100);
		cell23.setCellValue("10.포장표식 및 포장수량");

		cell23 = row23.createCell((short)1);
		cell23.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell23.setCellStyle(style0100);
		cell23.setCellValue("11.품명");

		cell23 = row23.createCell((short)2);
		cell23.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell23.setCellStyle(style0100);
		cell23.setCellValue("12.수량/단위");

		cell23 = row23.createCell((short)3);
		cell23.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell23.setCellStyle(style0100);
		cell23.setCellValue("13.순중량(KG)");

		cell23 = row23.createCell((short)4);
		cell23.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell23.setCellStyle(style0100);
		cell23.setCellValue("14.총중량(KG)");

		cell23 = row23.createCell((short)5);
		cell23.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell23.setCellStyle(style0100);
		cell23.setCellValue("15.용적(CBM)");

		HSSFRow row25 = sheet.createRow(25);
		row25.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell25 = null;

		float f36 = (Float.parseFloat(rst[36]));
		int int36 = (int) f36;

		cell25 = row25.createCell((short)0);
		cell25.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell25.setCellStyle(style0000_c);
		cell25.setCellValue(int36 + " " + rst[37]);

		cell25 = row25.createCell((short)1);
		cell25.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell25.setCellStyle(style0000_c);
		cell25.setCellValue(rst[40]);

		cell25 = row25.createCell((short)2);
		cell25.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell25.setCellStyle(style0000_r);
		cell25.setCellValue("");

		float f32 = (Float.parseFloat(rst[32]));
		int int32 = (int) f32;

		cell25 = row25.createCell((short)3);
		cell25.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell25.setCellStyle(style0000_r);
		cell25.setCellValue(int32);

		float f33 = (Float.parseFloat(rst[33]));
		int int33 = (int) f33;

		cell25 = row25.createCell((short)4);
		cell25.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell25.setCellStyle(style0000_r);
		cell25.setCellValue(33);

		cell25 = row25.createCell((short)5);
		cell25.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell25.setCellStyle(style0000_r);
		cell25.setCellValue(rst[34]);

		HSSFRow row28 = sheet.createRow(28);
		row28.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell28 = null;

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(28,(short)0,28,(short)5)); 

		cell28 = row28.createCell((short)0);
		cell28.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell28.setCellStyle(style0000_c);
		cell28.setCellValue("//////////////////////////////////////////////////////////////////////////////////////////");

		HSSFRow row30 = sheet.createRow(30);
		row30.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell30 = null;

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(30,(short)0,30,(short)5)); 

		cell30 = row30.createCell((short)0);
		cell30.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell30.setCellStyle(style0000_c);
		cell30.setCellValue("- 유첨 명세 참조");

		HSSFRow row50 = sheet.createRow(50);
		row50.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell50 = null;

		cell50 = row50.createCell((short)0);
		cell50.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell50.setCellStyle(style0000);
		cell50.setCellValue("16.연락처");

		cell50 = row50.createCell((short)1);
		cell50.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell50.setCellStyle(style0000);
		cell50.setCellValue(rst[39]);

		cell50 = row50.createCell((short)2);
		cell50.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell50.setCellStyle(style0000_r);
		cell50.setCellValue("17.서명");

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(50,(short)3,50,(short)5)); 

		cell50 = row50.createCell((short)3);
		cell50.setCellStyle(style0001);
		cell50 = row50.createCell((short)4);
		cell50.setCellStyle(style0001);
		cell50 = row50.createCell((short)5);
		cell50.setCellStyle(style0001);

		HSSFRow row51 = sheet.createRow(51);
		row51.setHeight ((short) 0x180); // row 높이 설정
		HSSFCell cell51 = null;

		for (int k=0; k<6; k++){
			cell51 = row51.createCell((short)k);
			cell51.setCellStyle(style0001);
		}

		query = "";
		rs = null;
		stmt = null;

		/**************************************************************
			Packing List Detail
		**************************************************************/
		sheet = workbook.createSheet();

		//cell width 설정
		sheet.setColumnWidth((short)0,(short)4000);
		sheet.setColumnWidth((short)1,(short)2000);
		sheet.setColumnWidth((short)2,(short)5000);
		sheet.setColumnWidth((short)3,(short)5000);
		sheet.setColumnWidth((short)4,(short)2000);
		sheet.setColumnWidth((short)5,(short)2000);
		sheet.setColumnWidth((short)6,(short)2000);
		sheet.setColumnWidth((short)7,(short)2000);
		sheet.setColumnWidth((short)8,(short)2000);
		sheet.setColumnWidth((short)9,(short)2000);
		sheet.setColumnWidth((short)10,(short)2000);
		sheet.setColumnWidth((short)11,(short)2000);
		sheet.setColumnWidth((short)12,(short)3000);

		workbook.setSheetName(1 , "Detail List" ,HSSFWorkbook.ENCODING_UTF_16);

		//Cell 생성
		HSSFRow row200 = sheet.createRow(0);
		row200.setHeight ((short) 0x360); // row 높이 설정

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(0,(short)0,0,(short)12)); 

		HSSFCell cell200 = row200.createCell((short)0);
		cell200.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell200.setCellStyle(style02);
		cell200.setCellValue("PACKING LIST");

		HSSFRow row201 = sheet.createRow(1);
		row201.setHeight ((short) 0x260); // row 높이 설정

		HSSFCell cell201 = row201.createCell((short)0);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("차량번호");

		cell201 = row201.createCell((short)1);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("포장수");

		cell201 = row201.createCell((short)2);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("품명(영문명)");

		cell201 = row201.createCell((short)3);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("규격");

		cell201 = row201.createCell((short)4);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("단위");

		cell201 = row201.createCell((short)5);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("수량");

		cell201 = row201.createCell((short)6);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("순중량\n(KG)");

		cell201 = row201.createCell((short)7);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("총중량\n(KG)");

		cell201 = row201.createCell((short)8);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("길이\n(CM)");

		cell201 = row201.createCell((short)9);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("폭\n(CM)");

		cell201 = row201.createCell((short)10);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("높이\n(CM)");

		cell201 = row201.createCell((short)11);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("용적\n(CBM)");

		cell201 = row201.createCell((short)12);
		cell201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell201.setCellStyle(style1100_c);
		cell201.setCellValue("비고");

		cell201 = row201.createCell((short)13);
		cell201.setCellStyle(style1000);

		query = " SELECT A.CAR_NO, A.PACKING_CNT, A.GOODS_NM, A.STDRD_SZ, B.MINORNM, " +
						"				 A.GOODS_CNT, A.PKG_WEIGHT, A.PKG_WEIGHT, A.PKG_LNGTH, A.PKG_HEIGHT, " +
						"				 A.PKG_WIDTH, A.PKG_CBM, A.REAMARK " +
						"   FROM TRANSFER.LTPCKLSDT A, " +
						"				 (SELECT MINORCD, MINORNM FROM TRANSFER.LTLCODE WHERE MAJORCD = '0008') B " +
						"  WHERE A.PL_NO IS NOT NULL " +
						"		 AND A.CNT_UNIT = B.MINORCD " +
						"		 AND A.PL_NO = '" + gstr1 + "' " +
						"  ORDER BY A.PL_NO, A.PL_SEQNO ";

		stmt = conn.prepareStatement(query);
		rs = stmt.executeQuery();

		String[] rst2 = new String[13];
		int[] rst3 = new int[5];
		double dou3 = 0.0;

		int t = 2;
		String parmChk = "";
		String vk = "N";

		while(rs.next()) {
			HSSFRow row202 = sheet.createRow(t);
			row202.setHeight ((short) 0x160); // row 높이 설정

			for (int s=0; s<rst2.length; s++) {
				HSSFCell cell202 = null;
				if (parmChk.equals(rs.getString(1))) vk = "Y";
				else vk = "N";

				if (s!=0 && s!=2 && s!=3 && s!=4 && s!=12) {
					float f201 = (Float.parseFloat(rs.getString(s+1)));
					int int201 = (int) f201;

					cell202 = row202.createCell((short)s);
					cell202.setEncoding(HSSFCell.ENCODING_UTF_16); 
					if (vk.equals("N")) cell202.setCellStyle(style1100_r);
					else if (vk.equals("Y")) cell202.setCellStyle(style1000_r);

					if (s==1){
						if (int201==0) cell202.setCellValue("");
						else cell202.setCellValue(int201);
					} else if (s>5 && s<12) {
						if (int201==0) cell202.setCellValue("");
						else {
							if (s==11) cell202.setCellValue(f201);
							else cell202.setCellValue(int201);
						}

						if (s<11) rst3[s-6] = rst3[s-6] + int201;
						else dou3 = dou3 + f201;

					} else cell202.setCellValue(int201);
				} else {
					cell202 = row202.createCell((short)s);
					cell202.setEncoding(HSSFCell.ENCODING_UTF_16); 

					if (vk.equals("N")) cell202.setCellStyle(style1100);
					else if (vk.equals("Y")) cell202.setCellStyle(style1000);

					if (s==0)	{
						if (vk.equals("N")) cell202.setCellValue(rs.getString(s+1));
						else cell202.setCellValue("");
					} else {
						cell202.setCellValue(rs.getString(s+1));
					}

				}

				cell202 = row202.createCell((short)13);
				cell202.setCellStyle(style1000);

			}
			t++;
			parmChk = rs.getString(1);
		}

		HSSFRow row203 = sheet.createRow(t);
		row203.setHeight ((short) 0x200); // row 높이 설정

		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(t,(short)0,t,(short)5)); 

		HSSFCell cell203 = row203.createCell((short)0);
		cell203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell203.setCellStyle(style1100_c);
		cell203.setCellValue("총계");

		for (int u=1; u<6; u++) {
			cell203 = row203.createCell((short)u);
			cell203.setCellStyle(style0100);
		}

		cell203 = row203.createCell((short)6);
		cell203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell203.setCellStyle(style1100_r);
		cell203.setCellValue(rst3[0]);

		cell203 = row203.createCell((short)7);
		cell203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell203.setCellStyle(style1100_r);
		cell203.setCellValue(rst3[1]);

		cell203 = row203.createCell((short)8);
		cell203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell203.setCellStyle(style1100_r);
		cell203.setCellValue("");

		cell203 = row203.createCell((short)9);
		cell203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell203.setCellStyle(style1100_r);
		cell203.setCellValue("");

		cell203 = row203.createCell((short)10);
		cell203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell203.setCellStyle(style1100_r);
		cell203.setCellValue("");

		cell203 = row203.createCell((short)11);
		cell203.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell203.setCellStyle(style1100_r);
		cell203.setCellValue(dou3);

		cell203 = row203.createCell((short)12);
		cell203.setCellStyle(style1100_r);

		cell203 = row203.createCell((short)13);
		cell203.setCellStyle(style1000);

		HSSFRow row204 = sheet.createRow(t+1);

		for (int u=0; u<13; u++) {
			HSSFCell cell204 = row204.createCell((short)u);
			cell204.setCellStyle(style0100);
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

 
