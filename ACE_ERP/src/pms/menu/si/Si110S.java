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

public class Si110S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Work Master List 조회
		arr_sql[0].append ("{call PMS.PR_SI110S_01(?,?,?) }" );
		//work Detail 조회
		arr_sql[1].append ("{call PMS.PR_SI110I_11(?,?) }" );
		//detail1 조회
		arr_sql[2].append ("{call PMS.PR_SI110I_21(?,?) }" );
		//detail2 조회
		arr_sql[3].append ("{call PMS.PR_SI110I_31(?,?) }" );
		//detail3 조회
		arr_sql[4].append ("{call PMS.PR_SI110I_41(?,?) }" );
		
		//work Master 저장
		arr_sql[5].append ("{call PMS.PR_SI110I_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?) }" );
		//work Detail 저장
		arr_sql[6].append ("{call PMS.PR_SI110I_12(?,?,?,?,?, ?) }" );
		//detail1 저장
		arr_sql[7].append ("{call PMS.PR_SI110I_22(?,?,?,?,?, ?,?,?) }" );
		//detail2 저장
		arr_sql[8].append ("{call PMS.PR_SI110I_32(?,?,?,?,?) }" );
		//detail3 저장
		arr_sql[9].append ("{call PMS.PR_SI110I_42(?,?,?,?,? ) }" );

		//work Master 날짜 중복 체크
		arr_sql[10].append ("{call PMS.PR_SI110I_03(?,?,?,?,?) }" );
		
		//전자결재 - 진행화면 조회
		arr_sql[11].append ("{call PMS.PR_SI110I_51(?,?) }" );
		//전자결재 - 출력화면 조회
		arr_sql[12].append ("{call PMS.PR_SI110I_61(?,?,?,?,?) }" );
		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("초기화~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	if(dSets[i].getName().equals("ds_wml")){
					GauceDataSet ds1 = gis.read("DS_WML");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, 0);
					cstmt.setString(2, "200001");
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_wd")){	//work detail 조회
					GauceDataSet ds1 = gis.read("DS_WD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_detail1")){	//하단 detail 1 조회 : 인력
					GauceDataSet ds1 = gis.read("DS_DETAIL1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail2")){	//하단 detail 2 조회 : 주요 장비
					GauceDataSet ds1 = gis.read("DS_DETAIL2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail3")){	//하단 detail 3 조회 : 주요자재
					GauceDataSet ds1 = gis.read("DS_DETAIL3");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
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
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_site_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// 현장sid
		String v_date 				= HDUtil.nullCheckStr(greq.getParameter("v_date"));				// 작업일자
		int v_dwr_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid

		//내부 변수
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;		
		StringUtil.printMsg("v_site_sid",v_site_sid,this);
		StringUtil.printMsg("v_date",v_date,this);
		//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
            	if(dSets[i].getName().equals("ds_wml")){
					GauceDataSet ds1 = gis.read("DS_WML");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setString(2, v_date);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_wd")){	//work detail 조회
					GauceDataSet ds1 = gis.read("DS_WD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_detail1")){	//하단 detail 1 조회 : 인력
					GauceDataSet ds1 = gis.read("DS_DETAIL1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail2")){	//하단 detail 2 조회 : 주요 장비
					GauceDataSet ds1 = gis.read("DS_DETAIL2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail3")){	//하단 detail 3 조회 : 주요자재
					GauceDataSet ds1 = gis.read("DS_DETAIL3");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            			
            	if(dSets[i].getName().equals("ds_wm_chk")){
					GauceDataSet ds_wm_chk = gis.read("DS_WM_CHK");	//일자 중복 체크 결과
					
					cstmt = conn.prepareCall(arr_sql[10].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setString(2, v_date);
					cstmt.registerOutParameter(3, OracleTypes.VARCHAR);	//결과를 받을 
					cstmt.registerOutParameter(4, OracleTypes.VARCHAR);	//결과를 받을 
					cstmt.registerOutParameter(5, OracleTypes.VARCHAR);	//결과를 받을
					
					cstmt.executeQuery();
					r_s_yn		 = cstmt.getString(3);
					r_msg_cd	 = cstmt.getString(4);
					r_msg		 = cstmt.getString(5);
					
					//StringUtil.printMsg(" r_s_yn",cstmt.getString(3),this);
					
					//if(!r_s_yn.equals("Y"))
						//throw new Exception (r_msg);
					
					if(ds_wm_chk!=null){
						ds_wm_chk.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_wm_chk.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_wm_chk.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_wm_chk.heap();
					}
					if(cstmt!=null) cstmt.close();
					if(ds_wm_chk!=null) gos.write(ds_wm_chk);
            	}
            	if(dSets[i].getName().equals("ds_ap_dwr")){	//전자결재 - 진행화면 조회
					GauceDataSet ds1 = gis.read("DS_AP_DWR");
					cstmt = conn.prepareCall(arr_sql[11].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
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
		//StringUtil.printMsg("저장~!","",this);
	}
}