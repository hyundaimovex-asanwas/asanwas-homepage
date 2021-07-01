<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ���� ������� �׼��� ���
 * ���α׷�ID 	: CQ021S
 * J  S  P		: cq021s
 * �� �� ��		: Cq021S
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-11-28
 * �������		: ������ ������� ��ȸ,���.. (__) ����!
 * [��  ��   ��  ��][������] ����
 * [2007-11-29][�ɵ���] beans �� ���� ����Ʈ�� �ҷ��ͼ� �׼��� ���.
 *						�� �ҷ����� �ͱ��� ����.
 * [2007-12-04][�ɵ���] �׼��� �� ��� ����. ���ǿ� ���� ��°� ���� / ���� ���� �� �Ϸ�~!
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
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


<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<%	// �Ķ���� �ޱ�.
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
  
  
  	len3 = data.size();	//����� ���.

// �� �տ� ������ üũ�Ѵ�.  
if(data == null || data.size() < 1 ) {
%>
	�����Ͱ� �����ϴ�.
<%
}else{
	bean3 = (BaseDataClass)data.get(0);// bean init.

	String filename    = "ks_pic_list("+ sDepartDate +").xls";	//���ϳ��� ����
	String sheetname   = "ks_pic_list";		//��Ʈ���� ����
	String doc_title   = "";										//���� Ÿ��Ʋ 
	int totalCount     = len3;	//�Ʒ� �ҽ� ��ġ�� �������� �̷��� ��..

	//�������////////////////////////////////////////////////////////////////////////////////////
	if(sBizChk.equals("true") ){
		doc_title = "���� ���� ���� ���强�� ��� " + bean3.get("title_date");
	}else{
		if (!"".equals(sTeams)) {	// ��ü������ �ƴ� ���
			doc_title = "���� ���� ������ ��� " + bean3.get("title_class")+" "+ bean3.get("title_date");
		}else{
			doc_title = "���� ���� ���� ��� " + bean3.get("title_date");
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
	
		//�׼��� ��Ÿ���� �������ִ� �κ�.
		HSSFFont fontH = wb.createFont();
		fontH.setFontHeightInPoints((short) 17);
		fontH.setFontName("����");
		fontH.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		fontH.setUnderline(HSSFFont.U_SINGLE);
	
		//�⺻ ��Ʈ : �� ���� �⺻ ��
		HSSFFont font = wb.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("����");
	
		HSSFFont fontG = wb.createFont();
		fontG.setFontHeightInPoints((short) 12.5);
		fontG.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		
		fontG.setFontName("�ü�");
	
	
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
	
		//�̰͸� ����....
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
	
		//��Ʈ���� ����
		wb.setSheetName(0, sheetname, HSSFWorkbook.ENCODING_UTF_16);
	
	
		//�÷� width ����
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
		cell.setCellValue(""+ doc_title );// 1������ ������ 
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
		
		
		for(int i=1; i<=totalCount; i++){	//��������.
			bean3 = (BaseDataClass)data.get(i-1); // i=1���� ����  bean�� 0����.. bean init.

			rowNum++; // ���� Line
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)13 );
	
			rowNum++; // �̸�, �������
			row = sheet.createRow(rowNum);
			row.setHeightInPoints( (float)27 );
			for(int j=0 ; j<6; j++){
				cell = row.createCell((short)j);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(styleC);	// ���Ⱑ 1�� �������� �ֻ�� ���ε�..
				cell.setCellValue("");
			}
			cell = row.getCell((short) 0);
			cell.setCellStyle(styleC);
			cell.setCellValue(i);
			
			//���� ������ �����ϸ�! �ε�.. ����.. �̰� ��...
			if (!bean3.get("manage_no").equals("")) {
				cell = row.getCell((short) 1);
//				cell.setCellValue("�� ��");	//���Ⱑ ���� ���� ����߸��� �κ�....����;;
		
				anchor    = new HSSFClientAnchor(20,20,1003,235,(short)1,rowNum,(short)1,rowNum+4); // �ִ�ũ�� : (0,0)-(1023,255)
				anchor.setAnchorType(2);        // 0 = Move and size with Cells, 2 = Move but don't size with cells, 3 = Don't move or size with cells.
	
				FileInputStream       fis = null;
				ByteArrayOutputStream bos = null;
				int pictureIndex;
				int c;
	
				String path = request.getRealPath("/Sales/file/photo/cust/" + bean3.get("manage_no") + ".JPG");	//�������
				String pathDefault = request.getRealPath("/Sales/file/photo/cust/default.JPG");	//����Ʈ ����
				try {
				    File f = new File(path);				
					if(f.isFile()){ //������ ������?
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
			cell.setCellValue("�̸�");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleG);
			cell.setCellValue(" "+ bean3.get("cust_nm1") );	//���Ⱑ �̸��� �����ϴ� �κ�
				//
			cell = row.getCell((short) 4);
			cell.setCellValue("�������");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("birthday") );
	
			rowNum++; // ����,����/����
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
			cell.setCellValue("����");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("gender_nm") );
			cell = row.getCell((short) 4);
			cell.setCellValue("����/����");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("comp_nm1") );
	
			rowNum++; // ���Ը���
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
			cell.setCellValue("���Ը���");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("north_purpose") );	// �ӽ÷� �������� �ھ� ����. 2007-12-04 �ɵ���
	
			rowNum++; // ����,����
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
			cell.setCellValue("��������");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("tour_no") );	//tour_no
			cell = row.getCell((short) 4);
			cell.setCellValue("��������");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("sn_datetime") );
	
			rowNum++; // ������
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
			cell.setCellValue("������");
			cell = row.getCell((short) 3);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("address1") );
			cell = row.getCell((short) 4);
			cell.setCellValue("��߳���");
			cell = row.getCell((short) 5);
			cell.setCellStyle(styleC);
			cell.setCellValue(" "+ bean3.get("ns_datetime") );
	
			sheet.addMergedRegion(new Region(rowNum - 4, (short) 0, rowNum, (short) 0));
			sheet.addMergedRegion(new Region(rowNum - 4, (short) 1, rowNum, (short) 1));
			sheet.addMergedRegion(new Region(rowNum - 2, (short) 3, rowNum - 2, (short) 5));


//			if (!"".equals(sTeams)) {	// ��ü������ �ƴ� ��� -> 2���������� ������ ǥ��

			//������ ������ �ݺ� 2008-10-13 �ɵ���. (with ������, �ǹ���)	
			//ù�ٸ� ������ ���� 2008-10-20	�ɵ���
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
				cell.setCellValue(""+doc_title); //�ݺ� ������ ������..
				sheet.addMergedRegion(new Region(rowNum, (short) 0, rowNum, (short) 5));
	
			}*/
//			}
	
	
	
		}	//for(int i=1; i<=totalCount; i++){	//��������.
	
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
