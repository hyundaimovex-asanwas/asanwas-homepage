package sales.menu.rv;


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

public class Rv300I extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_RV300I_01(?,?,?,?,? )");

		arr_sql[2].append ("SELECT                       		        \n")
				  .append ("	r15.bound_seq, TO_CHAR(r15.bound_seq) AS bound_nm     	\n")
				  .append ("FROM                                    	\n")
				  .append ("	sales.trv010 r1 join sales.trv015 r15 on (r1.accept_sid=r15.accept_sid)                  \n")
				  .append ("WHERE 1=1                           		\n")
				  .append (" AND  r1.ACCEPT_NO = ?              		\n")
				  .append (" ORDER BY r15.bound_seq               		\n")
				  ;
		arr_sql[3].append ("SELECT DISTINCT R2.PAY_SEQ, TO_CHAR(R2.PAY_SEQ) AS PAY_NM \n")
				  .append ("  FROM SALES.TRV020 R2 JOIN SALES.TRV010 R1 ON (R2.ACCEPT_SID=R1.ACCEPT_SID) \n")
				  .append (" WHERE R1.ACCEPT_NO= ? \n")
				  .append ("   AND R2.BOUND_SEQ= ? \n")
				  ;	  

		arr_sql[4].append("CALL SALES.PR_RV300I_02(?,?,?,?)");

	}

	
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			/*
			 * 검색시 필요한 조건
			 */
			int sClientSid 		= HDUtil.nullCheckNum(greq.getParameter("sClient_sid"));	// 매출처
			String v_accept_no 	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));	// 신청서번호		
			int v_bound_seq 	= HDUtil.nullCheckNum(greq.getParameter("v_bound_seq"));			// 상품순번.
			int v_pay_seq	 	= HDUtil.nullCheckNum(greq.getParameter("v_pay_seq"));			// 결제순번.
			//StringUtil.printMsg("대리점",sClientSid+"",this);
			//StringUtil.printMsg("신청서번호",v_accept_no,this);
			//StringUtil.printMsg("상품순번",v_bound_seq+"",this);
			//StringUtil.printMsg("결제순번",v_pay_seq+"",this);

	        //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
            	//O:MASTER=ds1, O:DS_BOUND=ds_bound, O:DS_PAYSEQ=ds_payseq
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("MASTER");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, sClientSid);
					cstmt.setString(2,v_accept_no);
					cstmt.setInt(3, v_bound_seq);
					cstmt.setInt(4, v_pay_seq);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_bound")){
					GauceDataSet ds1 = gis.read("DS_BOUND");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, v_accept_no);
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}            	
            	if(dSets[i].getName().equals("ds_payseq")){
					GauceDataSet ds1 = gis.read("DS_PAYSEQ");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString(1, v_accept_no);
					cstmt.setInt(2, v_bound_seq);
					rs=cstmt.executeQuery();
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
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;

		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		/* DataSet */
		GauceDataSet ds1 = gis.read("MASTER");
		//	I:MASTER=ds1,O:msgDS=msgDS)",
		try {
			//내부 변수
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_Rsv_sid               = ds1.indexOfColumn("RSV_SID");
				int colNm_PaySeq		        = ds1.indexOfColumn("PAY_SEQ");
				//StringUtil.printMsg("DDDD1",colNm_Rsv_sid+"" , this);
				//StringUtil.printMsg("DDDD2",colNm_PaySeq+"" , this);
				
				for(int i = 0; i < rows.length; i++) {
					//업데이트행만 처리한다.
					//StringUtil.printMsg("job=", rows[i].getJobType(), this);
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt        (1, rows[i].getInt(colNm_Rsv_sid));		//예약SID 
						//StringUtil.printMsg("1", rows[i].getInt(colNm_Rsv_sid), this);
						cstmt.setInt     	(2, rows[i].getInt(colNm_PaySeq));			//정산예정액
						//StringUtil.printMsg("2",rows[i].getInt(colNm_PaySeq) , this);
						cstmt.setString     (3, fParamEmpno);							//수정사번
						cstmt.setString     (4, fParamIp);								//수정ip
					
						cstmt.executeUpdate();
					} //if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
				};//for(int i=0; i<row.length; i++){
	
			}; //if
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
}

