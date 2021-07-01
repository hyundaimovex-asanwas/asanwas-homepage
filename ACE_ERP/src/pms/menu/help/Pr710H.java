package pms.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.*; 
import oracle.jdbc.OracleTypes;

public class Pr710H extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//�빫�� �⺻���� ��ȸ
		arr_sql[1].append ("SELECT 					 																											\n")
					  .append ("       A.CD_SITE,         																											\n")
					  .append ("       B.DS_SITE,        																											\n")
					  .append ("       SUBSTRING(A.YM_WORK,0,5) + '�� ' + SUBSTRING(A.YM_WORK,5,2) + '�� '	AS DT_MONTH			\n")				  
					  .append ("       FROM	DSBT_MAGAM A INNER JOIN  DWZT_SITE B   ON  A.CD_SITE = B.CD_SITE     					\n")   
					  .append ("  WHERE A.CD_SITE = ?		AND A.YM_WORK = ?																			\n");					  	
		//System.out.println("a010001_s1 \n" + arr_sql[1].toString());				
		
		//�⿪ �� �빫�� ���� ��ȸ
		arr_sql[2].append ("SELECT 					 																											\n")
					  .append ("       A.DS_DEPT SITE_NM,     																								\n")		
					  .append ("       A.DS_NAME ENO_NM, A.NO_JUMIN CET_NO, A.AM_RWPAY WRK_AMT, A.WORK_CNT WRK_DAY,    \n")
					  .append ("       A.RT_GS GONGSU, 																										\n")
					  .append ("       A.AM_WONGA WRK_PAY,																									\n")					   		  
					  .append ("       A.AM_JIGUB AM_JIGUB																									\n")
					  .append ("       FROM	DSBV_WORK_LIST A     																							\n")   
					  .append ("  WHERE A.CD_SITE = ?		AND A.YM_WORK = ?																			\n");	
		
		
		
		//System.out.println("a010001_s1 \n" + arr_sql[2].toString());			
		
		//	����������� 
		arr_sql[3].append ("{call PMS.PR_PR710HS_03(?,?) }" );
		
		//	����������� 
		arr_sql[4].append ("{call PMS.PR_PR710HS_04(?,?) }" );		

		//	����ó�� 
		arr_sql[5].append ("{call PMS.PR_PR710HS_05(?,?,?,?) }" );				
		
		//	�ΰ�ó�� 
		arr_sql[6].append ("{call PMS.PR_PR710HS_06(?,?,?,?,?) }" );			
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 

			for(int i=0; i<dSets.length;i++){

				if(dSets[i].getName().equals("ds_default1")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT1");  

						String  v_cd_site		= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 			// 
						String  v_ym_work	= HDUtil.nullCheckStr(greq.getParameter("v_ym_work")); 		// 						

						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[1].toString());

						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_ym_work);

						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));

						rs.close();
						cstmt.close();
						conn_ms.close();

				}else if(dSets[i].getName().equals("ds_default2")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT2");
					
						String  v_cd_site		= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 			// 
						String  v_ym_work	= HDUtil.nullCheckStr(greq.getParameter("v_ym_work")); 		// 						

						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[2].toString());

						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_ym_work);
						//System.out.println("v_cd_site ==== \n" + v_cd_site);	
						//System.out.println("v_ym_work ==== \n" + v_ym_work);							
						
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));

						rs.close();
						cstmt.close();
						conn_ms.close();
						
				// ���� ���� ���� ��ȸ
				}else if(dSets[i].getName().equals("ds_default3")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT3"); 
					
						cstmt = conn.prepareCall(arr_sql[3].toString());

						int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// ����sid

						cstmt.setInt(1, v_ap_m_sid);

						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
						
				// ���� ���� ���� ��ȸ
				}else if(dSets[i].getName().equals("ds_default4")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT4"); 
							
						cstmt = conn.prepareCall(arr_sql[4].toString());

						int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// ����sid

						cstmt.setInt(1, v_ap_m_sid);

						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
								
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 			
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
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {	
		
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		GauceDataSet msgDS = gis.read("msgDS");
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
		      //���� ����ó��
			  if (msgDS != null & dsType==1) {

					cstmt = conn.prepareCall(arr_sql[5].toString());
					
					int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// ���� sid
					String  v_empno	= HDUtil.nullCheckStr(greq.getParameter("vEmpNo")); 			// ������ ���
					String  v_empnm	= HDUtil.nullCheckStr(greq.getParameter("vEmpNmk")); 			// ������ ����

					cstmt.setInt(1, v_ap_m_sid);
					cstmt.setString(2, v_empno);							
					cstmt.setString(3, v_empnm);	
					cstmt.registerOutParameter(4,  java.sql.Types.VARCHAR);

					cstmt.executeQuery();

			  //���� �ݼ�ó��			
			  }else if(msgDS != null & dsType==2){
				  
					cstmt = conn.prepareCall(arr_sql[6].toString());
					
					int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// ���� sid
					String  v_empno	= HDUtil.nullCheckStr(greq.getParameter("vEmpNo")); 			// ������ ���
					String  v_empnm	= HDUtil.nullCheckStr(greq.getParameter("vEmpNmk")); 			// ������ ����
					String  v_apdesc	= HDUtil.nullCheckStr(greq.getParameter("vApDesc")); 			// ������ �ݼ� �ǰ�
					
					cstmt.setInt(1, v_ap_m_sid);
					cstmt.setString(2, v_empno);							
					cstmt.setString(3, v_empnm);
					cstmt.setString(4, v_apdesc);					
					cstmt.registerOutParameter(5,  java.sql.Types.VARCHAR);

					cstmt.executeQuery();				  
				  
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