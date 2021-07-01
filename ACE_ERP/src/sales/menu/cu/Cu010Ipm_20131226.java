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
 
public class Cu010Ipm_20131226 extends SuperServlet{
	/**
	 * ���� �̹��� ���� 
	 * ȯ�濡 ���߾� ��� ���� ����
	 */ 
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_COST;

		
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
   
		arr_sql[0].append ("SELECT										\n")
				  .append ("	'' HEAD, '' DETAIL, '��ü' DETAIL_NM    \n")
				  .append ("FROM SYSIBM.SYSDUMMY1                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.HEAD, B.DETAIL, B.DETAIL_NM           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.HEAD = B.HEAD                        \n")
				  .append (" AND B.HEAD = ?                             \n")
				  .append (" AND LENGTH (B.DETAIL) > 0                  \n");
		
		arr_sql[1].append ("SELECT                                      \n")
				  .append ("	B.HEAD, B.DETAIL||'' DETAIL, B.DETAIL_NM           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.HEAD = B.HEAD                        \n")
				  .append (" AND B.HEAD = ?                             \n")
				  .append (" AND LENGTH (B.DETAIL) > 0                  \n");
		
		//����� ���� ��ȸ
		arr_sql[2].append ("SELECT 																					\n")
				  .append ("    T1.CUST_SID    ,T1.MANAGE_NO    ,T1.REGI_NO                                         \n")
				  .append ("   ,T1.CUST_NM     ,T1.LAST_NM      ,T1.FIRST_NM                                        \n")
				  .append ("   ,T1.COUNTRY_CD  ,T1.NATION_CD    ,T1.BIRTHDAY                                        \n")
				  .append ("   ,T1.SEX 		   ,T1.TEL_NO 	    ,T1.MOBILE_NO                                       \n")
				  .append ("   ,T1.E_MAIL 	   ,T1.FAX_NO 	    ,T1.ZIP_CD                                          \n")
				  .append ("   ,T1.ADDRESS1    ,T1.ADDRESS2     ,T1.ENG_ZIP_CD                                      \n")
				  .append ("   ,T1.ENG_ADDR1   ,T1.ENG_ADDR2    ,T1.PASS_NO                                         \n")
				  .append ("   ,T1.PASS_EXPIRE_DATE ,T1.PASS_ISSUE_DATE                                             \n")
				  .append ("   ,T1.PASS_AREA   ,T1.COMPANY_NM   ,T1.POSITIONS                                       \n")
				  .append ("   ,T1.ENG_COMPANY_NM ,T1.ENG_POSITION ,T1.NORTH_CNT                                    \n")
				  .append ("   ,T1.CLIENT_SID      			                                        				\n")
				  .append ("   ,T1.PASS_TYPE   ,T1.REGI_YN		,'2' AS CUST_GU   \n") //��ȸ�� �� ����ڷ� ������
				  .append ("   ,T1.COUNTRY_GU  ,T1.SAUP_GU      ,T1.CUST_TYPE                                       \n")
				  .append ("   ,T1.HEIGHT      ,T1.GROUP_CD		,T1.ZIP_SID                					\n")
				  .append ("   ,T1.JOB_CD	   ,T2.CLIENT_NM 	         				          					\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU008',T1.PASS_TYPE)  AS PASS_TYPE_NAME                       \n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU002',T1.REGI_YN)    AS REGI_YN_NAME     /* �������� */    	\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU001',T1.CUST_GU)    AS CUST_GU_NAME     /* ������ */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU009',T1.COUNTRY_GU) AS COUNTRY_GU_NAME  /* ��������  */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU004',T1.SAUP_GU)    AS SAUP_GU_NAME     /* �������  */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'RV003',T1.CUST_TYPE)  AS CUST_TYPE_NAME   /* ������  */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'SY009',T1.SEX)    	AS SEX_GU_NAME      /* ��������  */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU003',T1.NATION_CD)  AS NATION_CD_NAME   /* �����ڵ�  */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'SY005',T1.COUNTRY_CD)  AS COUNTRY_NM                       \n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'SY005',T1.NATION_CD)  AS NATION_CD_NM                       \n")
				  .append ("   ,SALES.FN_CUST_CLOSE_YN (T1.CUST_SID,'" + fParamEmpno + "') AS CLOSE_YN								\n")
				  .append ("   ,T3.CLIENT_SID 		AS Company_Sid 												\n")
				  .append ("   ,T3.REAL_CLIENT 		AS RealCompany_Sid 												\n")
				  .append ("   ,T4.CLIENT_NM		AS RealCompany_NM 												\n")
				  .append ("FROM                                                                                    \n")
				  .append ("   SALES.TCU010 T1 LEFT OUTER JOIN  SALES.TCU030 T2 ON  T1.CLIENT_SID  = T2.CLIENT_SID  \n")
				  .append ("                   LEFT OUTER JOIN  SALES.TCM010 T3 ON  T1.CUST_SID    = T3.CUST_SID  \n")
		  		  .append ("                   LEFT OUTER JOIN  SALES.TCU030 T4 ON  T3.REAL_CLIENT = T4.CLIENT_SID  \n")
				  .append ("WHERE 1 = 1                                                                             \n");

