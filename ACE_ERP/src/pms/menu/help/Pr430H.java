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

public class Pr430H extends SuperServlet {
	
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
				arr_sql[2].append ("	SELECT   																											\n")
							  .append ("		A.CD_SITE,                                -- �����ڵ�[HIDDEN]  											\n")
							  .append ("		E.DS_SITE,                                -- �����ڵ�[HIDDEN]  											\n")
							  .append ("		A.NO_SILHENG,                             -- �����ȣ														\n")
							  .append ("		CASE A.TY_SILHENG  																						\n")
							  .append ("		WHEN 'A' THEN '��(����)����'  																				\n")
							  .append ("		WHEN 'B' THEN '������'  																						\n")																						
							  .append ("		WHEN 'C' THEN '�������'  																					\n")																						
							  .append ("		END AS TY_SILHENG,                        -- ���౸��  												\n")																						
							  .append ("		A.DS_SILHENG,                                -- ����  														\n")
							  .append ("		ISNULL(B.AM_DOKUB,0) AS AM_DOKUB_PRE,            -- ���ʵ���								\n")
							  .append ("		A.AM_DOKUB AS AM_DOKUB_CUR,				-- ���浵��											\n")
							  .append ("		A.AM_DOKUB - ISNULL(B.AM_DOKUB,0) AS AM_DOKUB_CHA,  -- ��������					\n")
							  .append ("		ISNULL(B.AM_SILHENG,0) AS AM_SILHENG_PRE,           -- ���ʽ���  							\n")
							  .append ("		A.AM_SILHENG AS AM_SILHENG_CUR,                     -- �������  								\n")
							  .append ("		A.AM_SILHENG - ISNULL(B.AM_SILHENG,0) AS AM_SILHENG_CHA,  -- ��������				\n")
							  .append ("		CASE 																											\n")
							  .append ("		WHEN ISNULL(B.AM_DOKUB,0) = 0 THEN 0															\n")
							  .append ("		ELSE (ISNULL(B.AM_SILHENG,0)/CAST(ISNULL(B.AM_DOKUB,0) AS FLOAT))*100			\n")
							  .append ("		END AS RT_SILHENG_PRE,                    -- ���ʽ�����												\n")
							  .append ("		CASE 																											\n")
							  .append ("		WHEN ISNULL(A.AM_DOKUB,0) = 0 THEN 0															\n")
							  .append ("		ELSE (ISNULL(A.AM_SILHENG,0)/CAST(ISNULL(A.AM_DOKUB,0) AS FLOAT))*100			\n")
							  .append ("		END AS RT_SILHENG_CUR,                    -- ���������  											\n")
							  .append ("		dbo.DZZFn_SelDate(A.DT_REQUEST) AS DT_REQUEST, -- ��û��  								\n")
							  .append ("		A.ID_REQUEST,                             -- ��û��ID[HIDDEN]  										\n")
							  .append ("		ISNULL(C.DS_HNAME,'') AS DS_REQUEST,      -- ��û��  											\n")
							  .append ("		A.TY_APPROVAL,                            -- �������[HIDDEN]  										\n")
							  .append ("		A.RM_BIGO                               -- ���  															\n")
							  .append ("		FROM  																											\n")
							  .append ("		DWAT_SITEBUDGET A  																						\n")
							  .append ("		LEFT OUTER JOIN DWAT_SITEBUDGET B  																\n")
							  .append ("		ON A.CD_SITE = B.CD_SITE  																				\n")
							  .append ("		AND B.NO_SILHENG = dbo.DWXFN_GET_SILHENGPRE(A.CD_SITE, A.NO_SILHENG)  		\n")
							  .append ("		LEFT OUTER JOIN DZZT_USERID C  																		\n")
							  .append ("		ON A.ID_REQUEST = C.ID_USER  																		\n")
							  .append ("		LEFT OUTER JOIN DZZT_USERID D  																		\n")
							  .append ("		ON A.ID_CONFIRM = D.ID_USER  																			\n")
							  .append ("		INNER JOIN DWZT_SITE E  																				\n")
							  .append ("		ON A.CD_SITE = E.CD_SITE  																				\n")
							  .append ("		WHERE  																											\n")
							  .append ("		A.CD_SITE  = ? 																								\n")
							  .append ("		AND A.NO_SILHENG = ? 																					\n")
							  .append ("		ORDER BY  																										\n")
							  .append ("		A.CD_SITE, ISNULL(A.NO_SEQAPP,999), A.NO_SEQMAKE, A.NO_SILHENG 					\n");
		//System.out.println("a010001_s1 \n" + arr_sql[1].toString());				
		

