package Payroll;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
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

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.*;


public class p030010i_04_2 extends HttpServlet{

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

				int intEDUPAY=0;                //����
				//�迭�� [0]�� �ο��� ����
				int[] intEDUPAYN = new int[6];  //������
				int[] intEDUPAYP = new int[6];  //���߰�
				int[] intEDUPAYU = new int[6];  //���б�
				int[] intEDUPAYH = new int[6];  //�����

				GauceDataSet userSet = reqGauce.getGauceDataSet("DS1");

				GauceStatement gsmt = null;

				/****************************************************
				�ͼӳ⵵	2010�� �������� ���װ�� 
				 step1 : YCENTRY10==> YCPAY10 ���� �⺻������ INSERT
				 ���ǻ���; �Ǻ��� ó����.

				 YCPRSNK(������) ��==>YCEMNTRY10(�ҵ�����Ű�)���� ������.
				 ==> ������� 1�δ� �ѵ� ������.
				*****************************************************/
				//String  str1	="";

				//�Ķ��Ÿ �޾ƿ��°� ����


				String str1 = reqGauce.getParameter("eyy");
				String str2 = reqGauce.getParameter("eno");	

				logger.dbg.println(this,"11111");				
				logger.dbg.println(this,str1);
				logger.dbg.println(this,str2);

				//int idxAPPDT	 = userSet.indexOfColumn("APPDT");   //�ͼӳ⵵
				//int idxEMPNO = userSet.indexOfColumn("EMPNO");   //���
									       
				GauceDataRow[] rows = userSet.getDataRows();

       			StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer SelectSql = null;

				Statement stmt = null;
				ResultSet rs = null;
				


				for (int j = 0; j < rows.length; j++){ 
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//�Ǻ� ���� 
						//������ ����//////////////////////////////////////////////////////////////////
						//����û											����û��
						//EDUPAYNK-������������       EDUPAYNE-������������
						//EDUPAYPK-���߰�����				EDUPAYPE-���߰�����
						//EDUPAYUK-���б�������				EDUPAYUE-���б�������
						//EDUPAYHK-����α�����				EDUPAYHE-����α�����

						//�ʱ�ȭ

						intEDUPAY=0;      //����
						for(int i=0;i<6;i++){
							intEDUPAYN[i]=0; 
							intEDUPAYP[i]=0;
							intEDUPAYU[i]=0;
							intEDUPAYH[i]=0;
						}						



						//str1=rows[j].getString(idxAPPDT).substring(0,4);
			
						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT COALESCE(RESINO1,'')RESINO1,RELAT1,FAMNM1,   \n" ); 
						SelectSql.append( "        EDUPAYNK,EDUPAYPK,EDUPAYUK,EDUPAYHK,				\n" ); 
						SelectSql.append( "        EDUPAYNE,EDUPAYPE,EDUPAYUE,EDUPAYHE					\n" ); 
						SelectSql.append( "   FROM PAYROLL.YCPRSNK													\n" ); 
						SelectSql.append( "  WHERE APPDT='"+str1+"12"+"' 										\n" ); 
						SelectSql.append( "    AND EMPNO='"+str2+"'													\n" ); 

						logger.dbg.println(this,"SelectSql::"+SelectSql.toString());
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  

							//���� ���б��� ����θ� �־���.
							if(rs.getInt("RELAT1")==0){
								intEDUPAY = rs.getInt("EDUPAYUK")+rs.getInt("EDUPAYUE")+rs.getInt("EDUPAYHK")+rs.getInt("EDUPAYHE");
							}else{//������ �ƴѰ��

								//������������
								if(rs.getInt("EDUPAYNK")!=0||rs.getInt("EDUPAYNE")!=0){
									intEDUPAYN[0]+=1;
									intEDUPAYN[intEDUPAYN[0]]=rs.getInt("EDUPAYNK")+rs.getInt("EDUPAYNE");									
								}

								//���߰�����
								if(rs.getInt("EDUPAYPK")!=0||rs.getInt("EDUPAYPE")!=0){
									intEDUPAYP[0]+=1;
									intEDUPAYP[intEDUPAYP[0]]=rs.getInt("EDUPAYPK")+rs.getInt("EDUPAYPE");									
								}

								//���б�������
								if(rs.getInt("EDUPAYUK")!=0||rs.getInt("EDUPAYUE")!=0){
									intEDUPAYU[0]+=1;
									intEDUPAYU[intEDUPAYU[0]]=rs.getInt("EDUPAYUK")+rs.getInt("EDUPAYUE");									
								}

								//����α�����
								if(rs.getInt("EDUPAYHK")!=0||rs.getInt("EDUPAYHE")!=0){
									intEDUPAYH[0]+=1;
									intEDUPAYH[intEDUPAYH[0]]=rs.getInt("EDUPAYHK")+rs.getInt("EDUPAYHE");				
								}
							}
 					  }//while			

						stmt.close();
						rs.close();
 
					    UpdateSql = new StringBuffer();
						UpdateSql.append( "  UPDATE PAYROLL.YCENTRY10 SET  \n" );
						UpdateSql.append( "   EDUAMT01= "+intEDUPAY+"        \n" );
						UpdateSql.append( "  ,EDUCNT02= "+intEDUPAYN[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT021="+intEDUPAYN[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT022="+intEDUPAYN[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT023="+intEDUPAYN[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT024="+intEDUPAYN[4]+"   \n" );
						UpdateSql.append( "  ,EDUAMT025="+intEDUPAYN[5]+"   \n" );
						UpdateSql.append( "  ,EDUCNT03= "+intEDUPAYP[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT031="+intEDUPAYP[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT032="+intEDUPAYP[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT033="+intEDUPAYP[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT034="+intEDUPAYP[4]+"   \n" );
						UpdateSql.append( "  ,EDUAMT035="+intEDUPAYP[5]+"   \n" );
						UpdateSql.append( "  ,EDUCNT04= "+intEDUPAYU[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT041="+intEDUPAYU[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT042="+intEDUPAYU[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT043="+intEDUPAYU[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT044="+intEDUPAYU[4]+"   \n" );
						UpdateSql.append( "  ,EDUAMT045="+intEDUPAYU[5]+"   \n" );
						UpdateSql.append( "  ,EDUCNT05= "+intEDUPAYH[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT051="+intEDUPAYH[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT052="+intEDUPAYH[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT053="+intEDUPAYH[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT054="+intEDUPAYH[4]+"   \n" );
						UpdateSql.append( "  ,EDUAMT055="+intEDUPAYH[5]+"   \n" );
						UpdateSql.append( "  WHERE APPYY = '"+str1+"' \n" );
						UpdateSql.append( "    AND EMPNO = '"+str2+"' \n" );

						logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.executeUpdate();
						gsmt.close();

						//������ �����Ű� ���� ��///////

					}
				} 

			} 
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}
      conn.commit();
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
