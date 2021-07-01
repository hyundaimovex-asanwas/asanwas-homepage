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

public class Rv241I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
	
		arr_sql[1].append("CALL SALES.PR_RV241I_01(?,?,?,?,?,   ?,?,?)");
		arr_sql[2].append("CALL SALES.PR_RV241I_02(?,?,?,?,?,	?,?,?,?,?,	?)");
		arr_sql[3].append("CALL SALES.PR_RV200I_06_BIZ(?,?,?,?,?,	?,?,?,?,?)");
	}
 		                                                                
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
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
		
		String sSDate = HDUtil.nullCheckStr(req.getParameter("sSDate"));
		String sAcceptNo = HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
		String sRoomType = HDUtil.nullCheckStr(req.getParameter("sRoomType"));
		String sPrice = HDUtil.nullCheckStr(req.getParameter("sPrice"));
		String sCustNm = HDUtil.nullCheckStr(req.getParameter("sCustNm"));
		String v_out_gubn = HDUtil.nullCheckStr(req.getParameter("v_out_gubn"));
		int sGoods_sid = HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid"));
		
		//StringUtil.printMsg(sSDate,this);
		//StringUtil.printMsg(sAcceptNo,this);
		//StringUtil.printMsg(sRoomType,this);
		//StringUtil.printMsg(sPrice,this);
		//StringUtil.printMsg(sCustNm,this);
		//StringUtil.printMsg(v_out_gubn,this);
		//StringUtil.printMsg(sGoods_sid,this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					/*
					 *  IN    pDEPART_DATE   VARCHAR(8),       -- 출발일자
			   IN    pGOODS_SID     VARCHAR(8),       -- 상품SID
			   IN    pACCEPT_NO     VARCHAR(14),      -- 신청서번호
			   IN    pROOM_TYPE_CD  VARCHAR(5),       -- 객실타입
			   IN    pUSE_AMT       VARCHAR(10),      -- 판매가
			   IN    pCUST_NM       VARCHAR(30),      -- 성명
			   IN    pINOUT_YN      VARCHAR(2)        -- 출경구분

					 */
					//StringUtil.printMsg("조회--",arr_sql[1].toString(),this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, sSDate);
					cstmt.setInt(2, sGoods_sid);
					cstmt.setString(3, sAcceptNo);
					cstmt.setString(4, sRoomType.toUpperCase());
					cstmt.setString(5, sPrice);
					cstmt.setString(6, sCustNm);
					cstmt.setString(7, v_out_gubn);
					cstmt.setInt(8,sClientSid);
					
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
						
						int colNm_RsvSid      	=	ds1.indexOfColumn("RSV_SID"); 	// 예약SID
						int colNm_CustType		=	ds1.indexOfColumn("CUST_TYPE");	// 할인코드  
						int colNm_CAROWNER_YN	=	ds1.indexOfColumn("STAY_YN");	//숙박 부과여부      
						int colNm_THEME_CD	 	=	ds1.indexOfColumn("MEAL_YN");	//식비부과여부
						int colNm_PayPre	 	=	ds1.indexOfColumn("PAY_PRE");	//정산시기      
						int colNm_PaySaup	 	=	ds1.indexOfColumn("PAY_SAUP");	//정산담당      

						
						for(int i=0; i<rows.length; i++){
						switch(rows[i].getJobType()){
							
							case GauceDataRow.TB_JOB_UPDATE:
								
								cstmt = conn.prepareCall(arr_sql[2].toString());
								
								//StringUtil.printMsg("=============================== 마스터 신규 =========================",this);
								//StringUtil.printMsg("1", rows[i].getInt(colNm_RsvSid),this);
								//StringUtil.printMsg("2", rows[i].getString(colNm_CustType),this);
								//StringUtil.printMsg("3", rows[i].getString(colNm_CAROWNER_YN),this);
								//StringUtil.printMsg("4", rows[i].getString(colNm_THEME_CD),this);
								//StringUtil.printMsg("5", rows[i].getString(colNm_PayPre),this);
								//StringUtil.printMsg("6", rows[i].getString(colNm_PaySaup),this);
								
								cstmt.setInt(1, Integer.parseInt(rows[i].getString(colNm_RsvSid)));
								cstmt.setString(2, rows[i].getString(colNm_CustType));
								cstmt.setString(3, rows[i].getString(colNm_CAROWNER_YN));
								cstmt.setString(4, rows[i].getString(colNm_THEME_CD));
								cstmt.setString(5, rows[i].getString(colNm_PayPre));
								cstmt.setString(6, rows[i].getString(colNm_PaySaup));
								cstmt.setString(7, iParamEmpno);
								cstmt.setString(8, iParamIp);
								cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
								// 쿼리실행
								cstmt.executeUpdate();
								
								//StringUtil.printMsg("실행 끝 ", "",this);
								break;
							}
						}
					}
					
					//판매가 계산
					if ("DS2".equals(gauceName)) {
						//System.out.println("DS2");
						if(ds_result!=null){
							res.enableFirstRow(ds_result);
							ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						}
						
						
						int    v_accept_sid  = HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	//신청서번호
						//System.out.println("v_accept_========>"+v_accept_sid);

								//StringUtil.printMsg("v_accept_sid",v_accept_sid,this);
									cstmt = conn.prepareCall(arr_sql[3].toString());

									cstmt.setInt        (1,  v_accept_sid);
									cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
									cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);
									cstmt.setString		(4, "RV241I");
									cstmt.setString     (5, fParamEmpno);
									cstmt.setString     (6, fParamIp);
									cstmt.setString     (7, "3");
									cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
									cstmt.executeUpdate();
									
									//System.out.println("요기~~~~~");
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
