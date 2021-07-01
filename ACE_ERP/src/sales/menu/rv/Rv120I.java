package sales.menu.rv;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv120I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		} 
		 
		/*
		 * �����ڵ� ����
		 * SY011 : �������
		 * RV003 : �����ڵ� 
		 * RV004 : ����������
		 */
		arr_sql[0].append ("SELECT										\n")
				  .append ("	'' head, '' detail, '��ü' detail_nm    \n")
				  .append ("FROM SYSIBM.SYSDUMMY1                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.head, B.detail, B.detail_nm           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.head = B.head                        \n")
				  .append (" AND B.head = ?                             \n")
				  .append (" AND LENGTH (B.detail) > 0                  \n");
	
		
		/*
		 * �������� ���̺� ��ȸ
		 */
		arr_sql[1].append("SELECT T1.DC_SID			    									\n")	/* Ȱ���ڵ�SID                	*/
	      		  .append("		 ,T1.DC_GUBUN_CD        									\n")	/* Ȱ�α����ڵ� (1��ü, 2�Ϲ�)    	*/
	      		  .append("		 ,T1.DC_ITEM3      											\n")	/* ���α���3(����)            	*/
	      		  .append("		 ,T1.DC_ITEM1      											\n")	/* ���α���1(��ǰ)            	*/
	      		  .append("		 ,T1.DC_ITEM2      											\n")	/* ���α���2(������)            	*/
	      		  .append("		 ,T1.BGN_DATE      											\n")	/* ������         					*/
	      		  .append("		 ,T1.END_DATE        										\n")	/* ������         					*/
	      		  .append("		 ,T1.APP_DC_CD         										\n")	/* ����������(RV004)         	*/
	      		  .append("		 ,SALES.FN_DETAIL_NM ('RV004', T1.APP_DC_CD) AS APP_DC_NM   \n")	
	      		  .append("		 ,INTEGER(T1.APP_DC_RATE) AS APP_DC_RATE					\n")	/* ����������/�ݾ�     			*/
	      		  .append("		 ,T1.APP_PERSONS  											\n")	/* ����   		*/
	      		  .append("		 ,T1.USE_YN         										\n")	/* ��뿩��                   		*/
	      		  .append(" FROM SALES.TRV300 T1											\n")
	      		  .append("WHERE 1 = 1 														\n")
	      		  .append("	 AND T1.DC_GUBUN_CD  = '3' 									\n");	//�ָ� ������			  

		
		/*
		 * �������� ���̺� ���
		 */

		arr_sql[2].append("INSERT INTO SALES.TRV300 (	\n")
				  .append("				 DC_GUBUN_CD    \n")	/* Ȱ�α����ڵ� (1��ü, 2�Ϲ�)     */
				  .append("				,DC_ITEM2      	\n")	/* ���α���1(������               	*/
				  .append("				,BGN_DATE      	\n")	/* ������                 			*/
				  .append("				,END_DATE      	\n")	/* ������         					*/
				  .append("				,APP_DC_CD      \n")	/* ����������(RV004)        	*/
				  
				  .append("				,APP_DC_RATE    \n")	/* ����������/�ݾ�         			*/
				  .append("				,FOC_PERSONS    \n")	/* ����FOC          				*/
				  .append("				,USE_YN		    \n")	/* ��뿩��     					*/
				  .append("				,U_EMPNO		\n")	
				  .append("				,U_DATE		    \n")	
				  
				  .append("				,U_IP		    \n")	
				  .append("			)					\n")
				  
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				?,?,?,?,?,		\n")	
				  .append("				?,?,?,?,CURRENT TIMESTAMP,		\n")
				  .append("				?				\n")
				  .append("			)");
		
		
		/*
		 * �������� ���̺� ����
		 */

		arr_sql[3].append("UPDATE SALES.TRV300 SET 						\n")
				  .append("		 END_DATE		= ?     				\n")	/* ������         					*/
				  .append("		,APP_DC_CD      = ?  					\n")	/* ����������(RV004)          	*/

				  .append("		,APP_DC_RATE	= ?    					\n")	/* ����������/�ݾ�    			 	*/
				  .append("		,FOC_PERSONS	= ?  					\n")	/* ����FOC               		*/
				  .append("		,USE_YN         = ?						\n")	/* ��뿩��                   		*/
				  .append("		,U_EMPNO      	= ?						\n")	
				  .append("		,U_DATE         = CURRENT TIMESTAMP						\n")	

				  .append("		,U_IP         	= ?						\n")	
				 .append ("WHERE   DC_SID 		= ?       				\n");
				  
		
		 arr_sql[4].append("DELETE FROM SALES.TRV300 WHERE DC_SID = ?");	
		 
		 
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // �������� ���̺� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sDate 		= HDUtil.nullCheckStr(req.getParameter("sDate"));		// ��������
		String sSaup	 	= HDUtil.nullCheckStr(req.getParameter("sSaup")); 		// ���� (trm300 ���̺����� dc_item3 �÷�=���ڿ���)
		String sGoods	 	= HDUtil.nullCheckStr(req.getParameter("sGoods")); 		// ��ǰ (trm300 ���̺����� dc_item1 �÷�=���ڿ���)
		String sSeason	 	= HDUtil.nullCheckStr(req.getParameter("sSeason")); 	// ���� 
		String sUse_yn 		= HDUtil.nullCheckStr(req.getParameter("sUse_yn")); 	// �������
		
		StringUtil.printMsg("����", sDate+"", this);
		StringUtil.printMsg("����", sSaup+"", this);
		StringUtil.printMsg("��ǰ", sGoods+"", this);
		StringUtil.printMsg("����", sSeason+"", this);
		StringUtil.printMsg("���", sUse_yn+"", this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					/*
					 * �븮�� ��ȸ
					 */
					if ("DS1".equals(gauceName)) {
	
						if (!"".equals(sDate)) { // ��������
					  		 arr_sql[1].append("		 AND ? BETWEEN T1.BGN_DATE AND T1.END_DATE	\n");	//������
						}
						if (!"0".equals(sSaup)) { // ����
							arr_sql[1].append("		 AND T1.DC_ITEM3  = ?      						\n"); 
						}
						if (!"0".equals(sGoods)) { // ��ǰ
							arr_sql[1].append("		 AND T1.DC_ITEM1  = ?      						\n"); 
						}
						if (!"".equals(sSeason)) { // ����
					  		 arr_sql[1].append("		 AND T1.DC_ITEM2  = ?      						\n"); 
						}
						if (!"".equals(sUse_yn)) { // �������
					  		 arr_sql[1].append("		 AND T1.USE_YN  = ?      						\n"); 
						}
						//arr_sql[1].append("ORDER BY T2.ITEM7 					\n");	//�����ڵ� ���ļ���		
				  		 // ���� ����
				  		 
				  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		// ����
				  		if (!"".equals(sDate)) {
					  		stmt.setString(sCnt1++, sDate);		// ������
						}
						
						if (!"0".equals(sSaup)) { 
							stmt.setString(sCnt1++, sSaup );			// ���� 
						}

						if (!"0".equals(sGoods)) { 
							stmt.setString(sCnt1++, sGoods );			// ��ǰ 
						}

						if (!"".equals(sSeason)) { 
							stmt.setString(sCnt1++, sSeason );			// ���� 
						}
						
						if (!"".equals(sUse_yn)) { 
							stmt.setString(sCnt1++, sUse_yn );			// ������� 
						}
					}
					
					rs = stmt.executeQuery();		// Query ����
					
					getDataSet(rs, ds1).flush();
					
					sCnt1 = 1;
				}
			}
		}catch (SQLException sqle){
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

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
//		ResultSetMetaData 	rsmd 		= null;
		ResultSet 			rs 			= null;
//		String[] 			columnName 	= null;

		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_DcSid                 = ds1.indexOfColumn("DC_SID");
				int colNm_DcGubun_cd            = ds1.indexOfColumn("DC_GUBUN_CD");
				int colNm_DcItem2               = ds1.indexOfColumn("DC_ITEM2");
				int colNm_BgnDate               = ds1.indexOfColumn("BGN_DATE");
				int colNm_EndDate               = ds1.indexOfColumn("END_DATE");
				int colNm_AppDc_cd              = ds1.indexOfColumn("APP_DC_CD");
				int colNm_AppDc_rate            = ds1.indexOfColumn("APP_DC_RATE");
				int colNm_FocPersons            = ds1.indexOfColumn("FOC_PERSONS");
				int colNm_UseYn                 = ds1.indexOfColumn("USE_YN");
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							StringUtil.printMsg("����",arr_sql[2].toString(), this);
							stmt = conn.getGauceStatement(arr_sql[2].toString());
					
							stmt.setGauceDataRow(rows[i]);
							  
							//StringUtil.printMsg("colNm_DcSid",rows[i].getString(colNm_DcSid)+"", this);
							//StringUtil.printMsg("colNm_DcGubun_cd",rows[i].getString(colNm_DcGubun_cd)+"", this);
							//StringUtil.printMsg("colNm_DcItem2",rows[i].getString(colNm_DcItem2)+"", this);
							//StringUtil.printMsg("colNm_BgnDate",rows[i].getString(colNm_BgnDate)+"", this);
							//StringUtil.printMsg("colNm_EndDate",rows[i].getString(colNm_EndDate)+"", this);
							//StringUtil.printMsg("colNm_AppDc_cd",rows[i].getString(colNm_AppDc_cd)+"", this);
							//StringUtil.printMsg("colNm_AppDc_rate",rows[i].getString(colNm_AppDc_rate)+"", this);
							//StringUtil.printMsg("colNm_FocPersons",rows[i].getString(colNm_FocPersons)+"", this);
							//StringUtil.printMsg("colNm_UseYn",rows[i].getString(colNm_UseYn)+"", this);

							
							stmt.setString(iCnt++, "2");			//���⼭ ��Ÿ ��������("2")�� �⺻����
							stmt.bindColumn(iCnt++, colNm_DcItem2);
							stmt.bindColumn(iCnt++, colNm_BgnDate);
							stmt.bindColumn(iCnt++, colNm_EndDate);
							stmt.bindColumn(iCnt++, colNm_AppDc_cd);
							stmt.bindColumn(iCnt++, colNm_AppDc_rate);
							stmt.bindColumn(iCnt++, colNm_FocPersons);
							stmt.bindColumn(iCnt++, colNm_UseYn);
							stmt.setString(iCnt++, iParamEmpno);
							stmt.setString(iCnt++, iParamIp);

							// ��������
							stmt.executeUpdate();
							
							stmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							stmt = conn.getGauceStatement(arr_sql[3].toString());
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(uCnt++, colNm_EndDate);
							stmt.bindColumn(uCnt++, colNm_AppDc_cd);
							stmt.bindColumn(uCnt++, colNm_AppDc_rate);
							stmt.bindColumn(uCnt++, colNm_FocPersons);
							stmt.bindColumn(uCnt++, colNm_UseYn);
							stmt.setString(uCnt++, iParamEmpno);
							stmt.setString(uCnt++, iParamIp);
							stmt.bindColumn(uCnt++, colNm_DcSid);
							
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[4].toString());
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(dCnt++, colNm_DcSid);
							
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							
							break;
					}
				
				}
			}

		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}

	}

}
