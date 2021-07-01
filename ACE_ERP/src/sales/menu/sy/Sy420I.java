package sales.menu.sy;

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

public class Sy420I extends SuperServlet {

	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * ������� : SY011
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
		 * �����μ� ��ȸ
		 */
		arr_sql[1].append("SELECT  T1.DEPT_SID         AS DEPT_SID        							\n")/* �μ� SID		*/
				  .append("       ,T1.DEPT_CD          AS DEPT_CD         							\n")/* �μ��ڵ�		*/
				  .append("       ,T1.DEPT_NM          AS DEPT_NM         							\n")/* �μ���  		*/
				  .append("       ,T1.PRT_SEQ          AS PRT_SEQ         							\n")/* ��¼���		*/
				  .append("       ,T1.PARENT_DEPT_SID  AS PARENT_DEPT_SID 							\n")/* �����μ�SID	*/
				  .append("       ,T2.DEPT_CD          AS PARENT_DEPT_CD      						\n")
				  .append("		  ,T1.USE_YN														\n")	
				  .append("  FROM 												\n")
				  .append("        SALES.TSY420 T1 LEFT OUTER JOIN  SALES.TSY420 T2 ON  T1.DEPT_SID  = T2.PARENT_DEPT_SID	\n")
				  .append("WHERE 1 = 1 																				\n");		
		/*
		 * �����μ� ���
		 */

		arr_sql[2].append("INSERT INTO 	SALES.TSY420			 (")
				  .append("				 DEPT_CD        		\n")	/* �μ��ڵ�          	*/
				  .append("				,DEPT_NM      			\n")	/* �μ���                	*/
				  .append("				,PRT_SEQ      			\n")	/* ��¼���            	*/
				  .append("				,PARENT_DEPT_SID      	\n")	/* �����μ�SID   	*/
				  .append("				,USE_YN        			\n")	/* �������         	*/
				  
				  .append("				,U_EMPNO         		\n")	/* ����������         	*/
				  .append("				,U_DATE        			\n")	/* ������������      	*/
				  .append("				,U_IP    				\n")	/* ��������IP    	*/
				  .append("			)					\n")
				  
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				?,?,?,?,?,		\n")	
				  .append("				?,CURRENT TIMESTAMP,?	\n")
				  .append("			)");
		
	
		
	
		
		/*
		 * �����μ� ����
		 */

		arr_sql[3].append("UPDATE SALES.TSY420 SET 						\n")
				  .append("		 dept_cd			= ?     				\n")	/* �μ��ڵ�          	*/
				  .append("		,dept_nm			= ?     				\n")	/* �μ���                	*/
				  .append("		,prt_seq			= ?    				 	\n")	/* ��¼���            	*/
				  .append("		,parent_dept_sid	= ?     				\n")	/* �����μ�SID   	*/
				  .append("		,use_yn      		= ?  					\n")	/* �������         	*/

				  .append("		,u_empno			= ?    					\n")	/* ����������         	*/
				  .append("		,u_date				= CURRENT TIMESTAMP  	\n")	/* ������������      	*/
				  .append("		,u_ip         		= ?						\n")	/* ��������IP    	*/

				 .append ("WHERE   dept_sid		 	= ?       				\n");
				  

		 arr_sql[4].append("DELETE FROM SALES.TSY420 WHERE dept_sid = ?");	
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
						if ("USEYN".equals(gauceName)) { 					// ������� 
							stmt = conn.getGauceStatement(arr_sql[0].toString());
							stmt.setString(codeCnt++, "SY011");
						}
						
						if  ("S_USEYN".equals(gauceName)){
							stmt = conn.getGauceStatement(arr_sql[0].toString());
							stmt.setString(codeCnt++, "SY011");
						}
						rs = stmt.executeQuery();		// Query ����
						getDataSet(rs, ds1).flush();
						StringUtil.printMsg("�����μ��ڵ�",arr_sql[0].toString(),this);
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
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sDept_cd = HDUtil.nullCheckStr(req.getParameter("sDept_cd"));	// �����μ��ڵ�
		String sDept_nm = HDUtil.nullCheckStr(req.getParameter("sDept_nm")); 	// �����μ���
		String sUse_yn = HDUtil.nullCheckStr(req.getParameter("sUse_yn"));		// ������� 
		
