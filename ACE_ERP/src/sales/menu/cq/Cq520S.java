package sales.menu.cq;

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

public class Cq520S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
   }
 
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}	
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","조회",this);

		/* DataBase */
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		try {
			// 검색시 조건
			String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));
			/*
			StringUtil.printMsg("sSaupSid",sSaupSid,this);
			StringUtil.printMsg("sBgnDate",sBgnDate,this);
			StringUtil.printMsg("sDepartTime",sDepartTime,this);
			StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
			*/			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int j=0; j<dSets.length;j++){	
				//기본 검색 내역
				int sCnt1 = 1;
				if(dSets[j].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					//StringUtil.printMsg("call","SALES.PR_CQ520S_01",this);
					//cstmt = conn.prepareCall("{call SALES.PR_CQ520S_01(1, 0, '20060717', '') }");
					cstmt = conn.prepareCall("{call SALES.PR_CQ520S_01(?,?,?,?,?) }");
					cstmt.setInt(1, Integer.parseInt(sSaupSid));
					cstmt.setInt(2, Integer.parseInt(sGoodsSid));								
					cstmt.setString(3, sBgnDate);
					cstmt.setString(4, sDepartTime); 
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));	
				}
				if(dSets[j].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					//StringUtil.printMsg("call","SALES.PR_CQ520S_02",this);
					//cstmt = conn.prepareCall("{call SALES.PR_CQ520S_02(1, 0, '20060725', '') }");
					cstmt = conn.prepareCall("{call SALES.PR_CQ520S_02(?,?,?,?,?) }");
					cstmt.setInt(1, Integer.parseInt(sSaupSid));
					cstmt.setInt(2, Integer.parseInt(sGoodsSid));								
					cstmt.setString(3, sBgnDate);
					cstmt.setString(4, sDepartTime);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[j].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					//StringUtil.printMsg("call","SALES.PR_CQ520S_03",this);
					//cstmt = conn.prepareCall("{call SALES.PR_CQ520S_03(1, 0, '20060724', '') }");
					cstmt = conn.prepareCall("{call SALES.PR_CQ520S_03(?,?,?,?,?) }");
					cstmt.setInt(1, Integer.parseInt(sSaupSid));
					cstmt.setInt(2, Integer.parseInt(sGoodsSid));								
					cstmt.setString(3, sBgnDate);
					cstmt.setString(4, sDepartTime);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
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
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
}