		//	����������� 
		arr_sql[3].append ("{call PMS.PR_PR430HS_03(?,?) }" );
		
		//	����������� 
		arr_sql[4].append ("{call PMS.PR_PR430HS_04(?,?) }" );		

		//	����ó�� 
		arr_sql[5].append ("{call PMS.PR_PR430HS_05(?,?,?,?) }" );				
		
		//	�ΰ�ó�� 
		arr_sql[6].append ("{call PMS.PR_PR430HS_06(?,?,?,?,?) }" );			
		
		//������, ������, ���濹�� ����Ʈ ���� ��ȸ
		arr_sql[7].append ("	SELECT   																											\n")
					  .append ("		A.CD_SITE,                               	 	-- �����ڵ� 													\n")
					  .append ("		E.DS_SITE,                                		-- �����ڵ�  													\n")	
					  .append ("		E.DS_CLIENT,                                		 															\n")						  
					  .append ("		A.NO_SILHENG,                             	-- �����ȣ													\n")

					  .append ("		A.AM_DOKUB,                             																		\n")
					  .append ("		A.AM_SILHENG,                             																	\n")			
					  .append ("		CASE 																											\n")
					  .append ("		WHEN ISNULL(A.AM_DOKUB,0) = 0 THEN 0															\n")
					  .append ("		ELSE ROUND((ISNULL(A.AM_SILHENG,0)/CAST(ISNULL(A.AM_DOKUB,0) AS FLOAT))*100,2)			\n")
					  .append ("		END AS RT_SILHENG_CUR,                    -- ���������  											\n")					  
					  
					  .append ("		ISNULL(C.DS_HNAME,'') AS DS_REQUEST,      -- ��û��  											\n")	
					  
					  .append ("		CASE A.TY_SILHENG  																						\n")
					  .append ("		WHEN 'A' THEN '������'  																						\n")
					  .append ("		WHEN 'B' THEN '������'  																						\n")																						
					  .append ("		WHEN 'C' THEN '�������'  																					\n")																						
					  .append ("		END AS TY_SILHENG                        				  												    \n")																						
					  .append ("		FROM  																											\n")
					  .append ("		DWAT_SITEBUDGET A  																						\n")
					  .append ("		LEFT OUTER JOIN DZZT_USERID C  																		\n")
					  .append ("		ON A.ID_REQUEST = C.ID_USER  																		\n")					  
					  .append ("		INNER JOIN DWZT_SITE E  																				\n")
					  .append ("		ON A.CD_SITE = E.CD_SITE  																				\n")
					  .append ("		WHERE  																											\n")
					  .append ("		A.CD_SITE  = ? 																								\n")
					  .append ("		AND A.NO_SILHENG = ? 																					\n");
		
		
		//���躯��, ������� ����Ʈ ���� ��ȸ
		arr_sql[8].append ("	SELECT   																											\n")
					  .append ("		A.CD_SITE,                               	 	-- �����ڵ� 													\n")
					  .append ("		E.DS_SITE,                                		-- �����ڵ�  													\n")
					  .append ("		CONVERT(varchar(8000),E.DS_REMARK) DS_REMARK, -- ���簳��  								\n")		
					  
