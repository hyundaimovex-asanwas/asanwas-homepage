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

public class Sms010 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();

		
		//Main ��ȸ
		arr_sql[0].append ("{call SECURITY.PR_SMS010S_01(?) }" );
		
		
		//����� ��ȸ
		arr_sql[1].append ("{call SECURITY.PR_SMS010S_02(?,?) }" );		
		
		// ����
		arr_sql[2].append ("{call SECURITY.PR_SMS010I_01(?,?,?,?,?) }" );
		

		// SMS �߼�
		arr_sql[3].append ("	INSERT INTO EMMADB.DBO.EM_SMT_TRAN( 																	\n")
					.append ("		MT_REFKEY,                               	 	 													\n")
					.append ("		DATE_CLIENT_REQ,                                		  											\n")
					.append ("		CONTENT,                             																\n")
					.append ("		CALLBACK, 																							\n")
					.append ("		SERVICE_TYPE,                               	 	 												\n")
					.append ("		BROADCAST_YN,                                		  												\n")
					.append ("		MSG_STATUS,                             															\n")
					.append ("		RECIPIENT_NUM, 																						\n")					
					.append ("		CARRIER )																							\n")						
					.append ("	VALUES (																								\n")
					.append ("		'FAM',  																							\n")
					.append ("		GETDATE(),  																						\n")
					.append ("		?,                                                                                                  \n")					
					.append ("		'0236693903', 																						\n")
					.append ("		'0',  																								\n")
					.append ("		'N',  																								\n")	
					.append ("		'1',  																								\n")			
					.append ("		?,																						            \n")						
					.append ("		10001 ); 																							\n");			
		
		            //System.out.println("INSERT INTO EMMADB.DBO.EM_SMT_TRAN \n" + arr_sql[3].toString());		

		
   }

	
	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;


		
		//StringUtil.printMsg("# Command","�̵��� ��ȸ",this);

		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            
				//O:gcds_data00=gcds_data00
            	if(dSets[i].getName().equals("gcds_data00")){
            		
					GauceDataSet ds1 = gis.read("gcds_data00");

					cstmt = conn.prepareCall(arr_sql[0].toString());

					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//����� ���� Ŀ��
	
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(1);	//Ŀ�� OUT param. 	
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	
            	
				//O:gcds_old=gcds_old
            	if(dSets[i].getName().equals("gcds_old")){
            		
					GauceDataSet ds1 = gis.read("gcds_old");

					String v_empnm  = HDUtil.nullCheckStr(greq.getParameter("ENO_NM")); 			// ����							
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_empnm);

					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
	
					cstmt.executeQuery();

					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 	
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					
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
	
	
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//apply method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		
		//StringUtil.printMsg("# Command","����",this);
		
		CallableStatement cstmt      = null;	
		ResultSet 			rs 		 = null;
			
		CallableStatement cstmt_ms   = null;	
		ResultSet 			rs_ms 	 = null;						
		
		
		GauceInputStream gis  = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds00 = gis.read("gcds_data00");
		  
		try{

			if (ds00 != null) {
			
				GauceDataRow[] 		rows = ds00.getDataRows();
				GauceDataColumn[] 	cols = ds00.getDataColumns();
					
				int colNm_EM_PHN_NO     = ds00.indexOfColumn("EM_PHN_NO");			//EM_PHN_NO
				int colNm_MEMO        	= ds00.indexOfColumn("MEMO");				//MEMO 
				
				//2021.06.11 �ű� ������ �̻��ߴٰ� 8�� �߿��� Closing �� ����          DB ���� 203.242.32.128 ===> 10.106.246.177
				//Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");
				
				Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://10.106.246.177:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");
				
				
				for(int i=0; i<rows.length; i++){				
				
					/* SMS ������ �κ� Start */
					
					cstmt_ms = conn_ms.prepareCall(arr_sql[3].toString());

					cstmt_ms.setString(1, rows[i].getString(colNm_MEMO));					
					cstmt_ms.setString(2, rows[i].getString(colNm_EM_PHN_NO));

					cstmt_ms.executeUpdate();

					/* SMS ������ �κ� Finish*/		
					
				}
					
					cstmt_ms.close();
					conn_ms.close();

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