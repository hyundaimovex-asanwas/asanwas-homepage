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

		//���庰 ��������Ȳ 
		arr_sql[0].append ("{call PMS.PR_Co010S_01(?,?,?,?,?,?) }" );
	
   }

	//init method
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		try {
		    GauceInputStream gis = greq.getGauceInputStream();
	        GauceOutputStream gos = gres.getGauceOutputStream();
	            
	        //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
	        GauceDataSet[] dSets = gis.readAllOutput(); 
	        for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default

            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
						//StringUtil.printMsg("DS DS_DEFAULT","����ȸ",this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "");
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "19990101");
						cstmt.setString(4, "");   
						cstmt.setString(5, "");   
						cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
						
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
						
						//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
						//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
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
	            
	        //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
	        GauceDataSet[] dSets = gis.readAllOutput(); 

	        for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
            	//O:DS_DEFAULT=ds_default
            	if(dSets[i].getName().equals("ds_default")){
						GauceDataSet ds1 = gis.read("DS_DEFAULT");
						String v_fdcode 	= HDUtil.nullCheckStr(greq.getParameter("v_fdcode")); 	    // ���� 
						String v_fr_actdat  = HDUtil.nullCheckStr(greq.getParameter("v_fr_actdat")); 	// ȸ������ 
						String v_to_actdat 	= HDUtil.nullCheckStr(greq.getParameter("v_to_actdat")); 	// ȸ������
						String v_fr_costcd	= HDUtil.nullCheckStr(greq.getParameter("v_fr_costcd")); 	// �����ڵ�
						String v_to_costcd  = HDUtil.nullCheckStr(greq.getParameter("v_to_costcd"));   	// �����ڵ� 
						
						//StringUtil.printMsg("v_cost_cd",v_cost_cd,this);

						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, v_fdcode);
						cstmt.setString(2, v_fr_actdat);
						cstmt.setString(3, v_to_actdat);
						cstmt.setString(4, v_fr_costcd);
						cstmt.setString(5, v_to_costcd);
						cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
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
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
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