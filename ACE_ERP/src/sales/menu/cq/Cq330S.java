package sales.menu.cq;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Cq330S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_RV813S_01(?,?,?,?,?,	 ?,?,?,?,?)");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int v_rowcnt = 0;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		 // 검색시 필요한 조건
		 int sSaupSid		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid")); 	// 지역 SID
		 String sDirection	= HDUtil.nullCheckStr(greq.getParameter("v_direction"));	// 방향
		 String sDate 		= HDUtil.nullCheckStr(greq.getParameter("v_date"));		// 일자 
		 String sTime		= HDUtil.nullCheckStr(greq.getParameter("v_time")); 		// 시각		
		 int sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid")); // 상품 SID
		 String sAccept_no	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no")); // 신청서번호

		 //고객쪽 추가조건
		 String sClass 		= HDUtil.nullCheckStr(greq.getParameter("v_class")); // 반
		 String sTeam		= HDUtil.nullCheckStr(greq.getParameter("v_team")); // 조 
		 String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("v_jobsel")); // 고객구분
				
/*		 String sAssign_YN	= HDUtil.nullCheckStr(req.getParameter("v_assign_YN")); // 미배정자
		 String sCustNM		= HDUtil.nullCheckStr(req.getParameter("v_custnm"));		// 성명
		 StringUtil.printMsg("sSaupSid- ",sSaupSid , this);
		 StringUtil.printMsg("sDirection- ",sDirection , this);
		 StringUtil.printMsg("sDate- ",sDate , this);
		 StringUtil.printMsg("sTime- ",sTime , this);
		 StringUtil.printMsg("sGoodSid- ",sGoodSid , this);
		 StringUtil.printMsg("sClass- ",sClass , this);
		 StringUtil.printMsg("sTeam- ",sTeam , this);		
		 StringUtil.printMsg("sJobsel- ",sJobsel , this);	
		 StringUtil.printMsg("sAccept_no- ",sAccept_no , this);  
		 StringUtil.printMsg("sAssign_YN- ",sAssign_YN , this);  
		 StringUtil.printMsg("sCustNM- ",sCustNM , this);*/  
		 
		try {
			int sCnt1 = 1;
			 GauceDataSet[] dSets = gis.readAllOutput();
			
			 for(int i=0; i<dSets.length;i++){
					//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
					//O:	DEFAULT=ds_default)",
	            	if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DS1");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, sSaupSid);	
					cstmt.setString(2, sDirection);
					cstmt.setString(3, sDate);	
					cstmt.setString(4, sTime);	
					cstmt.setInt(5, sGoodSid);	

					cstmt.setString(6, sClass);	
					cstmt.setString(7, sTeam);	
					cstmt.setString(8, sJobsel);
					cstmt.setString(9, sAccept_no);
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 					
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}