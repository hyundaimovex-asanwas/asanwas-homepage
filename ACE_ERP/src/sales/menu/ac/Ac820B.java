package sales.menu.ac;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac820B extends SuperServlet {

	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Date 조회
		arr_sql[0].append ("SELECT  SUBSTR(MIN(AGREE_TIME), 1, 8) FR_DATE,	\n")
				  .append ("		SUBSTR(MAX(AGREE_TIME), 1, 8) TO_DATE	\n")
				  .append ("FROM	SALES.TRV220							\n")
				  .append ("WHERE   REQ_DATE = ?							\n");

		
		//Default 조회
		arr_sql[1].append ("{call SALES.PR_AC820B_01(?,?, ?)}");
		
		//Master 조회
		arr_sql[2].append ("{call SALES.PR_AC820B_02(?,?, ?)}");

		//매입자료 생성
		arr_sql[3].append ("{call SALES.PR_AC820B_03(?, ?, ?, ?, ?, ?, ?)}");

		//매입자료 생성
		arr_sql[4].append ("{call SALES.PR_AC820B_04(?,?, ?)}");

	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            
			//청구일자
			String v_req_date 	= HDUtil.nullCheckStr(greq.getParameter("v_req_date"));
			String sJob_seq		= HDUtil.nullCheckStr(greq.getParameter("sJob_seq"));	// 작업구분
			//StringUtil.printMsg(" sJob_seq===",sJob_seq,this);
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_req_date);
					cstmt.setString(2, sJob_seq);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_master")){
					GauceDataSet ds1 = gis.read("MASTER");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, v_req_date);
					cstmt.setString(2, sJob_seq);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}			
            	if(dSets[i].getName().equals("ds_date")){
					GauceDataSet ds1 = gis.read("DATE");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_req_date);
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
			}
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
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
		ResultSet 			rs 			= null;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        /* DataSet RESULT=ds_result */
		GauceDataSet ds_result = gis.read("RESULT");

		String v_req_date 	= HDUtil.nullCheckStr(greq.getParameter("v_req_date"));
		String sJob_seq		= HDUtil.nullCheckStr(greq.getParameter("sJob_seq"));	// 작업구분
		
				
		try{
			//메시지처리
			if(ds_result!=null){
				ds_result.addDataColumn(new GauceDataColumn("FILE_NAME", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(!v_req_date.equals("")){
				cstmt = conn.prepareCall(arr_sql[3].toString());
				cstmt.setString(1, v_req_date);
				cstmt.setString(2, fParamEmpno);
				cstmt.setString(3, fParamIp);
				cstmt.setString(4, sJob_seq);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				
				cstmt.executeUpdate();
				
				String r_s_yn		= cstmt.getString(5);
				String r_msg_cd	 	= cstmt.getString(6);
				String r_msg		= cstmt.getString(7);
				
				if(!r_s_yn.equals("Y"))
					throw new Exception ("");
				if(cstmt!=null) cstmt.close();
				
				cstmt = conn.prepareCall(arr_sql[4].toString());
				cstmt.setString(1, v_req_date);
				cstmt.setString(2, sJob_seq);
				cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
				cstmt.executeQuery();
				rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
				//gos.write(getDataSet(rs, ds1));
				
				
				String getFileName = getDataFileMake(rs, HDConstant.FILE_UPLOAD_PATH_CARD, "HDASAN_SND_"+v_req_date+"_"+sJob_seq);
				StringUtil.printMsg("getFileName", getFileName, this);

				if(ds_result!=null){
					ds_result.put("FILE_NAME", getFileName, 30);//커서 OUT param.
					ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
					ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
					ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
					ds_result.heap();					
				}
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			if(ds_result!=null) gos.write(ds_result);
			gos.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

}