		arr_sql[3].append ("SELECT T1.CLIENT_SID||'' CLIENT_SID    /* ����óSID */  \n")
				  .append ("     ,T1.CLIENT_CD      /* ����ó �ڵ�*/  \n")
				  .append ("     ,T1.CLIENT_NM      /* ����ó ��   */  \n")
				  .append ("FROM SALES.TCU030 T1                   \n");
		arr_sql[4].append ("SELECT										\n")
				  .append ("	'' CLIENT_SID, '' CLIENT_CD, '��ü' CLIENT_NM    \n")
				  .append ("FROM SYSIBM.SYSDUMMY1                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT T1.CLIENT_SID||'' CLIENT_SID    /* ����óSID */  \n")
				  .append ("     ,T1.CLIENT_CD      /* ����ó �ڵ�*/  \n")
				  .append ("     ,T1.CLIENT_NM      /* ����ó ��   */  \n")
				  .append ("FROM SALES.TCU030 T1                   \n");

		
		//������ ���/����/����  ���ν��� ȣ��
		arr_sql[5].append("{CALL SALES.PR_CU010I_02(?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?)}");
		
		/*arr_sql[5].append ("INSERT INTO SALES.TCU010 (								 \n")
				  .append ("MANAGE_NO    		,REGI_NO          ,CUST_NM     		,\n")
				  .append ("LAST_NM      		,FIRST_NM         ,COUNTRY_CD  		,\n")
				  .append ("NATION_CD       	,BIRTHDAY         ,SEX 		   		,\n")
				  .append ("TEL_NO 	    		,MOBILE_NO        ,E_MAIL 	   		,\n")
				  .append ("FAX_NO 	    		,ZIP_CD           ,ADDRESS1    		,\n")
				  
				  .append ("ADDRESS2     		,ENG_ZIP_CD       ,ENG_ADDR1   		,\n")
				  .append ("ENG_ADDR2    		,PASS_NO          ,PASS_EXPIRE_DATE ,\n")
				  .append ("PASS_ISSUE_DATE  	,PASS_AREA        ,COMPANY_NM   	,\n")
				  .append ("POSITIONS        	,ENG_COMPANY_NM   ,ENG_POSITION     ,\n")
				  .append ("NORTH_CNT	    	,CLIENT_SID       ,PASS_TYPE		,\n")
				  
				  .append ("REGI_YN		  		,CUST_GU          ,COUNTRY_GU		,\n")
				  .append ("SAUP_GU          	,CUST_TYPE        ,HEIGHT			,\n")
				  .append ("GROUP_CD         	,ZIP_SID          ,JOB_CD			,\n")
				  .append ("U_EMPNO     		,U_DATE           ,U_IP				 \n")
				  .append (") VALUES (												 \n")
				  .append ("?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 			 \n")
				  .append ("?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,			 \n")
				  
				  .append ("?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP, ? 		    )\n");*/

