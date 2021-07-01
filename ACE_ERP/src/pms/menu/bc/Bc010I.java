package pms.menu.bc;

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

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Bc010I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
				//	default 조회
				arr_sql[0].append ("{call PMS.PR_BC010I_01(?,?,?,?,?, ?,?,?,?,? ) }" );
				//	ds_credit 조회
				arr_sql[1].append ("{call PMS.PR_BC010I_11(?,?)}");
				// ds_cashflow 조회
				arr_sql[2].append ("{call PMS.PR_BC010I_21(?,?)}");
				// ds_lic 조회
				arr_sql[3].append ("{call PMS.PR_BC010I_31(?,?)}");
				//	default 저장
				arr_sql[4].append ("{call PMS.PR_BC010I_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?) }" );
				// ds_gr_credit 저장
				arr_sql[5].append ("{call PMS.PR_BC010I_12(?,?,?,?,? ) }");
				// ds_gr_cashflow 저장
				arr_sql[6].append ("{call PMS.PR_BC010I_22(?,?,?,?,? ) }");
				// ds_gr_lic 저장
				arr_sql[7].append ("{call PMS.PR_BC010I_32(?,?,?,?,?,?) }");

   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

    		int v_bp_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_bp_sid"));			// 협력사
    		String v_in_cstr_kind 		= HDUtil.nullCheckStr(greq.getParameter("v_in_cstr_kind"));		// 상등록공종
    		String v_lic_kind 			= HDUtil.nullCheckStr(greq.getParameter("v_lic_kind"));			// 보유면허
    		String v_loc_place 			= HDUtil.nullCheckStr(greq.getParameter("v_loc_place"));		// 소재지
    		int v_cstr_eval_fee_fr 		= HDUtil.nullCheckNum(greq.getParameter("v_cstr_eval_fee_fr")); // 시평액 From
    		int v_cstr_eval_fee_to 		= HDUtil.nullCheckNum(greq.getParameter("v_cstr_eval_fee_to")); // 시평액 To
    		String v_credit_grd			= HDUtil.nullCheckStr(greq.getParameter("v_credit_grd")); 		// 신용등급
    		String v_cashflow_grd		= HDUtil.nullCheckStr(greq.getParameter("v_cashflow_grd")); 	// 현금흐름
    		String v_in_yn				= HDUtil.nullCheckStr(greq.getParameter("v_in_yn")); 			// 등록유무
    		//StringUtil.printMsg("v_bp_sid",v_bp_sid,this);
    		//StringUtil.printMsg("v_orderer_nm",v_orderer_nm,this);
    		
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.setString(2, v_in_cstr_kind);
					cstmt.setString(3, v_lic_kind);
					cstmt.setString(4, v_loc_place);
					cstmt.setInt(5, v_cstr_eval_fee_fr);
					cstmt.setInt(6, v_cstr_eval_fee_to);
					cstmt.setString(7, v_credit_grd);
					cstmt.setString(8, v_cashflow_grd);
					cstmt.setString(9, v_in_yn);
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
            	}
            	//JSP(O:DS_GR_CREDIT=ds_gr_credit,O:DS_GR_CASHFLOW=ds_gr_cashflow,O:DS_GR_LIC=ds_gr_lic)
            	if(dSets[i].getName().equals("ds_gr_credit")){
					GauceDataSet ds1 = gis.read("DS_GR_CREDIT");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();	//실행
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_gr_cashflow")){
					GauceDataSet ds1 = gis.read("DS_GR_CASHFLOW");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();	//실행
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_gr_lic")){
					GauceDataSet ds1 = gis.read("DS_GR_LIC");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();	//실행
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}  		


            	
			}
		}catch (SQLException sqle){
		} catch (Exception e){
		} finally {
		}
	}
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_bp_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_bp_sid"));			// 협력사
		String v_in_cstr_kind 		= HDUtil.nullCheckStr(greq.getParameter("v_in_cstr_kind"));		// 상등록공종
		String v_lic_kind 			= HDUtil.nullCheckStr(greq.getParameter("v_lic_kind"));			// 보유면허
		String v_loc_place 			= HDUtil.nullCheckStr(greq.getParameter("v_loc_place"));		// 소재지
		int v_cstr_eval_fee_fr 		= HDUtil.nullCheckNum(greq.getParameter("v_cstr_eval_fee_fr")); // 시평액 From
		int v_cstr_eval_fee_to 		= HDUtil.nullCheckNum(greq.getParameter("v_cstr_eval_fee_to")); // 시평액 To
		String v_credit_grd			= HDUtil.nullCheckStr(greq.getParameter("v_credit_grd")); 		// 신용등급
		String v_cashflow_grd		= HDUtil.nullCheckStr(greq.getParameter("v_cashflow_grd")); 	// 현금흐름
		String v_in_yn				= HDUtil.nullCheckStr(greq.getParameter("v_in_yn")); 			// 등록유무
		
		//StringUtil.printMsg("v_bp_sid",v_bp_sid,this);
		//StringUtil.printMsg("v_cstr_eval_fee_fr",v_cstr_eval_fee_fr,this);
		//StringUtil.printMsg("v_cstr_eval_fee_to",v_cstr_eval_fee_to,this);
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
            
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.setString(2, v_in_cstr_kind);
					cstmt.setString(3, v_lic_kind);
					cstmt.setString(4, v_loc_place);
					cstmt.setInt(5, v_cstr_eval_fee_fr);
					cstmt.setInt(6, v_cstr_eval_fee_to);
					cstmt.setString(7, v_credit_grd);
					cstmt.setString(8, v_cashflow_grd);
					cstmt.setString(9, v_in_yn);
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
            	}
            	//JSP(O:DS_GR_CREDIT=ds_gr_credit,O:DS_GR_CASHFLOW=ds_gr_cashflow,O:DS_GR_LIC=ds_gr_lic)
            	if(dSets[i].getName().equals("ds_gr_credit")){
					GauceDataSet ds1 = gis.read("DS_GR_CREDIT");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();	//실행
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_gr_cashflow")){
					GauceDataSet ds1 = gis.read("DS_GR_CASHFLOW");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();	//실행
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_gr_lic")){
					GauceDataSet ds1 = gis.read("DS_GR_LIC");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();	//실행
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
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	
		/* 2013.10.22 심동현
		 * 이렇게 TR을 호출합니다. 
		 * 		 * "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		 * 	따라서 gis.read로 가져오면 됨.
		 * 
		 * */
	
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        // (ds_default.IsUpdated || ds_gr_lic.IsUpdated || ds_gr_credit.IsUpdated || ds_gr_cashflow.IsUpdated) {
        GauceDataSet ds_default = gis.read("DS_DEFAULT");
        GauceDataSet ds_gr_lic = gis.read("DS_GR_LIC");
        GauceDataSet ds_gr_credit = gis.read("DS_GR_CREDIT");
        GauceDataSet ds_gr_cashflow = gis.read("DS_GR_CASHFLOW");
		
		
		try{
			if (ds_default != null) {
				GauceDataRow[] 		rows = ds_default.getDataRows();
				
				int colNm_bp_sid		= ds_default.indexOfColumn("bp_sid");                    
				int colNm_bp_cd         = ds_default.indexOfColumn("bp_cd");          
				int colNm_in_cstr_kind	= ds_default.indexOfColumn("in_cstr_kind");
				int colNm_bizregi_no    = ds_default.indexOfColumn("bizregi_no");   
				int colNm_in_yn         = ds_default.indexOfColumn("in_yn");           
				int colNm_bp_nm         = ds_default.indexOfColumn("bp_nm");        
				int colNm_exc_man      	= ds_default.indexOfColumn("exc_man");      
				int colNm_built_date    = ds_default.indexOfColumn("built_date");    
				int colNm_loc_place    	= ds_default.indexOfColumn("loc_place");     
				int colNm_phone_no     	= ds_default.indexOfColumn("phone_no");    
				int colNm_fax_no        = ds_default.indexOfColumn("fax_no");         
				int colNm_rcmd_man   	= ds_default.indexOfColumn("rcmd_man");   
				int colNm_in_date       = ds_default.indexOfColumn("in_date");        
				int colNm_remark        = ds_default.indexOfColumn("remark");        

				
				
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_default "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					/*
					StringUtil.printMsg("colNm_bp_sid",rows[i].getInt(colNm_bp_sid),this);
					StringUtil.printMsg("colNm_bp_cd",rows[i].getString(colNm_bp_cd),this);
					StringUtil.printMsg("colNm_in_cstr_kind",rows[i].getString(colNm_in_cstr_kind),this);
					StringUtil.printMsg("colNm_bizregi_no",rows[i].getString(colNm_bizregi_no),this);
					StringUtil.printMsg("colNm_in_yn",rows[i].getString(colNm_in_yn),this);
					StringUtil.printMsg("colNm_bp_nm",rows[i].getString(colNm_bp_nm),this);
					StringUtil.printMsg("colNm_exc_man",rows[i].getString(colNm_exc_man),this);
					StringUtil.printMsg("colNm_built_date",rows[i].getString(colNm_built_date),this);
					StringUtil.printMsg("colNm_loc_place",rows[i].getString(colNm_loc_place),this);
					StringUtil.printMsg("colNm_phone_no",rows[i].getString(colNm_phone_no),this);
					StringUtil.printMsg("colNm_fax_no",rows[i].getString(colNm_fax_no),this);
					StringUtil.printMsg("colNm_rcmd_man",rows[i].getString(colNm_rcmd_man),this);
					StringUtil.printMsg("colNm_in_date",rows[i].getString(colNm_in_date),this);
					StringUtil.printMsg("colNm_remark",rows[i].getString(colNm_remark),this);
					StringUtil.printMsg("jobtype",rows[i].getJobType(),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);*/
					
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_bp_sid));
					cstmt.setString(2, rows[i].getString(colNm_bp_cd));
					cstmt.setString(3, rows[i].getString(colNm_in_cstr_kind));	
					cstmt.setString(4, rows[i].getString(colNm_bizregi_no));	
					cstmt.setString(5, rows[i].getString(colNm_in_yn));
					cstmt.setString(6, rows[i].getString(colNm_bp_nm));	
					cstmt.setString(7, rows[i].getString(colNm_exc_man));		
					cstmt.setString(8, rows[i].getString(colNm_built_date));	
					cstmt.setString(9, rows[i].getString(colNm_loc_place));
					cstmt.setString(10, rows[i].getString(colNm_phone_no));	
					cstmt.setString(11, rows[i].getString(colNm_fax_no));
					cstmt.setString(12, rows[i].getString(colNm_rcmd_man));
					cstmt.setString(13, rows[i].getString(colNm_in_date));
					cstmt.setString(14, rows[i].getString(colNm_remark));	
					cstmt.setInt(15, rows[i].getJobType() );	//가우스행 작업 값
					cstmt.setString(16, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
						
				}
			}
			if (ds_gr_credit != null) {
				GauceDataRow[] 		rows = ds_gr_credit.getDataRows();
				
				int colNm_bp_sid					= ds_gr_credit.indexOfColumn("bp_sid");
				int colNm_bp_yymm					= ds_gr_credit.indexOfColumn("bp_yymm");
				int colNm_credit_grd				= ds_gr_credit.indexOfColumn("credit_grd");
				
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_gr_credit의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JoibType : 2=insert, 3=update, 4=delete
					
					cstmt = conn.prepareCall(arr_sql[5].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_bp_sid));
					cstmt.setString(2, rows[i].getString(colNm_bp_yymm));		//연도
					cstmt.setString(3, rows[i].getString(colNm_credit_grd));	//신용등급
					cstmt.setInt(4, rows[i].getJobType());	//가우스행 작업 값
					cstmt.setString(5, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
			
				}
			}
			if (ds_gr_cashflow != null) {
				GauceDataRow[] 		rows = ds_gr_cashflow.getDataRows();
				
				int colNm_bp_sid					= ds_gr_cashflow.indexOfColumn("bp_sid");
				int colNm_bp_yymm					= ds_gr_cashflow.indexOfColumn("bp_yymm");
				int colNm_cashflow_grd				= ds_gr_cashflow.indexOfColumn("cashflow_grd");
				
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_gr_cashflow의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JoibType : 2=insert, 3=update, 4=delete
					
					cstmt = conn.prepareCall(arr_sql[6].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_bp_sid));
					cstmt.setString(2, rows[i].getString(colNm_bp_yymm));		//연도
					cstmt.setString(3, rows[i].getString(colNm_cashflow_grd));	//신용등급
					cstmt.setInt(4, rows[i].getJobType());	//가우스행 작업 값
					cstmt.setString(5, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
				}
			}			
			if (ds_gr_lic != null) {
				GauceDataRow[] 		rows = ds_gr_lic.getDataRows();
				
				int colNm_bp_sid					= ds_gr_lic.indexOfColumn("bp_sid");
				int colNm_seq						= ds_gr_lic.indexOfColumn("seq");
				int colNm_lic_kind	  		        = ds_gr_lic.indexOfColumn("lic_kind");
				int colNm_cstr_eval_fee	            = ds_gr_lic.indexOfColumn("cstr_eval_fee");
				
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				int j=1;
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_gr_lic의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JoibType : 2=insert, 3=update, 4=delete
					
					
					cstmt = conn.prepareCall(arr_sql[7].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_bp_sid));
						if(4==rows[i].getJobType()){
							cstmt.setInt(2, rows[i].getInt(colNm_seq));	//순서(삭제시)

							//StringUtil.printMsg("colNm_seq",rows[i].getString(colNm_seq),this);
							//StringUtil.printMsg("colNm_lic_kind",rows[i].getString(colNm_lic_kind),this);
							//StringUtil.printMsg("colNm_cstr_eval_fee",rows[i].getString(colNm_cstr_eval_fee),this);
						}
						if(2==rows[i].getJobType()){
							cstmt.setInt(2, j );	//순서(저장시)
							//StringUtil.printMsg("colNm_seq",j,this);
							//StringUtil.printMsg("colNm_lic_kind",rows[i].getString(colNm_lic_kind),this);
							//StringUtil.printMsg("colNm_cstr_eval_fee",rows[i].getString(colNm_cstr_eval_fee),this);
							j++;
						}
					cstmt.setString(3, rows[i].getString(colNm_lic_kind));		//면허코드
					cstmt.setInt(4, rows[i].getInt(colNm_cstr_eval_fee));	//시평액
					cstmt.setInt(5, rows[i].getJobType());	//가우스행 작업 값
					cstmt.setString(6, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
		
				}
			}

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