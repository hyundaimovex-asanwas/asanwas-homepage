package sales.menu.help;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ml010H extends SuperServlet {

	public void makeSql(){
		arr_sql[0].append ("SELECT ORDERER_SID			AS ORDERER_SID,                                                /* 주문자SID					*/	\n")
				  .append ("       USER_ID			AS USER_ID,                                                             		/* 주문자ID				  	*/  \n")
				  .append ("       USER_NM			AS USER_NM,                                                         		/* 주문자성명              	*/  \n")
				  .append ("       MOBILE_NO		AS MOBILE_NO,                                                       		/* 핸드폰번호               	*/  \n")
				  .append ("       ORDERER_COMPANY		AS ORDERER_COMPANY,                                                       		/* 소속               	*/  \n")
				  .append ("       TEL_NO			AS TEL_NO,                                                           		/* 전화번호               	*/  \n")
				  .append ("       EMPNO             AS EMPNO                                                 		/* 유치자                     	*/  \n")
				  .append ("FROM SALES.TML010                                                                                               \n")
				  .append ("WHERE 1 = 1																										\n");
		
		arr_sql[1].append ("INSERT INTO SALES.TML010													\n")
				  .append ("       (USER_NM, MOBILE_NO, TEL_NO,ORDERER_COMPANY, EMPNO, U_EMPNO,U_DATE) \n")
				  .append ("VALUES ( ?, ?, ?,?, ?,?,CURRENT TIMESTAMP)			                                 \n");
		
		arr_sql[2].append ("UPDATE  SALES.TML010								\n")
				  .append ("   SET  USER_NM          = ?,                     			\n")
				  .append ("        MOBILE_NO          = ?,                     			\n")
				  .append ("        TEL_NO      = ?,                     					\n")
				  .append ("        ORDERER_COMPANY      = ?,      				\n")
				  .append ("        EMPNO    = ?,                     						\n")
				  .append ("        U_EMPNO            = ?,                     			\n")
				  .append ("        U_DATE             = CURRENT TIMESTAMP   \n")
				  .append ("WHERE   ORDERER_SID         = ? 	                    \n");
		
		arr_sql[3].append ("DELETE FROM SALES.TML010 WHERE ORDERER_SID = ?		\n");
	}
	
	
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
//		StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		try {
			// 검색시 조건
			String	sUserNm	= HDUtil.nullCheckStr(req.getParameter("sUserNm"));
			String	sMobileNo	= HDUtil.nullCheckStr(req.getParameter("sMobileNo"));
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							if (!"".equals(sUserNm)) 
								arr_sql[0].append (" AND USER_NM LIKE ? ");
					    	if (!"".equals(sMobileNo)) 	
						        arr_sql[0].append (" AND MOBILE_NO LIKE ? ");
							//StringUtil.printMsg("arr_sql[0].toString() :",arr_sql[0].toString(),this);	
							
													
							stmt = conn.getGauceStatement(arr_sql[0].toString());
		
							if (!"".equals(sUserNm)) 
								stmt.setString(sCnt1++, "%"+sUserNm+"%");
				            if (!"".equals(sMobileNo)) 
							stmt.setString(sCnt1++, "%"+sMobileNo+"%");	
		
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
		
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();
								
								for(int i=0; i<columnName.length; i++) {
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										row.addColumnValue(rs.getInt(columnName[i]));
									else
										row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								}
		
								ds1.addDataRow(row);
							}//End of while
							if(rs!=null) rs.close();
							if(stmt!=null) stmt.close();
		
							//StringUtil.printMsg("# ResultSet Total Count : ", ds1.getDataRowCnt(),this);
							break;
					}
				}
			}
			ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
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

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		/* DataSet */
		CallableStatement 	cstmt 		= null;
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("DS1");	
		ResultSet 			rs 			= null;
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				StringUtil.printMsg("try","try", this);
				
				int colNm_Orderer_sid		       		= ds1.indexOfColumn("ORDERER_SID");
				int colNm_User_nm                     	= ds1.indexOfColumn("USER_NM");
				int colNm_Mobile_no            			= ds1.indexOfColumn("MOBILE_NO");
				int colNm_Tel_no               			= ds1.indexOfColumn("TEL_NO");				
				int colNm_Orderer_company 			= ds1.indexOfColumn("ORDERER_COMPANY");
				int colNm_Empno     			       		= ds1.indexOfColumn("EMPNO");

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[1].toString());
							/*
							StringUtil.printMsg("1", rows[i].getString(colNm_User_nm), this);
							StringUtil.printMsg("2",rows[i].getString(colNm_Mobile_no) , this);
							StringUtil.printMsg("3", rows[i].getString(colNm_Tel_no), this);
							StringUtil.printMsg("4",rows[i].getString(colNm_Empno) , this);
							StringUtil.printMsg("5",rows[i].getString(colNm_Orderer_sid) , this);
							*/
							cstmt.setString     (1, rows[i].getString(colNm_User_nm)); 
							cstmt.setString     (2, rows[i].getString(colNm_Mobile_no));
							cstmt.setString     (3, rows[i].getString(colNm_Tel_no)); 
							cstmt.setString     (4, rows[i].getString(colNm_Orderer_company));
							cstmt.setString     (5, rows[i].getString(colNm_Empno));
							cstmt.setString	   (6, iParamEmpno);
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString     (1, rows[i].getString(colNm_User_nm)); 
							cstmt.setString     (2, rows[i].getString(colNm_Mobile_no));
							cstmt.setString     (3, rows[i].getString(colNm_Tel_no)); 
							cstmt.setString     (4, rows[i].getString(colNm_Orderer_company));
							cstmt.setString     (5, rows[i].getString(colNm_Empno));
							cstmt.setString     (6, iParamEmpno);
							cstmt.setString     (7, rows[i].getString(colNm_Orderer_sid));
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
							cstmt.setString     (1, rows[i].getString(colNm_Orderer_sid));
							cstmt.execute();
							break;
					}
				}
			}
		} catch (SQLException sqle){
			if(sqle.getErrorCode()==-532)
				res.writeException("ERROR",  sqle.getErrorCode()+"", "하위 데이터가 있으므로 삭제할 수 없습니다.");
			else 
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
	throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}