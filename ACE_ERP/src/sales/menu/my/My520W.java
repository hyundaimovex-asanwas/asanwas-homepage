package sales.menu.my;

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

import sales.common.*;

public class My520W extends SuperServlet {
	String SAVE_FILE  = HDConstant.FILE_UPLOAD_PATH_CAR;
	String SAVE_FILE2 = HDConstant.FILE_UPLOAD_PATH_CAR_INS;
	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT 																					\n")
				  .append ("	   T1.CAR_SID				/* 일련번호			 */                                 \n")
				  .append ("      ,T1.CAR_NO                /* 차량등록번호      */                                 		\n")
				  .append ("      ,T1.CAR_TYPE              /* 차종              */                                 		\n")
				  .append ("      ,T1.CAR_NM                /* 차명              */                                 		\n")
				  .append ("      ,T1.CAR_FORM              /* 형식              */                                 		\n")
				  .append ("      ,T1.CAR_YEAR              /* 연식              */                                 		\n")
				  .append ("      ,T1.CAR_CC                /* 배기량            */                                 		\n")
				  .append ("      ,T1.CAR_PERSONS           /* 승차인원          */                                 		\n")
				  .append ("      ,T1.MAX_KG                /* 최대적재량        */                                 		\n")
				  .append ("      ,T1.CAR_TYPE_CD           /* 차종코드          */                                 		\n")
				  .append ("      ,T1.CAR_DNO               /* 차대번호          */                                 		\n")
				  .append ("      ,T1.NORTH_YN              /* 최초방문여부      */                                 		\n")
				  .append ("      ,T1.NORTH_DATE            /* 최초방문예상일    */                                 		\n")
				  .append ("      ,T1.DRIVE_NO              /* 기본운전면허번호  */                                 	\n")
				  .append ("	  ,T1.CLIENT_SID			/* 매출처 SID		*/										\n")
				  .append ("	  ,T4.CLIENT_CD 			/* 매출처 CD		*/										\n")
				  .append ("	  ,T4.CLIENT_NM 			/* 매출처 NM		*/										\n")
				  .append ("      ,SALES.FN_DETAIL_NM ( 'CU017',T1.CAR_TYPE_CD) AS CAR_TYPE_CD_NAME                 \n")
				  .append ("      ,SALES.FN_DETAIL_NM ( 'CU018',T1.NORTH_YN)    AS NORTH_YN_NAME                    \n")
				  .append ("      ,T3.CUST_NM               /* 운전자            */                                 		\n")
				  .append ("FROM                                                                                    \n")
				  .append ("       SALES.TCU050 T1                                                                  \n")
				  .append ("      ,SALES.TCU040 T2 LEFT OUTER JOIN  SALES.TCU010 T3 ON  T2.CUST_SID  = T3.CUST_SID  \n")
				  .append ("	  ,SALES.TCU030 T4																	\n")
				  .append ("WHERE 1 = 1                                                                             \n")
				  .append ("  AND T1.DRIVE_NO  = T2.DRIVE_NO                                                        \n")
				  .append ("  AND T1.CLIENT_SID = T4.CLIENT_SID														\n");
				  
		arr_sql[1].append ("INSERT INTO SALES.TCU050                                                                \n")
				  .append ("(                                                                                       \n")
				  .append ("	CAR_NO, CAR_TYPE, CAR_NM, CAR_FORM, CAR_YEAR, CAR_CC, CAR_PERSONS,                  \n")
				  .append ("	MAX_KG, CAR_TYPE_CD, CAR_DNO, NORTH_YN, NORTH_DATE, DRIVE_NO, CLIENT_SID,           \n")
				  .append ("	U_EMPNO, U_DATE, U_IP                                                               \n")
				  .append (") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP, ?)            \n");
				  
