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

public class tr00101_s3 extends HttpServlet {
 
	public void doGet(HttpServletRequest request, HttpServletResponse response) {

	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String filepath = "\\Root\\HdAsan\\upload_file\\";
	String filename = "Freight Receipt";

	String query = "";

	String gorder_no = request.getParameter("v_str1").trim();
	String sdate = request.getParameter("v_str2").trim();
	if (gorder_no==null) gorder_no = "";
	
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

		sheet01.setColumnWidth((short)0,(short)1300);
		sheet01.setColumnWidth((short)1,(short)0);
		sheet01.setColumnWidth((short)2,(short)0);
		sheet01.setColumnWidth((short)3,(short)5000);
		sheet01.setColumnWidth((short)4,(short)4000);
		sheet01.setColumnWidth((short)5,(short)3000);
		sheet01.setColumnWidth((short)6,(short)3000);
		sheet01.setColumnWidth((short)7,(short)4300);
		sheet01.setColumnWidth((short)8,(short)4000);
		sheet01.setColumnWidth((short)9,(short)4000);
		sheet01.setColumnWidth((short)10,(short)3000);
		sheet01.setColumnWidth((short)11,(short)4700);
		sheet01.setColumnWidth((short)12,(short)5000);
		sheet01.setColumnWidth((short)13,(short)5000);

		workbook.setSheetName(0 , "화물 인수증" ,HSSFWorkbook.ENCODING_UTF_16);

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

		//Cell의 Font 설정
		HSSFFont font01 = workbook.createFont();
		font01.setFontHeightInPoints((short)20);
		font01.setFontName("굴림체");
		font01.setBoldweight(font01.BOLDWEIGHT_BOLD); 

		HSSFFont font02 = workbook.createFont();
		font02.setFontHeightInPoints((short)9);
		font02.setFontName("굴림체");

		HSSFFont font03 = workbook.createFont();
		font03.setFontHeightInPoints((short)9);
		font03.setFontName("굴림체");
		font03.setBoldweight(font03.BOLDWEIGHT_BOLD); 

		//Cell의 Align 속성
    style01.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style01.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

	  style02.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style02.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style02.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style02.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style02.setLeftBorderColor(HSSFColor.BLACK.index);
		style02.setTopBorderColor(HSSFColor.BLACK.index);
		style02.setBottomBorderColor(HSSFColor.BLACK.index);
		style02.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style02.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style02.setBorderBottom(HSSFCellStyle.BORDER_THIN);

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
		style04.setTopBorderColor(HSSFColor.BLACK.index);
		style04.setBottomBorderColor(HSSFColor.BLACK.index);
		style04.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style04.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style04.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		style05.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style05.setRightBorderColor(HSSFColor.BLACK.index);
		style05.setLeftBorderColor(HSSFColor.BLACK.index);
		style05.setBottomBorderColor(HSSFColor.BLACK.index);
		style05.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style05.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style05.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style06.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style06.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style06.setBottomBorderColor(HSSFColor.BLACK.index);
		style06.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style07.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style07.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style07.setRightBorderColor(HSSFColor.BLACK.index);
		style07.setBottomBorderColor(HSSFColor.BLACK.index);
		style07.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style07.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style08.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style08.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style08.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		style08.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style08.setLeftBorderColor(HSSFColor.BLACK.index);
		style08.setRightBorderColor(HSSFColor.BLACK.index);
		style08.setTopBorderColor(HSSFColor.BLACK.index);
		style08.setBottomBorderColor(HSSFColor.BLACK.index);
		style08.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style08.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style08.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style08.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style09.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style09.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style09.setRightBorderColor(HSSFColor.BLACK.index);
		style09.setLeftBorderColor(HSSFColor.BLACK.index);
		style09.setBottomBorderColor(HSSFColor.BLACK.index);
		style09.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style09.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style09.setBorderBottom(HSSFCellStyle.BORDER_THIN);

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
		style12.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.0"));

		style13.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style13.setFillForegroundColor(HSSFColor.BLACK.index);
		style13.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style13.setLeftBorderColor(HSSFColor.BLACK.index);
		style13.setTopBorderColor(HSSFColor.BLACK.index);
		style13.setBottomBorderColor(HSSFColor.BLACK.index);
		style13.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style13.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style13.setBorderBottom(HSSFCellStyle.BORDER_THIN);

	  style14.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style14.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style15.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style15.setVerticalAlignment(HSSFCellStyle.VERTICAL_BOTTOM);

	  style16.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style16.setVerticalAlignment(HSSFCellStyle.VERTICAL_BOTTOM);
    style16.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style16.setBottomBorderColor(HSSFColor.BLACK.index);
		style16.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		//Cell Font
		style01.setFont(font01);
		style02.setFont(font02);
		style05.setFont(font02);
		style06.setFont(font02);
		style07.setFont(font02);
		style08.setFont(font03);
		style09.setFont(font02);
		style10.setFont(font02);
		style11.setFont(font02);
		style12.setFont(font02);
		style14.setFont(font03);
		style15.setFont(font02);
		style16.setFont(font02);

		//Cell 병합 
		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet01.addMergedRegion(new Region(0,(short)0,0,(short)13)); 
		sheet01.addMergedRegion(new Region(2,(short)3,2,(short)5)); 
		sheet01.addMergedRegion(new Region(2,(short)7,2,(short)9)); 
		sheet01.addMergedRegion(new Region(2,(short)11,2,(short)12)); 

		for (int k=3; k<8 ;k++ ) {
			sheet01.addMergedRegion(new Region(k,(short)4,k,(short)5)); 
			sheet01.addMergedRegion(new Region(k,(short)8,k,(short)9)); 
		}

		///////////////////////////////////////////////////////////////////////////////////////////////
		// 1st Sheet ( 화물 인수증 )
		///////////////////////////////////////////////////////////////////////////////////////////////

		//Cell 생성
		HSSFRow row00 = sheet01.createRow(0);
		row00.setHeight ((short) 0x200); // row 높이 설정

		HSSFCell cell00 = row00.createCell((short)0);
		cell00.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell00.setCellStyle(style01);
		cell00.setCellValue("화물 인수증");

		HSSFRow row01 = sheet01.createRow(1);
		row01.setHeight ((short) 0x200); // row 높이 설정

		HSSFRow row02 = sheet01.createRow(2);
		row02.setHeight ((short) 0x180); // row 높이 설정

		HSSFCell cell0201 = row02.createCell((short)3);
		cell0201.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0201.setCellStyle(style02);
		cell0201.setCellValue("기본 정보");

		HSSFCell cell0202 = row02.createCell((short)4);
		cell0202.setCellStyle(style03);

		HSSFCell cell0203 = row02.createCell((short)5);
		cell0203.setCellStyle(style04);

		HSSFCell cell0205 = row02.createCell((short)7);
		cell0205.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0205.setCellStyle(style02);
		cell0205.setCellValue("송하인 정보");

		HSSFCell cell0206 = row02.createCell((short)8);
		cell0206.setCellStyle(style03);

		HSSFCell cell0207 = row02.createCell((short)9);
		cell0207.setCellStyle(style04);

		HSSFCell cell0209 = row02.createCell((short)11);
		cell0209.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0209.setCellStyle(style02);
		cell0209.setCellValue("수하인 정보");

		HSSFCell cell0210 = row02.createCell((short)12);
		cell0210.setCellStyle(style04);

		String sqlSheet = "";
		sqlSheet = " SELECT C.MINORNM PROJNM, IFNULL(A.ETD_DT,'') ETD_DT, IFNULL(A.ETD_DT1,'') ETD_DT1,  \n"
						 + "				V.VEND_NM, A.SHIPPERPS, A.SHIPPERTEL, A.FAC_PERSON, A.FAC_PRSTEL,  \n"
						 + "				IFNULL(A.RECIPIENT,'') RECIPIENT, IFNULL(A.RECP_OWN,'') RECP_OWN, IFNULL(A.RECP_TEL,'') RECP_TEL, IFNULL(A.RECP_ADD,'') RECP_ADD \n"
						 + "   FROM TRANSFER.LTORDERMST A \n"
						 + "				LEFT OUTER JOIN ACCOUNT.GCZM_VENDER V ON A.SHIPPER = V.VEND_CD, \n"
						 + "        TRANSFER.LTLCODE C \n"
						 + "  WHERE A.ORDER_NO = '" + gorder_no + "' \n"
						 + "    AND A.LINE_PART = C.MINORCD \n"
						 + "    AND C.MAJORCD = '0002' \n";

		String sqlSheet2 = "";
		sqlSheet2 = " SELECT A.CARTYPENO, B.CAR_NAME, COUNT(A.CARTYPENO) CAR_CNT \n"
							+ "   FROM TRANSFER.LTORDCAR A, \n"
							+ "        TRANSFER.LTCARTYPE  B \n"
							+ "  WHERE A.ORDER_NO = '" + gorder_no + "' \n"
							+ "    AND A.CARTYPENO = B.CAR_TYPE \n"
							+ "  GROUP BY A.CARTYPENO, B.CAR_NAME  \n";

		String sprojnm = "";
		String setd_date1 = "";
		String setd_date2 = "";
		String svendnm = "";
		String sshipper = "";
		String svendtel = "";
		String sfac_per = "";
		String sfac_tel = "";
		String scar_cnt = "";
		String srecipient = "";
		String srecp_own = "";
		String srecp_tel = "";
		String srecp_add = "";

		if (!gorder_no.equals("")) {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet);

			while(rs.next()) {
				sprojnm		 = rs.getString(1);
				setd_date1 = rs.getString(2);
				setd_date2 = rs.getString(3);
				svendnm		 = rs.getString(4);
				sshipper	 = rs.getString(5);
				svendtel	 = rs.getString(6);
				sfac_per	 = rs.getString(7);
				sfac_tel	 = rs.getString(8);
				srecipient = rs.getString(9);
				srecp_own	 = rs.getString(10);
				srecp_tel	 = rs.getString(11);
				srecp_add	 = rs.getString(12);
			}

			if (setd_date1.length()==8) setd_date1 = setd_date1.substring(0,4) + "/" + setd_date1.substring(4,6) + "/" + setd_date1.substring(6,8);
			if (setd_date2.length()==8) setd_date2 = setd_date2.substring(0,4) + "/" + setd_date2.substring(4,6) + "/" + setd_date2.substring(6,8);

			stmt = null;
			rs = null;

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet2);

