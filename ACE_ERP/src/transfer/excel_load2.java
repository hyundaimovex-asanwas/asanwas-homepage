package transfer;

import java.io.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.hssf.record.*;
import org.apache.poi.hssf.model.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;
import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import transfer.NumFormat;

public class excel_load2 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;
		NumFormat nf;

		int error_row = 0;
		int error_col = 0;

		String [] cel_value = {	"순번","적재차량","상차지","HS코드","영문명",	
														"반출일자","품명","규격","수량단위","수량",
														"단가(원)","금액(원)","단위포장별 수량","단위포장별 무게(KG)","단위포장별 길이(CM)",
														"단위포장별 폭(CM)","단위포장별 높이(CM)","단위포장별 용적(CBM)","단위포장별 총수량","총용적(CBM)",
														"총무게(KG)","비고"};

		String excelfile = "";

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			StringBuffer e_msg = new StringBuffer();

			try {
				//conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				excelfile = req.getParameter("v_str1");
				String ls_path = "/HdAsan/upload_file/";
				excelfile = ls_path + excelfile;

				if (excelfile == null) excelfile = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PARM1", "PARM2", "PARM3", "PARM4", "PARM5",
																					"PARM6", "PARM7", "PARM8", "PARM9", "PARM10",
																					"PARM11", "PARM12", "PARM13", "PARM14", "PARM15",
																					"PARM16", "PARM17", "PARM18", "PARM19", "PARM20",
																					"PARM21", "PARM22", "PARM23", "PARM24",
																					"DARM1", "DARM2", "DARM3", "DARM4", "DARM5",
																					"DARM6", "DARM7", "DARM8", "DARM9", "DARM10",
																					"DARM11", "DARM12", "DARM13", "DARM14", "DARM15",
																					"DARM16", "DARM17", "DARM18", "DARM19", "DARM20",
																					"DARM21", "DARM22", "DARM23", "DARM24"
																				}; 

				int[] intArrCN = new int[]{ 3, 50, 50, 50, 50,
																	 50, 50, 50, 50, 50,
																	 12, 12, 12, 12, 12,
																	 12, 12, 12, 12, 12,
																	 12, 12, 50, 50,
																		1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,
																		1,  1,  1,  1
																	}; 
			
				int[] intArrCN2 = new int[]{  0, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		  1,  1,  1,  1,  1,
																		  1,  1,  1,  3,  1,
																		  3,  1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelfile)); 

				//워크북을 생성!                
	      HSSFWorkbook workbook = new HSSFWorkbook(fs);

				GauceDataRow grow = null;

				int sheetNum = workbook.getNumberOfSheets();
				int icellnum = 0;
				int iamt10 = 0;
				int iamt11 = 0;
				int iamt12 = 0;
				int iamt13 = 0;
				int iamt14 = 0;
				int iamt15 = 0;
				int iamt16 = 0;
				int iamt17 = 0;
				int iamt18 = 0;
				int iamt19 = 0;
				int iamt20 = 0;
				int iamt21 = 0;
				int iamt0 = 0;

				String damt10 = "Y";
				String damt11 = "Y";
				String damt12 = "Y";
				String damt13 = "Y";
				String damt14 = "Y";
				String damt15 = "Y";
				String damt16 = "Y";
				String damt17 = "Y";
				String damt18 = "Y";
				String damt19 = "Y";
				String damt20 = "Y";
				String damt21 = "Y";

				float fint = (Float.parseFloat("0.1"));
				String sgbn = "";

