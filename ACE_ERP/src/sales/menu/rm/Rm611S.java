package sales.menu.rm;

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

public class Rm611S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//조회
		arr_sql[0].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");

		//조회
		arr_sql[1].append ("{call SALES.PR_RM611S_01(?,?,?,?,?, 	?,?,?)}");
		
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		try{
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			int 	v_block_sid			= HDUtil.nullCheckNum(greq.getParameter("v_block_sid"));
			int 	v_client_sid		= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));
			int 	v_goods_sid			= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));
			String 	v_fr_date	 		= HDUtil.nullCheckStr(greq.getParameter("v_fr_date"));
			String 	v_to_date	 		= HDUtil.nullCheckStr(greq.getParameter("v_to_date"));
			String 	v_block_no	 		= HDUtil.nullCheckStr(greq.getParameter("v_block_no"));
			String 	v_job_sel		 	= HDUtil.nullCheckStr(greq.getParameter("v_job_sel"));
			String 	v_mi_ipkum_gu	 	= HDUtil.nullCheckStr(greq.getParameter("v_mi_ipkum_gu"));
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds_master")){
					GauceDataSet ds1 = gis.read("MASTER");
						/*
						String temp_sql = arr_sql[0].toString();
						temp_sql = StringUtil.strReplace(temp_sql, "$1", v_fr_date);
						temp_sql = StringUtil.strReplace(temp_sql, "$2", v_to_date);
						
						stmt = conn.getGauceStatement(temp_sql);
						rs = stmt.executeQuery();
						if(rs.next()){
							if(rs.getInt("DAY_CNT")>31){
								res.writeException("ERROR", "0000", "기간을 한달이내로 하시길 바랍니다.");
								break;
							}
						} else {
							res.writeException("ERROR", "0000", "기간내의 일자를 계산하는중 오류가 발생했습니다.");
							break;
						}
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();
						*/
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt	(1, v_client_sid);
						cstmt.setInt	(2, v_goods_sid);
						cstmt.setString (3, v_fr_date);
						cstmt.setString (4, v_to_date);
						cstmt.setString (5, v_block_no);
						cstmt.setString (6, v_job_sel);
						cstmt.setString (7, v_mi_ipkum_gu);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 					
						gos.write(getDataSet(rs, ds1));
						
						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
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

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}