package sales.menu.rm;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
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
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class Rm010I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
    	arr_sql[0].append ("SELECT UPJANG_SID,                                                            /* 영업장SID					*/	\n")
				  .append ("       UPJANG_CD,                                                             /* 영업장코드  [Sort 기능]   	*/  \n")
				  .append ("       UPJANG_NM,                                                             /* 영업장명    [Sort 기능]   	*/  \n")
				  .append ("       UPJANG_ENG_NM,                                                         /* 영문명                    	*/  \n")
				  .append ("       UPJANG_SHORT_NM,                                                       /* 단축명                    	*/  \n")
				  .append ("       UPJANG_TYPE,                                                           /* 업장타입√                	*/  \n")
				  .append ("       DIRECT_YN,                                                             /* 직영                      	*/  \n")
				  .append ("       USE_YN,                                                                /* 사용                      	*/  \n")
				  .append ("       DISPLAY_SEQ,                                                           /* 순서        [Sort 기능]   	*/  \n")
				  .append ("       CLASS,                                                                 /* 반                  		*/  \n")
				  .append ("       REMARKS,                                                               /* 참고사항                  	*/  \n")
				  .append ("       SAUP_SID,                                                              /* 사업장SID                 	*/  \n")
				  .append ("       SALES.FN_DETAIL_NM('RM001', UPJANG_TYPE)       AS UPJANG_TYPE_NM,      /* 업장타입명                	*/  \n")
				  .append ("       (CASE WHEN DIRECT_YN = 'Y' THEN 'T' ELSE 'F' END) AS DIRECT_YN1,       /* 직영√       [Check Box]  	*/  \n")
				  .append ("       (CASE WHEN USE_YN = 'Y' THEN 'T' ELSE 'F' END) AS USE_YN1              /* 사용√       [Check Box]  	*/  \n")
				  .append ("FROM SALES.TRM010                                                                                               \n")
				  .append ("WHERE 1 = 1																										\n");
		
		arr_sql[1].append ("INSERT INTO SALES.TRM010													\n")
				  .append ("       (UPJANG_SID, UPJANG_CD, UPJANG_NM, UPJANG_ENG_NM, UPJANG_SHORT_NM, UPJANG_TYPE,  \n")
				  .append ("       DIRECT_YN, USE_YN, DISPLAY_SEQ, CLASS, REMARKS, SAUP_SID, U_EMPNO, U_IP)    \n")
				  .append ("VALUES ((SELECT COALESCE(MAX(UPJANG_SID), 0)+1 FROM SALES.TRM010), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)                                 \n");
		
		arr_sql[2].append ("UPDATE  SALES.TRM010								\n")
				  .append ("   SET  UPJANG_CD          = ?,                     \n")
				  .append ("        UPJANG_NM          = ?,                     \n")
				  .append ("        UPJANG_ENG_NM      = ?,                     \n")
				  .append ("        UPJANG_SHORT_NM    = ?,                     \n")
				  .append ("        UPJANG_TYPE        = ?,                     \n")
				  .append ("        DIRECT_YN          = ?,                     \n")
				  .append ("        USE_YN             = ?,                     \n")
				  .append ("        DISPLAY_SEQ        = ?,                     \n")
				  .append ("        CLASS              = ?,                     \n")
				  .append ("        REMARKS            = ?,                     \n")
				  .append ("        U_EMPNO            = ?,                     \n")
				  .append ("        U_DATE             = SYSTIMESTAMP,     \n")
				  .append ("        U_IP               = ?                      \n")
				  .append ("WHERE   UPJANG_SID         = ?                      \n");
		
		arr_sql[3].append ("DELETE FROM SALES.TRM010 WHERE UPJANG_SID = ?		\n");
    }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataBase */
    	ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		CallableStatement cstmt = null;

		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
			
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("ds1")){//고객구분
		    		GauceDataSet ds1 = gis.read("DEFAULT");
					switch(dsType){
						case 1:
							arr_sql[0].append("		 AND upjang_sid = 999999      						\n");
							cstmt = conn.prepareCall(arr_sql[0].toString());
							//StringUtil.printMsg("# arr_sql[0].toString()",arr_sql[0].toString(),this);
							rs = cstmt.executeQuery(); 
				   			gos.write(getDataSet(rs, ds1));// DataSet set
							break;
					}
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
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
    	//StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		try {
			// 검색시 조건
			int 	sSaupSid	= HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));
			String	sUpjangCd  = HDUtil.nullCheckStr(greq.getParameter("sUpjangCd"));
			String	sUpjangNm	= HDUtil.nullCheckStr(greq.getParameter("sUpjangNm"));

			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int j=0; j<dSets.length;j++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[j].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DEFAULT");
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							//res.enableFirstRow(ds1);
							if (sSaupSid !=0) 
								arr_sql[0].append (" AND SAUP_SID = ? ");
							if (!"".equals(sUpjangCd)) 
								arr_sql[0].append (" AND UPJANG_CD LIKE ? ");
							if (!"".equals(sUpjangNm)) 
								arr_sql[0].append (" AND UPJANG_NM LIKE ? ");
							//StringUtil.printMsg("arr_sql[0].toString() :",arr_sql[0].toString(),this);							
							cstmt = conn.prepareCall(arr_sql[0].toString()); 
		
							if (sSaupSid !=0) 
								cstmt.setInt(sCnt1++, sSaupSid);
		
							if (!"".equals(sUpjangCd))
								cstmt.setString(sCnt1++, sUpjangCd+"%");
		
							if (!"".equals(sUpjangNm)) 
								cstmt.setString(sCnt1++, sUpjangNm+"%");
		
							rs = cstmt.executeQuery(); 
				   			gos.write(getDataSet(rs, ds1));// DataSet set
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
							if(cstmt!=null) cstmt.close();
		
							//StringUtil.printMsg("# ResultSet Total Count : ", ds1.getDataRowCnt(),this);
							break;
					}
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

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet inputDs = gis.read("DEFAULT");
    	
    	int 	sSaupSid	= HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));
		
		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							for(; j<11;){
								//StringUtil.printMsg(j+"", cols[j].getColName() + " value [" + rows[i].getString(j).trim() + "] ", this);
  								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
									cstmt.setInt(j, rows[i].getInt(j++));
								else
									cstmt.setString(j, rows[i].getString(j++).trim());
							}
							
							cstmt.setInt(j++, sSaupSid);
							cstmt.setString(j++, iParamEmpno);
							cstmt.setString(j++, iParamIp);

							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							for(; j<11;){
								//StringUtil.printMsg(j + " : " + cols[j].getColName() + " value [" + rows[i].getString(j).trim() + "] ", this);
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
									cstmt.setInt(j, rows[i].getInt(j++));
								else
									cstmt.setString(j, rows[i].getString(j++).trim());
							}
							
							cstmt.setString(j++, iParamEmpno);
							cstmt.setString(j++, iParamIp);
							cstmt.setString(j++, rows[i].getString(0).trim());

							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
							cstmt.setString(1, rows[i].getString(0).trim());
							cstmt.execute();
							break;
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
	}
}