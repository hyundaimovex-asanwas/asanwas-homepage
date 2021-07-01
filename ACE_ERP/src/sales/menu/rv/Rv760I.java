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

public class Rv760I extends SuperServlet {

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
		arr_sql[0].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
		
		//	출경시간	
		arr_sql[1].append ("SELECT ' '           AS DEPART_TIME,			\n")
					.append ("		'전체'             AS DEPART_TIME_NM			\n")
					.append ("FROM DUAL			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT DETAIL AS DEPART_TIME,								\n")
					.append ("		DETAIL_NM	AS DEPART_TIME_NM						\n")
					.append ("FROM SALES.TSY010								\n")
					.append ("WHERE HEAD  = 'RM014'								\n")
					.append ("	AND ITEM1 = 'Y'								\n");
		
		//상품
		arr_sql[2].append ("SELECT 0                   AS GOODS_SID,					\n")     
					.append ("		'전체'              AS GOODS_NM       					\n")
					.append ("FROM DUAL					\n")
					.append ("UNION ALL					\n")
					.append ("SELECT GOODS_SID,					\n")
					.append ("		GOODS_NM					\n")
					.append ("FROM SALES.TRM200 R1					\n")
					.append ("WHERE SAUP_SID    =  ?					\n")
					.append ("	AND USE_YN      =  'Y'					\n");
		
		//고객구분
		arr_sql[3].append ("SELECT										\n")
					.append ("	' ' DETAIL, '전체' DETAIL_NM    \n")
					.append ("FROM DUAL                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT  					\n")
					.append ("		DETAIL,  					\n") 
					.append ("		DETAIL_NM  					\n")         
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD    =  'CU001'		\n")
					.append ("	AND DETAIL  >  ' '						\n")
					.append ("	AND ITEM1   =  'Y'   					\n");
		
		//반
		arr_sql[4].append ("SELECT ' '                 AS CLASS,			\n")          
					.append ("			'전체'             AS CLASS_NM			\n")         
					.append ("FROM DUAL			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT CLASS,			\n")
					.append ("			SALES.FN_DETAIL_NM('RV017', CLASS) AS CLASS_NM			\n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2			\n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE			\n")
					.append ("WHERE 1=1			\n");
	
		//조
		arr_sql[5].append ("SELECT ' '                 AS TEAMS,  				    \n")
					.append ("		'전체'             AS TEAMS_NM       				    \n")
					.append ("FROM DUAL  				    \n")
					.append ("UNION ALL  				    \n")
					.append ("SELECT TEAMS              AS TEAMS,  				    \n")
					.append ("		TEAMS              AS TEAMS_NM  				    \n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2  				    \n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE  				    \n")
					.append ("WHERE 1=1 				   \n");
		
