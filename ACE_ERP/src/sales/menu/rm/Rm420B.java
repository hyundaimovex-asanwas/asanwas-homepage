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

public class Rm420B extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
    	arr_sql[0].append ("SELECT 																															\n")
    				.append ("		R1.GOODS_SID,                                                                         					\n")
					.append ("		SALES.FN_GOODS_CD(MAX(R1.GOODS_SID))   AS GOODS_CD,   			\n")
					.append ("		SALES.FN_GOODS_NM(MAX(R1.GOODS_SID), '')   AS GOODS_NM,   				\n")
					.append ("		'F' AS USE_YN,     																						\n")
					.append ("		TO_CHAR(SALES.FN_DATE(MAX(DEPART_DATE))+1,'YYYYMMDD') AS BGN_DATE,   		\n")
					.append ("		TO_CHAR(SALES.FN_DATE(MAX(DEPART_DATE))+365,'YYYYMMDD') AS END_DATE    		\n")
					.append ("FROM SALES.TRM200 R1 LEFT OUTER JOIN						\n")
					.append ("		SALES.TRM220 R2													\n")
					.append ("		ON R2.GOODS_SID = R1.GOODS_SID						\n")
					.append ("WHERE R1.USE_YN   = 'Y'	AND DEPART_DATE IS NOT NULL											\n");
		
		arr_sql[1].append ("DELETE FROM SALES.TRM220               \n")
					.append ("   			WHERE GOODS_SID      =  ?	\n")
					.append ("   				AND DEPART_DATE   >=  ?	\n")
					.append ("   				AND DEPART_DATE   <=  ?	\n");
		
		arr_sql[2].append ("INSERT INTO SALES.TRM220						\n")
					.append ("   		(DEPART_DATE,										\n")
					.append ("   		GOODS_SID,											\n")
					.append ("   		DEPART_TIME,											\n")
					.append ("   		NIGHTS,													\n")
					.append ("   		DAYS,														\n")
					.append ("   		ARRIVE_DATE,											\n")
					.append ("   		ARRIVE_TIME,											\n")
					.append ("   		DOCU_CLOSE_DATE,								\n")
					.append ("   		GOODS_CLOSE_DATE,								\n")
					.append ("   		ACCT_CLOSE_YN,								\n")
					.append ("   		U_EMPNO,												\n")
					.append ("   		U_IP)														\n")
					.append ("   		SELECT S1.CALN_DATE,							\n")
					.append ("   		R1.GOODS_SID,										\n")
					.append ("   		'' AS DEPART_TIME,									\n")
					.append ("   		R1.NIGHTS,												\n")
					.append ("   		R1.DAYS,													\n")
					.append ("   		TO_CHAR(SALES.FN_DATE(S1.CALN_DATE)+(R1.DAYS-1),'YYYYMMDD') AS ARRIVE_DATE,											\n")
					.append ("   		'' AS ARRIVE_TIME,									\n")
					.append ("   		TO_CHAR(SALES.FN_DATE(S1.CALN_DATE)+(SELECT CAST(ITEM1||1 AS NUMERIC) * CAST(ITEM2 AS NUMERIC) FROM SALES.TSY010 WHERE HEAD = 'RM008' AND DETAIL = '001'),'YYYYMMDD') AS DOCU_CLOSE_DATE,						\n")
					.append ("   		TO_CHAR(SALES.FN_DATE(S1.CALN_DATE)+(SELECT CAST(ITEM1||1 AS NUMERIC) * CAST(ITEM2 AS NUMERIC) FROM SALES.TSY010 WHERE HEAD = 'RM008' AND DETAIL = '002'),'YYYYMMDD') AS GOODS_CLOSE_DATE,						\n")
					.append ("   		'' AS ACCT_CLOSE_YN,									\n")
					.append ("'" + iParamEmpno + "',									\n")
					.append ("'" + iParamIp + "'											\n")
					.append ("   		FROM SALES.TSY100 S1,						\n")
					.append ("   		 (										\n")
					.append ("   		SELECT GOODS_SID,						\n")
					.append ("   		 NIGHTS,						\n")
					.append ("   		 DAYS						\n")							
					.append ("   		FROM SALES.TRM200						\n")
					.append ("   		WHERE GOODS_SID = ?						\n")
					.append ("   		) R1						\n")
					.append ("   		WHERE S1.CALN_DATE  >=  ?						\n")
					.append ("   		AND S1.CALN_DATE  <=  ?						\n")
					.append ("   		ORDER BY S1.CALN_DATE						\n");		
		
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	//System.out.println("# Command : 조회");
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			// 검색시 조건
			String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));

			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
						int sCnt1 = 1;
						if (!"".equals(sGoodsSid) && !"0".equals(sGoodsSid)) 
							arr_sql[0].append (" AND R1.GOODS_SID = ? \n");
							arr_sql[0].append (" GROUP BY R1.GOODS_SID, R1.GOODS_CD						\n ");
							arr_sql[0].append (" ORDER BY R1.GOODS_CD												\n ");							
							
							//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
							cstmt = conn.prepareCall(arr_sql[0].toString());
		
							if (!"".equals(sGoodsSid) && !"0".equals(sGoodsSid))
								cstmt.setString(1, sGoodsSid);
							//System.out.println(arr_sql[0].toString());
							rs = cstmt.executeQuery(); // DataSet set
							gos.write(getDataSet(rs, ds1));
					}
			 }
			 gos.close();
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
		
		GauceDataSet inputDs = gis.read("DEFAULT");
    	
		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					if ( rows[i].getString(3).equals("T") ) {		// 생성 체크시					
						int j=1;
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_UPDATE:
								//StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);
								cstmt = conn.prepareCall(arr_sql[1].toString());
								cstmt.setString(j++, rows[i].getString(0).trim());
								//StringUtil.printMsg("1",rows[i].getString(0),this);
								cstmt.setString(j++, rows[i].getString(4).trim());
								//StringUtil.printMsg("2",rows[i].getString(4),this);
								cstmt.setString(j++, rows[i].getString(5).trim());
								//StringUtil.printMsg("3",rows[i].getString(5),this);
	
								cstmt.executeUpdate();
								if(cstmt!=null) cstmt.close();
								
								j=1;
								//StringUtil.printMsg("arr_sql[2]",arr_sql[2].toString(),this);								
								cstmt = conn.prepareCall(arr_sql[2].toString());
								cstmt.setString(j++, rows[i].getString(0).trim());
								//StringUtil.printMsg("1",rows[i].getString(0),this);
								cstmt.setString(j++, rows[i].getString(4).trim());
								//StringUtil.printMsg("2",rows[i].getString(4),this);
								cstmt.setString(j++, rows[i].getString(5).trim());
								//StringUtil.printMsg("3",rows[i].getString(5),this);
								cstmt.executeUpdate();
								if(cstmt!=null) cstmt.close();						
							break;
						}
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
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}