		//������ ����: ������� ����! ���� �� 5�� ���ν���
		arr_sql[6].append ("UPDATE SALES.TCU010 SET					\n")
				  .append ("			MANAGE_NO    		= ?,	\n")
				  .append ("			REGI_NO          	= ?,	\n")
				  .append ("			CUST_NM     		= ?,	\n")
				  .append ("			LAST_NM      		= ?,	\n")
				  .append ("			FIRST_NM         	= ?,	\n")
				  .append ("			COUNTRY_CD  		= ?,	\n")
				  .append ("			NATION_CD    		= ?,	\n")
				  .append ("			BIRTHDAY          	= ?,	\n")
				  .append ("			SEX 		   		= ?,	\n")
				  .append ("			TEL_NO 	    		= ?,	\n")
				  .append ("			MOBILE_NO        	= ?,	\n")
				  .append ("			E_MAIL 	   			= ?,	\n")
				  .append ("			FAX_NO 	    		= ?,	\n")
				  .append ("			ZIP_CD           	= ?,	\n")
				  .append ("			ADDRESS1    		= ?,	\n")
				  .append ("			ADDRESS2     		= ?,	\n")
				  .append ("			ENG_ZIP_CD       	= ?,	\n")
				  .append ("			ENG_ADDR1   		= ?,	\n")
				  .append ("			ENG_ADDR2    		= ?,	\n")
				  .append ("			PASS_NO          	= ?,	\n")
				  .append ("			PASS_EXPIRE_DATE 	= ?,	\n")
				  .append ("			PASS_ISSUE_DATE  	= ?,	\n")
				  .append ("			PASS_AREA        	= ?,	\n")
				  .append ("			COMPANY_NM   		= ?,	\n")
				  .append ("			POSITIONS        	= ?,	\n")
				  .append ("			ENG_COMPANY_NM   	= ?,	\n")
				  .append ("			ENG_POSITION     	= ?,	\n")
				  .append ("			NORTH_CNT	    	= ?,	\n")
				  .append ("			CLIENT_SID       	= ?,	\n")
				  .append ("			PASS_TYPE        	= ?,	\n")
				  .append ("			REGI_YN		    	= ?,	\n")
				  .append ("			CUST_GU          	= ?,	\n")
				  .append ("			COUNTRY_GU       	= ?,	\n")
				  .append ("			SAUP_GU          	= ?,	\n")
				  .append ("			CUST_TYPE        	= ?,	\n")
				  .append ("			HEIGHT           	= ?,	\n")
				  .append ("			GROUP_CD         	= ?, 	\n")
				  .append ("			ZIP_SID         	= ?, 	\n")
				  .append ("			JOB_CD	         	= ?, 	\n")
				  
				  .append ("			U_EMPNO     		= ?,	\n")
				  .append ("			U_DATE           	= CURRENT TIMESTAMP,	\n")
				  .append ("			U_IP             	= ?		\n")
				  .append ("WHERE CUST_SID = ?						\n");
		//������ ����
		arr_sql[7].append ("DELETE FROM SALES.TCU010 WHERE CUST_SID = ?	\n");

		//������ ��� �� CUST_SID GET 
		arr_sql[8].append ("SELECT MANAGE_NO FROM SALES.TCU010 WHERE MANAGE_NO = ?");
		
