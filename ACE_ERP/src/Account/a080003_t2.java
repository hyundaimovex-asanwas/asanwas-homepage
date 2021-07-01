package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080003_t2 extends HttpServlet{
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
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1  = reqGauce.getParameter("v_str1");		//��û����ȣ              
				String str2  = reqGauce.getParameter("v_str2");		//�ۼ�����
				String str3  = reqGauce.getParameter("v_str3");		//Save ����

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"FDCODE", "BGTRQNO",  "BGTYY",  "BGTDIV", "BGTDPT",  
					"DEPTCD", "EMPNO",    "WRDT",   "COSTCD", "BGTRQST", 
					"ATCODE", "FSREFCD",  "SATCODE","BGTGBCD","BGTTYPE", 
					"BGTMACT","BGTRQNOTE","WHYRQNOTE","BGTFRDEPT"																	
				};

				int[] idx = new int[19];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				String g_fdcode  = "";	//��������
				String g_bgtrqno = "";	//��û����ȣ
				String g_bgtyy   = "";	//����⵵
				String g_bgtdiv  = "";	//���꺻��
				String g_bgtdpt  = "";	//����μ�
				String g_bgtmact = "";	//����Ÿ��
				String g_atcode  = "";	//�����ڵ�
				String g_fsrefcd = "";	//�����׸��ڵ�
				String g_satcode = "";	//�����ڵ�
				String g_wrdt		 = "";	//�ۼ�����

				StringBuffer InsertSql  = null;	//����Master
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
		
				StringBuffer InsertSql2 = null;	//����Detail(2)
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2  = null;
				StringBuffer DeleteSql3  = null;
				StringBuffer DeleteSql4  = null;
				
				StringBuffer InsertSql3 = null;	//����Detail(3)

				//insert Master
				Statement stmt = null;
				ResultSet rs = null;

				//Update Master
				Statement stmt2 = null;
				ResultSet rs2 = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								���� ��û Master - ��û����ȣ Max ��ȸ
						********************************************************************/
						String Sbgtrqno1 = rows[j].getString(idx[1]);
						String Chk01     = "";
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT	    			 /*��û����ȣ*/				\n"); 
						sql.append( " CAST(MAX(SUBSTR(BGTRQNO,3,12)) AS INTEGER)+1 CNT		\n"); 
						sql.append( " FROM ACCOUNT.BGTRQMST									\n"); 
						sql.append( " WHERE FDCODE='"+rows[j].getString(idx[0])+"'			\n");
						sql.append( " AND SUBSTR(BGTRQNO,1,8)=SUBSTR('BR"+str1+"',1,8)		\n");

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while(rs.next())	{
							Sbgtrqno1 = rs.getInt(1) + "";
						}

						if (Sbgtrqno1.equals("0")) { 
							Sbgtrqno1 = "BR" + str1 + "0001";	Chk01 = "N";	//���ʻ���
						}else{	
							Sbgtrqno1 = "BR" + Sbgtrqno1 + "";	Chk01 = "N";		//�߰�����
						}

						/*******************************************************************
							���� ��û Master��  �߰� �Ѵ� InSert 
						********************************************************************/
						if (Chk01.equals("N"))	{	//New Create
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.BGTRQMST (					");  
							InsertSql.append( " FDCODE,  BGTRQNO, BGTYY,   BGTDIV,  BGTDPT, 	");  
							InsertSql.append( " DEPTCD,  EMPNO,   WRDT,    COSTCD,  BGTRQST,	");  
							InsertSql.append( " ATCODE,  FSREFCD, SATCODE, BGTGBCD, BGTTYPE,	");  
							InsertSql.append( " BGTMACT, BGTRQNOTE,WHYRQNOTE                 	"); 
 
							InsertSql.append( " ) VALUES(										");
  
							InsertSql.append( " ?,'"+Sbgtrqno1+"',?,?,?,		  				");  
							InsertSql.append( " ?, ?, ?, ?, ?,									");  
							InsertSql.append( " ?, ?, ?, ?, ?,									");
  
							InsertSql.append( " ?, ?, ?											");  
							InsertSql.append( " )												");

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idx[0]);
							for(int s=2;s<=17;s++) {
								gsmt.bindColumn(s, idx[s]);
							}

							gsmt.executeUpdate();
							gsmt.close();
							InsertSql = null;
						
							/*******************************************************************
								�����û �������� 
							********************************************************************/
							g_fdcode  = rows[j].getString(idx[0]);	//��������
							g_bgtrqno = Sbgtrqno1;					//��û����ȣ  
							g_bgtyy   = rows[j].getString(idx[2]);	//����⵵    
							g_bgtdiv  = rows[j].getString(idx[3]);	//���꺻��    
							g_bgtdpt  = rows[j].getString(idx[4]);	//����μ�    
							g_bgtmact = rows[j].getString(idx[15]);	//�����ڵ�    
							g_atcode  = rows[j].getString(idx[10]);	//�����ڵ�    
							g_fsrefcd = rows[j].getString(idx[11]);	//�����׸��ڵ�
							g_satcode = rows[j].getString(idx[12]);	//�����ڵ�
							g_wrdt    = rows[j].getString(idx[7]);	//�ۼ�����
							/********************************************************************/
						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						/*******************************************************************
								�����û Master Update
						********************************************************************/
						if (str3.equals("A")||str3.equals("C")){
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.BGTRQMST SET								\n");
						UpdateSql.append( " BGTYY = ?,   BGTDIV = ?,  BGTDPT = ?,   DEPTCD = ?,		\n");
						UpdateSql.append( " EMPNO = ?,   WRDT = ?,	  COSTCD = ?,   BGTRQST = ?,	\n");
						UpdateSql.append( " ATCODE = ?,	 FSREFCD = ?, SATCODE = ?,  BGTGBCD = ?,	\n");
						UpdateSql.append( " BGTTYPE = ?, BGTMACT = ?, BGTRQNOTE = ?,WHYRQNOTE=?		\n");
						UpdateSql.append( " WHERE FDCODE=? AND BGTRQNO=? 													\n");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int t=1;t<=16;t++) {
							gsmt.bindColumn(t, idx[t+1]);
						}

						gsmt.bindColumn(17, idx[0]);
						gsmt.bindColumn(18, idx[1]);
						gsmt.executeUpdate(); 
						gsmt.close();
						}

						/*******************************************************************
							�����û �������� 
						********************************************************************/
						g_fdcode  = rows[j].getString(idx[0]);	//��������  
						g_bgtrqno = rows[j].getString(idx[1]);	//��û����ȣ  
						g_bgtyy   = rows[j].getString(idx[2]);	//����⵵    
						g_bgtdiv  = rows[j].getString(idx[3]);	//���꺻��    
						g_bgtdpt  = rows[j].getString(idx[4]);	//����μ�    
						g_bgtmact = rows[j].getString(idx[15]);	//�����ڵ�    
						g_atcode  = rows[j].getString(idx[10]);	//�����ڵ�    
						g_fsrefcd = rows[j].getString(idx[11]);	//�����׸��ڵ�
						g_satcode = rows[j].getString(idx[12]);	//�����ڵ�
						g_wrdt    = rows[j].getString(idx[7]);	//�ۼ�����
						/********************************************************************/
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						/*******************************************************************
								�����û Master Delete
						********************************************************************/
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.BGTRQMST		");
						DeleteSql.append( " WHERE FDCODE = ? AND BGTRQNO = ?	");					
			
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.executeUpdate();
						gsmt.close();

						/*******************************************************************
								�����û Detail(1) Delete
						********************************************************************/
						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.BGTRQDTL1		");
						DeleteSql2.append( " WHERE FDCODE = ? AND BGTRQNO = ?   ");
			
						GauceStatement gsmt3 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt3.setGauceDataRow(rows[j]);
						gsmt3.bindColumn(1, idx[0]);
						gsmt3.bindColumn(2, idx[1]);
						gsmt3.executeUpdate(); 
						gsmt3.close();

						/*******************************************************************
							�����û �������� 
						********************************************************************/
						g_fdcode  = rows[j].getString(idx[0]);	//��������  
						g_bgtrqno = rows[j].getString(idx[1]);	//��û����ȣ  
						g_bgtyy   = rows[j].getString(idx[2]);	//����⵵    
						g_bgtdiv  = rows[j].getString(idx[3]);	//���꺻��    
						g_bgtdpt  = rows[j].getString(idx[4]);	//����μ�    
						g_bgtmact = rows[j].getString(idx[15]);	//�����ڵ�    
						g_atcode  = rows[j].getString(idx[10]);	//�����ڵ�    
						g_fsrefcd = rows[j].getString(idx[11]);	//�����׸��ڵ�
						g_satcode = rows[j].getString(idx[12]);	//�����ڵ�
						g_wrdt    = rows[j].getString(idx[7]);	//�ۼ�����
						/********************************************************************/
					}
				}

