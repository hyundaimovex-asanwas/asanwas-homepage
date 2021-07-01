package sales.menu.ac;

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

public class Ac420S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC420S_01(?,?,?,?,?	,?)");
	}
 
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;		
		//GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;

		/*
		 * 검색시 필요한 조건
		 */
		
		int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// 사업소
		int sGoods_sid 		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));			// 상품SID 
		int sClientSid 		= HDUtil.nullCheckNum(greq.getParameter("sClient_sid"));	// 매출처 
		String sSDate = HDUtil.nullCheckStr(greq.getParameter("sSDate")); 	// 출경일자
		String sEDate = HDUtil.nullCheckStr(greq.getParameter("sEDate")); 	// 출경시간 
		/*
		StringUtil.printMsg("사업소",sSaup_sid+"",this);
		StringUtil.printMsg("출발일 S",sSDate,this);
		StringUtil.printMsg("출발일 E",sEDate,this);
		StringUtil.printMsg("상품SID",sGoods_sid+"",this);
		StringUtil.printMsg("매출처",sClientSid+"",this);
		*/
		try {
			int sCnt1 = 1;
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
				
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2, sGoods_sid);
					cstmt.setInt(3, sClientSid);
					cstmt.setString(4, sSDate);
					cstmt.setString(5, sEDate);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));

            	}
			}
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
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