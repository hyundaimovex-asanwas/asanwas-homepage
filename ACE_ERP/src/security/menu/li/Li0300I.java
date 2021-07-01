package security.menu.li;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

public class Li0300I extends SuperServlet {

	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			
		StringUtil.printMsg("start::","1",this);		

		//수신열람확인 조회 
		arr_sql[0].append ("{call SECURITY.PR_LI0300S_01(?,?,?,?,?,?,?,?,?) }" );
		
		//수신열람확인 저장 
		arr_sql[1].append ("{call SECURITY.PR_LI0300I_01(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
        
   }

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				
				String gauceName = (String)it.next();

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_DEFAULT")){              //수신열람 조회 
						cstmt = conn.prepareCall(arr_sql[0].toString());
						
						String v_doc_grd		= HDUtil.nullCheckStr(req.getParameter("v_doc_grd")); 		// 문서등급
						String v_doc_frm		= HDUtil.nullCheckStr(req.getParameter("v_doc_frm")); 		// 문서형태
						String v_rcp_dpt		= HDUtil.nullCheckStr(req.getParameter("v_rcp_dpt")); 		// 수신부서
						String v_sgn_sts		= HDUtil.nullCheckStr(req.getParameter("v_sgn_sts")); 		// 결재상태
						String v_rcp_sts		= HDUtil.nullCheckStr(req.getParameter("v_rcp_sts")); 		// 수신상태
						String v_rcp_psn		= HDUtil.nullCheckStr(req.getParameter("v_rcp_psn")); 		// 수신자
						String v_doc_tle		= HDUtil.nullCheckStr(req.getParameter("v_doc_tle")); 		    // 제목
						String v_doc_cts		= HDUtil.nullCheckStr(req.getParameter("v_doc_cts")); 		// 내용
						String v_doc_kwd		= HDUtil.nullCheckStr(req.getParameter("v_doc_kwd")); 		// 키워드	
					
					
						/*
						StringUtil.printMsg("v_doc_grd::",v_doc_grd,this);
						StringUtil.printMsg("v_doc_frm::",v_doc_frm,this);
						StringUtil.printMsg("v_own_dpt::",v_own_dpt,this);
						StringUtil.printMsg("v_doc_tle::",v_doc_tle,this);
						StringUtil.printMsg("v_doc_cts::",v_doc_cts,this);
						StringUtil.printMsg("v_doc_kwd::",v_doc_kwd,this);				
						*/
						