/***********************************************************************************************************************************
							G . A . U . C . E .   D . A . T . A . S . E . T .   S . E . C . O . N . D .
************************************************************************************************************************************/

		if (str3.equals("B")||str3.equals("C")){

			GauceDataSet userSet2  = reqGauce.getGauceDataSet("USER2");
			String[] StrArrCN2 = new String[] {
				"FDCODE","BGTRQNO","BGTRQSEQ","BGTRQDIV","BGTRQAMT",
				"BGTTOMON","BGTFRMON","DVTFRACT","DVTFRSATCD","WHYRQNOTE",
				"ATKORNAM","CDNAM","JANAMT","CHK","BGTFRDEPT"
			};
			
			int[] idx2 = new int[15];
			for(int i=0;i<StrArrCN2.length;i++) {
				idx2[i] = userSet2.indexOfColumn(StrArrCN2[i]);
			}

			GauceDataRow[] rows2 = userSet2.getDataRows();

			StringBuffer Insertsql2_2_2 = null;	//����Detail(1)
			StringBuffer Updatesql2_2_2 = null;	
			StringBuffer Updatesql3_2_2 = null;	
			StringBuffer Updatesql4_2_2 = null;	
			StringBuffer Insertsql3_2_2 = null;	
			StringBuffer InsertSql5_2_2	= null;	//����Detail(3)
			StringBuffer DeleteSql_2		= null;
			StringBuffer DeleteSql_3		= null;

			Statement stmt1_2 = null;
			ResultSet rs1_2 = null;

			Statement stmt2_2 = null;
			ResultSet rs2_2 = null;

			Statement stmt3 = null;
			ResultSet rs3 = null;

			Statement stmt4_2 = null;
			ResultSet rs4_2 = null;

			Statement stmt5_2 = null;
			ResultSet rs5_2 = null;

			Statement stmt4 = null;
			ResultSet rs4 = null;

			Statement stmt5 = null;
			ResultSet rs5 = null;

			Statement stmt4_3 = null;
			ResultSet rs4_3 = null;

			Statement stmt8_2 = null;
			ResultSet rs8_2 = null; 

			Statement stmt9_2 = null;
			ResultSet rs9_2 = null;

			Statement stmt6_2 = null;
			ResultSet rs6_2 = null;

			Statement stmt10_2 = null;
			ResultSet rs10_2 = null;

			Statement stmt11_2 = null;
			ResultSet rs11_2 = null;

			Statement stmt12_2 = null;
			ResultSet rs12_2 = null;

			for (int j = 0; j < rows2.length; j++){
				if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					/*******************************************************************
						���� ��û Detail(1) - ���� ��ȸ
					********************************************************************/
					StringBuffer sql2_2 = new StringBuffer();
					String Seq  = "";
					String Chk02 = "";

					sql2_2.append( " SELECT						 									\n"); 
					sql2_2.append( " CAST(MAX(BGTRQSEQ) AS INTEGER)+1 CNT	/*����*/	            \n"); 
					sql2_2.append( " FROM ACCOUNT.BGTRQDTL1											\n"); 
					sql2_2.append( " WHERE FDCODE='"+g_fdcode+"'									\n");
					sql2_2.append( " AND BGTRQNO='"+g_bgtrqno+"'									\n");


					stmt2_2 = conn.createStatement();
					rs2_2 = stmt2_2.executeQuery(sql2_2.toString());

					while(rs2_2.next())	{
						Seq = rs2_2.getInt(1) + "";
					}

					if (Seq.equals(null)) {
						Seq = "01";									Chk02 = "N";		//���ʻ���
					}else{	
						if(Seq.length()<2){
							if (Seq.equals("0")) {	
								Seq = "01";							Chk02 = "N";		//���ʻ���
							}else	{
								Seq = "0" + Seq;				    Chk02 = "N";		//�߰�����
							}
						}else{
								Seq = Seq + "";					    Chk02 = "N";		//�߰�����
						}
					}

					/*******************************************************************
						���� ��û Detail(1) �ű� InSert 
					********************************************************************/
						Insertsql2_2_2 = new StringBuffer();
						Insertsql2_2_2.append( " INSERT INTO ACCOUNT.BGTRQDTL1 (									\n");
						Insertsql2_2_2.append( " FDCODE,  BGTRQNO, BGTRQSEQ,BGTRQDIV,  BGTRQAMT, 	\n");
						Insertsql2_2_2.append( " BGTTOMON,BGTFRMON,DVTFRACT,DVTFRSATCD,WHYRQNOTE,	\n");
						Insertsql2_2_2.append( " BGTFRDEPT,BGTRQST																\n");
						Insertsql2_2_2.append( " ) VALUES(																				\n");
						Insertsql2_2_2.append( " '"+g_fdcode+"','"+g_bgtrqno+"','"+Seq+"',?,?, 		\n");
						Insertsql2_2_2.append( " ?, ?, ?, ?, ?, ?, 'N'														\n");
						Insertsql2_2_2.append( " )																								\n");

						GauceStatement gsmt = conn.getGauceStatement(Insertsql2_2_2.toString());
						gsmt.setGauceDataRow(rows2[j]);
						for(int s=1;s<=7;s++) {
							gsmt.bindColumn(s, idx2[s+2]);
						}

						gsmt.bindColumn(8, idx2[14]);

						gsmt.executeUpdate();
						gsmt.close();
						Insertsql2_2_2 = null;
				
				}

/************************************************************************************************************************************/

				if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
	
					/*******************************************************************
						���� ��û Detail(1) - ���� (��û�ݾ�) ��ȸ
					*******************************************************************/
					StringBuffer sql1_2 = new StringBuffer();
					String p_oper2 = "";	
					int p_rqamt = 0;	/*��û��*/
					int p_amtrq = 0;	/*�����ݾ�-����ݾ�*/
					
					sql1_2.append( " SELECT COALESCE(A.BGTRQAMT,0) BGTRQAMT							\n");	
					sql1_2.append( " FROM ACCOUNT.BGTRQDTL1 A														\n");
					sql1_2.append( " WHERE A.FDCODE ='"+g_fdcode+"'											\n");
					sql1_2.append( "   AND A.BGTRQNO='"+g_bgtrqno+"'										\n");
					sql1_2.append( "   AND A.BGTRQSEQ='"+rows2[j].getString(idx2[2])+"'	\n");
					
							
					stmt1_2 = conn.createStatement();
					rs1_2 = stmt1_2.executeQuery(sql1_2.toString());
					
					while(rs1_2.next())	{
						p_rqamt = rs1_2.getInt(1);
					}
					
					/*******************************************************************
						�����û Detail(1) Update
					********************************************************************/
					Updatesql2_2_2 = new StringBuffer();
					Updatesql2_2_2.append( " UPDATE ACCOUNT.BGTRQDTL1 SET										\n");
					Updatesql2_2_2.append( " BGTRQDIV = ?,  BGTRQAMT = ?,  BGTTOMON = ?,		\n");
					Updatesql2_2_2.append( " BGTFRMON = ?,  DVTFRACT = ?,  DVTFRSATCD = ?,	\n");
					Updatesql2_2_2.append( " WHYRQNOTE = ?, BGTFRDEPT = '"+rows2[j].getString(idx2[14])+"', BGTRQST = 'R'		\n");
					Updatesql2_2_2.append( " WHERE FDCODE=? AND BGTRQNO=?	 AND BGTRQSEQ=?		\n");

			
					GauceStatement gsmt = conn.getGauceStatement(Updatesql2_2_2.toString());
					gsmt.setGauceDataRow(rows2[j]);

					for(int t=1;t<=7;t++) {
						gsmt.bindColumn(t, idx2[t+2]);	
					}

					
					gsmt.bindColumn(8,  idx2[0]);
					gsmt.bindColumn(9,	idx2[1]);
					gsmt.bindColumn(10, idx2[2]);

					gsmt.executeUpdate(); 
					gsmt.close();
					Updatesql2_2_2 = null;				
									
				}    

/************************************************************************************************************************************/					

				if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					/*******************************************************************
						�����û Detail(1) Delete
					********************************************************************/
					DeleteSql_2 = new StringBuffer();
					DeleteSql_2.append( " DELETE FROM ACCOUNT.BGTRQDTL1						");
					DeleteSql_2.append( " WHERE FDCODE = ? AND BGTRQNO = ? AND BGTRQSEQ = ? ");

					GauceStatement gsmt = conn.getGauceStatement(DeleteSql_2.toString());
					gsmt.setGauceDataRow(rows2[j]);

					gsmt.bindColumn(1, idx2[0]);
					gsmt.bindColumn(2, idx2[1]);
					gsmt.bindColumn(3, idx2[2]);
					gsmt.executeUpdate();
					gsmt.close();
					DeleteSql_2 = null;
					
/************************************************************************************************************************************/					
				
				}
			}
		}
			}catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}