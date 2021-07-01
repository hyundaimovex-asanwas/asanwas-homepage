package pms.menu.co;

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

public class Co010S_01 extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//현장별 총투입현황 
		arr_sql[0].append ("{call PMS.PR_Co010S_01(?,?,?,?,?,?) }" );
	
   }

	//init method
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","선조회",this);
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
						//StringUtil.printMsg("DS DS_DEFAULT","선조회",this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "");
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "19990101");
						cstmt.setString(4, "");   
						cstmt.setString(5, "");   
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

		//StringUtil.printMsg("v_cost_cd",v_cost_cd,this);
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
						String v_fdcode 	= HDUtil.nullCheckStr(greq.getParameter("v_fdcode")); 	    // 지점 
						String v_fr_actdat  = HDUtil.nullCheckStr(greq.getParameter("v_fr_actdat")); 	// 회계일자 
						String v_to_actdat 	= HDUtil.nullCheckStr(greq.getParameter("v_to_actdat")); 	// 회계일자
						String v_fr_costcd	= HDUtil.nullCheckStr(greq.getParameter("v_fr_costcd")); 	// 원가코드
						String v_to_costcd  = HDUtil.nullCheckStr(greq.getParameter("v_to_costcd"));   	// 원가코드 
						
						//StringUtil.printMsg("v_cost_cd",v_cost_cd,this);

						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, v_fdcode);
						cstmt.setString(2, v_fr_actdat);
						cstmt.setString(3, v_to_actdat);
						cstmt.setString(4, v_fr_costcd);
						cstmt.setString(5, v_to_costcd);
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
		CallableStatement cstmt = null;	
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
		
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						 					   				
						case GauceDataRow.TB_JOB_UPDATE:
						
						case GauceDataRow.TB_JOB_DELETE:
							
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
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
}