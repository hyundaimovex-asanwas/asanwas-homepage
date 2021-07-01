package sales.menu.rv;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
import sales.org.util.FileUtil;

public class Rv440B extends SuperServlet {
	
	//올리기 전에 체크하는 폴더~
	private String newPath = "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Sales/file/photo/cust_checking/";
									
	private String fExcelFilePath = "";
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
	
		/*
		 * 대리점 조회
		 */
		arr_sql[1].append("SELECT												\n")
					.append("       T2.DEPART_DATE								\n")	/* 출경일자   */
					.append("      ,T2.DEPART_TIME								\n")	/* 출경시간   */
					.append("      ,T4.ROOM_TYPE_CD								\n")	/* 객실타입   */
					.append("      ,T1.ACCEPT_NO								\n")	/* 신청서번호 */
					.append("      ,T2.CUST_SID									\n")	/* 고객 SID   */
					.append("      ,T3.MANAGE_NO	AS FILE_NAME							\n")	/* 관리번호   */
					
					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10','20') THEN SUBSTR(T3.REGI_NO,1,6)||'-'||SUBSTR(T3.REGI_NO,7,7)							\n")	/* 관리번호   */
					.append("      ELSE T3.PASS_NO END AS MANAGE_NO							\n")	/* 관리번호   */
				
					
					.append("      ,T3.CUST_NM									\n")	/* 한글성명   */
					.append("      ,T3.COMPANY_NM								\n")	/* 직장명     */
					.append("      ,T3.POSITIONS								\n")	/* 직위       */
					.append("	   ,'' AS FLAG									\n")
					.append("  FROM SALES.TRV010 T1								\n")
					.append("      ,SALES.TRV020 T2								\n")
					.append("      ,SALES.TCU010 T3								\n")
					.append("      ,SALES.TRM030 T4								\n")	/*객실타입 */
					
