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

public class Li0400I extends SuperServlet {

	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			
		//StringUtil.printMsg("start::","1",this);		

		//부서관리 조회  
		arr_sql[0].append ("{call SECURITY.PR_LI0400S_01(?) }" );
		
		//부서관리 저장 
		arr_sql[1].append ("{call SECURITY.PR_LI0400I_01(?,?,?,?,?,?,?,?,?,?,?) }");
		
		//부서매칭 조회 
	    arr_sql[2].append ("{call SECURITY.PR_LI0401S_01(?,?,?) }" );
	    
		//	부서매칭 저장 
		 arr_sql[3].append ("{call SECURITY.PR_LI0401I_01(?,?,?,?,?) }" );
        
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

					if(gauceName.equals("DS_DEFAULT")){              //
						cstmt = conn.prepareCall(arr_sql[0].toString());
						
						String v_wrk_div	= HDUtil.nullCheckStr(req.getParameter("v_wrk_div")); 		// 부서업무구분 
											
						/*
						StringUtil.printMsg("v_doc_grd::",v_doc_grd,this);
						StringUtil.printMsg("v_doc_frm::",v_doc_frm,this);
						StringUtil.printMsg("v_own_dpt::",v_own_dpt,this);
						StringUtil.printMsg("v_doc_tle::",v_doc_tle,this);
						StringUtil.printMsg("v_doc_cts::",v_doc_cts,this);
						StringUtil.printMsg("v_doc_kwd::",v_doc_kwd,this);				
						*/
						
						cstmt.setString(1, v_wrk_div);
						
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
									
				   }else if (gauceName.equals("DS_DEFAULT2")){
				   	
						cstmt = conn.prepareCall(arr_sql[2].toString());
							
						String v_deptcd	= HDUtil.nullCheckStr(req.getParameter("v_deptcd")); 		// 부서코드 
						String v_deptnm	= HDUtil.nullCheckStr(req.getParameter("v_deptnm")); 	// 부서명 
						String v_useyn  	= HDUtil.nullCheckStr(req.getParameter("v_useyn")); 		// 사용유무
						
						StringUtil.printMsg("v_deptcd::",v_deptcd,this);
												StringUtil.printMsg("v_deptnm::",v_deptnm,this);
												StringUtil.printMsg("v_useyn::",v_useyn,this);
												
						cstmt.setString(1, v_deptcd); 
						cstmt.setString(2, v_deptnm); 
						cstmt.setString(3, v_useyn);
						
		
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
	  GauceDataSet ds2 = req.getGauceDataSet("DS_DEFAULT2");
	                                                                     
	 
	  try{
		  if (ds1 != null) {
			  StringUtil.printMsg("ds1","ds1",this);
			  
			  GauceDataRow[] 		    rows = ds1.getDataRows();
			  GauceDataColumn[] 	cols = ds1.getDataColumns();
			
			  int colNm_WRK_DIV          = ds1.indexOfColumn("WRK_DIV");    
              int colNm_MAG_DPT_CD  = ds1.indexOfColumn("MAG_DPT_CD");    
              int colNm_MAG_DPT_NM  = ds1.indexOfColumn("MAG_DPT_NM");    
              int colNm_HIG_DPT_CD    = ds1.indexOfColumn("HIG_DPT_CD");    
              int colNm_DPT_LVL          = ds1.indexOfColumn("DPT_LVL");    
              int colNm_SRT_DT           = ds1.indexOfColumn("SRT_DT");    
              int colNm_END_DT           = ds1.indexOfColumn("END_DT");    
              int colNm_USE_YN           = ds1.indexOfColumn("USE_YN");    
				
			  StringUtil.printMsg("colNm_WRK_DIV",colNm_WRK_DIV,this);

			  for(int i=0; i<rows.length; i++){
				  int j=1;
				  switch(rows[i].getJobType()){
					  case GauceDataRow.TB_JOB_INSERT:
				   	  
					        //StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);
						 	cstmt = conn.prepareCall(arr_sql[1].toString());
						 	
							cstmt.setString(1, rows[i].getString(colNm_WRK_DIV));   
							cstmt.setString(2, rows[i].getString(colNm_MAG_DPT_CD));
							cstmt.setString(3, rows[i].getString(colNm_MAG_DPT_NM));
							cstmt.setString(4, rows[i].getString(colNm_HIG_DPT_CD));
							cstmt.setString(5, rows[i].getString(colNm_DPT_LVL));   
							cstmt.setString(6, rows[i].getString(colNm_SRT_DT));    
							cstmt.setString(7, rows[i].getString(colNm_END_DT));    
							cstmt.setString(8, rows[i].getString(colNm_USE_YN));    
					        cstmt.setString(9, iParamEmpno);
							cstmt.setString(10, iParamIp);
							cstmt.setString(11, "1");							

						    cstmt.executeUpdate();
			
						    if(cstmt!=null) cstmt.close();		
						
						    break;
					  case GauceDataRow.TB_JOB_UPDATE:
						  //StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
					       // StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
						    cstmt = conn.prepareCall(arr_sql[1].toString());
						
							cstmt.setString(1, rows[i].getString(colNm_WRK_DIV));   
							cstmt.setString(2, rows[i].getString(colNm_MAG_DPT_CD));
							cstmt.setString(3, rows[i].getString(colNm_MAG_DPT_NM));
							cstmt.setString(4, rows[i].getString(colNm_HIG_DPT_CD));
							cstmt.setString(5, rows[i].getString(colNm_DPT_LVL));   
							cstmt.setString(6, rows[i].getString(colNm_SRT_DT));    
							cstmt.setString(7, rows[i].getString(colNm_END_DT));    
							cstmt.setString(8, rows[i].getString(colNm_USE_YN));    
							cstmt.setString(9, iParamEmpno);
							cstmt.setString(10, iParamIp);
							cstmt.setString(11, "3");							
										
						   cstmt.executeUpdate();
			
						   if(cstmt!=null) cstmt.close();	
						   break;
					  case GauceDataRow.TB_JOB_DELETE:
					        //StringUtil.printMsg("TB_JOB_DELETE::",rows[i].getJobType(),this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
								
							cstmt.setString(1, rows[i].getString(colNm_WRK_DIV));   
							cstmt.setString(2, rows[i].getString(colNm_MAG_DPT_CD));
							cstmt.setString(3, rows[i].getString(colNm_MAG_DPT_NM));
							cstmt.setString(4, rows[i].getString(colNm_HIG_DPT_CD));
							cstmt.setString(5, rows[i].getString(colNm_DPT_LVL));   
							cstmt.setString(6, rows[i].getString(colNm_SRT_DT));    
							cstmt.setString(7, rows[i].getString(colNm_END_DT));    
							cstmt.setString(8, rows[i].getString(colNm_USE_YN));    
							cstmt.setString(9, iParamEmpno);
							cstmt.setString(10, iParamIp);
							cstmt.setString(11, "2");							
								
							cstmt.executeUpdate();
			
						  if(cstmt!=null) cstmt.close();	
						  break;						
				  }//switch(rows[i].getJobType()){
			  }
		  }//if (ds1 != null) {
		  
		if (ds2 != null) {
			 StringUtil.printMsg("ds2","ds2",this);
	  
			 GauceDataRow[] 		    rows = ds2.getDataRows();
			 GauceDataColumn[] 	    cols = ds2.getDataColumns();
	
			 int colNm_DEPTCD          = ds2.indexOfColumn("DEPTCD");    
			 int colNm_MAG_DPT_CD  = ds2.indexOfColumn("MAG_DPT_CD");    
		
			 //StringUtil.printMsg("colNm_DEPTCD",colNm_DEPTCD,this);
			 //StringUtil.printMsg("colNm_MAG_DPT_CD",colNm_MAG_DPT_CD,this);

			 for(int i=0; i<rows.length; i++){
				 int j=1;
				 switch(rows[i].getJobType()){
					 case GauceDataRow.TB_JOB_INSERT:
		   	  
						 break;
					 case GauceDataRow.TB_JOB_UPDATE:
						   //StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
						   cstmt = conn.prepareCall(arr_sql[3].toString());
				
						   cstmt.setString(1, rows[i].getString(colNm_DEPTCD));   
						   cstmt.setString(2, rows[i].getString(colNm_MAG_DPT_CD));
						   cstmt.setString(3, iParamEmpno);
						   cstmt.setString(4, iParamIp);
						   cstmt.setString(5, "3");							
								
						  cstmt.executeUpdate();
	
						  if(cstmt!=null) cstmt.close();	
						  break;
					 case GauceDataRow.TB_JOB_DELETE:
						  	
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