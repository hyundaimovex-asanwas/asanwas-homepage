package sales.menu.cu;

import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
 
import oracle.jdbc.OracleTypes;

public class Cu010S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		/*
		 * ������ȸ
		 * //01.��û����ȣ,02.������,03.���߱���,04.����,05.�븮�� SID,06.��������,07.�������,08.�ֹο���
		 */
		arr_sql[0].append("{call SALES.PR_CU010S_01( ?,?,?,?,?,   ?,?,?,? ) }");
		
		//�Ǹ�Ȯ�� ���� ȣ��
		arr_sql[1].append("{call SALES.PR_EAI_R_T_009( ?,?,?,?,?,   ? ) }");
			 
		//�Ǹ�Ȯ�� �ε� (�Ƹ��� �����ʸ�.. ����ϰ� �Ŀ�..)
		arr_sql[2].append("{call SALES.PR_EAI_S_S_007( ?,?,? ) }");
				 
	}
    
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {

	}	


	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		/*
		 * �˻��� �ʿ��� ����
		 */
		String sGroup_cd	= HDUtil.nullCheckStr(greq.getParameter("sGroup_cd"));	//01.��û����ȣ
		String sCust_gu		= HDUtil.nullCheckStr(greq.getParameter("sCust_gu"));	//02.������  
		String sRegi_yn_t	= HDUtil.nullCheckStr(greq.getParameter("sRegi_yn_t"));	//03.���߱���  
		String sCust_nm		= HDUtil.nullCheckStr(greq.getParameter("sCust_nm"));	//04.����    
		int	   sClient_sid	= HDUtil.nullCheckNum(greq.getParameter("sClient_sid"));	//05.�븮�� SID
		String sCountry_gu	= HDUtil.nullCheckStr(greq.getParameter("sCountry_gu"));	//06.��������  
		String sSaup_gu		= HDUtil.nullCheckStr(greq.getParameter("sSaup_gu"));	//07.�������  
		String sManage_no	= HDUtil.nullCheckStr(greq.getParameter("sManage_no"));	//08.�ֹο���  

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
						//��ȸ����
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, sGroup_cd);		//IN
						cstmt.setString(2, sCust_gu);		//IN
						cstmt.setString(3, sRegi_yn_t);		//IN
						cstmt.setString(4, sCust_nm);		//IN
						cstmt.setInt   (5, sClient_sid);		//IN
						cstmt.setString(6, sCountry_gu);		//IN
						cstmt.setString(7, sSaup_gu);		//IN 
						cstmt.setString(8, sManage_no);		//IN
						cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(9);	//Ŀ�� OUT param. 			
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
						
	

	/**
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		//StringUtil.printMsg("���ö��̴�??)", "",this);
		/*
		 * �˻��� �ʿ��� ����
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
		String sGroup_cd	= HDUtil.nullCheckStr(greq.getParameter("sGroup_cd"));	//01.��û����ȣ
		String sDir			= HDUtil.nullCheckStr(greq.getParameter("sDir"));	//02.�ۼ��ű���  
		StringUtil.printMsg("sDir:::)", sDir,this);
		
		try {
			GauceDataSet ds_result 		= greq.getGauceDataSet("DS_RESULT");	//�۽� ���			

			//���� ����
			String r_s_yn		= "";
			String r_msg_cd		= "";
			String r_msg		= "";
			
			Iterator it = greq.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = greq.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					if ("DS2".equals(gauceName)) {

						if(ds_result!=null){
							greq.enableFirstRow(ds_result);
							ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
							ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						}

						if("send".equals(sDir)){	//������ ����&�����ϴ� ���
							//StringUtil.printMsg("�Ǹ�Ȯ�� ��~:)", "��",this);
							cstmt = conn.prepareCall(arr_sql[1].toString());

							cstmt.setString     (1, sGroup_cd);
							cstmt.setString     (2, fParamEmpno);
							cstmt.setString     (3, fParamIp);
							cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
						
							r_s_yn 		= cstmt.getString(4);
							r_msg_cd 	= cstmt.getString(5);
							r_msg 		= cstmt.getString(6);
						
							if(!r_s_yn.equals("Y")){
								res.writeException("ERROR", r_msg_cd, r_msg);
							}
						
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
							
								ds_result.addDataRow(row1);
							}
						
							if(ds_result!=null) ds_result.flush();	
						}
						
						if("recv".equals(sDir)){	//������ �ε��ϴ� ��� 
							StringUtil.printMsg("�����鸸 �ε�)", "��",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());

							cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
						
							r_s_yn 		= cstmt.getString(1);
							r_msg_cd 	= cstmt.getString(2);
							r_msg 		= cstmt.getString(3);
						
							if(!r_s_yn.equals("Y")){
								res.writeException("ERROR", r_msg_cd, r_msg);
							}
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
							
								ds_result.addDataRow(row1);
							}
							if(ds_result!=null) ds_result.flush();	
						}
					}
				}
			}
		}catch (SQLException sqle){
			sqle.printStackTrace();
			greq.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			greq.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}
}