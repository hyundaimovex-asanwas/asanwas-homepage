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
import com.gauce.GauceException;//[20151016][�ɵ���] ����� ����ó�� �߰�

import oracle.jdbc.OracleTypes;

public class Cu010Ipm extends SuperServlet{
	private static final long serialVersionUID = 1L;
	/**
	 * ���� �̹��� ���� 
	 * ȯ�濡 ���߾� ��� ���� ����
	 */ 
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_COST;

	/*
	 * [20151016][�ɵ���] ����� ����ó�� �߰�
	 * 					  GAUCE5.x �������� ��^^
	 * */
	
	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		
		
		arr_sql[0].append ("SELECT										\n")
				  .append ("	'' HEAD, '' DETAIL, '��ü' DETAIL_NM    \n")
				  .append ("FROM DUAL			                        \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.HEAD, B.DETAIL, B.DETAIL_NM           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.HEAD = B.HEAD                        \n")
				  .append (" AND B.HEAD = ?                             \n")
				  .append (" AND LENGTH (rtrim(B.DETAIL)) > 0                  \n");
		
		arr_sql[1].append ("SELECT                                      \n")
				  .append ("	B.HEAD, B.DETAIL||'' DETAIL, B.DETAIL_NM           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.HEAD = B.HEAD                        \n")
				  .append (" AND B.HEAD = ?                             \n")
				  .append (" AND LENGTH (rtrim(B.DETAIL)) > 0                  \n");
		
		//����� ���� ��ȸ
		arr_sql[2].append ("SELECT 																					\n")
				  .append ("    T1.CUST_SID, CASE WHEN T1.REGI_YN_T = 'Y' 											\n")
				  .append ("                            THEN SALES.FN_SECURE_RETURN(T1.MANAGE_NO,7)					\n")
				  .append ("                 ELSE T1.MANAGE_NO														\n")
				  .append ("                 END AS MANAGE_NO, T1.REGI_NO                                           \n")
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
				  .append ("   ,T1.PASS_TYPE   ,T1.REGI_YN_T		,'2' AS CUST_GU   \n") //��ȸ�� �� ����ڷ� ������
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
				  .append ("FROM DUAL			                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT T1.CLIENT_SID||'' CLIENT_SID    /* ����óSID */  \n")
				  .append ("     ,T1.CLIENT_CD      /* ����ó �ڵ�*/  \n")
				  .append ("     ,T1.CLIENT_NM      /* ����ó ��   */  \n")
				  .append ("FROM SALES.TCU030 T1                   \n");

		
		//������ ���/����/����  ���ν��� ȣ��
		arr_sql[5].append("{CALL SALES.PR_CU010I_02(?,?,?,?,?,	?,?,?,?,?,	 ?,?,?,?,?,	?,?,?,?,?,	 ?,?,?,?,?,	?,?,?,?,?, ?,?,?,?,?,	?,?,?,?,?, ?,?,?,?,?,	?,?,?)}");
		
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
				  .append ("			U_DATE           	= CURRENT_TIMESTAMP,	\n")
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
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	/* DataSet */
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		CallableStatement cstmt = null;
		
