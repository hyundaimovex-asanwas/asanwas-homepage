package sales.menu.cu;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class Cu040S extends SuperServlet {

	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * �����ڵ� ����
		 * �븮������ : CU006
		 * ���Ǳ��� : CU012
		 * ���� : SY006
		 * ������ : CU013
		 * ������� : SY011
		 * ��������ȸ�� : CU010
		 * �����븮������ : CU011
		 */
		arr_sql[0].append ("SELECT										\n")
				  .append ("	' ' head, ' ' detail, '��ü' detail_nm    \n")
				  .append ("FROM DUAL                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.head, B.detail, B.detail_nm           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.head = B.head                        \n")
				  .append (" AND B.head = ?                             \n")
				  .append (" AND LENGTH (rtrim(B.detail)) > 0                  \n");
		
		/*
		 * �븮�� ��ȸ
		 */
		arr_sql[1].append("SELECT 																							\n")
	       		  .append(" 	 T2.SAL_DAM_NM 																				\n") /* ���������       */
	       		  .append("		,T1.CLIENT_CD 																				\n") /* �븮�� �ڵ�      */
			      .append("		,T1.VEND_CD 																				\n") /* [ȸ��]�ŷ�ó �ڵ�*/
			      .append("		,T1.CLIENT_NM 																				\n") /* �븮�� ��        */
			      .append("		,SALES.FN_DETAIL_NM ('CU006',T1.AGEN_GU)     AS AGEN_GU_NAME 								\n") /* ����             */
			      .append("		,SALES.FN_DETAIL_NM ('CU012',T1.DIR_YN)      AS DIR_YN_NAME 								\n") /* ����             */
			      .append("		,SALES.FN_DETAIL_NM ('SY006',T1.AREA_CD)     AS AREA_CD_NAME 								\n") /* ����             */
			      .append("		,T1.COMMI_RATE 																				\n") /* ��������         */
			      .append("		,SALES.FN_DETAIL_NM ('CU013',T1.CUNT_STATUS) AS CUNT_STATUS_NAME 							\n") /* ���             */
			      .append("		,T1.CLIENT_DAM_NM 																			\n") /* ����ó�����     */
			      .append("		,T1.TEL_NO 																					\n") /* ��ȭ��ȣ         */
			      .append("		,T1.MOBILE_NO 																				\n") /* �޴���ȭ         */
			      .append("		,T1.FAX_NO 																					\n") /* �ѽ���ȣ         */
			      .append("		,T1.E_MAIL 																					\n") /* �����ּ�         */
			      .append("		,T3.CONT_DATE 																				\n") /* �������         */
			      .append("		,T3.EXPIRE_DATE 																			\n") /* ��������         */
			      .append("		,SALES.FN_DETAIL_NM ('CU010',T3.INSUR_COMP_CD) AS INSUR_COMP_CD_NAME 						\n") /* ��������ȸ���   */      
			      .append("		,SALES.FN_DETAIL_NM ('SY011',T1.USE_YN)      AS USE_YN_NAME 								\n") /* �������         */
			      .append("FROM SALES.TCU030 T1 LEFT OUTER JOIN SALES.TSY410 T2 ON T1.SAL_DAM_SID  = T2.SAL_DAM_SID 		\n")
	              .append("		LEFT OUTER JOIN SALES.TCU031 T3 ON T1.CLIENT_SID   = T3.CLIENT_SID 							\n")
				  .append("WHERE 1 = 1 																						\n")
		  		  .append("		AND T3.CONT_DATE    = (SELECT MAX(T4.CONT_DATE ) 											\n")
				  .append("									FROM SALES.TCU031 T4 											\n")
				  .append("									WHERE T4.CLIENT_SID   = T1.CLIENT_SID) 							\n")
				  .append("		AND T1.CLIENT_GU = '1' 																		\n"); /* ����ó���� : 2:�븮��) */
				
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		CallableStatement cstmt = null;
		
		int v_rowcnt = 0;
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 
			
		    for(int i=0; i<dSets.length;i++){
		    	 if(dSets[i].getName().equals("codeDs5")){//�������
			    		GauceDataSet ds1 = gis.read("USEYN"); 		
			    		cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "SY011");
						rs = cstmt.executeQuery(); 
			   			gos.write(getDataSet(rs, ds1));// DataSet set
			   			rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];	
			   		} else if(dSets[i].getName().equals("sCodeDs1")){//�������
			    		GauceDataSet ds1 = gis.read("S_USEYN"); 		
			    		cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "SY011");
						rs = cstmt.executeQuery(); 
			   			gos.write(getDataSet(rs, ds1));// DataSet set
			   			rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];	
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

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;

		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sClient_sid = HDUtil.nullCheckStr(greq.getParameter("sClient_sid"));	// ����ó SID
		String sClient_nm = HDUtil.nullCheckStr(greq.getParameter("sClient_nm")); 	// LIKE
		String sSal_dam_sid = HDUtil.nullCheckStr(greq.getParameter("sSal_dam_sid")); 	// ��������� �ڵ� 
		String sUse_yn = HDUtil.nullCheckStr(greq.getParameter("sUse_yn"));			// ������� 
		
		try {
			int sCnt1 = 1;
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DS1");
					if (!"".equals(sClient_nm)) { // �븮���ڵ�/��
				  		 arr_sql[1].append("		 AND (T1.client_cd    LIKE ? OR T1.client_nm LIKE ?)	\n");	//����ó�ڵ�
					}
					if (!"".equals(sSal_dam_sid)) { // ��������ڸ�/�ڵ�
						arr_sql[1].append("					AND (T2.SAL_DAM_SID = ?) 								\n");        /* ��������� */
					}
					if (!"".equals(sUse_yn)) { // ������� 
				  		 arr_sql[1].append("		 AND T1.use_yn     = ?          						\n");	// ��뿩�� 
					}
					arr_sql[1].append("				ORDER BY T2.SAL_DAM_NM  ,T1.CLIENT_CD  \n");		/* ����ó���� :CU005          */
						  		  
					// ���� ����
					cstmt = conn.prepareCall(arr_sql[1].toString()); 
					//StringUtil.printMsg(" arr_sql[1].toString() ",arr_sql[1].toString(),this);	
				  		
			  		// ����
			  		if (!"".equals(sClient_nm)) {
				  		cstmt.setString(sCnt1++, sClient_nm + "%");		// ����ó�ڵ�
				  		cstmt.setString(sCnt1++, sClient_nm + "%");		// ����ó��
				  		 
					}
					if (!"".equals(sSal_dam_sid)) { 
						cstmt.setString(sCnt1++, sSal_dam_sid );			// ��������� 
					}
					if (!"".equals(sUse_yn)) { 
				  		 cstmt.setString(sCnt1++, sUse_yn);				// ��뿩�� 
					}
					
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			
				}
				sCnt1 = 1;
			}
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
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}