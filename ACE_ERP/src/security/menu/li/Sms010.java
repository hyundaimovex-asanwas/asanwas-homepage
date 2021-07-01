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

		
		//Main 조회
		arr_sql[0].append ("{call SECURITY.PR_SMS010S_01(?) }" );
		
		
		//퇴사자 조회
		arr_sql[1].append ("{call SECURITY.PR_SMS010S_02(?,?) }" );		
		
		// 저장
		arr_sql[2].append ("{call SECURITY.PR_SMS010I_01(?,?,?,?,?) }" );
		

		// SMS 발송
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


		
		//StringUtil.printMsg("# Command","이동훈 조회",this);

		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            
				//O:gcds_data00=gcds_data00
            	if(dSets[i].getName().equals("gcds_data00")){
            		
					GauceDataSet ds1 = gis.read("gcds_data00");

					cstmt = conn.prepareCall(arr_sql[0].toString());

					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
	
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 	
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	
            	
				//O:gcds_old=gcds_old
            	if(dSets[i].getName().equals("gcds_old")){
            		
					GauceDataSet ds1 = gis.read("gcds_old");

					String v_empnm  = HDUtil.nullCheckStr(greq.getParameter("ENO_NM")); 			// 성명							
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_empnm);

					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
	
					cstmt.executeQuery();

					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 	
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					
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
		
		
		//StringUtil.printMsg("# Command","저장",this);
		
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
				
				//2021.06.11 신규 서버로 이사했다가 8월 중에는 Closing 할 예정          DB 서버 203.242.32.128 ===> 10.106.246.177
				//Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");
				
				Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://10.106.246.177:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");
				
				
				for(int i=0; i<rows.length; i++){				
				
					/* SMS 보내는 부분 Start */
					
					cstmt_ms = conn_ms.prepareCall(arr_sql[3].toString());

					cstmt_ms.setString(1, rows[i].getString(colNm_MEMO));					
					cstmt_ms.setString(2, rows[i].getString(colNm_EM_PHN_NO));

					cstmt_ms.executeUpdate();

					/* SMS 보내는 부분 Finish*/		
					
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