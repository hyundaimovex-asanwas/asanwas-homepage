package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
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

import sales.common.*;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv310I_01 extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
		/*
		 * 관광 결재 요금 내역 조회
		 *    IN  pCLIENT_SID          NUMERIC(10)   -- 매출처 SID.
		 *   ,IN  pPAY_GUBN            VARCHAR(1)    -- 요금구분. 관광=N, 옵션=Y
		 *   ,IN  pCANCEL_YN           VARCHAR(2)    -- 취소자 포함 여부. 포함='RC'
		 *   ,IN  pSAUP_SID  			 NUMERIC(2)    -- 사업소 SID.
		 *   ,IN  pGOODS_SID  		 NUMERIC(2)    -- 상품 SID.
		 *   ,IN  pDEPART_DATE 		 VARCHAR(8)    -- 출발일자
		 *   ,IN  pACCEPT_NO           VARCHAR(14)   -- 주민/여권번호
		 *   ,IN  pCUST_NM             VARCHAR(30)   -- 한글성명
		 */
		arr_sql[0].append("{call SALES.PR_RV310I_01_01( ?, ?, ?, ?, ?,   ?, ?, ?,?,? ) }");

		//상품권 결재 정보 내역을 입금정보(TRV200)에 입력한다.
		arr_sql[2].append ("INSERT INTO SALES.TRV200 														\n")
				  .append ("(RSV_SID, ACCEPT_DATE, PLAN_PAY_DATE, PAY_DATE,	PAY_AMT, CLIENT_SID,			\n") 
				  .append (" PAY_YN, PAY_CD, PAY_MANAGE_NO, OPTION_YN, UPJANG_SID, U_EMPNO, U_DATE, U_IP)	\n")
				  .append ("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP, ?)				\n");

		//기간조회
		arr_sql[3].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		GauceStatement stmt = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		
		int    v_cnt 			= 1;
		int    v_client_sid 	= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	//대리점 SID
		int    v_goods_sid 		= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));		//상품 SID
		String v_depart_date1 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date1"));	//출경일자1
		String v_depart_date2 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date2"));	//출경일자2
		String v_accept_no   	= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));		//신청서번호
		String v_cust_nm	   	= HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));		//성명
		String v_pay_gubn	 	= HDUtil.nullCheckStr(req.getParameter("v_pay_gubn"));		//Option, 관광요금
		String v_cancel_yn		= HDUtil.nullCheckStr(req.getParameter("v_cancel_yn"));		//취소자여부
		int    v_saup_sid 		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));		//사업 SID
		int v_bound_seq 	= HDUtil.nullCheckNum(req.getParameter("v_bound_seq"));			// 상품순번.
		int v_pay_seq	 	= HDUtil.nullCheckNum(req.getParameter("v_pay_seq"));			// 결제순번.
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				GauceDataSet ds_grid = req.getGauceDataSet(gauceName);
				if(ds_grid!=null){
					res.enableFirstRow(ds_grid);
					
					if(gauceName.equals("DEFAULT")){
						/* 날짜 기간 검색하는 부분.. 여기선 안쓰지만 남겨둔다. 2008-05-10
						String temp_sql = arr_sql[3].toString();
						temp_sql = StringUtil.strReplace(temp_sql, "$1", v_depart_date1);
						temp_sql = StringUtil.strReplace(temp_sql, "$2", v_depart_date2);
						
						stmt = conn.getGauceStatement(temp_sql);
						rs = stmt.executeQuery();
						if(rs.next()){
							if(rs.getInt("DAY_CNT")>3){
								res.writeException("ERROR", "0000", "기간을 3일이내로 하시길 바랍니다.");
								break;
							}
						} else {
							res.writeException("ERROR", "0000", "기간내의 일자를 계산하는중 오류가 발생했습니다.");
							break;
						}
						
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();*/
						
						//조회쿼리
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt   (1, v_client_sid);   	//pCLIENT_SID  매출처 SID.                
						cstmt.setString(2, v_pay_gubn);		  	//pPAY_GUBN    요금구분. 관광=N, 옵션=Y   
						cstmt.setString(3, v_cancel_yn);	  	//pCANCEL_YN   취소자 포함 여부. 포함='RC'
						cstmt.setInt   (4, v_saup_sid);		  	//pSAUP_SID  	 사업소 SID.                
						cstmt.setInt   (5, v_goods_sid);	  	//pGOODS_SID   상품 SID.                  
						cstmt.setString(6, v_depart_date1); 	//pDEPART_DATE 출발일자                   
						cstmt.setString(7, v_accept_no);		//pACCEPT_NO   주민/여권번호              
						cstmt.setString(8, v_cust_nm);		 	//pCUST_NM     한글성명                   			
						cstmt.setInt(9, v_bound_seq);
						cstmt.setInt(10, v_pay_seq);

						rs = cstmt.executeQuery();
						getDataSet(rs, ds_grid).flush();
					}//if(gauceName.equals("DEFAULT")){
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
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		String v_pay_manage_no 	= HDUtil.nullCheckStr(req.getParameter("v_pay_manage_no"));	//결재관리번호
		String v_client_cd 		= HDUtil.nullCheckStr(req.getParameter("v_client_cd"));		//대리점코드
		String v_accept_date 	= HDUtil.nullCheckStr(req.getParameter("v_accept_date"));	//신청일자
		String v_pay_date 		= HDUtil.nullCheckStr(req.getParameter("v_pay_date"));		//입금일자
		String v_plan_pay_date 	= HDUtil.nullCheckStr(req.getParameter("v_plan_pay_date"));	//입금예정일자(==무통입금일자)
		String v_pay_cd		 	= HDUtil.nullCheckStr(req.getParameter("v_pay_cd"));		//입금구분
		

		//StringUtil.printMsg("동현:무통입금일자", v_plan_pay_date, this);
		
		
		if(v_accept_date.equals(""))
			v_accept_date = v_pay_date;
		
		if(v_plan_pay_date.equals(""))
			v_plan_pay_date = v_pay_date;
		
		if(v_pay_cd.equals("080"))	//무통입금코드면
			v_pay_date = v_plan_pay_date;
		

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					GauceDataRow[]    row  = ds1.getDataRows();
					
					//입금액 인서트 Roop.
					for(int i=0; i<row.length; i++){
						
						//그리드의 선택 컬럼이 지정되어 있지 않으면 인서트하지 않도록 조건 추가[2008-01-17]
						if(row[i].getString(ds1.indexOfColumn("JOB_SEL")).equals("T")	){
							stmt = conn.getGauceStatement(arr_sql[2].toString());
							stmt.setInt   (1, row[i].getInt(18));
							stmt.setString(2, v_accept_date);
							stmt.setString(3, v_plan_pay_date);
							stmt.setString(4, v_pay_date);
							stmt.setInt   (5, row[i].getInt(16));
							stmt.setString(6, row[i].getString(ds1.indexOfColumn("CLIENT_SID")));
							if(v_pay_cd.equals("020")){
								stmt.setString(7, "N");
							} else
								stmt.setString(7, "Y");
							stmt.setString(8, v_pay_cd);
							stmt.setString(9, v_pay_manage_no);
							stmt.setString(10, row[i].getString(19));
							stmt.setInt	  (11, row[i].getInt(20));
							stmt.setString(12, fParamEmpno);
							stmt.setString(13, fParamIp);
							stmt.executeUpdate();
							if(stmt!=null) stmt.close();
						}
						
						if(row[i].getString(ds1.indexOfColumn("JOB_SEL2")).equals("T")	){
								stmt = conn.getGauceStatement(arr_sql[2].toString());
								stmt.setInt   (1, row[i].getInt(18));
								stmt.setString(2, v_accept_date);
								stmt.setString(3, v_plan_pay_date);
								stmt.setString(4, v_pay_date);
								stmt.setInt   (5, row[i].getInt(16));
								stmt.setString(6, row[i].getString(ds1.indexOfColumn("CLIENT_SID")));
								if(v_pay_cd.equals("020")){
									stmt.setString(7, "N");
								} else
									stmt.setString(7, "Y");
								stmt.setString(8, v_pay_cd);
								stmt.setString(9, v_pay_manage_no);
								stmt.setString(10, row[i].getString(19));
								stmt.setInt	  (11, row[i].getInt(20));
								stmt.setString(12, fParamEmpno);
								stmt.setString(13, fParamIp);
								stmt.executeUpdate();
								if(stmt!=null) stmt.close();
						}
					}//for(int i=0; i<row.length; i++){
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
	}}
