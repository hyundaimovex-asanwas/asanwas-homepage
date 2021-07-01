package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
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

public class Rv240I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * �����ڵ�
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
		 * ������ ��ȸ
		 */
		arr_sql[1].append ("")
					.append("SELECT             						\n")			   	                                                                                                                           
					.append("       T1.ACCEPT_SID						\n")   /* ��ûSID        */                                                       
					.append("      ,T1.ACCEPT_NO						\n")	/* ��û����ȣ     */                                                       
					.append("      ,T1.ACCEPT_DATE						\n")	/* ��û����       */                                                       
					.append("      ,T1.DEPART_DATE						\n")	/* �������       */                                                       
					.append("      ,T1.GOODS_SID						\n")	/* ��ǰ SID       */                                                       
					.append(" FROM SALES.TRV010 T1						\n")
					.append("WHERE 1=1               					\n")                                                                             
					.append("  AND T1.JOB_GUBUN  = '2'					\n");	/* �۾�����(2:��Ͻ�û) */   
		
		/*
		 * ��������Ʈ ��ȸ
		 */
		arr_sql[2].append ("")
					.append("SELECT 					\n")                           
					.append("       T1.CAR_RSV_SID		\n")	/* ��������SID 		*/          
					.append("      ,T1.ACCEPT_SID		\n")	/* ��ûSID     		*/         
					.append("      ,T1.CAR_SID			\n")	/* ���� SID    		*/          
					.append("      ,T2.CAR_NM			\n")	/* ����        		*/         
					.append("      ,T2.CAR_NO			\n")	/* ������Ϲ�ȣ		*/         
					.append("      ,T1.DEPART_DATE		\n")    /* �������    		*/          
					.append("      ,T1.DEPART_TIME		\n")    /* ���ð�    		*/          
					.append("      ,T1.ARRIVE_DATE		\n")    /* �԰�����    		*/          
					.append("      ,T1.ARRIVE_TIME		\n")    /* �԰�ð�    		*/          
					.append("      ,T1.CARGO			\n")	/* ȭ��        		*/        
					.append("      ,T1.DRIVE_SID		\n")	/* ��������SID 		*/    
					.append("	   ,T3.DRIVE_NO			\n")	
					.append("      ,T4.CUST_NM			\n")	/* �ѱۼ��� (������)  	*/   
					.append("      ,T4.MANAGE_NO		\n")	/* ������ȣ(�ֹ�/����)	*/ 
					.append("      ,T1.CLIENT_SID		\n")	/* ����óSID   		*/         
					.append("      ,T1.LONG_STAY_YN		\n")	/* ���ü������ : RV031  		*/         
					.append("      ,T1.CAR_DESC		\n")	/* �������� �������   		*/         
					.append(" FROM SALES.TRV040 T1		\n") 	/* �������� ���� 		*/           
					.append("     ,SALES.TCU050 T2		\n") 	/* �������� 			*/                
					.append("     ,SALES.TCU040 T3		\n") 	/* ������������ 		*/            
					.append("     ,SALES.TCU010 T4		\n") 	/* ������ 			*/                
					.append("WHERE	1=1 				\n")                                          
					.append("  AND T1.CAR_SID     = T2.CAR_SID		\n")     /* ���� SID    */
					.append("  AND T1.DRIVE_SID   = T3.DRIVE_SID	\n")     /* ��������SID */
					.append("  AND T3.CUST_SID    = T4.CUST_SID		\n");     /* ��SID     */
		
		/*
		 *�ο�����Ʈ ��ȸ (GRID3) 
		 */
		arr_sql[3].append ("")
				.append("SELECT                    										\n")
				.append("      T1.ACCEPT_SID       									\n") 	/* ��û SID         		*/
				.append("      ,T1.RSV_SID       									\n") 	/* ���� SID         		*/       
				.append("      ,T1.CUST_SID       										\n")	/* ��SID            	*/                       
				.append("      ,T2.CUST_NM       										\n")	/* �ѱۼ���           		*/                       
				.append("      ,T2.MANAGE_NO        									\n")	/* ������ȣ(�ֹ�/����)		*/                       
				.append("      ,T2.CUST_TYPE        									\n")	/* ��������		*/                       
				.append("      ,T1.UNITY_NO AS N_CARD_NO      							\n")	/* �������ȣ */                       
				.append("      ,T2.WORK_NO AS WORK_NO    								\n")	/* �ǹ���ȣ		*/                       
				.append("      ,T1.DEPART_DATE       									\n")	/* �������           		*/                       
				.append("      ,T1.DEPART_TIME       									\n")	/* ���ð�           		*/                       
				.append("      ,T1.ARRIVE_DATE       									\n")	/* �԰�����           		*/                       
				.append("      ,T1.ARRIVE_TIME       									\n")	/* �԰�ð�           		*/                       
				.append("      ,T1.DRIVE_YN       										\n")	/* ��������:SY010			*/                       
				.append("      ,SALES.FN_DETAIL_NM('SY010',T1.DRIVE_YN) AS DRIVE_YN_NM  \n")         
				.append("      ,T1.NORTH_PURPOSE       									\n") 	/* ��ϸ���           		*/                       
				.append("      ,T1.LONG_STAY_YN       									\n") 	/* ���ü������ : RV031           		*/				
				.append("      ,SALES.FN_ROOM_TYPE_CD(T3.A_ROOM_TYPE_SID) AS ROOM_TYPE_CD \n") 	/* �������Ÿ��*/
				.append("      ,T3.REMARKS			AS REMARKS   						\n") 	/* �������  		*/
				.append("      ,T3.N_CARD_GU		AS N_CARD_GU						\n") 	/* ����� ����  		*/
				.append("      ,T3.A_ROOM_TYPE_SID										\n") 	/* �������Ÿ��sid	*/
				.append(" FROM SALES.TRV020 T1 JOIN SALES.TCU010 T2 ON (T1.CUST_SID = T2.CUST_SID) \n")  	/*�������� ���� 			*/                                 
				.append("                      JOIN SALES.TCM040 T3 ON (T1.RSV_SID  = T3.RSV_SID) \n")  	/*�������� ���� 			*/				
				.append("WHERE 1=1       												\n");                                                                 
				 
		
		/*
		 * // ��û�� , ��û�� no, ����� SId, ����ó sid, ��û����, ���������� ���, �������� ip, �������� 1(insert) 2(delete) 3(update), �޼����ڵ�, �޼���
		 */
		
		arr_sql[4].append("CALL SALES.PR_RV240I_01(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"); 
		
		/*
		 * ��������SID, ����� SID, ��ûSID, ����SID, ��������SID, ������� , 
		 * ���ð�, �԰�����, �԰�ð�, ȭ��, ����ó SID, 
		 * ���������ڻ��, IP, �������� 1(insert) 2(delete) 3(update), �޼�����, �޼��� 
		 */
		arr_sql[5].append("CALL SALES.PR_RV240I_02(?,?,?,?,?,?, ?, ?,?,?,?,?,?,?,?,?,?,?,?)");
		
		/*
		 * ����SID,����� Sid, ��ûSID, ��SID, �������, ��߽ð�, 
		 * ��������, ���ͽð�, ��������, ��ϸ���, ���, 
		 * IP, �������� 1(insert) 2(delete) 3(update), �޼����ڵ�, �޼���
		 */
		arr_sql[6].append("CALL SALES.PR_RV240I_03(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,? )");
	
		
		/*
		 * ������ ������ ���� ���� 
		 * ��û�� SID
		 */
		
		arr_sql[7].append("CALL SALES.PR_RV240I_04(?,?,?)");
		
		/*
		 * ������� üũ 
		 */
		arr_sql[8].append("SELECT SALES.FN_RSV_CLOSE_YN(?,?) DEPT_FLAG FROM SYSIBM.SYSDUMMY1");
		
		/*
		 * ��ǰ�� ������ڿ� ���� �������, ��߽ð�, �԰�����, �԰�ð� ����
		 */
		arr_sql[9].append(" SELECT DEPART_DATE    	\n")
						.append ("		,DEPART_TIME    		\n")
						.append ("		,ARRIVE_DATE    		\n")
						.append ("		,ARRIVE_TIME    		\n")
						.append ("FROM SALES.TRM220		\n")
						.append ("  WHERE 1 = 1			\n")
						.append ("		AND DEPART_DATE = ?		\n")
						.append ("		AND GOODS_SID   = ?		\n");
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if("RM014".equals(gauceName)){								//���Խð�
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "RM014");
					} else if("RM015".equals(gauceName)){						//���ͽð�
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "RM015");
					} else if ("SY010".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "SY010");
					} else if ("CU022".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "CU022");
					} else if("DS1".equals(gauceName)){
						stmt = conn.getGauceStatement(arr_sql[1].toString());
					} else if("DS2".equals(gauceName)){
						stmt = conn.getGauceStatement(arr_sql[2].toString());
					} else if("DS3".equals(gauceName)){
						stmt = conn.getGauceStatement(arr_sql[3].toString());
					}
