package sales.menu.ac;

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

public class Ac810I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
        
        //조회
        arr_sql[0].append ("{CALL SALES.PR_AC810I_01(?, ?, ?, ?, ?,  ?)}");
        
        //카드 취소 : 당일 승인취소
        arr_sql[1].append ("{CALL SALES.PR_AC810I_02(?, ?, ?, ?, ?, ?, ?)}");
        
        //카드 취소 : 매입취소
        arr_sql[2].append ("{CALL SALES.PR_AC810I_03(?, ?, ?, ?, ?, ?, ?)}");
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int    v_cnt 			= 1;
		int    v_client_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));	//대리점 SID
		String v_bgn_pay_date 	= HDUtil.nullCheckStr(greq.getParameter("v_bgn_pay_date"));	//출경일자1
		String v_end_pay_date 	= HDUtil.nullCheckStr(greq.getParameter("v_end_pay_date"));	//출경일자2
		String v_pay_manage_no  = HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));	//신청서번호
		String v_card_no	   	= HDUtil.nullCheckStr(greq.getParameter("v_card_no"));		//성명

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		try{
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
        	
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				// DEFAULT=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString (1, v_bgn_pay_date);
					cstmt.setString (2, v_end_pay_date);
					cstmt.setString (3, v_pay_manage_no);
					cstmt.setString (4, v_card_no);
					cstmt.setInt	(5, v_client_sid);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 					
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

		/* DataSet I:DEFAULT=ds1,O:RESULT=ds_result */
		GauceDataSet ds1 		= gis.read("DEFAULT");
		GauceDataSet ds_result 	= gis.read("RESULT");
		
		String v_pay_manage_no 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));	//결제관리번호
		String v_card_buy_yn 	= HDUtil.nullCheckStr(greq.getParameter("v_card_buy_yn"));		//매입여부
		//StringUtil.printMsg("# v_pay_manage_no",v_pay_manage_no,this);
		//StringUtil.printMsg("# v_card_buy_yn",v_card_buy_yn,this);

		try{
			if(ds_result!=null){
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

			if(ds1!=null){
				GauceDataRow[]    row  = ds1.getDataRows();
				
				for(int i=0; i<row.length; i++){
					if(v_card_buy_yn.equals("Y"))	//기 매입자료. 취소청구 자료 생성 (TRV220,TRV200)
						cstmt = conn.prepareCall(arr_sql[2].toString());
					else
						cstmt = conn.prepareCall(arr_sql[1].toString());	//당일 취소 (TRV200)
					
					cstmt.setString(1, v_pay_manage_no);
					cstmt.setString(2, fParamEmpno);
					cstmt.setString(3, fParamIp);
					cstmt.setString(4, "1");
					cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);	//메세지
					cstmt.executeUpdate();

					
					String r_s_yn		= cstmt.getString(5);
					String r_msg_cd	 	= cstmt.getString(6);
					String r_msg		= cstmt.getString(7);
					if(!r_s_yn.equals("Y"))
						throw new Exception ("");
					if(cstmt!=null) cstmt.close();
					
					if(ds_result!=null){
						ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_result.heap();					
					}
				}
			}

			if(ds_result!=null) gos.write(ds_result);
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}
}
