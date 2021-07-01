package sales.menu.rv;

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

public class Rv203I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_RV203I_01(?,?,?,?)");

		arr_sql[2].append ("SELECT                       		        \n")
				  .append ("	r15.bound_seq, CHAR(r15.bound_seq) AS bound_nm     	\n")
				  .append ("FROM                                    	\n")
				  .append ("	sales.trv010 r1 join sales.trv015 r15 on (r1.accept_sid=r15.accept_sid)                  \n")
				  .append ("WHERE 1=1                           		\n")
				  .append (" AND  r1.ACCEPT_NO = ?              		\n")
				  .append (" ORDER BY r15.bound_seq               		\n")
				  ;
		arr_sql[3].append ("SELECT DISTINCT R2.PAY_SEQ, CHAR(R2.PAY_SEQ) AS PAY_NM \n")
				  .append ("  FROM SALES.TRV020 R2 JOIN SALES.TRV010 R1 ON (R2.ACCEPT_SID=R2.ACCEPT_SID) \n")
				  .append (" WHERE R1.ACCEPT_NO= ? \n")
				  .append ("   AND R2.BOUND_SEQ= ? \n")
				  ;	  

		arr_sql[4].append("CALL SALES.PR_RV203I_02(?,?,?,?,?	,?,?,?,?,?	,?,?,?,?)");

	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement 	cstmt 		= null;
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// 매출처
		String v_accept_no 	= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	// 신청서번호		
		int v_bound_seq 	= HDUtil.nullCheckNum(req.getParameter("v_bound_seq"));			// 상품순번.
		int v_pay_seq	 	= HDUtil.nullCheckNum(req.getParameter("v_pay_seq"));			// 결제순번.
		/*
		StringUtil.printMsg("대리점",sClientSid+"",this);
		StringUtil.printMsg("신청서번호",v_accept_no,this);
		StringUtil.printMsg("상품순번",v_bound_seq+"",this);
		StringUtil.printMsg("결제순번",v_pay_seq+"",this);
		*/

		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("MASTER")){
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, sClientSid);
						cstmt.setString(2,v_accept_no);
						cstmt.setInt(3, v_bound_seq);
						cstmt.setInt(4, v_pay_seq);
					}
					if(gauceName.equals("DS_BOUND")){
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1, v_accept_no);
					}
					if(gauceName.equals("DS_PAYSEQ")){
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setString(1, v_accept_no);
						cstmt.setInt(2, v_bound_seq);
					}
					rs = cstmt.executeQuery();							
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
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;

		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("MASTER");	

		try {
			//내부 변수
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_Accept_sid          = ds1.indexOfColumn("ACCEPT_SID");
				int colNm_PaySeq		        = ds1.indexOfColumn("PAY_SEQ");
				int colNm_BoundSeq	        = ds1.indexOfColumn("BOUND_SEQ");
				int colNm_Id               			= ds1.indexOfColumn("ID");
				int colNm_Email			        = ds1.indexOfColumn("EMAIL");
				int colNm_Recipient_Gu	    = ds1.indexOfColumn("RECIPIENT_GU");
				int colNm_Name              	= ds1.indexOfColumn("NAME");
				int colNm_Mob               		= ds1.indexOfColumn("MOB");
				int colNm_Depart_Date        = ds1.indexOfColumn("DEPART_DATE");
				int colNm_Arrive_Date	        = ds1.indexOfColumn("ARRIVE_DATE");
				int colNm_Goods_Sid	        = ds1.indexOfColumn("GOODS_SID");
				int colNm_Accept_No	        = ds1.indexOfColumn("ACCEPT_NO");
				//int colNm_Passwd	       	 	= ds1.indexOfColumn("PASSWD");
				//StringUtil.printMsg("colNm_Rsv_sid",colNm_Rsv_sid+"" , this);
				//StringUtil.printMsg("DDDD2",colNm_PaySeq+"" , this);
			
				
				for(int i = 0; i < rows.length; i++) {
					//업데이트행만 처리한다.
					//StringUtil.printMsg("job=", rows[i].getJobType(), this);
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						/*
						StringUtil.printMsg("1",rows[i].getInt(colNm_Accept_sid), this);
						StringUtil.printMsg("2",rows[i].getInt(colNm_PaySeq) , this);
						StringUtil.printMsg("3",rows[i].getInt(colNm_BoundSeq) , this);
						StringUtil.printMsg("4",rows[i].getString(colNm_Id), this);
						StringUtil.printMsg("5",rows[i].getString(colNm_Email) , this);
						StringUtil.printMsg("6",rows[i].getString(colNm_Recipient_Gu) , this);
						StringUtil.printMsg("7",rows[i].getString(colNm_Name) , this);
						StringUtil.printMsg("8",rows[i].getString(colNm_Mob) , this);
						StringUtil.printMsg("9",rows[i].getString(colNm_Depart_Date) , this);
						StringUtil.printMsg("10",rows[i].getString(colNm_Arrive_Date) , this);						
						StringUtil.printMsg("11",rows[i].getInt(colNm_Goods_Sid) , this);
						StringUtil.printMsg("12",rows[i].getString(colNm_Accept_No) , this);
						//StringUtil.printMsg("13",rows[i].getString(colNm_Passwd) , this);
						*/
											
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt       (1, rows[i].getInt(colNm_Accept_sid));		//신청서번호SID 
						cstmt.setInt     	(2, rows[i].getInt(colNm_PaySeq));				//결제순번
						cstmt.setInt     	(3, rows[i].getInt(colNm_BoundSeq));			//상품순번
						cstmt.setString (4, rows[i].getString(colNm_Id));					//아이디 (대리점)
						cstmt.setString (5, rows[i].getString(colNm_Email));			//이메일( 사용자)
						cstmt.setString (6, rows[i].getString(colNm_Recipient_Gu));		//수신자구분(대리점/사용자)
						cstmt.setString (7, rows[i].getString(colNm_Name));			//이름
						cstmt.setString (8, rows[i].getString(colNm_Mob));				//핸드폰
						cstmt.setString (9, rows[i].getString(colNm_Depart_Date));			//출발일자
						cstmt.setString (10, rows[i].getString(colNm_Arrive_Date));		//도착일자
						cstmt.setInt     	(11, rows[i].getInt(colNm_Goods_Sid));				//상품sid
						cstmt.setString (12, rows[i].getString(colNm_Accept_No));			//신청서번호
						//cstmt.setString (13, rows[i].getString(colNm_Passwd));			//신청서번호
						cstmt.setString (13, fParamEmpno);										//수정사번
						cstmt.setString (14, fParamIp);												//수정ip
						cstmt.executeUpdate();
					} //if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
				};//for(int i=0; i<row.length; i++){
	
			}; //if
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}

