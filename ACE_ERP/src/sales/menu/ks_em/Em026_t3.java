//**��������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em026_t3 extends HttpServlet{

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

				String strPaycd="";
				String strMemo="";

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

            /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              	1. �ް� �̽ǽ� ����� Ȯ��
								2. �ټӼ��� ���
								3. �װ����� ���
								4. 20�Ϻ� ���

							 ����
							 �ټӼ��� ���,�װ���, �⺻��20�Ϻ�                                                                          
						   �ް��̽ǽ� ����� �����                                                                                       
						   �ް��̽ǽú������޳���� �����ϰ�                                                                              
           	   �ް��̽ǽú������޳���� å�� �Ǵ� ����� ����� �ȿ� �ް��� �� ���� ��� ������.
						  +++++++++++++++++++++++++++++++++++++++++++++++*/
            
						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
              �޿�����۾� ���� : �⺻��, �ð��� ���
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
						for(int k=1;k<=3;k++) { 
               if (k==1){
								 strPaycd ="004"; 
								 strMemo="�ټӼ��� �����";  //�⺻��
							 }else if(k==2){
								 strPaycd ="005";  
								 strMemo="�պ��װ� �����"; //OT
							 }else if(k==3){
								 strPaycd ="006";  
								 strMemo="�⺻��20�� �����"; //OT
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
													.append("   REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), \n" )
													.append("   REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  \n" )
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
        
            StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;

						sql.append( " SELECT A.EMPNO,  200 SEN_PAY,  450 AIR_PAY,   \n" )
							 .append( "        A.B_PAY0, DECIMAL(ROUND(DECIMAL(A.B_PAY0*20/30,10,3),2),10,2) B20_PAY \n" )
							 .append( "   FROM SALES.TCM345 A                                               \n" )
							 .append( "  WHERE A.REWARD_YM = '"+rows[j].getString(idx[0])+"'                \n" )
							 .append( "    AND NOT EXISTS ( SELECT B.EMPNO         --�ް� �� �� ���(�޿� ������ ���� 1�� ���� �Ⱓ�� �ް��� �Ȱ����)  \n" )
							 .append( "                       FROM SALES.TCM355 B                                         \n" )
							 .append( "                      WHERE A.EMPNO = B.EMPNO                                      \n" )
							 .append( "                        AND B.REWARD_YM = '"+rows[j].getString(idx[0])+"'          \n" )
							 .append( "                     )                                                             \n" );
 
            logger.dbg.println(this,"J:::"+j+"::"+sql.toString());
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
								StringBuffer UpdateSql = new StringBuffer();
								UpdateSql.append("  UPDATE SALES.TCM400 SET            \n" )
												 .append("         SEN_PAY = "+rs.getInt(2)+", \n" )
												 .append("         AIR_PAY = "+rs.getInt(3)+", \n" )
									       .append("         B_PAY0 = "+rs.getInt(4)+",   \n" )  //2���� �⺻��
									       .append("         B20_PAY = "+rs.getFloat(5)+"   \n" )  //2���� �⺻���� 20%
											 	 .append( "	 WHERE PAY_YM=?		\n")
												 .append( "    AND PAY_DIV=?	\n")
								         .append( "    AND EMPNO="+rs.getString(1)+"  	\n");
								GauceStatement gsmt_1 = conn.getGauceStatement(UpdateSql.toString()); //�α׳���°�
								gsmt_1.setGauceDataRow(rows[j]);

								gsmt_1.bindColumn(1, idx[0]);
								gsmt_1.bindColumn(2, idx[1]);

								gsmt_1.executeUpdate();
								gsmt_1.close();							
						}
						rs.close();
						stmt.close();


            /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              �޿�����۾� ���� : �⺻�� �� �ð��� 
						 +++++++++++++++++++++++++++++++++++++++++++++++*/
						for(int m=1;m<=3;m++) { 
							 strPaycd="";
							 if (m==1){ 
								 strPaycd ="004"; 
								 strMemo="�ټӼ��� ���Ϸ�";  //
							 }else if(m==2){
								 strPaycd ="005";  
								 strMemo="�պ��װ� ���Ϸ�"; //
							 }else if(m==3){
								 strPaycd ="006";  
								 strMemo="�⺻��20 ���Ϸ�"; //
							 }

							StringBuffer UpdateSql = new StringBuffer();			
							UpdateSql.append( " UPDATE SALES.TCM499		\n")
												.append( " SET                  \n")
												.append( " TODT=REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), \n")
												.append( " TOTM=REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  WRKSTS='2',   \n")
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

            /*
	
						StringBuffer UpdateSql = new StringBuffer();			

					  UpdateSql.append( " UPDATE SALES.TCM345			\n")
											.append( " SET                      \n")
											.append( " JOB_CD=?,  VEND_CD=?,  DEPT_CD=?,   TEAM_CD=?, WORK_CD=?,   \n")
											.append( " CONT_GB=?, START_DT=?, END_DT=?,    C_EMPNO=?, C_POSI_CD=?, \n")
											.append( " C_OPI=?,   T_EMPNO=?,  T_POSI_CD=?, T_OPI=?,   REMARK=?,    \n")
							       	.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP, \n")
							        .append( " REWARD_YM=? \n")
											.append( " WHERE EMPNO=?						\n")
											.append( " AND SEQ=?                \n");

						rows[j].setString(idx[20],strEmpno);

  					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idx[3]);	
						gsmt.bindColumn(2,  idx[4]);	
						gsmt.bindColumn(3,  idx[5]);	
						gsmt.bindColumn(4,  idx[6]);	
						gsmt.bindColumn(5,  idx[7]);	
						gsmt.bindColumn(6,  idx[8]);	
						gsmt.bindColumn(7,  idx[9]);	
						gsmt.bindColumn(8,  idx[10]);	
						gsmt.bindColumn(9,  idx[11]);	
						gsmt.bindColumn(10,  idx[12]);	
						gsmt.bindColumn(11,  idx[13]);	
						gsmt.bindColumn(12,  idx[14]);	
						gsmt.bindColumn(13,  idx[15]);	
						gsmt.bindColumn(14,  idx[16]);	
						gsmt.bindColumn(15,  idx[17]);	
						gsmt.bindColumn(16,  idx[20]);
						gsmt.bindColumn(17,  idx[22]);
						gsmt.bindColumn(18,  idx[0]);	
						gsmt.bindColumn(19,  idx[1]);	
						gsmt.executeUpdate();					
						gsmt.close();									
						*/
					}
					
					/******************************** **********************************************
					 * DELETE ó��
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            /*

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM SALES.TCM345		\n")
										 .append( "	 WHERE EMPNO=?							\n")
				  					 .append( "    AND SEQ=?							  \n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);

						gsmt.executeUpdate();
						gsmt.close();

						*/

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