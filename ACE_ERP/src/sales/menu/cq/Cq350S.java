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

public class Cq350S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ350S_01(?,?,?,?,?,	 ?,?,?,?,?)");
		
		arr_sql[2].append("CALL SALES.PR_CQ350S_02(?,?,?,?,?,	?,?,?,?,?)");
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

		 // 검색시 필요한 조건
		 int sSaupSid		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid")); 	// 지역 SID
		 String sDirection	= HDUtil.nullCheckStr(greq.getParameter("v_direction"));	// 방향
		 String sDate 		= HDUtil.nullCheckStr(greq.getParameter("v_date"));		// 일자 
		 String sTime		= HDUtil.nullCheckStr(greq.getParameter("v_time")); 		// 시각		
		 int sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid")); // 상품 SID
		 String sAccept_no	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no")); // 신청서번호

		 //고객쪽 추가조건
		 String sClass 		= HDUtil.nullCheckStr(greq.getParameter("v_class")); // 반
		 String sTeam		= HDUtil.nullCheckStr(greq.getParameter("v_team")); // 조 
		 String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("v_jobsel")); // 고객구분
		 /*		
		 StringUtil.printMsg("sSaupSid- ",sSaupSid , this);
		 StringUtil.printMsg("sDirection- ",sDirection , this);
		 StringUtil.printMsg("sDate- ",sDate , this);
		 StringUtil.printMsg("sTime- ",sTime , this);
		 StringUtil.printMsg("sGoodSid- ",sGoodSid , this);
		 StringUtil.printMsg("sClass- ",sClass , this);
		 StringUtil.printMsg("sTeam- ",sTeam , this);		
		 StringUtil.printMsg("sJobsel- ",sJobsel , this);	
		 StringUtil.printMsg("sAccept_no- ",sAccept_no , this);  
		 */
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, sSaupSid);	
					cstmt.setString(2, sDirection);
					cstmt.setString(3, sDate);	
					cstmt.setString(4, sTime);	
					cstmt.setInt(5, sGoodSid);	

					cstmt.setString(6, sClass);	
					cstmt.setString(7, sTeam);	
					cstmt.setString(8, sJobsel);
					cstmt.setString(9, sAccept_no);
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, sSaupSid);	
					cstmt.setString(2, sDirection);
					cstmt.setString(3, sDate);	
					cstmt.setString(4, sTime);	
					cstmt.setInt(5, sGoodSid);	

					cstmt.setString(6, sClass);	
					cstmt.setString(7, sTeam);	
					cstmt.setString(8, sJobsel);
					cstmt.setString(9, sAccept_no);
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 			
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