		//국적구분
		arr_sql[6].append ("SELECT ' '                 	AS COUNTRY_GU,			\n")           
					.append ("			'전체'          AS COUNTRY_GU_NM         			\n")
					.append ("FROM DUAL			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT DETAIL 			AS COUNTRY_GU,			\n")
					.append ("		DETAIL_NM			AS COUNTRY_GU_NM		\n")
					.append ("FROM SALES.TSY010			\n")
					.append ("WHERE HEAD  = 'CU009'			\n")
					.append ("	AND ITEM1 = 'Y'			\n");
   }

    
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		//GauceDataSet ds1 = null;
		//GauceStatement stmt = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
		String 	sDepartDate	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
		String 	sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
		String 	sClass	= HDUtil.nullCheckStr(greq.getParameter("sClass"));	

		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
			
		    for(int i=0; i<dSets.length;i++){
		    	int sCnt1 = 1;
		   		if(dSets[i].getName().equals("ds3")){
		    		GauceDataSet ds1 = gis.read("DS3");
		    		cstmt = conn.prepareCall(arr_sql[1].toString());
		    		cstmt.setString(1, sSaupSid);
					cstmt.setString(2, sDepartDate);	
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   		} else if(dSets[i].getName().equals("ds4")){
		    		GauceDataSet ds1 = gis.read("DS4");
		    		cstmt = conn.prepareCall(arr_sql[2].toString());
		    		cstmt.setString(1, sSaupSid);
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   		} else if(dSets[i].getName().equals("ds5")){
		    		GauceDataSet ds1 = gis.read("DS5");
		    		cstmt = conn.prepareCall(arr_sql[3].toString());
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   		} else if(dSets[i].getName().equals("ds6")){
		    		GauceDataSet ds1 = gis.read("DS6");
		    		
		    		if (!"".equals(sDepartDate)) 
						arr_sql[4].append (" AND R1.DEPART_DATE = ? \n");
					if (!"".equals(sDepartTime)) 
						arr_sql[4].append (" AND R2.DEPART_TIME = ? \n");
					arr_sql[4].append ("GROUP BY CLASS			");
					
		    		cstmt = conn.prepareCall(arr_sql[4].toString());
		    		
		    		if (!"".equals(sDepartDate))
						cstmt.setString(sCnt1++, sDepartDate);
					if (!"".equals(sDepartTime))
						cstmt.setString(sCnt1++, sDepartTime);
					
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   		} else if(dSets[i].getName().equals("ds7")){
		    		GauceDataSet ds1 = gis.read("DS7");
		    		
		    		if (!"".equals(sDepartDate)) 
						arr_sql[5].append (" AND R1.DEPART_DATE = ? \n");
					if (!"".equals(sDepartTime)) 
						arr_sql[5].append (" AND R2.DEPART_TIME = ? \n");
					if (!"".equals(sClass)) 
						arr_sql[5].append (" AND R2.CLASS = ? \n");
					arr_sql[5].append ("GROUP BY TEAMS  				    ");
					
		    		cstmt = conn.prepareCall(arr_sql[5].toString());
		    		
		    		if (!"".equals(sDepartDate))
						cstmt.setString(sCnt1++, sDepartDate);
					if (!"".equals(sDepartTime))
						cstmt.setString(sCnt1++, sDepartTime);
					if (!"".equals(sClass))
						cstmt.setString(sCnt1++, sClass);	
					
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   		}else if(dSets[i].getName().equals("ds8")){
		    		GauceDataSet ds1 = gis.read("DS8");
		    		
		    		cstmt = conn.prepareCall(arr_sql[6].toString());
		    		
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
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
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		//GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));
			String 	sCustGu		= HDUtil.nullCheckStr(greq.getParameter("sCustGu"));
			String 	sClass		= HDUtil.nullCheckStr(greq.getParameter("sClass"));
			String 	sTeams		= HDUtil.nullCheckStr(greq.getParameter("sTeams"));
			String 	sSRejectYn	= HDUtil.nullCheckStr(greq.getParameter("sSRejectYn"));
			String 	sCountryGu	= HDUtil.nullCheckStr(greq.getParameter("sCountryGu"));
			
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DS1");
						switch(dsType){
							case 1:
							int sCnt1 = 1;
							//res.enableFirstRow(ds1);
							
							//StringUtil.printMsg("sSaupSid",sSaupSid,this);
							//StringUtil.printMsg("sDepartTime",sDepartTime,this);
							//StringUtil.printMsg("sGoodsSid",sGoodsSid,this);							
							
							cstmt = conn.prepareCall("{call SALES.PR_RV760I_01(?,?,?,?,?, 	?,?,?,?,?) }");							
							cstmt.setString(1, sBgnDate);
							cstmt.setString(2, sDepartTime);
							cstmt.setInt(3, Integer.parseInt(sSaupSid));
							cstmt.setInt(4, Integer.parseInt(sGoodsSid));
							cstmt.setString(5, sCustGu);
							cstmt.setString(6, sClass);
							cstmt.setString(7, sTeams);
							cstmt.setString(8, sSRejectYn);
							cstmt.setString(9, sCountryGu);
							cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 			
							gos.write(getDataSet(rs, ds1));
					}
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

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		GauceDataSet inputDs = gis.read("DEFAULT");
		GauceDataSet ds9 = gis.read("DS9");
		
		CallableStatement cstmt = null;		
		boolean fail=false;		
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
				
				int colNm_RsvSid                = inputDs.indexOfColumn("RSV_SID");
				int colNm_UnityNo                = inputDs.indexOfColumn("UNITY_NO");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//res.enableFirstRow(ds9);
				ds9.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
				GauceDataRow row = ds9.newDataRow();						
				
				inner : {
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call SALES.PR_RV760I_02_00001","call SALES.PR_RV760I_02_00001",this);						
							cstmt = conn.prepareCall("{call SALES.PR_RV760I_02(?,?,?,?,?,	 ?,?,?) }");						
							
							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));						
							cstmt.setString(2, rows[i].getString(colNm_UnityNo));
							cstmt.setString(3, iParamEmpno);
							cstmt.setString(4, iParamIp);
							cstmt.setString(5, "3");  
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
	
							if (cstmt.getString(6).equals("Y") ) {
								if ( !cstmt.getString(7).equals("0000") ) {
									//StringUtil.printMsg("성공메시지","성공메시지",this);								
									row.addColumnValue(cstmt.getString(8));
								}
							} else {
								//StringUtil.printMsg("실패메시지","실패메시지",this);							
								conn.rollback();
								row.addColumnValue(cstmt.getString(8));	
								fail = true;								
								break inner;						
							} 
							if(cstmt!=null) cstmt.close();
							break;
						}
					}
				}
				ds9.addDataRow(row);	
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
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}