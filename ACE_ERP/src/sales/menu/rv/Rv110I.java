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

public class Rv110I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * �����ڵ� ����
		 * SY011 : �������
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
		 * ��ü�� ��ȸ 
		 */
		arr_sql[1].append("SELECT 						       								\n")                                                                          
					.append("       T1.DC_SID        										\n")	/* �����ڵ� SID               */              
					.append("      ,T1.DC_GUBUN_CD        									\n")	/* ���α����ڵ�(1��ü/2�Ϲ�)  */              
					.append("      ,T1.DC_ITEM1        										\n")	/* ���α���1(��ǰSID)         */              
					.append("      ,T2.GOODS_CD        										\n")	/* ��ǰ�ڵ�                   */              
					.append("      ,T2.GOODS_NM        										\n")	/* ��ǰ��                     */              
					.append("      ,T1.BGN_DATE        										\n")    /* ������                     */              
					.append("      ,T1.END_DATE        										\n")    /* ������                     */              
					.append("      ,T1.BGN_PERSONS        									\n")    /* �����ο�                   */              
					.append("      ,T1.END_PERSONS        									\n")    /* �����ο�                   */              
					.append("      ,T1.APP_DC_CD        									\n")    /* ����������[RV004]        */              
					.append("      ,SALES.FN_DETAIL_NM ( 'RV004',T1.APP_DC_CD) AS APP_DC_NM \n")                 
					.append("      ,T1.APP_DC_RATE       			 						\n")    /* ����������/�ݾ�            */              
					.append("      ,T1.FOC_PERSONS        									\n")    /* ���� FOC �ο�              */              
					.append("      ,T1.USE_YN        										\n")    /* ��뿩��                   */              
					.append("      ,SALES.FN_DETAIL_NM ( 'SY011',T1.USE_YN) AS USE_YN_NM    \n")                    
					.append("  FROM        													\n")                                                                           
					.append("       SALES.TRV300 T1        									\n")                                                           
					.append("      ,SALES.TRM200 T2        									\n")                                                           
					.append(" WHERE 1 = 1        											\n")                                                                     
					.append("   AND INTEGER(T1.DC_ITEM1)    = T2.GOODS_SID        			\n")  
					.append("   AND T1.DC_GUBUN_CD = '1'        							\n");    /*  ���α����ڵ�(1��ü/2�Ϲ�) */         
		
		/*
		 * ���
		 */

		arr_sql[2].append("INSERT INTO SALES.TRV300 (					\n")
					.append("	DC_GUBUN_CD							\n")
					.append("	,DC_ITEM1								\n")
					
					.append("	,BGN_DATE								\n")
					.append("	,END_DATE								\n")
					.append("	,BGN_PERSONS							\n")
					.append("	,END_PERSONS							\n")
					.append("	,APP_DC_CD								\n")
					
					.append("	,APP_DC_RATE							\n")
					.append("	,FOC_PERSONS							\n")
					.append("	,USE_YN									\n")
					.append("	,U_EMPNO								\n")	
					.append("	,U_DATE		    						\n")	

					.append("	,U_IP		    						\n")	
					.append("			)								\n")
					 
					.append("VALUES										\n")
					.append("			(	    						\n")
					.append("				?,?,						\n")
					.append("				?,?,?,?,?,					\n")	
					.append("				?,?,?,?,CURRENT TIMESTAMP,	\n")
					.append("				?			\n")
					.append("											\n")
					.append("			)								\n");
		
		
		/*
		 * ����
		 */

		arr_sql[3].append("UPDATE SALES.TRV300 SET 						\n")
					.append("dc_item1 = ?,			\n")   
					.append("bgn_date = ?,			\n")   
					.append("end_date = ?,			\n")   
					.append("bgn_persons = ?,			\n")
					.append("end_persons = ?,			\n")
					.append("app_dc_cd = ?,			\n")  
					.append("app_dc_rate = ?,			\n")
					.append("foc_persons = ?,			\n")
					.append("use_yn = ?,			\n")     
					.append("u_empno = ?,")
					.append("u_date=CURRENT TIMESTAMP,")
					.append("u_ip=? ")
				 .append ("WHERE   DC_SID 		= ?       				\n");
				  
		
		 arr_sql[4].append("DELETE FROM SALES.TRV300 WHERE DC_SID = ?");	
		 
		 
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
		
		GauceDataSet 		ds1 		= null;
		GauceStatement 		stmt 		= null;
		ResultSet 			rs			= null;
//		ResultSetMetaData 	rsmd 		= null;
//		String[] 			columnName 	= null;
		
