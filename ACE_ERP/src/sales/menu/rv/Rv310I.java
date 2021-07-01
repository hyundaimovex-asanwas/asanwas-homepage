package sales.menu.rv;

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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv310I extends SuperServlet {

	private static final long serialVersionUID = 1L;

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
		arr_sql[0].append("{call SALES.PR_RV310I_01( ?,?,?,?,?,   ?,?,?,?,?,  ? ) }");

		//상품권 결재 정보 내역을 입금정보(TRV200)에 입력한다.
		arr_sql[2].append ("INSERT INTO SALES.TRV200 														\n")
				  .append ("(PAY_SID, RSV_SID, ACCEPT_DATE, PLAN_PAY_DATE, PAY_DATE,	PAY_AMT, CLIENT_SID,			\n") 
				  .append (" PAY_YN, PAY_CD, PAY_MANAGE_NO, OPTION_YN, UPJANG_SID, U_EMPNO, U_DATE, U_IP)	\n")
				  .append ("VALUES (sales.sws_trv200_id.nextVal, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSTIMESTAMP, ?)				\n");

		//기간조회
		arr_sql[3].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_site_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));				// 현장
		int v_orderer_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_orderer_sid"));			// 발주처
		
		//StringUtil.printMsg("v_site_sid",v_site_sid,this);
		//StringUtil.printMsg("v_orderer_sid",v_orderer_sid,this);
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		
		int    v_cnt 			= 1;
		int    v_client_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));	//대리점 SID
		int    v_goods_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));		//상품 SID
		String v_depart_date1 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date1"));	//출경일자1
		String v_depart_date2 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date2"));	//출경일자2
		String v_accept_no   	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));		//신청서번호
		String v_cust_nm	   	= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm"));		//성명
		String v_pay_gubn	 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_gubn"));		//Option, 관광요금
		String v_cancel_yn		= HDUtil.nullCheckStr(greq.getParameter("v_cancel_yn"));		//취소자여부
		int    v_saup_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));		//사업 SID
		int v_bound_seq 		= HDUtil.nullCheckNum(greq.getParameter("v_bound_seq"));			// 상품순번.
		int v_pay_seq	 		= HDUtil.nullCheckNum(greq.getParameter("v_pay_seq"));			// 결제순번.
		StringUtil.printMsg("v_client_sid",v_client_sid,this);
		StringUtil.printMsg("v_goods_sid",v_goods_sid,this);
		StringUtil.printMsg("v_depart_date1",v_depart_date1+"",this);
		StringUtil.printMsg("v_accept_no",v_accept_no,this);
		StringUtil.printMsg("v_cust_nm",v_cust_nm,this);
		StringUtil.printMsg("v_pay_gubn",v_pay_gubn,this);
		StringUtil.printMsg("v_cancel_yn",v_cancel_yn,this);
		StringUtil.printMsg("v_saup_sid",v_saup_sid,this);
		StringUtil.printMsg("v_bound_seq",v_bound_seq,this);
		StringUtil.printMsg("v_pay_seq",v_pay_seq,this);
		
		try{
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O: DEFAULT=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DEFAULT");

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
					cstmt.registerOutParameter(11, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(11);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
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
		StringUtil.printMsg("# Command","저장",this);
		
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet //I:DEFAULT=ds1 */
		GauceDataSet ds1 = gis.read("DEFAULT");	//20140121


		try{		
			String v_pay_manage_no 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));	//결제관리번호
			String v_client_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_client_cd"));		//대리점코드
			String v_accept_date 	= HDUtil.nullCheckStr(greq.getParameter("v_accept_date"));	//신청일자
			String v_pay_date 		= HDUtil.nullCheckStr(greq.getParameter("v_pay_date"));		//입금일자
			String v_plan_pay_date 	= HDUtil.nullCheckStr(greq.getParameter("v_plan_pay_date"));	//입금예정일자(==무통입금일자)
			String v_pay_cd		 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_cd"));		//입금구분
			//StringUtil.printMsg("동현:무통입금일자", v_plan_pay_date, this);

			if(v_accept_date.equals(""))
				v_accept_date = v_pay_date;	//
			
			if(v_plan_pay_date.equals(""))
				v_plan_pay_date = v_pay_date;
			
			if(v_pay_cd.equals("080"))	//무통입금코드면
				v_pay_date = v_plan_pay_date;

			if(ds1!=null){
				GauceDataRow[]    row  = ds1.getDataRows();
				
				//입금액 인서트 Roop.
				for(int i=0; i<row.length; i++){
					
					StringUtil.printMsg(" row[i].getString(1)",  row[i].getString(1), this);
					StringUtil.printMsg(" row[i].getInt(2)",  row[i].getString(2), this);
					StringUtil.printMsg(" row[i].getInt(3)",  row[i].getString(3), this);
					StringUtil.printMsg(" row[i].getInt(4)",  row[i].getString(4), this);
					StringUtil.printMsg(" row[i].getInt(5)",  row[i].getString(5), this);
					StringUtil.printMsg(" row[i].getInt(6)",  row[i].getString(6), this);
					StringUtil.printMsg(" row[i].getInt(7)",  row[i].getString(7), this);
					StringUtil.printMsg(" row[i].getInt(8)",  row[i].getString(8), this);
					StringUtil.printMsg(" row[i].getInt(9)",  row[i].getString(9), this);
					StringUtil.printMsg(" row[i].getInt(10)",  row[i].getString(10), this);
					StringUtil.printMsg(" row[i].getInt(11)",  row[i].getString(11), this);
					StringUtil.printMsg(" row[i].getInt(12)",  row[i].getString(12), this);
					StringUtil.printMsg(" row[i].getInt(13)",  row[i].getString(13), this);
					StringUtil.printMsg(" row[i].getInt(14)",  row[i].getString(14), this);
					StringUtil.printMsg(" row[i].getInt(15)",  row[i].getString(15), this);
					StringUtil.printMsg(" row[i].getInt(16)",  row[i].getString(16), this);
					StringUtil.printMsg(" row[i].getInt(17)",  row[i].getString(17), this);
					StringUtil.printMsg(" row[i].getInt(18)",  row[i].getString(18), this);
					StringUtil.printMsg(" row[i].getInt(19)",  row[i].getString(19), this);
					StringUtil.printMsg(" row[i].getInt(20)",  row[i].getString(20), this);
					StringUtil.printMsg(" row[i].getInt(21)",  row[i].getString(21), this);
					StringUtil.printMsg(" row[i].getInt(22)",  row[i].getString(22), this);
					StringUtil.printMsg(" row[i].getInt(23)",  row[i].getString(23), this);
					
						
						
					//그리드의 선택 컬럼이 지정되어 있지 않으면 인서트하지 않도록 조건 추가[2008-01-17]
					if( (row[i].getString(ds1.indexOfColumn("JOB_SEL")).equals("T")) || (row[i].getString(ds1.indexOfColumn("JOB_SEL2")).equals("T"))		){
						cstmt = conn.prepareCall(arr_sql[2].toString());
						StringUtil.printMsg(" sql", arr_sql[2].toString(), this);
						cstmt.setInt   (1, row[i].getInt(19));
						cstmt.setString(2, v_accept_date);
						cstmt.setString(3, v_plan_pay_date);
						cstmt.setString(4, v_pay_date);
						cstmt.setInt   (5, row[i].getInt(17));
						cstmt.setString(6, row[i].getString(ds1.indexOfColumn("CLIENT_SID")));
						if(v_pay_cd.equals("020")){
							cstmt.setString(7, "N");
						} else
							cstmt.setString(7, "Y");
						cstmt.setString(8, v_pay_cd);
						cstmt.setString(9, v_pay_manage_no);
						cstmt.setString(10, row[i].getString(20));
						cstmt.setInt	  (11, row[i].getInt(21));
						cstmt.setString(12, fParamEmpno);
						cstmt.setString(13, fParamIp);
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
					}
				}//for(int i=0; i<row.length; i++){
			}
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {

			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
