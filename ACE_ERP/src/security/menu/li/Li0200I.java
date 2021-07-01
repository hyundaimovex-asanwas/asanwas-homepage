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

public class Li0200I extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//기등록문서  조회
		arr_sql[0].append ("{call SECURITY.PR_LI0200S_01(?,?,?,?,?,?) }" );
		
        //배포정보 조회 
		arr_sql[2].append ("{call SECURITY.PR_LI0200S_02(?) }" );
		
		//배포상세 조회 
		arr_sql[3].append ("{call SECURITY.PR_LI0200S_03(?) }" );
		
		
		//배포정보 저장
		arr_sql[1].append ("{call SECURITY.PR_LI0200I_01(?,?,?,?,?,?,?,?,?) }");
        
        //배포상세 저장
	    arr_sql[4].append ("{call SECURITY.PR_LI0200I_02(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
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

					if(gauceName.equals("DS_DEFAULT")){              //문서정보 조회 
						cstmt = conn.prepareCall(arr_sql[0].toString());
						
						String v_doc_grd		= HDUtil.nullCheckStr(req.getParameter("v_doc_grd")); 		// 문서등급
						String v_doc_frm		= HDUtil.nullCheckStr(req.getParameter("v_doc_frm")); 		// 문서형태
						String v_own_dpt		= HDUtil.nullCheckStr(req.getParameter("v_gdeptcd")); 		// 소유부서
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
						cstmt.setString(3, v_own_dpt);
						cstmt.setString(4, v_doc_tle);
						cstmt.setString(5, v_doc_cts);
						cstmt.setString(6, v_doc_kwd);
	
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					
					}else if (gauceName.equals("DS_DEFAULT2")){     //배포정보조회 
						cstmt = conn.prepareCall(arr_sql[2].toString());		
						
						StringUtil.printMsg("v_doc_mag_sid::t","START",this);		
						
						int v_doc_mag_sid = HDUtil.nullCheckNum(req.getParameter("v_doc_mag_sid"));	//등록번호		
					
						//StringUtil.printMsg("v_doc_mag_sid::t",v_doc_mag_sid,this);
						
						StringUtil.printMsg("v_doc_mag_sid::t","END",this);
						
						cstmt.setInt(1, v_doc_mag_sid);
						
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
						
					}else if (gauceName.equals("DS_DEFAULT3")){    //배포상세조회
						cstmt = conn.prepareCall(arr_sql[3].toString());		
	
						int v_dtb_mag_sid = HDUtil.nullCheckNum(req.getParameter("v_dtb_mag_sid"));	//등록번호		

						StringUtil.printMsg("v_dtb_mag_sid::t",v_dtb_mag_sid,this);
						
						//StringUtil.printMsg("v_doc_mag_sid::t","END",this);
						
						cstmt.setInt(1, v_dtb_mag_sid);
	
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
	  GauceDataSet ds2 = req.getGauceDataSet("DS_DEFAULT2");
	  GauceDataSet ds3 = req.getGauceDataSet("DS_DEFAULT3");
	 
	  try{
		  if (ds2 != null) {
			  StringUtil.printMsg("ds2","ds2",this);
			  
			  GauceDataRow[] 		rows = ds2.getDataRows();
			  GauceDataColumn[] 	cols = ds2.getDataColumns();
			
			    int colNm_DOC_MAG_SID      = ds2.indexOfColumn("DOC_MAG_SID");  //
				int colNm_SND_DIV               = ds2.indexOfColumn("SND_DIV");      //
				int colNm_DTB_CNT              = ds2.indexOfColumn("DTB_CNT");	  //
				int colNm_DTB_DT                = ds2.indexOfColumn("DTB_DT");	  //
				int colNm_TNS_WAY             = ds2.indexOfColumn("TNS_WAY");	  //
				int colNm_TNS_RSN             = ds2.indexOfColumn("TNS_RSN");	  //
	
				
			  //StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);

			  for(int i=0; i<rows.length; i++){
				  int j=1;
				  switch(rows[i].getJobType()){
					  case GauceDataRow.TB_JOB_INSERT:
				   	  
					        StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);
						 	cstmt = conn.prepareCall(arr_sql[1].toString());
						    cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
						    cstmt.setString(2, rows[i].getString(colNm_SND_DIV));   
					        cstmt.setInt(3, rows[i].getInt(colNm_DTB_CNT));
							cstmt.setString(4, rows[i].getString(colNm_DTB_DT));
							cstmt.setString(5, rows[i].getString(colNm_TNS_WAY));
							cstmt.setString(6, rows[i].getString(colNm_TNS_RSN));
					        cstmt.setString(7, iParamEmpno);
							cstmt.setString(8, iParamIp);
							cstmt.setString(9, "1");							

						    cstmt.executeUpdate();
			
						    if(cstmt!=null) cstmt.close();		
						
						    break;
					  case GauceDataRow.TB_JOB_UPDATE:
						  //StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
					        StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
						    cstmt = conn.prepareCall(arr_sql[1].toString());
						
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
							cstmt.setString(2, rows[i].getString(colNm_SND_DIV));   
							cstmt.setInt(3, rows[i].getInt(colNm_DTB_CNT));
							cstmt.setString(4, rows[i].getString(colNm_DTB_DT));
							cstmt.setString(5, rows[i].getString(colNm_TNS_WAY));
							cstmt.setString(6, rows[i].getString(colNm_TNS_RSN));
							cstmt.setString(7, iParamEmpno);
							cstmt.setString(8, iParamIp);
							cstmt.setString(9, "1");			
										
						   cstmt.executeUpdate();
			
						   if(cstmt!=null) cstmt.close();	
						   break;
					  case GauceDataRow.TB_JOB_DELETE:
					        StringUtil.printMsg("TB_JOB_DELETE::",rows[i].getJobType(),this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
								
							cstmt.setInt(1, rows[i].getInt(colNm_DOC_MAG_SID));
							cstmt.setString(2, rows[i].getString(colNm_SND_DIV));   
							cstmt.setInt(3, rows[i].getInt(colNm_DTB_CNT));
							cstmt.setString(4, rows[i].getString(colNm_DTB_DT));
							cstmt.setString(5, rows[i].getString(colNm_TNS_WAY));
							cstmt.setString(6, rows[i].getString(colNm_TNS_RSN));
							cstmt.setString(7, iParamEmpno);
							cstmt.setString(8, iParamIp);
							cstmt.setString(9, "2");				
								
							 cstmt.executeUpdate();
			
						  if(cstmt!=null) cstmt.close();	
						  break;						
				  }//switch(rows[i].getJobType()){
			  }
		  }//if (ds2 != null) {
		  
		  if (ds3 != null) {
					 StringUtil.printMsg("ds3","ds3",this);
			  
					 GauceDataRow[] 		rows = ds3.getDataRows();
					 GauceDataColumn[] 	cols = ds3.getDataColumns();
			
					   int colNm_DTB_MAG_SID        = ds3.indexOfColumn("DTB_MAG_SID");  //
			           int colNm_DTB_SEQ                = ds3.indexOfColumn("DTB_SEQ");  //
					   int colNm_RCP_DPT                = ds3.indexOfColumn("RCP_DPT");      //
					   int colNm_SGN_STS                = ds3.indexOfColumn("SGN_STS");	  //
					   int colNm_RCP_STS                = ds3.indexOfColumn("RCP_STS");	  //
					   int colNm_TNS_RCP_DST        = ds3.indexOfColumn("TNS_RCP_DST");	  //
					   int colNm_TNS_RCP_PSN        = ds3.indexOfColumn("TNS_RCP_PSN");	  //
					   int colNm_RCP_DT                  = ds3.indexOfColumn("RCP_DT");	  //
					   int colNm_RCP_PSN                = ds3.indexOfColumn("RCP_PSN");	  //
					   int colNm_DOC_MAG_SID        = ds3.indexOfColumn("DOC_MAG_SID");	  //
			           int colNm_RCP_RDG_SID        = ds3.indexOfColumn("RCP_RDG_SID");	  //
					   
				
					 //StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);

					 for(int i=0; i<rows.length; i++){
						 int j=1;
						 switch(rows[i].getJobType()){
							 case GauceDataRow.TB_JOB_INSERT:
				   	  
								    StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);
								    cstmt = conn.prepareCall(arr_sql[4].toString());
								    cstmt.setInt(1, rows[i].getInt(colNm_DTB_MAG_SID));
									cstmt.setInt(2, rows[i].getInt(colNm_DTB_SEQ));
									cstmt.setString(3, rows[i].getString(colNm_RCP_DPT));   
									cstmt.setString(4, rows[i].getString(colNm_SGN_STS));   
									cstmt.setString(5, rows[i].getString(colNm_RCP_STS));   
									cstmt.setString(6, rows[i].getString(colNm_TNS_RCP_DST));   
									cstmt.setString(7, rows[i].getString(colNm_TNS_RCP_PSN));   
									cstmt.setString(8, rows[i].getString(colNm_RCP_DT));   
									cstmt.setString(9, rows[i].getString(colNm_RCP_PSN));    
									cstmt.setInt(10, rows[i].getInt(colNm_DOC_MAG_SID));
						        	cstmt.setInt(11, rows[i].getInt(colNm_RCP_RDG_SID));
									cstmt.setString(12, iParamEmpno);
									cstmt.setString(13, iParamIp);
									cstmt.setString(14, "1");				
				

								   cstmt.executeUpdate();
			
								   if(cstmt!=null) cstmt.close();		
						
								   break;
							 case GauceDataRow.TB_JOB_UPDATE:
								 //StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
								   StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
									cstmt = conn.prepareCall(arr_sql[4].toString());
									 cstmt.setInt(1, rows[i].getInt(colNm_DTB_MAG_SID));
									 cstmt.setInt(2, rows[i].getInt(colNm_DTB_SEQ));
									 cstmt.setString(3, rows[i].getString(colNm_RCP_DPT));   
									 cstmt.setString(4, rows[i].getString(colNm_SGN_STS));   
									 cstmt.setString(5, rows[i].getString(colNm_RCP_STS));   
									 cstmt.setString(6, rows[i].getString(colNm_TNS_RCP_DST));   
									 cstmt.setString(7, rows[i].getString(colNm_TNS_RCP_PSN));   
									 cstmt.setString(8, rows[i].getString(colNm_RCP_DT));   
									 cstmt.setString(9, rows[i].getString(colNm_RCP_PSN));    
									 cstmt.setInt(10, rows[i].getInt(colNm_DOC_MAG_SID));
							         cstmt.setInt(11, rows[i].getInt(colNm_RCP_RDG_SID));
									 cstmt.setString(12, iParamEmpno);
									 cstmt.setString(13, iParamIp);
									 cstmt.setString(14, "3");			
										
								     cstmt.executeUpdate();
			
								  if(cstmt!=null) cstmt.close();	
								  break;
							 case GauceDataRow.TB_JOB_DELETE:
								   StringUtil.printMsg("TB_JOB_DELETE::",rows[i].getJobType(),this);
									cstmt = conn.prepareCall(arr_sql[4].toString());
									cstmt.setInt(1, rows[i].getInt(colNm_DTB_MAG_SID));
									cstmt.setInt(2, rows[i].getInt(colNm_DTB_SEQ));
									cstmt.setString(3, rows[i].getString(colNm_RCP_DPT));   
									cstmt.setString(4, rows[i].getString(colNm_SGN_STS));   
									cstmt.setString(5, rows[i].getString(colNm_RCP_STS));   
									cstmt.setString(6, rows[i].getString(colNm_TNS_RCP_DST));   
									cstmt.setString(7, rows[i].getString(colNm_TNS_RCP_PSN));   
									cstmt.setString(8, rows[i].getString(colNm_RCP_DT));   
									cstmt.setString(9, rows[i].getString(colNm_RCP_PSN));    
									cstmt.setInt(10, rows[i].getInt(colNm_DOC_MAG_SID));
						          	cstmt.setInt(11, rows[i].getInt(colNm_RCP_RDG_SID));
									cstmt.setString(12, iParamEmpno);
									cstmt.setString(13, iParamIp);
									cstmt.setString(14, "2");			
								
									cstmt.executeUpdate();
			
								 if(cstmt!=null) cstmt.close();	
								 break;						
						 }//switch(rows[i].getJobType()){
					 }
				 }//if (ds3 != null) {
	
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