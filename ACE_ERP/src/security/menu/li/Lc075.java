package security.menu.li;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
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

public class Lc075 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();

		//Main ��ȸ
		arr_sql[0].append ("{call SECURITY.PR_LC075S_01(?,?,?,?) }" );
		
		// ����
		arr_sql[2].append ("{call SECURITY.PR_LC075I_01(?,?,?,?,?,?,?,?) }" );

		// ������Ʈ
		arr_sql[3].append ("{call SECURITY.PR_LC075I_02(?,?,?,?,?,?,?) }" );
		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_staxdate  = HDUtil.nullCheckStr(greq.getParameter("v_staxdate")); 			// ����
		String v_carno    = HDUtil.nullCheckStr(greq.getParameter("v_carno")); 					// carno
		String v_from_tm = HDUtil.nullCheckStr(greq.getParameter("v_from_tm")); 				// ���۽ð�	


		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            
				//O:DS_DEFAULT=ds_default
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[0].toString());
				
					cstmt.setString(1, v_staxdate);
					cstmt.setString(2, v_carno);
					cstmt.setString(3, v_from_tm);				
					
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
	
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 	
				
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					
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
		
		
		//StringUtil.printMsg("# Command","����",this);
		
		CallableStatement cstmt      = null;	
		ResultSet 			rs 			= null;
			
		CallableStatement cstmt_ms  = null;	
		ResultSet 			rs_ms 		= null;		
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT2");
		GauceDataSet ds3 = gis.read("DS_DEFAULT3");
		  
		try{
			if (ds1 != null) {
				
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					

				int colNm_DRIVE_DT       = ds1.indexOfColumn("DRIVE_DT");		    	//DRIVE_DT 
				int colNm_FROM_TM       = ds1.indexOfColumn("FROM_TM");		    //FROM_TM 
				int colNm_TO_TM          = ds1.indexOfColumn("TO_TM");		    		//TO_TM 				
				int colNm_CAR_NO     	= ds1.indexOfColumn("CAR_NO");        		//CAR_NO    
				int colNm_DRIVER     		= ds1.indexOfColumn("DRIVER");        			//DRIVER 				
				int colNm_DRIVE_BEFORE = ds1.indexOfColumn("DRIVE_BEFORE");		//DRIVE_BEFORE       
				int colNm_DRIVE_AFTER  	= ds1.indexOfColumn("DRIVE_AFTER");			//DRIVE_AFTER    
				int colNm_REMARK        = ds1.indexOfColumn("REMARK");				//REMARK

				for(int i=0; i<rows.length; i++){
					
					int j=1;

					switch(rows[i].getJobType()){
					
						case GauceDataRow.TB_JOB_INSERT:
							
							/*
							StringUtil.printMsg("colNm_DRIVE_DT::",rows[i].getString(colNm_DRIVE_DT),this);	
							StringUtil.printMsg("colNm_CAR_NO::",rows[i].getString(colNm_CAR_NO),this);					
							StringUtil.printMsg("colNm_DRIVER::",rows[i].getString(colNm_DRIVER),this);	
							StringUtil.printMsg("colNm_DRIVE_BEFORE::",rows[i].getString(colNm_DRIVE_BEFORE),this);		
							StringUtil.printMsg("colNm_DRIVE_AFTER::",rows[i].getString(colNm_DRIVE_AFTER),this);					
							StringUtil.printMsg("colNm_REMARK::",rows[i].getString(colNm_REMARK),this);	
							*/
 
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(2, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(3, rows[i].getString(colNm_TO_TM));									
						    cstmt.setString(4, rows[i].getString(colNm_CAR_NO));							
							cstmt.setString(5, rows[i].getString(colNm_DRIVER));
							cstmt.setString(6, rows[i].getString(colNm_DRIVE_BEFORE));
							cstmt.setString(7, rows[i].getString(colNm_DRIVE_AFTER));									
							cstmt.setString(8, rows[i].getString(colNm_REMARK));		
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;

							
						case GauceDataRow.TB_JOB_UPDATE:
							
					        //StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(2, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(3, rows[i].getString(colNm_TO_TM));									
						    cstmt.setString(4, rows[i].getString(colNm_CAR_NO));							
							cstmt.setString(5, rows[i].getString(colNm_DRIVER));
							cstmt.setString(6, rows[i].getString(colNm_DRIVE_BEFORE));
							cstmt.setString(7, rows[i].getString(colNm_DRIVE_AFTER));									
							cstmt.setString(8, rows[i].getString(colNm_REMARK));									

							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
							
							
						case GauceDataRow.TB_JOB_DELETE:

							cstmt = conn.prepareCall(arr_sql[4].toString());

							cstmt.setString(1, rows[i].getString(colNm_DRIVE_DT));
						    cstmt.setString(2, rows[i].getString(colNm_CAR_NO));							
							cstmt.setString(3, rows[i].getString(colNm_DRIVER));
							cstmt.setString(4, rows[i].getString(colNm_DRIVE_BEFORE));
							cstmt.setString(5, rows[i].getString(colNm_DRIVE_AFTER));									
							cstmt.setString(6, rows[i].getString(colNm_REMARK));									

							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;						
							
					}

				}

			}
			
			
			
			if(ds3 != null){
				
				GauceDataRow[] 		rows = ds3.getDataRows();
				GauceDataColumn[] 	cols  = ds3.getDataColumns();
					
				int colNm_DRIVE_DT       = ds3.indexOfColumn("DRIVE_DT");		    	//DRIVE_DT 
				int colNm_FROM_TM      = ds3.indexOfColumn("FROM_TM");		    	//FROM_TM 	
				int colNm_TO_TM          = ds3.indexOfColumn("TO_TM");		    		//TO_TM 					
				int colNm_CAR_NO     	= ds3.indexOfColumn("CAR_NO");        		//CAR_NO    			
				int colNm_DRIVE_BEFORE = ds3.indexOfColumn("DRIVE_BEFORE");		//DRIVE_BEFORE       
				int colNm_DRIVE_AFTER  	= ds3.indexOfColumn("DRIVE_AFTER");			//DRIVE_AFTER    
				int colNm_REMARK        = ds3.indexOfColumn("REMARK");				//REMARK

				for(int i=0; i<rows.length; i++){
					
					int j=1;

					switch(rows[i].getJobType()){
					
						case GauceDataRow.TB_JOB_INSERT:

							cstmt = conn.prepareCall(arr_sql[3].toString());

							cstmt.setString(1, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(2, rows[i].getString(colNm_FROM_TM));	
							cstmt.setString(3, rows[i].getString(colNm_TO_TM));								
						    cstmt.setString(4, rows[i].getString(colNm_CAR_NO));							
							cstmt.setString(5, rows[i].getString(colNm_DRIVE_BEFORE));
							cstmt.setString(6, rows[i].getString(colNm_DRIVE_AFTER));									
							cstmt.setString(7, rows[i].getString(colNm_REMARK));		
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;

							
						case GauceDataRow.TB_JOB_UPDATE:
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							break;						
							
					}

				}
				
			}
			
			
			
			gos.close();
			
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
		
	}
	
}