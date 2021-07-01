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

public class Rm310S extends SuperServlet {

	
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
		
		//사업소
		arr_sql[3].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
		
		//영업장
		arr_sql[4].append ("SELECT										\n")
					.append ("	0 UPJANG_SID, '전체' UPJANG_NM, 0 DISPLAY_SEQ    \n")
					.append ("FROM DUAL                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT UPJANG_SID,				\n")		
					.append ("			UPJANG_NM,				\n")
					.append ("			DISPLAY_SEQ				\n")					
					.append ("FROM SALES.TRM010				\n")
					.append ("WHERE SAUP_SID    =  ?				\n")
					.append ("	AND UPJANG_TYPE = '10'				\n")
					.append ("	AND USE_YN      = 'Y'				\n")
					.append ("ORDER BY DISPLAY_SEQ					\n");
		
		//객실타입
		arr_sql[5].append ("SELECT										\n")
					.append ("	0 ROOM_TYPE_SID, '전체' ROOM_TYPE_CD, 0 DISPLAY_SEQ    \n")
		  			.append ("FROM DUAL                       \n")
		  			.append ("UNION ALL                                   \n")		
		  			.append ("SELECT 															\n")                                    
					.append ("		ROOM_TYPE_SID,                       															\n")                
					.append ("		ROOM_TYPE_CD,                                      											\n")
					.append ("		DISPLAY_SEQ                                      											\n")					
					.append ("FROM SALES.TRM030															\n")
					.append ("WHERE USE_YN='Y'															\n");
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	//StringUtil.printMsg("# Command","선조회",this);
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
		String 	sUpjangSid	= HDUtil.nullCheckStr(greq.getParameter("sUpjangSid"));		
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput();
			
		    for(int i=0; i<dSets.length;i++){
			   	if(dSets[i].getName().equals("ds3")){
		   			GauceDataSet ds1 = gis.read("DS3");
		   			cstmt = conn.prepareCall(arr_sql[3].toString());
		   			//System.out.println("# Query ds3 : " + arr_sql[3].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				} else if(dSets[i].getName().equals("ds4")){
					GauceDataSet ds1 = gis.read("DS4");
					//System.out.println("# Query ds4 : " + arr_sql[4].toString());
					//StringUtil.printMsg("sSaupSid",sSaupSid,this);
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setString(1, sSaupSid);	
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				} else if(dSets[i].getName().equals("ds5")){
					GauceDataSet ds1 = gis.read("DS5");
					//StringUtil.printMsg("sUpjangSid",sUpjangSid,this);
						if ( !sUpjangSid.equals("") && !sUpjangSid.equals("0") )
							arr_sql[5].append("AND UPJANG_SID = ?										\n");
							arr_sql[5].append ("ORDER BY DISPLAY_SEQ									\n");
							cstmt = conn.prepareCall(arr_sql[5].toString());
						if ( !sUpjangSid.equals("") && !sUpjangSid.equals("0") )
							cstmt.setInt(1, Integer.parseInt(sUpjangSid) );
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
	
    // 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
			String 	sUpjangSid	= HDUtil.nullCheckStr(greq.getParameter("sUpjangSid"));
			String 	sRoomTypeSid	= HDUtil.nullCheckStr(greq.getParameter("sRoomTypeSid"));
			String 	sQTypeCd	= HDUtil.nullCheckStr(greq.getParameter("sQTypeCd"));
			String 	sQTypeStr	= HDUtil.nullCheckStr(greq.getParameter("sQTypeStr"));			
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DS1");
								//StringUtil.printMsg("call SALES.PR_RM310S_01","",this);
								cstmt = conn.prepareCall("{call SALES.PR_RM310S_01(?,?,?,?,?,   ?,?,?) }");
								cstmt.setInt(1, Integer.parseInt(sSaupSid));
								cstmt.setInt(2, Integer.parseInt(sUpjangSid));
								cstmt.setInt(3, Integer.parseInt(sRoomTypeSid));
								cstmt.setString(4, sBgnDate);
								cstmt.setString(5, sEndDate);
								cstmt.setString(6, sQTypeCd);
								cstmt.setString(7, sQTypeStr);	
								cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
								cstmt.executeQuery();
								rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
								gos.write(getDataSet(rs, ds1));
							}
					if(dSets[i].getName().equals("ds2")){
						GauceDataSet ds1 = gis.read("DS2");
								//StringUtil.printMsg("call SALES.PR_RM310I_02","",this);
								cstmt = conn.prepareCall("{call SALES.PR_RM310S_02(?,?,?,?,?,     ?,?,?) }");
								//StringUtil.printMsg("sSaupSid",sSaupSid,this);
								//StringUtil.printMsg("sUpjangSid",sUpjangSid,this);
								//StringUtil.printMsg("sRoomTypeSid",sRoomTypeSid,this);								
								cstmt.setInt(1, Integer.parseInt(sSaupSid));
								cstmt.setInt(2, Integer.parseInt(sUpjangSid));
								cstmt.setInt(3, Integer.parseInt(sRoomTypeSid));
								cstmt.setString(4, sBgnDate);
								cstmt.setString(5, sEndDate);
								cstmt.setString(6, sQTypeCd);
								cstmt.setString(7, sQTypeStr);								
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