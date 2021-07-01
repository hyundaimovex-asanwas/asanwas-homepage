package pms.news.itm;

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

public class Itm020 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
				//default 조회 
				arr_sql[0].append ("{call PMS.PR_NEW_ITM020S_01(?) }" );
				
				
				//ds_detail 조회
				arr_sql[1].append ("{call PMS.PR_NEW_ITM020S_02(?,?,?)}");

				
				//ds_detail 저장
				arr_sql[2].append ("{call PMS.PR_NEW_ITM020S_03(?,?,?,?,?,?,?,?,?) }");

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


            for(int i=0; i<dSets.length;i++){
            	
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);	
            	
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	
            	//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
            	
            	if(dSets[i].getName().equals("ds_item_m")){
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_M");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
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

		String v_overValue1 	= HDUtil.nullCheckStr(greq.getParameter("v_overValue1"));	//code
		String v_overValue2 	= HDUtil.nullCheckStr(greq.getParameter("v_overValue2"));	//tree level	

		//int v_overValue0 = Integer.parseInt(v_overValue2) + 1;
		//String v_overValue3 = v_overValue0.toString;
		
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            	
            	
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default
            	
            	
            	if(dSets[i].getName().equals("ds_item_d")){
            	
					GauceDataSet ds1 = gis.read("DS_ITEM_D");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_overValue1);
					cstmt.setString(2, v_overValue2);	
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					

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
	
		StringUtil.printMsg("# Command","저장",this);
		CallableStatement 		cstmt 		= null;	
		GauceStatement 			stmt 		= null;
		ResultSet 				rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        // (ds_default.IsUpdated || ds_gr_lic.IsUpdated) {
        GauceDataSet ds_item_d = gis.read("DS_ITEM_D");
        GauceDataSet ds_gr_lic = gis.read("DS_GR_LIC");

        StringUtil.printMsg("# Command","저장2",this);
		
		try{
			if (ds_item_d != null) {
				
				GauceDataRow[] 		rows = ds_item_d.getDataRows();
				
				int colNm_CD_ITEM		= ds_item_d.indexOfColumn("CD_ITEM");                    
				int colNm_CD_BIG        = ds_item_d.indexOfColumn("CD_BIG");          
				int colNm_CD_MID		= ds_item_d.indexOfColumn("CD_MID");
				int colNm_CD_SMALL    	= ds_item_d.indexOfColumn("CD_SMALL");   
				int colNm_DS_KSITEM     = ds_item_d.indexOfColumn("DS_KSITEM");           
				int colNm_AMT_ITEM      = ds_item_d.indexOfColumn("AMT_ITEM");         
				int colNm_TREE_LEVEL    = ds_item_d.indexOfColumn("TREE_LEVEL");    
  
				
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_default "+i+"행 작업===",rows[i].getJobType(),this);
					//가우스 행 JobType : 2=insert, 3=update, 4=delete
					
					StringUtil.printMsg("colNm_CD_ITEM",rows[i].getString(colNm_CD_ITEM),this);
					StringUtil.printMsg("colNm_CD_BIG",rows[i].getString(colNm_CD_BIG),this);
					StringUtil.printMsg("colNm_CD_MID",rows[i].getString(colNm_CD_MID),this);
					StringUtil.printMsg("colNm_CD_SMALL",rows[i].getString(colNm_CD_SMALL),this);
					StringUtil.printMsg("colNm_DS_KSITEM",rows[i].getString(colNm_DS_KSITEM),this);
					StringUtil.printMsg("colNm_AMT_ITEM",rows[i].getString(colNm_AMT_ITEM),this);
					StringUtil.printMsg("colNm_TREE_LEVEL",rows[i].getString(colNm_TREE_LEVEL),this);					
					StringUtil.printMsg("jobtype",rows[i].getJobType(),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					
					
					cstmt = conn.prepareCall(arr_sql[2].toString());

					cstmt.setString(1, rows[i].getString(colNm_CD_ITEM));
					cstmt.setString(2, rows[i].getString(colNm_CD_BIG));	
					cstmt.setString(3, rows[i].getString(colNm_CD_MID));	
					cstmt.setString(4, rows[i].getString(colNm_CD_SMALL));
					cstmt.setString(5, rows[i].getString(colNm_DS_KSITEM));	
					cstmt.setString(6, rows[i].getString(colNm_AMT_ITEM));			
					cstmt.setString(7, rows[i].getString(colNm_TREE_LEVEL));
					cstmt.setInt(8, rows[i].getJobType() );	//가우스행 작업 값
					cstmt.setString(9, iParamEmpno);
					
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

			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		
		}
	}
}