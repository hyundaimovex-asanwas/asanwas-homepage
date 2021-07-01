package pms.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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

public class Pr750H extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//����Ϻ� �⺻���� ��ȸ
		arr_sql[1].append ("		SELECT    																														\n")
					  .append ("       DBO.DZZFN_SELDATE(A.DT_WORK) AS DT_WORK,	-- �۾�����												\n")
					  .append ("       A.NO_EQUIP,	-- ����ȣ																								\n")
					  .append ("       E.MD_EQUIP,	-- ����																									\n")
					  .append ("       E.SZ_EQUIP,	-- �԰�																										\n")
					  .append ("       A.QN_WORK,		-- �۾��ð�																								\n")
					  .append ("       A.HM_FRWORK,	-- �ð�(����)																							\n")
					  .append ("       A.HM_TOWORK,	-- �ð�(����)																							\n")
					  .append ("       A.UP_WORK,		-- �ܰ�																									\n")
					  .append ("       A.AM_WORK,		-- �ݾ�																								\n")
					  .append ("       A.AT_WORK,		-- ������																								\n")
					  .append ("       A.DS_WORK,		-- �۾�����																								\n")
					  .append ("       A.CD_COST,		-- �����ڵ�																								\n")
					  .append ("       S.CD_DKCOST,		-- �����ڵ�																							\n")
					  .append ("       S.DS_ITEM,		-- ������																									\n")
					  .append ("       C.VEND_NM AS DS_VENDOR		-- ��ü��																				\n")
					  .append ("   FROM    DEAT_ILBO A																											\n")
					  .append ("		INNER JOIN DEAT_EQUIP E ON E.CD_SITE = A.CD_SITE AND E.NO_EQUIP = A.NO_EQUIP 				\n")
					  .append ("		LEFT OUTER JOIN OIFV_VENDOR C  ON E.CD_VENDOR = C.VEND_ID											\n")
					  .append ("		LEFT OUTER JOIN DWAT_SILHENG S ON S.CD_SITE = A.CD_SITE AND S.CD_COST = A.CD_COST		\n")
					  .append ("   WHERE  A.CD_SITE = ?																										\n")
					  .append ("		AND	   SUBSTRING(A.DT_WORK,1,6) = ?																				\n");
		//System.out.println("a010001_s1 \n" + arr_sql[1].toString());				
		
		
		//����Ϻ� ���� ��ȸ
		arr_sql[2].append ("		SELECT    																														\n")
					  .append ("       A.CD_SITE,         																											\n")
					  .append ("       B.DS_SITE,        																											\n")
					  .append ("       SUBSTRING(A.DT_WORK,0,5) + '�� ' + SUBSTRING(A.DT_WORK,5,2) + '�� ' AS DT_MONTH			\n")				  
					  .append ("    FROM	DEAT_ILBO A INNER JOIN  DWZT_SITE B   ON  A.CD_SITE = B.CD_SITE     							\n")   
					  .append ("  	WHERE A.CD_SITE = ?	AND SUBSTRING(A.DT_WORK,1,6) = ?													\n");		

		//System.out.println("a010001_s1 \n" + arr_sql[1].toString());			
		
		//	����������� 
		arr_sql[3].append ("{call PMS.PR_PR010HS_03(?,?) }" );
		
		//	����������� 
		//arr_sql[4].append ("{call PMS.PR_PR010HS_04(?,?) }" );		

		//	����ó�� 
		arr_sql[5].append ("{call PMS.PR_PR010HS_05(?,?,?,?) }" );				
		
		//	�ΰ�ó�� 
		arr_sql[6].append ("{call PMS.PR_PR010HS_06(?,?,?,?,?) }" );			
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

						//System.out.println("v_cd_site ==== \n" + v_cd_site);	
						//System.out.println("v_ym_work ==== \n" + v_ym_work);										
						
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[2].toString());

						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_ym_work);				
						
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