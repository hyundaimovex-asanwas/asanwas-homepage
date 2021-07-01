package pms.menu.help;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.hmm.ejb.util.EJBStringUtil;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.*; 
import oracle.jdbc.OracleTypes;

public class Pr431H extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

				//���ຯ�� ���� ��ȸ
				arr_sql[1].append ("	SELECT   																											\n")
							  .append ("		A.CD_SITE,                               	 	-- �����ڵ� 													\n")
							  .append ("		E.DS_SITE,                                		-- �����ڵ�  													\n")
							  .append ("		A.NO_SILHENG,                             	-- �����ȣ													\n")
							  .append ("		CASE A.TY_SILHENG  																						\n")
							  .append ("		WHEN 'A' THEN '������'  																						\n")
							  .append ("		WHEN 'B' THEN '������'  																						\n")																						
							  .append ("		WHEN 'C' THEN '�������'  																					\n")																						
							  .append ("		END AS TY_SILHENG,                        -- ���౸��  												\n")																						
							  .append ("		A.DS_SILHENG,                                -- ����  														\n")
							  .append ("		dbo.DZZFn_SelDate(A.DT_REQUEST) AS DT_REQUEST, -- ��û��  								\n")
							  .append ("		A.ID_REQUEST,                             -- ��û��ID[HIDDEN]  										\n")
							  .append ("		ISNULL(C.DS_HNAME,'') AS DS_REQUEST,      -- ��û��  											\n")
							  .append ("		A.TY_APPROVAL,                            -- �������[HIDDEN]  										\n")
							  .append ("		A.RM_BIGO                               -- ���  															\n")
							  .append ("		FROM  																											\n")
							  .append ("		DWAT_SITEBUDGET A  																						\n")
							  .append ("		LEFT OUTER JOIN DZZT_USERID C  																		\n")
							  .append ("		ON A.ID_REQUEST = C.ID_USER  																		\n")
							  .append ("		INNER JOIN DWZT_SITE E  																				\n")
							  .append ("		ON A.CD_SITE = E.CD_SITE  																				\n")
							  .append ("		WHERE  																											\n")
							  .append ("		A.CD_SITE  = ? 																								\n")
							  .append ("		AND A.NO_SILHENG = ? 																					\n");
				//System.out.println("a010001_s1 \n" + arr_sql[1].toString());			
		
				//���ຯ�� ���� ��ȸ
				 arr_sql[2].append ("	SELECT 																																					\n")
							  .append ("		A.CD_COST,          --�����ڵ�																													\n")
							  .append ("		A.CD_DKCOST,        --�����ڵ�																												\n")
							  .append ("		A.DS_COST,          --������																													\n")
							  .append ("		A.SZ_SIZE,          --�԰�																														\n")
							  .append ("		A.DS_UNIT,          --����																														\n")
							  .append ("		ISNULL(E.QN_TT_DOKUB,0) AS QN_TT_DOKUBPRE,      --����(����)����															\n")
							  .append ("		ISNULL(E.UP_TT_DOKUB,0) AS UP_TT_DOKUBPRE,      --����(����)�ܰ�															\n")
							  .append ("		ISNULL(E.AM_TT_DOKUB,0) AS AM_TT_DOKUBPRE,      --����(����)�ݾ�															\n")
							  .append ("		ISNULL(B.QN_TT_DOKUB,0) AS QN_TT_DOKUB,         --���޼���																	\n")
							  .append ("		ISNULL(B.UP_TT_DOKUB,0) AS UP_TT_DOKUB,         --���޴ܰ�																		\n")
							  .append ("		ISNULL(B.AM_TT_DOKUB,0) AS AM_TT_DOKUB,         --���ޱݾ�																	\n")
							  .append ("		ISNULL(B.AM_TT_DOKUB,0) - ISNULL(E.AM_TT_DOKUB,0) AS AM_TT_DOKUBCHA,  --��������								\n")
							  .append ("		ISNULL(E.QN_TT_SILHENG,0) AS QN_TT_SILHENGPRE,  --����(����)����															\n")
							  .append ("		ISNULL(E.UP_MATERIAL,0) AS UP_MATERIALPRE,    --����(����)���																\n")
							  .append ("		ISNULL(E.UP_LABOR,0) AS UP_LABORPRE,          --����(����)�빫																	\n")
							  .append ("		ISNULL(E.UP_COST,0) AS UP_COSTPRE,            --����(����)���																	\n")
							  .append ("		ISNULL(E.UP_TT_SILHENG,0) AS UP_TT_SILHENGPRE,  --����(����)�ܰ�[HIDDEN]												\n")
							  .append ("		ISNULL(E.AM_TT_SILHENG,0) AS AM_TT_SILHENGPRE,  --����(����)�ݾ�															\n")
							  .append ("		ISNULL(B.QN_TT_SILHENG,0) AS QN_TT_SILHENG,     --�������																	\n")
							  .append ("		ISNULL(B.UP_MATERIAL,0) AS UP_MATERIAL,       --�������																		\n")
							  .append ("		ISNULL(B.UP_LABOR,0) AS UP_LABOR,         --����빫																				\n")
							  .append ("		ISNULL(B.UP_COST,0) AS UP_COST,               --������																			\n")
							  .append ("		ISNULL(B.UP_TT_SILHENG,0) AS UP_TT_SILHENG,     --����ܰ�[HIDDEN]														\n")
							  .append ("		ISNULL(B.AM_TT_SILHENG,0) AS AM_TT_SILHENG,     --����ݾ�																	\n")
							  .append ("		ISNULL(B.AM_TT_SILHENG,0) - ISNULL(E.AM_TT_SILHENG,0) AS AM_TT_SILHENGCHA,  --��������						\n")
							  .append ("		B.RM_BIGO,    --���																																\n")
							  .append ("		CASE WHEN ISNULL(D.CD_COST,'') = '' THEN 'Y' ELSE 'N' END AS YN_NEW,       --�űԿ���[HIDDEN]						\n")
							  .append ("		CASE WHEN 																																		\n")
							  .append ("		B.QN_TT_DOKUB <> ISNULL(E.QN_TT_DOKUB,0) 																						\n")
							  .append ("		OR B.UP_TT_DOKUB <> ISNULL(E.UP_TT_DOKUB,0) 																					\n")
							  .append ("		OR B.AM_TT_DOKUB <> ISNULL(E.AM_TT_DOKUB,0) 																					\n")
							  .append ("		OR B.QN_TT_SILHENG <> ISNULL(E.QN_TT_SILHENG,0) 																				\n")
							  .append ("		OR B.UP_MATERIAL <> ISNULL(E.UP_MATERIAL,0) 																						\n")
							  .append ("		OR B.UP_LABOR <> ISNULL(E.UP_LABOR,0) 																								\n")
							  .append ("		OR B.UP_COST <> ISNULL(E.UP_COST,0) 																									\n")
							  .append ("		OR B.UP_TT_SILHENG <> ISNULL(E.UP_TT_SILHENG,0) 																				\n")
							  .append ("		OR B.AM_TT_SILHENG <> ISNULL(E.AM_TT_SILHENG,0) 																				\n")
							  .append ("		THEN 'Y' ELSE 'N' END AS YN_CHANGE, --���濩��																						\n")
							  .append ("		A.YN_COST,    --ǰ�񿩺�[HIDDEN]																											\n")
							  .append ("		A.GR_COST,    --��������[HIDDEN]																											\n")
							  .append ("		A.NO_ORDER1,  --����1[NIDDEN]																												\n")
							  .append ("		A.NO_ORDER2  --����2[NIDDEN]																												\n")
							  .append ("	FROM 																																					\n")
							  .append ("		DWZT_COST_CHANGE A																														\n")
							  .append ("		INNER JOIN DWAT_SILHENG_CHANGE B WITH (NOLOCK)																				\n")
							  .append ("		ON A.CD_SITE = B.CD_SITE 																													\n")
							  .append ("		AND A.CD_COST = B.CD_COST																												\n")
							  .append ("		AND A.NO_SILHENG = B.NO_SILHENG																										\n")
							  .append ("		LEFT OUTER JOIN DWZT_COST_CHANGE D    --<���� ������ ���� ������ ��������>												\n")
							  .append ("		ON A.CD_SITE = D.CD_SITE 																													\n")
							  .append ("		AND A.CD_COST = D.CD_COST																												\n")
							  .append ("		AND D.NO_SILHENG = ?																															\n")
							  .append ("		LEFT OUTER JOIN DWAT_SILHENG_CHANGE E WITH (NOLOCK)																		\n")
							  .append ("		ON A.CD_SITE = E.CD_SITE 																													\n")
							  .append ("		AND A.CD_COST = E.CD_COST																												\n")
							  .append ("		AND E.NO_SILHENG = ?																															\n")
							  .append ("		WHERE 																																				\n")
							  .append ("		A.CD_SITE = ? 																																	\n")
							  .append ("		AND A.NO_SILHENG = ?  --<������� �ڵ带 ��������>																					\n")						  
							  .append ("		ORDER BY																																			\n")
							  .append ("		CD_DKCOST																																		\n");

				 				//System.out.println("a010001_s1 \n" + arr_sql[2].toString());				
			
		
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

						String  v_cd_site			= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 		// 
						String  v_no_silheng		= HDUtil.nullCheckStr(greq.getParameter("v_no_silheng")); 		// 						

						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[1].toString());

						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_no_silheng);
						
						//System.out.println("v_cd_site ==== \n" + v_cd_site);	
						//System.out.println("v_no_silheng ==== \n" + v_no_silheng);								
						
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));

						rs.close();
						cstmt.close();
						conn_ms.close();

				}else if(dSets[i].getName().equals("ds_default2")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT2");
						
					
						String  v_cd_site			= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 		// 
						String  v_no_silheng		= HDUtil.nullCheckStr(greq.getParameter("v_no_silheng")); 		// 						
						int  v_no_silhengpre		= HDUtil.nullCheckNum(greq.getParameter("v_no_silheng")); 		// 
						
						v_no_silhengpre = v_no_silhengpre -1;
						
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[2].toString());
	
						cstmt.setInt(1, v_no_silhengpre);						
						cstmt.setInt(2, v_no_silhengpre);						
						cstmt.setString(3, v_cd_site);
						cstmt.setString(4, v_no_silheng);
						
						System.out.println("v_cd_site ==== \n" + v_cd_site);	
						System.out.println("v_no_silheng ==== \n" + v_no_silheng);							
						
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));

						rs.close();
						cstmt.close();
						conn_ms.close();
						
						
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