package pms.menu.cc;
//	si110i
//	si110i_h1 사용

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

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cc110S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//카드 사용 현황 조회
		arr_sql[0].append ("{call PMS.PR_CC110S_01(?,?,?,?,?,  ?,?,?,?) }" );

		//card use list detail 조회 - 계정정보
		arr_sql[1].append ("{call PMS.PR_CC110I_02(?,?) }" );

	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("초기화~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_mgr_no 		= HDUtil.nullCheckStr(greq.getParameter("v_mgr_no"));			//처리자 사번
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				// 작업일자
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				// 작업일자
		String v_ccstat			= HDUtil.nullCheckStr(greq.getParameter("v_ccstat"));			// 처리 상태
		String v_card_num 		= HDUtil.nullCheckStr(greq.getParameter("v_card_num"));			// 카드번호
		int	v_acquire_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_acquire_sid"));		// 매입sid

		//내부 변수
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;		
		//StringUtil.printMsg("v_site_sid",v_site_sid,this);
		StringUtil.printMsg("v_frdate",v_frdt,this);
		StringUtil.printMsg("v_todate",v_todt,this);

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
            	if(dSets[i].getName().equals("ds_cul")){
					GauceDataSet ds1 = gis.read("DS_CUL");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_frdt);
					cstmt.setString(2, v_todt);
					cstmt.setString(3, v_mgr_no);
					cstmt.setString(4, v_card_num);
					cstmt.setString(5, v_ccstat);
					cstmt.setString(6, "");
					cstmt.setString(7, "");
					cstmt.setString(8, "");
					cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(9);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_culd")){
					GauceDataSet ds1 = gis.read("DS_CULD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_acquire_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}

            	
            }
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("저장~!","",this);
	}
}