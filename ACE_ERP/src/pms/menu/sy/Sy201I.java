/******************************************************************************
 * �ý��۸�		: ���¾�ü ���
 * ���α׷�ID 	: CU050I
 * J  S  P		: cu050i
 * �� �� ��		: Cu050I
 * [��  ��   ��  ��][������] ����
 * [2008-02-27][�ɵ���] ��������� : ���̺� ������ ���� �ٽ� ����
 * 					���¾�ü ���� SALES.TCU030 1���� �����.
 * 					ȸ����� �ŷ�ó ACCOUNT.GCZM_VENDER
 * [2013-07-03][�ڰ汹] ��������ý��� ���¾�ü �ڵ�����޴��� �ű��ۼ�
 *****************************************************************************/
package pms.menu.sy;

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

public class Sy201I extends SuperServlet {

	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		/*
		 * ���¾�ü��ȸ
		 */
		arr_sql[1].append("SELECT coop_sid			    										\n")	/* ���¾�üSID                	*/
				  .append("		 ,coop_cd      												 				\n")	/* ���¾�ü�ڵ�               	*/
				  .append("		 ,coop_nm     												 				\n")	/* ���¾�ü��               	*/
	      		 	      		  
				  .append("FROM PMS.TSY030 \n")
				  .append("WHERE 1 = 1 																		\n");	      		  
		
		/*
		 *  ���¾�ü���
		 */
		arr_sql[4].append("INSERT INTO PMS.TSY030 (")
				  .append("				 coop_cd      \n")		/* ���¾�ü�ڵ�    */
				  .append("				,coop_nm      \n")		/* ���¾�ü��       */
				  .append("		 		,u_date       	\n") 		/* ������������    */
				  .append("		 		,u_empno       	\n")	/* ���������ڻ�� */
				  .append("			)					\n")
				  
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				?,?,CURRENT TIMESTAMP,?	\n")
				  .append("			)");
		
		/*
		 * ���¾�ü����
		 */
		arr_sql[7].append("UPDATE PMS.TSY030 SET 						\n")
				  .append("		 coop_cd		= ?     									\n")		/* ���¾�ü�ڵ�           	*/
				  .append("		,coop_nm		= ?									\n")		/* ���¾�ü��	 			*/
				  .append("		,u_date        	= CURRENT TIMESTAMP		\n") 	/* ������������           	*/
				  .append("		,u_empno       	= ?						\n")					/* ���������ڻ��        	*/
				 .append ("WHERE   coop_sid 	= ?       				\n");
			
		/*
		 * ���¾�ü����
		 */	  

		 arr_sql[10].append("DELETE FROM PMS.TSY030 WHERE coop_sid = ?");	
	
		 /*
		 * Coop SID ������
		 */
		arr_sql[13].append("SELECT coop_sid FROM PMS.TSY030 WHERE coop_cd = ?\n");
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
		GauceDataSet ds1 = null; // ���¾�ü ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sCoop_cd = HDUtil.nullCheckStr(req.getParameter("sCoop_cd")); 	// ���¾�ü �ڵ�
		String sCoop_nm = HDUtil.nullCheckStr(req.getParameter("sCoop_nm")); 	// ���¾�ü �� 
		//StringUtil.printMsg("���¾�ü �ڵ�",sCoop_cd,this);
		//StringUtil.printMsg("���¾�ü ��",sCoop_nm,this);
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					// ���¾�ü ��ȸ
					if ("DS1".equals(gauceName)) {
						if (!"".equals(sCoop_cd)) { // ���¾�ü �ڵ�
							 arr_sql[1].append("		 AND coop_cd  LIKE ? \n");	
						}
						if (!"".equals(sCoop_nm)) { //���¾�ü ��
							 arr_sql[1].append("		 AND coop_nm LIKE ?	\n");	 
						}
						 arr_sql[1].append("		 ORDER BY coop_cd	\n");
		
						stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
						// ����
						if (!"".equals(sCoop_cd)) { 
							stmt.setString(sCnt1++, sCoop_cd + "%");				// ���¾�ü �ڵ� 
											}
						if (!"".equals(sCoop_nm)) {
							stmt.setString(sCnt1++, sCoop_nm + "%");		// ���¾�ü ��
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
		ResultSet 			rs 			= null;
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		
		int fCoopSid = 0;
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_CoopSid             = ds1.indexOfColumn("coop_sid".toUpperCase());
				int colNm_CoopCd              = ds1.indexOfColumn("coop_cd".toUpperCase());
				int colNm_CoopNm             = ds1.indexOfColumn("coop_nm".toUpperCase());
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							stmt = conn.getGauceStatement(arr_sql[4].toString());	//tsy030 ����
						
							//StringUtil.printMsg("colNm_CoopCd " , colNm_CoopCd+"",this);
							//StringUtil.printMsg("colNm_CoopNm " , colNm_CoopNm+"",this);
							
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(iCnt++, colNm_CoopCd);
							stmt.bindColumn(iCnt++, colNm_CoopNm);
							stmt.setString(iCnt++, iParamEmpno);
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							
							stmt = conn.getGauceStatement(arr_sql[13].toString());
						
							stmt.setString(1, rows[i].getColumnValue(colNm_CoopCd)+"");
							rs = stmt.executeQuery();
							
							if(rs.next()) {
								fCoopSid = rs.getInt(1);
							}
													
							rs.close();
							stmt.close();
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
							
							stmt = conn.getGauceStatement(arr_sql[7].toString());
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(uCnt++, colNm_CoopCd);
							stmt.bindColumn(uCnt++, colNm_CoopNm);
							stmt.setString(uCnt++, iParamEmpno);
							stmt.bindColumn(uCnt++, colNm_CoopSid);
							
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[10].toString());
							stmt.setGauceDataRow(rows[i]);
							stmt.bindColumn(dCnt++, colNm_CoopSid);
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