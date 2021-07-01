package sales.menu.ml;

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

public class Ml200I extends SuperServlet {
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append("{call SALES.PR_ML200I_01(?,?,?,?,  ?)}");

		//결제결과 처리 : 결제화면에 있는 GRID의 데이터에 결제내역을 업뎃 + 추가 입력하는 것
		arr_sql[1].append("{call SALES.PR_ML200I_02(?,?,?,?,?,  ?,?,?,?,?)}"); //결제마스터(TPU010) 업데이트 1회
		arr_sql[2].append("{call SALES.PR_ML200I_03(?,?,?,?,? )}"); //주문-결제 관계(TML220) 인서트. 화면 행수*결제액만큼

	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
            
            
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

    		String v_fr_date 	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate")); 	// 주문일자 From
    		String v_to_date 	= HDUtil.nullCheckStr(greq.getParameter("sEndDate")); 	// 주문일자 To
    		String v_tr_gu		= HDUtil.nullCheckStr(greq.getParameter("sTrGu")); 		// 거래구분
    		String v_order_nm	= HDUtil.nullCheckStr(greq.getParameter("sTr_OrderNm")); 			// 주문자명
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O: DS_MAIN=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS_MAIN");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_date);
					cstmt.setString(2, v_to_date);
					cstmt.setString(3, v_tr_gu);
					cstmt.setString(4, v_order_nm);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}

			}
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

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt 	= null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 		= null;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		String v_pay_manage_no 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));	//결재관리번호
		String v_client_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_client_cd"));		//대리점코드
		String v_accept_date 	= HDUtil.nullCheckStr(greq.getParameter("v_accept_date"));	//신청일자
		String v_pay_date 		= HDUtil.nullCheckStr(greq.getParameter("v_pay_date"));		//입금일자
		String v_plan_pay_date 	= HDUtil.nullCheckStr(greq.getParameter("v_plan_pay_date"));	//입금예정일자(==무통입금일자)
		String v_pay_cd		 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_cd"));		//입금구분
		int 	pay_sid 		= 0 ;

		//StringUtil.printMsg("v_pay_manage_no=", v_pay_manage_no, this);
		//StringUtil.printMsg("v_client_cd=", v_client_cd, this);
		//StringUtil.printMsg("v_accept_date=", v_accept_date, this);
		//StringUtil.printMsg("v_pay_date=", v_pay_date, this);
		//StringUtil.printMsg("v_plan_pay_date=", v_plan_pay_date, this);
		//StringUtil.printMsg("v_pay_cd=", v_pay_cd, this);
		
		/* DataSet */
		GauceDataSet ds1 = gis.read("DEFAULT");
		
		try{	//I:DEFAULT=ds1
			if(ds1!=null){
				GauceDataRow[]    row  = ds1.getDataRows();
				//1 결제마스터 인서트
				cstmt = conn.prepareCall(arr_sql[1].toString());
						
				cstmt.setString(1, v_pay_manage_no);
				cstmt.setString(2, "1");
				cstmt.setString(3, v_accept_date);
				cstmt.setString(4, v_pay_date);
				cstmt.setString(5, v_plan_pay_date);
				cstmt.setString(6, v_pay_cd);
				if(v_pay_cd.equals("020")||v_pay_cd.equals("120")){//가상계좌 or 온라인 다이렉트
					cstmt.setString(7, "N");
				} else{
					cstmt.setString(7, "Y");
				}
				cstmt.setString(8, fParamEmpno);
				cstmt.setString(9, fParamIp);
				cstmt.registerOutParameter(10, java.sql.Types.DECIMAL);	//PAY_SID
				cstmt.executeUpdate();
				
				pay_sid = cstmt.getBigDecimal(10).intValue();
				//StringUtil.printMsg("PAY_SID==", pay_sid, this);
				//StringUtil.printMsg("row.length==", row.length, this);
				
																		
	
				//2 결제액 인서트 Roop.
				for(int i=0; i<row.length; i++){
						
					//그리드의 선택 컬럼이 지정되어 있지 않으면 인서트하지 않도록 조건 추가[2008-01-17]
					if( (row[i].getString(ds1.indexOfColumn("JOB_SEL")).equals("T")) ){
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt   (1, row[i].getInt( ds1.indexOfColumn("ORDER_SID") ));
						cstmt.setInt   (2, pay_sid);
						cstmt.setInt   (3, row[i].getInt( ds1.indexOfColumn("PAYING_AMT") ));
						cstmt.setString(4, fParamEmpno);
						cstmt.setString(5, fParamIp);
						cstmt.executeUpdate();
					}
				}//for(int i=0; i<row.length; i++){
			
			}
			gos.close();
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

}
