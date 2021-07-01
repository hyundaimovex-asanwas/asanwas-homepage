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

public class Rm430S extends SuperServlet {

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
    	arr_sql[0].append ("SELECT DEPART_DATE, 					\n")                                 
					.append ("		SALES.FN_GOODS_NM(GOODS_SID,'') AS GOODS_NM,   					\n")
					.append ("		DEPART_TIME,                                    					\n")
					.append ("		NIGHTS,                                         					\n")
					.append ("		DAYS,                                           					\n")
					.append ("		ARRIVE_DATE,                                    					\n")
					.append ("		ARRIVE_TIME,                                    					\n")
					.append ("		( CASE WHEN DOCU_CLOSE_YN='Y' THEN 'T' ELSE 'F' END ) AS DOCU_CLOSE_YN,                                  					\n")
					.append ("		DOCU_CLOSE_DATE,                                					\n")
					.append ("		( CASE WHEN GOODS_CLOSE_YN='Y' THEN 'T' ELSE 'F' END ) AS GOODS_CLOSE_YN,                                 					\n")
					.append ("		GOODS_CLOSE_DATE                                					\n")
					.append ("FROM SALES.TRM220 					\n")
					.append ("WHERE 1=1									\n");
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
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

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String	sEndDate  = HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));

			//StringUtil.printMsg("상품SID",sGoodsSid,this);
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
						switch(dsType){
							case 1:
								int sCnt1 = 1;
								
								if (!"".equals(sBgnDate)) 
									arr_sql[0].append (" AND DEPART_DATE >= ?  \n");
								if (!"".equals(sEndDate)) 
									arr_sql[0].append (" AND DEPART_DATE <= ? \n");
								if (!"".equals(sGoodsSid)) 
									arr_sql[0].append (" AND GOODS_SID = ? \n");
								
								//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);							
								cstmt = conn.prepareCall(arr_sql[0].toString());
			
								if (!"".equals(sBgnDate))
									cstmt.setString(sCnt1++, sBgnDate);
								if (!"".equals(sEndDate)) 
									cstmt.setString(sCnt1++, sEndDate);
								if (!"".equals(sGoodsSid)) 
									cstmt.setString(sCnt1++, sGoodsSid);
								
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
	}
}
