package config.menu.ap;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Ap110I extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//결재함 조회
		arr_sql[0].append("{call COMMON.PR_AP110I_01 (?,?,?,?,?     ,?) }");
		
	}
 
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

		/*
		 * 검색시 필요한 조건
		 */
		String sNowEmpno	= HDUtil.nullCheckStr(greq.getParameter("v_empno"));	// 로긴사번
		String sFrDate		= HDUtil.nullCheckStr(greq.getParameter("v_fr_date"));	//
		String sToDate		= HDUtil.nullCheckStr(greq.getParameter("v_to_date"));	//
		String sDocGu		= HDUtil.nullCheckStr(greq.getParameter("v_doc_gu"));	//
		String sDocGu2		= HDUtil.nullCheckStr(greq.getParameter("v_doc_gu2"));	//
		try {
			for(int i=0; i<dSets.length;i++){
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("MASTER");
						cstmt = conn.prepareCall(arr_sql[0].toString());

						cstmt.setString(1, sNowEmpno);	
						cstmt.setString(2, sFrDate);	
						cstmt.setString(3, sToDate);	
						cstmt.setString(4, sDocGu);
						cstmt.setString(5, sDocGu2);
						cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					}
				}
				gos.close();
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

		public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		}
	}