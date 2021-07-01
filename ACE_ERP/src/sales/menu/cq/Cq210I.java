package sales.menu.cq;

import java.io.FileOutputStream;
import java.io.InputStream;
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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Cq210I extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//����ž��_������ȸ
		arr_sql[0].append("{call SALES.PR_CQ210I_01 (?,?,?,?,?,   ?,? ) }");
		
		//����ž��_���� ȣ�� ���� 
		arr_sql[2].append("{call SALES.PR_CQ210I_02 (?,?,?,?,?,   ?,?,?,?,?,  ?) }");		

		// ����ž��_������ ��ȸ
		arr_sql[3].append("{call SALES.PR_CQ210I_03 (?,?,?,?,?,   ?,?,?,?,?,  ?,? ) }");
				
		// ����ž��_������ ���� 
		arr_sql[4].append("{call SALES.PR_CQ210I_04 (?,?,?,?,?,   ?,?,?,?) }");

		// ����ž��_�׼���_������ ��ȸ
		arr_sql[5].append("{call SALES.PR_CQ210I_05 (?,?,?,?,?,   ?,?,?,?,?,  ?,? ) }");
		
	}
 
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement 	cstmt 	= null;
		ResultSet 			rs 		= null;
		
		// �˻��� �ʿ��� ����
		int sSaupSid		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid")); 	// ���� SID
		String sDirection	= HDUtil.nullCheckStr(greq.getParameter("v_direction"));	// ����
		String sDate 		= HDUtil.nullCheckStr(greq.getParameter("v_date"));		// ���� 
		String sTime		= HDUtil.nullCheckStr(greq.getParameter("v_time")); 		// �ð�		
		int sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid")); // ��ǰ SID
		String sAccept_no	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no")); // ��û����ȣ

		//���� �߰�����
		String sClass 		= HDUtil.nullCheckStr(greq.getParameter("v_class")); // ��
		String sTeam		= HDUtil.nullCheckStr(greq.getParameter("v_team")); // �� 
		String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("v_jobsel")); // ������
				
		String sAssign_YN	= HDUtil.nullCheckStr(greq.getParameter("v_assign_YN")); // �̹�����
		String sCustNM		= HDUtil.nullCheckStr(greq.getParameter("v_custnm"));		// ����
		
		String sRide		= HDUtil.nullCheckStr(greq.getParameter("v_ride"));//ž�¸�� �ٿ��
		/*
		StringUtil.printMsg("sSaupSid- ",sSaupSid , this);
		StringUtil.printMsg("sDirection- ",sDirection , this);
		StringUtil.printMsg("sDate- ",sDate , this);
		StringUtil.printMsg("sTime- ",sTime , this);
		StringUtil.printMsg("sGoodSid- ",sGoodSid , this);
		StringUtil.printMsg("sClass- ",sClass , this);
		StringUtil.printMsg("sTeam- ",sTeam , this);		
		StringUtil.printMsg("sJobsel- ",sJobsel , this);	
		StringUtil.printMsg("sAccept_no- ",sAccept_no , this);  
		StringUtil.printMsg("sAssign_YN- ",sAssign_YN , this);  
		StringUtil.printMsg("sCustNM- ",sCustNM , this);  
		*/
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		try {

	          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default
            	if(dSets[i].getName().equals("ds_car")){
					GauceDataSet ds1 = gis.read("DS_CAR");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, sSaupSid);	
					cstmt.setString(2, sDirection);
					cstmt.setString(3, sDate);	
					cstmt.setString(4, sTime);	
					cstmt.setInt(5, sGoodSid);	
					cstmt.setString(6, sAccept_no);
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_cust")){
					GauceDataSet ds1 = gis.read("DS_CUST");
					if(sRide.equals("Y")){
						cstmt = conn.prepareCall(arr_sql[5].toString());
						//StringUtil.printMsg(" sRide", arr_sql[5].toString(),this);
					}else{
						cstmt = conn.prepareCall(arr_sql[3].toString());
						//StringUtil.printMsg(" sRide", arr_sql[3].toString(),this);
					}
					
					cstmt.setInt(1, sSaupSid);	
					cstmt.setString(2, sDirection);
					cstmt.setString(3, sDate);	
					cstmt.setString(4, sTime);	
					cstmt.setInt(5, sGoodSid);	
					cstmt.setString(6, sClass);	
					cstmt.setString(7, sTeam);	
					cstmt.setString(8, sJobsel);
					cstmt.setString(9, sAccept_no);
					cstmt.setString(10, sAssign_YN);
					cstmt.setString(11, sCustNM);
					cstmt.registerOutParameter(12, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(12);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            }
            gos.close();
			

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
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        GauceDataSet ds_car 	= gis.read("DS_CAR");
        GauceDataSet ds_cust 	= gis.read("DS_CUST");
        
        
		
		/* DataSet */
		GauceDataSet ds_result = gis.read("DS_RESULT");		
		try {
			//�޽���ó��
			if(ds_result!=null){
				//gres.enableFirstRow(ds_result);
				//ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				//ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				//ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

			if (ds_car != null) {// �����׸��� ȣ��/��Ī ����
				GauceDataRow[] 		rows = ds_car.getDataRows();
				int colNm_CarRsvSid			= ds_car.indexOfColumn("CAR_RSV_SID");
				int colNm_RideCarNum  		= ds_car.indexOfColumn("RIDE_CAR_NUM");
				int colNm_RideCar_Nm		= ds_car.indexOfColumn("RIDE_CAR_NM");
				int colNm_RideCarNum2  		= ds_car.indexOfColumn("RIDE_CAR_NUM2");
				int colNm_RideCar_Nm2		= ds_car.indexOfColumn("RIDE_CAR_NM2");

				
				
				
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("ds_default "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					/*
					StringUtil.printMsg("colNm_in_date",rows[i].getString(colNm_in_date),this);
					StringUtil.printMsg("colNm_remark",rows[i].getString(colNm_remark),this);
					StringUtil.printMsg("jobtype",rows[i].getJobType(),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);*/
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setInt(1, rows[i].getInt(colNm_CarRsvSid));
					cstmt.setString(2, rows[i].getString(colNm_RideCarNum));
					cstmt.setString(3, rows[i].getString(colNm_RideCar_Nm));
					cstmt.setString(4, rows[i].getString(colNm_RideCarNum2));
					cstmt.setString(5, rows[i].getString(colNm_RideCar_Nm2));
					cstmt.setString(6, fParamEmpno);
					cstmt.setString(7, fParamIp);
					cstmt.setString(8, "3");		//3=update rows[i].getJobType() );	//���콺�� �۾� ��
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);	
					cstmt.executeUpdate();
							
					String r_s_yn		= cstmt.getString(9);
					String r_msg_cd	 	= cstmt.getString(10);
					String r_msg		= cstmt.getString(11);
					
					if(!r_s_yn.equals("Y"))
						throw new Exception(r_msg);
					
					if(ds_result!=null){
						//GauceDataRow row1 = ds_result.newDataRow();
						//row1.addColumnValue(r_s_yn);
						//row1.addColumnValue(r_msg_cd);
						//row1.addColumnValue(r_msg);
						
						//ds_result.addDataRow(row1);	
					}
					if(cstmt!=null) cstmt.close();						
				}
			}

			if (ds_cust != null) {// �ο��׸��� ž������ ���� 
				GauceDataRow[] 		rows = ds_cust.getDataRows();
				int colNm_RsvSid			= ds_cust.indexOfColumn("RSV_SID");
				int colNm_CarRsvSid			= ds_cust.indexOfColumn("CAR_RSV_SID");
				int colNm_DriveYn  			= ds_cust.indexOfColumn("DONGSEUNG2");

				
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("ds_default "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
					cstmt.setInt(2, rows[i].getInt(colNm_CarRsvSid));
					cstmt.setString(3, rows[i].getString(colNm_DriveYn));
					cstmt.setString(4, fParamEmpno);
					cstmt.setString(5, fParamIp);
					cstmt.setString(6, "3");	//3=update rows[i].getJobType() );	//���콺�� �۾� ��
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	
					cstmt.executeUpdate();
							
					String r_s_yn		= cstmt.getString(7);
					String r_msg_cd	 	= cstmt.getString(8);
					String r_msg		= cstmt.getString(9);
					
					if(!r_s_yn.equals("Y"))
						throw new Exception(r_msg);
					
					if(ds_result!=null){
						//GauceDataRow row1 = ds_result.newDataRow();
						//row1.addColumnValue(r_s_yn);
						//row1.addColumnValue(r_msg_cd);
						//row1.addColumnValue(r_msg);
						
						//ds_result.addDataRow(row1);	
					}
					if(cstmt!=null) cstmt.close();						
				}
			}

			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}

}
