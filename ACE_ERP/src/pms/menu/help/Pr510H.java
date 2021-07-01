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

public class Pr510H extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//발주의뢰서 기본사항 조회
		arr_sql[1].append ("SELECT 					 									\n")
					  .append ("       A.CD_SITE,         									\n")
					  .append ("       B.DS_SITE,        									\n")
					  .append ("       A.NO_HADOCONT,          						\n")
					  .append ("       A.DS_HADOCONT,          						\n")
					  .append ("       A.SN_SEQ,         									\n")
					  .append ("       A.TY_GUBUN,         								\n")
					  .append ("       A.DS_STATUS,         								\n")
					  .append ("       A.DT_REQUEST,         							\n")
					  .append ("       A.AM_TT_DOKUB,         							\n")
					  .append ("       A.AM_TT_SILHENG,         						\n")
					  
					  .append ("       CASE WHEN A.AM_TT_DOKUB = 0 THEN 0		  																													\n")
					  .append ("       ELSE CONVERT(FLOAT,ROUND(CONVERT(DECIMAL,ISNULL(A.AM_TT_SILHENG,0)) / CONVERT(DECIMAL,ISNULL(A.AM_TT_DOKUB,0)) * 100,3)) 				\n")
					  .append ("       END DAEBI,					  																																				\n")					  
					  
					  .append ("       A.NO_GAHADOCONT,        						\n")
					  .append ("       SUBSTRING(A.DT_EXPLAIN,0,5) + '년 ' + SUBSTRING(A.DT_EXPLAIN,5,2) + '월 ' + SUBSTRING(A.DT_EXPLAIN,7,2) + '일   '  + SUBSTRING(A.DT_EXPLAIN,9,2) + '시 ' + SUBSTRING(A.DT_EXPLAIN,11,2) + '분' AS DT_EXPLAIN,      \n")
					  .append ("       A.AT_SITEEXPLAIN,        						\n")
					  .append ("       A.ID_SITESABUN,        							\n")
					  .append ("       A.NO_SITETEL,        								\n")
					  .append ("       A.DS_FROMTO,        								\n")
					  .append ("       A.DT_ASFROMTO,         							\n")
					  .append ("       A.DS_PREPAY1,        								\n")
					  .append ("       A.YN_MATERIAL,        							\n")
					  .append ("       CONVERT(NUMERIC(10,3), ROUND(A.RT_TAX, 3)) RT_TAX,        \n")
					  .append ("       A.TY_TAX,        									\n")
					  .append ("       SUBSTRING(A.DT_BIDMAGAM,0,5) + '년 ' + SUBSTRING(A.DT_BIDMAGAM,5,2) + '월 ' + SUBSTRING(A.DT_BIDMAGAM,7,2) + '일   '  + SUBSTRING(A.DT_BIDMAGAM,9,2) + '시 ' + SUBSTRING(A.DT_BIDMAGAM,11,2) + '분' AS DT_BIDMAGAM,      \n")
					  

					  .append ("       A.AT_BIDMAGAM,        							\n")
					  .append ("       A.ID_SABUN,        									\n")
					  .append ("       A.NO_TEL,        									\n")
					  .append ("       A.RM_REMARK,        								\n")
					  .append ("       RIGHT(A.NO_HADOCONT,6) AS NO_BID,     \n")
					  
					  .append ("       C.DS_HNAME AS DS_SITESABUN,        			\n")
					  .append ("       ISNULL(D.DS_HNAME,'') AS DS_SABUN,      	\n") 
					  .append ("       E.YN_FILE,         										\n")
					  .append ("       ISNULL(A.TY_COSMI,'')  AS TY_COSMI,       	\n")
					  .append ("       E.ONOFF,        											\n")
					  .append ("       RTRIM(E.DT_FROM) AS DT_FROM,        			\n")
					  .append ("       RTRIM(E.DT_TO) AS DT_TO,        				\n")
					  .append ("       E.CD_COSTCLASS,          							\n")
					  .append ("       F.DS_COSTCLASS,          							\n")
					  .append ("       E.CD_LICCOST,          								\n")
					  .append ("       G.DS_LICCOST,        									\n")
					  .append ("       A.YN_PMCHKREQ,        								\n")
					  .append ("       CASE A.TY_PMSTATUS        						\n")
					  .append ("       WHEN '1' THEN '1'        								\n")
					  .append ("       WHEN '2' THEN '2'        								\n")
					  .append ("       ELSE ''        												\n")
					  .append ("       END AS TY_PMSTATUS,        						\n")
					  .append ("       CASE A.TY_PMSTATUS        						\n")
					  .append ("       WHEN '1' THEN 'PM검토요청'       					\n")
					  .append ("       WHEN '2' THEN '현설의뢰완료'        				\n")
					  .append ("       ELSE '현설의뢰요청전'        							\n")
					  .append ("       END AS DS_PMSTATUS,               				\n")
				  
					  .append ("       SUBSTRING(E.DT_REQCONTRACT,0,5) + '-' + SUBSTRING(E.DT_REQCONTRACT,5,2) + '-' + SUBSTRING(E.DT_REQCONTRACT,7,2) AS DT_REQCONTRACT, 				\n")	  

					  .append ("       E.TY_HADOTYPE,      									\n")
					  .append ("       E.DS_CONTMETHOD,							   		\n")
					  .append ("       ISNULL(E.TY_BIDSTATUS,'') TY_BIDSTATUS,	\n")
					  .append ("       ISNULL(H.DS_FILENAME,'') REAL_FILE,			\n")			
					  .append ("       ISNULL(H.DS_LOCATION,'') SYS_FILE				\n")	
					  
					  .append ("       FROM	DWZT_HADOSTATUS A INNER JOIN  DWZT_SITE B   ON  A.CD_SITE = B.CD_SITE     \n")   
					  .append ("       LEFT OUTER JOIN DZZT_USERID C  ON A.ID_SITESABUN = C.ID_USER        						\n")
					  .append ("       LEFT OUTER JOIN DZZT_USERID D  ON A.ID_SABUN = D.ID_USER        							\n")
					  .append ("       INNER JOIN   DCBT_ORDERPLAN E ON  A.NO_HADOCONT = E.CD_SITE+E.NO_BID				\n")
					  .append ("       LEFT OUTER JOIN DCZV_COSTTOPCLASS F ON  E.CD_COSTCLASS = F.CD_COSTCLASS     	\n")   
					  .append ("       LEFT OUTER JOIN DCZV_LICLOWCOST G ON  E.CD_COSTCLASS = G.CD_COSTCLASS AND  E.CD_LICCOST = G.CD_LICCOST \n")
					  .append ("       LEFT OUTER JOIN DCCT_CONTRACT_DOCUMENT H ON  H.NO_CONT = A.NO_HADOCONT      \n")
					  
					  .append ("  WHERE A.CD_SITE = ?		AND RIGHT(A.NO_HADOCONT,6) = ?				\n");
		
		//System.out.println("a010001_s1 \n" + arr_sql[1].toString());		
		//System.out.println("이동훈 \n");		
		//업체 추천이 있을 경우
		arr_sql[2].append ("{call PMS.PR_PR510HS_02(?,?) }" );
		 
		//	현장결재정보 		
		arr_sql[3].append ("{call PMS.PR_PR510HS_03(?,?) }" );	
		
		//	본사결재정보 
		arr_sql[4].append ("{call PMS.PR_PR510HS_04(?,?) }" );		

		//	승인처리 
		arr_sql[5].append ("{call PMS.PR_PR510HS_05(?,?,?,?) }" );				
		
		//	부결처리 
		arr_sql[6].append ("{call PMS.PR_PR510HS_06(?,?,?,?,?) }" );		
		
		// 최종승인후  ms-sql 쪽에 외주발주의뢰 승인 SP exec
		//arr_sql[11].append ("{call DCBPR_PREORDERPLAN_APPROVE_OK(?,?,?) @CD_SITE=?, @NO_BID=?, @ID_USER=? }" );		
		arr_sql[7].append ("{call dbo.DCBPR_PREORDERPLAN_APPROVE_OK(?,?,?) }" );			
		
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
						
						String  v_cd_site		= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 		// 
						String  v_no_cont		= HDUtil.nullCheckStr(greq.getParameter("v_no_cont")); 		// 						
						
						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						
						cstmt = conn_ms.prepareCall(arr_sql[1].toString());					

						//System.out.println("v_cd_site2 ==== \n" + v_cd_site);	
						//System.out.println("v_no_cont2 ==== \n" + v_no_cont);							
							
						
						cstmt.setString(1, v_cd_site);
						cstmt.setString(2, v_no_cont);

						
						
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));						
						
						rs.close();
						cstmt.close();
						conn_ms.close();

				}else if(dSets[i].getName().equals("ds_default2")){

						GauceDataSet ds1 = gis.read("DS_DEFAULT2");
					
						cstmt = conn.prepareCall(arr_sql[2].toString());
						
						int  v_ap_m_sid		= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid"));
						
						cstmt.setInt(1, v_ap_m_sid);
						
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
						
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
						
		/* DataSet */
		CallableStatement cstmt2 = null;
		ResultSet rs2 = null;				
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		GauceDataSet msgDS = gis.read("msgDS");
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
		      //결재 승인처리
			  if (msgDS != null & dsType==1) {

					cstmt = conn.prepareCall(arr_sql[5].toString());
					
					int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// 결재 sid
					String  v_cd_site	= HDUtil.nullCheckStr(greq.getParameter("v_cd_site")); 			// 
					String  v_no_cont	= HDUtil.nullCheckStr(greq.getParameter("v_no_cont")); 			// 							
					String  v_empno	= HDUtil.nullCheckStr(greq.getParameter("vEmpNo")); 			// 결재자 사번
					String  v_empnm	= HDUtil.nullCheckStr(greq.getParameter("vEmpNmk")); 			// 결재자 성명	
					double  cnt = 0;
					
					cstmt.setInt(1, v_ap_m_sid);
					cstmt.setString(2, v_empno);							
					cstmt.setString(3, v_empnm);	
					cstmt.registerOutParameter(4,  java.sql.Types.VARCHAR);

					cstmt.executeQuery();

			        //전표Master 입력/수정 구분=====================================================>>>>
			        Statement stmt0 = conn.createStatement();
			        StringBuffer sql0 = new StringBuffer();
			        
					sql0.append( " SELECT COUNT(*)   											\n")
						 .append( " 			FROM COMMON.APPROVE_MASTER  				\n")			        
						 .append( "	 WHERE AP_M_SID ='"+v_ap_m_sid+"'					\n")
						 .append( "	      AND AP_STATUS_M = '3'								\n");	//최종승인

					ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 

					if(rs0.next()){
						
						 cnt= rs0.getDouble(1);
						 //System.out.println("cnt ==== \n" + cnt);
					}
					
					rs0.close();
					stmt0.close();					
					
					if(cnt > 0){   //최종승인이면 ms sql 쪽에 결재승인 처리 sp 호출	
					
					// 결재 승인 처리 sp 호출 
					Connection conn_ms2 = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");

					//System.out.println("v_cd_site2 ==== \n" + v_cd_site);	
					//System.out.println("v_no_cont2 ==== \n" + v_no_cont);							
					//System.out.println("v_empno2 ==== \n" + v_empno);		
					
					cstmt2 = conn_ms2.prepareCall(arr_sql[7].toString());						
					
					cstmt2.setString(1, v_cd_site);
					cstmt2.setString(2, v_no_cont);
					cstmt2.setString(3, v_empno);
					
					rs2 = cstmt2.executeQuery();
					//gos.write(getDataSet(rs2, ds1));

					rs2.close();
					cstmt2.close();	
					conn_ms2.close();
					
					}
					
					
					
					
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