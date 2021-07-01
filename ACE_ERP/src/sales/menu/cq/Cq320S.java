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

public class Cq320S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ641S_01(?,?,?,?,?	,? )");
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
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int    sSaup_sid 	= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));		// 사업소
		String sArriveDate  = HDUtil.nullCheckStr(greq.getParameter("sArriveDate")); 	// 출경일자
		String sArriveTime  = HDUtil.nullCheckStr(greq.getParameter("sArriveTime")); 	// 출경시간
		int    sGoods_sid	= HDUtil.nullCheckNum(greq.getParameter("sGoodsSid"));		// 상품 
		String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("sJobsel")); 		// 고객구분
	   
		try {
			int sCnt1 = 1;
			 GauceDataSet[] dSets = gis.readAllOutput();
			
			 for(int i=0; i<dSets.length;i++){
					//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
					//O:	DEFAULT=ds_default)",
	            	if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DS1");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt   (1,sSaup_sid);
						cstmt.setString(2, sArriveDate);
						cstmt.setString(3, sArriveTime);
						cstmt.setInt   (4, sGoods_sid);
						cstmt.setString(5, sJobsel);
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}