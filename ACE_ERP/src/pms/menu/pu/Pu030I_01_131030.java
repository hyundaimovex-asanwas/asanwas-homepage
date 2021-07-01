package pms.menu.pu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.db.GauceStatement;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Pu030I_01_131030 extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//트리조회
		arr_sql[0].append ("{call PMS.PR_PU030I_01()}");
		//자재상세조회_트리
		arr_sql[1].append ("{call PMS.PR_PU030I_02(?)}");
		//		자재상세조회_조회검색
		arr_sql[2].append ("{call PMS.PR_PU030I_04(?)}");
		
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
				ResultSet rs = null;
		
				GauceDataSet ds1 = null;
				GauceDataSet ds2 = null;
		
				try {
					Iterator it = req.getGauceDataSetKeys();
					while(it.hasNext()){
						String gauceName = (String)it.next();
						ds1 = req.getGauceDataSet(gauceName);
						if(ds1!=null){
							res.enableFirstRow(ds1);
							//System.out.println("v_job_sel======>"+v_job_sel);
							if(gauceName.equals("DS1")){
								cstmt = conn.prepareCall(arr_sql[0].toString()); 
							rs = cstmt.executeQuery();
							getDataSet(rs, ds1).flush();
							}//if(ds1!=null)the end...
						}//while(it.hasNext()) The end...
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

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceDataSet ds1 = null;
		GauceDataSet ds2 = null;
		
		String v_item_nm 	= HDUtil.nullCheckStr(req.getParameter("v_item_nm"));
		
			try {
				Iterator it = req.getGauceDataSetKeys();
				while(it.hasNext()){
					String gauceName = (String)it.next();
					StringUtil.printMsg("gauceName",gauceName,this);
					ds1 = req.getGauceDataSet(gauceName);
					if(ds1!=null){
						res.enableFirstRow(ds1);
						//System.out.println("v_job_sel======>"+v_job_sel);
						if(gauceName.equals("DS1")){
							cstmt = conn.prepareCall(arr_sql[1].toString()); 
							cstmt.setString(1, v_item_nm);
						}
						if(gauceName.equals("DS2")){
							cstmt = conn.prepareCall(arr_sql[2].toString()); 
							cstmt.setString(1, v_item_nm);
						}
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
						}//if(ds1!=null)the end...
					}//while(it.hasNext()) The end...
			} catch (SQLException sqle){
			    throw sqle;
			} catch (Exception e) {
			    throw e;
			} finally {
			    if(rs!=null) rs.close();
			    if(cstmt!=null) cstmt.close();
			}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {		
				StringUtil.printMsg("# Command","저장",this);
				GauceDataSet inputDs = req.getGauceDataSet("DS2");
				CallableStatement cstmt = null;		
				GauceStatement stmt = null;		
				String reqNo="";
				ResultSet rs = null;
				boolean fail=false;
	
				/** 
				 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
				 **/
				String iParamEmpno = fParamEmpno;
				String iParamIp = fParamIp;

				try{
					if(inputDs!=null){
                
						int colNm_ITEM_NM   	              = inputDs.indexOfColumn("ITEM_NM");
						int colNm_ITEM_SIZE   	          = inputDs.indexOfColumn("ITEM_SIZE");
						int colNm_ITEM_UNIT       	      = inputDs.indexOfColumn("ITEM_UNIT");
						int colNm_TEM_KIND            	  = inputDs.indexOfColumn("ITEM_KIND");				
						int colNm_CODE_NO              	  = inputDs.indexOfColumn("CODE_NO");
						int colNm_ITEM_SID              	  = inputDs.indexOfColumn("ITEM_SID");
						GauceDataRow[] 		rows = inputDs.getDataRows();
						GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
						for(int i=0; i<rows.length; i++){
							int j=1;
							switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_INSERT:
								/*
								StringUtil.printMsg("call","SALES.PR_RV510i_02-INSERT",this);
								StringUtil.printMsg("colNm_ITEM_NM",rows[i].getString(colNm_ITEM_NM),this);
								StringUtil.printMsg("colNm_ITEM_SIZE",rows[i].getString(colNm_ITEM_SIZE),this);
								StringUtil.printMsg("colNm_ITEM_UNIT",rows[i].getString(colNm_ITEM_UNIT),this);
								StringUtil.printMsg("colNm_TEM_KIND",rows[i].getString(colNm_TEM_KIND),this);
								StringUtil.printMsg("colNm_CODE_NO",rows[i].getString(colNm_CODE_NO),this);
								StringUtil.printMsg("colNm_ITEM_SID",rows[i].getString(colNm_ITEM_SID),this);
								*/
						 						
								cstmt = conn.prepareCall("{call PMS.PR_PU030i_03(?,?,?,?,?      ,?,?,?) }");
						
								cstmt.setString(1, rows[i].getString(colNm_ITEM_NM));
								cstmt.setString(2, rows[i].getString(colNm_ITEM_SIZE));						
								cstmt.setString(3, rows[i].getString(colNm_ITEM_UNIT));
								cstmt.setString(4, rows[i].getString(colNm_TEM_KIND));
								cstmt.setString(5, rows[i].getString(colNm_CODE_NO));
								cstmt.setString(6, iParamEmpno);
								cstmt.setString(7, "1");
								cstmt.setInt(8, rows[i].getInt(colNm_ITEM_SID));
								
								cstmt.executeUpdate();
						
								if(cstmt!=null) cstmt.close();						
								break;
								
							case GauceDataRow.TB_JOB_UPDATE:
								/*
								StringUtil.printMsg("call","SALES.PR_RV510i_02-UPDATE",this);
								StringUtil.printMsg("call","SALES.PR_RV510i_02-TB_JOB_UPDATE",this);
								StringUtil.printMsg("colNm_ITEM_NM",rows[i].getString(colNm_ITEM_NM),this);
								StringUtil.printMsg("colNm_ITEM_SIZE",rows[i].getString(colNm_ITEM_SIZE),this);
								StringUtil.printMsg("colNm_ITEM_UNIT",rows[i].getString(colNm_ITEM_UNIT),this);
								StringUtil.printMsg("colNm_TEM_KIND",rows[i].getString(colNm_TEM_KIND),this);
								StringUtil.printMsg("colNm_CODE_NO",rows[i].getString(colNm_CODE_NO),this);
								StringUtil.printMsg("colNm_ITEM_SID",rows[i].getString(colNm_ITEM_SID),this);
								*/
								cstmt = conn.prepareCall("{call PMS.PR_PU030i_03(?,?,?,?,?      ,?,?,?) }");
						
								cstmt.setString(1, rows[i].getString(colNm_ITEM_NM));
								cstmt.setString(2, rows[i].getString(colNm_ITEM_SIZE));						
								cstmt.setString(3, rows[i].getString(colNm_ITEM_UNIT));
								cstmt.setString(4, rows[i].getString(colNm_TEM_KIND));
								cstmt.setString(5, rows[i].getString(colNm_CODE_NO));
								cstmt.setString(6, iParamEmpno);
								cstmt.setString(7, "3");
								cstmt.setInt(8, rows[i].getInt(colNm_ITEM_SID));
								
								cstmt.executeUpdate();
						
								if(cstmt!=null) cstmt.close();	
								break;
								
							case GauceDataRow.TB_JOB_DELETE:
								/*
								StringUtil.printMsg("call","SALES.PR_RV510i_02-DELETE",this);
								StringUtil.printMsg("call","SALES.PR_RV510i_02-TB_JOB_DELETE",this);
								StringUtil.printMsg("colNm_ITEM_NM",rows[i].getString(colNm_ITEM_NM),this);
								StringUtil.printMsg("colNm_ITEM_SIZE",rows[i].getString(colNm_ITEM_SIZE),this);
								StringUtil.printMsg("colNm_ITEM_UNIT",rows[i].getString(colNm_ITEM_UNIT),this);
								StringUtil.printMsg("colNm_TEM_KIND",rows[i].getString(colNm_TEM_KIND),this);
								StringUtil.printMsg("colNm_CODE_NO",rows[i].getString(colNm_CODE_NO),this);
								StringUtil.printMsg("colNm_ITEM_SID",rows[i].getString(colNm_ITEM_SID),this);
								*/
								
								cstmt = conn.prepareCall("{call PMS.PR_PU030i_03(?,?,?,?,?      ,?,?,?) }");
						
								cstmt.setString(1, rows[i].getString(colNm_ITEM_NM));
								cstmt.setString(2, rows[i].getString(colNm_ITEM_SIZE));						
								cstmt.setString(3, rows[i].getString(colNm_ITEM_UNIT));
								cstmt.setString(4, rows[i].getString(colNm_TEM_KIND));
								cstmt.setString(5, rows[i].getString(colNm_CODE_NO));
								cstmt.setString(6, iParamEmpno);
								cstmt.setString(7, "2");
								cstmt.setInt(8, rows[i].getInt(colNm_ITEM_SID));
						
								cstmt.executeUpdate();
						
								if(cstmt!=null) cstmt.close();	
								break;						
							}
						}
					}
				} catch (SQLException sqle){
					throw sqle;
				} catch (Exception e) {
					throw e;
				} finally {
				
					if(rs!=null) rs.close();
					if(stmt!=null) stmt.close();			
					if(cstmt!=null) cstmt.close();
					if( fail == true ) throw new Exception("");			
				}
			}
}
