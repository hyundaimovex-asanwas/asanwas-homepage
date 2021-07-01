//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em026_t8 extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
			try {
				conn = service.getDBConnection();
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				conn.setAutoCommit(false);

				//�Ķ��Ÿ �޾ƿ��°� ����
				/*******************************************************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				logger.dbg.println(this,"����ó��");

				String strPaycd="";
				String strMemo="";
				String strYYmmdd="";
				String strYYmmdd2="";
			  String strYYmm="";    //�޿����޳�� 1���� ��
				String strYYmm2="";   //�޿����޳�� 2���� ��

				//�Ķ��Ÿ �޾ƿ��°� ����
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ "PAY_YM","PAY_DIV","I_EMPNO"                         
																			  };

				int[] idx = new int[3]; //�÷������� �־��ش�.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            
						/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              �޿�����۾� ���� : ����ó�� -- ��ȭ��, ����, ��ȭ�� ����, ��ȭ�� ��������
					  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
						for(int k=1;k<=4;k++) { 
               if (k==1){
								 strPaycd ="020"; 
								 strMemo="��ȭ�� �����";  //
							 }else if (k==2){
								 strPaycd ="021"; 
								 strMemo="����ó�� �����";  //
							 }else if (k==3){
								 strPaycd ="022"; 
								 strMemo="��ȭ������ �����";  //
							}else if (k==4){
								 strPaycd ="023"; 
								 strMemo="��ȭ���������� �����";  //
							}

							 StringBuffer InsertSql_2 = new StringBuffer();
							 InsertSql_2.append("  INSERT INTO SALES.TCM499 (  \n" )
													.append("   APPDT,	PAYDIV,	 PAYDT,	  PBDIV,	PAYCD,  \n" )
													.append("    FRDT,	FRTM,	    TODT, 	 TOTM, 	WRKSTS,	\n" )
													.append("    MEMO,  I_EMPNO,I_DATE,	U_EMPNO,	U_DATE  \n" )
													.append("  ) VALUES ( \n" )
													.append("  '"+rows[j].getString(idx[0])+"', \n" )
													.append("  '"+rows[j].getString(idx[1])+"', \n" )
													.append("  '','1', \n" )
													.append("  '"+strPaycd+"',\n" )
													.append("   REPLACE(CAST(CURRENT DATE AS VARCHAR(10)),'-',''), \n" )
													.append("   REPLACE(CAST(CURRENT TIME AS VARCHAR(8)),'.',''),  \n" )
													.append("   '','',\n" )
													.append("   '1', \n" ) //������
													.append("   '"+strMemo+"', \n" )
													.append("  '"+rows[j].getString(idx[2])+"', CURRENT TIMESTAMP,\n" )
													.append("  '"+rows[j].getString(idx[2])+"', CURRENT TIMESTAMP) \n" );

							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);

							gsmt_2.executeUpdate();
							gsmt_2.close();
						}


						//�޿����޳�� - 1 ����, - 2 ���� �� ===========================================================
						StringBuffer sql0 = new StringBuffer();
						Statement stmt0= null;
						ResultSet rs0 = null;

						strYYmmdd = rows[j].getString(idx[0]);
            strYYmmdd2 =  strYYmmdd.substring(0,4)+"-"+strYYmmdd.substring(4,6)+"-"+"01";

						sql0.append( " SELECT SUBSTR(REPLACE(CAST((CAST('"+strYYmmdd2+"' AS DATE) - 1 MONTH ) AS VARCHAR(10)),'-',''),1,6),  \n" )
						    .append( "        SUBSTR(REPLACE(CAST((CAST('"+strYYmmdd2+"' AS DATE) - 2 MONTH ) AS VARCHAR(10)),'-',''),1,6)   \n" )
							  .append( "   FROM SYSIBM.SYSDUMMY1    \n" );
							  
						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());
						while (rs0.next())	{
								strYYmm=rs0.getString(1);
								strYYmm2=rs0.getString(2);
						}
						rs0.close();
						stmt0.close();
						//================================================================================


            /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
              �޿�����۾� ���� : ��ȭ�� ���� ( �޿����޳�� 2������ ��ȭ�� ���ݾ� )
					  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
						StringBuffer UpdateSql_1 = new StringBuffer();
						UpdateSql_1.append("  UPDATE SALES.TCM400 A                                           \n")
										   .append("     SET A.TEL_PAY = (SELECT COALESCE(SUM(B.TEL_FEE),0)TEL_FEE    \n")
										   .append("	                      FROM SALES.TCM090 B                     	\n")
											 .append("                       WHERE B.UP_DATE LIKE '"+strYYmm2+"%'      	\n")
											 .append("                         AND B.TELHIS_SID = A.CUST_SID          	\n")
											 .append("                      )                                           \n")
											 .append("	 WHERE A.PAY_YM=?                                            	  \n")
											 .append("     AND A.PAY_DIV =?                                         	  \n");

						logger.dbg.println(this,UpdateSql_1.toString());
						GauceStatement gsmt_1 = conn.getGauceStatement(UpdateSql_1.toString()); //�α׳���°�
						gsmt_1.setGauceDataRow(rows[j]);

						gsmt_1.bindColumn(1, idx[0]);
						gsmt_1.bindColumn(2, idx[1]);

						gsmt_1.executeUpdate();
						gsmt_1.close();							

					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              �޿�����۾� ���� : 2.����
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
            StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;

						sql.append( "  SELECT EMPNO, PAY_AMT     \n" )
							 .append( "    FROM SALES.TCM440       \n" )
							 .append( "   WHERE PAY_YM ='"+rows[j].getString(idx[0])+"' \n" );								 
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
								StringBuffer UpdateSql_2 = new StringBuffer();
								UpdateSql_2.append("  UPDATE SALES.TCM400 SET  \n" )
												   .append("   ADV_PAY = "+rs.getFloat(2)+" \n" )
												   .append( "	 WHERE PAY_YM=?		\n")
												   .append( "    AND PAY_DIV=?	\n")
								           .append( "    AND EMPNO="+rs.getString(1)+"  	\n");
								GauceStatement gsmt_2 = conn.getGauceStatement(UpdateSql_2.toString()); //�α׳���°�
								gsmt_2.setGauceDataRow(rows[j]);

								gsmt_2.bindColumn(1, idx[0]);
								gsmt_2.bindColumn(2, idx[1]);

								gsmt_2.executeUpdate();
								gsmt_2.close();							
						}
						rs.close();
						stmt.close();
					 /*********************************************************************************************/
						
            /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              �޿�����۾� ���� : ��ȭ�� ����
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
						StringBuffer UpdateSql_3 = new StringBuffer();
						UpdateSql_3.append("  UPDATE SALES.TCM400 A                                               \n")
										   .append("     SET A.TELUBO_PAY = 100                                           \n")
										   .append("	 WHERE A.PAY_YM=?                                                 	\n")
											 .append("     AND A.PAY_DIV = ?                                              	\n")
											 .append("     AND EXISTS ( SELECT X.EMPNO                                    	\n")
											 .append("                    FROM ( SELECT EMPNO FROM SALES.TCM355 --�ް���    \n")
											 .append("	                          WHERE START_DT LIKE '"+strYYmm+"%'      	\n")
											 .append("                            UNION ALL                               	\n")
											 .append("                           SELECT EMPNO FROM SALES.TCM300 --�����    \n")
											 .append("	                          WHERE END_DT LIKE '"+strYYmm+"%'         	\n")
											 .append("                          ) X                                       	\n")
											 .append("                   WHERE A.EMPNO = X.EMPNO                            \n")
						           .append("                 ) \n");

						logger.dbg.println(this,UpdateSql_3.toString());
						GauceStatement gsmt_3 = conn.getGauceStatement(UpdateSql_3.toString()); //�α׳���°�
						gsmt_3.setGauceDataRow(rows[j]);

						gsmt_3.bindColumn(1, idx[0]);
						gsmt_3.bindColumn(2, idx[1]);

						gsmt_3.executeUpdate();
						gsmt_3.close();							

						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
              �޿�����۾� ���� : ��ȭ�� ��������
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
						StringBuffer UpdateSql_4 = new StringBuffer();
						UpdateSql_4.append("  UPDATE SALES.TCM400 A                                      \n")
  										 .append("      SET A.TELSAVE_PAY =( SELECT (-B.TELUBO_PAY)            \n")
							         //.append("      SET A.TELSAVE_PAY =( SELECT (A.TEL_PAY-B.TELUBO_PAY)   \n") 
											 .append("	                           FROM SALES.TCM400 B           	 \n")
											 .append("                            WHERE B.PAY_YM= '"+strYYmm+"'    \n")
											 .append("                              AND B.TELUBO_PAY <> 0        	 \n")
											 .append("                              AND A.EMPNO = B.EMPNO)         \n")
											 .append("	                                                         	 \n")
											 .append("    WHERE A.PAY_YM =?                                     	 \n")
											 .append("      AND A.PAY_DIV = ?                                       \n")
											 .append("      AND EXISTS ( SELECT B.EMPNO FROM SALES.TCM400 B        \n")
											 .append("	                  WHERE B.PAY_YM='"+strYYmm+"'             \n")
											 .append("                      AND B.TELUBO_PAY <> 0                	 \n")
											 .append("                      AND A.EMPNO = B.EMPNO                  \n")
											 .append("                  )                                          \n");
																                                                        
						logger.dbg.println(this,UpdateSql_4.toString());
						GauceStatement gsmt_4 = conn.getGauceStatement(UpdateSql_4.toString()); //�α׳���°�
						gsmt_4.setGauceDataRow(rows[j]);

						gsmt_4.bindColumn(1, idx[0]);
						gsmt_4.bindColumn(2, idx[1]);

						gsmt_4.executeUpdate();
						gsmt_4.close();							

            /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
              �޿�����۾� ���� : ����ó��-- ��ȭ��, ����, ��ȭ�� ����, ��ȭ�� ��������
						 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
						for(int m=1;m<=4;m++) { 
							 strPaycd="";
							 if (m==1){
								 strPaycd ="020"; 
								 strMemo="��ȭ�� ���Ϸ�";  //����
							 }else if (m==2){
								 strPaycd ="021"; 
								 strMemo="����ó�� ���Ϸ�";  //����
							 }else if (m==3){
								 strPaycd ="022"; 
								 strMemo="��ȭ������ ���Ϸ�";  //����
							}else if (m==4){
								 strPaycd ="023"; 
								 strMemo="��ȭ���������� ���Ϸ�";  //����
							}

							StringBuffer UpdateSql = new StringBuffer();			
							UpdateSql.append( " UPDATE SALES.TCM499		\n")
												.append( " SET                  \n")
												.append( " TODT=REPLACE(CAST(CURRENT DATE AS VARCHAR(10)),'-',''), \n")
												.append( " TOTM=REPLACE(CAST(CURRENT TIME AS VARCHAR(8)),'.',''),  WRKSTS='2',   \n")
                        .append("  MEMO = '"+strMemo+"', \n" )
												.append( " U_DATE=CURRENT TIMESTAMP \n")
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'	\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' \n")
												.append( "   AND PAYCD='"+strPaycd+"'       \n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.executeUpdate();					
							gsmt.close();									
					  }
					}
						/******************************** **********************************************
						* Update ó��
						*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

           
					 }
					
					/******************************** **********************************************
					 * DELETE ó��
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            

			   	}
				}
			}
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}

			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e.getMessage());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
