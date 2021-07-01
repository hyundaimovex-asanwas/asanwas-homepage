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
import sales.common.SuperServlet;
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

public class Rv410S extends SuperServlet {

	
    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//	출경시간	
		arr_sql[0].append ("SELECT ''                 AS DEPART_TIME,				\n")
					.append ("		'전체'             AS DEPART_TIME_NM				\n")
					.append ("FROM SYSIBM.SYSDUMMY1				\n")
					.append ("UNION ALL				\n")
					.append ("SELECT DETAIL,				\n")
					.append ("		DETAIL_NM				\n")
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD  = 'RM014'				\n")
					.append ("	AND ITEM1 = 'Y'					\n");
		
		//사업소
		arr_sql[1].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
				
		//상품
		arr_sql[2].append ("SELECT 0                   AS GOODS_SID,					\n")     
					.append ("		'전체'              AS GOODS_NM       					\n")
					.append ("FROM SYSIBM.SYSDUMMY1					\n")
					.append ("UNION ALL					\n")
					.append ("SELECT GOODS_SID,					\n")
					.append ("		GOODS_NM					\n")
					.append ("FROM SALES.TRM200 R1					\n")
					.append ("WHERE SAUP_SID    =  ?					\n")
					.append ("	AND USE_YN      =  'Y'					\n");
		
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
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS2")){
								StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[0].toString());
							} 
							if(gauceName.equals("DS3")){
								StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[1].toString());
							} 							
							if(gauceName.equals("DS4")){
								StringUtil.printMsg("arr_sql[2]",arr_sql[2].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[2].toString());
								stmt.setString(1, sSaupSid);								
							} 														
								rs = stmt.executeQuery(); // DataSet set
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
						                v_rowcnt++ ;
									}//End of while
									if(rs!=null) rs.close();
									if(stmt!=null) stmt.close();
							ds1.flush();
							break;
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
		GauceStatement stmt = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime"));			
			String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));
			String 	sParam01	= HDUtil.nullCheckStr(req.getParameter("sParam01"));
			String 	sParam02	= HDUtil.nullCheckStr(req.getParameter("sParam02"));
			String 	sParam03= HDUtil.nullCheckStr(req.getParameter("sParam03"));
			String 	sParam04	= HDUtil.nullCheckStr(req.getParameter("sParam04"));
			String 	sParam05	= HDUtil.nullCheckStr(req.getParameter("sParam05"));
			String 	sParam06	= HDUtil.nullCheckStr(req.getParameter("sParam06"));
			String 	sParam07	= HDUtil.nullCheckStr(req.getParameter("sParam07"));
			String 	sParam08	= HDUtil.nullCheckStr(req.getParameter("sParam08"));
			String 	sParam09	= HDUtil.nullCheckStr(req.getParameter("sParam09"));
			String 	sParam10	= HDUtil.nullCheckStr(req.getParameter("sParam10"));
			String 	sParam11	= HDUtil.nullCheckStr(req.getParameter("sParam11"));
			String 	sParam12	= HDUtil.nullCheckStr(req.getParameter("sParam12"));
			String 	sParam13	= HDUtil.nullCheckStr(req.getParameter("sParam13"));
			String 	sParam14= HDUtil.nullCheckStr(req.getParameter("sParam14"));			

			StringUtil.printMsg("sBgnDate",sBgnDate,this);
			StringUtil.printMsg("sDepartTime",sDepartTime,this);
			StringUtil.printMsg("sSaupSid",sSaupSid,this);
			StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
			StringUtil.printMsg("sParam01",sParam01,this);
			StringUtil.printMsg("sParam02",sParam02,this);
			StringUtil.printMsg("sParam03",sParam03,this);
			StringUtil.printMsg("sParam04",sParam04,this);
			StringUtil.printMsg("sParam05",sParam05,this);
			StringUtil.printMsg("sParam06",sParam06,this);
			StringUtil.printMsg("sParam07",sParam07,this);
			StringUtil.printMsg("sParam08",sParam08,this);
			StringUtil.printMsg("sParam09",sParam09,this);
			StringUtil.printMsg("sParam10",sParam10,this);
			StringUtil.printMsg("sParam11",sParam11,this);
			StringUtil.printMsg("sParam12",sParam12,this);
			StringUtil.printMsg("sParam13",sParam13,this);
			StringUtil.printMsg("sParam14",sParam14,this);
			
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

							cstmt = conn.prepareCall("{call SALES.PR_RV410S_01('"+sBgnDate+"', '"+sDepartTime+"',"+sSaupSid+", "+sGoodsSid+", '"+sParam01+"', '"+sParam02+"', '"+sParam03+"', '"+sParam04+"', '"+sParam05+"', '"+sParam06+"', '"+sParam07+"', '"+sParam08+"', '"+sParam09+"', '"+sParam10+"', '"+sParam11+"', '"+sParam12+"', '"+sParam13+"', '"+sParam14+"' ) }");							
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
							if(stmt!=null) stmt.close();
		
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
			if(stmt!=null) stmt.close();
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
	}

}
