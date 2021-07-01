package pms.menu.cat;
//
//20160421	�ɵ���	ã���� �ݾ� �÷� ���� ���ص� ���ε�ǰ� �÷� ����
//					�׼��� �ݾ׶� , �� ���ڿ��̾ ġȯ�ϰ� ����
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

import pms.common.HDConstant;		//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.HDUtil;			//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import sales.common.StringUtil;		//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�
import pms.common.SuperServlet;		//ȸ�� �޴� �ȿ� ������Ÿ�� �޴��� ������ �̿��ϴ� �ɷ�

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
		arr_sql[1].append("CALL PMS.PR_CAT010I_01(?,?,?,?,?,  ?,?,?,?,? )");	// ��ȸ
		arr_sql[2].append("CALL PMS.PR_CAT010I_02(?,? )");	// ��ȸ2
		arr_sql[3].append("CALL PMS.PR_CAT010I_03(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,? )");	// ����1
		arr_sql[4].append("CALL PMS.PR_CAT010I_04(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,   ?)");	// ����2
		
	}

	
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;


		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            	
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
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
		/* 2014.01.12 �ɵ���
		 * ����� �׼��� �ε��ϴ� ȭ���̹Ƿ� 
		 * 	���� ���ε�, �����б�, db���� ��ȸ�ϱ� 3������ ������.
		 * 
		 * */
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();		
		
		
		/* DataSet I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs,O:MAIN_DS=excelDs */
		
        GauceDataSet sel_dsM 		= gis.read("MAIN_DSM");		//���� ��ȸ
        GauceDataSet sel_ds 		= gis.read("MAIN_DS");		//��������ȸ
		
		GauceDataSet excelDs 	= gis.read("TEMP_EXCEL");	//��������; 
		GauceDataSet ds_xlD 	= gis.read("EXCELDS"); 		//�������� detail;
		GauceDataSet ds_xlM 	= gis.read("EXCELDSM"); 	//�������� master
		GauceDataSet ds_result 	= gis.read("RESULT");

		if(ds_result!=null){
			ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
			ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
		}
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		try {
			String sBgnDate = HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String sEndDate = HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String sAcctGu  = HDUtil.nullCheckStr(greq.getParameter("sAcctGu"));
			String sTr_Sum  = HDUtil.nullCheckStr(greq.getParameter("sTr_Sum"));
			int v_ot_sid = HDUtil.nullCheckNum(greq.getParameter("v_ot_sid"));
			
			
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput();

            //StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets.length,this);
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� "+i+"��° �����ͼ� ���� ",dSets[i].getName(),this);		

            	
				//������ ��ȸ;            	//O:MAIN_DSM=excelDsM
				if (sel_dsM != null) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					/*StringUtil.printMsg("�Ϲ� ��ȸ ",this);
					StringUtil.printMsg("������  ",arr_sql[1].toString(),this);
					StringUtil.printMsg("�ŷ����� ����== ",sBgnDate,this);
					StringUtil.printMsg("�ŷ����� ��   == ",sEndDate,this);
					StringUtil.printMsg("�����ڵ�   == ",sAcctGu,this);
					StringUtil.printMsg("����   == ",sTr_Sum,this);*/
					cstmt.setString(1,sBgnDate );
					cstmt.setString(2,sEndDate );
					cstmt.setString(3,sAcctGu );
					cstmt.setString(4,sTr_Sum );
					cstmt.setString(5,sEndDate );
					cstmt.setString(6,sAcctGu );
					cstmt.setString(7,sTr_Sum );
					cstmt.setString(8,sAcctGu );
					cstmt.setString(9,sTr_Sum );
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, sel_dsM));
				}
				//������ ;            	//O:MAIN_DS=excelDs
				if (sel_ds != null) {
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1,v_ot_sid );
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, sel_ds));
				}
				
				

				// * �������϶��� �ѹ��� ����ǰ�.. ������ ����				
				//�׼����� JSP (I:TEMP_EXCEL=tempExcelDs)
    			// ���� ���ε� 
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
					//StringUtil.printMsg("���� �������ϸ�:",o_name, this);
					
					fExcelFilePath = "D:/myWorks1/HDAsan/WebContent/Pms/file/" + o_name;//���ÿ�
					//fExcelFilePath = HDConstant.FILE_UPLOAD_PATH_FILE + o_name;	//������
					//StringUtil.printMsg("���ε�� �׼� ������ ���:",fExcelFilePath, this);

					InputStream is = (InputStream)excelRow[0].getInputStream(data_url);
					
					FileOutputStream os = new FileOutputStream(fExcelFilePath);
					copy(is, os, 1024*1024*10 );
					is.close();
					os.close();
				}				

				// * �������϶��� �ѹ��� ����ǰ�.. ������ ����
				// ���� �о �׸���� �Ѹ��� O:EXCELDS=excelDs
				if (ds_xlD != null && dSets[i].getName().equals("excelDs")) {
					//gres.enableFirstRow(ds_xlD);
					
					//StringUtil.printMsg("���� EXCEL PATH : ", fExcelFilePath, this);
					Workbook workbook = Workbook.getWorkbook(new File(fExcelFilePath));  /// �о�� ���ϸ�
					
					Sheet sheet0 = workbook.getSheet("All_company_list"); // Sheet�� : Sheet�� ����160421 

					//StringUtil.printMsg("=========ROW", sheet0.getRows()+"",this);
					String arr[][] = new String[sheet0.getRows()][60];	//�迭��ü�� ��Ʈ���̳׿�..
					
					for (int row = 0; row < sheet0.getRows(); row++) {	

						for (int column =0; column < sheet0.getColumns(); column++)	 {
							String content = "";
							//StringUtil.printMsg("�׼� �� Ÿ�� ==",sheet0.getCell(column,row).getType().toString(), this);

							// ����Ÿ��							
							if(sheet0.getCell(column,row).getType() == CellType.NUMBER)	{
								//NumberCell numberCell = (NumberCell) sheet0.getCell(column,row);
								//content = numberCell.getValue()+"";
								
								Cell cell = sheet0.getCell(column,row);
								content = cell.getContents();	
								//�׳� cell�� ������ �ȿ� �ִ� �� �״�� �޾ƿ´�. ex)  ��=681,509,000 �޸����� �����ؼ�.
								//StringUtil.printMsg("�׼���Ʈ ����==","row="+row+"::column="+column+"::��="+content, this);
								arr[row][column+1] = content;
							// ����Ÿ��		
							} else if(sheet0.getCell(column,row).getType() == CellType.LABEL)	{
								LabelCell labelCell = (LabelCell) sheet0.getCell(column,row);
								content = labelCell.getContents();
								//StringUtil.printMsg("�׼���Ʈ ����==","row="+row+"::column="+column+"::��="+content, this);
								arr[row][column+1] = content;
							// ��¥ Ÿ�� 		
							} else if(sheet0.getCell(column,row).getType() == CellType.DATE)	{
								DateCell dateCell = (DateCell) sheet0.getCell(column,row);
								content = dateCell.getDate()+"";
								//StringUtil.printMsg("�׼���Ʈ ��¥==","row="+row+"::column="+column+"::��="+content, this);
								arr[row][column+1] = content;
							} 
							//���⼭�� �Ҽ��� �� ������ �ɴϴ�. 2011-03-02
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
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN01",    GauceDataColumn.TB_STRING, 2)); // ����
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN02",    GauceDataColumn.TB_STRING, 2)); // ��������
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN03",    GauceDataColumn.TB_STRING, 2)); // ����
					ds_xlM.addDataColumn(new GauceDataColumn("GUBN04",    GauceDataColumn.TB_STRING, 2)); // ��������
					ds_xlM.addDataColumn(new GauceDataColumn("OT_SID",    GauceDataColumn.TB_DECIMAL, 10)); // 12
					
					/*
					 * temp�� �ִ� �ҷ��� �����͸� ds_xlM, ds_xlD�� �Ѹ��� �κ�
					 * 20170629	�ɵ���
					 */
					
					//��=�����ȣ	row=0::column=1::��= 20160438092-00                           
					//��=�����		row=1::column=1::��=ȫõ�� ȯ����ʽü� ������� (��ް���)   
					//��=����ó		row=2::column=1::��=�ѱ�ȯ�����                              
					//��=������		row=3::column=1::��=2016-05-09 16:00:00                       
					//��=���ʱݾ�	row=4::column=1::��=767,105,000                               
					//��=1���� �����ݾ�	row=5::column=1::��=681,509,000                               

					// ������ ������ �κ�
					GauceDataRow gRowM = ds_xlM.newDataRow();
					gRowM.addColumnValue(arr[0][2]);	//�����ȣ
					gRowM.addColumnValue(arr[1][2]);	//�����
					gRowM.addColumnValue(arr[2][2]);	//����ó
					gRowM.addColumnValue(arr[3][2]);	//������
					gRowM.addColumnValue(Double.parseDouble(arr[4][2].replaceAll(",", "")) );	//���ʱݾ�
					gRowM.addColumnValue(Double.parseDouble(arr[5][2].replaceAll(",", "")) );	//�����ݾ�
					gRowM.addColumnValue(" "); 		// ����
					gRowM.addColumnValue(" "); 		// ��������
					gRowM.addColumnValue(" "); 		// ����
					gRowM.addColumnValue(" "); 		// ����
					gRowM.addColumnValue(111); 		// OT_SID �÷� : �⺻�� ���� 1�� �� �Ŀ� ȭ�鿡�� 0���� ���� (���� �Է½�)
					ds_xlM.addDataRow(gRowM);
					//StringUtil.printMsg("ds_xlMī��Ʈ == " , ds_xlM.getDataRowCnt(), this);
					gos.write(ds_xlM);	//3.x������ ds_xlD.flush()�� �ش�
										
					// �����ϵ����� �κ� : 8����� ���� ������ ������ ���� ����
					for (int row = 8; row < sheet0.getRows(); row++) {
						GauceDataRow gRow = ds_xlD.newDataRow();
						//StringUtil.printMsg("����ȯ===",arr[row][4],this);
						////StringUtil.printMsg("����ȯ===",Double.parseDouble(arr[row][4]).toSring(),this);
						
						//StringUtil.printMsg("�����ڵ�   == ",sAcctGu,this);
						// �����ݾ�= null �ε����� ����	20160422 �ɵ���
						if(arr[row][5] != null ){
							gRow.addColumnValue(arr[row][1]);	//����
							gRow.addColumnValue(arr[row][2]);	//��ü��
							gRow.addColumnValue(arr[row][3]);	//����ڹ�ȣ
							gRow.addColumnValue(arr[row][4]);	//��ǥ��
							gRow.addColumnValue(Double.parseDouble(arr[row][5].replaceAll(",", "")));	//number	�����ݾ�
							gRow.addColumnValue(arr[row][6]);	//number	������� ������
							gRow.addColumnValue(arr[row][7]);	//number	���ʴ�� ������
							gRow.addColumnValue(arr[row][8]);	//number	���ʴ�� ������
							gRow.addColumnValue(arr[row][10]);	//�����Ͻ�
							gRow.addColumnValue(arr[row][11]);	//number	�������Ѱ� ����
							gRow.addColumnValue(arr[row][12]);	//���
							gRow.addColumnValue(111); 		// OT_SID �÷� : �⺻�� ���� 1�� �� �Ŀ� ȭ�鿡�� 0���� ���� (���� �Է½�)
							gRow.addColumnValue(222);		// DT_SID  �÷� : �⺻�� ���� 1�� �� �Ŀ� ȭ�鿡�� 0���� ���� (���� �Է½�)
							ds_xlD.addDataRow(gRow);
						}
						
					}
					//StringUtil.printMsg("ī��Ʈ == " , ds_xlD.getDataRowCnt(), this);
					
					gos.write(ds_xlD);	//3.x������ ds_xlD.flush()�� �ش�
					
					//StringUtil.printMsg("���� ������",this);
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
		/* 2013.10.22 �ɵ���
		 * �̷��� TR�� ȣ���մϴ�. 
		 * 		 * JSP(I:EXCELDSM=excelDsM,I:EXCELDS=excelDs,O:RESULT=ds_result)"
		 * 	���� gis.read�� �������� ��.
		 * 
		 * 2015.06.03 �ɵ���
		 * �ŷ�ó �÷��� �߰� ������ �� �ְ� ����
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
		String v_edit_styatus = "";										//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
		int	v_ot_sid = 0;
		try {

			// 1 ������ ���� �Է� + ������sid �޾ƿ���
			if (ds_xlsM != null) {
				
				GauceDataRow[] 		rows = ds_xlsM.getDataRows();
				GauceDataColumn[] 	cols = ds_xlsM.getDataColumns();
						
				//StringUtil.printMsg("ROW ---> " , rows.length+"", this);
				int colNm_OT_SID	  = ds_xlsM.indexOfColumn("OT_SID");
				int colNm_OT_NO	  = ds_xlsM.indexOfColumn("OT_NO");
				int colNm_OT_NM	  = ds_xlsM.indexOfColumn("OT_NM");
				int colNm_ORDERER_NM	  = ds_xlsM.indexOfColumn("ORDERER_NM");	//����
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
				
				//����SID = OT_SID �޾ƿ���
				if (cstmt.getString(13).equals("Y") ) {
					//StringUtil.printMsg("�����޽���",cstmt.getString(15),this);
					v_ot_sid = cstmt.getInt(1);
					//StringUtil.printMsg("���SID",cstmt.getInt(1),this);
					
				} else {
					StringUtil.printMsg("���и޽���",cstmt.getString(15),this);
					conn.rollback();
				}				
				
				if(cstmt!=null) cstmt.close();	
			}
			

			
			// 2 ������ ���� �Է�
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
					//StringUtil.printMsg("INSERT "+i+"�� ========================",this);
					//StringUtil.printMsg("rows[i].getJobType() �� == ", rows[i].getJobType() ,this);	//���ν��� �������� ��.
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					//StringUtil.printMsg("INSERT 0= ",rows[i].getInt(colNm_TR_SID),this);	//�Ϸù�ȣ
					//StringUtil.printMsg("INSERT 1= ",rows[i].getString(colNm_Col01),this);	//�ŷ��Ͻ� (���࿡�� ����)
					//StringUtil.printMsg("INSERT 2= ",rows[i].getString(colNm_Col02),this);
					//StringUtil.printMsg("INSERT 3= ",rows[i].getString(colNm_Col03),this);
					//StringUtil.printMsg("INSERT 4= ",rows[i].getString(colNm_Col04),this);
					//StringUtil.printMsg("INSERT 5= ",rows[i].getString(colNm_Col05),this);
					//StringUtil.printMsg("INSERT 6= ",rows[i].getString(colNm_Col06),this);
					//StringUtil.printMsg("INSERT 7= ","***"+rows[i].getString(colNm_Col01).substring(0,10).replaceAll("/","")+"***",this);	//�ŷ�����
					//StringUtil.printMsg("INSERT 8= ","***"+rows[i].getString(colNm_Col01).substring(11,16).replaceAll(":","")+"***",this);	//�ŷ��ð�
					//StringUtil.printMsg("================ �� ===============",this);
					
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
					cstmt.setString(12, HDUtil.nullCheckStr(rows[i].getString(colNm_OT_REMARK)) );	//��� ��ĭ�� ���=��ü
					cstmt.setString(13, fParamEmpno);
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
					// ��������
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
	 * ���ϻ���
	 */
	private void deleteExcelFile(String filePath) {
		File target = new File(filePath);
		try {
	        if (!target.exists()) {
	                //System.err.println(filePath + " �������� �ʽ��ϴ�...");
	                return;
	        }
	
	        // ������ �մϴ�... Ȥ�� �÷����� ���� 
	        //�۹̼� ����(SecurityException)�� ���� �� �ֽ��ϴ�....
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
