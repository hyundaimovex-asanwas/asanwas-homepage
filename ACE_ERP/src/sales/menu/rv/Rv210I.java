package sales.menu.rv;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv210I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		arr_sql[1].append("CALL SALES.PR_Rv210I_01(?,?,?,?,?,  ?)");					//조회하기
		arr_sql[2].append("CALL SALES.PR_Rv210I_02(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?)");	//수정된 상세내역 값 저장하기
		arr_sql[3].append("CALL SALES.PR_RV200I_06(?,?,?,?,?,?,?,?,?,?)");		//판매가 계산 저장하기		

	}
 		                                                                
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}
	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int sSaupSid = HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
		int sGoodsSid = HDUtil.nullCheckNum(req.getParameter("sGoodsSid"));
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid"));
		String sDepartDate = HDUtil.nullCheckStr(req.getParameter("sDepartDate"));
		String sAcceptNo = HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
		String sStatusCd = HDUtil.nullCheckStr(req.getParameter("sStatusCd"));
		
		StringUtil.printMsg("신청서번호===",sAcceptNo,this);
				
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					/*
					   IN     pSAUP_SID        NUMERIC(10)      -- 1 사업소SID
					  ,IN     pGOODS_SID       NUMERIC(10)      -- 2 상품SID
					  ,IN     pCLIENT_SID      NUMERIC(10)      -- 3 매출처SID
					  ,IN     pDEPART_DATE     VARCHAR(08)      -- 4 출발일(시작)
					  ,IN     pACCEPT_NO	   VARCHAR(14)      -- 5 신청서번호
					  ,IN     pSTATUS_CD	   VARCHAR(02)      -- 6 예약상태
					 */
					StringUtil.printMsg("조회--",arr_sql[1].toString(),this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setInt   (1, sSaupSid);
					cstmt.setInt   (2, sGoodsSid);
					cstmt.setInt   (3, sClientSid);
					cstmt.setString(4, sDepartDate);
					cstmt.setString(5, sAcceptNo);
					cstmt.setString(6, sStatusCd);
					
					rs = cstmt.executeQuery();							
					getDataSet(rs, ds1).flush();

				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		try {
			
			GauceDataSet ds_result 		= req.getGauceDataSet("DS_RESULT");	//판매가 계산 결과			

			//내부 변수
			String r_s_yn		= "";
			String r_msg_cd		= "";
			String r_msg		= "";
			
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						

						int colNm_RSV_SID    	=	ds1.indexOfColumn("RSV_SID");		//예약SID
						int colNm_AGE_CD		=	ds1.indexOfColumn("AGE_CD");		//연령코드
						int colNm_CAROWNER_YN	=	ds1.indexOfColumn("CAROWNER_YN");	//자차여부      
						int colNm_CUST_TYPE  	=	ds1.indexOfColumn("CUST_TYPE");		//할인유형      
						int colNm_JEJU_YN	 	=	ds1.indexOfColumn("JEJU_YN");		//제주여부      
						int colNm_WEEKEND_YN 	=	ds1.indexOfColumn("WEEKEND_YN");	//주말여부      
						int colNm_THEME_CD	 	=	ds1.indexOfColumn("THEME_CD");		//테마코드      
						int colNm_USE_DATE   	=	ds1.indexOfColumn("DEPART_DATE");		//사용일자      
						int colNm_U_EMPNO    	=	ds1.indexOfColumn("U_EMPNO");		//최종수정자사번
						int colNm_U_IP       	=	ds1.indexOfColumn("U_IP");			//최종수정IP    


						for(int i=0; i<rows.length; i++){
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_UPDATE:
								
								cstmt = conn.prepareCall(arr_sql[2].toString());
								
								//StringUtil.printMsg("=============================== 업데이트 파라미터 =========================",this);
								//StringUtil.printMsg("예약SID    - ",rows[i].getString(colNm_RSV_SID)	, this);   
								//StringUtil.printMsg("자차여부       - ",rows[i].getString(colNm_CAROWNER_YN), this);   
								//StringUtil.printMsg("할인유형       - ",rows[i].getString(colNm_CUST_TYPE)  , this);   
								//StringUtil.printMsg("제주여부       - ",rows[i].getString(colNm_JEJU_YN)    , this);   
								//StringUtil.printMsg("주말여부       - ",rows[i].getString(colNm_WEEKEND_YN) , this);   
								//StringUtil.printMsg("테마코드       - ",rows[i].getString(colNm_THEME_CD)   , this);   
								//StringUtil.printMsg("사용일자       - ",rows[i].getString(colNm_USE_DATE)	, this);   

								
								
								cstmt.setInt(1, Integer.parseInt(rows[i].getString(colNm_RSV_SID)));
								cstmt.setString(2, rows[i].getString(colNm_AGE_CD));
							
								cstmt.setString(3, rows[i].getString(colNm_CAROWNER_YN));               
								cstmt.setString(4, rows[i].getString(colNm_CUST_TYPE));                 
								cstmt.setString(5, rows[i].getString(colNm_JEJU_YN));                   
								cstmt.setString(6, rows[i].getString(colNm_WEEKEND_YN));                
								cstmt.setString(7, rows[i].getString(colNm_THEME_CD));                     
								cstmt.setString(8, rows[i].getString(colNm_USE_DATE));                     
								cstmt.setString(9, iParamEmpno);
								cstmt.setString(10, iParamIp);
								cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
								// 쿼리실행
								cstmt.executeUpdate();

								r_s_yn 		= cstmt.getString(11);
								r_msg_cd 	= cstmt.getString(12);
								r_msg 		= cstmt.getString(13);
								
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
								
								break;
							}
						}
					}
					if ("DS2".equals(gauceName)) {
						System.out.println("DS2");

						if(ds_result!=null){
							res.enableFirstRow(ds_result);
							ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						}

						
						
						int    v_accept_sid  = HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	//신청서번호
						StringUtil.printMsg("v_accept_sid",v_accept_sid,this);

						cstmt = conn.prepareCall(arr_sql[3].toString());

						cstmt.setInt        (1,  v_accept_sid);
						cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
						cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);
						cstmt.setString		(4, "Rv210I");
						cstmt.setString     (5, fParamEmpno);
						cstmt.setString     (6, fParamIp);
						cstmt.setString     (7, "3");
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.executeUpdate();
						
						//System.out.println("업데이트 완료~~~~~");

						
						r_s_yn 		= cstmt.getString(8);
						r_msg_cd 	= cstmt.getString(9);
						r_msg 		= cstmt.getString(10);
						
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