//		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			
			while(it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				int codeCnt = 1;
				if (ds1 != null) {
					switch(dsType) {
					case 1:
						res.enableFirstRow(ds1);
						
						// � �ڵ带 ������ �ð��ΰ��� �����Ѵ� 
					if ("RV004".equals(gauceName)) {								// ����������
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(codeCnt++, "RV004");
					} else if ("SY011".equals(gauceName)) {								// �������
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(codeCnt++, "SY011");
					}
						
						rs = stmt.executeQuery();		// Query ����
						getDataSet(rs, ds1).flush();
					
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

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null;
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sDate = HDUtil.nullCheckStr(req.getParameter("sDate"));		// ��������
		String sGoods_sid = HDUtil.nullCheckStr(req.getParameter("sGoods_sid")); 	// ��ǰ�ڵ�
		
		StringUtil.printMsg("���� " , sDate+"", this);
		StringUtil.printMsg("�ڵ�", sGoods_sid+"", this);
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
	
						if (!"".equals(sDate)) {
					  		 arr_sql[1].append("   AND ?     BETWEEN T1.BGN_DATE AND T1.END_DATE        		\n");	//������
						}
						if (!"".equals(sGoods_sid)) { 
					  		 arr_sql[1].append("		AND INTEGER(T1.DC_ITEM1)   = ?     						\n");	// ��ǰ�ڵ� 
						}
			
						arr_sql[1].append(" ORDER BY T1.BGN_PERSONS			\n");	// �⺻ ��
						
						// ���� ����
				  		//StringUtil.printMsg("QUERY",arr_sql[1].toString(),this);
				  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
				  		// ����
				  		if (!"".equals(sDate)) {
					  		stmt.setString(sCnt1++, sDate);		// ������
					  		 
						}
						if (!"".equals(sGoods_sid)) { 
							stmt.setString(sCnt1++, sGoods_sid );			// ��ǰ�ڵ� 
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
				int colNm_DcItem1               = ds1.indexOfColumn("DC_ITEM1");
				int colNm_BgnDate               = ds1.indexOfColumn("BGN_DATE");
				int colNm_EndDate               = ds1.indexOfColumn("END_DATE");
				int colNm_BgnPersons            = ds1.indexOfColumn("BGN_PERSONS");
				int colNm_EndPersons            = ds1.indexOfColumn("END_PERSONS");
				int colNm_AppDc_cd              = ds1.indexOfColumn("APP_DC_CD");
				int colNm_AppDc_rate            = ds1.indexOfColumn("APP_DC_RATE");
				int colNm_FocPersons            = ds1.indexOfColumn("FOC_PERSONS");
				int colNm_UseYn                 = ds1.indexOfColumn("USE_YN");

				StringUtil.printMsg("colNm_DcSid       ", colNm_DcSid,this);                        
				StringUtil.printMsg("colNm_DcGubun_cd  ", colNm_DcGubun_cd,this);                   
				StringUtil.printMsg("colNm_DcItem1     ", colNm_DcItem1,this);                      
				StringUtil.printMsg("colNm_BgnDate     ", colNm_BgnDate,this);                      
				StringUtil.printMsg("colNm_EndDate     ", colNm_EndDate,this);                      
				StringUtil.printMsg("colNm_BgnPersons  ", colNm_BgnPersons,this);                   
				StringUtil.printMsg("colNm_EndPersons  ", colNm_EndPersons,this);                   
				StringUtil.printMsg("colNm_AppDc_cd    ", colNm_AppDc_cd,this);                     
				StringUtil.printMsg("colNm_AppDc_rate  ", colNm_AppDc_rate,this);                   
				StringUtil.printMsg("colNm_FocPersons  ", colNm_FocPersons,this);                   
				StringUtil.printMsg("colNm_UseYn       ", colNm_UseYn,this);                        
				                                                                                    

				
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
						
							StringUtil.printMsg("����",arr_sql[2].toString(), this);
							
							StringUtil.printMsg("colNm_DcSid       ", rows[i].getString(colNm_DcSid),this);
							StringUtil.printMsg("colNm_DcGubun_cd  ", rows[i].getString(colNm_DcGubun_cd),this);
							StringUtil.printMsg("colNm_DcItem1     ", rows[i].getString(colNm_DcItem1),this);
							StringUtil.printMsg("colNm_BgnDate     ", rows[i].getString(colNm_BgnDate),this);
							StringUtil.printMsg("colNm_EndDate     ", rows[i].getString(colNm_EndDate),this);
							StringUtil.printMsg("colNm_BgnPersons  ", rows[i].getString(colNm_BgnPersons),this);
							StringUtil.printMsg("colNm_EndPersons  ", rows[i].getString(colNm_EndPersons),this);
							StringUtil.printMsg("colNm_AppDc_cd    ", rows[i].getString(colNm_AppDc_cd),this);
							StringUtil.printMsg("colNm_AppDc_rate  ", rows[i].getString(colNm_AppDc_rate),this);
							StringUtil.printMsg("colNm_FocPersons  ", rows[i].getString(colNm_FocPersons),this);
							StringUtil.printMsg("colNm_UseYn       ", rows[i].getString(colNm_UseYn),this);
							
							
							stmt = conn.getGauceStatement(arr_sql[2].toString());
					
							stmt.setGauceDataRow(rows[i]);
							
							stmt.setString(iCnt++, "1");
							stmt.bindColumn(iCnt++, colNm_DcItem1);
							stmt.bindColumn(iCnt++, colNm_BgnDate);
							stmt.bindColumn(iCnt++, colNm_EndDate);
							stmt.bindColumn(iCnt++, colNm_BgnPersons);
							stmt.bindColumn(iCnt++, colNm_EndPersons);
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
							
						
							
							stmt.bindColumn(uCnt++, colNm_DcItem1);
							stmt.bindColumn(uCnt++, colNm_BgnDate);
							stmt.bindColumn(uCnt++, colNm_EndDate);
							stmt.bindColumn(uCnt++, colNm_BgnPersons);
							stmt.bindColumn(uCnt++, colNm_EndPersons);
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
