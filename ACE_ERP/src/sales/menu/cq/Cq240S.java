package sales.menu.cq;

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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Cq240S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//차량탑승_차량조회
		arr_sql[0].append("{call SALES.PR_CQ240S_01 (?,?,?,?,?,   ?,?,? ) }");
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

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		CallableStatement cstmt = null;		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		// 검색시 필요한 조건
		int sSaupSid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid")); 	// 지역 SID
		String sDirection	= HDUtil.nullCheckStr(req.getParameter("v_direction"));	// 방향
		String sDate 		= HDUtil.nullCheckStr(req.getParameter("v_date"));		// 일자 
		String sTime		= HDUtil.nullCheckStr(req.getParameter("v_time")); 		// 시각		
		int sGoodSid		= HDUtil.nullCheckNum(req.getParameter("v_goods_sid")); // 상품 SID
		String sAccept_no	= HDUtil.nullCheckStr(req.getParameter("v_accept_no")); // 신청서번호
		String 	sParam01	= HDUtil.nullCheckStr(req.getParameter("sParam01"));
		String 	sParam02	= HDUtil.nullCheckStr(req.getParameter("sParam02"));
		String 	sParam03	= HDUtil.nullCheckStr(req.getParameter("sParam03"));

		//고객쪽 추가조건
		String sClass 		= HDUtil.nullCheckStr(req.getParameter("v_class")); // 반
		String sTeam		= HDUtil.nullCheckStr(req.getParameter("v_team")); // 조 
		String sJobsel		= HDUtil.nullCheckStr(req.getParameter("v_jobsel")); // 고객구분
				
		String sAssign_YN	= HDUtil.nullCheckStr(req.getParameter("v_assign_YN")); // 미배정자
		String sCustNM		= HDUtil.nullCheckStr(req.getParameter("v_custnm"));		// 성명
		
		/*StringUtil.printMsg("sSaupSid- ",sSaupSid , this);
		StringUtil.printMsg("sDirection- ",sDirection , this);
		StringUtil.printMsg("sDate- ",sDate , this);
		StringUtil.printMsg("sTime- ",sTime , this);
		StringUtil.printMsg("sGoodSid- ",sGoodSid , this);
		StringUtil.printMsg("sClass- ",sClass , this);
		StringUtil.printMsg("sTeam- ",sTeam , this);		
		StringUtil.printMsg("sJobsel- ",sJobsel , this);	
		StringUtil.printMsg("sAccept_no- ",sAccept_no , this);  
		StringUtil.printMsg("sAssign_YN- ",sAssign_YN , this);  
		StringUtil.printMsg("sCustNM- ",sCustNM , this);  
		StringUtil.printMsg("sParam01",sParam01,this);
		StringUtil.printMsg("sParam02",sParam02,this);*/
			
		
		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						//StringUtil.printMsg("객실상태조회 쿼리",arr_sql[0].toString(), this);
						cstmt = conn.prepareCall(arr_sql[0].toString());

						cstmt.setInt(1, sSaupSid);	
						cstmt.setString(2, sDirection);
						cstmt.setString(3, sDate);	
						cstmt.setString(4, sTime);	
						cstmt.setInt(5, sGoodSid);	
						cstmt.setString(6, sAccept_no);
						cstmt.setString(7, sParam01);
						cstmt.setString(8, sParam02);
						rs = cstmt.executeQuery();
					}

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
	}

}