			int ichk = 1;
			while(rs.next()) {
				if (ichk==1) scar_cnt	= rs.getString(2) + " " + rs.getInt(3) + "대";
				else scar_cnt	= scar_cnt + " ," + rs.getString(2) + " " + rs.getInt(3) + "대";
				ichk++;
			}
		}

		HSSFRow row03 = sheet01.createRow(3);
		row03.setHeight ((short) 0x180); // row 높이 설정

		HSSFCell cell0301 = row03.createCell((short)3);
		cell0301.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0301.setCellStyle(style05);
		cell0301.setCellValue(" 프로젝트명");

		HSSFCell cell0302 = row03.createCell((short)4);
		cell0302.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0302.setCellStyle(style06);
		cell0302.setCellValue(sprojnm);

		HSSFCell cell0303 = row03.createCell((short)5);
		cell0303.setCellStyle(style07);

		HSSFCell cell0305 = row03.createCell((short)7);
		cell0305.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0305.setCellStyle(style05);
		cell0305.setCellValue(" 업체명");

		HSSFCell cell0306 = row03.createCell((short)8);
		cell0306.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0306.setCellStyle(style06);
		cell0306.setCellValue(svendnm);

		HSSFCell cell0307 = row03.createCell((short)9);
		cell0307.setCellStyle(style07);

		HSSFCell cell0309 = row03.createCell((short)11);
		cell0309.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0309.setCellStyle(style05);
		cell0309.setCellValue(" 업체명");

		HSSFCell cell0310 = row03.createCell((short)12);
		cell0310.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0310.setCellStyle(style07);
		cell0310.setCellValue(srecipient);

		HSSFRow row04 = sheet01.createRow(4);
		row04.setHeight ((short) 0x180); // row 높이 설정

		HSSFCell cell0401 = row04.createCell((short)3);
		cell0401.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0401.setCellStyle(style05);
		cell0401.setCellValue(" 반출일자");

		HSSFCell cell0402 = row04.createCell((short)4);
		cell0402.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0402.setCellStyle(style06);
		cell0402.setCellValue(setd_date1);

		HSSFCell cell0403 = row04.createCell((short)5);
		cell0403.setCellStyle(style07);

		HSSFCell cell0405 = row04.createCell((short)7);
		cell0405.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0405.setCellStyle(style05);
		cell0405.setCellValue(" 담당자");

		HSSFCell cell0406 = row04.createCell((short)8);
		cell0406.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0406.setCellStyle(style06);
		cell0406.setCellValue(sshipper);

		HSSFCell cell0407 = row04.createCell((short)9);
		cell0407.setCellStyle(style07);

		HSSFCell cell0409 = row04.createCell((short)11);
		cell0409.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0409.setCellStyle(style05);
		cell0409.setCellValue(" 담당자");

		HSSFCell cell0410 = row04.createCell((short)12);
		cell0410.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0410.setCellStyle(style07);
		cell0410.setCellValue(srecp_own);

		HSSFRow row05 = sheet01.createRow(5);
		row05.setHeight ((short) 0x180); // row 높이 설정

		HSSFCell cell0501 = row05.createCell((short)3);
		cell0501.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0501.setCellStyle(style05);
		cell0501.setCellValue(" 상차/입고일");

		HSSFCell cell0502 = row05.createCell((short)4);
		cell0502.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0502.setCellStyle(style06);
		cell0502.setCellValue(setd_date2);

		HSSFCell cell0503 = row05.createCell((short)5);
		cell0503.setCellStyle(style07);

		HSSFCell cell0505 = row05.createCell((short)7);
		cell0505.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0505.setCellStyle(style05);
		cell0505.setCellValue(" 전화번호");

		HSSFCell cell0506 = row05.createCell((short)8);
		cell0506.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0506.setCellStyle(style06);
		cell0506.setCellValue(svendtel);

		HSSFCell cell0507 = row05.createCell((short)9);
		cell0507.setCellStyle(style07);

		HSSFCell cell0509 = row05.createCell((short)11);
		cell0509.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0509.setCellStyle(style05);
		cell0509.setCellValue(" 전화번호");

		HSSFCell cell0510 = row05.createCell((short)12);
		cell0510.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0510.setCellStyle(style07);
		cell0510.setCellValue(srecp_tel);

		HSSFRow row06 = sheet01.createRow(6);
		row06.setHeight ((short) 0x180); // row 높이 설정

		HSSFCell cell0601 = row06.createCell((short)3);
		cell0601.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0601.setCellStyle(style05);
		cell0601.setCellValue(" 총투입대수");

		HSSFCell cell0602 = row06.createCell((short)4);
		cell0602.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0602.setCellStyle(style06);
		cell0602.setCellValue(scar_cnt);

		HSSFCell cell0603 = row06.createCell((short)5);
		cell0603.setCellStyle(style07);

		HSSFCell cell0605 = row06.createCell((short)7);
		cell0605.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0605.setCellStyle(style05);
		cell0605.setCellValue(" 출하공장 담당자");

		HSSFCell cell0606 = row06.createCell((short)8);
		cell0606.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0606.setCellStyle(style06);
		cell0606.setCellValue(sfac_per);

		HSSFCell cell0607 = row06.createCell((short)9);
		cell0607.setCellStyle(style07);

		HSSFCell cell0609 = row06.createCell((short)11);
		cell0609.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0609.setCellStyle(style05);
		cell0609.setCellValue(" 주 소");

		HSSFCell cell0610 = row06.createCell((short)12);
		cell0610.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0610.setCellStyle(style07);
		cell0610.setCellValue(srecp_add);

		HSSFRow row07 = sheet01.createRow(7);
		row07.setHeight ((short) 0x180); // row 높이 설정

		HSSFCell cell0701 = row07.createCell((short)3);
		cell0701.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0701.setCellStyle(style05);
		cell0701.setCellValue(" 비 고");

		HSSFCell cell0702 = row07.createCell((short)4);
		cell0702.setCellStyle(style06);

		HSSFCell cell0703 = row07.createCell((short)5);
		cell0703.setCellStyle(style07);

		HSSFCell cell0705 = row07.createCell((short)7);
		cell0705.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0705.setCellStyle(style05);
		cell0705.setCellValue(" 출하공장 전화번호");

		HSSFCell cell0706 = row07.createCell((short)8);
		cell0706.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0706.setCellStyle(style06);
		cell0706.setCellValue(sfac_tel);

		HSSFCell cell0707 = row07.createCell((short)9);
		cell0707.setCellStyle(style07);

		HSSFRow row08 = sheet01.createRow(8);
		row08.setHeight ((short) 0x200); // row 높이 설정

		HSSFRow row09 = sheet01.createRow(9);
		row09.setHeight ((short) 0x240); // row 높이 설정

		HSSFCell cell0900 = row09.createCell((short)0);
		cell0900.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0900.setCellStyle(style08);
		cell0900.setCellValue("NO");

		HSSFCell cell0901 = row09.createCell((short)1);
		cell0901.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0901.setCellStyle(style08);
		cell0901.setCellValue("HS CODE");

		HSSFCell cell0902 = row09.createCell((short)2);
		cell0902.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0902.setCellStyle(style08);
		cell0902.setCellValue("영문명");

		HSSFCell cell0903 = row09.createCell((short)3);
		cell0903.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0903.setCellStyle(style08);
		cell0903.setCellValue("품 명");

		HSSFCell cell0904 = row09.createCell((short)4);
		cell0904.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0904.setCellStyle(style08);
		cell0904.setCellValue("규 격");

		HSSFCell cell0905 = row09.createCell((short)5);
		cell0905.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0905.setCellStyle(style08);
		cell0905.setCellValue("수량\n단위");

		HSSFCell cell0906 = row09.createCell((short)6);
		cell0906.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0906.setCellStyle(style08);
		cell0906.setCellValue("수 량");

		HSSFCell cell0907 = row09.createCell((short)7);
		cell0907.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0907.setCellStyle(style08);
		cell0907.setCellValue("단가(원)");

		HSSFCell cell0908 = row09.createCell((short)8);
		cell0908.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0908.setCellStyle(style08);
		cell0908.setCellValue("금액(원)");

		HSSFCell cell0909 = row09.createCell((short)9);
		cell0909.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0909.setCellStyle(style08);
		cell0909.setCellValue("총용적(CBM)");

		HSSFCell cell0910 = row09.createCell((short)10);
		cell0910.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0910.setCellStyle(style08);
		cell0910.setCellValue("총무게(KG)");

		HSSFCell cell0911 = row09.createCell((short)11);
		cell0911.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0911.setCellStyle(style08);
		cell0911.setCellValue("비고\n(반입시 반출일자)");

		HSSFCell cell0912 = row09.createCell((short)12);
		cell0912.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0912.setCellStyle(style08);
		cell0912.setCellValue("상차지\n상세정보");

		HSSFCell cell0913 = row09.createCell((short)13);
		cell0913.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell0913.setCellStyle(style08);
		cell0913.setCellValue("하차지\n상세정보");

		sqlSheet = "";
		sqlSheet = " SELECT A.ARTC_NM, RTRIM(A.STN_SZNM) STN_SZNM, RTRIM(B.MINORNM) MINORNM, A.ARTC_CNT, A.UNIT_PRICE, A.PRICE, ROUND(ROUND(A.ARTC_CNT/A.PUNIT_CNT,1)*A.PKG_CBM,1) TOT_CBM, \n"
						 + "        ROUND(A.ARTC_CNT/A.PUNIT_CNT*A.PUNIT_WGHT,0) TOT_WGHT, A.CANCLE_STS, IFNULL(A.ENG_ARTCNM,'') ENG_ARTCNM, D.LD_CARGONM, D.OFF_CARGONM \n"
						 + "   FROM TRANSFER.LTORDERDTL A, \n"
						 + "        TRANSFER.LTLCODE B, \n"
						 + "        TRANSFER.LTCARGOODS C \n"
						 + "        LEFT OUTER JOIN TRANSFER.LTORDCAR D ON C.ORDER_NO = D.ORDER_NO AND C.CAR_SEQ_NO = D.CAR_SEQ_NO \n"
						 + "  WHERE A.ORDER_NO  = '" + gorder_no + "' \n"
						 + "    AND A.ARTC_UNIT = B.MINORCD \n"
						 + "    AND A.ORDER_NO  = C.ORDER_NO \n"
						 + "    AND A.ORDER_SEQ = C.ORDER_SEQ \n"
						 + "    AND B.MAJORCD   = '0008' ";

		int row = 10;
		int s_cnt = 0;
		int s_price = 0;
		int icnt = 1;

		HSSFCell cell1000 = null;
		HSSFCell cell1001 = null;
		HSSFCell cell1002 = null;
		HSSFCell cell1003 = null;
		HSSFCell cell1004 = null;
		HSSFCell cell1005 = null;
		HSSFCell cell1006 = null;
		HSSFCell cell1007 = null;
		HSSFCell cell1008 = null;
		HSSFCell cell1009 = null;
		HSSFCell cell1010 = null;
		HSSFCell cell1011 = null;
		HSSFCell cell1012 = null;
		HSSFCell cell1013 = null;

		HSSFRow row10 = null;

		if (!gorder_no.equals("")) {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlSheet);

			while(rs.next()) {

				row10 = sheet01.createRow(row);
				row10.setHeight ((short) 0x160); // row 높이 설정

				cell1000 = row10.createCell((short)0);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style09);
				cell1000.setCellValue(icnt);

				cell1000 = row10.createCell((short)1);
				cell1000.setCellStyle(style09);

				cell1000 = row10.createCell((short)2);
				cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1000.setCellStyle(style09);
				cell1000.setCellValue(rs.getString(10));

				cell1001 = row10.createCell((short)3);
				cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1001.setCellStyle(style10);
				cell1001.setCellValue(rs.getString(1));

				cell1002 = row10.createCell((short)4);
				cell1002.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1002.setCellStyle(style09);
				cell1002.setCellValue(rs.getString(2));

				cell1003 = row10.createCell((short)5);
				cell1003.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1003.setCellStyle(style10);
				cell1003.setCellValue(rs.getString(3));

				cell1004 = row10.createCell((short)6);
				cell1004.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1004.setCellStyle(style11);
				cell1004.setCellValue(rs.getInt(4));
				s_cnt = s_cnt + rs.getInt(4);

				cell1005 = row10.createCell((short)7);
				cell1005.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1005.setCellStyle(style11);
				cell1005.setCellValue(rs.getInt(5));

				cell1006 = row10.createCell((short)8);
				cell1006.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1006.setCellStyle(style11);
				cell1006.setCellValue(rs.getInt(6));
				s_price = s_price + rs.getInt(6);

				cell1007 = row10.createCell((short)9);
				cell1007.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1007.setCellStyle(style12);
				cell1007.setCellValue(rs.getDouble(7));

				cell1008 = row10.createCell((short)10);
				cell1008.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1008.setCellStyle(style11);
				cell1008.setCellValue(rs.getInt(8));

				cell1009 = row10.createCell((short)11);
				cell1009.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1009.setCellStyle(style09);
				cell1009.setCellValue(rs.getString(9));

				cell1010 = row10.createCell((short)12);
				cell1010.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1010.setCellStyle(style10);
				cell1010.setCellValue(rs.getString(11));

				cell1011 = row10.createCell((short)13);
				cell1011.setEncoding(HSSFCell.ENCODING_UTF_16); 
				cell1011.setCellStyle(style10);
				cell1011.setCellValue(rs.getString(12));

				icnt++;
				row++;
			}

			stmt = null;
			rs = null;
		}

		for (int r=0; r<5; r++)	{
			row10 = sheet01.createRow(row);
			row10.setHeight ((short) 0x160); // row 높이 설정

			for (int s=0; s<14; s++) {
				if (s==0)	{
					cell1000 = row10.createCell((short)s);
					cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
					cell1000.setCellStyle(style09);
					cell1000.setCellValue(icnt);
				} else {
					cell1000 = row10.createCell((short)s);
					cell1000.setCellStyle(style09);
				}
			}

			row++;
			icnt++;
		}

		row10 = sheet01.createRow(row);
		row10.setHeight ((short) 0x160); // row 높이 설정

		cell1000 = row10.createCell((short)0);
		cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1000.setCellStyle(style09);
		cell1000.setCellValue("합계");

		for (int s=1; s<14; s++) {
			if (s!=6 && s!=8) {
				cell1000 = row10.createCell((short)s);
				cell1000.setCellStyle(style13);
			}
		}

		cell1000 = row10.createCell((short)6);
		cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1000.setCellStyle(style11);
		cell1000.setCellValue(s_cnt);

		cell1000 = row10.createCell((short)8);
		cell1000.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1000.setCellStyle(style11);
		cell1000.setCellValue(s_price);

		row++;

		row10 = sheet01.createRow(row);
		row10.setHeight ((short) 0x260); // row 높이 설정

		row++;

		row10 = sheet01.createRow(row);
		row10.setHeight ((short) 0x200); // row 높이 설정

		cell1001 = row10.createCell((short)3);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style14);
		cell1001.setCellValue("송하인(대리인) ");

		cell1001 = row10.createCell((short)6);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style14);
		cell1001.setCellValue("물류센터(창고업자)");

		cell1001 = row10.createCell((short)10);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style14);
		cell1001.setCellValue("운송사 ");

		cell1001 = row10.createCell((short)12);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style14);
		cell1001.setCellValue("수하인(대리인) ");

		row++;

		row10 = sheet01.createRow(row);
		row10.setHeight ((short) 0x200); // row 높이 설정

		cell1001 = row10.createCell((short)3);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("일  시 : ");

		cell1001 = row10.createCell((short)6);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("일  시 : ");

		cell1001 = row10.createCell((short)10);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("일   시 : ");

		cell1001 = row10.createCell((short)12);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("일  시 : ");

		row++;

		row10 = sheet01.createRow(row);
		row10.setHeight ((short) 0x200); // row 높이 설정

		cell1001 = row10.createCell((short)3);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("회사명 : ");

		sheet01.addMergedRegion(new Region(row,(short)4,row,(short)5)); 

		cell1001 = row10.createCell((short)4);
		cell1001.setCellStyle(style16);
		cell1001 = row10.createCell((short)5);
		cell1001.setCellStyle(style16);

		cell1001 = row10.createCell((short)6);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("회사명 : ");

		sheet01.addMergedRegion(new Region(row,(short)7,row,(short)8)); 

		cell1001 = row10.createCell((short)7);
		cell1001.setCellStyle(style16);
		cell1001 = row10.createCell((short)8);
		cell1001.setCellStyle(style16);

		cell1001 = row10.createCell((short)10);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("차량번호 : ");

		cell1001 = row10.createCell((short)11);
		cell1001.setCellStyle(style16);

		cell1001 = row10.createCell((short)12);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("회사명 : ");

		cell1001 = row10.createCell((short)13);
		cell1001.setCellStyle(style16);

		row++;

		row10 = sheet01.createRow(row);
		row10.setHeight ((short) 0x200); // row 높이 설정

		cell1001 = row10.createCell((short)3);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("성  명 : ");

		sheet01.addMergedRegion(new Region(row,(short)4,row,(short)5)); 

		cell1001 = row10.createCell((short)4);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style16);
		cell1001.setCellValue("(서명)");

		cell1001 = row10.createCell((short)5);
		cell1001.setCellStyle(style16);

		cell1001 = row10.createCell((short)6);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("성  명 : ");

		sheet01.addMergedRegion(new Region(row,(short)7,row,(short)8)); 

		cell1001 = row10.createCell((short)7);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style16);
		cell1001.setCellValue("(서명)");

		cell1001 = row10.createCell((short)8);
		cell1001.setCellStyle(style16);

		cell1001 = row10.createCell((short)10);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("성   명 : ");

		cell1001 = row10.createCell((short)11);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style16);
		cell1001.setCellValue("(서명)");

		cell1001 = row10.createCell((short)12);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style15);
		cell1001.setCellValue("성  명 : ");

		cell1001 = row10.createCell((short)13);
		cell1001.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell1001.setCellStyle(style16);
		cell1001.setCellValue("(서명)");

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

 