					  .append ("		E.DS_CLIENT,                                		 															\n")						  
					  .append ("		A.NO_SILHENG,                             	-- �����ȣ													\n")
					  .append ("		CASE A.TY_SILHENG  																						\n")
					  .append ("		WHEN 'A' THEN '������'  																						\n")
					  .append ("		WHEN 'B' THEN '������'  																						\n")																						
					  .append ("		WHEN 'C' THEN '�������'  																					\n")																						
					  .append ("		END AS TY_SILHENG,                       																	\n")																						
					  .append ("		A.DS_SILHENG,                                 																\n")
					  .append ("		CONTRCT.AM_SUPPLY,                            															\n")
					  .append ("		CONTRCT.AM_SUPPLY_OUR,                                												\n")
					  .append ("		GASUL.GASUL,																									\n")
					  .append ("		ROUND(ISNULL(GASUL.GASUL,0)/ISNULL(CONTRCT.AM_SUPPLY,0)*100,2) AS GASUL_SUPPLY,							\n")					  
					  .append ("		BUDAE.BUDAE,																																		\n")	
					  .append ("		ROUND(ISNULL(BUDAE.BUDAE,0)/ISNULL(CONTRCT.AM_SUPPLY,0)*100,2) AS BUDAE_SUPPLY,							\n")							  
					  .append ("		KYUNGSANG.KYUNGSANG,																														\n")				
					  .append ("		ROUND(ISNULL(KYUNGSANG.KYUNGSANG,0)/ISNULL(CONTRCT.AM_SUPPLY,0)*100,2) AS KYUNGSANG_SUPPLY,		\n")		
					  .append ("		P.HAP,																																				\n")		
					  .append ("		ROUND(ISNULL(P.HAP,0)/ISNULL(CONTRCT.AM_SUPPLY,0)*100,2) AS HAP_SUPPLY,											\n")					  
					  .append ("		JA.UP_MATERIAL,																																	\n")	
					  .append ("		ROUND(ISNULL(JA.UP_MATERIAL,0)/ISNULL(CONTRCT.AM_SUPPLY,0)*100,2) AS UP_MATERIAL_SUPPLY,				\n")					  
					  .append ("		ISNULL(NOM.UP_LABOR,0) UP_LABOR,																																		\n")	
					  .append ("		ROUND(ISNULL(NOM.UP_LABOR,0)/ISNULL(CONTRCT.AM_SUPPLY,0)*100,2) AS UP_LABOR_SUPPLY,						\n")					  
					  .append ("		KUNG.UP_COST,																																	\n")		
					  .append ("		ROUND(ISNULL(KUNG.UP_COST,0)/ISNULL(CONTRCT.AM_SUPPLY,0)*100,2) AS UP_COST_SUPPLY,						\n")					  
					  .append ("		SUBSTRING(E.DT_FROM,1,4) + '.' + SUBSTRING(E.DT_FROM,5,2) + '.' + SUBSTRING(E.DT_FROM,7,2)  AS DT_FROM, 		\n")	
					  .append ("		SUBSTRING(E.DT_TO,1,4) + '.' + SUBSTRING(E.DT_TO,5,2) + '.' + SUBSTRING(E.DT_TO,7,2)  AS DT_TO 						\n")					  
				  
