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

public class Cq610S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_CQ610S_01(?,?,?)");
		arr_sql[2].append("CALL SALES.PR_CQ610S_02(?,?,?,?,?		,?)");
		arr_sql[3].append("CALL SALES.PR_CQ610S_03(?,?,?)");
		arr_sql[4].append("CALL SALES.PR_CQ610S_04(?,?,?)");
	}
 
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int v_rowcnt = 0;

		 int 	sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// 사업소
		 String	sJobDate		= HDUtil.nullCheckStr(greq.getParameter("sJobDate"));	// 상품 	
		 String sCustGu 		= HDUtil.nullCheckStr(greq.getParameter("sCustGu")); 	// 고객관리번호
		 String sManageNo		= HDUtil.nullCheckStr(greq.getParameter("sManageNo")); 	// 영업
		 String sName			= HDUtil.nullCheckStr(greq.getParameter("sName")); 		// 성명
		
		 /*
		StringUtil.printMsg("사업소",sSaup_sid+"",this);
		StringUtil.printMsg("상품",sJobDate,this);
		StringUtil.printMsg("고객구분",sCustGu,this);
		StringUtil.printMsg("고객관리번호",sManageNo,this);
		StringUtil.printMsg("이름",sName,this);
		*/
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int sCnt1 = 1;
			
			
			for(int i=0; i<dSets.length;i++){	
				//기본 검색 내역
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall(arr_sql[1].toString()); // 총괄
					cstmt.setInt(1,sSaup_sid);
					cstmt.setString(2,sJobDate);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
					}
					
				if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[2].toString());	//체류인원 현황
					cstmt.setInt(1,sSaup_sid);
					cstmt.setString(2, sJobDate);
					cstmt.setString(3, sCustGu);
					cstmt.setString(4, sManageNo);
					cstmt.setString(5, sName);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[3].toString()); // 총괄
					cstmt.setInt(1,sSaup_sid);
					cstmt.setString(2,sJobDate);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}				

				if(dSets[i].getName().equals("ds4")){
					GauceDataSet ds1 = gis.read("DS4");
					cstmt = conn.prepareCall(arr_sql[4].toString()); // 총괄
					cstmt.setInt(1,sSaup_sid);
					cstmt.setString(2,sJobDate);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}			
			}
				//gos.close();
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

	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}