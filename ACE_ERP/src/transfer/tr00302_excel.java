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

public class tr00302_excel extends HttpServlet {
 
	public void doGet(HttpServletRequest request, HttpServletResponse response) {

	Connection conn = null;
	PreparedStatement stmt = null;

	String filepath = "\\Root\\HdAsan\\upload_file\\";
	String filename = "방문명단";

	String query = "";

	String gstr1 = request.getParameter("v_str1").trim();
	String gstr2 = request.getParameter("v_str2").trim();
	String gstr3 = request.getParameter("v_str3").trim();
	String sdate = request.getParameter("v_str4").trim();

	try {

//		filename = new String(filename.getBytes("euc_kr"),"8859_1");

		Class.forName("com.ibm.as400.access.AS400JDBCDriver");
		conn = DriverManager.getConnection("jdbc:as400:203.242.32.198;user=QPILOT;password=PILOT");

		String client = request.getHeader("User-Agent");
    if (client.indexOf("MSIE 5.5") != -1) {
        response.setHeader("Content-Type", "doesn/matter;charset=8859_1");
        response.setHeader("Content-Disposition", "filename="+filename+"_"+sdate+".xls;");
    } 
    else {
//				response.setHeader("Content-Type", "application/octet-stream;charset=8859_1");
//        response.setHeader("Content-Disposition", "attachment;filename="+filename+"_"+sdate+".xls;");

	String ss = filename+"_"+sdate+".xls";

	response.setContentType("application/octet-stream"); 
  response.setHeader("Content-Disposition", "attachment;filename="+new String(ss.getBytes("euc-kr"),"8859_1"));

    }

		query = "SELECT IFNULL(C.MINORNM,'') A_AREA, " +
						"				A.RTRN_DATE, " +
						"				A.PRSN_NAME, " +
						"				CASE WHEN A.GENDER = 'M' then '남' " +
						"						 ELSE '여' " +
						"				END  SEX, " +
						"				SUBSTR(A.PRSN_REGNO,1,2)||'.'||SUBSTR(A.PRSN_REGNO,3,2)||'.'||SUBSTR(A.PRSN_REGNO,5,2) AS PR_REGNO, " +
						"				A.PRSN_CMPY, " +
						"				A.JOB_DUTY, " +
						"				A.ADDRESS1, " +
						"				D.PICFILE, " +
						"				CASE WHEN LENGTH(RTRIM(D.PICFILE)) IS NULL THEN 0 ELSE LENGTH(RTRIM(D.PICFILE)) END, " +
						"				A.START_DATE " +
						"  FROM TRANSFER.LTPSRNACC A " +
						"				LEFT JOIN ACCOUNT.COMMDTIL B ON B.CDCODE = A.PURPOSE AND B.CMTYPE = '0030' " +
						"				LEFT JOIN TRANSFER.LTLCODE C ON C.MINORCD = A.ACC_AREA   AND C.MAJORCD = '0007' " +
						"				LEFT JOIN PAYROLL.HIPERSON D ON D.EMPNO = A.CREATE_USR " +
						"	WHERE A.ACCSECTION <> 'O' " +
						"		AND  A.START_DATE BETWEEN '" + gstr1 + "' AND '" + gstr2 + "' " +
						"		AND A.ACCESSNO = '" + gstr3 + "'";

		stmt = conn.prepareStatement(query);
		ResultSet rs = stmt.executeQuery();

		HSSFWorkbook workbook = new HSSFWorkbook();

		HSSFSheet sheet = workbook.createSheet();

		//cell width 설정
		sheet.setColumnWidth((short)0,(short)1100);
		sheet.setColumnWidth((short)1,(short)4000);
		sheet.setColumnWidth((short)2,(short)3000);
		sheet.setColumnWidth((short)3,(short)6000);
		sheet.setColumnWidth((short)4,(short)3000);
		sheet.setColumnWidth((short)5,(short)6500);

		workbook.setSheetName(0 , "방문명단_"+sdate ,HSSFWorkbook.ENCODING_UTF_16);

		////////////////////////////////////////////////////////////////////////////////////////
		//타이틀
		////////////////////////////////////////////////////////////////////////////////////////
		HSSFCellStyle style01 = workbook.createCellStyle();

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

		//Cell 병합 
		//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
		sheet.addMergedRegion(new Region(0,(short)0,0,(short)5)); 

		//Cell Font
		style01.setFont(font);

		//Cell 생성
		HSSFRow row01 = sheet.createRow(0);
		row01.setHeight ((short) 0x360); // row 높이 설정

		HSSFCellStyle style00 = workbook.createCellStyle();
		style00.setBorderTop(HSSFCellStyle.BORDER_THICK);
		style00.setTopBorderColor(HSSFColor.BLACK.index);

		HSSFCell cell01 = row01.createCell((short)0);
		cell01.setEncoding(HSSFCell.ENCODING_UTF_16); 
		cell01.setCellStyle(style01);
		cell01.setCellValue("개성공업지구 방문인원 명단    (" + sdate +")");

		HSSFCellStyle style02 = workbook.createCellStyle();
		style02.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style02.setTopBorderColor(HSSFColor.BLACK.index);

		HSSFCellStyle style03 = workbook.createCellStyle();

		style03.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style03.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style03.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style03.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		style03.setLeftBorderColor(HSSFColor.BLACK.index);
		style03.setRightBorderColor(HSSFColor.BLACK.index);
		style03.setTopBorderColor(HSSFColor.BLACK.index);            
		style03.setBottomBorderColor(HSSFColor.BLACK.index);

		style03.setAlignment((short)HSSFCellStyle.ALIGN_LEFT);
		style03.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		style03.setFont(font01);

		HSSFCellStyle style04 = workbook.createCellStyle();
		style04.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style04.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style04.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style04.setTopBorderColor(HSSFColor.BLACK.index);
		style04.setRightBorderColor(HSSFColor.BLACK.index);
		style04.setBottomBorderColor(HSSFColor.BLACK.index);

    style04.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style04.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style04.setFont(font01);

		HSSFCellStyle style05 = workbook.createCellStyle();
		style05.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style05.setBottomBorderColor(HSSFColor.BLACK.index);

		HSSFCellStyle style06 = workbook.createCellStyle();
		style06.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style06.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style06.setRightBorderColor(HSSFColor.BLACK.index);
		style06.setRightBorderColor(HSSFColor.BLACK.index);

		HSSFCellStyle style07 = workbook.createCellStyle();
		style07.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style07.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style07.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style07.setRightBorderColor(HSSFColor.BLACK.index);
		style07.setRightBorderColor(HSSFColor.BLACK.index);
		style07.setBottomBorderColor(HSSFColor.BLACK.index);

		HSSFRow row02 = sheet.createRow(1);
		row02.setHeight ((short) 0x200); // row 높이 설정
		HSSFCell cell02 = null;

		for (int d=0; d<6; d++) {
			cell02 = row02.createCell((short)d);
			cell02.setCellStyle(style00);
		}

		//실제 데이터
		HSSFCellStyle style = workbook.createCellStyle();

		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		style.setLeftBorderColor(HSSFColor.BLACK.index);
		style.setRightBorderColor(HSSFColor.BLACK.index);
		style.setTopBorderColor(HSSFColor.BLACK.index);            
		style.setBottomBorderColor(HSSFColor.BLACK.index);

		style.setAlignment((short)HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

		style.setFont(font01);
		ResultSetMetaData rsmd = rs.getMetaData();

		byte [] bdata = new byte[1];
		int ilen = 0;
		int rowCnt = 2;
		int idxcell = 3;
		int idximg = 0;
		int[] pictureIndex = new int[500];
		int ino = 1;

		while(rs.next()) {
			//Region(int 시작row, short 시작col, int 종료row, short 종료col) 
			sheet.addMergedRegion(new Region(rowCnt,(short)0,rowCnt+3,(short)0)); 
			sheet.addMergedRegion(new Region(rowCnt,(short)1,rowCnt+3,(short)1)); 

			sheet.addMergedRegion(new Region(rowCnt+3,(short)3,rowCnt+3,(short)5)); 

			//1st Row
			HSSFRow row = sheet.createRow(rowCnt);
			row.setHeight ((short) 0x1d0); // row 높이 설정

			HSSFCell cell = row.createCell((short)0);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue(ino);

			cell = row.createCell((short)1);
			cell.setCellStyle(style02);

			cell = row.createCell((short)2);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue("번호");

			cell = row.createCell((short)3);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style03);
			cell.setCellValue(" " + rs.getString(1)+" / "+ino);

			cell = row.createCell((short)4);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue("체류기간");

			String strdate = rs.getString(11);
			String expdate = rs.getString(2);
			String gsdate = "";

			strdate = strdate.substring(0,4)+"."+strdate.substring(4,6)+"."+strdate.substring(6,8);
			expdate = expdate.substring(0,4)+"."+expdate.substring(4,6)+"."+expdate.substring(6,8);

			if (strdate.equals(expdate)) gsdate = strdate;
			else gsdate = strdate + " ~ " + expdate;

			cell = row.createCell((short)5);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style04);
			cell.setCellValue(" " + gsdate);

			//2nd Row
			row = sheet.createRow(rowCnt+1);
			row.setHeight ((short) 0x1d0); // row 높이 설정

			cell = row.createCell((short)0);
			cell.setCellStyle(style06);

			cell = row.createCell((short)2);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue("성명");

			cell = row.createCell((short)3);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style03);
			cell.setCellValue(" " + rs.getString(3));

			cell = row.createCell((short)4);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue("성별");

			cell = row.createCell((short)5);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style04);
			cell.setCellValue(" " + rs.getString(4));