					  .append ("		FROM  																											\n")
					  .append ("		DWAT_SITEBUDGET A  																						\n")
					  .append ("		INNER JOIN DWZT_SITE E  																				\n")
					  .append ("		ON A.CD_SITE = E.CD_SITE  																				\n")
					  // ����Ʈ ���ʿ� ���ݾ� ���س���
					  .append ("		LEFT OUTER JOIN  																							\n")
					  .append ("		( SELECT CD_FIELD,																							\n")					  
					  .append ("		SUM(ISNULL(AM_INIT_SUPPLY,0)+ISNULL(AM_CHNGE_SUPPLY,0)) AS AM_SUPPLY,		\n")	
					  .append ("		SUM(ISNULL(AM_INIT_SUPPLY_OUR,0)+ISNULL(AM_INIT_SUPPLY_PART,0)+ISNULL(AM_CHNGE_SUPPLY_OUR,0)+ISNULL(AM_CHNGE_SUPPLY_PART,0)) AS AM_SUPPLY_OUR		\n")						  
					  .append ("							  FROM DOZT_CONST_CONTRCT														\n")
					  .append ("		WHERE CD_FIELD = ? GROUP BY CD_FIELD																\n")
					  .append ("		) AS CONTRCT ON A.CD_SITE = CONTRCT.CD_FIELD												\n")
					  // ����Ʈ ����ʿ� ���밡���ݾ� ���س���					  
					  .append ("		LEFT OUTER JOIN  																							\n")					  
					  .append ("		( SELECT 		B.CD_SITE,																					\n")
					  .append ("		    ISNULL(B.AM_TT_SILHENG,0) AS GASUL															\n")
					  .append ("		FROM 																											\n")
					  .append ("		    DWZT_COST A WITH (NOLOCK)																		\n")
					  .append ("		    INNER JOIN DWAT_SILHENG B ON B.CD_SITE = A.CD_SITE AND B.CD_COST = A.CD_COST	\n")
					  .append ("		WHERE 																													\n")
					  .append ("		    B.CD_SITE = ? AND A.DS_COST LIKE '%���밡����%'					  						\n")
					  .append ("		) AS GASUL ON A.CD_SITE = GASUL.CD_SITE														\n")
					  // ����Ʈ ����ʿ� ����δ��ݾ� ���س���						  
					  .append ("		LEFT OUTER JOIN  																							\n")					  
					  .append ("		( SELECT 		B.CD_SITE,																					\n")
					  .append ("		    ISNULL(B.AM_TT_SILHENG,0) AS BUDAE															\n")
					  .append ("		FROM 																											\n")
					  .append ("		    DWZT_COST A WITH (NOLOCK)																		\n")
					  .append ("		    INNER JOIN DWAT_SILHENG B ON B.CD_SITE = A.CD_SITE AND B.CD_COST = A.CD_COST	\n")
					  .append ("		WHERE 																													\n")
					  .append ("		    B.CD_SITE = ? AND A.DS_COST LIKE '%����δ��%'					  						\n")
					  .append ("		) AS BUDAE ON A.CD_SITE = BUDAE.CD_SITE														\n")					  
					  // ����Ʈ ����ʿ� ���� �ݾ� ���س���						  
					  .append ("		LEFT OUTER JOIN  																							\n")					  
					  .append ("		( SELECT 		B.CD_SITE,																					\n")
					  .append ("		    ISNULL(B.AM_TT_SILHENG,0) AS KYUNGSANG													\n")
					  .append ("		FROM 																											\n")
					  .append ("		    DWZT_COST A WITH (NOLOCK)																		\n")
					  .append ("		    INNER JOIN DWAT_SILHENG B ON B.CD_SITE = A.CD_SITE AND B.CD_COST = A.CD_COST	\n")
					  .append ("		WHERE 																													\n")
					  .append ("		    B.CD_SITE = ? AND A.DS_COST LIKE '%����%'					  										\n")
					  .append ("		) AS KYUNGSANG ON A.CD_SITE = KYUNGSANG.CD_SITE													\n")					  
					  // ����Ʈ �Ʒ��ʿ� �հ� �ݾ� ���س���						  
					  .append ("		LEFT OUTER JOIN  																									\n")					  
					  .append ("		( SELECT 		B.CD_SITE,																							\n")
					  .append ("		    ISNULL(B.AM_TT_SILHENG,0) AS HAP																		\n")
					  .append ("		FROM 																													\n")
					  .append ("		    DWZT_COST A WITH (NOLOCK)																				\n")
					  .append ("		    INNER JOIN DWAT_SILHENG B ON B.CD_SITE = A.CD_SITE AND B.CD_COST = A.CD_COST	\n")
					  .append ("		WHERE 																													\n")
					  .append ("		    B.CD_SITE = ? AND A.CD_DKCOST = 'P'					  												\n")
					  .append ("		) AS P ON A.CD_SITE = P.CD_SITE																				\n")						  
					  // ����Ʈ ���ʿ� ���� �ݾ� ���س���						  
					  .append ("		LEFT OUTER JOIN  																								\n")						  
					  .append ("		( SELECT 		MAX(B.CD_SITE) CD_SITE,																	\n")	
					  .append ("		SUM(B.UP_MATERIAL * B.QN_TT_SILHENG) UP_MATERIAL											\n")							  				  
				      .append ("		FROM 																												\n")
					  .append ("		    DWZT_COST A WITH (NOLOCK)																			\n")
					  .append ("		    INNER JOIN DWAT_SILHENG B																				\n")
					  .append ("		        ON B.CD_SITE = A.CD_SITE 																			\n")
					  .append ("		        AND B.CD_COST = A.CD_COST																		\n")
					  .append ("		WHERE 																												\n")
					  .append ("		    B.CD_SITE = ? AND A.CD_GBIMOK IN ('01')															\n")
					  .append ("		GROUP BY A.CD_GBIMOK					  																	\n")
					  .append ("		) AS JA ON A.CD_SITE = JA.CD_SITE																		\n")							  
					  // ����Ʈ ���ʿ� �빫�� �ݾ� ���س���						  
					  .append ("		LEFT OUTER JOIN  																								\n")						  
					  .append ("		( SELECT 		MAX(B.CD_SITE) CD_SITE,																	\n")						  
					  .append ("		SUM(B.UP_LABOR * B.QN_TT_SILHENG) UP_LABOR														\n")						  
				      .append ("		FROM 																												\n")
					  .append ("		    DWZT_COST A WITH (NOLOCK)																			\n")
					  .append ("		    INNER JOIN DWAT_SILHENG B																				\n")
					  .append ("		        ON B.CD_SITE = A.CD_SITE 																			\n")
					  .append ("		        AND B.CD_COST = A.CD_COST																		\n")
					  .append ("		WHERE 																												\n")
					  .append ("		    B.CD_SITE = ? AND A.CD_GBIMOK IN ('02')															\n")
					  .append ("		GROUP BY A.CD_GBIMOK					  																	\n")
					  .append ("		) AS NOM ON A.CD_SITE = NOM.CD_SITE																		\n")						  
					  // ����Ʈ ���ʿ� ��� �ݾ� ���س���						  
					  .append ("		LEFT OUTER JOIN  																								\n")						  
					  .append ("		( SELECT 		MAX(B.CD_SITE) CD_SITE,																	\n")
					  .append ("		SUM(B.UP_COST * B.QN_TT_SILHENG)	UP_COST														\n")						  
				      .append ("		FROM 																												\n")
					  .append ("		    DWZT_COST A WITH (NOLOCK)																			\n")
					  .append ("		    INNER JOIN DWAT_SILHENG B																				\n")
					  .append ("		        ON B.CD_SITE = A.CD_SITE 																			\n")
					  .append ("		        AND B.CD_COST = A.CD_COST																		\n")
					  .append ("		WHERE 																												\n")
					  .append ("		    B.CD_SITE = ? AND A.CD_GBIMOK IN ('03')															\n")
					  .append ("		GROUP BY A.CD_GBIMOK					  																	\n")
					  .append ("		) AS KUNG ON A.CD_SITE = KUNG.CD_SITE																\n")						  
					  
