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

public class Rm310I extends SuperServlet {

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
		arr_sql[3].append ("SELECT SAUP_SID,				\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200				\n");
		
		//영업장
		arr_sql[4].append ("SELECT													\n")
					.append ("	0 UPJANG_SID, '전체' UPJANG_NM, 0 DISPLAY_SEQ    	\n")
					.append ("FROM DUAL                       	\n")
					.append ("UNION ALL                         \n")		
					.append ("SELECT UPJANG_SID,				\n")		
					.append ("			UPJANG_NM,				\n")
					.append ("			DISPLAY_SEQ				\n")					
					.append ("FROM SALES.TRM010					\n")
					.append ("WHERE SAUP_SID    =  ?			\n")
					.append ("	AND UPJANG_TYPE = '10'			\n")
					.append ("	AND USE_YN      = 'Y'			\n")
					.append ("ORDER BY DISPLAY_SEQ				\n");
		
		//객실타입
		arr_sql[5].append ("SELECT														\n")
					.append ("	0 ROOM_TYPE_SID, '전체' ROOM_TYPE_CD, 0 DISPLAY_SEQ    \n")
		  			.append ("FROM DUAL                       							\n")
		  			.append ("UNION ALL                                 \n")		
		  			.append ("SELECT 									\n")                                    
					.append ("		ROOM_TYPE_SID,                      \n")                
					.append ("		ROOM_TYPE_CD,                       \n")
					.append ("		DISPLAY_SEQ                         \n")					
					.append ("FROM SALES.TRM030							\n")
					.append ("WHERE 1=1									\n");		
   }

    
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
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
								//StringUtil.printMsg("call SALES.PR_RM310I_01","",this);
								cstmt = conn.prepareCall("{call SALES.PR_RM310I_01(?,?,?,?,?,     ?,?,?) }");
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
								cstmt = conn.prepareCall("{call SALES.PR_RM310I_02(?,?,?,?,?,    ?,?,?) }");
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
    	CallableStatement 	cstmt = null;	
 		ResultSet 			rs 	  = null;
 		
 		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
 		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
    	
 		/* DataSet */
		GauceDataSet inputDs1 = gis.read("DS1");
		GauceDataSet inputDs2 = gis.read("DS2");		
		GauceDataSet msgDS = gis.read("msgDS");
				
		boolean fail=false;
		
		try{
			if(inputDs1!=null){
			
				int colNm_UpjangSid 	= inputDs1.indexOfColumn("UPJANG_SID");
				int colNm_UseDate 		= inputDs1.indexOfColumn("USE_DATE");
				int colNm_RsvCloseDate 	= inputDs1.indexOfColumn("RSV_CLOSE_DATE");
				int colNm_OpenNm 		= inputDs1.indexOfColumn("OPEN_GOODS_NM");
				
				GauceDataRow[] 		rows = inputDs1.getDataRows();
				GauceDataColumn[] 	cols = inputDs1.getDataColumns();
				
				inner1: {
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call SALES.PR_RM310I_03","",this);
							cstmt = conn.prepareCall("{call SALES.PR_RM310I_03(?,?,?,?,?,    ?,?,?,?,?) }");
							cstmt.setInt(1,rows[i].getInt(colNm_UpjangSid));
							cstmt.setString(2,rows[i].getString(colNm_UseDate));
							cstmt.setString(3, rows[i].getString(colNm_RsvCloseDate));
							cstmt.setString(4, rows[i].getString(colNm_OpenNm));						
							cstmt.setString(5, iParamEmpno);
							cstmt.setString(6, iParamIp);
							cstmt.setString(7, "3");
							cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
	
							//메시지처리
							if (cstmt.getString(8).equals("Y") ) {
								if ( !cstmt.getString(9).equals("0000") ) {
									//StringUtil.printMsg("성공메시지",cstmt.getString(10),this);
									GauceDataRow row = msgDS.newDataRow();									
									row.addColumnValue(cstmt.getString(10));
									msgDS.addDataRow(row);
								}
							} else {
								//StringUtil.printMsg("실패메시지",cstmt.getString(10),this);								
								conn.rollback();
								GauceDataRow row = msgDS.newDataRow();								
								row.addColumnValue(cstmt.getString(10));
								msgDS.addDataRow(row);
								fail=true;
								break inner1;						
							} 
						
							if(cstmt!=null) cstmt.close();
							break;
					}
				}
			}
			}
			if(inputDs2!=null){
				int colNm_SelectDiv 	= inputDs2.indexOfColumn("SELECT_DIV");
				int colNm_RsvCnt 	= inputDs2.indexOfColumn("RSV_CNT");				
				int colNm_RoomTypeSid 	= inputDs2.indexOfColumn("ROOM_TYPE_SID");
				int colNm_UseDate 	= inputDs2.indexOfColumn("USE_DATE");				
				int colNm_UseYn1 	= inputDs2.indexOfColumn("USE_YN1");				
				int colNm_UseYn2 	= inputDs2.indexOfColumn("USE_YN2");	
				int colNm_OverBlockCnt 	= inputDs2.indexOfColumn("OVER_BLOCK_CNT");
				int colNm_Remarks1 	= inputDs2.indexOfColumn("REMARKS1");
				int colNm_Remarks2 	= inputDs2.indexOfColumn("REMARKS2");
				int colNm_Remarks3 	= inputDs2.indexOfColumn("REMARKS3");				
				int colNm_IntRsvYn 	= inputDs2.indexOfColumn("INT_RSV_YN");
			
				GauceDataRow[] 		rows2 = inputDs2.getDataRows();
				GauceDataColumn[] 	cols2 = inputDs2.getDataColumns();
				
				inner2:
				for(int i=0; i<rows2.length; i++){
					int j=1;
					switch(rows2[i].getJobType()){
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call SALES.PR_RM310I_04","",this);
							cstmt = conn.prepareCall("{call SALES.PR_RM310I_04(?,?,?,?,?,     ?,?,?,?,?,      ?,?,?,?,?) }");
							//StringUtil.printMsg("객실타입SID",rows2[i].getInt(colNm_RoomTypeSid),this);
							//StringUtil.printMsg("출발일",rows2[i].getString(colNm_UseDate),this);
							//StringUtil.printMsg("가용1",rows2[i].getString(colNm_UseYn1),this);
							//StringUtil.printMsg("가용2",rows2[i].getString(colNm_UseYn2),this);
							//StringUtil.printMsg("오버블럭",rows2[i].getInt(colNm_OverBlockCnt),this);
							//StringUtil.printMsg("인터넷오픈YN",rows2[i].getString(colNm_IntRsvYn),this);
							//StringUtil.printMsg("EmpNo",iParamEmpno,this);
							//StringUtil.printMsg("IP",iParamIp,this);
							//StringUtil.printMsg("참고1",rows2[i].getString(colNm_Remarks1),this);
							//StringUtil.printMsg("참고2",rows2[i].getString(colNm_Remarks2),this);
							//StringUtil.printMsg("참고3",rows2[i].getString(colNm_Remarks3),this);							
							
							cstmt.setInt(1,rows2[i].getInt(colNm_RoomTypeSid));
							cstmt.setString(2,rows2[i].getString(colNm_UseDate));
							
							if ( rows2[i].getString(colNm_UseYn1).equals("") ) 
								cstmt.setString(3, "N");
							else
								cstmt.setString(3, rows2[i].getString(colNm_UseYn1));
							
							if ( rows2[i].getString(colNm_UseYn2).equals("") ) 
								cstmt.setString(4, "N");
							else
								cstmt.setString(4, rows2[i].getString(colNm_UseYn2));	
							
							cstmt.setInt(5, rows2[i].getInt(colNm_OverBlockCnt));
							if ( rows2[i].getString(colNm_IntRsvYn).equals("T") ) 
								cstmt.setString(6, "Y");
							else
								cstmt.setString(6, "N");				
							cstmt.setString(7, rows2[i].getString(colNm_Remarks1));
							cstmt.setString(8, rows2[i].getString(colNm_Remarks2));
							cstmt.setString(9, rows2[i].getString(colNm_Remarks3));							
							cstmt.setString(10, iParamEmpno);
							cstmt.setString(11, iParamIp);
							cstmt.setString(12, "3");
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
							
							//메시지처리
							if (cstmt.getString(13).equals("Y") ) {
								if ( !cstmt.getString(14).equals("0000") ) {
									//StringUtil.printMsg("성공메시지",cstmt.getString(15),this);
									GauceDataRow row = msgDS.newDataRow();									
									row.addColumnValue(cstmt.getString(15));
									msgDS.addDataRow(row);
								}
							} else {
								//StringUtil.printMsg("실패메시지",cstmt.getString(15),this);								
								conn.rollback();
								GauceDataRow row = msgDS.newDataRow();								
								row.addColumnValue(cstmt.getString(15));
								msgDS.addDataRow(row);
								fail=true;
								break inner2;						
							}							
	
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
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}