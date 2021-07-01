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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cm030I extends SuperServlet {

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
		
		
		//룩업용 : 메뉴명 불러오기(INIT)
		arr_sql[0].append ("SELECT MENU_IDX, SCDNM ||'(' || LV ||')' AS SCDNM	\n")     
				  .append ("  FROM COMMON.MENU_MASTER   						\n")				  
		  		  .append (" ORDER BY LV, PARENT_IDX, SEQ 						\n");		
				      
		
		
		//마스터 추가		
		arr_sql[1].append ("INSERT INTO COMMON.MENU_MASTER (MENU_IDX, PARENT_IDX, SCDNM, REGDATE, SEQ, LV, DIRPATH)  	\n")     
				  .append ("  				        VALUES (COMMON.SWS_MENU_MASTER_ID.NEXTVAL, ?, ?, ?, ?, ?, ?) 		\n") ;    

		
		//룩업용 : 메뉴명 불러오기(SELECT)
		arr_sql[2].append ("SELECT MENU_IDX, SCDNM ||'(' || LV ||')' AS SCDNM	\n")     
				  .append ("  FROM COMMON.MENU_MASTER   						\n")
				  .append (" WHERE LV = ? 	                         			\n")	
				  .append ("  AND MENU_IDX NOT IN ('113','115','209','29','28','13','199','52','373','212','151','152','153','154','53','54','55','30','31','32','33','34','35','21','22','23','24','25','26','27','36','37','38','39','40','51','50','158','155','208','203','253','206','273','213','374','333','375','376','377','378','379','380') 	                         												\n")

		  		  .append (" ORDER BY LV, PARENT_IDX, SEQ 						\n");			
		
		
		//마스터 조회
		arr_sql[3].append ("SELECT M01.MENU_IDX, M01.PARENT_IDX, M01.SCDNM, M01.SEQ, M01.LV, M01.DIRPATH, M01.FLAG, 	\n")
				  .append ("CASE M01.LV WHEN 1 THEN M01.SCDNM 															\n")
				  .append ("			   WHEN 2 THEN (SELECT S1.SCDNM FROM COMMON.MENU_MASTER S1 WHERE S1.MENU_IDX=M01.PARENT_IDX)||'>'||M01.SCDNM \n")
				  .append ("			   WHEN 3 THEN (SELECT S2.SCDNM FROM COMMON.MENU_MASTER S2 WHERE S2.MENU_IDX=(SELECT S1.PARENT_IDX FROM COMMON.MENU_MASTER S1 WHERE S1.MENU_IDX=M01.PARENT_IDX) ) \n")
				  .append ("					 ||'>'||(SELECT S1.SCDNM FROM COMMON.MENU_MASTER S1 WHERE S1.MENU_IDX=M01.PARENT_IDX)||'>'||M01.SCDNM \n")
				  .append ("			   END FULLPATH 																\n")
				  .append ("  FROM COMMON.MENU_MASTER M01                      											\n")
				  .append (" WHERE M01.LV = ? 	                         												\n")
				  
				  .append ("  AND M01.MENU_IDX NOT IN ('113','115','209','29','28','13','199','52','373','212','151','152','153','154','53','54','55','30','31','32','33','34','35','21','22','23','24','25','26','27','36','37','38','39','40','51','50','158','155','208','203','253','206','273','213','374','333','375','376','377','378','379','380') 	                         												\n")
				  
				  .append (" ORDER BY M01.PARENT_IDX, M01.SEQ ASC    	                         						\n");

		
		
		
		//마스터 수정
		arr_sql[4].append ("UPDATE COMMON.MENU_MASTER                        \n")
				  .append ("   SET  SEQ = ?                                  \n")
				  .append ("       ,PARENT_IDX = ?                           \n")
				  .append ("       ,SCDNM = ?                                \n")
				  .append ("       ,DIRPATH = ?                              \n")
				  .append ("       ,FLAG = ? 	                             \n")
				  .append (" WHERE MENU_IDX = ? 	                         \n");				  

		
		
		//마스터 삭제 
		arr_sql[5].append ("DELETE FROM COMMON.MENU_DETAIL                  \n")
				  .append (" WHERE PGM_IDX = ? 	                            \n");
		

		
		
   }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		//StringUtil.printMsg("# Command","선조회",this);
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
	
		try{
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O: DS_MENU=ds_menu
            	if(dSets[i].getName().equals("ds_menu")){
					GauceDataSet ds1 = gis.read("DS_MENU");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
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
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","조회",this);		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataBase */
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			// 검색시 조건
			int menu_level = HDUtil.nullCheckNum(greq.getParameter("menu_level"));
			//String 	upmenuid	= HDUtil.nullCheckStr(req.getParameter("upmenuid"));
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O: DEFAULT=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					//StringUtil.printMsg(" 쿼리쿼리===",arr_sql[3].toString(),this);
					cstmt.setInt(1, menu_level);
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	
            	
            	
            	if(dSets[i].getName().equals("ds_menu")){
            		
					GauceDataSet ds1 = gis.read("DS_MENU");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setInt(1, menu_level-1);					
					
					rs = cstmt.executeQuery();
					
					gos.write(getDataSet(rs, ds1));
					
				}
            	
            	
            	
            	
            	
            	
			}
			
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

		CallableStatement cstmt = null;	
		ResultSet 	rs 			= null;

		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();


		int menu_idx = HDUtil.nullCheckNum(greq.getParameter("menu_idx"));
		
		/* DataSet */
		GauceDataSet inputDs = gis.read("DS1");		
		try{
			if(inputDs!=null){

				int colNm_PARENT_IDX			= inputDs.indexOfColumn("PARENT_IDX");
				int colNm_SCDNM					= inputDs.indexOfColumn("SCDNM");
				int colNm_SEQ					= inputDs.indexOfColumn("SEQ");
				int colNm_LEVEL					= inputDs.indexOfColumn("LV");
				int colNm_DIRPATH				= inputDs.indexOfColumn("DIRPATH");
								
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					// 마스터 추가
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);		
						cstmt = conn.prepareCall(arr_sql[1].toString());
/*
						StringUtil.printMsg("colNm_PARENT_IDX",rows[i].getString(colNm_PARENT_IDX),this);
						StringUtil.printMsg("colNm_SCDNM",rows[i].getString(colNm_SCDNM),this);
						StringUtil.printMsg("colNm_SEQ",rows[i].getString(colNm_SEQ),this);
						StringUtil.printMsg("colNm_LEVEL",rows[i].getString(colNm_LEVEL),this);
						StringUtil.printMsg("colNm_DIRPATH",rows[i].getString(colNm_DIRPATH),this);
						PARENT_IDX, SCDNM, REGDATE, SEQ, LV, DIRPATH)
						*/						
						cstmt.setInt(1, rows[i].getInt(colNm_PARENT_IDX));
						cstmt.setString(2, rows[i].getString(colNm_SCDNM));
						cstmt.setString(3, "20110517" );
						cstmt.setInt(4, rows[i].getInt(colNm_SEQ));						
						cstmt.setInt(5, rows[i].getInt(colNm_LEVEL));
						cstmt.setString(6, rows[i].getString(colNm_DIRPATH));
						
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();		
						break;

					// 마스터 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						
						int colNm_idx                   = inputDs.indexOfColumn("MENU_IDX");
						int colNm_lvl                   = inputDs.indexOfColumn("LV");
						int colNm_pid                   = inputDs.indexOfColumn("PARENT_IDX");
						int colNm_snm                   = inputDs.indexOfColumn("SCDNM");
						int colNm_seq                   = inputDs.indexOfColumn("SEQ");
						int colNm_dir                   = inputDs.indexOfColumn("DIRPATH");
						int colNm_flag                   = inputDs.indexOfColumn("FLAG");

						//StringUtil.printMsg("colNm_idx",""+rows[i].getInt(colNm_idx),this);
						//StringUtil.printMsg("colNm_lvl",rows[i].getString(colNm_lvl),this);
						//StringUtil.printMsg("colNm_pid",""+rows[i].getInt(colNm_pid),this);
						//StringUtil.printMsg("colNm_snm",rows[i].getString(colNm_snm),this);
						//StringUtil.printMsg("colNm_seq",rows[i].getString(colNm_seq),this);
						//StringUtil.printMsg("colNm_dir",rows[i].getString(colNm_dir),this);
						
						cstmt.setInt(1, rows[i].getInt(colNm_seq));
						cstmt.setInt(2, rows[i].getInt(colNm_pid));
						cstmt.setString(3, rows[i].getString(colNm_snm));
						cstmt.setString(4, rows[i].getString(colNm_dir));
						cstmt.setString(5, rows[i].getString(colNm_flag));
						cstmt.setInt(6, rows[i].getInt(colNm_idx));
						
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:

						//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);						
						cstmt = conn.prepareCall(arr_sql[5].toString());
						//stmt.bindColumn(j++, colNm_PGM_IDX);
						//stmt.execute();
						if(cstmt!=null) cstmt.close();
						break;						
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

}