//				for (int k = 0; k < sheetNum; k++) {
				for (int k = 0; k < 1; k++) {

					HSSFSheet sheet = workbook.getSheetAt(k);
          int rows = sheet.getPhysicalNumberOfRows();
					int icnt = 0;

					for (int t = 20; t < rows; t++) {
						HSSFRow rowt   = sheet.getRow(t);
						HSSFCell cellf  = rowt.getCell((short)7); 
						sgbn = cellf.getStringCellValue();

						if (sgbn != null && !sgbn.equals("")) {
							icnt++;
						} else break;
					}

					icnt = icnt + 20;

					if (icnt==20)	{
						error_row = 20;
						error_col = 0;
						int ichk_a = (int) (Float.parseFloat("A"));
					}

					for (int r = 20; r < icnt; r++) {
						error_row = r;
			      // 시트에 대한 행을 하나씩 추출
						HSSFRow row   = sheet.getRow(r);
						if (row != null) { 
							int cells = row.getPhysicalNumberOfCells();
							grow = dSet.newDataRow();

							for (short c = 0; c < cells; c++) {
								// 행에대한 셀을 하나씩 추출하여 셀 타입에 따라 처리
								HSSFCell cell  = row.getCell(c);
								icellnum = cell.getCellNum();
								error_col = c;

								if (cell != null) { 
									String value = null;
									
									switch (cell.getCellType()) {
										case HSSFCell.CELL_TYPE_FORMULA :
											value = cell.getCellFormula()+"";
											break;
										case HSSFCell.CELL_TYPE_NUMERIC :
											value = cell.getNumericCellValue()+""; //double
											break;
										case HSSFCell.CELL_TYPE_STRING :
											value = cell.getStringCellValue()+""; //String
											break;
										case HSSFCell.CELL_TYPE_BLANK :
											value = null+"";
											break;
										case HSSFCell.CELL_TYPE_BOOLEAN :
											value = cell.getBooleanCellValue()+""; //boolean
											break;
										case HSSFCell.CELL_TYPE_ERROR :
											value = cell.getErrorCellValue()+""; // byte
											break;
										default :
									}

									value = value.trim();

									if (icellnum==0) grow.addColumnValue((int) (Float.parseFloat(value)));
									else if (icellnum>9 && icellnum<22) {
										if (value.equals("")) value = "0.0";
										else if (value.equals("null")) value = "0.0";

										if (c==10) {
											nf = new NumFormat();

											if (nf.NumFormat(value).equals("Y")) iamt10 = (int) (Float.parseFloat(value));
											else {
												iamt10 = 0;
												damt10 = "N";
											}

											grow.addColumnValue(iamt10);
											nf = null;

										} else if (c==11) {
											nf = new NumFormat();

											if (nf.NumFormat(value).equals("Y")) iamt11 = (int) (Float.parseFloat(value));
											else {
												iamt11 = 0;
												damt11 = "N";
											}

											grow.addColumnValue(iamt11);
											nf = null;
										} else if (c==12) {
											if (iamt10==0 || iamt11==0) {
												iamt12 = 0;
												damt12 = "N";
											} else iamt12 = iamt10*iamt11;

											grow.addColumnValue(iamt12);
										} else if (c==13) {	//단위포장별 수량
											nf = new NumFormat();

											if (nf.NumFormat(value).equals("Y")) iamt13 = (int) (Float.parseFloat(value));
											else {
												iamt13 = iamt10;
												damt13 = "N";
											}

											grow.addColumnValue(iamt13);
											nf = null;

										} else if (c==18) {	//단위포장별 용적
											String samt18 = "";
											if (iamt15==0 || iamt16==0 || iamt17==0) {
												iamt18 = 0;
												damt18 = "N";
											} else {
												int iflag = 0;
												if (iamt15>100) iamt15 = iamt15/100;
												else iflag++;

												if (iamt16>100) iamt16 = iamt16/100;
												else iflag++;

												if (iamt17>100) iamt17 = iamt17/100;
												else iflag++;

												if (iflag==0)
													samt18 = iamt15*iamt16*iamt17 + "";
												else {
													int val = 1;
													for (int w=0;w<iflag;w++) val = val * 100;
													
													String s1 = iamt15 + "";
													String s2 = iamt16 + "";
													String s3 = iamt17 + "";

													samt18 = Float.parseFloat(s1)*Float.parseFloat(s2)*Float.parseFloat(s3)/val + "";
												}
											}

											grow.addColumnValue(Float.parseFloat(samt18) );

										} else if (c==19) {	//단위포장별 총수량
											if (iamt10==0 || iamt13==0) {
												iamt19 = 0;
												damt19 = "N";
											} else iamt19 = iamt10/iamt13;

											grow.addColumnValue(iamt19);
										} else if (c==20) {	//총용적
											if (iamt18==0 || iamt19==0) {
												iamt20 = 0;
												damt20 = "N";
											} else iamt20 = iamt18*iamt19;

											grow.addColumnValue(iamt20);
										} else if (c==21) {	//총중량
											if (iamt14==0 || iamt19==0) {
												iamt21 = 0;
												damt21 = "N";
											} else iamt21 = iamt14*iamt19;

											grow.addColumnValue(iamt21);
										} else if (c==14 || c==15 || c==16 || c==17) {
											nf = new NumFormat();

											if (nf.NumFormat(value).equals("Y")) {
												if (c==14) iamt14 = (int) (Float.parseFloat(value));
												else if (c==15) iamt15 = (int) (Float.parseFloat(value));
												else if (c==16) iamt16 = (int) (Float.parseFloat(value));
												else if (c==17) iamt17 = (int) (Float.parseFloat(value));
											} else {
												if (c==14) {
													iamt14 = 0;
													damt14 = "N";
												} else if (c==15) {
													iamt15 = 0;
													damt15 = "N";
												} else if (c==16) {
													iamt16 = 0;
													damt16 = "N";
												} else if (c==17) {
													iamt17 = 0;
													damt17 = "N";
												}
											}

											if (c==14) grow.addColumnValue(iamt14);
											else if (c==15) grow.addColumnValue(iamt15);
											else if (c==16) grow.addColumnValue(iamt16);
											else if (c==17) grow.addColumnValue(iamt17);
											
											nf = null;
										} else grow.addColumnValue(value);
									} else if (value.equals("null")) grow.addColumnValue("");
									else if (value.equals("")) grow.addColumnValue("");
									else grow.addColumnValue(new String(value.getBytes("euc_kr"),"ksc5601"));

									if (icellnum==6) {logger.dbg.println(this,"celnum 6 : " + value); }

								
								} 
							}

							for (int a=0;a<9 ;a++ ) grow.addColumnValue("N");

							grow.addColumnValue(damt10);
							grow.addColumnValue(damt11);
							grow.addColumnValue(damt12);
							grow.addColumnValue(damt13);
							grow.addColumnValue(damt14);
							grow.addColumnValue(damt15);
							grow.addColumnValue(damt16);
							grow.addColumnValue(damt17);
							grow.addColumnValue(damt18);
							grow.addColumnValue(damt19);
							grow.addColumnValue(damt20);
							grow.addColumnValue(damt21);

							grow.addColumnValue("N");
							grow.addColumnValue("N");
							dSet.addDataRow(grow);

						}
					}
				}

				//읽어들인 파일 지우기
				File fd = new File(excelfile);
				if(fd.isFile()) fd.delete();

			} catch(Exception e) {

				logger.dbg.println(this,e_msg.toString());

				error_row++;

				GauceDataRow erow = null;
				erow = dSet.newDataRow();
				erow.addColumnValue(0);
				erow.addColumnValue("Y");

				String err_msg = error_row + "번째 행의 " + cel_value[error_col-1];
				erow.addColumnValue(new String(err_msg.getBytes("euc_kr"),"ksc5601"));

				dSet.addDataRow(erow);

		  	logger.err.println(this,e);

				//읽어들인 파일 지우기
				File fd = new File(excelfile);
				if(fd.isFile()) fd.delete();


		  } finally {
				if (stmt != null) try {stmt.close();} catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,"error : " + e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	} //public void
} //

