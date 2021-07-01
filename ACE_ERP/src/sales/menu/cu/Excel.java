package sales.menu.cu;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

import jxl.CellType;
import jxl.DateCell;
import jxl.LabelCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.biff.EmptyCell;
import jxl.read.biff.BiffException;
import jxl.read.biff.BlankCell;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;


public class Excel extends HttpServlet {
	
	private Hashtable cu009;
	private Hashtable cu002;
	private Hashtable sy009;
	private Hashtable cu001;
	private Hashtable cu004;
	private Hashtable rv003;
	private Hashtable sy005;
	private Hashtable cu003;
	private Hashtable cu008;
	
	private Hashtable client;
	private Hashtable clientSid;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException {
	
		setCode(req, res);	// �����ڵ� 
		readCustExcel(req, res);
	}
	
	public void writeExcel() {
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(new File("D:/temp/myExcelFile.xls")); // ���� ���� ���� ��Ʈ
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
	
			jxl.write.WritableCellFormat format= new WritableCellFormat();
			jxl.write.WritableCellFormat format0= new WritableCellFormat();
	
			format.setBackground(jxl.format.Colour.GRAY_25 );
			format.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			format.setAlignment(jxl.format.Alignment.CENTRE);
	
			format0.setBackground(jxl.format.Colour.WHITE );
			format0.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			format0.setAlignment(jxl.format.Alignment.CENTRE);
			sheet.setColumnView(0,8);
	
			jxl.write.Label label =null;
			jxl.write.Blank blank=null;
	
			label = new jxl.write.Label(0,0,"�����",format);
			sheet.addCell(label);
			label = new jxl.write.Label(1,0,"�׽�Ʈ",format);
			sheet.addCell(label);
			label = new jxl.write.Label(2,0,"������",format);
			sheet.addCell(label);
			label = new jxl.write.Label(3,0,"�׽�Ʈ",format);
			sheet.addCell(label);
			blank = new jxl.write.Blank(4,0,format0);
			sheet.addCell(blank );
	
			for(int h=1;h<51;h++) {
			for(int i=0;i<10;i++) {
				label = new jxl.write.Label(i, h, "("+i+","+h+")",format0);
				sheet.addCell(label);
				}
			}
			workbook.write();
			workbook.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriteException e) {
			e.printStackTrace();
		}
	}

		
	public void readExcel(HttpServletRequest req,HttpServletResponse res) {
		
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

//		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet ���� 			
			ds1 = new GauceDataSet(); 		
			gceRes.enableFirstRow(ds1);
			
			Workbook workbook = Workbook.getWorkbook(new File("D:/temp/Book1.xls"));  /// �о�� ���ϸ�
		
			Sheet sheet0 = workbook.getSheet("Sheet1"); // Sheet�� 
			
			StringUtil.printMsg("Column == > " + sheet0.getColumns(),this); // ��Ʈ�� ����� Į�� 
			StringUtil.printMsg("Row ==> " + sheet0.getRows(),this);
			
			String arr[][] = new String[sheet0.getRows()][sheet0.getColumns()];
			
			for (int row = 0; row < sheet0.getRows(); row++) {	
				 
				// ����Ÿ��
				for (int column =0; column < sheet0.getColumns(); column++)	 {
					String content = "";
	
					if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
						
						NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
						content = numberCell.getValue()+""; 
						
						arr[row][column] = content;
				// ����Ÿ��		
					} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
				
						LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
						content = labelCell.getString()+"";
						
						arr[row][column] = content;
				// ���� Ÿ�� 		
					} else if(sheet0.getCell(column,row).getType() == CellType.DATE)	{
					
						DateCell dateCell = (DateCell) sheet0.getCell(column,row);
						content = dateCell.getDate()+"";
						
						arr[row][column] = content;
					}
				}
			}

			/*
			 * DataSet Header
			 */
			ds1.addDataColumn(new GauceDataColumn("key_seq",    GauceDataColumn.TB_STRING,10));
			ds1.addDataColumn(new GauceDataColumn("name",   	GauceDataColumn.TB_STRING, 10));
			/*
			 * ������ ������ ���� ������ �´� 
			 */
			
			for (int row = 1; row < sheet0.getRows(); row++) {
				GauceDataRow gRow = ds1.newDataRow();
				for (int column = 0; column < sheet0.getColumns(); column++) {
					StringUtil.printMsg(arr[row][column],this);
					
					gRow.addColumnValue(arr[row][column]);
					
				}
				ds1.addDataRow(gRow);
				StringUtil.printMsg("-------------------------------------",this);
			}

			StringUtil.printMsg(ds1.getName(),this);
			StringUtil.printMsg(ds1.getDataColCnt()+"",this);
			StringUtil.printMsg(ds1.getDataRowCnt()+"",this);
			
			
			ds1.flush();
			gceRes.flush();
			gceRes.commit();
			gceRes.close();
		} catch (FileNotFoundException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			loader.restoreService(service);
		}
	}
	
	
	// �� ���� �۾� 
	public void readCustExcel(HttpServletRequest req,HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet ���� 			
			ds1 = new GauceDataSet(); 		
			gceRes.enableFirstRow(ds1);
			
			Workbook workbook = Workbook.getWorkbook(new File("D:/temp/Book1.xls"));  /// �о�� ���ϸ�
		
			Sheet sheet0 = workbook.getSheet("Sheet1"); // Sheet�� 
			
//			StringUtil.printMsg("Column == > " + sheet0.getColumns(),this); // ��Ʈ�� ����� Į�� 
//			StringUtil.printMsg("Row ==> " + sheet0.getRows(),this);
			
			String arr[][] = new String[sheet0.getRows()][58];
			
			for (int row = 0; row < sheet0.getRows(); row++) {	
				 
				// ����Ÿ��
				for (int column =0; column < sheet0.getColumns(); column++)	 {
					String content = "";
					
					if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
						
						NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
						content = numberCell.getValue()+""; 
						
						arr[row][column+1] = content;
				// ����Ÿ��		
					} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
				
						LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
						content = labelCell.getString()+"";
						
						arr[row][column+1] = content;
				// ���� Ÿ�� 		
					} else if(sheet0.getCell(column,row).getType() == CellType.DATE)	{
					
						DateCell dateCell = (DateCell) sheet0.getCell(column,row);
						content = dateCell.getDate()+"";
						
						arr[row][column+1] = content;
					} 
				}
				arr[row][0] = ""; // sid�κ� 
				
				for (int i = 29 ; i < 58; i++) {
					arr[row][i] = "";
				}
			}

			/*
			 * DataSet Header
			 */
			
			ds1.addDataColumn(new GauceDataColumn("client_sid",      GauceDataColumn.TB_STRING, 5)); // 0
			
			ds1.addDataColumn(new GauceDataColumn("client_cd",      GauceDataColumn.TB_STRING, 10));  // 1
			ds1.addDataColumn(new GauceDataColumn("cust_nm",        GauceDataColumn.TB_STRING, 20)); // 2
			ds1.addDataColumn(new GauceDataColumn("last_nm",        GauceDataColumn.TB_STRING, 10)); //3
			ds1.addDataColumn(new GauceDataColumn("first_nm",       GauceDataColumn.TB_STRING, 20)); //4
			ds1.addDataColumn(new GauceDataColumn("manege_no",      GauceDataColumn.TB_STRING, 20)); //5
			ds1.addDataColumn(new GauceDataColumn("group_cd",       GauceDataColumn.TB_STRING, 20)); //6
			ds1.addDataColumn(new GauceDataColumn("sex",    		GauceDataColumn.TB_STRING, 1));  // 7
			ds1.addDataColumn(new GauceDataColumn("height",         GauceDataColumn.TB_STRING, 3));	// 8
			ds1.addDataColumn(new GauceDataColumn("bithday",        GauceDataColumn.TB_STRING, 8)); // 9
			ds1.addDataColumn(new GauceDataColumn("regi_yn",        GauceDataColumn.TB_STRING, 1)); // 10
			ds1.addDataColumn(new GauceDataColumn("cust_gu",        GauceDataColumn.TB_STRING, 1)); // 11
			ds1.addDataColumn(new GauceDataColumn("country_gu",     GauceDataColumn.TB_STRING, 2)); // 12
			ds1.addDataColumn(new GauceDataColumn("saup_gu",        GauceDataColumn.TB_STRING, 2)); // 13
			ds1.addDataColumn(new GauceDataColumn("cust_type",      GauceDataColumn.TB_STRING, 3)); // 14
			ds1.addDataColumn(new GauceDataColumn("country_cd",     GauceDataColumn.TB_STRING, 3));	// 15
			ds1.addDataColumn(new GauceDataColumn("nation_cd",      GauceDataColumn.TB_STRING, 2));	// 16
			ds1.addDataColumn(new GauceDataColumn("tel_no",         GauceDataColumn.TB_STRING, 20));	// 17
			ds1.addDataColumn(new GauceDataColumn("mobile_no",      GauceDataColumn.TB_STRING, 15)); // 18
			ds1.addDataColumn(new GauceDataColumn("company_nm",     GauceDataColumn.TB_STRING, 30)); // 19
			ds1.addDataColumn(new GauceDataColumn("positions",      GauceDataColumn.TB_STRING, 30)); // 20
			ds1.addDataColumn(new GauceDataColumn("eng_company_nm", GauceDataColumn.TB_STRING, 30)); // 21
			ds1.addDataColumn(new GauceDataColumn("eng_position",   GauceDataColumn.TB_STRING, 30)); // 22
			ds1.addDataColumn(new GauceDataColumn("zip_cd",         GauceDataColumn.TB_STRING, 6)); // 23
			ds1.addDataColumn(new GauceDataColumn("address1",       GauceDataColumn.TB_STRING, 60)); // 24
			ds1.addDataColumn(new GauceDataColumn("address2",       GauceDataColumn.TB_STRING, 60)); // 25
			ds1.addDataColumn(new GauceDataColumn("eng_addr1",      GauceDataColumn.TB_STRING, 60)); // 26
			ds1.addDataColumn(new GauceDataColumn("pass_type",      GauceDataColumn.TB_STRING, 2)); // 27
			ds1.addDataColumn(new GauceDataColumn("pass_no",        GauceDataColumn.TB_STRING, 20)); // 28

			ds1.addDataColumn(new GauceDataColumn("client_sid_yn",      GauceDataColumn.TB_STRING, 2)); // 29
			ds1.addDataColumn(new GauceDataColumn("client_cd_yn",      GauceDataColumn.TB_STRING, 2));  // 30
			ds1.addDataColumn(new GauceDataColumn("cust_nm_yn",        GauceDataColumn.TB_STRING, 2)); //31
			ds1.addDataColumn(new GauceDataColumn("last_nm_yn",        GauceDataColumn.TB_STRING, 2)); //32
			ds1.addDataColumn(new GauceDataColumn("first_nm_yn",       GauceDataColumn.TB_STRING, 2)); // 33
			ds1.addDataColumn(new GauceDataColumn("manege_no_yn",      GauceDataColumn.TB_STRING, 2)); // 34
			ds1.addDataColumn(new GauceDataColumn("group_cd_yn",       GauceDataColumn.TB_STRING, 2)); // 35
			ds1.addDataColumn(new GauceDataColumn("sex_yn",				GauceDataColumn.TB_STRING, 2)); // 36
			ds1.addDataColumn(new GauceDataColumn("height_yn",         	GauceDataColumn.TB_STRING, 2));  // 37
			ds1.addDataColumn(new GauceDataColumn("bithday_yn",        	GauceDataColumn.TB_STRING, 2));  // 38
			ds1.addDataColumn(new GauceDataColumn("regi_yn_yn",        GauceDataColumn.TB_STRING, 2)); // 39
			ds1.addDataColumn(new GauceDataColumn("cust_gu_yn",        GauceDataColumn.TB_STRING, 2)); // 40
			ds1.addDataColumn(new GauceDataColumn("country_gu_yn",     GauceDataColumn.TB_STRING, 2)); // 41
			ds1.addDataColumn(new GauceDataColumn("saup_gu_yn",        GauceDataColumn.TB_STRING, 2)); // 42
			ds1.addDataColumn(new GauceDataColumn("cust_type_yn",      GauceDataColumn.TB_STRING, 2)); // 43
			ds1.addDataColumn(new GauceDataColumn("country_cd_yn",     GauceDataColumn.TB_STRING, 2)); // 44
			ds1.addDataColumn(new GauceDataColumn("nation_cd_yn",      GauceDataColumn.TB_STRING, 2)); // 45
			ds1.addDataColumn(new GauceDataColumn("tel_no_yn",         GauceDataColumn.TB_STRING, 2)); // 46
			ds1.addDataColumn(new GauceDataColumn("mobile_no_yn",      GauceDataColumn.TB_STRING, 2)); // 47
			ds1.addDataColumn(new GauceDataColumn("company_nm_yn",     GauceDataColumn.TB_STRING, 2)); // 48
			ds1.addDataColumn(new GauceDataColumn("positions_yn",      GauceDataColumn.TB_STRING, 2)); // 49
			ds1.addDataColumn(new GauceDataColumn("eng_company_nm_yn", GauceDataColumn.TB_STRING, 2)); // 50 
			ds1.addDataColumn(new GauceDataColumn("eng_position_yn",   GauceDataColumn.TB_STRING, 2)); //51
			ds1.addDataColumn(new GauceDataColumn("zip_cd_yn",         GauceDataColumn.TB_STRING, 2)); // 52
			ds1.addDataColumn(new GauceDataColumn("address1_yn",       GauceDataColumn.TB_STRING, 2)); // 53
			ds1.addDataColumn(new GauceDataColumn("address2_yn",       GauceDataColumn.TB_STRING, 2)); // 54
			ds1.addDataColumn(new GauceDataColumn("eng_addr1_yn",      GauceDataColumn.TB_STRING, 2)); // 55
			ds1.addDataColumn(new GauceDataColumn("pass_type_yn",      GauceDataColumn.TB_STRING, 2)); // 56
			ds1.addDataColumn(new GauceDataColumn("pass_no_yn",        GauceDataColumn.TB_STRING, 2)); // 57

			/*
			 * ������ �����Ͱ� �ִ� ������ �о �� �ʵ��� ���� üũ�� �Ѵ� 
			 * ����üũ�� �ϱ�鼭 ������ �ִ°�쿡�� ȭ�鿡 ������ ǥ�ø� ���ش� 
			 */
			for (int row = 1; row < sheet0.getRows(); row++) {
				GauceDataRow gRow = ds1.newDataRow();
				for (int column = 1; column < sheet0.getColumns()+1; column++) {
					
					// ����ó �ڵ� 
					if (column==1) {  
						if (arr[row][column] != null && !arr[row][column].equals("") && arr[row][column].length() > 0) {
							if (arr[row][column].length() <= 5) { 
								
								if (checkClientCode(arr[row][column],arr[row][column], req, res)) { // Client Code�� Ȯ�� 
									
									arr[row][0] = getClientSid(arr[row][column], req, res); // Client Sid ������ 
									arr[row][column+29] = "T";
									gRow.addColumnValue(arr[row][0]);
								} else {
									arr[row][0] ="";
									arr[row][column+29] = "F";
									gRow.addColumnValue(arr[row][0]);
								}
								
							} else {
								arr[row][0] = "";
								arr[row][column+29] = "F";
								gRow.addColumnValue(arr[row][0]);
							}
						} else {
							arr[row][0] = "";
							arr[row][column+29] = "F";
							gRow.addColumnValue(arr[row][0]);
						}
					} 
					
					
					// ���� 
					else if (column==2) {
						if (arr[row][column].length() <= 20) {
							arr[row][column+29] = "T";
						} else {
							arr[row][column+29] = "F";
						}
					}
					
					// ������
					else if (column==3) {
						if (arr[row][column].length() <= 10) {
							arr[row][column+29] = "T";
						} else {
							arr[row][column+29] = "F";
						}
					}				
					
					// �����̸�
					else if (column==4) {
						if (arr[row][column].length() <= 20) {
							arr[row][column+29] = "T";
							
						} else {
							arr[row][column+29] = "F";
						}
					}				
					
					// �ֹ�/���ǹ�ȣ
					else if (column==5) {
						if (arr[row][column].length() <= 15) {
							
							if (checkManageNo(arr[row][column], req, res)) {
								arr[row][column+29] = "T";
							} else {
								arr[row][column+29] = "F";
							}
							arr[row][column+29] = "T";
						} else {
							arr[row][column+29] = "F";
						}
					}					
					
					// �׷��ڵ� 
					else if (column==6) {
						if (arr[row][column].length() <= 20) {
							arr[row][column+29] = "T";
						} else {
							arr[row][column+29] = "F";
						}
					}		
					
					// ���� 
					else if (column==7) { 
						if (arr[row][column].length() <= 1) {
							if (checkCode("SY009",arr[row][column])) {
								arr[row][column+29] = "T";	
							} else {
								arr[row][column+29] = "F";
							}
							
						} else {
							arr[row][column+29] = "F";
						}
					} 
					
					// ����
					else if (column==8) {
						if (arr[row][column].length() <= 3) {
							
							if(checkNum(arr[row][column])) {
								arr[row][column+29] = "T";
								StringUtil.printMsg("����  �ڵ� ���", this);
							} else {
								arr[row][column+29] = "F";
								StringUtil.printMsg("����  ���� ����", this);
							}
							
						} else {
							arr[row][column+29] = "F";
							StringUtil.printMsg("���� ���̿��� ", this);
						}
					}		
					
					// ������� 
					else if (column==9) {
						if (arr[row][column].length() <= 8) {
							arr[row][column+29] = "T";
							StringUtil.printMsg("������� �ڵ� ���", this);
						} else {
							arr[row][column+29] = "F";
							StringUtil.printMsg("������� ���̿��� ", this);
						}
					}				
					
					// �������� 
					else if (column==10) {
						if (arr[row][column].length() <= 1) {
							arr[row][column+29] = "T";
							StringUtil.printMsg("�������� �ڵ� ���", this);
						} else {
							arr[row][column+29] = "F";
							StringUtil.printMsg("�������� ���̿��� ", this);
						}
					}				
					
					// ������
					else if (column==11) { 
						if (arr[row][column].length() <= 1) {
							if(checkCode("CU001",arr[row][column])) {
								arr[row][column+29] = "T";	
							} else {
								arr[row][column+29] = "F";
							}
						} else {
							arr[row][column+29] = "F";
						}
					} 
					
					// �������� 
					else if (column==12) {
						if (arr[row][column].length() <= 2) {
							if (checkCode("CU009",arr[row][column])) {
								arr[row][column+29] = "T";
							} else {
								arr[row][column+29] = "F";
							}
							
						} else {
							arr[row][column+29] = "F";
						}
					} 
					
					// �������
					else if (column==13) {
						if (arr[row][column].length() <= 2) {
							if (checkCode("CU004",arr[row][column])) {
								arr[row][column+29] = "T";								
							} else {
								arr[row][column+29] = "F";
							}

						} else {
							arr[row][column+29] = "F";
						}
					} 
					
					// ������ 
					else if (column==14) { 
						if (arr[row][column].length() <= 3) {
							if (checkCode("RV003",arr[row][column])) {
								arr[row][column+29] = "T";								
							} else {
								arr[row][column+29] = "F";
							}
						} else {
							arr[row][column+29] = "F";
						}
					} 
					
					// ���� 
					else if (column==15) {
						if (arr[row][column].length() <= 3) {
							if (checkCode("SY005",arr[row][column])) {
								arr[row][column+29] = "T";	
							} else {
								arr[row][column+29] = "F";
							}
							
						} else {
							arr[row][column+29] = "F";
						}
					}
					
					// ���� 
					else if (column==16) { 
						if (arr[row][column].length() <= 2) {
							if (checkCode("CU003",arr[row][column])) {
								arr[row][column+29] = "T";	
							} else {
								arr[row][column+29] = "F";
							}
						} else {
							StringUtil.printMsg("�����ڵ� ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					} 
					
					// ������ȭ
					else if (column==17) {
						if (arr[row][column].length() <= 20) {
							StringUtil.printMsg("������ȭ �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("������ȭ ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}	
					
					// ��󿬶�ó 
					else if (column==18) {
						if (arr[row][column].length() <= 15) {
							StringUtil.printMsg("��󿬶�ó �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("��󿬶�ó ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}	
					
					// �����
					else if (column==19) {
						if (arr[row][column].length() <= 30) {
							StringUtil.printMsg("����� �ڵ� ���", this);
							arr[row][column+29] = "F";
						} else {
							StringUtil.printMsg("����� ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}
					
					// ����
					else if (column==20) {
						if (arr[row][column].length() <= 30) {
							StringUtil.printMsg("���� �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("���� ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}
					
					// ���������
					else if (column==21) {
						if (arr[row][column].length() <= 30) {
							StringUtil.printMsg("��������� �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("��������� ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}
					
					// ���� ���� 
					else if (column==22) {
						if (arr[row][column].length() <= 30) {
							StringUtil.printMsg("��������  �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("���� ���� ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}
					
					// �����ȣ
					else if (column==23) {
						if (arr[row][column].length() <= 6) {
							StringUtil.printMsg("�����ȣ �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("�����ȣ ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}
					
					// �ּ� 1
					else if (column==24) {
						if (arr[row][column].length() <= 60) {
							StringUtil.printMsg("�ּ�1 �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("�ּ�1 ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}
					
					// �ּ� 2
					else if (column==25) {
						if (arr[row][column].length() <= 60) {
							arr[row][column+29] = "T";
							StringUtil.printMsg("�ּ�2 �ڵ� ���", this);
						} else {
							arr[row][column+29] = "F";
							StringUtil.printMsg("�ּ�2 ���̿��� ", this);
						}
					}
					
					// �����ּ� 1
					else if (column==26) {
						if (arr[row][column].length() <= 60) {
							arr[row][column+29] = "T";
							StringUtil.printMsg("�����ּ�1 �ڵ� ���", this);
						} else {
							arr[row][column+29] = "F";
							StringUtil.printMsg("�����ּ�1 ���̿��� ", this);
						}
					}
					
					// ���� ����
					else if (column==27) { 
						if (arr[row][column].length() <= 2) {
							if (checkCode("CU008",arr[row][column])) {
								arr[row][column+29] = "T";
							} else {
								arr[row][column+29] = "F";
							}
							
						} else {
							arr[row][column+29] = "F";
						}
					}
					
					// ���Ǹ����� 
					else if (column==28) {
						if (arr[row][column].length() <= 8) {
							StringUtil.printMsg("���Ǹ����� �ڵ� ���", this);
							arr[row][column+29] = "T";
						} else {
							StringUtil.printMsg("���Ǹ����� ���̿��� ", this);
							arr[row][column+29] = "F";
						}
					}
					
					gRow.addColumnValue(arr[row][column]);
					
					
				}
				
				for (int j = 29; j < 58; j++) {
					gRow.addColumnValue(arr[row][j]);
				}
				StringUtil.printMsg("--------------------------------------------------------------", this);
				ds1.addDataRow(gRow);
			}
			
			
			for(int k = 1; k < 6; k++) {
				for (int t = 0; t < 58; t++) {
					System.out.println("["+k+"]["+t+"]" + arr[k][t]);
				}
			}
			
			ds1.flush();
			
			gceRes.flush();
			gceRes.commit();
			gceRes.close();
		}  catch (FileNotFoundException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			loader.restoreService(service);
		}
	}	
	
	
	/*
	 * �����ڵ� ���� 
	 */
	public void setCode(HttpServletRequest req, HttpServletResponse res) {
		
		StringUtil.printMsg("SET CODE", this);
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		cu009 = new Hashtable();
		cu002 = new Hashtable();
		sy009 = new Hashtable();
		cu001 = new Hashtable();
		cu004 = new Hashtable();
		rv003 = new Hashtable();
		sy005 = new Hashtable();
		cu003 = new Hashtable();
		cu008 = new Hashtable();
		
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			
			String query = "";
			
			int sCnt = 1;
			/*
			 * Code ���� 
			 */
			query   += "" 		
					+ "\n\t" + "SELECT " 									
					+ "\n\t" + "	b.head, b.detail, b.detail_nm " 
					+ "\n\t" + "FROM "
					+ "\n\t" + "	SALES.TSY011 a, " 
					+ "\n\t" + "	SALES.TSY010 b "
					+ "\n\t" + "WHERE 1=1 "
					+ "\n\t" + " AND a.head = b.head AND b.head in (" +
							"?, ?, ?, ?, ?, ?, ?, ?, ?) and length (b.detail) > 0";
			
			StringUtil.printMsg(query, this);
	//		 ���� ����
			pstmt = conn.prepareStatement(query); 
			
			pstmt.setString(sCnt++,"CU009");
			pstmt.setString(sCnt++,"CU002");
			pstmt.setString(sCnt++,"SY009");
			pstmt.setString(sCnt++,"CU001");
			pstmt.setString(sCnt++,"CU004");
			pstmt.setString(sCnt++,"RV003");
			pstmt.setString(sCnt++,"SY005");
			pstmt.setString(sCnt++,"CU003");
			pstmt.setString(sCnt++,"CU008");
			
			rs = pstmt.executeQuery(); // DataSet set
			
			while(rs.next()) {
				if (rs.getString(1).equals("CU009")) {
					cu009.put(rs.getString(2),rs.getString(3));
				} else if (rs.getString(1).equals("CU002")) {
					cu002.put(rs.getString(2),rs.getString(3));
				} else if (rs.getString(1).equals("SY009")) {
					sy009.put(rs.getString(2),rs.getString(3));
				} else if (rs.getString(1).equals("CU001")) {
					cu001.put(rs.getString(2),rs.getString(3));
				} else  if (rs.getString(1).equals("RV003")) {
					rv003.put(rs.getString(2),rs.getString(3));
				} else  if (rs.getString(1).equals("SY005")) {
					sy005.put(rs.getString(2),rs.getString(3));
				} else  if (rs.getString(1).equals("CU003")) {
					cu003.put(rs.getString(2),rs.getString(3));
				}  else  if (rs.getString(1).equals("CU008")) {
					cu008.put(rs.getString(2),rs.getString(3));
				}
			}
		
			rs.close();
		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private boolean checkCode(String key, String value) { 
		boolean flag = true;
		
		if(key.equals("CU009")) {
			for (int i = 0; i < cu009.size(); i++) {
				if (cu009.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("CU002")) {
			for (int i = 0; i < cu002.size(); i++) {
				if (cu002.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("SY009")) {
			for (int i = 0; i < sy009.size(); i++) {
				if (sy009.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("CU001")) {
			for (int i = 0; i < cu009.size(); i++) {
				if (cu001.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("CU004")) {
			for (int i = 0; i < cu004.size(); i++) {
				if (cu004.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("RV003")) {
			for (int i = 0; i < rv003.size(); i++) {
				if (rv003.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("SY005")) {
			for (int i = 0; i < sy005.size(); i++) {
				if (sy005.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("CU003")) {
			for (int i = 0; i < cu003.size(); i++) {
				if (cu003.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		} else if(key.equals("CU008")) {
			for (int i = 0; i < cu008.size(); i++) {
				if (cu008.containsKey(value)) {
					flag = true;
				} else {
					flag = false;
				}
			}
		}
		
		
		
		return flag;
	}
	
	/*
	 * ����ó �ڵ� Ȯ�� 
	 */
	private boolean checkClientCode(String key, String value, HttpServletRequest req, HttpServletResponse res) {
		boolean flag = true;
		
//		for (int i = 0; i < client.size(); i++) {
//			if (client.containsValue(value)) {
//				flag = true;
//			} else {
//				flag = false;
//			}
//		}
		
		
		StringUtil.printMsg("SET Client CODE", this);
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			
			String query = "";
			
			int Cnt = 0;
			/*
			 * Code ���� 
			 */
			
			query   += "" 		
					+ "\n\t" + "SELECT " 									
					+ "\n\t" + "	count(client_cd)" 
					+ "\n\t" + "FROM "
					+ "\n\t" + "	SALES.TCU030 " 
					+ "\n\t" + "WHERE 1=1 "
					+ "\n\t" + "	AND client_cd = ?";
			
			StringUtil.printMsg(query,this);
	//		 ���� ����
			pstmt = conn.prepareStatement(query); 
			
			pstmt.setString(1, value);
			
			rs = pstmt.executeQuery(); // DataSet set
			
			
			while(rs.next()) {
				Cnt = rs.getInt(1);
			}
		
			if (Cnt == 0) {
				flag = false;
			} else if (Cnt > 0) {
				flag = true;
			}
			
			rs.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}
	
	/*
	 * ����ó SID ���� 
	 */
	private String getClientSid(String key, HttpServletRequest req, HttpServletResponse res) {
		String sid= "";
		
		StringUtil.printMsg("SET Client CODE", this);
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			String query = "";
			
			int Cnt = 0;
			/*
			 * Code ���� 
			 */
			
			query   += "" 		
					+ "\n\t" + "SELECT " 									
					+ "\n\t" + "	client_sid " 
					+ "\n\t" + "FROM "
					+ "\n\t" + "	SALES.TCU030 " 
					+ "\n\t" + "WHERE 1=1 "
					+ "\n\t" + "	AND client_cd = ?";
			
			StringUtil.printMsg(query,this);
	//		 ���� ����
			pstmt = conn.prepareStatement(query); 
			
			pstmt.setString(1, key);
			
			rs = pstmt.executeQuery(); // DataSet set
			
			
			while(rs.next()) {
				sid = rs.getString(1);
			}
		
			
			
			rs.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return  sid;
	}
	
	/*
	 * �ֹε�Ϲ�ȣ �ߺ����� 
	 */
	private boolean checkManageNo(String no, HttpServletRequest req, HttpServletResponse res) {

		boolean flag = true;
		
		StringUtil.printMsg("SET Client CODE", this);
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			String query = "";
			
			int Cnt = 0;
			/*
			 * Code ���� 
			 */
			
			query   += "" 		
					+ "\n\t" + "SELECT " 									
					+ "\n\t" + "	count(manage_cd) " 
					+ "\n\t" + "FROM "
					+ "\n\t" + "	SALES.TCU010 " 
					+ "\n\t" + "WHERE 1=1 "
					+ "\n\t" + "	AND manage_cd = ?";
			
			StringUtil.printMsg(query,this);
	//		 ���� ����
			pstmt = conn.prepareStatement(query); 
			
			pstmt.setString(1, no);
			
			rs = pstmt.executeQuery(); // DataSet set
			
			
			while(rs.next()) {
				Cnt = rs.getInt(1);
			}

			if(Cnt > 0) {
				flag = false;
			} else {
				flag = true;
			}
			
			rs.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return  flag;
	}
	
	/*
	 * ����  Ȯ��
	 */
	private boolean checkNum(String value) {
		
		boolean flag = true;
		
		try {
			int temp = Integer.parseInt(value);
		
			if (temp >= 0) {
				flag = true;
			} else {
				flag = false;
			}
		} catch (NumberFormatException e) {
			flag = false;
		}
		return flag;
	}
}
