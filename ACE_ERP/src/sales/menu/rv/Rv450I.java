package sales.menu.rv;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.CallableStatement;
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

public class Rv450I extends SuperServlet {

	

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		/*
		 * 메인조회
		 * //01.신청서번호,02.고객구분,03.인중구분,04.고객명,05.대리점 SID,06.국적구분,07.사업구분,08.주민여권
		 */
		arr_sql[0].append("{call SALES.PR_RV450I_01( ?, ?, ?, ?, ?,   ? ) }");
		
		//실명확인 연계 호출
		arr_sql[1].append("{call SALES.PR_EAI_R_T_009( ?, ?, ?, ?, ?,   ? ) }");
			 
	}
    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}	


	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		GauceDataSet ds1 = null; // 대리점 정보 
		
		CallableStatement cstmt = null;		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		/*
		 * 검색시 필요한 조건
		 */
		String sGroup_cd	= HDUtil.nullCheckStr(req.getParameter("sGroup_cd"));	//01.신청서번호
		String sCust_gu		= HDUtil.nullCheckStr(req.getParameter("sCust_gu"));	//02.고객구분  
		String sRegi_yn_t	= HDUtil.nullCheckStr(req.getParameter("sRegi_yn_t"));	//03.인중구분  
		String sCust_nm		= HDUtil.nullCheckStr(req.getParameter("sCust_nm"));	//04.고객명    
		int	   sClient_sid	= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	//05.대리점 SID
		String sManage_no	= HDUtil.nullCheckStr(req.getParameter("sManage_no"));	//06.주민여권  


		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);

				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						//조회쿼리
						cstmt = conn.prepareCall(arr_sql[0].toString());
						 
						cstmt.setString(1, sGroup_cd);		//IN
						cstmt.setString(2, sCust_gu);		//IN
						cstmt.setString(3, sRegi_yn_t);		//IN
						cstmt.setString(4, sCust_nm);		//IN
						cstmt.setInt   (5, sClient_sid);	//IN
						cstmt.setString(6, sManage_no);		//IN
					
					
						rs = cstmt.executeQuery();
					
					
					}
					getDataSet(rs, ds1).flush();
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
	

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		//StringUtil.printMsg("어플라이는??)", "",this);
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
		String sGroup_cd	= HDUtil.nullCheckStr(req.getParameter("sGroup_cd"));	//01.신청서번호
		String sDir			= HDUtil.nullCheckStr(req.getParameter("sDir"));	//02.송수신구분  
		StringUtil.printMsg("sDir:::)", sDir,this);
		
		try {
			GauceDataSet ds_result 		= req.getGauceDataSet("DS_RESULT");	//송신 결과			

			//내부 변수
			String r_s_yn		= "";
			String r_msg_cd		= "";
			String r_msg		= "";
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					if ("DS2".equals(gauceName)) {

						if(ds_result!=null){
							res.enableFirstRow(ds_result);
							ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						}

						if("send".equals(sDir)){	//데이터 생성&전송하는 경우
							//StringUtil.printMsg("실명확인 송~:)", "슝",this);
							cstmt = conn.prepareCall(arr_sql[1].toString());

							cstmt.setString     (1, sGroup_cd);
							cstmt.setString     (2, fParamEmpno);
							cstmt.setString     (3, fParamIp);
							cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
						
							r_s_yn 		= cstmt.getString(4);
							r_msg_cd 	= cstmt.getString(5);
							r_msg 		= cstmt.getString(6);
						
							if(!r_s_yn.equals("Y")){
								res.writeException("ERROR", r_msg_cd, r_msg);
							}
						
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
							
								ds_result.addDataRow(row1);
							}
						
							if(ds_result!=null) ds_result.flush();	
						}
						
						if("recv".equals(sDir)){	//데이터 로드하는 경우 
							StringUtil.printMsg("직원들만 로드)", "슝",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());

							cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
						
							r_s_yn 		= cstmt.getString(1);
							r_msg_cd 	= cstmt.getString(2);
							r_msg 		= cstmt.getString(3);
						
							if(!r_s_yn.equals("Y")){
								res.writeException("ERROR", r_msg_cd, r_msg);
							}
						
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
							
								ds_result.addDataRow(row1);
							}
						
							if(ds_result!=null) ds_result.flush();	
						}

					
						
								  
					}
				}
			}
		}catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}


}
