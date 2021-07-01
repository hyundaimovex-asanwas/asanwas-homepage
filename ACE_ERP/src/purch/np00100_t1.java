package purch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class np00100_t1 extends HttpServlet{

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


				//�Ķ��Ÿ �޾ƿ��°� ����
				String str1 = reqGauce.getParameter("v_str1");

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
					
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  
																"RQ_NO",		"RQ_NM",	"SITE_CD",		"RQ_DT",

																"RQ_STEP",		"RQ_BIGO"
                         					                               	
																			  };
																	  
				int[] idx = new int[6]; //�÷������� �־��ش�.
				
				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
		
				for (int j = 0; j < rows.length; j++){


/******************************************************************************
** INSERT ó��
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_INSERT) {

						//û����ȣ���� : 
						StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;
						String strSeq = "00000";
						String strRQ_NO = "";

						sql.append( "SELECT IFNULL(MAX(SUBSTR(RQ_NO,6,7)),0)+1 AS RQ_NO						\n" )		//PK RQ_NO
								.append( "FROM PURCH.REQUEST_HEAD														\n" )
								.append( "WHERE SUBSTR(RQ_NO,1,4) ='"+str1+"'											\n" );

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							strSeq = rs.getString(1);
						}
						rs.close();
						stmt.close();

						int ichk = Integer.parseInt(strSeq);

						if (ichk<10) strRQ_NO =  str1 + "0000" + ichk;									//1�ڸ��̸� 0�� 4�� ���̰�
						else if (ichk<100 && ichk>9) strRQ_NO =   str1 + "000" + ichk;				//2�ڸ��̸� 0�� 3�� ���̰�
						else if (ichk<1000 && ichk>99) strRQ_NO =   str1 + "00" + ichk;			//3�ڸ��̸� 0�� 2�� ���̰�
						else if (ichk<10000 && ichk>999) strRQ_NO =   str1 + "0" + ichk;			//4�ڸ��̸� 0�� 1�� ���̰�
						else if (ichk>9999) strRQ_NO =  str1 + ichk;										//5�ڸ��̸� 0�� �� ���̰�

						rows[j].setString(idx[0],strRQ_NO);

						StringBuffer InsertSql = new StringBuffer();			

						InsertSql.append( " INSERT INTO PURCH.REQUEST_HEAD(													\n")		
									 .append( "RQ_NO, RQ_NM, SITE_CD, RQ_DT,												\n")	
									 .append( "RQ_STEP, RQ_BIGO) 																	\n")	
									 .append( " VALUES																					\n")
									 .append( " (?,?,' ', ?,?,' ')																			\n");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());		
	
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[0]);
						gsmt.bindColumn(2,  idx[1]);
						gsmt.bindColumn(3,  idx[3]);
						gsmt.bindColumn(4,  idx[4]);   

					//	logger.dbg.println(this,InsertSql.toString());//�α׳���°�

						gsmt.executeUpdate();					
						gsmt.close();									

					}


/******************************************************************************
* Update ó��
*********************************************************************************/
 
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();			

								UpdateSql.append( " UPDATE PURCH.REQUEST_HEAD											\n")
												.append( " SET																			\n")
												.append( " RQ_NM = ?,																	\n")
								//				.append( " SITE_CD = ?,																\n")
												.append( " RQ_DT = ?,																	\n")
												.append( " RQ_STEP = ?																\n")
								//				.append( " RQ_BIGO = ?																	\n")	
												.append( " WHERE RQ_NO = ?															\n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						//logger.dbg.println(this,UpdateSql.toString());//�α׳���°�

						gsmt.setGauceDataRow(rows[j]);
											

						gsmt.bindColumn(1,  idx[1]);
			//			gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(2,  idx[3]);
						gsmt.bindColumn(3,  idx[4]);
			//			gsmt.bindColumn(5,  idx[5]);
						gsmt.bindColumn(4,  idx[0]);

						gsmt.executeUpdate();					
						gsmt.close();									

					}

				}

/**********************************************************************************************

**********************************************************************************************/


			}
			catch(Exception e){
				logger.err.println(this,e);
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}

