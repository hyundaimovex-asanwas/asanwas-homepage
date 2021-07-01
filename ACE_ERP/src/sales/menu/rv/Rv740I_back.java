package sales.menu.rv;


import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

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

public class Rv740I_back extends SuperServlet {

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
		arr_sql[1].append ("SELECT ''                 AS DEPART_TIME,		")
					.append ("		'전체'             AS DEPART_TIME_NM		")
					.append ("FROM SYSIBM.SYSDUMMY1		")
					.append ("UNION ALL		")
					.append ("SELECT R2.DEPART_TIME,		")
					.append ("		SALES.FMT_TIME(R2.DEPART_TIME) AS DEPART_TIME_NM		")
					.append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2		")
					.append ("ON R2.GOODS_SID   = R1.GOODS_SID		")
					.append ("WHERE R1.SAUP_SID    = ?		")
					.append ("	AND R2.DEPART_DATE = ?		")
					.append ("GROUP BY R2.DEPART_TIME		");
		
		//상품
		arr_sql[2].append ("SELECT 0                   AS GOODS_SID,    ")
					.append ("		'전체'              AS GOODS_NM    ")       
					.append ("FROM SYSIBM.SYSDUMMY1    ")
					.append ("UNION ALL    ")
					.append ("SELECT R1.GOODS_SID,    ")
					.append ("		MIN(R1.GOODS_NM)   AS GOODS_NM    ")
					.append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2    ")
					.append ("ON R2.GOODS_SID   = R1.GOODS_SID    ")
					.append ("WHERE R1.SAUP_SID    = ?    ")
					.append ("	AND R2.DEPART_DATE = ?    ")
					.append ("GROUP BY R1.GOODS_SID    ");
		
		//고객구분
		arr_sql[3].append ("SELECT										\n")
					.append ("	'' DETAIL, '전체' DETAIL_NM    \n")
					.append ("FROM SYSIBM.SYSDUMMY1                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT  					\n")
					.append ("		DETAIL,  					\n") 
					.append ("		DETAIL_NM  					\n")         
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD    =  'CU001'		\n")
					.append ("	AND DETAIL  >  ' '						\n")
					.append ("	AND ITEM1   =  'Y'   					\n");
		
		//반
		arr_sql[4].append ("SELECT ''                 AS CLASS,			\n")          
					.append ("			'전체'             AS CLASS_NM			\n")         
					.append ("FROM SYSIBM.SYSDUMMY1			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT CLASS,			\n")
					.append ("			SALES.FN_DETAIL_NM('RV017', CLASS) AS CLASS_NM			\n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2			\n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE			\n")
					.append ("WHERE 1=1			\n");
	
		//조
		arr_sql[5].append ("SELECT ''                 AS TEAMS,  				    \n")
					.append ("		'전체'             AS TEAMS_NM       				    \n")
					.append ("FROM SYSIBM.SYSDUMMY1  				    \n")
					.append ("UNION ALL  				    \n")
					.append ("SELECT TEAMS              AS TEAMS,  				    \n")
					.append ("		TEAMS              AS TEAMS_NM  				    \n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2  				    \n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE  				    \n")
					.append ("WHERE 1=1 				   \n");
		
