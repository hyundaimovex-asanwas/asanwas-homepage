package sales.menu.help;

import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
 
import oracle.jdbc.OracleTypes;

public class Rv012H extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++) {
            arr_sql[i] = new StringBuffer();
        }
		// TODO Auto-generated method stub
        arr_sql[0].append("{CALL SALES.PR_RV012H_01(?,?,?,?,?	,?)} ");

	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int    sClientSid 		= HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
		int    sAcceptSid 		= HDUtil.nullCheckNum(greq.getParameter("sAcceptSid"));
		String sAcceptDate 		= HDUtil.nullCheckStr(greq.getParameter("sAcceptDate"));
		String sAcceptTime 		= HDUtil.nullCheckStr(greq.getParameter("sAcceptTime"));
		String sCustNm 		    = HDUtil.nullCheckStr(greq.getParameter("sCustNm"));		
		
		//StringUtil.printMsg("sClientSid", sClientSid,this);
		//StringUtil.printMsg("sAcceptSid", sAcceptSid,this);
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int j=0; j<dSets.length;j++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[j].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DS1");

						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt   (1, sClientSid);
						cstmt.setInt   (2, sAcceptSid);
						cstmt.setString(3, sAcceptDate);
						cstmt.setString(4, sAcceptTime);
						cstmt.setString(5, sCustNm);
						cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 			
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
}