		arr_sql[2].append ("UPDATE  SALES.TCU050                                                                    \n")
				  .append ("   SET 	CAR_NO		= ?,																\n") 
				  .append ("		CAR_TYPE 	= ?,                                                                \n")
				  .append ("		CAR_NM 		= ?,                                                                \n")
				  .append ("		CAR_FORM 	= ?,                                                                \n")
				  .append ("		CAR_YEAR 	= ?,                                                                \n")
				  .append ("		CAR_CC 		= ?,                                                                \n")
				  .append ("		CAR_PERSONS = ?,                                                                \n")
				  .append ("		MAX_KG 		= ?,                                                                \n")
				  .append ("		CAR_TYPE_CD = ?,                                                                \n")
				  .append ("		CAR_DNO 	= ?,                                                                \n")
				  .append ("		NORTH_YN 	= ?,                                                                \n")
				  .append ("		NORTH_DATE 	= ?,                                                                \n")
				  .append ("		DRIVE_NO 	= ?,                                                                \n")
				  .append ("		CLIENT_SID 	= ?,                                                                \n")
				  .append ("		U_EMPNO 	= ?,                                                                \n")
				  .append ("		U_DATE 		= CURRENT TIMESTAMP,                                                \n")
				  .append ("		U_IP 		= ?                                                                 \n")
				  .append ("WHERE   CAR_NO 		= ?                                                                 \n");
				  
		arr_sql[3].append ("DELETE FROM SALES.TCU050 WHERE CAR_NO = ?                                               \n");
				  
		arr_sql[4].append ("SELECT CAR_SID FROM SALES.TCU050 WHERE CAR_NO = ?                                       \n");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
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
								ds1.addDataColumn(new GauceDataColumn("CAR_SID", GauceDataColumn.TB_NUMBER));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
							} else if(gauceName.equals("IMAGE2")){
								ds1.addDataColumn(new GauceDataColumn("CAR_SID", GauceDataColumn.TB_NUMBER));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO2", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_URL2", GauceDataColumn.TB_URL, 1024));
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
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null;
		
		// 검색시 조건
		String  sClientCd	= HDUtil.nullCheckStr(req.getParameter("sClientCd")); 	// 매출처
		String  sCarNo		= HDUtil.nullCheckStr(req.getParameter("sCarNo")); 		// 차량등록번호
		String	sDriveNo	= HDUtil.nullCheckStr(req.getParameter("sDriveNo"));	// 고객구분
		String  sCustNm		= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// 고객명

		//StringUtil.printMsg("sClientCd", sClientCd, this);
		//StringUtil.printMsg("sCarNo", sCarNo, this);
		//StringUtil.printMsg("sDriveNo", sDriveNo, this);
		//tringUtil.printMsg("sCustNm", sCustNm, this);

		// dataset 구분 param
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = req.getGauceDataSet("DEFAULT");
					
					if(ds1!=null){
						res.enableFirstRow(ds1);
						
						if (!"".equals(sCarNo)) 
							arr_sql[0].append (" AND T1.CAR_NO LIKE ? ");
						
						if (!"".equals(sDriveNo))
							arr_sql[0].append (" AND T1.DRIVE_NO = ? ");
		
						if (!"".equals(sCustNm)) 
							arr_sql[0].append (" AND T3.CUST_NM = ? ");
						
						if(!"".equals(sClientCd))
							arr_sql[0].append (" AND T4.CLIENT_CD = ? ");

						//StringUtil.printMsg("arr_sql[0].toString()", arr_sql[0].toString(), this);

						//쿼리 실행
						stmt = conn.getGauceStatement(arr_sql[0].toString()); 
		
						if (!"".equals(sCarNo)) 
							stmt.setString(sCnt1++, "%"+sCarNo+"%");
						
						if (!"".equals(sDriveNo)) 
							stmt.setString(sCnt1++, sDriveNo);
						
						if (!"".equals(sCustNm)) 
							stmt.setString(sCnt1++, sCustNm);
						
						if(!"".equals(sClientCd))
							stmt.setString(sCnt1++, sClientCd);
						
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
						
						
						while ( rs.next()) {
							GauceDataRow row = ds1.newDataRow();
							for(int i=0; i<columnName.length; i++) {
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									row.addColumnValue(rs.getInt(columnName[i]));
								else
									row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
							}
							ds1.addDataRow(row);
							
							v_rowcnt++ ;
						}//End of while
						
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();

						ds1.flush();
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
				

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							stmt = conn.getGauceStatement(arr_sql[1].toString());

							for(; j<15;){
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
							if(stmt!=null) stmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							stmt = conn.getGauceStatement(arr_sql[2].toString());

							for(; j<15;){
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

			}

		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}
	}

}
