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

public class Si010I1 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//마스터 조회
		arr_sql[0].append ("{call PMS.PR_SI010I_01(?,?,?,?,?, ?,?) }" );

		//Main 저장
		arr_sql[1].append ("{call PMS.PR_SI010I_02(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,?,?,?,?)}" );
	
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

				
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
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "080304");
					cstmt.setString(2, "2");
					cstmt.setString(3, "19990101");
					cstmt.setString(4, "19990101");   
					cstmt.setString(5, "6050006");   
					cstmt.setString(6, "1");   
					// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 					
					
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
					String v_empno	        	= HDUtil.nullCheckStr(greq.getParameter("v_empno"));      	// 작성자 
					String v_inout_gb	        = HDUtil.nullCheckStr(greq.getParameter("v_inout_gb"));      	// 작성자 

					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_cost_cd);
					cstmt.setString(2, v_ingb_cd);
					cstmt.setString(3, v_fr_inout_dt);
					cstmt.setString(4, v_to_inout_dt);
					cstmt.setString(5, v_empno);
					cstmt.setString(6, v_inout_gb);
					// 프로시저가 동적 쿼리 프로시저라.. 값을 어케 받을까.. 우움...;;;
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 					
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
			
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");

		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_INOUT_SID     = ds1.indexOfColumn("INOUT_SID");        //출납등록SID    
				int colNm_SITE_SID      = ds1.indexOfColumn("SITE_SID");		    //현장SID        
				int colNm_COST_CD       = ds1.indexOfColumn("COST_CD");			//원가코드       
				int colNm_INGB_CD       = ds1.indexOfColumn("INGB_CD");			//입력구분       
				int colNm_INOUT_DT      = ds1.indexOfColumn("INOUT_DT");		    //출납일자       
				int colNm_ATCODE        = ds1.indexOfColumn("ATCODE");			//회계계정       
				int colNm_BID_SITE_KIND	= ds1.indexOfColumn("BID_SITE_KIND");	//공종           
				int colNm_SUPAMT        = ds1.indexOfColumn("SUPAMT");			//공급가         
				int colNm_VATAMT        = ds1.indexOfColumn("VATAMT");			//부가세         
				int colNm_SUMAMT        = ds1.indexOfColumn("SUMAMT");			//합계           
				int colNm_REMARK        = ds1.indexOfColumn("REMARK");			//적요           
				int colNm_TAX_KND       = ds1.indexOfColumn("TAX_KND");			//과세구분       
				int colNm_VEND_CD       = ds1.indexOfColumn("VEND_CD");			//거래처코드     
				int colNm_VEND_NM       = ds1.indexOfColumn("VEND_NM");			//거래처명       
				int colNm_TAX_DIV       = ds1.indexOfColumn("TAX_DIV");			//귀속구분       
				int colNm_GUBUN         = ds1.indexOfColumn("GUBUN");			     //발행구분       
				int colNm_INOUT_GB      = ds1.indexOfColumn("INOUT_GB");		//출납구분       
				int colNm_OWNER         = ds1.indexOfColumn("OWNER");			//소유자         
				int colNm_CARD_KND      = ds1.indexOfColumn("CARD_KND");		//카드종류       
				int colNm_CARD_NUM      = ds1.indexOfColumn("CARD_NUM");		//카드번호       
				int colNm_H_ASTNBR      = ds1.indexOfColumn("H_ASTNBR");		//대표자산번호   
				int colNm_ASTNM         = ds1.indexOfColumn("ASTNM");		        //자산명  
				int colNm_XSUPAMT       = ds1.indexOfColumn("XSUPAMT");		    //매입공급가  
				int colNm_NONPAY        = ds1.indexOfColumn("NONPAY");		    //미불구분  
				int colNm_ADPAYGB       = ds1.indexOfColumn("ADPAYGB");		    //전도금구분 
				int colNm_DCSTR_SID     = ds1.indexOfColumn("DCSTR_SID");		//세부공정SID  
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
				StringUtil.printMsg("iParamEmpno::",iParamEmpno,this);
				for(int i=0; i<rows.length; i++){
					int j=1;
					StringUtil.printMsg("ds1의 "+i+"행 작업===",rows[i].getJobType(),this);
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						 					   
							cstmt = conn.prepareCall(arr_sql[1].toString());
						    cstmt.setInt(1, rows[i].getInt(colNm_INOUT_SID));
							cstmt.setInt(2, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(3, rows[i].getString(colNm_COST_CD));
							cstmt.setString(4, rows[i].getString(colNm_INGB_CD));
							cstmt.setString(5, rows[i].getString(colNm_INOUT_DT));
							cstmt.setString(6, rows[i].getString(colNm_ATCODE));
							cstmt.setString(7, rows[i].getString(colNm_BID_SITE_KIND));
							cstmt.setInt(8, rows[i].getInt(colNm_SUPAMT));
							cstmt.setInt(9, rows[i].getInt(colNm_VATAMT));
							cstmt.setInt(10,rows[i].getInt(colNm_SUMAMT));
							cstmt.setString(11, rows[i].getString(colNm_REMARK));
							cstmt.setString(12, rows[i].getString(colNm_TAX_KND));
							cstmt.setString(13, rows[i].getString(colNm_VEND_CD));
							cstmt.setString(14, rows[i].getString(colNm_VEND_NM));
							cstmt.setString(15, rows[i].getString(colNm_TAX_DIV));
							cstmt.setString(16, rows[i].getString(colNm_GUBUN));
							cstmt.setString(17, rows[i].getString(colNm_INOUT_GB));
							cstmt.setString(18, rows[i].getString(colNm_OWNER));
							cstmt.setString(19, rows[i].getString(colNm_CARD_KND));
							cstmt.setString(20, rows[i].getString(colNm_CARD_NUM));
							cstmt.setString(21, rows[i].getString(colNm_H_ASTNBR));
						    cstmt.setString(22, rows[i].getString(colNm_ASTNM));
						    cstmt.setInt(23, rows[i].getInt(colNm_XSUPAMT));
						    cstmt.setString(24, rows[i].getString(colNm_NONPAY));
							cstmt.setString(25, rows[i].getString(colNm_ADPAYGB));
						    cstmt.setString(26, rows[i].getString(colNm_DCSTR_SID));
							cstmt.setString(27, iParamEmpno);
							cstmt.setString(28, iParamIp);
							cstmt.setString(29, "1");

							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();		
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
            				StringUtil.printMsg("call","colNm_SUPAMT"+rows[i].getInt(colNm_SUPAMT),this);
						    StringUtil.printMsg("call","XSUPAMT"+rows[i].getInt(colNm_XSUPAMT),this);
								
							cstmt.setInt(1, rows[i].getInt(colNm_INOUT_SID));
							cstmt.setInt(2, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(3, rows[i].getString(colNm_COST_CD));
							cstmt.setString(4, rows[i].getString(colNm_INGB_CD));
							cstmt.setString(5, rows[i].getString(colNm_INOUT_DT));
							cstmt.setString(6, rows[i].getString(colNm_ATCODE));
							cstmt.setString(7, rows[i].getString(colNm_BID_SITE_KIND));
							cstmt.setInt(8, rows[i].getInt(colNm_SUPAMT));
							cstmt.setInt(9, rows[i].getInt(colNm_VATAMT));
							cstmt.setInt(10,rows[i].getInt(colNm_SUMAMT));
							cstmt.setString(11, rows[i].getString(colNm_REMARK));
							cstmt.setString(12, rows[i].getString(colNm_TAX_KND));
							cstmt.setString(13, rows[i].getString(colNm_VEND_CD));
							cstmt.setString(14, rows[i].getString(colNm_VEND_NM));
							cstmt.setString(15, rows[i].getString(colNm_TAX_DIV));
							cstmt.setString(16, rows[i].getString(colNm_GUBUN));
							cstmt.setString(17, rows[i].getString(colNm_INOUT_GB));
							cstmt.setString(18, rows[i].getString(colNm_OWNER));
							cstmt.setString(19, rows[i].getString(colNm_CARD_KND));
							cstmt.setString(20, rows[i].getString(colNm_CARD_NUM));
							cstmt.setString(21, rows[i].getString(colNm_H_ASTNBR));
						    cstmt.setString(22, rows[i].getString(colNm_ASTNM));
						    cstmt.setInt(23,rows[i].getInt(colNm_XSUPAMT));
					    	cstmt.setString(24, rows[i].getString(colNm_NONPAY));
						    cstmt.setString(25, rows[i].getString(colNm_ADPAYGB));
							cstmt.setString(26, rows[i].getString(colNm_DCSTR_SID));
						    cstmt.setString(27, iParamEmpno);
						    cstmt.setString(28, iParamIp);
							cstmt.setString(29, "3");
							
					
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
								
							cstmt.setInt(1, rows[i].getInt(colNm_INOUT_SID));
							cstmt.setInt(2, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(3, rows[i].getString(colNm_COST_CD));
							cstmt.setString(4, rows[i].getString(colNm_INGB_CD));
							cstmt.setString(5, rows[i].getString(colNm_INOUT_DT));
							cstmt.setString(6, rows[i].getString(colNm_ATCODE));
							cstmt.setString(7, rows[i].getString(colNm_BID_SITE_KIND));
							cstmt.setInt(8, rows[i].getInt(colNm_SUPAMT));
							cstmt.setInt(9, rows[i].getInt(colNm_VATAMT));
							cstmt.setInt(10,rows[i].getInt(colNm_SUMAMT));
							cstmt.setString(11, rows[i].getString(colNm_REMARK));
							cstmt.setString(12, rows[i].getString(colNm_TAX_KND));
							cstmt.setString(13, rows[i].getString(colNm_VEND_CD));
							cstmt.setString(14, rows[i].getString(colNm_VEND_NM));
							cstmt.setString(15, rows[i].getString(colNm_TAX_DIV));
							cstmt.setString(16, rows[i].getString(colNm_GUBUN));
							cstmt.setString(17, rows[i].getString(colNm_INOUT_GB));
							cstmt.setString(18, rows[i].getString(colNm_OWNER));
							cstmt.setString(19, rows[i].getString(colNm_CARD_KND));
							cstmt.setString(20, rows[i].getString(colNm_CARD_NUM));
							cstmt.setString(21, rows[i].getString(colNm_H_ASTNBR));
						    cstmt.setString(22, rows[i].getString(colNm_ASTNM));
						    cstmt.setInt(23,rows[i].getInt(colNm_XSUPAMT));
						    cstmt.setString(24, rows[i].getString(colNm_NONPAY));
						    cstmt.setString(25, rows[i].getString(colNm_ADPAYGB));
						    cstmt.setString(26, rows[i].getString(colNm_DCSTR_SID));
							cstmt.setString(27, iParamEmpno);
							cstmt.setString(28, iParamIp);
							cstmt.setString(29, "2");
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