						cstmt.setString(1, v_doc_grd);
						cstmt.setString(2, v_doc_frm);
						cstmt.setString(3, v_rcp_dpt);
						cstmt.setString(4, v_sgn_sts);
						cstmt.setString(5, v_rcp_sts);
						cstmt.setString(6, v_rcp_psn);
						cstmt.setString(7, v_doc_tle);
						cstmt.setString(8, v_doc_cts);
						cstmt.setString(9, v_doc_kwd);
	
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}
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
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {	
		
      StringUtil.printMsg("# Command","저장",this);
	  CallableStatement cstmt = null;	
	  ResultSet 			   rs 	= null;
	
	  /** 
	   * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
	   **/
	  String iParamEmpno 	= fParamEmpno;
	  String iParamIp 	= fParamIp;
	  
	  StringUtil.printMsg("# Command","iParamEmpno::"+iParamEmpno,this);
	  StringUtil.printMsg("# Command","iParamIp::"+iParamIp,this);
			
	  /* DataSet */
	  GauceDataSet ds1 = req.getGauceDataSet("DS_DEFAULT");
	                                                                     
	 
	  try{
		  if (ds1 != null) {
			  StringUtil.printMsg("ds1","ds1",this);
			  
			  GauceDataRow[] 		    rows = ds1.getDataRows();
			  GauceDataColumn[] 	cols = ds1.getDataColumns();
			
		    	int colNm_DOC_MAG_SID  = ds1.indexOfColumn("DOC_MAG_SID"); 
				int colNm_DOC_GRD      = ds1.indexOfColumn("DOC_GRD");    
				int colNm_DOC_FRM      = ds1.indexOfColumn("DOC_FRM");    
				int colNm_DOC_TLE       = ds1.indexOfColumn("DOC_TLE");    
				int colNm_DOC_CTS      = ds1.indexOfColumn("DOC_CTS");    
				int colNm_DOC_KWD     = ds1.indexOfColumn("DOC_KWD");    
				int colNm_FLE_DRC       = ds1.indexOfColumn("FLE_DRC");    
				int colNm_RAL_DRC       = ds1.indexOfColumn("RAL_DRC");    
				int colNm_FLE_NM         = ds1.indexOfColumn("FLE_NM");    
				int colNm_OWN_DPT     = ds1.indexOfColumn("OWN_DPT");    
				int colNm_PRD_DPT      = ds1.indexOfColumn("PRD_DPT");    
				int colNm_PRD_PSN      = ds1.indexOfColumn("PRD_PSN");    
				int colNm_PRD_DT         = ds1.indexOfColumn("PRD_DT");     
				int colNm_PRS_YR_LMT  = ds1.indexOfColumn("PRS_YR_LMT"); 
				int colNm_DOC_SGN_STS      = ds1.indexOfColumn("DOC_SGN_STS");    
				int colNm_CRT_DIV        = ds1.indexOfColumn("CRT_DIV");    
				int colNm_USE_YN         = ds1.indexOfColumn("USE_YN");     
				int colNm_DUS_DT         = ds1.indexOfColumn("DUS_DT");     
				int colNm_ORG_MGN_NO  = ds1.indexOfColumn("ORG_MGN_NO");
			    int colNm_RCP_RDG_SID  = ds1.indexOfColumn("RCP_RDG_SID"); 		 
		    	int colNm_RCP_STS          = ds1.indexOfColumn("RCP_STS"); 			
			    int colNm_SND_DIV          = ds1.indexOfColumn("SND_DIV"); 	
			    int colNm_RCP_DPT         = ds1.indexOfColumn("RCP_DPT"); 	
			    int colNm_RCP_DT           = ds1.indexOfColumn("RCP_DT"); 	
			    
			   
	
				
			  StringUtil.printMsg("colNm_FLE_DRC",colNm_FLE_DRC,this);

			  for(int i=0; i<rows.length; i++){
				  int j=1;
				  switch(rows[i].getJobType()){
					  case GauceDataRow.TB_JOB_INSERT:
				   	  
					        StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);
						 	cstmt = conn.prepareCall(arr_sql[1].toString());
						 	
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
							cstmt.setString(2, rows[i].getString(colNm_DOC_GRD));
							cstmt.setString(3, rows[i].getString(colNm_DOC_FRM));
							cstmt.setString(4, rows[i].getString(colNm_DOC_TLE));
							cstmt.setString(5, rows[i].getString(colNm_DOC_CTS));
							cstmt.setString(6, rows[i].getString(colNm_DOC_KWD));
							cstmt.setString(7, rows[i].getString(colNm_FLE_DRC));
							cstmt.setString(8, rows[i].getString(colNm_RAL_DRC));
							cstmt.setString(9, rows[i].getString(colNm_FLE_NM));
							cstmt.setString(10, rows[i].getString(colNm_OWN_DPT));
							cstmt.setString(11, rows[i].getString(colNm_PRD_DPT));
							cstmt.setString(12, rows[i].getString(colNm_PRD_PSN));
							cstmt.setString(13, rows[i].getString(colNm_PRD_DT));
							cstmt.setString(14, rows[i].getString(colNm_PRS_YR_LMT));
							cstmt.setString(15, rows[i].getString(colNm_DOC_SGN_STS));
							cstmt.setString(16, rows[i].getString(colNm_CRT_DIV));
							cstmt.setString(17, rows[i].getString(colNm_USE_YN));
							cstmt.setString(18, rows[i].getString(colNm_DUS_DT));
							cstmt.setInt(19, rows[i].getInt(colNm_ORG_MGN_NO));
					        cstmt.setInt(20, rows[i].getInt(colNm_RCP_RDG_SID));
					        cstmt.setString(21, rows[i].getString(colNm_RCP_STS));
					        cstmt.setString(22, rows[i].getString(colNm_SND_DIV));
				     	    cstmt.setString(23, rows[i].getString(colNm_RCP_DPT));
					        cstmt.setString(24, rows[i].getString(colNm_RCP_DT));
					        cstmt.setString(25, iParamEmpno);
							cstmt.setString(26, iParamIp);
							cstmt.setString(27, "1");							

						    cstmt.executeUpdate();
			
						    if(cstmt!=null) cstmt.close();		
						
						    break;
					  case GauceDataRow.TB_JOB_UPDATE:
						  //StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
					        StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
						    cstmt = conn.prepareCall(arr_sql[1].toString());
						
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
							cstmt.setString(2, rows[i].getString(colNm_DOC_GRD));
							cstmt.setString(3, rows[i].getString(colNm_DOC_FRM));
							cstmt.setString(4, rows[i].getString(colNm_DOC_TLE));
							cstmt.setString(5, rows[i].getString(colNm_DOC_CTS));
							cstmt.setString(6, rows[i].getString(colNm_DOC_KWD));
							cstmt.setString(7, rows[i].getString(colNm_FLE_DRC));
							cstmt.setString(8, rows[i].getString(colNm_RAL_DRC));
							cstmt.setString(9, rows[i].getString(colNm_FLE_NM));
							cstmt.setString(10, rows[i].getString(colNm_OWN_DPT));
							cstmt.setString(11, rows[i].getString(colNm_PRD_DPT));
							cstmt.setString(12, rows[i].getString(colNm_PRD_PSN));
							cstmt.setString(13, rows[i].getString(colNm_PRD_DT));
							cstmt.setString(14, rows[i].getString(colNm_PRS_YR_LMT));
							cstmt.setString(15, rows[i].getString(colNm_DOC_SGN_STS));
							cstmt.setString(16, rows[i].getString(colNm_CRT_DIV));
							cstmt.setString(17, rows[i].getString(colNm_USE_YN));
							cstmt.setString(18, rows[i].getString(colNm_DUS_DT));
							cstmt.setInt(19, rows[i].getInt(colNm_ORG_MGN_NO));
							cstmt.setInt(20, rows[i].getInt(colNm_RCP_RDG_SID));
							cstmt.setString(21, rows[i].getString(colNm_RCP_STS));
						    cstmt.setString(22, rows[i].getString(colNm_SND_DIV));
						    cstmt.setString(23, rows[i].getString(colNm_RCP_DPT));
					        cstmt.setString(24, rows[i].getString(colNm_RCP_DT));
							cstmt.setString(25, iParamEmpno);
							cstmt.setString(26, iParamIp);
							cstmt.setString(27, "1");		
										
						   cstmt.executeUpdate();
			
						   if(cstmt!=null) cstmt.close();	
						   break;
					  case GauceDataRow.TB_JOB_DELETE:
					        StringUtil.printMsg("TB_JOB_DELETE::",rows[i].getJobType(),this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
								
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
							cstmt.setString(2, rows[i].getString(colNm_DOC_GRD));
							cstmt.setString(3, rows[i].getString(colNm_DOC_FRM));
							cstmt.setString(4, rows[i].getString(colNm_DOC_TLE));
							cstmt.setString(5, rows[i].getString(colNm_DOC_CTS));
							cstmt.setString(6, rows[i].getString(colNm_DOC_KWD));
							cstmt.setString(7, rows[i].getString(colNm_FLE_DRC));
							cstmt.setString(8, rows[i].getString(colNm_RAL_DRC));
							cstmt.setString(9, rows[i].getString(colNm_FLE_NM));
							cstmt.setString(10, rows[i].getString(colNm_OWN_DPT));
							cstmt.setString(11, rows[i].getString(colNm_PRD_DPT));
							cstmt.setString(12, rows[i].getString(colNm_PRD_PSN));
							cstmt.setString(13, rows[i].getString(colNm_PRD_DT));
							cstmt.setString(14, rows[i].getString(colNm_PRS_YR_LMT));
							cstmt.setString(15, rows[i].getString(colNm_DOC_SGN_STS));
							cstmt.setString(16, rows[i].getString(colNm_CRT_DIV));
							cstmt.setString(17, rows[i].getString(colNm_USE_YN));
							cstmt.setString(18, rows[i].getString(colNm_DUS_DT));
							cstmt.setInt(19, rows[i].getInt(colNm_ORG_MGN_NO));
					        cstmt.setInt(20, rows[i].getInt(colNm_RCP_RDG_SID));
				      	    cstmt.setString(21, rows[i].getString(colNm_RCP_STS));
				            cstmt.setString(22, rows[i].getString(colNm_SND_DIV));
				            cstmt.setString(23, rows[i].getString(colNm_RCP_DPT));
					        cstmt.setString(24, rows[i].getString(colNm_RCP_DT));
							cstmt.setString(25, iParamEmpno);
							cstmt.setString(26, iParamIp);
							cstmt.setString(27, "2");							
								
							cstmt.executeUpdate();
			
						  if(cstmt!=null) cstmt.close();	
						  break;						
				  }//switch(rows[i].getJobType()){
			  }
		  }//if (ds1 != null) {
	
	  } catch (SQLException sqle){
		  throw sqle;
	  } catch (Exception e) {
		  throw e;
	  } finally {
		  //msgDS.flush();
		  if(rs!=null) rs.close();
//					  if(stmt!=null) stmt.close();			
		  if(cstmt!=null) cstmt.close();
		  //if( fail == true ) throw new Exception("");			
	  }
		
	}
}