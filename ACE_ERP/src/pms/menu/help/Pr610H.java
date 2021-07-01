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

public class Pr610H extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//자재청구서 기본사항 조회
		arr_sql[1].append ("SELECT 					 																														\n")
					  .append ("		SUBSTRING(A.NO_MR,1,8) + '-' + SUBSTRING(A.NO_MR,9,4)  AS NO_MR,  												\n")		
					  .append ("		SUBSTRING(A.DT_REQUEST,1,4) + '년 ' + SUBSTRING(A.DT_REQUEST,5,2) + '월 ' +  SUBSTRING(A.DT_REQUEST,7,2) + '일'  AS DT_REQUEST,  	\n")
			  
					  .append ("		A.RM_REQUEST   AS RM_REQUEST,  																								\n")
					  .append ("		A.CD_SITE    AS CD_SITE,  																											\n")
					  .append ("		B.DS_DEPT    AS DS_DEPT,  																											\n")
					  .append ("		M.CNT_ITEM AS CNT_ITEM,  																											\n")
					  .append ("		M.QN_ITEM AS QN_ITEM,																												\n")
					  .append ("		CONVERT(DECIMAL, M.AM_ITEM) AS AM_ITEM,																												\n")
					  .append ("		ISNULL(A.CD_BUYTYPE,'')		AS CD_BUYTYPE,  																				\n")
					  .append ("		ISNULL(A.DS_RESOURCE,'')		AS DS_RESOURCE,   																				\n")
					  .append ("		ISNULL(A.YN_END, 'N')			AS YN_END,  																						\n")
					  .append ("		A.YN_SITEEXPLAIN,  																													\n")
					  .append ("		ISNULL(A.DS_BUYTYPE, '') AS DS_BUYTYPE,  																					\n")
					  
					  .append ("		SUBSTRING(A.FR_DELIVERY,1,4) + '년 ' + SUBSTRING(A.FR_DELIVERY,5,2) + '월 ' +  SUBSTRING(A.FR_DELIVERY,7,2) + '일'  AS FR_DELIVERY,  			\n")					  
					  .append ("		SUBSTRING(A.TO_DELIVERY,1,4) + '년 ' + SUBSTRING(A.TO_DELIVERY,5,2) + '월 ' +  SUBSTRING(A.TO_DELIVERY,7,2) + '일'  AS TO_DELIVERY,  			\n")
					  .append ("		SUBSTRING(A.DT_CONTRACT,1,4) + '년 ' + SUBSTRING(A.DT_CONTRACT,5,2) + '월 ' +  SUBSTRING(A.DT_CONTRACT,7,2) + '일'  AS DT_CONTRACT,  	\n")

					  .append ("		A.CD_SITEDAM,  																															\n")
					  .append ("		D.DS_HNAME,  																															\n")
					  .append ("		A.RM_ETC,																																	\n")
					  //.append ("		@DS_FILENAME AS DS_FILE,																									\n")
					  .append ("		SUBSTRING(A.DT_EXPLAIN,1,4) + '년 ' + SUBSTRING(A.DT_EXPLAIN,5,2) + '월 ' +  SUBSTRING(A.DT_EXPLAIN,7,2) + '일'  AS DT_EXPLAIN,  	\n")					  
					  .append ("		SUBSTRING(A.DT_EXPLAIN,9,2)  AS HH_EXPLAIN,      																			\n")
					  .append ("		SUBSTRING(A.DT_EXPLAIN,11,2) AS MM_EXPLAIN,																				\n")
					  .append ("		A.AT_SITEEXPLAIN,																														\n")
					  .append ("		A.CD_PAYMENT,																															\n")
					  .append ("		Z.DS_PAYMENT,																															\n")
					  .append ("		A.CD_DELIVERY,																															\n")
					  .append ("		X.DS_CODE AS DS_DELIVERY,																											\n")
					  .append ("		ISNULL(A.RT_CONTRACT,0) AS RT_CONTRACT,																					\n")
					  .append ("		ISNULL(A.RT_FLAW,0) AS RT_FLAW,																								\n")
					  .append ("		ISNULL(A.DS_FLAWTERM,'0') AS DS_FLAWTERM,																				\n")
					  .append ("		ISNULL(A.DS_DELAY,'0') AS DS_DELAY																								\n")
					  .append ("	FROM    DMAT_MR A  																														\n")
					  .append ("	 	INNER JOIN DZZT_DEPT B ON A.CD_SITE = B.CD_DEPT  																		\n")
					  
					  .append ("	  	INNER JOIN ( SELECT NO_MR, COUNT(DISTINCT CD_ITEM) CNT_ITEM,  													\n")
					  .append ("	  								SUM(QN_ITEM) QN_ITEM, SUM(AM_ITEM) AM_ITEM 												\n")					  
					  .append ("	    				FROM DMAT_MRITEM  WHERE NO_MR = ? GROUP BY NO_MR ) 												\n")
					  .append ("	   		M ON A.NO_MR = M.NO_MR 																										\n")
					  
					  .append ("	 LEFT OUTER JOIN DZZT_USERID D ON A.CD_SITEDAM = D.ID_USER  														\n")
					  .append ("	 LEFT OUTER JOIN DMZV_AP_PAYMENT  Z ON  A.CD_PAYMENT  = Z.CD_PAYMENT      									\n")
					  .append ("	 LEFT OUTER JOIN DMZT_CODE X ON X.CD_TYPE  = 'AC' AND A.CD_DELIVERY = X.CD_CODE    						\n")  
					  .append ("	WHERE A.NO_MR   = ? 																														\n");
		
		//System.out.println("a010001_s1 \n" + arr_sql[1].toString());				
		
		//청구서 품목정보 Grid
		//도급수량, 실행수량은 공사시스템의 실행예산(DWAT_SILHENG)에서 조회할 것      
		arr_sql[20].append ("  SELECT																																\n")
					  .append ("		ISNULL(A.SN_NO,'') AS SN_NO2, --순번,																				\n")
					  .append ("		ISNULL(B.CD_DKCOST,'') AS CD_DKCOST,																				\n")
					  .append ("		ISNULL(A.CD_COST,'') AS CD_COST,																					\n")
					  .append ("		ISNULL(F.DS_COST  , '') AS DS_COST,																					\n")
					  .append ("		ISNULL(A.NO_HADOCONT,'') as NO_HADOCONT,																		\n")
					  .append ("		ISNULL(B.DS_HADOCONT,'') as DS_HADOCONT,																		\n")
					  .append ("		ISNULL(B.SZ_SIZE, '') AS SZ_SIZE,																						\n")
					  .append ("		ISNULL(A.CD_ITEM,'') AS CD_ITEM, --품목코드,																		\n")
					  .append ("		ISNULL(A.DS_ITEM,'') AS DS_ITEM, --품목명칭,																		\n")
					  .append ("		ISNULL(D.SZ_ITEM,'') AS SZ_ITEM, --규격,																			\n")
					  .append ("		ISNULL(A.SZ_ITEM,'') AS SZ_SITEITEM, --현장규격,																\n")
					  .append ("		ISNULL(A.UT_ITEM,'') AS UT_ITEM, --단위,																			\n")
					  .append ("		ISNULL(A.TY_ITEM,'') AS TY_ITEM, --비목,																			\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(B.QN_TT_DOKUB,0)) AS QN_TT_DOKUB, --도급수량,														\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(B.UP_TT_DOKUB,0)) AS UP_TT_DOKUB, --도급예상단가,													\n")
					  .append ("		DBO.DZZFN_COMMA(CONVERT(NUMERIC,ISNULL(B.AM_TT_DOKUB,0))) AS AM_TT_DOKUB, --도급예상금액,						\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(B.QN_TT_SILHENG,0)) AS QN_TT_SILHENG, --실행수량,													\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(B.UP_TT_SILHENG,0)) AS UP_TT_SILHENG, --실행예상단가,        										\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(B.AM_TT_SILHENG,0)) AS AM_TT_SILHENG, --예상금액,													\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(B.QN_TT_SILHENG,0) - ISNULL(E.QN_ITEM,0)) AS QN_ITEMp, --기청구수량,    					\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(B.AM_TT_SILHENG,0) - ISNULL(E.AM_ITEM,0)) AS AM_ITEMp, --기청구금액,    					\n")
					  .append ("		DBO.DZZFN_COMMA(ISNULL(A.QN_ITEM,0)) AS QN_ITEM, --청구수량,       																\n")
					  .append ("		DBO.DZZFN_COMMA(CONVERT(NUMERIC,ISNULL(A.UP_ITEM,0))) AS UP_ITEM, --청구예상단가,               						\n")
					  .append ("		DBO.DZZFN_COMMA(CONVERT(NUMERIC, A.QN_ITEM * A.UP_ITEM)) AS AM_ITEM --예상금액     		\n")
					  .append ("  FROM    DMAT_MRITEM A																										\n")
					  .append ("		LEFT OUTER JOIN DMMT_ITEM D ON (A.CD_ITEM = D.CD_ITEM)        										\n")
					  .append ("		LEFT OUTER JOIN (    																										\n")
					  .append ("  		SELECT CD_COST, SUM(QN_ITEM) AS QN_ITEM, SUM(AM_ITEM) AS AM_ITEM    						\n")
					  .append ("  			FROM DMAV_MRSILHENG    																						\n")
					  .append ("  		WHERE CD_SITE = ?   																									\n")
					  .append ("  			GROUP BY CD_COST    																								\n")
					  .append ("		) E ON E.CD_COST = A.CD_COST    																					\n")
					  .append ("		LEFT OUTER JOIN DMXFN_MRCOST_BIMOK_DETAIL(?,'01','') B ON B.CD_COST = A.CD_COST			\n")
					  .append ("		LEFT OUTER JOIN DWZT_COST F ON  A.CD_COST = F.CD_COST  AND F.CD_SITE = ?					\n")
					  .append ("  WHERE A.NO_MR   = ?       																									\n")
					  .append ("			ORDER BY A.SN_NO																										\n");	 
		//System.out.println("a010001_s1 \n" + arr_sql[2].toString());		
		
		//청구서 품목정보 Grid
		//도급수량, 실행수량은 공사시스템의 실행예산(DWAT_SILHENG)에서 조회할 것      
		arr_sql[2].append ("  SELECT																																\n")		
					  .append ("		ISNULL(A.SN_NO,'') AS SN_NO2, --순번,																				\n")
					  .append ("		ISNULL(B.CD_DKCOST,'') AS CD_DKCOST,																				\n")
					  .append ("		ISNULL(A.CD_COST,'') AS CD_COST,																					\n")
					  .append ("		ISNULL(F.DS_COST  , '') AS DS_COST,																					\n")
					  .append ("		ISNULL(A.NO_HADOCONT,'') as NO_HADOCONT,																		\n")
					  .append ("		ISNULL(B.DS_HADOCONT,'') as DS_HADOCONT,																		\n")
					  .append ("		ISNULL(B.SZ_SIZE, '') AS SZ_SIZE,																						\n")
					  .append ("		ISNULL(A.CD_ITEM,'') AS CD_ITEM, --품목코드,																		\n")
					  .append ("		ISNULL(A.DS_ITEM,'') AS DS_ITEM, --품목명칭,																		\n")
					  .append ("		ISNULL(D.SZ_ITEM,'') AS SZ_ITEM, --규격,																			\n")
					  .append ("		ISNULL(A.SZ_ITEM,'') AS SZ_SITEITEM, --현장규격,																\n")
					  .append ("		ISNULL(A.UT_ITEM,'') AS UT_ITEM, --단위,																			\n")
					  .append ("		ISNULL(A.TY_ITEM,'') AS TY_ITEM, --비목,																			\n")
					  .append ("		ISNULL(B.QN_TT_DOKUB,0) AS QN_TT_DOKUB, --도급수량,														\n")
					  .append ("		ISNULL(B.UP_TT_DOKUB,0) AS UP_TT_DOKUB, --도급예상단가,													\n")
					  .append ("		CONVERT(NUMERIC,ISNULL(B.AM_TT_DOKUB,0)) AS AM_TT_DOKUB, --도급예상금액,						\n")
					  .append ("		ISNULL(B.QN_TT_SILHENG,0) AS QN_TT_SILHENG, --실행수량,													\n")
					  .append ("		ISNULL(B.UP_TT_SILHENG,0) AS UP_TT_SILHENG, --실행예상단가,        										\n")
					  .append ("		ISNULL(B.AM_TT_SILHENG,0) AS AM_TT_SILHENG, --예상금액,													\n")
					  .append ("		ISNULL(B.QN_TT_SILHENG,0) - ISNULL(E.QN_ITEM,0) AS QN_ITEMp, --기청구수량,    					\n")
					  .append ("		ISNULL(B.AM_TT_SILHENG,0) - ISNULL(E.AM_ITEM,0) AS AM_ITEMp, --기청구금액,    					\n")
					  .append ("		ISNULL(A.QN_ITEM,0) AS QN_ITEM, --청구수량,       																\n")
					  .append ("		ISNULL(A.UP_ITEM,0) AS UP_ITEM, --청구예상단가,               						\n")
					  .append ("		CONVERT(NUMERIC, A.QN_ITEM * A.UP_ITEM) AS AM_ITEM --예상금액     		\n")
					  .append ("  FROM    DMAT_MRITEM A																										\n")
					  .append ("		LEFT OUTER JOIN DMMT_ITEM D ON (A.CD_ITEM = D.CD_ITEM)        										\n")
					  .append ("		LEFT OUTER JOIN (    																										\n")
					  .append ("  		SELECT CD_COST, SUM(QN_ITEM) AS QN_ITEM, SUM(AM_ITEM) AS AM_ITEM    						\n")
					  .append ("  			FROM DMAV_MRSILHENG    																						\n")
					  .append ("  		WHERE CD_SITE = ?   																									\n")
					  .append ("  			GROUP BY CD_COST    																								\n")
					  .append ("		) E ON E.CD_COST = A.CD_COST    																					\n")
					  .append ("		LEFT OUTER JOIN DMXFN_MRCOST_BIMOK_DETAIL(?,'01','') B ON B.CD_COST = A.CD_COST			\n")
					  .append ("		LEFT OUTER JOIN DWZT_COST F ON  A.CD_COST = F.CD_COST  AND F.CD_SITE = ?					\n")
					  .append ("  WHERE A.NO_MR   = ?       																									\n")
					  .append ("			ORDER BY A.SN_NO																										\n");	 		
		
		//	
		//arr_sql[2].append ("{exec econnetDev.DMAPR_MRITEM_MASTER_SELECT('201509150005','') }" );
		
		//	현장결재정보 
		arr_sql[3].append ("{call PMS.PR_PR610HS_03(?,?) }" );
		
		//	본사결재정보 
		arr_sql[4].append ("{call PMS.PR_PR610HS_04(?,?) }" );		

		//	승인처리 
		arr_sql[5].append ("{call PMS.PR_PR610HS_05(?,?,?,?) }" );				
		
		//	부결처리 
		arr_sql[6].append ("{call PMS.PR_PR610HS_06(?,?,?,?,?) }" );			
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
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 

			for(int i=0; i<dSets.length;i++){

				if(dSets[i].getName().equals("ds_default1")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT1");  

						//String  v_cd_site		= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 		// 
						String  v_no_mr		= HDUtil.nullCheckStr(greq.getParameter("v_no_mr")); 		// 						

						//System.out.println("v_no_mr ==== \n" + v_no_mr);							
						
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[1].toString());

						//cstmt.setString(1, v_cd_site);
						cstmt.setString(1, v_no_mr);
						cstmt.setString(2, v_no_mr);
						
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));

						rs.close();
						cstmt.close();
						conn_ms.close();

				}else if(dSets[i].getName().equals("ds_default2")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT2");
						
						String  v_cd_site		= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 		// 
						String  v_no_mr		= HDUtil.nullCheckStr(greq.getParameter("v_no_mr")); 		// 						
	
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						cstmt = conn_ms.prepareCall(arr_sql[2].toString());
	
						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_cd_site);
						cstmt.setString(3, v_cd_site);						
						cstmt.setString(4, v_no_mr);
						//System.out.println("v_cd_site ==== \n" + v_cd_site);	
						//System.out.println("v_no_mr ==== \n" + v_no_mr);							
						
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
	



						
						
						//GauceDataRow[] 		rowss = ds1.getDataRows();
						
						//GauceDataColumn[] 	colss = ds1.getDataColumns();		
						
						//int colNm_AM_TT_DOKUB = rowss[1].getString(ds1.indexOfColumn("AM_TT_DOKUB"));
						
						//ds1.setInt(9, rowss[i].getInt(colNm_EduCost));						
						
						//Integer.parseInt((String)rowss[1].get("AM_TT_DOKUB"))
						
						//cstmt.setString(10, rows[i].getString(colNm_RefundYn));
						
						//int colNm_AM_TT_DOKUB                     	= ds1.indexOfColumn("AM_TT_DOKUB");
						
						//ds1.addDataColumn(new GauceDataColumn("AM_TT_DOKUB", GauceDataColumn.TB_NUMBER));
						
						//cstmt.setInt(8, ds1.rows[i].getInt(colNm_AM_TT_DOKUB));
						//System.out.println("colNm_AM_TT_DOKUB ==== \n" + colNm_AM_TT_DOKUB);						
						//prop.add("AM_TT_DOKUB",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
						//ds1.add("AM_TT_DOKUB", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
						//int DOKUB_AMT 		= ds1.getInt(1);
						//rows[j].setInt(idxSEQ,intSeq);
						//int DOKUB_AMT 		= cstmt.getInt(15);
						//full_dir_nm 	= cstmt.getString(2);						
						//ds1.put("AM_TT_DOKUB",DOKUB_AMT, 100);
						//ds1.put("FULL_DIR_NM",full_dir_nm, 300);
						//StringUtil.printMsg("DOKUB_AMT == ", colNm_AM_TT_DOKUB, this);

						//System.out.println(sql);
						//GauceDataSet gs = this.selectProcess(sql, bind, prop);
						//return gs;
						
						//int strDate = EJBStringUtil.nvl(p_strDate, "");
						
						
						
						rs.close();
						cstmt.close();
						conn_ms.close();
						
				// 현장 결재 라인 조회
				}else if(dSets[i].getName().equals("ds_default3")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT3"); 
					
						cstmt = conn.prepareCall(arr_sql[3].toString());

						int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// 결재sid

						cstmt.setInt(1, v_ap_m_sid);

						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
						
				// 본사 결재 라인 조회
				}else if(dSets[i].getName().equals("ds_default4")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT4"); 
							
						cstmt = conn.prepareCall(arr_sql[4].toString());

						int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// 결재sid

						cstmt.setInt(1, v_ap_m_sid);

						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
								
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
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
		      //결재 승인처리
			  if (msgDS != null & dsType==1) {

					cstmt = conn.prepareCall(arr_sql[5].toString());
					
					int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// 결재 sid
					String  v_empno	= HDUtil.nullCheckStr(greq.getParameter("vEmpNo")); 			// 결재자 사번
					String  v_empnm	= HDUtil.nullCheckStr(greq.getParameter("vEmpNmk")); 			// 결재자 성명

					cstmt.setInt(1, v_ap_m_sid);
					cstmt.setString(2, v_empno);							
					cstmt.setString(3, v_empnm);	
					cstmt.registerOutParameter(4,  java.sql.Types.VARCHAR);

					cstmt.executeQuery();

			  //결재 반송처리			
			  }else if(msgDS != null & dsType==2){
				  
					cstmt = conn.prepareCall(arr_sql[6].toString());
					
					int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// 결재 sid
					String  v_empno	= HDUtil.nullCheckStr(greq.getParameter("vEmpNo")); 			// 결재자 사번
					String  v_empnm	= HDUtil.nullCheckStr(greq.getParameter("vEmpNmk")); 			// 결재자 성명
					String  v_apdesc	= HDUtil.nullCheckStr(greq.getParameter("vApDesc")); 			// 결재자 반송 의견
					
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