					  .append ("		WHERE  																												\n")
					  .append ("		A.CD_SITE  = ? 																									\n")
					  .append ("		AND A.NO_SILHENG = ? 																						\n");
		
		
		//System.out.println("a010001_s1 \n" + arr_sql[8].toString());	
		
		//	���� + ����������� 
		arr_sql[9].append ("{call PMS.PR_PR430HS_09(?,?) }" );			
		
		
		
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
	
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[2].toString());
	
						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_no_silheng);
						
						//System.out.println("v_cd_site ==== \n" + v_cd_site);	
						//System.out.println("v_no_silheng ==== \n" + v_no_silheng);							
						
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

				// Report ���� ��ȸ
				}else if(dSets[i].getName().equals("ds_default5")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT5"); 
									
						String  v_cd_site			= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 		// 
						String  v_no_silheng		= HDUtil.nullCheckStr(greq.getParameter("v_no_silheng")); 		// 						
	
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[7].toString());
	
						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_no_silheng);				
						
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));

						rs.close();
						cstmt.close();	
						conn_ms.close();
						
				// Report ���� ��ȸ
				}else if(dSets[i].getName().equals("ds_default6")){

					
						GauceDataSet ds1 = gis.read("DS_DEFAULT6"); 
									
						String  v_cd_site			= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 		// 
						String  v_no_silheng		= HDUtil.nullCheckStr(greq.getParameter("v_no_silheng")); 		// 						
	
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[8].toString());

						cstmt.setString(1, v_cd_site);						
						cstmt.setString(2, v_cd_site);
						cstmt.setString(3, v_cd_site);
						cstmt.setString(4, v_cd_site);
						cstmt.setString(5, v_cd_site);	
						cstmt.setString(6, v_cd_site);					
						cstmt.setString(7, v_cd_site);	
						cstmt.setString(8, v_cd_site);					
						cstmt.setString(9, v_cd_site);							
						cstmt.setString(10, v_no_silheng);

						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));

						//System.out.println("rs ==== \n" + rs.getString(v_cd_site));	
						//System.out.println("ds1 ==== \n" + ds1.toString());							
						
						rs.close();
						cstmt.close();
						conn_ms.close();
						
				// Report ���� ��ȸ
				}else if(dSets[i].getName().equals("ds_default7")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT7"); 
						
						cstmt = conn.prepareCall(arr_sql[9].toString());
	
						int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// ����sid
	
						//System.out.println("v_ap_m_sid = \n" + v_ap_m_sid);					
						
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