		int v_rowcnt = 0;
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 
			
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("searchds1")){//������
		    		GauceDataSet ds1 = gis.read("CUSTALL");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU001");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("searchds2")){//��������
					GauceDataSet ds1 = gis.read("NATIONALL");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU009");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds4")){//������
					GauceDataSet ds1 = gis.read("CUST");
		    		cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU001");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds1")){//��������
					GauceDataSet ds1 = gis.read("NATION");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU009");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds2")){//��������
					GauceDataSet ds1 = gis.read("AUTH");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU002");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds3")){//����
					GauceDataSet ds1 = gis.read("SEX");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "SY009");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds5")){//����
					GauceDataSet ds1 = gis.read("TRAD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU003");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds8")){//�������
					GauceDataSet ds1 = gis.read("SAUP");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU004");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds6")){//��������
					GauceDataSet ds1 = gis.read("PASS");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU008");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("BUY_TYPEALL")){
					GauceDataSet ds1 = gis.read("BUY_TYPEALL");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds9")){
					GauceDataSet ds1 = gis.read("BUY_TYPE");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
		   		} else if(dSets[i].getName().equals("initds7")){
					GauceDataSet ds1 = gis.read("CUST_TYPE");
					arr_sql[1].append (" AND B.ITEM4='Y'		\n");	//����ڰ� ���� ��
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "RV003");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("ds1")){//�⺻��ȸ
					GauceDataSet ds1 = gis.read("DEFAULT");
					arr_sql[2].append (" AND T1.MANAGE_NO = '999999999999' ");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds10")){//�⺻��ȸ
					GauceDataSet ds1 = gis.read("CU019");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU019");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds11")){
					GauceDataSet ds1 = gis.read("CU020");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU020");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("imgDs")){	
					GauceDataSet ds1 = gis.read("IMAGE");
					ds1.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
					ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
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
    
	// ��ȸ method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;

		// �˻��� ����
		int  	sClientSid	= HDUtil.nullCheckNum(greq.getParameter("sClientSid")); 	// ����ó
		String	sCustGu		= HDUtil.nullCheckStr(greq.getParameter("sCustGu"));		// ������
		String  sCountryGu	= HDUtil.nullCheckStr(greq.getParameter("sCountryGu"));	// ��������
		String  sCustNm		= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));		// ����
		String  sManegeNo	= HDUtil.nullCheckStr(greq.getParameter("sManegeNo"));		// ������ȣ
		String 	sAcceptNo	= HDUtil.nullCheckStr(greq.getParameter("sAcceptNo"));
		// dataset ���� param
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){// || dSets[i].getName().equals("imgDs")){
						/*
						StringUtil.printMsg(" sClientSid ",sClientSid,this);
						StringUtil.printMsg(" sCustGu ",sCustGu,this);
						StringUtil.printMsg(" sCountryGu ",sCountryGu,this);
						StringUtil.printMsg(" sCustNm ",sCustNm,this);
						StringUtil.printMsg(" sManegeNo ",sManegeNo,this);
						StringUtil.printMsg(" sAcceptNo ",sAcceptNo,this);
						*/
						int sCnt1 = 1;
						GauceDataSet ds1 = gis.read("DEFAULT");
						GauceDataSet imgDs = gis.read("IMAGE");
						if (!"".equals(sCustNm) && !"".equals(sManegeNo)) {
							//StringUtil.printMsg(" IF::::::::::::: ","IF",this);
							if (!"".equals(sManegeNo)) {
								arr_sql[2].append (" AND T1.MANAGE_NO = ? ");
							}
							if (!"".equals(sCustNm)) {
								arr_sql[2].append (" AND T1.CUST_NM = ? ");
							}
							//System.out.println("�ֹι�ȣ ���� ���ð��");
						} else {
							//StringUtil.printMsg(" ELSE::::::::::::: ","ELSE",this);
							//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
							if (sClientSid>0) 
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
						 
						arr_sql[2].append(" AND ROWNUM <= 2000");
						
						//���� ����
						
						cstmt = conn.prepareCall(arr_sql[2].toString()); 
						if (!"".equals(sCustNm) && !"".equals(sManegeNo)) {
							if (!"".equals(sManegeNo)) {
								cstmt.setString(sCnt1++, sManegeNo );
							}
							if (!"".equals(sCustNm)) {
								cstmt.setString(sCnt1++, sCustNm );
							}
						} else {
							if (sClientSid>0) {
								cstmt.setInt(sCnt1++, sClientSid);
							}					
							if (!"".equals(sCustGu)) {
								cstmt.setString(sCnt1++, sCustGu);
							}
							if (!"".equals(sCountryGu)) {
								cstmt.setString(sCnt1++, sCountryGu);
							}
							if (!"".equals(sCustNm)) {
								cstmt.setString(sCnt1++, sCustNm);
							}
							if (!"".equals(sManegeNo)) {
								cstmt.setString(sCnt1++, sManegeNo );
							}
							if (!"".equals(sAcceptNo)) {
								cstmt.setString(sCnt1++, sAcceptNo);
							}
						}	
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1)); // DataSet set & ����
						//gos.write(getDataSet(rs, imgDs)); // DataSet set & ����
						
						//imgDs.addDataColumn(new GauceDataColumn("MANAGE_NO", GauceDataColumn.TB_STRING));
						//imgDs.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
						//imgDs.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
						
						//StringUtil.printMsg("���⼭ ����? ------->" + dsType , this);
						
						/*
						while ( rs.next()) {
						
							GauceDataRow row = ds1.newDataRow();
							ds1.addDataRow(row);
							GauceDataRow imgRow = imgDs.newDataRow();
							
							//File imgFile = new File(SAVE_FILE + rs.getString("PIC_ADDR")+".JPG");	//���Ⱑ ���
							// ��������̳׿�.. �� ����... �׷���!!!!
							imgRow.addColumnValue(rs.getString("MANAGE_NO"));
							
							//if(imgFile.isFile()){
								imgRow.addColumnValue(HDConstant.PIC_NEW_PATH + rs.getString("PIC_ADDR")+".JPG");
								imgRow.addColumnValue(HDConstant.PIC_NEW_PATH + rs.getString("PIC_ADDR")+".JPG");
							//} else {
								//imgRow.addColumnValue("");
								//imgRow.addColumnValue("");
							//}
							imgDs.addDataRow(imgRow);
							v_rowcnt++ ;
						
						}//End of while
						*/
						
						//if(rs!=null) rs.close();
						//if(cstmt!=null) cstmt.close();
						//gos.close();
						//if(cstmt!=null) cstmt.close();	
						//gos.write(getDataSet(rs, ds1)); // DataSet set & ����
						//gos.write(getDataSet(rs, imgDs)); // DataSet set & ����
					}
					
					if(dSets[i].getName().equals("searchds4")){
						GauceDataSet ds1 = gis.read("SEARCH_DS4");
							//���� ����
						//StringUtil.printMsg("sClientSid ------->" , sClientSid, this);
						//StringUtil.printMsg("fParamEmpno ------->" ,fParamEmpno, this);
						//StringUtil.printMsg("fParamIp ------->" ,fParamIp, this);
						cstmt = conn.prepareCall("SELECT SALES.FN_ACCEPT_NO(" + sClientSid + ",'" + fParamEmpno + "','" + fParamIp + "') AS ACCEPT_NO FROM DUAL");
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1));
					}
				}
				gos.close();
			} catch (SQLException sqle){
				//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
				throw sqle;
			} catch (Exception e) {
				//gres..writeException("ERROR", "", e.toString());
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
	// �Է�, ����, ����
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	//StringUtil.printMsg("# Command","����",this);
		//StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet inputDs = gis.read("REGIST");
		GauceDataSet imgDs = gis.read("IMAGE");		
		GauceDataSet resultDs = gis.read("RESULT");
    	
    	try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//GauceDataRow[] 		imgRow = imgDs.getDataRows();
				//GauceDataColumn[] 	imgCol = imgDs.getDataColumns();
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//StringUtil.printMsg("# TB_JOB_INSERT","TB_JOB_INSERT",this);							
							cstmt = conn.prepareCall(arr_sql[8].toString());
							cstmt.setString(1, rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")));
							rs = cstmt.executeQuery();
							if(rs.next())
								throw new Exception("[Cu010Ipm]\n�̹� �ԷµǾ� �ִ� �ֹι�ȣ�Դϴ�.\n������='��ü'�� ���� ��ȸ�ϱ� �ٶ��ϴ�.");
							
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
								
							cstmt = conn.prepareCall(arr_sql[5].toString());
							for(; j<40;){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER ){
									//StringUtil.printMsg("NUMBER:::::", "NUMBER", this);
									cstmt.setInt(j, rows[i].getInt(j++));
								}
								else
									cstmt.setString(j, rows[i].getString(j++).trim());
									//StringUtil.printMsg("STRING:::::", "STRING", this);
							}
							cstmt.setString(j++, iParamEmpno);
							//StringUtil.printMsg("iParamEmpno:::::",iParamEmpno, this);
							cstmt.setString(j++, iParamIp);
							//StringUtil.printMsg("iParamIp:::::", iParamIp, this);
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
							
							/*
							cstmt = conn.prepareCall(arr_sql[9].toString());
							cstmt.setString(1, rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")));
							rs = cstmt.executeQuery();
							if(rs.next()){
								if(resultDs!=null) {
									GauceDataRow resultRow = resultDs.newDataRow();
									resultRow.addColumnValue(rs.getInt("CUST_SID"));
									resultDs.addDataRow(resultRow);
								}
							}
							*/
							//����� ������ �߰� 20140204 =>�߰��κ� ����
							String r_s_yn		= cstmt.getString(46);
							String r_msg_cd	 	= cstmt.getString(47);
							String r_msg		= cstmt.getString(48);
							
							if(resultDs!=null){
								resultDs.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
								resultDs.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
								resultDs.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
								resultDs.heap();					
							}
							//����� ������ �߰� 20140204 =>�߰��κ� ��							
									
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
							
							
							/*20131211 �ּ�
							//�� ���� ���� ���
							int data_name = imgDs.indexOfColumn("PICTURE_INFO");
							int data_url  = imgDs.indexOfColumn("PICTURE_URL");
							String d_name = imgRow[i].getString(data_name);
							//StringUtil.printMsg("d_name", "["+ d_name +"]", this);
							if(d_name!=null && !d_name.equals("")){
								String o_name = rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")) + ".JPG";
								
								InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
								FileOutputStream os = new FileOutputStream(SAVE_FILE + o_name);
								copy(is, os, 1024*1024*10 );
								is.close();
								os.close();
							}
							*/
						
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							StringUtil.printMsg("# TB_JOB_UPDATE","TB_JOB_UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[5].toString());

							for(; j<40;){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
									cstmt.setInt(j, rows[i].getInt(j++));
								else
									cstmt.setString(j, rows[i].getString(j++).trim());
							}
							
							cstmt.setString(j++, iParamEmpno);	//40
							cstmt.setString(j++, iParamIp);		//41
							//cstmt.setString(j++, rows[i].getString(0).trim());
							cstmt.setString(j++, rows[i].getString(inputDs.indexOfColumn("CUST_SID")));//42
							cstmt.setInt(j++, rows[i].getInt(52) );	//43.�Ҽ�ȸ�� client_sid 		52��° �÷�
							cstmt.setInt(j++, rows[i].getInt(53) );	//44.���δ�ȸ�� realclient_sid	53��° ��ȸ�÷�
							
							cstmt.setString(j++, "3");			//45.��������     1: INSERT, 2: DELETE, 3: UPDATE						
							cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//46.����Y/N
							cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//47.�޼��� �ڵ�
							cstmt.registerOutParameter(j++, java.sql.Types.VARCHAR);//48.�޼���

							cstmt.executeUpdate();	// �Ʊ� �̰� �����µ�.. ��..;
						
							//����� ������ �߰� 20140204 =>�߰��κ� ����
							String r_s_yn2		= cstmt.getString(46);
							String r_msg_cd2	 	= cstmt.getString(47);
							String r_msg2		= cstmt.getString(48);
							
							if(resultDs!=null){
								resultDs.put("S_YN", 	r_s_yn2, 1);//Ŀ�� OUT param.
								resultDs.put("MSG_CD", r_msg_cd2, 4);//Ŀ�� OUT param.
								resultDs.put("MSG", 	r_msg2, 200);//Ŀ�� OUT param.
								resultDs.heap();					
							}
							//����� ������ �߰� 20140204 =>�߰��κ� ��		
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[7].toString());
							cstmt.setString(1, rows[i].getString(inputDs.indexOfColumn("CUST_SID"))); // ������ȣ�� ���� 
							cstmt.executeUpdate();
							break;
					}
					if(cstmt!=null) cstmt.close();
				}
				if(resultDs!=null) gos.write(resultDs);
				
				/*20131211�ּ�
				for(int i=0; i<imgRow.length; i++){
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
				}
				*/
			}
    	} catch (Exception e) {
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", "9010", e.toString()) );//����ڷ� �ϸ�?
    		throw e;
			/**
			 * 20151016 �ɵ��� : GAUCE5.x�̻� ���� ���� �����ϱ� 
			 * new GauceException(������, �����ڵ�, �����޽���)
			 * - ������     : client���� ������ �����ϴ� ������(����� ����)
			 * 				  Fail�� ó���� ���� SrvERROR, ���������� SrvINFO
			 * - �����ڵ�   : ����� ���� �����ڵ� (����4�ڸ�?)
			 * - �����޽��� : ����� ���� �����޽���
			 **/

    	} finally {
			gos.close();	//�̰� ����� �;� ���ܸ� �����ݴϴ�.

			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}