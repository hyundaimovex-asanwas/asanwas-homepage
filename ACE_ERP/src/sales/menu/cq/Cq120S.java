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

public class Cq120S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//탑승자 예정 현황
		arr_sql[0].append ("{call SALES.PR_CQ120S_01(?,?,?,?,?) }");

		//반조별 관광객 명단
		arr_sql[1].append ("{call SALES.PR_CQ120S_02(?,?,?,?,?) }");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));		// 사업소
		String sDepart_date = HDUtil.nullCheckStr(greq.getParameter("sDepart_date")); 	// 출경일자
		String sDepart_time = HDUtil.nullCheckStr(greq.getParameter("sDepart_time")); 	// 출경시간 
		int sGoods_sid 		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));		// 상품SID 
		/*
		StringUtil.printMsg("사업소",sSaup_sid,this);
		StringUtil.printMsg("출경일자",sDepart_date,this);
		StringUtil.printMsg("출경시간",sDepart_time,this);
		StringUtil.printMsg("상품SID",sGoods_sid+"",this);
		 */
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int j=0; j<dSets.length;j++){	
				//기본 검색 내역
				if(dSets[j].getName().equals("ds_cust")){
					GauceDataSet ds1 = gis.read("DS_CUST");
						//StringUtil.printMsg("arr_sql[0].toString()", arr_sql[0].toString(), this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, sSaup_sid);
						cstmt.setString(2, sDepart_date);
						cstmt.setString(3, sDepart_time);
						cstmt.setInt(4, sGoods_sid);
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));	
				} else if (dSets[j].getName().equals("ds_tour")){
					GauceDataSet ds1 = gis.read("DS_TOUR");
						//StringUtil.printMsg("arr_sql[1].toString()", arr_sql[1].toString(), this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, sSaup_sid);
						cstmt.setString(2, sDepart_date);
						cstmt.setString(3, sDepart_time);
						cstmt.setInt(4, sGoods_sid);
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


	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}