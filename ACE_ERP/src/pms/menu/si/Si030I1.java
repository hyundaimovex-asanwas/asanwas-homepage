package pms.menu.si;

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

public class Si030I1 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//마스터 조회
		arr_sql[0].append ("{call PMS.PR_SI030I_01(?,?,?,?,?,?) }" );

		//Main 저장
		arr_sql[1].append ("{call PMS.PR_SI030I_02(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,?)}" );
	
   }

	//init method
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","선조회",this);
    	//System.out.println("Si030I1 :; 선조회");
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		try {
			
			GauceInputStream gis = greq.getGauceInputStream();
	        GauceOutputStream gos = gres.getGauceOutputStream();
	        
	      //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
			//Iterator it = req.getGauceDataSetKeys();
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default
            	if(dSets[i].getName().equals("ds_default")){
            		
					   GauceDataSet ds1 = gis.read("DS_DEFAULT");
						//StringUtil.printMsg("DS DS_DEFAULT","선조회",this);
					   
					    //System.out.println("Si030I1 :; 선조회 :: DS_DEFAULT");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "080304");
						cstmt.setString(2, "2");
						cstmt.setString(3, "19990101");
						cstmt.setString(4, "19990101");   
						cstmt.setString(5, "6070001");   
						
						// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
						cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 					
						//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
						//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
						gos.write(getDataSet(rs, ds1));
					}         	
			}
		}catch (SQLException sqle){
			gres.addException(sqle);
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}

	}	
	
	//select method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
    	
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			    
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			 for(int i=0; i<dSets.length;i++){
					//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
	            	//O:DS_DEFAULT=ds_default
	            	if(dSets[i].getName().equals("ds_default")){
						GauceDataSet ds1 = gis.read("DS_DEFAULT");
						
						String v_cost_cd 	        = HDUtil.nullCheckStr(greq.getParameter("v_cost_cd")); 	    // 원가 
						String v_ingb_cd		    = HDUtil.nullCheckStr(greq.getParameter("v_ingb_cd")); 		// 입력구분
						String v_fr_inout_dt 	    = HDUtil.nullCheckStr(greq.getParameter("v_fr_inout_dt")); 	// 출납일자 시작
						String v_to_inout_dt	    = HDUtil.nullCheckStr(greq.getParameter("v_to_inout_dt")); 	// 출납일자 종료
						String v_empno	            = HDUtil.nullCheckStr(greq.getParameter("v_empno"));      	// 작성자 


						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, v_cost_cd);
						cstmt.setString(2, v_ingb_cd);
						cstmt.setString(3, v_fr_inout_dt);
						cstmt.setString(4, v_to_inout_dt);
						cstmt.setString(5, v_empno);
						
						// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
						cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						
						rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param.
						gos.write(getDataSet(rs, ds1));
						
					}
				
			}
	    }catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
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
		//GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
			
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");

