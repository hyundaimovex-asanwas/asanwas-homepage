package sales.menu.cu;

import java.io.File;
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
import sales.common.SuperServlet;

public class Cu100I_백업 extends SuperServlet {
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_DRIVE;

	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT T1.DRIVE_SID																			\n")
				  .append ("	  ,T1.DRIVE_NO              /* 운전면허번호    */                                         	\n")
				  .append ("      ,T1.LICENSE_DATE          /* 면허일자        */                                         	\n")
				  .append ("      ,T1.RENEWAL_DATE          /* 갱신기간        */                                         	\n")
				  .append ("      ,T1.LICENSE_TYPE          /* 면허종류코드    */                                         	\n")
				  .append ("      ,T1.CUST_SID              /* 고객SID         */                                        \n")
				  .append ("      ,T2.CUST_NM               /* 운전자          */                                         		\n")
				  .append ("      ,SALES.FN_SECURE_RETURN(T2.MANAGE_NO,7) AS MANAGE_NO /* 주민/여권 번호*/     	\n")
				  .append ("      ,T2.MANAGE_NO AS MANAGE_FULL                                        	\n")
				  .append ("      ,T3.CLIENT_CD             /* 협력업체코드    */                                         	\n")
				  .append ("      ,T3.CLIENT_NM             /* 협력업체명      */                                         	\n")
				  .append ("      ,SALES.FN_DETAIL_NM ( 'CU007',T1.LICENSE_TYPE) LICENSE_TYPE_NAME                      \n")
				  .append ("FROM                                                                                        \n")
				  .append ("       SALES.TCU040 T1                                                                      \n")
				  .append ("      ,SALES.TCU010 T2 LEFT OUTER JOIN  SALES.TCU030 T3 ON  T2.CLIENT_SID  = T3.CLIENT_SID  \n")
				  .append ("WHERE 1 = 1                                                                                 \n")
				  .append ("  AND T1.CUST_SID = T2.CUST_SID																\n");
		 
		arr_sql[1].append ("INSERT INTO SALES.TCU040										\n")
				  .append ("(DRIVE_NO, LICENSE_DATE, RENEWAL_DATE, LICENSE_TYPE, CUST_SID,  \n")
				  .append (" U_EMPNO, U_DATE, U_IP)                                         \n")
				  .append ("VALUES (?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP, ?)                 \n");
		
		 arr_sql[2].append ("UPDATE  SALES.TCU040		\n")
				   .append ("   SET  DRIVE_NO = ?,		\n") 
				   .append ("		LICENSE_DATE = ?,   \n")
				   .append ("		RENEWAL_DATE = ?,   \n")
				   .append ("		LICENSE_TYPE = ?,   \n")
				   .append ("		CUST_SID = ?,       \n")
				   .append ("		U_EMPNO = ?,        \n")
				   .append ("		U_DATE = CURRENT TIMESTAMP,         \n")
				   .append ("		U_IP = ?            \n")
				   .append ("WHERE   DRIVE_NO = ?        \n");
		 arr_sql[3].append("DELETE FROM SALES.TCU040 WHERE DRIVE_NO = ?");
		 