////StringUtil.printMsg("gauceName", gauceName, this);
					if(gauceName.equals("DS1") || gauceName.equals("DS2") || gauceName.equals("DS3")){
						rs = stmt.executeQuery();		// Query ����
						getDataSetHead(rs, ds1).flush();
					} else {
						rs = stmt.executeQuery();		// Query ����
						getDataSet(rs, ds1).flush();
					}
				}
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
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

		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		// ������
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClientSid"));				// ���¾�ü
		int sSaupSid 		= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));			// ��� Sid
		String sFromAcceptDate 	= HDUtil.nullCheckStr(req.getParameter("sFromAcceptDate")); 	// ��û���� From
		String sToAcceptDate 	= HDUtil.nullCheckStr(req.getParameter("sToAcceptDate")); 		// ��û���� To
		String sAcceptNo 		= HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));					// ��û����ȣ  
		int sAcceptSid		= HDUtil.nullCheckNum(req.getParameter("sAcceptSid")); // ��û SID
		
		String sDeptDate = HDUtil.nullCheckStr(req.getParameter("sDeptDate")); // �������
		
		int v_goods_sid	= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));
		String v_depart_date = HDUtil.nullCheckStr(req.getParameter("v_depart_date"));
		String vResponse = HDUtil.nullCheckStr(req.getParameter("sResponse"));	//����� ���Կ��� pm = ����� ����
		

		//StringUtil.printMsg("��ȸ �޼ҵ� ", "������?",this);
		
		try {
			int sCnt1 = 1;
			int sCnt2 = 1;
			int sCnt3 = 1;
			
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				//StringUtil.printMsg("ī�콺�̸�:",gauceName,this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					  
					if ("DS1".equals(gauceName)) {
	
//						if (sClientSid!=0)  /* ����óSID */
							arr_sql[1].append("    AND  T1.CLIENT_SID  = ?					\n");	
						
//						if (!"".equals(sToAcceptDate) && !"".equals(sFromAcceptDate))  /* ��û����  */
						////StringUtil.printMsg("DS1.equals(gauceName) - ", vResponse, this);
							if(vResponse.equals("pm")){	//pm ����� ��Ͻ�û�� ���� ��û���ڿ��� ������ڷ� ����...
								arr_sql[1].append("  AND T1.DEPART_DATE BETWEEN ? AND ?		\n");   
							}
							else{
								arr_sql[1].append("  AND T1.ACCEPT_DATE BETWEEN ? AND ?		\n");	
							}
						
						if (!"".equals(sAcceptNo))  	/* ��û����ȣ*/ 
							arr_sql[1].append("  AND T1.ACCEPT_NO   LIKE   ?			\n");   
						
//						if (sSaupSid!=0)  	/* ���SID */ 
						arr_sql[1].append("  AND T1.SAUP_SID =   ?			\n");   
						arr_sql[1].append("  ORDER BY T1.ACCEPT_NO ASC		\n");		
				  		 // ���� ����
				  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
				  		// ����
//				  		if (sClientSid!=0)  /* ����óSID */
					  		stmt.setInt(sCnt1++, sClientSid );	
//				  		if (!"".equals(sToAcceptDate) && !"".equals(sFromAcceptDate)) { /* ��û����  */   
							stmt.setString(sCnt1++, sFromAcceptDate );			// to
							stmt.setString(sCnt1++, sToAcceptDate);			// from 
//						}
				  		if (!"".equals(sAcceptNo))  	/* ��û����ȣ*/ 
				  			stmt.setString(sCnt1++, sAcceptNo + "%");	
				  		
//				  		if (sSaupSid!=0)  	/* ���SID */ 
				  			stmt.setInt(sCnt1++, sSaupSid);
					} 
					//StringUtil.printMsg("arr_sql[1] - ", arr_sql[1].toString(), this);
					
					/*
					 * ����
					 */
					if ("DS2".equals(gauceName)) {
						
//						if (sAcceptSid!=0)  
							arr_sql[2].append("		AND T1.ACCEPT_SID = ? \n");	/* ��û SID */

						//arr_sql[2].append("ORDER BY T1.CAR_RSV_SID				\n");
						
				  		stmt = conn.getGauceStatement(arr_sql[2].toString()); 
				  		
//				  		if (sAcceptSid!=0) 
				  			stmt.setInt(sCnt2++, sAcceptSid);			 /* ��ûSID     */     
					} 
					
					/*
					 * �ο�
					 */
					if ("DS3".equals(gauceName)) {
						  
						//if (sAcceptSid!=0) 
							arr_sql[3].append("  AND    T1.ACCEPT_SID  = ?   \n");  /* ��ûSID     */     
						arr_sql[3].append("ORDER BY T1.RSV_SID       										\n");    
				  		stmt = conn.getGauceStatement(arr_sql[3].toString()); 
				  		
				  		// ����
				  		//if (sAcceptSid!=0) 
				  			stmt.setInt(sCnt3++, sAcceptSid);			 /* ��ûSID     */     
					}
					
					// ������� üũ 
					if("DEPT_DATE".equals(gauceName)) {
						stmt = conn.getGauceStatement("SELECT SALES.FN_RSV_CLOSE_YN('" + sDeptDate + "',"+sClientSid+") DEPT_FLAG FROM SYSIBM.SYSDUMMY1");
					}

					// �������� üũ  - 20080516 updated by �ɵ���.
					if("RSV_CLOSE_DATE".equals(gauceName)) {
						//StringUtil.printMsg("dkrdkr","�ǾǾ�",this);
						//stmt = conn.getGauceStatement("SELECT N_RSV_CLOSE_DATE FROM SALES.TSY100 WHERE CALN_DATE='"+ sDeptDate +"'");
						stmt = conn.getGauceStatement("SELECT SALES.FN_RSV_CLOSE_YN_BIZ('" + sDeptDate + "',"+sClientSid+") AS DEPT_FLAG FROM SYSIBM.SYSDUMMY1");
					}

					if("DS_TEMP".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[9].toString());
						stmt.setString(1, v_depart_date);
						stmt.setInt(2, v_goods_sid);
					}
					
					rs = stmt.executeQuery();		// Query ����
					
					getDataSet(rs, ds1).flush();
				}
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
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
		CallableStatement cstmt;

		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		GauceDataSet ds2 = req.getGauceDataSet("DS2");
		GauceDataSet ds3 = req.getGauceDataSet("DS3");
		GauceDataSet ds4 = req.getGauceDataSet("DS4");
		
		// Parameter
		int 	iAcceptSid = 0; // ��ûSID
		String 	iAcceptNo = ""; // ��û ��ȣ 
		long 	iCarRsvSid = 0; // ���� SID
		long 	iRsvSid = 0;  	// ���� Sid

		
		int sSaupSid = HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid"));	//����ósid
		int sGoodsSid = HDUtil.nullCheckNum(req.getParameter("sGoodsSid"));	//��ǰsid
		

		String v_edit_status = "";
		
		try{
			res.enableFirstRow(ds4);
			
			ds4.addDataColumn(new GauceDataColumn("ACCEPT_SID", GauceDataColumn.TB_STRING,10));
			ds4.addDataColumn(new GauceDataColumn("ACCEPT_NO", GauceDataColumn.TB_STRING,15));
			ds4.addDataColumn(new GauceDataColumn("CAR_RSV_SID", GauceDataColumn.TB_STRING,10));
			ds4.addDataColumn(new GauceDataColumn("RSV_SID", GauceDataColumn.TB_STRING,10));
			ds4.addDataColumn(new GauceDataColumn("FLAG", GauceDataColumn.TB_STRING,10));
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				
				int colNm_AcceptSid             = ds1.indexOfColumn("ACCEPT_SID");
				int colNm_AcceptNo              = ds1.indexOfColumn("ACCEPT_NO");
				int colNm_AcceptDate            = ds1.indexOfColumn("ACCEPT_DATE");
				
				for(int i = 0; i < rows.length; i++) {
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:	//�μ�Ʈ
							cstmt = conn.prepareCall(arr_sql[4].toString());

							GauceDataRow gRow = ds4.newDataRow();

							cstmt.setInt(1, rows[i].getInt(colNm_AcceptSid));
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);

							cstmt.setString(2, rows[i].getString(colNm_AcceptNo));
							cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);

							cstmt.setInt(3, sSaupSid);

							cstmt.setInt(4, sClientSid);
							cstmt.setString(5, rows[i].getString(colNm_AcceptDate));
							cstmt.setInt(6, rows[i].getInt(ds1.indexOfColumn("GOODS_SID")));
							cstmt.setString(7, rows[i].getString(ds1.indexOfColumn("DEPART_DATE")));

							cstmt.setString(8, fParamEmpno);
							cstmt.setString(9, fParamIp);
							cstmt.setString(10, "1"); // INSERT

							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							
							// ��������
							cstmt.executeUpdate();
							
							// �����ڵ� �� �ִ°�� 
							if("N".equals(cstmt.getString(11)))
								throw new Exception (cstmt.getString(13));
							
							// �����ڵ尡 ���°��
							iAcceptSid = cstmt.getBigDecimal(1).intValue(); // ���ν����� ���Ͽ� ���� ��û�� SID
							iAcceptNo = cstmt.getString(2); // ��û�� ��ȣ 
							
							gRow.addColumnValue(iAcceptSid);
							gRow.addColumnValue(iAcceptNo);
							gRow.addColumnValue("0");
							gRow.addColumnValue("0");
							gRow.addColumnValue("DS1");
							
							ds4.addDataRow(gRow);
							if(cstmt!=null) 
								cstmt.close();
							
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[7].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_AcceptSid));
							cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							
							break;
					} 
				}
			} 
			
			if (ds2 != null) {
				GauceDataRow[] 	rows = ds2.getDataRows();
				
				int colNm_CarRsv_sid        = ds2.indexOfColumn("CAR_RSV_SID");  	/*1 ��������SID 		*/
				int colNm_AcceptSid          = ds2.indexOfColumn("ACCEPT_SID");  	/*2 ��ûSID     		*/
				int colNm_CarSid                = ds2.indexOfColumn("CAR_SID");  		/*3 ���� SID    		*/
				int colNm_DepartDate         = ds2.indexOfColumn("DEPART_DATE");  	/*5 �������    		*/
				int colNm_DepartTime         = ds2.indexOfColumn("DEPART_TIME");  	/* ���ð�    		*/
				int colNm_ArriveDate           = ds2.indexOfColumn("ARRIVE_DATE"); 	/* �԰�����    		*/
				int colNm_ArriveTime           = ds2.indexOfColumn("ARRIVE_TIME"); 	/* �԰�ð�    		*/
				int colNm_Cargo                 = ds2.indexOfColumn("CARGO");  			/* ȭ��        		*/
				int colNm_DriveSid              = ds2.indexOfColumn("DRIVE_SID");  		/* 4 ��������SID 		*/
				
				for(int i = 0; i < rows.length; i++) {

					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							GauceDataRow gRow = ds4.newDataRow();
							
							cstmt.setInt(1, rows[i].getInt(colNm_CarRsv_sid));	// �������� SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);	
							
							cstmt.setInt(2, sSaupSid);							// ����� SID
							if (iAcceptSid > 0) {
								cstmt.setLong(3, iAcceptSid);											// ��û SID
							} else {
								cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));											// ��û SID
								
								iAcceptSid = rows[i].getInt(colNm_AcceptSid);
							}
							
							cstmt.setInt(4, rows[i].getInt(colNm_CarSid));		// ���� SID
							cstmt.setInt(5, rows[i].getInt(colNm_DriveSid));	// �������� SID
							cstmt.setString(6, rows[i].getString(colNm_DepartDate));				// ������� 
							cstmt.setString(7, rows[i].getString(colNm_DepartTime));				// ���ð�
							cstmt.setString(8, rows[i].getString(colNm_ArriveDate));				// �԰����� 
							cstmt.setString(9, rows[i].getString(colNm_ArriveTime));				// �԰�ð�
							cstmt.setString(10, rows[i].getString(colNm_Cargo));						// ȭ��
							cstmt.setInt(11,sClientSid);											// ����óSID

							cstmt.setString(12, rows[i].getString(ds2.indexOfColumn("LONG_STAY_YN")));						// ȭ��
							cstmt.setString(13, rows[i].getString(ds2.indexOfColumn("CAR_DESC")));						// ȭ��

							cstmt.setString(14, fParamEmpno);
							cstmt.setString(15, fParamIp);
							cstmt.setString(16, "1"); 												// INSERT
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							
							// ��������
							cstmt.executeUpdate();
							

							// �����ڵ� �� �ִ°�� 
							if("N".equals(cstmt.getString(17))) 
								throw new Exception (cstmt.getString(19));
							
							iCarRsvSid = cstmt.getBigDecimal(1).intValue(); // ���� ���� SID
							
							gRow.addColumnValue(iAcceptSid);
							gRow.addColumnValue("0");
							gRow.addColumnValue(iCarRsvSid);
							gRow.addColumnValue("0");
							gRow.addColumnValue("DS2");
							
							ds4.addDataRow(gRow);
							if(cstmt!=null) 
								cstmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_CarRsv_sid));	// �������� SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);			
							cstmt.setInt(2, sSaupSid);							// ����� SID
							cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));	// ��û SID
							cstmt.setInt(4, rows[i].getInt(colNm_CarSid));		// ���� SID
							cstmt.setInt(5, rows[i].getInt(colNm_DriveSid));	// �������� SID
							cstmt.setString(6, rows[i].getString(colNm_DepartDate));				// ������� 
							cstmt.setString(7, rows[i].getString(colNm_DepartTime));				// ���ð�
							cstmt.setString(8, rows[i].getString(colNm_ArriveDate));				// �԰����� 
							cstmt.setString(9, rows[i].getString(colNm_ArriveTime));				// �԰�ð�
							cstmt.setString(10, rows[i].getString(colNm_Cargo));						// ȭ��
							cstmt.setInt(11, sClientSid);											// ����óSID
							cstmt.setString(12, rows[i].getString(ds2.indexOfColumn("LONG_STAY_YN")));						// ȭ��
							cstmt.setString(13, rows[i].getString(ds2.indexOfColumn("CAR_DESC")));						// ȭ��

							cstmt.setString(14, fParamEmpno);
							cstmt.setString(15, fParamIp);
							cstmt.setString(16, "3"); 												// INSERT
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							
							// ��������
							cstmt.executeUpdate();
							

							// �����ڵ� �� �ִ°�� 
							if("N".equals(cstmt.getString(17))) 
								throw new Exception (cstmt.getString(19));
							
							if(cstmt!=null) 
								cstmt.close();
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("DS2 Insert",arr_sql[5].toString(), this);
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_CarRsv_sid));	// �������� SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);	
							cstmt.setInt(2, sSaupSid);							// ����� SID
							
							cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));	// ��û SID
							cstmt.setInt(4, rows[i].getInt(colNm_CarSid));		// ���� SID
							cstmt.setInt(5, rows[i].getInt(colNm_DriveSid));	// �������� SID
							cstmt.setString(6, rows[i].getString(colNm_DepartDate));				// ������� 
							cstmt.setString(7, rows[i].getString(colNm_DepartTime));				// ���ð�
							cstmt.setString(8, rows[i].getString(colNm_ArriveDate));				// �԰����� 
							cstmt.setString(9, rows[i].getString(colNm_ArriveTime));				// �԰�ð�
							cstmt.setString(10, rows[i].getString(colNm_Cargo));						// ȭ��
							cstmt.setInt(11, sClientSid);											// ����óSID
							cstmt.setString(12, rows[i].getString(ds2.indexOfColumn("LONG_STAY_YN")));						// ȭ��
							cstmt.setString(13, rows[i].getString(ds2.indexOfColumn("CAR_DESC")));						// ȭ��

							cstmt.setString(14, fParamEmpno);
							cstmt.setString(15, fParamIp);
							cstmt.setString(16, "2"); 												// INSERT
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							
							// ��������
							cstmt.executeUpdate();
							

							// �����ڵ� �� �ִ°�� 
							if("N".equals(cstmt.getString(17))) 
								throw new Exception (cstmt.getString(19));
							 
							if(cstmt!=null) 
								cstmt.close();
							
							break;
					} 
				} 
			} 
			
			if (ds3 != null) {
				GauceDataRow[] 	rows = ds3.getDataRows();
			
				int colNm_AcceptSid             = ds3.indexOfColumn("ACCEPT_SID");			/* ��û SID			*/
				int colNm_RsvSid                = ds3.indexOfColumn("RSV_SID");			/* ���� SID			*/
				int colNm_CustSid               = ds3.indexOfColumn("CUST_SID");	 	/* ��SID          	*/
				int colNm_DepartDate            = ds3.indexOfColumn("DEPART_DATE");		/* �������           	*/
				int colNm_DepartTime            = ds3.indexOfColumn("DEPART_TIME");		/* ���ð�           	*/
				int colNm_ArriveDate            = ds3.indexOfColumn("ARRIVE_DATE"); 	/* �԰�����           	*/
				int colNm_ArriveTime            = ds3.indexOfColumn("ARRIVE_TIME");		/* �԰�ð�           	*/
				int colNm_LongStayYn            = ds3.indexOfColumn("LONG_STAY_YN");	// ��⿩��
				int colNm_CustType              = ds3.indexOfColumn("CUST_TYPE");		// ��������
				int colNm_NcardNo          		= ds3.indexOfColumn("N_CARD_NO");	// ����� ��ȣ
				int colNm_NorthPurpose          = ds3.indexOfColumn("NORTH_PURPOSE");	/* ��ϸ���           	*/
				int colNm_DriveYn               = ds3.indexOfColumn("DRIVE_YN");		/* ��������:SY010    */       
				int colNm_NcardGu          		= ds3.indexOfColumn("N_CARD_GU");	// ����� ����
				int colNm_RoomTypeSid      		= ds3.indexOfColumn("A_ROOM_TYPE_SID");	// ������� �ڵ�
				int colNm_Remarks          		= ds3.indexOfColumn("REMARKS");	// �������
				
				
				for(int i = 0; i < rows.length; i++) {
					//StringUtil.printMsg("���콺��Ÿ��", rows[i].getJobType(), this);
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//StringUtil.printMsg("���콺��Ÿ��", "�Է�? Ȯ���սô�.", this);
							cstmt = conn.prepareCall(arr_sql[6].toString());
							
							GauceDataRow gRow = ds4.newDataRow();
							
							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));		// ����SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
							cstmt.setInt(2, sSaupSid);							// ����� SID
							
							if (iAcceptSid > 0) {
								cstmt.setLong(3, iAcceptSid);											// ��û SID
							} else {
								cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));											// ��û SID
								
								iAcceptSid = rows[i].getInt(colNm_AcceptSid);
							}
							
							// ��ûSID
							cstmt.setInt(4, rows[i].getInt(colNm_CustSid));	// �� SID
							//StringUtil.printMsg("4",rows[i].getInt(colNm_CustSid) , this);
							cstmt.setString(5, rows[i].getString(colNm_DepartDate));				// �������
							//StringUtil.printMsg("5", rows[i].getString(colNm_DepartDate), this);
							cstmt.setString(6, rows[i].getString(colNm_DepartTime));				// ���ð�
							//StringUtil.printMsg("6", rows[i].getString(colNm_DepartTime), this);
							cstmt.setString(7, rows[i].getString(colNm_ArriveDate));				// �԰�����
							//StringUtil.printMsg("7", rows[i].getString(colNm_ArriveDate), this);
							cstmt.setString(8, rows[i].getString(colNm_ArriveTime));				// �԰�ð�
							//StringUtil.printMsg("8", rows[i].getString(colNm_ArriveTime), this);
							cstmt.setString(9, rows[i].getString(colNm_DriveYn));					// ��������
							//StringUtil.printMsg("9", rows[i].getString(colNm_DriveYn), this);
							cstmt.setString(10, rows[i].getString(colNm_NorthPurpose));				// ��ϸ���
							//StringUtil.printMsg("10", rows[i].getString(colNm_NorthPurpose), this);							
							cstmt.setString(11, rows[i].getString(colNm_CustType));				// ��������
							//StringUtil.printMsg("11", rows[i].getString(colNm_CustType), this);
							cstmt.setString(12, rows[i].getString(colNm_LongStayYn));			// ��⿩��
							//StringUtil.printMsg("12", rows[i].getString(colNm_LongStayYn), this);
							cstmt.setInt(13, sClientSid);		//  -- 13.����óSID  	20071005 �߰� by �ɵ���
							//StringUtil.printMsg("13", sClientSid, this);
							cstmt.setInt(14, sGoodsSid);		//  14.��ǰSID		20071005 �߰� by �ɵ���
							//StringUtil.printMsg("14", sGoodsSid, this);
							cstmt.setString(15, rows[i].getString(colNm_NcardNo));			// 15.�������ȣ		20071005 �߰� by �ɵ���
							//StringUtil.printMsg("15", rows[i].getString(colNm_NcardNo), this);
							//StringUtil.printMsg("16", colNm_RoomTypeSid, this);
							cstmt.setInt(16, rows[i].getInt(colNm_RoomTypeSid));		//  16.�������SID	20071005 �߰� by �ɵ���
							
							//StringUtil.printMsg("16", rows[i].getInt(colNm_RoomTypeSid), this);
							cstmt.setString(17, rows[i].getString(colNm_Remarks));			// 17.���ǰ����������20071005 �߰� by �ɵ���
							//StringUtil.printMsg("17", rows[i].getString(colNm_Remarks), this);
							cstmt.setString(18, rows[i].getString(colNm_NcardGu));			// 18.����� ���� 20071009 �߰� by �ɵ���
							//StringUtil.printMsg("18", rows[i].getString(colNm_NcardGu), this);
							cstmt.setString(19, fParamEmpno);
							//StringUtil.printMsg("19",fParamEmpno , this);
							cstmt.setString(20, fParamIp);
							//StringUtil.printMsg("20",fParamIp , this);
							cstmt.setString(21, "1");	// INSERT
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
							
							// ��������
							cstmt.executeUpdate();
							
							//		 �����ڵ� �� �ִ°�� 
							if("N".equals(cstmt.getString(22)))
								throw new Exception (cstmt.getString(24));
							
							iRsvSid = cstmt.getBigDecimal(1).intValue(); //���� SID
						
							gRow.addColumnValue(iAcceptSid);
							gRow.addColumnValue("0");
							gRow.addColumnValue("0");
							gRow.addColumnValue(iRsvSid);
							gRow.addColumnValue("DS3");
							
							ds4.addDataRow(gRow);
							
							if(cstmt!=null) 
								cstmt.close();
						
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("���콺��Ÿ��", "Update ��", this);
							cstmt = conn.prepareCall(arr_sql[6].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));		// ����SID
							//StringUtil.printMsg("1", rows[i].getInt(colNm_RsvSid), this);
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
							cstmt.setInt(2, sSaupSid);							// ����� SID
							//StringUtil.printMsg("2", sSaupSid, this);
							cstmt.setLong(3, 0);											// ��ûSID
							cstmt.setInt(4, rows[i].getInt(colNm_CustSid));	// �� SID			
							cstmt.setString(5, rows[i].getString(colNm_DepartDate));				// ������� 
							cstmt.setString(6, rows[i].getString(colNm_DepartTime));				// ���ð�
							cstmt.setString(7, rows[i].getString(colNm_ArriveDate));				// �԰����� 
							cstmt.setString(8, rows[i].getString(colNm_ArriveTime));				// �԰�ð�
							//StringUtil.printMsg("8", rows[i].getString(colNm_ArriveTime), this);
							cstmt.setString(9, rows[i].getString(colNm_DriveYn));					// ��������
							cstmt.setString(10, rows[i].getString(colNm_NorthPurpose));				// ��ϸ���
							//StringUtil.printMsg("10", rows[i].getString(colNm_NorthPurpose), this);
							cstmt.setString(11, rows[i].getString(colNm_CustType));				// ��������
							//StringUtil.printMsg("11", rows[i].getString(colNm_CustType), this);
							cstmt.setString(12, rows[i].getString(colNm_LongStayYn));			// ��⿩��
							//StringUtil.printMsg("12", rows[i].getString(colNm_LongStayYn), this);
							cstmt.setInt(13, sClientSid);		//  -- 13.����óSID  	20071005 �߰� by �ɵ���
							//StringUtil.printMsg("13", sClientSid, this);
							cstmt.setInt(14, sGoodsSid);		//  14.��ǰSID		20071005 �߰� by �ɵ���
							//StringUtil.printMsg("14", sGoodsSid, this);
							cstmt.setString(15, rows[i].getString(colNm_NcardNo));			// 15.�������ȣ		20071005 �߰� by �ɵ���
							//StringUtil.printMsg("15", rows[i].getString(colNm_NcardNo), this);
							//StringUtil.printMsg("16", colNm_RoomTypeSid, this);
							cstmt.setInt(16, rows[i].getInt(colNm_RoomTypeSid));		//  16.�������SID	20071005 �߰� by �ɵ���
								
							//StringUtil.printMsg("16", rows[i].getInt(colNm_RoomTypeSid), this);
							cstmt.setString(17, rows[i].getString(colNm_Remarks));			// 17.���ǰ����������20071005 �߰� by �ɵ���
							//StringUtil.printMsg("17", rows[i].getString(colNm_Remarks), this);
							cstmt.setString(18, rows[i].getString(colNm_NcardGu));			// 18.����� ���� 20071009 �߰� by �ɵ���
							//StringUtil.printMsg("18", rows[i].getString(colNm_NcardGu), this);
							cstmt.setString(19, fParamEmpno);
							//StringUtil.printMsg("19",fParamEmpno , this);
							cstmt.setString(20, fParamIp);
							//StringUtil.printMsg("20",fParamIp , this);
							cstmt.setString(21, "3");	// UPDATE
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
							// ��������
							cstmt.executeUpdate();
							
							//StringUtil.printMsg("22", cstmt.getString(22), this);
							//StringUtil.printMsg("23", cstmt.getString(23), this);
							//StringUtil.printMsg("24", cstmt.getString(24), this);

							//		 �����ڵ� �� �ִ°�� 
							if("N".equals(cstmt.getString(22)))
								throw new Exception (cstmt.getString(24));
							
							if(cstmt!=null) 
								cstmt.close();
							
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("���콺��Ÿ��", "����?", this);
							//StringUtil.printMsg("ds3 Delete",arr_sql[6].toString(), this);
							cstmt = conn.prepareCall(arr_sql[6].toString());

							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));		// ����SID
							//StringUtil.printMsg("1", rows[i].getInt(colNm_RsvSid), this);
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
							cstmt.setInt(2, sSaupSid);							// ����� SID
							//StringUtil.printMsg("2", sSaupSid, this);
							cstmt.setLong(3, 0);											// ��ûSID
							cstmt.setInt(4, rows[i].getInt(colNm_CustSid));	// �� SID			
							cstmt.setString(5, rows[i].getString(colNm_DepartDate));				// ������� 
							cstmt.setString(6, rows[i].getString(colNm_DepartTime));				// ���ð�
							cstmt.setString(7, rows[i].getString(colNm_ArriveDate));				// �԰����� 
							cstmt.setString(8, rows[i].getString(colNm_ArriveTime));				// �԰�ð�
							//StringUtil.printMsg("8", rows[i].getString(colNm_ArriveTime), this);
							cstmt.setString(9, rows[i].getString(colNm_DriveYn));					// ��������
							cstmt.setString(10, rows[i].getString(colNm_NorthPurpose));				// ��ϸ���
							//StringUtil.printMsg("10", rows[i].getString(colNm_NorthPurpose), this);
							cstmt.setString(11, rows[i].getString(colNm_CustType));				// ��������
							//StringUtil.printMsg("11", rows[i].getString(colNm_CustType), this);
							cstmt.setString(12, rows[i].getString(colNm_LongStayYn));			// ��⿩��
							//StringUtil.printMsg("12", rows[i].getString(colNm_LongStayYn), this);
							cstmt.setInt(13, sClientSid);		//  -- 13.����óSID  	20071005 �߰� by �ɵ���
							//StringUtil.printMsg("13", sClientSid, this);
							cstmt.setInt(14, sGoodsSid);		//  14.��ǰSID		20071005 �߰� by �ɵ���
							//StringUtil.printMsg("14", sGoodsSid, this);
							cstmt.setString(15, rows[i].getString(colNm_NcardNo));			// 15.�������ȣ		20071005 �߰� by �ɵ���
							//StringUtil.printMsg("15", rows[i].getString(colNm_NcardNo), this);
							//StringUtil.printMsg("16", colNm_RoomTypeSid, this);
							cstmt.setInt(16, rows[i].getInt(colNm_RoomTypeSid));		//  16.�������SID	20071005 �߰� by �ɵ���
									
							//StringUtil.printMsg("16", rows[i].getInt(colNm_RoomTypeSid), this);
							cstmt.setString(17, rows[i].getString(colNm_Remarks));			// 17.���ǰ����������20071005 �߰� by �ɵ���
							//StringUtil.printMsg("17", rows[i].getString(colNm_Remarks), this);
							cstmt.setString(18, rows[i].getString(colNm_NcardGu));			// 18.����� ���� 20071009 �߰� by �ɵ���
							//StringUtil.printMsg("18", rows[i].getString(colNm_NcardGu), this);
							cstmt.setString(19, fParamEmpno);
							//StringUtil.printMsg("19",fParamEmpno , this);
							cstmt.setString(20, fParamIp);
							//StringUtil.printMsg("20",fParamIp , this);
							cstmt.setString(21, "2");	// DELETE
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
							// ��������
							cstmt.executeUpdate();
								
							//StringUtil.printMsg("22", cstmt.getString(22), this);
							//StringUtil.printMsg("23", cstmt.getString(23), this);
							//StringUtil.printMsg("24", cstmt.getString(24), this);
							
							// ��������
							cstmt.executeUpdate();
							
							
							//StringUtil.printMsg("1", cstmt.getString(22), this);
							
							//		 �����ڵ� �� �ִ°�� 
							if("N".equals(cstmt.getString(22)))
								throw new Exception (cstmt.getString(24));
							
							if(cstmt!=null) cstmt.close();

							break;
					} 
				} 
			} 
			
			if (ds4 != null) 
				ds4.flush();
			
		} catch (SQLException sqle){
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}

	}

}
