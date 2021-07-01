package common;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import common.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cm040I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//레벨1 목록
		arr_sql[0].append ("SELECT MENU_IDX, SCDNM         \n")     
				  .append ("  FROM COMMON.MENU_MASTER   \n")     
				  .append (" WHERE LV  = 1           \n")     
				  .append ("   AND FLAG = 'T'           \n")
				  .append (" ORDER BY SEQ ASC           \n");    
		//레벨2 목록		
		arr_sql[1].append ("SELECT MENU_IDX, SCDNM         \n")     
				  .append ("  FROM COMMON.MENU_MASTER   \n")     
				  .append (" WHERE LV  = 2           \n")     
				  .append ("   AND PARENT_IDX = ?           \n")
				  .append ("   AND FLAG = 'T'           \n")     
				  .append (" ORDER BY SEQ ASC	        \n");    
		//레벨3 목록		
		arr_sql[2].append ("SELECT MENU_IDX, SCDNM         \n")                                             
				  .append ("  FROM COMMON.MENU_MASTER   \n")     
				  .append (" WHERE LV  = 3           \n")     
				  .append ("   AND PARENT_IDX = ?           \n")
				  .append ("   AND FLAG = 'T'           \n")     
				  .append (" ORDER BY SEQ ASC	        \n");                       

		//레벨4 조회
		arr_sql[3].append ("SELECT PGM_IDX, PARENT_IDX, PGMNM, SYSID, UPMENUID, RPGMID, FLAG, SEQ, OLDPGMID, PAGETYPE, STRDATE, ENDDATE  \n")
				  .append ("  FROM COMMON.MENU_DETAIL                       \n")
				  .append (" WHERE PARENT_IDX = ? 	                         \n")
				  .append (" ORDER BY SEQ ASC    	                         \n");
		
		//레벨4 수정
		arr_sql[4].append ("UPDATE COMMON.MENU_DETAIL                        \n")
				  .append ("   SET  PGMNM  = ?                               \n")
				  .append ("   		,RPGMID = ?                              \n")
				  .append ("   		,FLAG = ?                                \n")
				  .append ("        ,SEQ = ?                                 \n")				  
				  .append (" WHERE PGM_IDX = ? 	                             \n");

		//레벨4 삭제 
		arr_sql[5].append ("DELETE FROM COMMON.MENU_DETAIL                  \n")
				  .append (" WHERE PGM_IDX = ? 	                             \n");
		
		//레벨4 추가
		arr_sql[6].append ("INSERT INTO COMMON.MENU_DETAIL (PGM_IDX, PARENT_IDX, PGMNM, RPGMID, FLAG, SEQ , PAGETYPE, \n")
				  .append (" STRDATE, ENDDATE, REGMAN, MODMAN)           \n")
				  .append (" VALUES (COMMON.SWS_MENU_DETAIL_ID.NEXTVAL, ?,?,?,?,?,  ?,?,?,?,?  )                         \n");

		//레벨4 추가
		arr_sql[7].append (" SELECT T2.DPT_CD, \n")
				  .append ("	    ASNHR.SF_GET_DPTNAME('01','A4',T2.DPT_CD) AS DPT_NM, \n")
				  .append ("	    ASNHR.SF_GET_COMMNAME('01','A2',T2.JOB_CD) AS JOB_NM, \n")
				  .append ("   		T2.RET_YMD, CASE WHEN  T2.RET_YMD IS NULL THEN 'Y' ELSE 'N' END AS USE_YN,")
				  .append ("	    T2.ENO_NM||'('||T2.ENO_NO||')' AS ENO_NM, T1.BTN_AUTH \n")
				  .append ("   FROM COMMON.MENU_AUTH T1 JOIN ASNHR.T_CM_PERSON T2 ON (T1.USERID = T2.ENO_NO) \n")
				  .append (" WHERE T1.PGM_IDX = ? \n ")
				  .append (" ORDER BY DPT_NM, T2.JOB_CD \n ");
				  
   }


    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;

		/* DataSet */
		GauceStatement stmt = null;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int menu_idx = HDUtil.nullCheckNum(greq.getParameter("menu_idx"));
				
	
		
		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O: DS2=ds_lc1,   DS3=ds_lc2,    DS4=ds_lc3
            	if(dSets[i].getName().equals("ds_lc1")){
					GauceDataSet ds1 = gis.read("DS2");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}			
            	if(dSets[i].getName().equals("ds_lc2")){
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, menu_idx);
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));					
				}			
            	if(dSets[i].getName().equals("ds_lc3")){
					GauceDataSet ds1 = gis.read("DS4");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, menu_idx);
					rs = cstmt.executeQuery();
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
	
	// 조회 method
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		//StringUtil.printMsg("# Command","조회",this);		


        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		try {
         	//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			// 검색시 조건
			int menu_idx 	= HDUtil.nullCheckNum(greq.getParameter("menu_idx"));
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O: DEFAULT=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, menu_idx);
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS_GR2");
					cstmt = conn.prepareCall(arr_sql[7].toString());
					cstmt.setInt(1, menu_idx);
					rs = cstmt.executeQuery();
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


	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet inputDs = gis.read("DS1");	//		I:DS1=ds1
		
		
		int menu_idx = HDUtil.nullCheckNum(greq.getParameter("menu_idx"));
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;

		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				int colNm_PARENT_IDX		= inputDs.indexOfColumn("PARENT_IDX");
				int colNm_PGMNM				= inputDs.indexOfColumn("PGMNM");
				int colNm_RPGMID			= inputDs.indexOfColumn("RPGMID");
				int colNm_FLAG				= inputDs.indexOfColumn("FLAG");
				int colNm_SEQ				= inputDs.indexOfColumn("SEQ");
				int colNm_PAGETYPE			= inputDs.indexOfColumn("PAGETYPE");
				int colNm_STRDATE			= inputDs.indexOfColumn("STRDATE");
				int colNm_ENDDATE			= inputDs.indexOfColumn("ENDDATE");
				int colNm_PGM_IDX			= inputDs.indexOfColumn("PGM_IDX");
				
				for(int i=0; i<rows.length; i++){
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						
						//StringUtil.printMsg("arr_sql[6]",arr_sql[5].toString(),this);		
						cstmt = conn.prepareCall(arr_sql[6].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_PARENT_IDX));
						cstmt.setString(2, rows[i].getString(colNm_PGMNM));
						cstmt.setString(3, rows[i].getString(colNm_RPGMID));
						cstmt.setString(4, rows[i].getString(colNm_FLAG));
						cstmt.setInt(5, rows[i].getInt(colNm_SEQ));
						cstmt.setString(6, rows[i].getString(colNm_PAGETYPE));
						cstmt.setString(7, rows[i].getString(colNm_STRDATE));
						cstmt.setString(8, rows[i].getString(colNm_ENDDATE));
						cstmt.setString(9, iParamEmpno);
						cstmt.setString(10, iParamEmpno);						
						
						cstmt.execute();
						if(cstmt!=null) cstmt.close();
						break;
						//객실정보 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setString(1, rows[i].getString(colNm_PGMNM));
						cstmt.setString(2, rows[i].getString(colNm_RPGMID));
						cstmt.setString(3, rows[i].getString(colNm_FLAG));
						cstmt.setInt(4, rows[i].getInt(colNm_SEQ));
						cstmt.setString(5, rows[i].getString(colNm_PGM_IDX));
						/*if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							cstmt.setString(j++, "Y");
						} else {
							cstmt.setString(j++, "N");							
						}						*/
						
						cstmt.execute();
						if(cstmt!=null) cstmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:

						//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);						
						cstmt = conn.prepareCall(arr_sql[5].toString());
						cstmt.setInt(1, rows[i].getInt(colNm_PGM_IDX));
						cstmt.execute();
						if(cstmt!=null) cstmt.close();
						break;						
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

}