		//동숙구분
		arr_sql[6].append ("SELECT ''                 AS JOIN_CD, 				\n")    
					.append ("		'전체'             AS JOIN_CD_NM    				\n")
					.append ("FROM SYSIBM.SYSDUMMY1 				\n")
					.append ("UNION ALL 				\n")
					.append ("SELECT DETAIL, 				\n")
					.append ("		DETAIL_NM 				\n")
					.append ("FROM SALES.TSY010 				\n")
					.append ("WHERE HEAD  = 'RV006' 				\n")
					.append ("	AND ITEM1 = 'Y' 				\n");
   }

    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		String 	sDepartDate	= HDUtil.nullCheckStr(req.getParameter("sDepartDate"));
		String 	sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime"));
		String 	sClass	= HDUtil.nullCheckStr(req.getParameter("sClass"));	

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS2")){
								StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[0].toString());
							} 
							if(gauceName.equals("DS3")){
								StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, sSaupSid);
								stmt.setString(2, sDepartDate);								
							} 							
							if(gauceName.equals("DS4")){
								StringUtil.printMsg("arr_sql[2]",arr_sql[2].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[2].toString());
								stmt.setString(1, sSaupSid);
								stmt.setString(2, sDepartDate);								
							} 												
							if(gauceName.equals("DS5")){
								StringUtil.printMsg("arr_sql[3]",arr_sql[3].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[3].toString());
							} 												
							if(gauceName.equals("DS6")){

								if (!"".equals(sDepartDate)) 
									arr_sql[4].append (" AND R1.DEPART_DATE = ? \n");
								if (!"".equals(sDepartTime)) 
									arr_sql[4].append (" AND R2.DEPART_TIME = ? \n");
								arr_sql[4].append ("GROUP BY CLASS			");
								
								StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[4].toString());
								
								if (!"".equals(sDepartDate))
									stmt.setString(sCnt1++, sDepartDate);
								if (!"".equals(sDepartTime))
									stmt.setString(sCnt1++, sDepartTime);
							} 												
							if(gauceName.equals("DS7")){
								
								if (!"".equals(sDepartDate)) 
									arr_sql[5].append (" AND R1.DEPART_DATE = ? \n");
								if (!"".equals(sDepartTime)) 
									arr_sql[5].append (" AND R2.DEPART_TIME = ? \n");
								if (!"".equals(sClass)) 
									arr_sql[5].append (" AND R2.CLASS = ? \n");
								arr_sql[5].append ("GROUP BY TEAMS  				    ");
								
								StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[5].toString());
								
								if (!"".equals(sDepartDate))
									stmt.setString(sCnt1++, sDepartDate);
								if (!"".equals(sDepartTime))
									stmt.setString(sCnt1++, sDepartTime);
								if (!"".equals(sClass))
									stmt.setString(sCnt1++, sClass);	
							} 	
							if(gauceName.equals("DS8")){
								StringUtil.printMsg("arr_sql[6]",arr_sql[6].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[6].toString());
							} 								
								rs = stmt.executeQuery(); // DataSet set
								getDataSet(rs, ds1).flush();
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));
			String 	sClass	= HDUtil.nullCheckStr(req.getParameter("sClass"));
			String 	sTeams	= HDUtil.nullCheckStr(req.getParameter("sTeams"));			
			String 	sCustGu	= HDUtil.nullCheckStr(req.getParameter("sCustGu"));
			String 	sAcceptNo	= HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
			String 	sRoomSid	= HDUtil.nullCheckStr(req.getParameter("sRoomSid"));			

			StringUtil.printMsg("sBgnDate",sBgnDate,this);
			StringUtil.printMsg("sDepartTime",sDepartTime,this);
			StringUtil.printMsg("sSaupSid",sSaupSid,this);
			StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
			StringUtil.printMsg("sCustGu",sCustGu,this);
			StringUtil.printMsg("sClass",sClass,this);
			StringUtil.printMsg("sTeams",sTeams,this);
			StringUtil.printMsg("sAcceptNo",sAcceptNo,this);
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							
							if(gauceName.equals("DS1")){
								StringUtil.printMsg("call","SALES.PR_RV740I_01",this);
								cstmt = conn.prepareCall("{call SALES.PR_RV740I_01(?, ?, ?, ?, ?, ?, ?, ?) }");							
								cstmt.setString(1, sBgnDate);
								cstmt.setString(2, sDepartTime);
								cstmt.setInt(3, Integer.parseInt(sSaupSid));
								cstmt.setInt(4, Integer.parseInt(sGoodsSid));
								cstmt.setString(5, sCustGu);
								cstmt.setString(6, sClass);
								cstmt.setString(7, sTeams);
								cstmt.setString(8, sAcceptNo);
							} 
							if(gauceName.equals("DS9")){
								StringUtil.printMsg("call","SALES.PR_RV740I_02",this);								
								cstmt = conn.prepareCall("{call SALES.PR_RV740I_02(?, ?, ?, ?, ?, ?, ?, ?) }");							
								cstmt.setString(1, sBgnDate);
								cstmt.setString(2, sDepartTime);
								cstmt.setInt(3, Integer.parseInt(sSaupSid));
								cstmt.setInt(4, Integer.parseInt(sGoodsSid));
								cstmt.setString(5, sCustGu);
								cstmt.setString(6, sClass);
								cstmt.setString(7, sTeams);
								cstmt.setString(8, sAcceptNo);
							}	
							if(gauceName.equals("DS10")){
								StringUtil.printMsg("call","SALES.PR_RV740I_03",this);								
								cstmt = conn.prepareCall("{call SALES.PR_RV740I_03(?, ?, ?, ?, ?, ?, ?, ?, ?) }");							
								cstmt.setString(1, sBgnDate);
								cstmt.setString(2, sDepartTime);
								cstmt.setInt(3, Integer.parseInt(sSaupSid));
								cstmt.setInt(4, Integer.parseInt(sGoodsSid));
								cstmt.setString(5, sCustGu);
								cstmt.setString(6, sClass);
								cstmt.setString(7, sTeams);
								cstmt.setString(8, sAcceptNo);
								cstmt.setInt(9, Integer.parseInt(sRoomSid));								
							}								
							rs = cstmt.executeQuery();							
							
							rsmd = rs.getMetaData();
							columnName = new String[rsmd.getColumnCount()];
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));										
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));										
							}
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();
								for(int i=0; i<columnName.length; i++) {
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										row.addColumnValue(rs.getInt(columnName[i]));
									else
										row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								}
								ds1.addDataRow(row);
							}//End of while
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
		
							StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
							break;
					}
				}
				ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.				
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
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
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;	
		boolean fail=false;		
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			inner: {
			if(inputDs!=null){
				
				String commitDiv = "";
				int colNm_RsvSid                = inputDs.indexOfColumn("RSV_SID");
				int colNm_MRsvSid                = inputDs.indexOfColumn("M_RSV_SID");
				int colNm_RoomTypeSid                = inputDs.indexOfColumn("ROOM_TYPE_SID");
				int colNm_RoomSid                = inputDs.indexOfColumn("ROOM_SID");
				int colNm_JoinCd                = inputDs.indexOfColumn("JOIN_CD");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:

						StringUtil.printMsg("call","SALES.PR_RV740I_04-INSERT",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV740I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
					
						cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
						cstmt.setInt(2, rows[i].getInt(colNm_MRsvSid));
						cstmt.setInt(3, rows[i].getInt(colNm_RoomTypeSid));
						cstmt.setInt(4, rows[i].getInt(colNm_RoomSid));
						cstmt.setString(5, rows[i].getString(colNm_JoinCd));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, iParamIp);
						cstmt.setString(8, "1");
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//메시지처리
						if (cstmt.getString(9).equals("Y") ) {
							if ( !cstmt.getString(10).equals("0000") ) {
								StringUtil.printMsg("성공메시지","성공메시지",this);
								GauceDataRow row = msgDS.newDataRow();									
								row.addColumnValue(cstmt.getString(11));
								msgDS.addDataRow(row);
							}
						} else {
							StringUtil.printMsg("실패메시지","실패메시지",this);								
							conn.rollback();
							GauceDataRow row = msgDS.newDataRow();								
							row.addColumnValue(cstmt.getString(11));
							msgDS.addDataRow(row);
							fail = true;							
							break inner;						
						}						

						if(cstmt!=null) cstmt.close();
						break;
						
					case GauceDataRow.TB_JOB_UPDATE:
						StringUtil.printMsg("call","SALES.PR_RV740I_04-UPDATE",this);						
						cstmt = conn.prepareCall("{call SALES.PR_RV740I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
						
						cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
						cstmt.setInt(2, rows[i].getInt(colNm_MRsvSid));
						cstmt.setInt(3, rows[i].getInt(colNm_RoomTypeSid));
						cstmt.setInt(4, rows[i].getInt(colNm_RoomSid));
						cstmt.setString(5, rows[i].getString(colNm_JoinCd));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, iParamIp);
						cstmt.setString(8, "1");
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();

						//메시지처리
						if (cstmt.getString(9).equals("Y") ) {
							if ( !cstmt.getString(10).equals("0000") ) {
								StringUtil.printMsg("성공메시지","성공메시지",this);
								GauceDataRow row = msgDS.newDataRow();									
								row.addColumnValue(cstmt.getString(11));
								msgDS.addDataRow(row);
							}
						} else {
							StringUtil.printMsg("실패메시지","실패메시지",this);								
							conn.rollback();
							GauceDataRow row = msgDS.newDataRow();								
							row.addColumnValue(cstmt.getString(11));
							msgDS.addDataRow(row);
							fail = true;							
							break inner;						
						}
						
						if(cstmt!=null) cstmt.close();
						break;						
						
					case GauceDataRow.TB_JOB_DELETE:
						StringUtil.printMsg("call","SALES.PR_RV740I_04-DELETE",this);						
						cstmt = conn.prepareCall("{call SALES.PR_RV740I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
					
						cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
						cstmt.setInt(2, rows[i].getInt(colNm_MRsvSid));
						cstmt.setInt(3, rows[i].getInt(colNm_RoomTypeSid));
						cstmt.setInt(4, rows[i].getInt(colNm_RoomSid));
						cstmt.setString(5, rows[i].getString(colNm_JoinCd));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, iParamIp);
						cstmt.setString(8, "2");
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();

						//메시지처리
						if (cstmt.getString(9).equals("Y") ) {
							if ( !cstmt.getString(10).equals("0000") ) {
								StringUtil.printMsg("성공메시지","성공메시지",this);
								GauceDataRow row = msgDS.newDataRow();									
								row.addColumnValue(cstmt.getString(11));
								msgDS.addDataRow(row);
							}
						} else {
							StringUtil.printMsg("실패메시지","실패메시지",this);								
							conn.rollback();
							GauceDataRow row = msgDS.newDataRow();								
							row.addColumnValue(cstmt.getString(11));
							msgDS.addDataRow(row);
							fail = true;							
							break inner;						
						}
						
						if(cstmt!=null) cstmt.close();
						break;						
					}
				}
			}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			msgDS.flush();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}
}