		//������ ��� �� CUST_SID GET 
		arr_sql[9].append ("SELECT CUST_SID FROM SALES.TCU010 WHERE MANAGE_NO = ?");

	}
	// �ʱ�
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		StringUtil.printMsg("DS TYPE","����ȸ",this);
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("CUSTALL")){//������
								stmt = conn.getGauceStatement(arr_sql[0].toString());
								stmt.setString(1, "CU001");
							} else if(gauceName.equals("NATIONALL")){//��������
								stmt = conn.getGauceStatement(arr_sql[0].toString());
								stmt.setString(1, "CU009");
							} else if(gauceName.equals("CUST")){//������
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU001");
							} else if(gauceName.equals("NATION")){//��������
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU009");
							} else if(gauceName.equals("AUTH")){//��������
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU002");
							} else if(gauceName.equals("SEX")){//����
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "SY009");
							} else if(gauceName.equals("TRAD")){//��������
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU003");
							} else if(gauceName.equals("SAUP")){//�������
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU004");
							} else if(gauceName.equals("PASS")){//��������
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU008");
							} else if(gauceName.equals("BUY_TYPEALL")){
								stmt = conn.getGauceStatement(arr_sql[4].toString());
							} else if(gauceName.equals("BUY_TYPE")){//����ó
								stmt = conn.getGauceStatement(arr_sql[3].toString());
							} else if(gauceName.equals("CUST_TYPE") || gauceName.equals("CUST_TYPE1")){//��������
								arr_sql[1].append (" AND B.ITEM4='Y'		\n");	//����ڰ� ���� ��
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "RV003");
							} else if(gauceName.equals("DEFAULT")){
								stmt = conn.getGauceStatement(arr_sql[2].toString());
							} else if (gauceName.equals("CU019")) { 
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU019");
							} else if (gauceName.equals("CU020")) { 
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, "CU020");
							}
							else if(gauceName.equals("IMAGE")){
								ds1.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
							}
							if(!gauceName.equals("IMAGE")){
								rs = stmt.executeQuery(); // DataSet set
								rsmd = rs.getMetaData();
								columnName = new String[rsmd.getColumnCount()];
								for(int i=0; i<columnName.length; i++){
									columnName[i] = rsmd.getColumnName(i+1);
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC")) {
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
									} else {
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
									}
								}
								
								if(!gauceName.equals("DEFAULT")){
									while ( rs.next()) {
										GauceDataRow row = ds1.newDataRow();
										
										for(int i=0; i<columnName.length; i++) {
											if(rsmd.getColumnTypeName(i+1).equals("NUMERIC")) {
												row.addColumnValue(rs.getInt(columnName[i]));
											} else {
												row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
											}
										}
		
										ds1.addDataRow(row);
						                v_rowcnt++ ;
									}//End of while
									if(rs!=null) rs.close();
									if(stmt!=null) stmt.close();
								}
							}

							ds1.flush();
							break;
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}	

	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceDataSet imgDs = null;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter ����
		 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
		 **********************************************************************************/

		// �˻��� ����
		String  sClientNm	= HDUtil.nullCheckStr(req.getParameter("sClientSid")); 	// ����ó
		String	sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu"));		// ������
		String  sCountryGu	= HDUtil.nullCheckStr(req.getParameter("sCountryGu"));	// ��������
		String  sCustNm		= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// ����
		String  sManegeNo	= HDUtil.nullCheckStr(req.getParameter("sManegeNo"));		// ������ȣ
		int  	sClientSid	= HDUtil.nullCheckNum(req.getParameter("sClientSid")); 	// ����ó
		String 	sAcceptNo	= HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
		// dataset ���� param
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			//StringUtil.printMsg("dsType ------->" + dsType , this);
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = req.getGauceDataSet("DEFAULT");
					//imgDs = req.getGauceDataSet("IMAGE");
					
					if(imgDs==null){
						//System.out.println("========================== imgDs null");
					}
					
					if(ds1!=null){
						res.enableFirstRow(ds1);
						//res.enableFirstRow(imgDs);
						
						if (!"".equals(sCustNm) && !"".equals(sManegeNo)) {
							if (!"".equals(sManegeNo)) {
								arr_sql[2].append (" AND T1.MANAGE_NO = ? ");
							}
							
							if (!"".equals(sCustNm)) {
								arr_sql[2].append (" AND T1.CUST_NM = ? ");
							}
							
							System.out.println("�ֹι�ȣ ���� ���ð��");
						} else {
						
							if (!"".equals(sClientNm)) 
								arr_sql[2].append (" AND T1.CLIENT_SID = ? ");
							
							if (!"".equals(sCustGu))
								arr_sql[2].append (" AND T1.CUST_GU = ? ");
			
							if (!"".equals(sCountryGu)) 
								arr_sql[2].append (" AND T1.COUNTRY_GU = ? ");
							
							if (!"".equals(sCustNm)) 
								arr_sql[2].append (" AND T1.CUST_NM = ? ");
			
							if (!"".equals(sManegeNo)) 
								arr_sql[2].append (" AND T1.MANAGE_NO = ? ");
							
							if (!"".equals(sAcceptNo)) {
								arr_sql[2].append(" AND T1.GROUP_CD = ? ");
							}
						}
						 
						arr_sql[2].append(" ORDER BY T1.CUST_NM FETCH FIRST 2000 ROW ONLY");
						
						//���� ����
						
						//StringUtil.printMsg("����ȸ ------->" + arr_sql[2].toString(), this);//������� ����
						stmt = conn.getGauceStatement(arr_sql[2].toString()); 
						if (!"".equals(sCustNm) && !"".equals(sManegeNo)) {
							if (!"".equals(sManegeNo)) {
								stmt.setString(sCnt1++, sManegeNo );
							}
							if (!"".equals(sCustNm)) {
								stmt.setString(sCnt1++, sCustNm );
							}
						} else {
							if (!"".equals(sClientNm)) {
								stmt.setString(sCnt1++, sClientNm);
							}					
							if (!"".equals(sCustGu)) {
								stmt.setString(sCnt1++, sCustGu);
							}
							if (!"".equals(sCountryGu)) {
								stmt.setString(sCnt1++, sCountryGu);
							}
							
							if (!"".equals(sCustNm)) {
								stmt.setString(sCnt1++, sCustNm);
							}
							if (!"".equals(sManegeNo)) {
								stmt.setString(sCnt1++, sManegeNo );
							}
							
							
							if (!"".equals(sAcceptNo)) {
								stmt.setString(sCnt1++, sAcceptNo);
							}
						}	
						rs = stmt.executeQuery(); // DataSet set
						rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];
						for(int i=0; i<columnName.length; i++){
							columnName[i] = rsmd.getColumnName(i+1);
							
							if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER"))
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
							else
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1) ));
						}
						
						//imgDs.addDataColumn(new GauceDataColumn("MANAGE_NO", GauceDataColumn.TB_STRING));
						//imgDs.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
						//imgDs.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
						
						//StringUtil.printMsg("���⼭ ����? ------->" + dsType , this);
						while ( rs.next()) {
							GauceDataRow row = ds1.newDataRow();
							for(int i=0; i<columnName.length; i++) {
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER"))
									row.addColumnValue(rs.getInt(columnName[i]));
								else
									row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
							}
							ds1.addDataRow(row);
							
							/*GauceDataRow imgRow = imgDs.newDataRow();
							
							File imgFile = new File(SAVE_FILE + rs.getString("MANAGE_NO")+".JPG");	//���Ⱑ ���
							
							// ��������̳׿�.. �� ����... �׷���!!!!
							imgRow.addColumnValue(rs.getString("MANAGE_NO"));
							
							if(imgFile.isFile()){
								imgRow.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST + rs.getString("MANAGE_NO")+".JPG");
								imgRow.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST + rs.getString("MANAGE_NO")+".JPG");
							} else {
								imgRow.addColumnValue("");
								imgRow.addColumnValue("");
							}
							imgDs.addDataRow(imgRow);*/

							v_rowcnt++ ;
						}//End of while
						
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();

						ds1.flush();
						//imgDs.flush();
					}
					break;
				case 2:
					ds1 = req.getGauceDataSet("SEARCH_DS4");
					
					if(ds1!=null){
						res.enableFirstRow(ds1);
		 
						//���� ����
						stmt = conn.getGauceStatement("SELECT SALES.FN_ACCEPT_NO(" + sClientSid + ",'" + fParamEmpno + "','" + fParamIp + "') AS ACCEPT_NO FROM SYSIBM.SYSDUMMY1");
						
						rs = stmt.executeQuery();		// Query ����
						
						getDataSet(rs, ds1).flush();
					}
					break;
	
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}
	
	/**
	 * ��� : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 
	 */
	// �Է�, ����, ����
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception{
		GauceDataSet inputDs = req.getGauceDataSet("REGIST");
		//GauceDataSet imgDs = req.getGauceDataSet("IMAGE");
		GauceDataSet resultDs = req.getGauceDataSet("RESULT");
		GauceStatement stmt = null;
		CallableStatement cstmt = null;
		
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		try{
			if(resultDs!=null) {
				res.enableFirstRow(resultDs);
				
				resultDs.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
			}
			
			String 	sCompanyNo	= HDUtil.nullCheckStr(req.getParameter("sCompanyNo"));
			
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//GauceDataRow[] 		imgRow = imgDs.getDataRows();
				//GauceDataColumn[] 	imgCol = imgDs.getDataColumns();
				for(int i=0; i<rows.length; i++){
					int j=1;
					//StringUtil.printMsg("�� Ÿ��?", rows[i].getJobType() , this);
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
								stmt = conn.getGauceStatement(arr_sql[8].toString());
								stmt.setString(1, rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")));
								ResultSet rs = stmt.executeQuery();
								if(rs.next())
									throw new Exception("�̹� �ߺ��� �ڷᰡ �ֽ��ϴ�.");
								if(rs!=null) rs.close();
								if(stmt!=null) stmt.close();
								
								//stmt = conn.getGauceStatement(arr_sql[5].toString());
								cstmt = conn.prepareCall(arr_sql[5].toString());
								
								for(; j<40;){
									if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
										cstmt.setInt(j, rows[i].getInt(j++));
									else
										cstmt.setString(j, rows[i].getString(j++).trim());
								}
								
								cstmt.setString(j++, iParamEmpno);	//40.���������ڻ�� 
								cstmt.setString(j++, iParamIp);		//41.��������IP  
								cstmt.setInt(j++, 0);				//42.�� SID (���ʴϱ� 0)
						
								cstmt.setInt(j++, rows[i].getInt(52) );	//43.�Ҽ�ȸ�� client_sid 		52��° �÷�
								cstmt.setInt(j++, rows[i].getInt(53) );	//44.���δ�ȸ�� realclient_sid	53��° ��ȸ�÷�

						//StringUtil.printMsg("43 �Ҽӻ�sid",rows[i].getInt(52) , this);
						//StringUtil.printMsg("44 ���δ�ȸ�� sid", rows[i].getInt(53) , this);
								
								cstmt.setString(j++, "1");			//45.��������     1: INSERT, 2: DELETE, 3: UPDATE						
								cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//46.����Y/N
								cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//47.�޼��� �ڵ�
								cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//48.�޼���
								cstmt.executeUpdate();
								//stmt.execute();
								
								if(stmt!=null) stmt.close();
								
								stmt = conn.getGauceStatement(arr_sql[9].toString());
								stmt.setString(1, rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")));
								rs = stmt.executeQuery();
								if(rs.next()){
									if(resultDs!=null) {
										GauceDataRow resultRow = resultDs.newDataRow();
										resultRow.addColumnValue(rs.getInt("CUST_SID"));
										resultDs.addDataRow(resultRow);
									}
								}
								
								if(rs!=null) rs.close();
								if(stmt!=null) stmt.close();
								
								//�� ���� ���� ���
								//int data_name = imgDs.indexOfColumn("PICTURE_INFO");
								//int data_url  = imgDs.indexOfColumn("PICTURE_URL");
								//String d_name = imgRow[i].getString(data_name);
								//StringUtil.printMsg("d_name", "["+ d_name +"]", this);
								/*if(d_name!=null && !d_name.equals("")){
									String o_name = rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")) + ".JPG";
									
									InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
									FileOutputStream os = new FileOutputStream(SAVE_FILE + o_name);
									copy(is, os, 1024*1024*10 );
									is.close();
									os.close();
								}*/
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//stmt = conn.getGauceStatement(arr_sql[6].toString());
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							for(; j<40;){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
									cstmt.setInt(j, rows[i].getInt(j++));
								else
									cstmt.setString(j, rows[i].getString(j++).trim());
							}
							
							//stmt.setString(j++, iParamEmpno);
							//stmt.setString(j++, iParamIp);
							//stmt.setString(j++, rows[i].getString(0).trim());
							//stmt.setString(j++, rows[i].getString(inputDs.indexOfColumn("CUST_SID")));
							//StringUtil.printMsg("37 �׷��ڵ�", rows[i].getString(37) , this);
							
							cstmt.setString(j++, iParamEmpno);	//40.���������ڻ�� 
							cstmt.setString(j++, iParamIp);		//41.��������IP  
							cstmt.setInt(j++, rows[i].getInt(inputDs.indexOfColumn("CUST_SID")));				//42.�� SID
						//StringUtil.printMsg("42 CUST_SID", rows[i].getInt(inputDs.indexOfColumn("CUST_SID")) , this);
							
						
							cstmt.setInt(j++, rows[i].getInt(52) );	//43.�Ҽ�ȸ�� client_sid 		52��° �÷�
							cstmt.setInt(j++, rows[i].getInt(53) );	//44.���δ�ȸ�� realclient_sid	53��° ��ȸ�÷�
							
							cstmt.setString(j++, "3");			//45.��������     1: INSERT, 2: DELETE, 3: UPDATE						
							cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//46.����Y/N
							cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//47.�޼��� �ڵ�
							cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//48.�޼���

							cstmt.executeUpdate();	// �Ʊ� �̰� �����µ�.. ��..;
						
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[7].toString());
							stmt.setString(1, rows[i].getString(inputDs.indexOfColumn("CUST_SID"))); // ������ȣ�� ���� 
							stmt.execute();
							break;
					}
					if(stmt!=null) stmt.close();
				}
				
				if(resultDs!=null) resultDs.flush();

				/*for(int i=0; i<imgRow.length; i++){
					switch(imgRow[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//�� ���� ���� ���
							int data_name = imgDs.indexOfColumn("PICTURE_INFO");
							int data_url  = imgDs.indexOfColumn("PICTURE_URL");
							String d_name = imgRow[i].getString(data_name);
							
							if(!imgRow[i].getString(1).trim().equals("") && d_name!=null && !d_name.equals("")){
								String o_name = imgRow[i].getString(0).trim() + ".JPG";
								
								InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
								FileOutputStream os = new FileOutputStream(SAVE_FILE + o_name);
								copy(is, os, 1024*1024*10 );
								is.close();
								os.close();
							}

							break;
					}
				}*/
			}

		} catch (SQLException sqle){
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}
	}

}
