package sales.menu.rv;

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

public class Rv811S extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_RV811S_01(?,?,?,?,?,  ?,?,?)"); // 조회: 인원 명단
		arr_sql[2].append("CALL SALES.PR_RV811S_02(?,?,?,?,?,  ?,?,?)"); //리포트 출력조회
		arr_sql[3].append("CALL SALES.PR_RV811S_03(?,?,?,?,?,  ?,?,?)"); // 조회: 차량 명단
		arr_sql[4].append("CALL SALES.PR_RV811S_04(?,?,?,?,?,  ?,?,?)"); // 조회: 인원+차량
		}
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			//검색시 필요한 조건
			int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// 사업소
			String sDepart_date = HDUtil.nullCheckStr(greq.getParameter("sDepart_date")); 	// 출경일자
			String sDepart_time = HDUtil.nullCheckStr(greq.getParameter("sDepart_time")); 	// 출경시간 
			int sGoods_sid 		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));			// 상품SID 
			int sClientSid 		= HDUtil.nullCheckNum(greq.getParameter("sClient_sid"));	// 매출처
			String v_accept_no 	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));	// 신청서번호		
			String sJobsel 	= HDUtil.nullCheckStr(greq.getParameter("sJobsel"));	// 신분구분
			/*
			StringUtil.printMsg("사업소",sSaup_sid+"",this);
			StringUtil.printMsg("출경일자",sDepart_date,this);
			StringUtil.printMsg("출경시간",sDepart_time,this);
			StringUtil.printMsg("상품SID",sGoods_sid+"",this);
			StringUtil.printMsg("매출처",sClientSid+"",this);
			StringUtil.printMsg("신청서번호",v_accept_no,this);
			StringUtil.printMsg("신분구분",sJobsel,this);
			 */
			int v_rowcnt = 0;
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//StringUtil.printMsg("dsType",dsType,this);
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DS1");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));	
					}
					if(dSets[i].getName().equals("ds_gr2")){
						GauceDataSet ds1 = gis.read("DS_GR2");
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));		
					}		
					if(dSets[i].getName().equals("ds_gr3")){
						GauceDataSet ds1 = gis.read("DS_GR3");
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));		
					}	
					if(dSets[i].getName().equals("ds9")){
						GauceDataSet ds1 = gis.read("REPORT");
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}