//		int fSiteSid = 0;
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_TAXNBR         = ds1.indexOfColumn("TAXNBR");             //
				int colNm_COCODE        = ds1.indexOfColumn("COCODE");             //
				int colNm_DEPTCD         = ds1.indexOfColumn("DEPTCD");             //
				int colNm_EMPNO          = ds1.indexOfColumn("EMPNO");              //
				int colNm_TAXIODIV        = ds1.indexOfColumn("TAXIODIV");           //
				int colNm_TAXDIV            = ds1.indexOfColumn("TAXDIV");             //
				int colNm_TAXKND          = ds1.indexOfColumn("TAXKND");             //
				int colNm_VEND_CD        = ds1.indexOfColumn("VEND_CD");            //
				int colNm_TAXDAT           = ds1.indexOfColumn("TAXDAT");             //
				int colNm_TAXSUM          = ds1.indexOfColumn("TAXSUM");             //
				int colNm_TAXVATAMT     = ds1.indexOfColumn("TAXVATAMT");          //
				int colNm_TAXTOT           = ds1.indexOfColumn("TAXTOT");             //
				int colNm_REMARK          = ds1.indexOfColumn("REMARK");             //
				int colNm_TAXCDNBR      = ds1.indexOfColumn("TAXCDNBR");           //
				int colNm_ATCODE           = ds1.indexOfColumn("ATCODE");             //
				int colNm_TAXPRTYN       = ds1.indexOfColumn("TAXPRTYN");           //
				int colNm_TAXCNT           = ds1.indexOfColumn("TAXCNT");             //
				int colNm_LASTPRT         = ds1.indexOfColumn("LASTPRT");            //
				int colNm_TAXTYPE         = ds1.indexOfColumn("TAXTYPE");            //
				int colNm_FSDAT             = ds1.indexOfColumn("FSDAT");              //
				int colNm_FSNBR             = ds1.indexOfColumn("FSNBR");              //
				int colNm_TAXKIDIV          = ds1.indexOfColumn("TAXKIDIV");           //
				int colNm_FDCODE           = ds1.indexOfColumn("FDCODE");             //
				int colNm_WORKTYPE        = ds1.indexOfColumn("WORKTYPE");           //
				int colNm_REPORT           = ds1.indexOfColumn("REPORT");             //
				int colNm_WRDT               = ds1.indexOfColumn("WRDT");               //
				int colNm_WRID                = ds1.indexOfColumn("WRID");               //
				int colNm_UPDT                = ds1.indexOfColumn("UPDT");               //
				int colNm_UPID                      = ds1.indexOfColumn("UPID");               //
				int colNm_SEQ                       = ds1.indexOfColumn("SEQ");                //
				int colNm_GUBUN                  = ds1.indexOfColumn("GUBUN");              //
				int colNm_AMEND_CODE        = ds1.indexOfColumn("AMEND_CODE");         //
				int colNm_AMEND_REMARK     = ds1.indexOfColumn("AMEND_REMARK");       //
				int colNm_EXTCHK                   = ds1.indexOfColumn("EXTCHK");             //
				int colNm_REMARK2                 = ds1.indexOfColumn("REMARK2");            //
				int colNm_REMARK3                 = ds1.indexOfColumn("REMARK3");            //
				int colNm_S_BIZPLACE            = ds1.indexOfColumn("S_BIZPLACE");         //
				int colNm_B_BIZPLACE            = ds1.indexOfColumn("B_BIZPLACE");         //
				
			    /*		
				StringUtil.printMsg("colNm_INOUT_SID",colNm_INOUT_SID,this);
				StringUtil.printMsg("colNm_SITE_SID",colNm_SITE_SID,this);
				StringUtil.printMsg("colNm_COST_CD",colNm_COST_CD,this);
				StringUtil.printMsg("colNm_INGB_CD",colNm_INGB_CD,this);
				StringUtil.printMsg("colNm_INOUT_DT",colNm_INOUT_DT,this);
				StringUtil.printMsg("colNm_ATCODE",colNm_ATCODE,this);
				StringUtil.printMsg("colNm_BID_SITE_KIND",colNm_BID_SITE_KIND,this);
				StringUtil.printMsg("colNm_SUPAMT",colNm_SUPAMT,this);
				StringUtil.printMsg("colNm_VATAMT",colNm_VATAMT,this);
				StringUtil.printMsg("colNm_SUMAMT",colNm_SUMAMT,this);
				StringUtil.printMsg("colNm_REMARK",colNm_REMARK,this);
				StringUtil.printMsg("colNm_TAX_KND",colNm_TAX_KND,this);
				StringUtil.printMsg("colNm_VEND_CD",colNm_VEND_CD,this);
				StringUtil.printMsg("colNm_VEND_NM",colNm_VEND_NM,this);
				StringUtil.printMsg("colNm_TAX_DIV",colNm_TAX_DIV,this);
				StringUtil.printMsg("colNm_GUBUN",colNm_GUBUN,this);
				StringUtil.printMsg("colNm_INOUT_GB",colNm_INOUT_GB,this);
				StringUtil.printMsg("colNm_OWNER",colNm_OWNER,this);
				StringUtil.printMsg("colNm_CARD_KND",colNm_CARD_KND,this);
				StringUtil.printMsg("colNm_CARD_NUM",colNm_CARD_NUM,this);
				StringUtil.printMsg("colNm_H_ASTNBR",colNm_H_ASTNBR,this);
                 */
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						 					   
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_TAXNBR));       
							cstmt.setString(2, rows[i].getString(colNm_COCODE));       
							cstmt.setString(3, rows[i].getString(colNm_DEPTCD));       
							cstmt.setString(4, rows[i].getString(colNm_EMPNO));        
							cstmt.setString(5, rows[i].getString(colNm_TAXIODIV));     
							cstmt.setString(6, rows[i].getString(colNm_TAXDIV));       
							cstmt.setString(7, rows[i].getString(colNm_TAXKND));       
							cstmt.setString(8, rows[i].getString(colNm_VEND_CD));      
							cstmt.setString(9, rows[i].getString(colNm_TAXDAT));       
							cstmt.setInt(10,rows[i].getInt(colNm_TAXSUM));       
							cstmt.setInt(11, rows[i].getInt(colNm_TAXVATAMT));   
							cstmt.setInt(12, rows[i].getInt(colNm_TAXTOT));      
							cstmt.setString(13, rows[i].getString(colNm_REMARK));      
							cstmt.setString(14, rows[i].getString(colNm_TAXCDNBR));    
							cstmt.setString(15, rows[i].getString(colNm_ATCODE));      
							cstmt.setString(16, rows[i].getString(colNm_TAXPRTYN));    
							cstmt.setInt(17, rows[i].getInt(colNm_TAXCNT));      
							cstmt.setString(18, rows[i].getString(colNm_LASTPRT));     
							cstmt.setString(19, rows[i].getString(colNm_TAXTYPE));     
							cstmt.setString(20, rows[i].getString(colNm_FSDAT));       
							cstmt.setString(21, rows[i].getString(colNm_FSNBR));       
							cstmt.setString(22, rows[i].getString(colNm_TAXKIDIV));    
							cstmt.setString(23, rows[i].getString(colNm_FDCODE));      
							cstmt.setString(24, rows[i].getString(colNm_WORKTYPE));    
							cstmt.setString(25, rows[i].getString(colNm_REPORT));      
							cstmt.setString(26, rows[i].getString(colNm_WRDT));        
							cstmt.setString(27, rows[i].getString(colNm_WRID));        
							cstmt.setString(28, rows[i].getString(colNm_UPDT));        
							cstmt.setString(29, rows[i].getString(colNm_UPID));        
							cstmt.setInt(30, rows[i].getInt(colNm_SEQ));         
							cstmt.setString(31, rows[i].getString(colNm_GUBUN));       
							cstmt.setString(32, rows[i].getString(colNm_AMEND_CODE));  
							cstmt.setString(33, rows[i].getString(colNm_AMEND_REMARK));
							cstmt.setString(34, rows[i].getString(colNm_EXTCHK));      
							cstmt.setString(35, rows[i].getString(colNm_REMARK2));     
							cstmt.setString(36, rows[i].getString(colNm_REMARK3));     
							cstmt.setString(37, rows[i].getString(colNm_S_BIZPLACE));  
							cstmt.setString(38, rows[i].getString(colNm_B_BIZPLACE));  
							cstmt.setString(39, iParamEmpno);
							cstmt.setString(40, iParamIp);
							cstmt.setString(41, "1");
															
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
								
							cstmt.setString(1, rows[i].getString(colNm_TAXNBR));       
							cstmt.setString(2, rows[i].getString(colNm_COCODE));       
							cstmt.setString(3, rows[i].getString(colNm_DEPTCD));       
							cstmt.setString(4, rows[i].getString(colNm_EMPNO));        
							cstmt.setString(5, rows[i].getString(colNm_TAXIODIV));     
							cstmt.setString(6, rows[i].getString(colNm_TAXDIV));       
							cstmt.setString(7, rows[i].getString(colNm_TAXKND));       
							cstmt.setString(8, rows[i].getString(colNm_VEND_CD));      
							cstmt.setString(9, rows[i].getString(colNm_TAXDAT));       
							cstmt.setInt(10,rows[i].getInt(colNm_TAXSUM));       
							cstmt.setInt(11, rows[i].getInt(colNm_TAXVATAMT));   
							cstmt.setInt(12, rows[i].getInt(colNm_TAXTOT));      
							cstmt.setString(13, rows[i].getString(colNm_REMARK));      
							cstmt.setString(14, rows[i].getString(colNm_TAXCDNBR));    
							cstmt.setString(15, rows[i].getString(colNm_ATCODE));      
							cstmt.setString(16, rows[i].getString(colNm_TAXPRTYN));    
							cstmt.setInt(17, rows[i].getInt(colNm_TAXCNT));      
							cstmt.setString(18, rows[i].getString(colNm_LASTPRT));     
							cstmt.setString(19, rows[i].getString(colNm_TAXTYPE));     
							cstmt.setString(20, rows[i].getString(colNm_FSDAT));       
							cstmt.setString(21, rows[i].getString(colNm_FSNBR));       
							cstmt.setString(22, rows[i].getString(colNm_TAXKIDIV));    
							cstmt.setString(23, rows[i].getString(colNm_FDCODE));      
							cstmt.setString(24, rows[i].getString(colNm_WORKTYPE));    
							cstmt.setString(25, rows[i].getString(colNm_REPORT));      
							cstmt.setString(26, rows[i].getString(colNm_WRDT));        
							cstmt.setString(27, rows[i].getString(colNm_WRID));        
							cstmt.setString(28, rows[i].getString(colNm_UPDT));        
							cstmt.setString(29, rows[i].getString(colNm_UPID));        
							cstmt.setInt(30, rows[i].getInt(colNm_SEQ));         
							cstmt.setString(31, rows[i].getString(colNm_GUBUN));       
							cstmt.setString(32, rows[i].getString(colNm_AMEND_CODE));  
							cstmt.setString(33, rows[i].getString(colNm_AMEND_REMARK));
							cstmt.setString(34, rows[i].getString(colNm_EXTCHK));      
							cstmt.setString(35, rows[i].getString(colNm_REMARK2));     
							cstmt.setString(36, rows[i].getString(colNm_REMARK3));     
							cstmt.setString(37, rows[i].getString(colNm_S_BIZPLACE));  
							cstmt.setString(38, rows[i].getString(colNm_B_BIZPLACE));  
							cstmt.setString(39, iParamEmpno);
							cstmt.setString(40, iParamIp);
							cstmt.setString(41, "3");
					
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
								
							cstmt.setString(1, rows[i].getString(colNm_TAXNBR));       
							cstmt.setString(2, rows[i].getString(colNm_COCODE));       
							cstmt.setString(3, rows[i].getString(colNm_DEPTCD));       
							cstmt.setString(4, rows[i].getString(colNm_EMPNO));        
							cstmt.setString(5, rows[i].getString(colNm_TAXIODIV));     
							cstmt.setString(6, rows[i].getString(colNm_TAXDIV));       
							cstmt.setString(7, rows[i].getString(colNm_TAXKND));       
							cstmt.setString(8, rows[i].getString(colNm_VEND_CD));      
							cstmt.setString(9, rows[i].getString(colNm_TAXDAT));       
							cstmt.setInt(10,rows[i].getInt(colNm_TAXSUM));       
							cstmt.setInt(11, rows[i].getInt(colNm_TAXVATAMT));   
							cstmt.setInt(12, rows[i].getInt(colNm_TAXTOT));      
							cstmt.setString(13, rows[i].getString(colNm_REMARK));      
							cstmt.setString(14, rows[i].getString(colNm_TAXCDNBR));    
							cstmt.setString(15, rows[i].getString(colNm_ATCODE));      
							cstmt.setString(16, rows[i].getString(colNm_TAXPRTYN));    
							cstmt.setInt(17, rows[i].getInt(colNm_TAXCNT));      
							cstmt.setString(18, rows[i].getString(colNm_LASTPRT));     
							cstmt.setString(19, rows[i].getString(colNm_TAXTYPE));     
							cstmt.setString(20, rows[i].getString(colNm_FSDAT));       
							cstmt.setString(21, rows[i].getString(colNm_FSNBR));       
							cstmt.setString(22, rows[i].getString(colNm_TAXKIDIV));    
							cstmt.setString(23, rows[i].getString(colNm_FDCODE));      
							cstmt.setString(24, rows[i].getString(colNm_WORKTYPE));    
							cstmt.setString(25, rows[i].getString(colNm_REPORT));      
							cstmt.setString(26, rows[i].getString(colNm_WRDT));        
							cstmt.setString(27, rows[i].getString(colNm_WRID));        
							cstmt.setString(28, rows[i].getString(colNm_UPDT));        
							cstmt.setString(29, rows[i].getString(colNm_UPID));        
							cstmt.setInt(30, rows[i].getInt(colNm_SEQ));         
							cstmt.setString(31, rows[i].getString(colNm_GUBUN));       
							cstmt.setString(32, rows[i].getString(colNm_AMEND_CODE));  
							cstmt.setString(33, rows[i].getString(colNm_AMEND_REMARK));
							cstmt.setString(34, rows[i].getString(colNm_EXTCHK));      
							cstmt.setString(35, rows[i].getString(colNm_REMARK2));     
							cstmt.setString(36, rows[i].getString(colNm_REMARK3));     
							cstmt.setString(37, rows[i].getString(colNm_S_BIZPLACE));  
							cstmt.setString(38, rows[i].getString(colNm_B_BIZPLACE));  
							cstmt.setString(39, iParamEmpno);
							cstmt.setString(40, iParamIp);
							cstmt.setString(41, "2");
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;						
					}//switch(rows[i].getJobType()){
				}
			}//if (ds1 != null) {
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			//msgDS.flush();
			if(rs!=null) rs.close();
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
}