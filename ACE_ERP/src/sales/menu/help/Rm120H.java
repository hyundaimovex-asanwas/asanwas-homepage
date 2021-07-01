package sales.menu.help;

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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;



public class Rm120H extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//  ��ȸ 
		arr_sql[0].append("{call SALES.PR_RM120S_02(?, ?, ?, ?, ?) }"); //����, ��SID, �̿��������, �̿���������

		//  ���� (�߰�/����)
		//'20080224','20101231','OO',0, 423  ,0,'�Ǹ�����','2030004','172.16.1.23','1',NULL,NULL,NULL
		//��������, ��������, ����, �����ȣ,��SID,����SEQ,����,�������,����IP,��������,����Y/N,�޼����ڵ�,�޼���
		arr_sql[1].append("{CALL SALES.PR_RV740I_04 (?, ?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?, ?)}");
	}
 
	
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
	
		/* �˻��� �ʿ��� ���� */
		
		String	sRoomStatus = HDUtil.nullCheckStr(greq.getParameter("sRoomStatus")); // ����� 
		int 	sRoomSid	= HDUtil.nullCheckNum(greq.getParameter("sRoomSid")); 	// ��sid
		String	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate")); 	// ���������� 
		String	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate")); 	// ���������
		
		
		try {
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sRoomStatus);
					cstmt.setInt(2, sRoomSid);
					cstmt.setString(3, sBgnDate);
					cstmt.setString(4, sEndDate);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            }
            
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 		= gis.read("DS1");
		GauceDataSet ds_result 	= gis.read("RESULT");
		
		try{
			//���� ����
			String v_edit_styatus = "";	//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
			String v_send_id 	= "";
			String r_s_yn		= "";	//Return Status Yn
			String r_msg_cd		= "";	//Return Message Code
			String r_msg		= ""; 	//Return message
			
					
			if(ds_result!=null){
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

			GauceDataRow[] 		rows = ds1.getDataRows();
				
			int colNm_BGN_DATE	 		= ds1.indexOfColumn("BGN_DATE");	//'���� ����' 
			int colNm_END_DATE	 		= ds1.indexOfColumn("END_DATE");    //'���� ����' 
			int colNm_REMARKS	   		= ds1.indexOfColumn("REMARKS");     //'����'			
			int colNm_EMP_NM	 		= ds1.indexOfColumn("EMP_NM");      //'�����'		
			int colNm_ROOM_SID	 		= ds1.indexOfColumn("ROOM_SID");    //'��SID'		  
			int colNm_KEY_SEQ	   		= ds1.indexOfColumn("KEY_SEQ");     //'Ű'				
			int colNm_ROOM_STATUS		= ds1.indexOfColumn("ROOM_STATUS"); //'����'			
			
			//StringUtil.printMsg("�ο���",rows.length, this);
			for(int i=0; i<rows.length; i++){
				if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
					v_edit_styatus = "1";
				} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
					v_edit_styatus = "2";
				} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
					v_edit_styatus = "3";
				}
				//StringUtil.printMsg("for�� ��","", this);
				
				cstmt = conn.prepareCall(arr_sql[1].toString());
				cstmt.setString        (1, rows[i].getString(colNm_BGN_DATE));		//����������
				//StringUtil.printMsg("1::::::::::::", rows[i].getString(colNm_BGN_DATE), this);
				cstmt.setString        (2, rows[i].getString(colNm_END_DATE));		//�����������
				//StringUtil.printMsg("2::::::::::::", rows[i].getString(colNm_END_DATE), this);
				cstmt.setString     (3, rows[i].getString(colNm_ROOM_STATUS));	//���ǻ��� : 'OO'��..
				//StringUtil.printMsg("3::::::::::::", rows[i].getString(colNm_ROOM_STATUS), this);
				cstmt.setInt        (4, 0);										//RSV_SID : ������.
				cstmt.setInt        (5, rows[i].getInt(colNm_ROOM_SID));		//����sid
				//StringUtil.printMsg("5::::::::::::", rows[i].getInt(colNm_ROOM_SID), this);
				cstmt.setInt        (6, rows[i].getInt(colNm_KEY_SEQ));			//key_seq
				//StringUtil.printMsg("6::::::::::::", rows[i].getInt(colNm_KEY_SEQ), this);
				cstmt.setString     (7, rows[i].getString(colNm_REMARKS));		//�������(�������)
				cstmt.setString     (8, fParamEmpno);							//�������
				cstmt.setString     (9, fParamIp);								//����ip
				cstmt.setString     (10, v_edit_styatus);						//��������
				//StringUtil.printMsg("10::::::::::::", v_edit_styatus, this);
				cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);

				cstmt.executeUpdate();

				r_s_yn 		= cstmt.getString(11);
				r_msg_cd 	= cstmt.getString(12);
				r_msg 		= cstmt.getString(13);

				if(!r_s_yn.equals("Y")){
					throw new Exception (r_msg);
				}
				
				if(ds_result!=null){
					ds_result.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
					ds_result.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
					ds_result.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
					ds_result.heap();			
				}
				
				if(ds_result!=null) gos.write(ds_result);
							
			};//for(int i=0; i<row.length; i++){
	
			
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		};//try{		
		
	};//public void apply

}


