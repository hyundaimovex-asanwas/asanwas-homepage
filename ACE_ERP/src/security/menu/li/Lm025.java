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

public class Lm025 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call SECURITY.PR_LM025S_01(?,?,?,?) }" );
		
		
		// 저장
		arr_sql[2].append ("{call SECURITY.PR_LM025I_01(?,?,?,?,?) }" );
		

		// SMS 발송
		arr_sql[3].append ("	INSERT INTO EMMADB.DBO.EM_SMT_TRAN( 														\n")
					.append ("		MT_REFKEY,                               	 	 													\n")
					.append ("		DATE_CLIENT_REQ,                                		  											\n")
					.append ("		CONTENT,                             																\n")
					.append ("		CALLBACK, 																							\n")
					.append ("		SERVICE_TYPE,                               	 	 												\n")
					.append ("		BROADCAST_YN,                                		  											\n")
					.append ("		MSG_STATUS,                             															\n")
					.append ("		RECIPIENT_NUM, 																					\n")					
					.append ("		CARRIER )																							\n")						
					.append ("	VALUES (																									\n")
					.append ("		'CAR',  																								\n")
					.append ("		GETDATE(),  																							\n")
					.append ("		?,                                                                                                      \n")					
					.append ("		'0236693753', 																						\n")
					.append ("		'0',  																									\n")
					.append ("		'N',  																									\n")	
					.append ("		'1',  																									\n")			
					.append ("		?,																						                \n")						
					.append ("		10001 ); 																								\n");			
		
		            //System.out.println("INSERT INTO EMMADB.DBO.EM_SMT_TRAN \n" + arr_sql[3].toString());		
		
		// 삭제
		arr_sql[4].append ("{call SECURITY.PR_LM025D_01(?,?,?,?,?) }" );		
		
		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_staxdate  = HDUtil.nullCheckStr(greq.getParameter("v_staxdate")); 			// 일자
		String v_carno    = HDUtil.nullCheckStr(greq.getParameter("v_carno")); 					// carno
		String v_from_tm = HDUtil.nullCheckStr(greq.getParameter("v_from_tm")); 				// 시작시간	

		//StringUtil.printMsg("# Command","이동훈 조회",this);

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            
				//O:DS_DEFAULT=ds_default
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[0].toString());
				
					cstmt.setString(1, v_staxdate);
					cstmt.setString(2, v_carno);
					cstmt.setString(3, v_from_tm);				
					
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
	
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 	
				
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					
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
					
				int colNm_CAR_NO     	= ds1.indexOfColumn("CAR_NO");        		//CAR_NO    
				int colNm_DRIVE_DT       = ds1.indexOfColumn("DRIVE_DT");		    	//DRIVE_DT   				
				int colNm_FROM_TM      = ds1.indexOfColumn("FROM_TM");				//FROM_TM       
				int colNm_TO_TM        	= ds1.indexOfColumn("TO_TM");					//TO_TM    
				int colNm_STATUS         = ds1.indexOfColumn("STATUS");				//STATUS

				for(int i=0; i<rows.length; i++){
					
					int j=1;

					switch(rows[i].getJobType()){
					
						case GauceDataRow.TB_JOB_INSERT:
							
							//StringUtil.printMsg("colNm_STATUS::",rows[i].getString(colNm_STATUS),this);	
					        //StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);					
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
						    cstmt.setString(1, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(3, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(4, rows[i].getString(colNm_TO_TM));
							cstmt.setString(5, rows[i].getString(colNm_STATUS));									

							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;

							
						case GauceDataRow.TB_JOB_UPDATE:
							
					        //StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
						    cstmt.setString(1, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(3, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(4, rows[i].getString(colNm_TO_TM));
							cstmt.setString(5, rows[i].getString(colNm_STATUS));									

							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
							
							
						case GauceDataRow.TB_JOB_DELETE:

							cstmt = conn.prepareCall(arr_sql[4].toString());

						    cstmt.setString(1, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(3, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(4, rows[i].getString(colNm_TO_TM));
							cstmt.setString(5, rows[i].getString(colNm_STATUS));								

							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;						
							
					}

				}

			}
			
			
			if (ds3 != null) {
			
					/* SMS 보내는 부분 Start */

					String  v_car				= HDUtil.nullCheckStr(greq.getParameter("v_car")); 		 
					String  v_drivedt		= HDUtil.nullCheckStr(greq.getParameter("v_drivedt")); 		 		
					String  v_from_tm		= HDUtil.nullCheckStr(greq.getParameter("v_from_tm")); 		
					String  v_to_tm			= HDUtil.nullCheckStr(greq.getParameter("v_to_tm")); 		 		
					String  v_phone			= HDUtil.nullCheckStr(greq.getParameter("v_phone")); 		 
					String  v_status			= HDUtil.nullCheckStr(greq.getParameter("v_status")); 						
					String  Message 		= null;
					
					//StringUtil.printMsg("v_status::",v_status,this);	
			        StringUtil.printMsg("v_car::",v_car,this);							

					if(v_status.equals("Y")){
						Message = "[현대아산]" + v_drivedt + " " + v_from_tm +"시-" + v_to_tm +"시 " +v_car + "사용 승인되었습니다.";
					}else if(v_status.equals("N")){
						Message = "[현대아산]" + v_drivedt + " " + v_from_tm +"시-" + v_to_tm +"시 " +v_car + "사용 반려되었습니다.";						
					}
			
					Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");
					

			        //StringUtil.printMsg("Message::",Message,this);								
					
					cstmt_ms = conn_ms.prepareCall(arr_sql[3].toString());

					cstmt_ms.setString(1, Message);
					cstmt_ms.setString(2, v_phone);
					
					rs_ms = cstmt_ms.executeQuery();
					
					gos.write(getDataSet(rs_ms, ds3));

					rs_ms.close();
					cstmt_ms.close();
					conn_ms.close();		
					
					/* SMS 보내는 부분 Finish*/		
					

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