		 arr_sql[4].append ("SELECT DRIVE_SID FROM SALES.TCU040 WHERE DRIVE_NO = ?");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("DEFAULT")){
								stmt = conn.getGauceStatement(arr_sql[0].toString());
							} else if(gauceName.equals("IMAGE")){
								ds1.addDataColumn(new GauceDataColumn("DRIVE_SID", GauceDataColumn.TB_NUMBER));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
							}
							if(gauceName.equals("DEFAULT")){
								rs = stmt.executeQuery(); // DataSet set
								rsmd = rs.getMetaData();
								columnName = new String[rsmd.getColumnCount()];
								for(int i=0; i<columnName.length; i++){
									columnName[i] = rsmd.getColumnName(i+1);
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
									else
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
								}
							}
							if(rs!=null) rs.close();
							if(stmt!=null) stmt.close();

							ds1.flush();
							break;
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceDataSet imgDs = null;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter 설정
		 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
		 **********************************************************************************/

		// 검색시 조건
		String  sClientCd	= HDUtil.nullCheckStr(req.getParameter("sClientCd")); 	// 매출처
		String	sDriveNo	= HDUtil.nullCheckStr(req.getParameter("sDriveNo"));		// 고객구분
		String  sCustNm		= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// 고객명
		
		// dataset 구분 param
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = req.getGauceDataSet("DEFAULT");
					imgDs = req.getGauceDataSet("IMAGE");
					
					if(ds1!=null){
						res.enableFirstRow(ds1);
						res.enableFirstRow(imgDs);
		 
						if (!"".equals(sClientCd)) 
							arr_sql[0].append (" AND T2.CLIENT_SID = ? ");
						
						if (!"".equals(sDriveNo))
							arr_sql[0].append (" AND T1.DRIVE_NO LIKE ? ");
		
						if (!"".equals(sCustNm)) 
							arr_sql[0].append (" AND T2.CUST_NM LIKE ? ");
						

//System.out.println("arr_sql[0].toString() : " + arr_sql[0].toString());
						//쿼리 실행
						stmt = conn.getGauceStatement(arr_sql[0].toString()); 
		
						if (!"".equals(sClientCd)) {
							stmt.setString(sCnt1++, sClientCd);
						}			
						
						if (!"".equals(sDriveNo)) {
							stmt.setString(sCnt1++, "%" +sDriveNo+"%");
						}
						
						if (!"".equals(sCustNm)) {
							stmt.setString(sCnt1++, sCustNm +"%");
						}
						
						rs = stmt.executeQuery(); // DataSet set
						rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];
						for(int i=0; i<columnName.length; i++){
							columnName[i] = rsmd.getColumnName(i+1);
							if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
							else
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1) ));
						}
						
						imgDs.addDataColumn(new GauceDataColumn("DRIVE_SID", GauceDataColumn.TB_NUMBER));
						imgDs.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
						imgDs.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
						
						while ( rs.next()) {
							GauceDataRow row = ds1.newDataRow();
							for(int i=0; i<columnName.length; i++) {
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									row.addColumnValue(rs.getInt(columnName[i]));
								else
									row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
							}
							ds1.addDataRow(row);
							
							GauceDataRow imgRow = imgDs.newDataRow();
							File imgFile = new File(SAVE_FILE +  rs.getInt("DRIVE_SID")+".jpg");
							imgRow.addColumnValue(rs.getInt("DRIVE_SID"));
							if(imgFile.isFile()){
								imgRow.addColumnValue( HDConstant.FILE_DOWNLOAD_PATH_DRIVE + rs.getInt("DRIVE_SID")+".jpg");
								imgRow.addColumnValue( HDConstant.FILE_DOWNLOAD_PATH_DRIVE + rs.getInt("DRIVE_SID")+".jpg");
							} else {
								imgRow.addColumnValue("");
								imgRow.addColumnValue("");
							}
							imgDs.addDataRow(imgRow);

							v_rowcnt++ ;
						}//End of while
						
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();

						ds1.flush();
						imgDs.flush();
					}
					break;
	
			}
		} catch (SQLException sqle){
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

	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet inputDs = req.getGauceDataSet("REGIST");
		GauceDataSet imgDs = req.getGauceDataSet("IMAGE");
		GauceStatement stmt = null;
		ResultSet rs = null;

		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				GauceDataRow[] 		imgRow = imgDs.getDataRows();
				GauceDataColumn[] 	imgCol = imgDs.getDataColumns();

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
//System.out.println("arr_sql[1].toString() : " + arr_sql[1].toString());
							stmt = conn.getGauceStatement(arr_sql[1].toString());

							for(; j<6;){
//System.out.println(j + " : " + cols[j].getColName() + " value [" + rows[i].getString(j).trim() + "] colType() [" + cols[j].getColType() +"]");
								
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER ) 
									stmt.setInt(j, rows[i].getInt(j++));
								else 
									stmt.setString(j, rows[i].getString(j++).trim());
							}
							
							stmt.setString(j++, iParamEmpno);
							stmt.setString(j++, iParamIp);

							stmt.execute();
							
							if(stmt!=null) stmt.close();
							
							//고객 사진 정보 등록
							int data_name = imgDs.indexOfColumn("PICTURE_INFO");
							int data_url  = imgDs.indexOfColumn("PICTURE_URL");
							String d_name = imgRow[i].getString(data_name);
							String v_drive_sid = "";
							
							if(!imgRow[i].getString(0).trim().equals("") && d_name!=null && !d_name.equals("")){
								stmt = conn.getGauceStatement(arr_sql[4].toString());
								stmt.setString(1, rows[i].getString(1).trim());
								rs = stmt.executeQuery();
								if(rs.next())
									v_drive_sid = rs.getString("DRIVE_SID");
								else
									res.writeException("ERROR", "Data 추출오류", "관리번호를 추출하는데 실패했습니다.");
								
//								String o_name = v_drive_sid + ".jpg";
								
////System.out.println("imgRow data_name : " + data_name + " : " + d_name + " : " + o_name);

								InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
								FileOutputStream os = new FileOutputStream(SAVE_FILE + v_drive_sid + ".jpg");
								copy(is, os, 1024*1024*10 );
								is.close();
								os.close();
							}

							if(stmt!=null) stmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
//System.out.println("arr_sql[2].toString() : " + arr_sql[2].toString());
							stmt = conn.getGauceStatement(arr_sql[2].toString());

							for(; j<6;){
////System.out.println(j + " : " + cols[j].getColName() + " value [" + rows[i].getString(j).trim() + "] colType() [" + cols[j].getColType() +"]");
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
									stmt.setInt(j, rows[i].getInt(j++));
								else
									stmt.setString(j, rows[i].getString(j++).trim());
							}
							
							stmt.setString(j++, iParamEmpno);
							stmt.setString(j++, iParamIp);
							stmt.setString(j++, rows[i].getString(1).trim());

							stmt.execute();
							if(stmt!=null) stmt.close();
							
							break;
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[3].toString());
							stmt.setString(1, rows[i].getString(1).trim());
							stmt.execute();
							break;
					}
					if(stmt!=null) stmt.close();
				}

				for(int i=0; i<imgRow.length; i++){
					switch(imgRow[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//고객 사진 정보 등록
							int data_name = imgDs.indexOfColumn("PICTURE_INFO");
							int data_url  = imgDs.indexOfColumn("PICTURE_URL");
							String d_name = imgRow[i].getString(data_name);
							
							if(!imgRow[i].getString(0).trim().equals("") && d_name!=null && !d_name.equals("")){
								String o_name = imgRow[i].getInt(0) + ".jpg";
								
//System.out.println("imgRow data_name : " + data_name + " : " + d_name + " : " + o_name);

								InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
								FileOutputStream os = new FileOutputStream(SAVE_FILE + o_name);
								copy(is, os, 1024*1024*10 );
								is.close();
								os.close();
							}

							break;
					}
				}
			}

		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}
	}

}
