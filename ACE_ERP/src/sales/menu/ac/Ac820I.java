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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac820I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//조회
		arr_sql[0].append ("{call SALES.PR_AC820I_01(?,?,?,?,?,   ?,?,?,? )}");

		//저장
		arr_sql[1].append ("{call SALES.PR_AC820I_02(?, ?, ?, ?, ?, ?, ?)}");
		
		arr_sql[2].append ("{call SALES.PR_AC820I_03(?, ?, ?, ?, ?, ?)}");
		
		arr_sql[3].append ("{call SALES.PR_AC820I_04(?, ?)}");
		
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String v_fr_date 			= HDUtil.nullCheckStr(greq.getParameter("v_fr_date"));
		String v_to_date 			= HDUtil.nullCheckStr(greq.getParameter("v_to_date"));
		String v_job_sel		 	= HDUtil.nullCheckStr(greq.getParameter("v_job_sel"));
		String v_card_no 			= HDUtil.nullCheckStr(greq.getParameter("v_card_no"));
		String v_accept_no 			= HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));
		String v_issue_company_nm 	= HDUtil.nullCheckStr(greq.getParameter("v_issue_company_nm"));
		String v_job_gu				= HDUtil.nullCheckStr(greq.getParameter("v_job_gu"));
		String v_pay_manage_no		= HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));
		int	   v_saup_sid			= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid") );
		//StringUtil.printMsg(" v_saup_sid===",v_saup_sid, this);
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		try {
	        //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            


            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//	//DEFAULT=ds_default DS2=ds2
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_date);
					cstmt.setString(2, v_to_date);
					cstmt.setString(3, v_job_sel);
					cstmt.setString(4, v_card_no);
					cstmt.setString(5, v_issue_company_nm);
					cstmt.setString(6, v_accept_no);
					cstmt.setString(7, v_job_gu);
					cstmt.setInt(8, v_saup_sid);
					
					cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(9);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString(1, v_pay_manage_no);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
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
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DEFAULT");
		GauceDataSet ds_result = gis.read("RESULT");
		
		try {

			
			if(ds_result!=null){
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				
				for(int i = 0; i < rows.length; i++) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
					//StringUtil.printMsg("card_sid", rows[i].getInt(ds1.indexOfColumn("CARD_SID")), this);
					cstmt.setInt (1, rows[i].getInt(ds1.indexOfColumn("CARD_SID")));
					cstmt.setString (2, rows[i].getString(ds1.indexOfColumn("REQ_DATE")));
					cstmt.setString (3, fParamEmpno);
					cstmt.setString (4, fParamIp);
					cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					if(!cstmt.getString(5).equals("Y"))
						throw new Exception (cstmt.getString(7));
					
					if(ds_result!=null){
						ds_result.put("S_YN", (String)cstmt.getString(5), 1);//커서 OUT param.
						ds_result.put("MSG_CD", (String)cstmt.getString(6), 4);//커서 OUT param.
						ds_result.put("MSG", (String)cstmt.getString(7), 200);//커서 OUT param.
						ds_result.heap();
					}
					if(cstmt!=null) cstmt.close();
				}
			}

			if(ds_result!=null) gos.write(ds_result);
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(cstmt!=null) cstmt.close();
		}
	}

}