					.append(" WHERE 1 = 1										\n")
					.append("   AND T1.ACCEPT_SID    = T2.ACCEPT_SID			\n")
					.append("   AND T2.CUST_SID      = T3.CUST_SID				\n")
					.append("   AND T2.ROOM_TYPE_SID = T4.ROOM_TYPE_SID			\n")
					.append("   AND T2.STATUS_CD   IN ('RA','RR' , 'DP' ,'AR')		\n");   /* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */
																																
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
	
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		String sSaup_sid 	= HDUtil.nullCheckStr(req.getParameter("sSaup_sid"));	// 사업소
		String sDepart_date = HDUtil.nullCheckStr(req.getParameter("sDepart_date")); 	// 출경일자
		String sDepart_time = HDUtil.nullCheckStr(req.getParameter("sDepart_time")); 	// 출경시간 
		int 	sGoods_sid 	= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));			// 상품SID
		String sJobsel		= HDUtil.nullCheckStr(req.getParameter("sJobsel") );		//고객구분 
		
		//StringUtil.printMsg("작업구분"+ sJobsel,this);

		boolean flag = true;
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					
					/*
					 * 사진조회 (신규 Chacking폴더와 비교)
					 */
					if ("DS1".equals(gauceName) || "DS2".equals(gauceName)) {
						if (!"".equals(sSaup_sid)) { 
							arr_sql[1].append("   AND T1.SAUP_SID    = ?																	\n");	/* 사업소 										*/
						}
						if (!"".equals(sDepart_date)) {
							arr_sql[1].append("   AND T2.DEPART_DATE = ?																	\n");	/* 출경일자 										*/
						}
						if (!"".equals(sDepart_time)) { 
							arr_sql[1].append("   AND T2.DEPART_TIME = ?																	\n");	/* 출경시간 										*/ 
						}
						
						if (sGoods_sid > 0) {
							arr_sql[1].append("   AND T1.GOODS_SID   = ?																	\n");	/* 상품SID  										*/
						}
						
						if ("0".equals(sJobsel)) {
							arr_sql[1].append("   \n");							
						}else if ("1".equals(sJobsel)){
							arr_sql[1].append(" AND T2.CUST_GU='1'     \n");
						}else if ("2".equals(sJobsel)){
							arr_sql[1].append(" AND T2.CUST_GU='2' AND T2.SAUP_GU NOT IN ('50','55')   \n");
						}else if ("3".equals(sJobsel)){
							arr_sql[1].append(" AND T2.CUST_GU='2' AND T2.SAUP_GU IN ('50','55')  \n");
						};


						arr_sql[1].append("ORDER BY T2.DEPART_TIME		\n")
					 			.append("        ,T2.CLASS		\n")     																													
					 			.append("        ,T2.TEAMS		\n")     																													
					 			.append("        ,T2.TOUR_NO		\n") 																													
					 			.append("        ,T2.RSV_SID		\n"); 	
				  		 // 쿼리 실행
				  		 
				  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
				  		// 조건
				  		if (!"".equals(sSaup_sid)) {
					  		stmt.setInt(sCnt1++, Integer.parseInt(sSaup_sid));		// 사업소
					  		 
						}
						if (!"".equals(sDepart_date)) { 
							stmt.setString(sCnt1++, sDepart_date );			// 출경일자 
						}
						if (!"".equals(sDepart_time)) { 
					  		 stmt.setString(sCnt1++, sDepart_time);				// 출경시간 
						}
						if (sGoods_sid > 0) { 
					  		 stmt.setInt(sCnt1++, sGoods_sid);				// 상품SID 
						}
					}
					//System.out.println(arr_sql[1].toString());
					rs = stmt.executeQuery();		// Query 실행
					
					rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
					for(int i=0; i<columnName.length; i++){
						columnName[i] = rsmd.getColumnName(i+1);
						
						if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
							ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
						else
							ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1) ));
					}
					
					ds1.addDataColumn(new GauceDataColumn("IS_FILE", GauceDataColumn.TB_STRING));
					
					if ("DS1".equals(gauceName)) {
						while ( rs.next()) {
							GauceDataRow row = ds1.newDataRow();
							for(int i=0; i<columnName.length; i++) {
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									row.addColumnValue(rs.getInt(columnName[i]));
								else
									row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
							}
							
							// StringUtil.printMsg("파일명1:",rs.getString(6),this);
							// StringUtil.printMsg("체크2",isCustFile1(rs.getString(6))+"",this);
							
							if (isCustFile1(rs.getString(6)+".JPG") == true) {
								row.addColumnValue("Y");	
							}else if(isCustFile1(rs.getString(6)+".JPG") == false) {
								row.addColumnValue("N");
							}
							
							ds1.addDataRow(row);
						}
					} else if ("DS2".equals(gauceName)) {
						while ( rs.next()) {
							GauceDataRow row = ds1.newDataRow();
							for(int i=0; i<columnName.length; i++) {
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									row.addColumnValue(rs.getInt(columnName[i]));
								else
									row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
							}
							
							// StringUtil.printMsg("파일명2:",rs.getString(6),this);
							// StringUtil.printMsg("체크2",isCustFile2(rs.getString(6))+"",this);
							
							if (isCustFile2(rs.getString(6)+".JPG") == true) {
								row.addColumnValue("Y");	
							}else if(isCustFile2(rs.getString(6)+".JPG") == false) {
								row.addColumnValue("N");
							}
							
							ds1.addDataRow(row);
						}
					}

					
					if(rs!=null) rs.close();
					if(stmt!=null) stmt.close();

					ds1.flush();
					
					res.close();
					res.flush();
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		// 사진 복사  
		// 고객정보에서 정해진 고객에 대한 파일을 가지고 지정된 사진 파일을 생성한다 
	
			// TODO Auto-generated method stub
			GauceStatement 		stmt 		= null;
			ResultSet 			rs 			= null;

			/** 
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
			 **/
			/* DataSet */
			GauceDataSet ds1 = req.getGauceDataSet("DS1");
			
			int fClientSid = 0;
			String fDepartDate = HDUtil.nullCheckStr(req.getParameter("sDepart_date"));
			
			//고객 사진 복사를 할경우 Y면 Cust_SID로 변경하여 복사 N이면 Manage_NO 그대로 복사
			//Manage_NO로 복사를 할경우 조회일자 아래 폴더 MANAGE로 하여 생성한다 
			
			String sGubun = HDUtil.nullCheckStr(req.getParameter("sGubun"));  
			
			try{
				if (ds1 != null) {
					GauceDataRow[] 		rows = ds1.getDataRows();
					GauceDataColumn[] 	cols = ds1.getDataColumns();
					
					int colNm_CustSid               = ds1.indexOfColumn("CUST_SID");
					int colNm_ManageNo              = ds1.indexOfColumn("MANAGE_NO");
					int colNm_IsFile				= ds1.indexOfColumn("IS_FILE");
					
					int colNm_FileName              = ds1.indexOfColumn("FILE_NAME");
					
					for(int i = 0; i < rows.length; i++) {

						int iCnt = 1;
						int colNum = 0;
						
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_INSERT:
								break;
							case GauceDataRow.TB_JOB_UPDATE:
								if ("Y".equals(sGubun)) { // SID로 생성
									String  targetFile= rows[i].getColumnValue(colNm_CustSid).toString();
									String fileName = rows[i].getColumnValue(colNm_FileName).toString();
									String isFile = rows[i].getColumnValue(colNm_IsFile).toString();
									
									// 원본, 이동파일 
									
									// StringUtil.printMsg("원본파일명"+HDConstant.FILE_UPLOAD_PATH_COST+fileName+".JPG",this);
									// StringUtil.printMsg("이동파일명"+HDConstant.FILE_UPLOAD_PATH_COST+fDepartDate+"/"+targetFile+".JPG",this);
									
									File f = new File(HDConstant.PIC_DOWNLOAD_PATH+fDepartDate+"/");
									// StringUtil.printMsg("생성폴더명",HDConstant.FILE_UPLOAD_PATH_COST+fDepartDate+"/",this);
									if (!f.isDirectory()) {
										f.mkdir();
									}
									
									if (isFile.equals("Y")) { // 파일이 있는경우 
									
										  int bytes_read = 0; 
										   byte [] buffer = new byte[512]; // buffer to hold characters read from file 
										   
										   FileInputStream fin = new FileInputStream(HDConstant.FILE_UPLOAD_PATH_COST+fileName+".JPG"); 
									       FileOutputStream fout = new FileOutputStream(HDConstant.PIC_DOWNLOAD_PATH+fDepartDate+"/"+targetFile+".JPG"); 
									       
									       
									       while ((bytes_read = fin.read(buffer)) != -1) {
									            fout.write(buffer, 0, bytes_read); 
									       }
									       
									       fout.close();
									       fin.close();
									}
								} else if ("N".equals(sGubun)) { // Manage No로 생성 
									String  targetFile= rows[i].getColumnValue(colNm_ManageNo).toString();
									String fileName = rows[i].getColumnValue(colNm_FileName).toString();
									String isFile = rows[i].getColumnValue(colNm_IsFile).toString();
									
									// 원본, 이동파일 
								
//									// StringUtil.printMsg("원본파일명"+HDConstant.FILE_UPLOAD_PATH_COST+fileName+".JPG",this);
//									// StringUtil.printMsg("이동파일명"+HDConstant.FILE_UPLOAD_PATH_COST+fDepartDate+"/Manage/"+targetFile+".JPG",this);

									File f = new File(HDConstant.PIC_DOWNLOAD_PATH+fDepartDate+"/Manage/");
									
									// StringUtil.printMsg("생성폴더명",HDConstant.FILE_UPLOAD_PATH_COST+fDepartDate+"/Manage/",this);
									if (!f.isDirectory()) {
										f.mkdir();
									}
									
									if (isFile.equals("Y")) { // 파일이 있는경우 
									
										  int bytes_read = 0; 
										   byte [] buffer = new byte[512]; // buffer to hold characters read from file 
										   
										   FileInputStream fin = new FileInputStream(HDConstant.FILE_UPLOAD_PATH_COST+fileName+".JPG"); 
									       FileOutputStream fout = new FileOutputStream(HDConstant.PIC_DOWNLOAD_PATH+fDepartDate+"/Manage/"+fileName+".JPG"); 
									       
									       // StringUtil.printMsg("원본파일명"+HDConstant.FILE_UPLOAD_PATH_COST+fileName+".JPG",this);
											// StringUtil.printMsg("이동파일명"+HDConstant.FILE_UPLOAD_PATH_COST+fDepartDate+"/Manage/"+fileName+".JPG",this);
									       
									       while ((bytes_read = fin.read(buffer)) != -1) {
									            fout.write(buffer, 0, bytes_read); 
									       }
									       
									       fout.close();
									       fin.close();
									}									
								} else if ("U".equals(sGubun)) { // 신규생성된 업로드 
									String  targetFile= rows[i].getColumnValue(colNm_ManageNo).toString();
									String fileName = rows[i].getColumnValue(colNm_FileName).toString();
									String isFile = rows[i].getColumnValue(colNm_IsFile).toString();
									
									File f = new File(HDConstant.FILE_UPLOAD_PATH_COST);
									
									if (!f.isDirectory()) {
										f.mkdir();
									}
									
									if (isFile.equals("Y")) { // 파일이 있는경우 
									
										  int bytes_read = 0; 
										   byte [] buffer = new byte[512]; // buffer to hold characters read from file 
										   
										   FileInputStream fin = new FileInputStream(newPath+fileName+".JPG"); 
									       FileOutputStream fout = new FileOutputStream(HDConstant.FILE_UPLOAD_PATH_COST+fileName+".JPG"); 
									       
									       while ((bytes_read = fin.read(buffer)) != -1) {
									            fout.write(buffer, 0, bytes_read); 
									       }
									       
									       fout.close();
									       fin.close();
									       
									       deleteExcelFile(newPath+fileName+".JPG");
									}				
								}
								break;
							
							case GauceDataRow.TB_JOB_DELETE:
								break;
								
							
						}
					}
				}
			}  catch (FileNotFoundException sqle){
				res.writeException("ERROR", "", sqle.getMessage());
				throw sqle;
			} finally{
				if(stmt!=null) stmt.close();
			}
	}
	
	
	/*
	 * 조회1 신규
	 */
	public boolean isCustFile1(String fileName) {
		boolean flag = true;
		try {
			// StringUtil.printMsg(newPath + fileName,this);
			File f = new File(newPath + fileName);
			if (f.isFile()==true) {
				flag = true;	
			} else {
				flag = false;
			}
			
			
			
		} catch (Exception e) {
			flag = false;
		}
		return flag;
	}
	/*
	 * 조회2일때 사용 기존에 조회 하던곳
	 */
	public boolean isCustFile2(String fileName) {
		boolean flag = true;
		try {
			//StringUtil.printMsg(HDConstant.FILE_UPLOAD_PATH_COST+fileName,this);
			File f = new File(HDConstant.FILE_UPLOAD_PATH_COST+fileName);
			if (f.isFile()==true) {
				flag = true;	
			} else {
				flag = false;
			}
			
			
			
		} catch (Exception e) {
			flag = false;
		}
		return flag;
	}

	
	/*
	 * 파일삭제
	 */
	private void deleteExcelFile(String filePath) {
		File target = new File(filePath);
		try {
	        if (!target.exists()) {
	                System.err.println(filePath + " 존재하지 않습니다...");
	                return;
	        }
	
	        // 삭제를 합니다... 혹시 플랫폼에 따라 
	        //퍼미션 오류(SecurityException)가 나올 수 있습니다....
	        if (target.delete()) {
	                System.err.println("** Deleted " + filePath + " **");
	        } else {
	                System.err.println("Failed to delete " + filePath);
	        }
		} catch (SecurityException e) {        
			System.err.println("Unable to delete " + filePath +
                "(" + e.getMessage() + ")");
		}


	}	
}
