package pms.menu.help;

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

public class Pu010H extends SuperServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			
		//StringUtil.printMsg("start::","1",this);		

		//전자결재기안 결재선 조회1_결재선지정 자동지정 /	자재청구 상신 / 자재청구접수 상신 / 품의작성 상신
		arr_sql[1].append ("{call PMS.PR_PU010HS_01(?,?) }" );
		 //전자결재기안 결재선 조회2_결재선 수동지정 /	자재청구 상신 / 자재청구접수 상신 / 품의작성 상신
		 arr_sql[2].append ("{call PMS.PR_PU010HS_02(?,?,?,?,?) }" );
		//	자재청구 상신 / 자재청구접수 상신 / 품의작성 상신  
		arr_sql[3].append ("{call PMS.PR_PU010HI_01(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?) }");
		
		//	자재청구_전자결재기안 기본사항 조회 
		arr_sql[4].append ("{call PMS.PR_PU010HS_04(?,?) }" );
		//	자재청구_전자결재기안 기본사항 조회_품목 LIST 
		arr_sql[5].append ("{call PMS.PR_PU010HS_05(?,?) }" );
			  
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			for(int i=0; i<dSets.length;i++){
				
				if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
						cstmt = conn.prepareCall(arr_sql[4].toString());
						int  v_rqst_sid		= HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid")); 		// 청구sid
						//StringUtil.printMsg("v_rqst_sid::",v_rqst_sid,this);
						cstmt.setInt(1, v_rqst_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
				}else if(dSets[i].getName().equals("ds_default2") & dsType==2){
						GauceDataSet ds1 = gis.read("DS_DEFAULT2");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						int  v_sid		= HDUtil.nullCheckNum(greq.getParameter("v_sid"));
						cstmt.setInt(1, v_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
				}else if(dSets[i].getName().equals("ds_default2") & dsType==5){
					GauceDataSet ds1 = gis.read("DS_DEFAULT5");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					String  v_empno1		= HDUtil.nullCheckStr(greq.getParameter("v_empno1")); 		// 
					String  v_empno2		= HDUtil.nullCheckStr(greq.getParameter("v_empno2")); 		// 
					String  v_empno3		= HDUtil.nullCheckStr(greq.getParameter("v_empno3"));  		// 
					String  v_empno4		= HDUtil.nullCheckStr(greq.getParameter("v_empno4")); 		// 
			
					cstmt.setString(1, v_empno1);
					cstmt.setString(2, v_empno2);
					cstmt.setString(3, v_empno3);
					cstmt.setString(4, v_empno4);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}else if(dSets[i].getName().equals("ds_default9")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT9");
					cstmt = conn.prepareCall(arr_sql[5].toString());
					int  v_rqst_sid	= HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid")); 		// 청구sid
					cstmt.setInt(1, v_rqst_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
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
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {	
		
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
	  
		GauceDataSet msgDS = gis.read("msgDS");
		GauceDataSet ds1 = gis.read("DS_APPROVE");
	  
		try{
		  if (ds1 != null) {
			  //StringUtil.printMsg("ds1","ds1",this);
			  
			  GauceDataRow[] 		    rows = ds1.getDataRows();
			  GauceDataColumn[] 	cols = ds1.getDataColumns();
			 
			  int colNm_DOC_SID          = ds1.indexOfColumn("DOC_SID"); 
			  int colNm_DOC_GU          = ds1.indexOfColumn("DOC_GU");
			  int colNm_DOC_GU2         = ds1.indexOfColumn("DOC_GU2"); 
			  int colNm_AP_GU_1          = ds1.indexOfColumn("AP_GU_1"); 
			  int colNm_AP_SEQ_1       = ds1.indexOfColumn("AP_SEQ_1"); 
			  int colNm_AP_TYPE_1      = ds1.indexOfColumn("AP_TYPE_1"); 
			  int colNm_AP_EMPNO_1  = ds1.indexOfColumn("AP_EMPNO_1"); 
			  int colNm_AP_GU_2         = ds1.indexOfColumn("AP_GU_2"); 
			  int colNm_AP_SEQ_2       = ds1.indexOfColumn("AP_SEQ_2"); 
			  int colNm_AP_TYPE_2      = ds1.indexOfColumn("AP_TYPE_2"); 
			  int colNm_AP_EMPNO_2  = ds1.indexOfColumn("AP_EMPNO_2"); 
			  int colNm_AP_GU_3         = ds1.indexOfColumn("AP_GU_3"); 
			  int colNm_AP_SEQ_3       = ds1.indexOfColumn("AP_SEQ_3"); 
			  int colNm_AP_TYPE_3      = ds1.indexOfColumn("AP_TYPE_3"); 
			  int colNm_AP_EMPNO_3  = ds1.indexOfColumn("AP_EMPNO_3"); 
			  int colNm_AP_GU_4         = ds1.indexOfColumn("AP_GU_4"); 
			  int colNm_AP_SEQ_4       = ds1.indexOfColumn("AP_SEQ_4"); 
			  int colNm_AP_TYPE_4     = ds1.indexOfColumn("AP_TYPE_4"); 
			  int colNm_AP_EMPNO_4  = ds1.indexOfColumn("AP_EMPNO_4"); 
			  int colNm_AP_STATUS_M  = ds1.indexOfColumn("AP_STATUS_M"); 

			  for(int i=0; i<rows.length; i++){
				  int j=1;
				  switch(rows[i].getJobType()){
					  case GauceDataRow.TB_JOB_INSERT:
						  	/*
						  	StringUtil.printMsg("colNm_DOC_SID",rows[i].getString(colNm_DOC_SID),this);
						  	StringUtil.printMsg("colNm_DOC_GU",rows[i].getString(colNm_DOC_GU),this);
						  	StringUtil.printMsg("colNm_DOC_GU2",rows[i].getString(colNm_DOC_GU2),this);
						  	StringUtil.printMsg("colNm_AP_GU_1",rows[i].getString(colNm_AP_GU_1),this);
						  	StringUtil.printMsg("colNm_AP_SEQ_1",rows[i].getString(colNm_AP_SEQ_1),this);
						  	StringUtil.printMsg("colNm_AP_TYPE_1",rows[i].getString(colNm_AP_TYPE_1),this);
						  	StringUtil.printMsg("colNm_AP_EMPNO_1",rows[i].getString(colNm_AP_EMPNO_1),this);
						  	StringUtil.printMsg("colNm_AP_GU_2",rows[i].getString(colNm_AP_GU_2),this);
						  	StringUtil.printMsg("colNm_AP_SEQ_2",rows[i].getString(colNm_AP_SEQ_2),this);
						  	StringUtil.printMsg("colNm_AP_TYPE_2",rows[i].getString(colNm_AP_TYPE_2),this);
						  	StringUtil.printMsg("colNm_AP_EMPNO_2",rows[i].getString(colNm_AP_EMPNO_2),this);
						  	StringUtil.printMsg("colNm_AP_GU_3",rows[i].getString(colNm_AP_GU_3),this);
						  	StringUtil.printMsg("colNm_AP_SEQ_3",rows[i].getString(colNm_AP_SEQ_3),this);
						  	StringUtil.printMsg("colNm_AP_TYPE_3",rows[i].getString(colNm_AP_TYPE_3),this);
						  	StringUtil.printMsg("colNm_AP_EMPNO_3",rows[i].getString(colNm_AP_EMPNO_3),this);
						  	StringUtil.printMsg("colNm_AP_GU_4",rows[i].getString(colNm_AP_GU_4),this);
						  	StringUtil.printMsg("colNm_AP_SEQ_4",rows[i].getString(colNm_AP_SEQ_4),this);
						  	StringUtil.printMsg("colNm_AP_TYPE_4",rows[i].getString(colNm_AP_TYPE_4),this);
						  	StringUtil.printMsg("colNm_AP_EMPNO_4",rows[i].getString(colNm_AP_EMPNO_4),this);
						  	StringUtil.printMsg("colNm_AP_STATUS_M",rows[i].getString(colNm_AP_STATUS_M),this);
						  	*/
							cstmt = conn.prepareCall(arr_sql[3].toString());
						 	
						   // StringUtil.printMsg("# Command","1",this);
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_SID));
							
						   // StringUtil.printMsg("# Command","2",this);
							
							cstmt.setString(2, rows[i].getString(colNm_DOC_GU));
							cstmt.setString(3, rows[i].getString(colNm_DOC_GU2));
							cstmt.setString(4, rows[i].getString(colNm_AP_GU_1));
							cstmt.setInt(5, rows[i].getInt(colNm_AP_SEQ_1));
							cstmt.setString(6, rows[i].getString(colNm_AP_TYPE_1));
							cstmt.setString(7, rows[i].getString(colNm_AP_EMPNO_1));
							cstmt.setString(8, rows[i].getString(colNm_AP_GU_2));
							cstmt.setInt(9, rows[i].getInt(colNm_AP_SEQ_2));
							cstmt.setString(10, rows[i].getString(colNm_AP_TYPE_2));
							cstmt.setString(11, rows[i].getString(colNm_AP_EMPNO_2));
							cstmt.setString(12, rows[i].getString(colNm_AP_GU_3));
							cstmt.setInt(13, rows[i].getInt(colNm_AP_SEQ_3));
							cstmt.setString(14, rows[i].getString(colNm_AP_TYPE_3));
							cstmt.setString(15, rows[i].getString(colNm_AP_EMPNO_3));
							cstmt.setString(16, rows[i].getString(colNm_AP_GU_4));
							cstmt.setInt(17, rows[i].getInt(colNm_AP_SEQ_4));
							cstmt.setString(18, rows[i].getString(colNm_AP_TYPE_4));
							cstmt.setString(19, rows[i].getString(colNm_AP_EMPNO_4));
							cstmt.setString(20, rows[i].getString(colNm_AP_STATUS_M));
							cstmt.setString(21, iParamEmpno);
							cstmt.setString(22, iParamIp);
							cstmt.setString(23, "1");				
							cstmt.registerOutParameter(24,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(25,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(26,  java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();		
							break;
					  case GauceDataRow.TB_JOB_UPDATE:
						  cstmt = conn.prepareCall(arr_sql[1].toString());
						   if(cstmt!=null) cstmt.close();	
						   break;
					  case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[1].toString());
			
						  if(cstmt!=null) cstmt.close();	
						  break;						
				  }//switch(rows[i].getJobType()){
			  }
		  }//if (ds1 != null) {
		  gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}