package sales.menu.rv;

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


public class Rv740I extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//��鵵 ���ǻ��� ��ȸ
		arr_sql[0].append("{call SALES.PR_RV740I_01 (?, ?, ?, ? ) }");
		
		// ��鵵 ���� ���� ���� 
		arr_sql[2].append("{call SALES.PR_RV740I_04 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");		
		//CALL SALES.PR_RV740I_04 ('20061001','20061002','IV',0,487,0,'','2030004','172.16.1.23','3',NULL,NULL,NULL);		
		
		
		// ���� ����  ����- ��ǰ������ ���� 
		arr_sql[3].append("{call SALES.PR_RV740I_05 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		//CALL SALES.PR_RV740I_05 ('20061001','20061002',1973897, 488, 0, 28, '2030004','172.16.1.23','3',NULL,NULL,NULL);
		
		
		// �ڵ�����
		arr_sql[4].append("{call SALES.PR_RV740I_07 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

		// ���� ����  ����- ���ڱⰣ ����
		arr_sql[5].append("{call SALES.PR_RV740I_06 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

		// ���ǻ��� ��� ��ȸ
		arr_sql[6].append("{call SALES.PR_RV740I_02 (?, ?, ?,? ) }");		

		  // ������ ��ȸ
		arr_sql[7].append("{call SALES.PR_RV740I_03 (?,?,?,?,?,   ?,?, ? ) }");

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

		String[] columnName = null;
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
			/* �˻��� �ʿ��� ���� */
			String sSDate 		= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// ����
			String sTDate 		= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// ���� 
			int sHotel 			= HDUtil.nullCheckNum(greq.getParameter("sUpjang"));	// ȣ�� 
			String sAccept_no	= HDUtil.nullCheckStr(greq.getParameter("sAccept_no")); // ��û����ȣ		
			int sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // ��ǰ SID
			String sClass 		= HDUtil.nullCheckStr(greq.getParameter("sClass")); // ��
			String sTeam		= HDUtil.nullCheckStr(greq.getParameter("sTeam")); // �� 
			String sAssign_YN	= HDUtil.nullCheckStr(greq.getParameter("sAssign_YN")); // �̹�����
			String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("sJobsel")); // ������
			
			/*StringUtil.printMsg("sSDATE - ", sSDate, this);
			StringUtil.printMsg("sTDATE - ", sTDate, this);
			StringUtil.printMsg("HOTEL - ", sHotel, this);
			StringUtil.printMsg("Accept_no - ", sAccept_no, this);
			StringUtil.printMsg("GoodSid - ", sGoodSid, this);
			StringUtil.printMsg("Class - ", sClass, this);
			StringUtil.printMsg("Team - ", sTeam, this);		
			StringUtil.printMsg("sAssign_YN - ", sAssign_YN, this);*/		
			

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					//StringUtil.printMsg("���ǻ�����ȸ ����",arr_sql[0].toString(), this);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, sHotel);	//IN    pUPJANG_SID  NUMERIC(10),  -- ������ SID
					cstmt.setString(2, sSDate);	//IN    pBGN_DATE    VARCHAR(8),   -- ��������
					cstmt.setString(3, sTDate);	//IN    pEND_DATE    VARCHAR(8)   -- ��������
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}

            	if(dSets[i].getName().equals("ds2")){	//�ϴ� ������ �׸���
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[7].toString());
					cstmt.setString(1, sSDate);		// ��������
					cstmt.setString(2, sAccept_no);	// ��û����ȣ						
					cstmt.setInt   (3, sGoodSid);	// ��ǰ SID
					cstmt.setString(4, sClass);		// ��
					cstmt.setString(5, sTeam);		// ��
					cstmt.setString(6, sAssign_YN);	// �̹���
					cstmt.setString(7, sJobsel);	// ������						
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}

            	if(dSets[i].getName().equals("ds3")){	//������� ��ȸ
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[6].toString());
					cstmt.setInt(1, sHotel);	//IN    pUPJANG_SID  NUMERIC(10),  -- ������ SID
					cstmt.setString(2, sSDate);	//IN    pBGN_DATE    VARCHAR(8),   -- ��������
					cstmt.setString(3, sTDate);	//IN    pEND_DATE    VARCHAR(8)   -- ��������
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}

            }

		}catch (SQLException sqle){
//			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
	//		res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(conn!=null) conn.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","������Ʈ",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");
		GauceDataSet ds3 = gis.read("DS3");
		GauceDataSet ds4 = gis.read("DS4");
		GauceDataSet ds_result = gis.read("RESULT");
		try {
			//���� ���� ���� JSP(I:DS1=ds1,O:RESULT=ds_result
			//���� �������� (��ǰ ������ ����)	JSP(I:DS2=ds2,O:RESULT=ds_result
			//���� �������� (���ڱⰣ ����)		JSP(I:DS4=ds2,O:RESULT=ds_result
			//�ڵ�����							JSP(I:DS3=ds2,O:RESULT=ds_result
			
			
			//�޽���ó��
			if(ds_result!=null){
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}


			// ��鵵 ���� ����			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				//CALL SALES.PR_RV740I_04 ('20061001','20061002','IV',0,487,0,'','2030004','172.16.1.23','3',NULL,NULL,NULL);
				String sSDate 				= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// ��������
				String sTDate 				= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// ��������
				int colNm_Room_Status		= ds1.indexOfColumn("ROOM_STATUS");
				int colNm_Room_Sid  		= ds1.indexOfColumn("ROOM_SID");

				for(int i=0; i<rows.length; i++){
					
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1, sSDate);
						cstmt.setString(2, sTDate);
						cstmt.setString(3, rows[i].getString(colNm_Room_Status));
						cstmt.setInt(4, 0);  
						cstmt.setInt(5, rows[i].getInt(colNm_Room_Sid));
						cstmt.setInt(6, 0);
						cstmt.setString(7, "");  
						cstmt.setString(8, fParamEmpno);
						cstmt.setString(9, fParamIp);
						cstmt.setString(10, "3");
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);				
						
						//StringUtil.printMsg("��鵵���º�������", cstmt.toString() , this);
						
						cstmt.executeUpdate();
						
						String r_s_yn		= cstmt.getString(11);
						String r_msg_cd	 	= cstmt.getString(12);
						String r_msg		= cstmt.getString(13);
						
						if(!r_s_yn.equals("Y"))
							throw new Exception(r_msg);
						
						if(ds_result!=null){
							ds_result.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
							ds_result.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
							ds_result.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
							ds_result.heap();								
						}
						if(cstmt!=null) cstmt.close();
					}
				}
			}
					
			// ���� ����  ���� - ��ǰ������ ����			
			if (ds2 != null) {
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
				String sSDate 				= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// ��������
				String sTDate 				= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// ��������
				int sGoodSid				= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // ��ǰ SID
				int colNm_Rsv_Sid			= ds2.indexOfColumn("RSV_SID");
				int colNm_Room_Sid  		= ds2.indexOfColumn("ROOM_SID");
				//StringUtil.printMsg("������", sSDate, this);
				//StringUtil.printMsg("������", sTDate, this);
				//StringUtil.printMsg("��ǰ�Ƶ�", sGoodSid, this);				
				
				for(int i=0; i<rows.length; i++){
					
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {

						//StringUtil.printMsg("����sid==", rows[i].getInt(colNm_Rsv_Sid), this);
						//StringUtil.printMsg("��sid==", rows[i].getInt(colNm_Room_Sid), this);
						//StringUtil.printMsg("������������",arr_sql[3].toString(), this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
												
						cstmt.setString(1, sSDate);
						cstmt.setString(2, sTDate);
						cstmt.setInt(3, rows[i].getInt(colNm_Rsv_Sid));
						cstmt.setInt(4, rows[i].getInt(colNm_Room_Sid));
						cstmt.setInt(5, 0);
						cstmt.setInt(6, sGoodSid);
						cstmt.setString(7, fParamEmpno);
						cstmt.setString(8, fParamIp);
						cstmt.setString(9, "3");
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);								
						
						cstmt.executeUpdate();
						
						String r_s_yn		= cstmt.getString(10);
						String r_msg_cd	 	= cstmt.getString(11);
						String r_msg		= cstmt.getString(12);
						
						if(!r_s_yn.equals("Y"))
							throw new Exception(r_msg);
						
						if(ds_result!=null){
							ds_result.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
							ds_result.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
							ds_result.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
							ds_result.heap();			
						}
						if(cstmt!=null) cstmt.close();
					}
				}				
			}
			
			// �ο� ���� ����  (�ڵ�����)
			if (ds3 != null) {
				String sSDate 		= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// ��������
				String sAccept_no	= HDUtil.nullCheckStr(greq.getParameter("sAccept_no")); // ��û����ȣ		
				int sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // ��ǰ SID
				//int sHotel 			= HDUtil.nullCheckNum(req.getParameter("sUpjang"));	// ȣ��
				String sClass 		= HDUtil.nullCheckStr(greq.getParameter("sClass")); // ��
				String sTeam		= HDUtil.nullCheckStr(greq.getParameter("sTeam")); // ��
				String sAssign_YN	= HDUtil.nullCheckStr(greq.getParameter("sAssign_YN")); // �̹�����		
				String sFromType	= HDUtil.nullCheckStr(greq.getParameter("sFromRoomType")); // ������Ÿ��
				String sToType		= HDUtil.nullCheckStr(greq.getParameter("sToRoomType")); // ���水��Ÿ��
				
				//int cnt = 1;
				////StringUtil.printMsg("����",arr_sql[4].toString(), this);
				cstmt = conn.prepareCall(arr_sql[4].toString());
										
				cstmt.setString(1, sSDate);
				cstmt.setString(2, sAccept_no);
				cstmt.setInt(3, sGoodSid);
				//cstmt.setInt(4, sHotel);
				cstmt.setString(4, sClass);
				cstmt.setString(5, sTeam);
				cstmt.setString(6, sAssign_YN);
				cstmt.setString(7, sFromType);
				cstmt.setString(8, sToType);
				cstmt.setString(9, fParamEmpno);
				cstmt.setString(10, fParamIp);
				cstmt.setString(11, "3");
				cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);								
				
				/*StringUtil.printMsg("1������", sSDate, this);
				StringUtil.printMsg("2��û����ȣ", sAccept_no, this);
				StringUtil.printMsg("3��ǰ�Ƶ�", sGoodSid, this);
				StringUtil.printMsg("4ȣ��", sHotel, this);
				StringUtil.printMsg("5��", sClass, this);
				StringUtil.printMsg("6��", sTeam, this);
				StringUtil.printMsg("7�̹�����", sAssign_YN, this);
				StringUtil.printMsg("8������Ÿ��", sFromType, this);
				StringUtil.printMsg("9���水��Ÿ��", sToType, this);						
				StringUtil.printMsg("10empno", fParamEmpno, this);
				StringUtil.printMsg("11ip", fParamIp, this);*/
										
				cstmt.executeUpdate();
				
				String r_s_yn		= cstmt.getString(12);
				String r_msg_cd	 	= cstmt.getString(13);
				String r_msg		= cstmt.getString(14);
				
				if(!r_s_yn.equals("Y"))
					throw new Exception(r_msg);
				
				if(ds_result!=null){
					ds_result.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
					ds_result.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
					ds_result.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
					ds_result.heap();
				}
				if(cstmt!=null) cstmt.close();				
			}

			// ���� ����  ���� - ���ڱⰣ ���� 
			if (ds4 != null) {
				GauceDataRow[] 		rows = ds4.getDataRows();
				GauceDataColumn[] 	cols = ds4.getDataColumns();

				String sSDate 				= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// ��������
				String sTDate 				= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// ��������
				int sGoodSid				= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // ��ǰ SID
				int colNm_Rsv_Sid			= ds4.indexOfColumn("RSV_SID");
				int colNm_Room_Sid  		= ds4.indexOfColumn("ROOM_SID");
			
				for(int i=0; i<rows.length; i++){
					
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {

						//StringUtil.printMsg("����sid==", rows[i].getInt(colNm_Rsv_Sid), this);
						//StringUtil.printMsg("��sid==", rows[i].getInt(colNm_Room_Sid), this);
						//StringUtil.printMsg("������������",arr_sql[5].toString(), this);
						cstmt = conn.prepareCall(arr_sql[5].toString());
												
						cstmt.setString(1, sSDate);
						cstmt.setString(2, sTDate);
						cstmt.setInt(3, rows[i].getInt(colNm_Rsv_Sid));
						cstmt.setInt(4, rows[i].getInt(colNm_Room_Sid));
						cstmt.setInt(5, 0);
						cstmt.setInt(6, sGoodSid);
						cstmt.setString(7, fParamEmpno);
						cstmt.setString(8, fParamIp);
						cstmt.setString(9, "3");
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);								
						
						cstmt.executeUpdate();
						
						String r_s_yn		= cstmt.getString(10);
						String r_msg_cd	 	= cstmt.getString(11);
						String r_msg		= cstmt.getString(12);
						
						if(!r_s_yn.equals("Y"))
							throw new Exception(r_msg);
						
						if(ds_result!=null){
							ds_result.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
							ds_result.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
							ds_result.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
							ds_result.heap();	
						}
						if(cstmt!=null) cstmt.close();
					}
				}
			
			}
			
			if(ds_result!=null) gos.write(ds_result);
			gos.close();		
		} catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}	

	}

}