		StringUtil.printMsg("�����μ��ڵ�",sDept_cd,this);
		StringUtil.printMsg("�����μ��� ",sDept_nm,this);
		StringUtil.printMsg("������� ",sUse_yn,this);
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
	
						if (!"".equals(sDept_cd)) { // �����μ��ڵ�
					  		 arr_sql[1].append("		 AND T1.dept_cd    = ?	\n");	//�����μ��ڵ�
						}
						if (!"".equals(sDept_nm)) { // �����μ���
					  		 arr_sql[1].append("		 AND T1.dept_nm    LIKE ?	\n");	// �����μ��� 
						}
						if (!"".equals(sUse_yn)) { // ������� 
					  		 arr_sql[1].append("		 AND T1.use_yn     = ? 		\n");	// ��뿩�� 
						}
						arr_sql[1].append("ORDER BY T1.PRT_SEQ  					\n");
		
				  		 // ���� ����
				  		 
						
				  		
				  		// ����
						
				  		if (!"".equals(sDept_cd)) {
					  		stmt.setString(sCnt1++, sDept_cd);		// �����μ��ڵ�
					  		 
						}
						if (!"".equals(sDept_nm)) { 
							stmt.setString(sCnt1++, sDept_nm + "%" );		// �����μ��� 
						}
						if (!"".equals(sUse_yn)) { 
					  		 stmt.setString(sCnt1++, sUse_yn);				// ��뿩�� 
						}
					}
			  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
					System.out.println(sDept_cd);
					StringUtil.printMsg("QUERY",arr_sql[1].toString(),this);

					
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
		
		System.out.println("apply");
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		
		int fClientSid = 0;
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_DeptSid               = ds1.indexOfColumn("DEPT_SID");
				int colNm_DeptCd                = ds1.indexOfColumn("DEPT_CD");
				int colNm_DeptNm                = ds1.indexOfColumn("DEPT_NM");
				int colNm_PrtSeq                = ds1.indexOfColumn("PRT_SEQ");
				int colNm_ParentDept_sid        = ds1.indexOfColumn("PARENT_DEPT_SID");
				int colNm_Use_Yn                 = ds1.indexOfColumn("USE_YN");
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							stmt = conn.getGauceStatement(arr_sql[2].toString());
					
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(iCnt++, colNm_DeptCd);
							stmt.bindColumn(iCnt++, colNm_DeptNm);
							stmt.bindColumn(iCnt++, colNm_PrtSeq);
							stmt.bindColumn(iCnt++, colNm_ParentDept_sid);
							stmt.bindColumn(iCnt++, colNm_Use_Yn);
							stmt.setString(iCnt++, iParamEmpno);
							stmt.setString(iCnt++, iParamIp);
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							rs = stmt.executeQuery();
							rs.close();
							stmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							stmt = conn.getGauceStatement(arr_sql[3].toString());
							stmt.setGauceDataRow(rows[i]);
							
							
							stmt.bindColumn(uCnt++, colNm_DeptCd);
							stmt.bindColumn(uCnt++, colNm_DeptNm);
							stmt.bindColumn(uCnt++, colNm_PrtSeq);
							stmt.bindColumn(uCnt++, colNm_ParentDept_sid);
							stmt.bindColumn(uCnt++, colNm_Use_Yn);

							stmt.setString(uCnt++, iParamEmpno);
							stmt.setString(uCnt++, iParamIp);
							stmt.bindColumn(uCnt++, colNm_DeptSid);
							
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[10].toString());
							stmt.setGauceDataRow(rows[i]);
							StringUtil.printMsg("CL SID " , colNm_DeptSid+"",this);
							stmt.bindColumn(dCnt++, colNm_DeptSid);
							
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
