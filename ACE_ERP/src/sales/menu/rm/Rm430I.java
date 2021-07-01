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

public class Rm430I extends SuperServlet {

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
		
    	arr_sql[0].append ("SELECT 'F'                              AS USE_YN, 								\n")   
					.append ("		R1.DEPART_DATE,                                    									\n")
					.append ("		SALES.FN_YOIL_NM(R1.DEPART_DATE)    AS YOIL_NM,  			\n")					
					.append ("		R1.GOODS_SID,                                      									\n")
					.append ("		SALES.FN_GOODS_CD(R1.GOODS_SID)     AS GOODS_CD, 				\n")  
					.append ("		SALES.FN_GOODS_NM(R1.GOODS_SID, '') AS GOODS_NM,   				\n")
					.append ("		R1.DEPART_TIME,                                    									\n")
					.append ("		R1.NIGHTS,                                         										\n")
					.append ("		R1.DAYS,                                           										\n")
					.append ("		R1.ARRIVE_DATE,                                    									\n")
					.append ("		R1.ARRIVE_TIME 																		\n")
					.append ("FROM SALES.TRM220 R1 JOIN SALES.TRM200 R2 ON(R1.GOODS_SID=R2.GOODS_SID)   	\n")
					.append ("WHERE 1=1 																					\n");
		
		arr_sql[1].append ("INSERT INTO SALES.TRM220		\n")
					.append ("(	DEPART_DATE,		\n")
					.append ("	GOODS_SID,		\n")
					.append ("	DEPART_TIME,		\n")
					.append ("	NIGHTS,		\n")
					.append ("	DAYS,		\n")
					.append ("	ARRIVE_DATE,		\n")
					.append ("	ARRIVE_TIME,		\n")
					.append ("	ACCT_CLOSE_YN,		\n")
					.append ("	U_EMPNO,		\n")
					.append ("	U_IP)		\n")
					.append ("VALUES (?, ?, ?, ?, ?, ?, ?, '',?, ?)		\n");
		
		arr_sql[2].append ("UPDATE SALES.TRM220										\n")
					.append ("SET DEPART_TIME       =  ?,										\n")
					.append ("		NIGHTS            =  ?,										\n")
					.append ("		DAYS              =  ?,										\n")
					.append ("		ARRIVE_TIME       =  ?										\n")
					.append ("WHERE DEPART_DATE       =  ?										\n")
					.append ("	AND GOODS_SID         = ?										\n");
		
		arr_sql[3].append ("DELETE FROM SALES.TRM220 			\n")
					.append ("WHERE DEPART_DATE = ? AND GOODS_SID = ?		\n");
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","조회",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String	sEndDate    = HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));
			String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			//StringUtil.printMsg("sBgnDate",sBgnDate,this);
			//StringUtil.printMsg("sEndDate",sEndDate,this);
			//StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
			//StringUtil.printMsg("sSaupSid",sSaupSid,this);

			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
						switch(dsType){
						case 1:
							int sCnt1 = 1;
							
							if (!"".equals(sBgnDate)) 
								arr_sql[0].append (" AND R1.DEPART_DATE >= ?  \n");
							if (!"".equals(sEndDate)) 
								arr_sql[0].append (" AND R1.DEPART_DATE <= ? \n");
							if (!"".equals(sGoodsSid) && !"0".equals(sGoodsSid)) 
								arr_sql[0].append (" AND R1.GOODS_SID = ? \n");
							if (!"".equals(sSaupSid) && !"0".equals(sSaupSid)) 
								arr_sql[0].append (" AND R2.SAUP_SID = ? \n");
							
							
							//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
							cstmt = conn.prepareCall(arr_sql[0].toString());
							
							if (!"".equals(sBgnDate))
								cstmt.setString(sCnt1++, sBgnDate);
							if (!"".equals(sEndDate)) 
								cstmt.setString(sCnt1++, sEndDate);
							if (!"".equals(sGoodsSid) && !"0".equals(sGoodsSid)) 
								cstmt.setString(sCnt1++, sGoodsSid);
							if (!"".equals(sSaupSid) && !"0".equals(sSaupSid)) 
								cstmt.setString(sCnt1++, sSaupSid);
														
							rs = cstmt.executeQuery(); // DataSet set
							gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
							break;
						}
					}
			}
			gos.close();
		} catch (SQLException sqle){
			//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//gres..writeException("ERROR", "", e.toString());
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
    	
    	try{
			GauceDataSet inputDs = gis.read("DEFAULT");
			GauceDataRow[] 		rows = inputDs.getDataRows();
			GauceDataColumn[] 	cols = inputDs.getDataColumns();
			
			if(inputDs!=null){
				
				int colNm_DepartDate 	= inputDs.indexOfColumn("DEPART_DATE");	
				int colNm_GoodsSid 	= inputDs.indexOfColumn("GOODS_SID");
				int colNm_SaupSid 	= inputDs.indexOfColumn("SAUP_SID");	
				int colNm_GoodsCd 	= inputDs.indexOfColumn("GOODS_CD");	
				int colNm_GoodsNm 	= inputDs.indexOfColumn("GOODS_NM");
				int colNm_DepartTime 	= inputDs.indexOfColumn("DEPART_TIME");
				int colNm_Nights 	= inputDs.indexOfColumn("NIGHTS");
				int colNm_Days 	= inputDs.indexOfColumn("DAYS");
				int colNm_ArriveDate 	= inputDs.indexOfColumn("ARRIVE_DATE");
				int colNm_ArriveTime 	= inputDs.indexOfColumn("ARRIVE_TIME");
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							//StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);
							cstmt.setString(j++, rows[i].getString(colNm_DepartDate));
							cstmt.setInt(j++, rows[i].getInt(colNm_GoodsSid));								
							cstmt.setString(j++, rows[i].getString(colNm_DepartTime));
							cstmt.setInt(j++, rows[i].getInt(colNm_Nights));
							cstmt.setInt(j++, rows[i].getInt(colNm_Days));
							cstmt.setString(j++, rows[i].getString(colNm_ArriveDate));
							cstmt.setString(j++, rows[i].getString(colNm_ArriveTime));
							cstmt.setString(j++, iParamEmpno);
							cstmt.setString(j++, iParamIp);							
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();						
						break;
						
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[2].toString());
	
							//StringUtil.printMsg("arr_sql[2]",arr_sql[2].toString(),this);
							cstmt.setString(j++, rows[i].getString(colNm_DepartTime));
							cstmt.setInt(j++, rows[i].getInt(colNm_Nights));
							cstmt.setInt(j++, rows[i].getInt(colNm_Days));
							cstmt.setString(j++, rows[i].getString(colNm_ArriveTime));
							cstmt.setString(j++, rows[i].getString(colNm_DepartDate));
							cstmt.setInt(j++, rows[i].getInt(colNm_GoodsSid));
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();							
						break;
					
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());

							//StringUtil.printMsg("arr_sql[3]",arr_sql[3].toString(),this);
							cstmt.setString(j++, rows[i].getString(colNm_DepartDate));
							cstmt.setInt(j++, rows[i].getInt(colNm_GoodsSid));
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();							
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
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}