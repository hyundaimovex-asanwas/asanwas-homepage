package pms.menu.pu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;


import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;


public class Pu031I extends SuperServlet {

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
		//룩업용 : 메뉴명 불러오기
		arr_sql[0].append ("SELECT CODE_NO, CODE_NM ||'(' || ITEM_LEVEL ||')' AS CODE_NM	\n")     
				  .append ("  FROM PMS.TPU011   							\n")
		  		  .append (" ORDER BY ITEM_LEVEL, P_CODE 						\n");		
				      
		//마스터 추가		
		arr_sql[1].append ("INSERT INTO PMS.TPU011 (CODE_NO,P_CODE, CODE_NM,  ITEM_LEVEL)  \n")     
				  .append ("  				        VALUES (?, ?, ?, ?) \n") ;    

		//마스터 조회
		arr_sql[3].append ("SELECT M01.CODE_NO, M01.P_CODE, M01.CODE_NM, M01.ITEM_LEVEL \n")
				  .append ("  FROM PMS.TPU011 M01                      \n")
				  .append (" WHERE M01.ITEM_LEVEL = ? 	                         \n")
				  .append (" ORDER BY M01.P_CODE  ASC    	                         \n");

		//마스터 수정
		arr_sql[4].append ("UPDATE PMS.TPU011                        \n")
				  .append ("   SET  P_CODE = ?                                   \n")
				  .append ("       ,CODE_NM = ?                                \n")
				  .append (" WHERE CODE_NO = ? 	                         \n");				  

		//마스터 삭제 
		arr_sql[5].append ("DELETE FROM PMS.TPU010                  \n")
				  .append (" WHERE ITEM_SID = ? 	                             \n");
		
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
			//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
			//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds_menu")){
					GauceDataSet ds1 = gis.read("DS_MENU");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					//cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
					rs=cstmt.executeQuery();
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
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

		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// 검색시 조건
			int menu_level = HDUtil.nullCheckNum(greq.getParameter("menu_level"));
			//String 	upmenuid	= HDUtil.nullCheckStr(req.getParameter("upmenuid"));
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
						cstmt = conn.prepareCall(arr_sql[3].toString());
							if (menu_level != 0 ) 
								cstmt.setInt(1, menu_level);	
							rs=cstmt.executeQuery(); 
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
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		int menu_idx = HDUtil.nullCheckNum(greq.getParameter("menu_idx"));
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		try{
			if (ds1 != null) {
				//StringUtil.printMsg("ds1","ds1",this);
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				int colNm_CODE_NO	  		     = ds1.indexOfColumn("CODE_NO");
				int colNm_P_CODE                 = ds1.indexOfColumn("P_CODE");
				int colNm_CODE_NM  		         = ds1.indexOfColumn("CODE_NM");
				int colNm_ITEM_LEVEL             = ds1.indexOfColumn("ITEM_LEVEL");
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					// 마스터 추가
					case GauceDataRow.TB_JOB_INSERT:
						/*
						StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);		
						StringUtil.printMsg("colNm_CODE_NO",""+rows[i].getString(colNm_CODE_NO),this);
						StringUtil.printMsg("colNm_P_CODE",rows[i].getString(colNm_P_CODE),this);
						StringUtil.printMsg("colNm_CODE_NM",""+rows[i].getString(colNm_CODE_NM),this);
						StringUtil.printMsg("colNm_ITEM_LEVEL",rows[i].getString(colNm_ITEM_LEVEL),this);
						*/
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, rows[i].getString(colNm_CODE_NO));
						cstmt.setString(2, rows[i].getString(colNm_P_CODE));
						cstmt.setString(3, rows[i].getString(colNm_CODE_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_LEVEL));					
						
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;

					// 마스터 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("arr_sql[4]",arr_sql[4].toString(),this);						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						
						int colNm_CODE_NO2                   = ds1.indexOfColumn("CODE_NO");
						int colNm_ITEM_LEVEL2                   = ds1.indexOfColumn("ITEM_LEVEL");
						int colNm_P_CODE2                   = ds1.indexOfColumn("P_CODE");
						int colNm_CODE_NM2                   = ds1.indexOfColumn("CODE_NM");
						
						//StringUtil.printMsg("colNm_idx",""+rows[i].getInt(colNm_idx),this);
						//StringUtil.printMsg("colNm_lvl",rows[i].getString(colNm_lvl),this);
						//StringUtil.printMsg("colNm_pid",""+rows[i].getInt(colNm_pid),this);
						//StringUtil.printMsg("colNm_snm",rows[i].getString(colNm_snm),this);
						//StringUtil.printMsg("colNm_seq",rows[i].getString(colNm_seq),this);
						//StringUtil.printMsg("colNm_dir",rows[i].getString(colNm_dir),this);
						cstmt.setString(1, rows[i].getString(colNm_CODE_NO2));
						//cstmt.setString(2, rows[i].getString(colNm_LEVEL2));
						cstmt.setString(3, rows[i].getString(colNm_P_CODE2));
						cstmt.setString(4, rows[i].getString(colNm_CODE_NM2));
						
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
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}