			//3th Row
			row = sheet.createRow(rowCnt+2);
			row.setHeight ((short) 0x1d0); // row 높이 설정

			cell = row.createCell((short)0);
			cell.setCellStyle(style06);

			cell = row.createCell((short)2);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue("생년월일");

			cell = row.createCell((short)3);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style03);
			cell.setCellValue(" " + rs.getString(5));

			cell = row.createCell((short)4);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue("직장/직위");

			cell = row.createCell((short)5);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style04);
			cell.setCellValue(" " + rs.getString(6)+" / "+rs.getString(7));

			//4th Row
			row = sheet.createRow(rowCnt+3);
			row.setHeight ((short) 0x1d0); // row 높이 설정

			cell = row.createCell((short)0);
			cell.setCellStyle(style07);

			cell = row.createCell((short)1);
			cell.setCellStyle(style05);

			cell = row.createCell((short)2);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style);
			cell.setCellValue("거주지");

			cell = row.createCell((short)3);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16); 
			cell.setCellStyle(style04);
			cell.setCellValue(" " + rs.getString(8));

			cell = row.createCell((short)4);
			cell.setCellStyle(style05);

			cell = row.createCell((short)5);
			cell.setCellStyle(style04);

			bdata = rs.getBytes(9);
			ilen = rs.getInt(10);

			if (ilen>0) {

				ByteArrayOutputStream bos = null;

				InputStream fin = new ByteArrayInputStream(bdata);

				bos = new ByteArrayOutputStream( );
				int c;
				while ( (c = fin.read()) != -1) {
					bos.write( c );
				}

				//20131231 jys 막음
				//pictureIndex[idximg] = workbook.addPicture( bos.toByteArray(), HSSFWorkbook.PICTURE_TYPE_JPEG  );

			}

			row = sheet.createRow(rowCnt+4);
			row.setHeight ((short) 0x200); // row 높이 설정

			idximg++;
			rowCnt = rowCnt + 5;
			ino++;
		}

		HSSFPicture picture = null;
		HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
		int posi = 2;

		for (int e=0; e<idximg; e++){
			HSSFClientAnchor anchor;
			//20131231 jys 막음															
			//anchor = new HSSFClientAnchor(10,10,1020,255,(short)1,(short)posi,(short)1,(short)posi+3); // 이미지 크기조절은 여기서..
			//anchor.setAnchorType( 2 );

			//picture = patriarch.createPicture(anchor, pictureIndex[e]);
			posi = posi+5;
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


	} catch (Exception e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}    
	}   
}

 
