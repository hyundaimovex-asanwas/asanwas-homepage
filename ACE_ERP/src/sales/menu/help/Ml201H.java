package sales.menu.help;
 
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

public class Ml201H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++) {
            arr_sql[i] = new StringBuffer();
        }
		// TODO Auto-generated method stub
		arr_sql[0].append("CALL SALES.PR_PU010S_01(?,?,?,?, ?)"); // 신용카드


		arr_sql[1].append("CALL SALES.PR_RV330S_02(?,?,?,?,?)"); 
		arr_sql[2].append("CALL SALES.PR_RV330S_03(?,?)"); // 상품권
		arr_sql[3].append("CALL SALES.PR_RV330S_04(?,?)"); // 기타대체
		arr_sql[4].append("CALL SALES.PR_RV330S_05(?,?)"); // 무통장입금
		
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	
	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;


		//System.out.println("11111111111111111111111");
		//상품권 리스트에 필요한 입력 파라미터 정의
		String sPayCd 		= HDUtil.nullCheckStr(greq.getParameter("pay_cd"));
		String sPayManageNo = HDUtil.nullCheckStr(greq.getParameter("pay_manage_no"));
		String sOrderNo 	= HDUtil.nullCheckStr(greq.getParameter("order_no"));
		String sPayDate		= HDUtil.nullCheckStr(greq.getParameter("pay_date"));
		int    sOrderSid	= HDUtil.nullCheckNum(greq.getParameter("order_sid"));
		int    sPaySid		= HDUtil.nullCheckNum(greq.getParameter("pay_sid"));
		String sSalesGubn	= HDUtil.nullCheckStr(greq.getParameter("sales_gubn"));		

		StringUtil.printMsg("sOrderNo",sOrderNo,this);
		//StringUtil.printMsg("sPayDate",sPayDate,this);
		//StringUtil.printMsg("sOrderSid",sOrderSid,this);
		StringUtil.printMsg("PAY_CD", sPayCd,this);
		//StringUtil.printMsg("PAY_MANAGE_NO",sPayManageNo,this);
		StringUtil.printMsg("sPaySid",sPaySid,this);
		StringUtil.printMsg("sSalesGubn",sSalesGubn,this);
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		try{
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
            	//DS4=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS4");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sOrderNo);
					cstmt.setInt(2, sPaySid);
					cstmt.setString(3, sPayCd);
					cstmt.setString(4, sSalesGubn);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
			}
		} catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}
}
