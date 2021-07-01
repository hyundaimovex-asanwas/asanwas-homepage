package sales.menu.cu;


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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;


public class Cu011I extends SuperServlet {

	private static final long serialVersionUID = 1L;

	public void makeSql(){
	}

    
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		//StringUtil.printMsg("# Command","조회",this);		

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		
		try {
			// 검색시 조건
			String 	sClientSid	= HDUtil.nullCheckStr(greq.getParameter("sClientSid"));
			String 	sWorkNo		= HDUtil.nullCheckStr(greq.getParameter("sWorkNo"));
			String 	sCustNm		= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));
			String 	sManageNo	= HDUtil.nullCheckStr(greq.getParameter("sManageNo"));
			String 	sWorkNoChk	= HDUtil.nullCheckStr(greq.getParameter("sWorkNoChk"));	//체크박스 false||true
			String 	sDepartDate	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));	
			//StringUtil.printMsg(" sClientSid",sClientSid,this);
			//StringUtil.printMsg(" sWorkNo",sWorkNo,this);
			//StringUtil.printMsg(" sCustNm",sCustNm,this);
			//StringUtil.printMsg(" sManageNo",sManageNo,this);
			//StringUtil.printMsg(" sWorkNoChk",sWorkNoChk,this);
			//StringUtil.printMsg(" sDepartDate",sDepartDate,this);

			
			
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

    		
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O: DS1=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall("{call SALES.PR_CU011I_01(?,?,?,?,?,  ?,?) }");
					cstmt.setInt(1, Integer.parseInt(sClientSid));
					cstmt.setString(2, sCustNm);
					cstmt.setString(3, sManageNo);
					cstmt.setString(4, sWorkNo);
					cstmt.setString(5, sWorkNoChk);
					cstmt.setString(6, sDepartDate);
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
			}
            
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}


	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;	
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		String 	sCreateCond	= HDUtil.nullCheckStr(greq.getParameter("sCreateCond"));	//체크박스 false||true
		
		try{
			// I: DEFAULT=ds1
			/* DataSet */
			GauceDataSet inputDs = gis.read("DEFAULT");					
			GauceDataSet crtDs = gis.read("CREATE");
			
			if (inputDs != null) {			
				int colNm_CustSid    		= inputDs.indexOfColumn("CUST_SID");
				int colNm_WorkNo            = inputDs.indexOfColumn("WORK_NO");
				int colNm_VisitKList        = inputDs.indexOfColumn("VISIT_K_LIST");
					
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
					
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call SALES.PR_CU011i_02","call SALES.PR_CU011i_02",this);						
						cstmt = conn.prepareCall("{call SALES.PR_CU011i_02(?,?,?,?,?,   ?,?,?) }");						
						
						cstmt.setInt(1, rows[i].getInt(colNm_CustSid));						
						cstmt.setString(2, rows[i].getString(colNm_WorkNo));
						cstmt.setString(3, rows[i].getString(colNm_VisitKList));
						cstmt.setString(4, fParamEmpno);
						cstmt.setString(5, fParamIp);
						cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
						cstmt.executeUpdate();
	
						if(cstmt!=null) cstmt.close();
						break;
					}
				}
			}
			
			
			// 생성 클릭한 경우
			if(crtDs!=null){
				StringUtil.printMsg("call SALES.PR_CU011i_03","call SALES.PR_CU011i_03",this);
				
				int colNm_CustSid               = crtDs.indexOfColumn("CUST_SID");
				int colNm_JobSel                = crtDs.indexOfColumn("JOB_SEL");
				
				GauceDataRow[] 		rows = crtDs.getDataRows();
				GauceDataColumn[] 	cols = crtDs.getDataColumns();
				
				
				for(int i=0; i<rows.length; i++){
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
						//체크한 (F->T로 되서 업데이트로 찍힌) row만 생성한다.
						if(rows[i].getString(colNm_JobSel).equals("T")){
													
							cstmt = conn.prepareCall("{call SALES.PR_CU011i_03(?, ?, ?, ?, ?, ?, ?) }");						
							//StringUtil.printMsg("sCreateCond",sCreateCond,this);
							cstmt.setInt(1, rows[i].getInt(colNm_CustSid));						
							cstmt.setString(2, sCreateCond);
							cstmt.setString(3, fParamEmpno);
							cstmt.setString(4, fParamIp);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
	
							if(cstmt!=null) cstmt.close();
						}
						break;
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

}
