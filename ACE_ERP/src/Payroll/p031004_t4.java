package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t4 extends HttpServlet{

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

				int intCnt=0;     //�����ٹ�����
				int intNtaxCnt=0; //�����������

				int[] intBP11000 = new int[4];  //�޿�
				int[] intBP12000 = new int[4];  //��
				int[] intBP13000 = new int[4];  //������
				int[] intBP10SUM = new int[4];  //�ѱ޿���
				int[] intBP21000 = new int[3];  //���ܱٷκ����
				int[] intBP22000 = new int[3];  //�߰��ٷκ����
				int[] intBP23000 = new int[3];  //��Ÿ�����
				int[] intBP31000 = new int[4];  //���ο���
				int[] intBP32000 = new int[4];  //�ǰ�����
				int[] intBP33000 = new int[4];  //��뺸��
				int[] intBP34000 = new int[4];  //��������
				int[] intBP41000 = new int[3];  //�ҵ漼
				int[] intBP42000 = new int[3];  //����ҵ漼
				int[] intBP43000 = new int[3];  //��Ư��
				int[] intBP40SUM = new int[3];  //���װ�

        String[] strWkresino = new String[3]; //����ڵ�Ϲ�ȣ
				String[] strWknm = new String[3];     //�ٹ�ó��
				String[] strStrtdt = new String[3];   //�ٹ��Ⱓfr
				String[] strEnddt = new String[3];    //�ٹ��Ⱓto

				String strNTAXCD02 ="";

    
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //�ͼӳ⵵       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //�ͼӳ⵵       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;
	       
        //===================================================================================
        /************************************************************************************
         �����ٹ��� ����.
				 ������� �ݾ������� ��ü �ٹ��� ���� �ణ�� ���۾����� ��������..
				*************************************************************************************/

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //�ʱ�ȭ 
						intCnt=0;
						intNtaxCnt=0;
						strNTAXCD02 ="";
						for(int i=0;i<3;i++){
							strWkresino[i]=""; 
							strWknm[i]  ="";
						  strStrtdt[i]=""; 	 
							strEnddt[i] ="";

							intBP11000[i] =0;intBP12000[i] =0;intBP13000[i] =0;intBP10SUM[i] =0;
							intBP21000[i] =0;intBP22000[i] =0;intBP23000[i] =0;
							intBP31000[i] =0;intBP32000[i] =0;intBP33000[i] =0;intBP34000[i] =0;
							intBP41000[i] =0;intBP42000[i] =0;intBP43000[i] =0;intBP40SUM[i] =0;
              
						}

            intBP31000[3]=0;
						intBP32000[3]=0;
						intBP33000[3]=0;
						intBP34000[3]=0;

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT YYYY,    EMPNO,   SEQ,      WKRESINO, WKNM, \n" ); 
						SelectSql.append( "        DEPTCD,  PAYGRD,  STRTDT,   ENDDT,          \n" ); 
						SelectSql.append( "        BP11000, BP12000, BP13000,  BP10SUM,        \n" ); 
						SelectSql.append( "        BP21000, BP22000, BP23000,                  \n" ); 
						SelectSql.append( "        BP31000, BP32000, BP33000,  BP34000,        \n" ); 
						SelectSql.append( "        BP41000, BP42000, BP43000,  BP40SUM,        \n" ); 
						SelectSql.append( "        BTAXNM01,BTAXCD01,BTAXAMT01,                \n" ); 
						SelectSql.append( "        BTAXNM02,BTAXCD02,BTAXAMT02                 \n" );
						SelectSql.append( "   FROM PAYROLL.YCBEFOFF                            \n" ); 
						SelectSql.append( "  WHERE YYYY='"+rows[j].getString(idxAPPYY)+"'      \n" ); 
						SelectSql.append( "    AND EMPNO ='"+rows[j].getString(idxEMPNO)+"'    \n" ); 
						SelectSql.append( "  ORDER BY SEQ                                      \n" ); 
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						//BP22000, BP23000�� ������� ����....������. BP21000�� ����ϴ±�.

						while(rs.next()){  
							intCnt+=1;
              strWkresino[intCnt-1]=rs.getString("WKRESINO"); 
							strWknm[intCnt-1]  =rs.getString("WKNM"); 
						  strStrtdt[intCnt-1]=rs.getString("STRTDT"); 
							strEnddt[intCnt-1] =rs.getString("ENDDT"); 

              intBP11000[intCnt-1] = rs.getInt("BP11000");  //�޿�          
            	intBP12000[intCnt-1] = rs.getInt("BP12000");	//��          
							intBP13000[intCnt-1] = rs.getInt("BP13000");	//������      
							intBP10SUM[intCnt-1] = rs.getInt("BP10SUM");	//�ѱ޿��� 
							
							intBP21000[intCnt-1] = rs.getInt("BP21000");	//���ܱٷκ����
							intBP22000[intCnt-1] = rs.getInt("BP22000");	//�߰��ٷκ����
							intBP23000[intCnt-1] = rs.getInt("BP23000");	//��Ÿ�����    
							
							intBP31000[intCnt-1] = rs.getInt("BP31000");	//���ο���      
							intBP32000[intCnt-1] = rs.getInt("BP32000");	//�ǰ�����      
							intBP33000[intCnt-1] = rs.getInt("BP33000");	//��뺸��      
							intBP34000[intCnt-1] = rs.getInt("BP34000");	//��������      
							intBP41000[intCnt-1] = rs.getInt("BP41000");	//�ҵ漼        
							intBP42000[intCnt-1] = rs.getInt("BP42000");	//����ҵ漼    
							intBP43000[intCnt-1] = rs.getInt("BP43000");	//��Ư��        
							intBP40SUM[intCnt-1] = rs.getInt("BP40SUM");	//���װ�   
							
							intBP11000[3] += intBP11000[intCnt-1];	//�޿��հ�     
							intBP12000[3] += intBP12000[intCnt-1];	//���հ�      
							intBP13000[3] += intBP13000[intCnt-1];	//�������հ�      
							intBP10SUM[3] += intBP10SUM[intCnt-1];	//�ѱ޿��հ�
							
							intBP31000[3] += intBP31000[intCnt-1];	//���ο����հ�     
							intBP32000[3] += intBP32000[intCnt-1];	//�ǰ������հ�      
							intBP33000[3] += intBP33000[intCnt-1];	//��뺸���հ�      
							intBP34000[3] += intBP34000[intCnt-1];	//���������հ�
            

              if(rs.getInt("BP22000")!=0){   //
								intNtaxCnt+=1;
								//intBP22000[intNtaxCnt-1] = rs.getInt("BP22000");

								strNTAXCD02 ="O01"; //����0 + ����01
              }


              //�̰� �㿡 �Ӹ� �Ἥ �ذ�����...���ش� ��� �׳� �н� 
              if(rs.getInt("BTAXAMT01")!=0){ //
								intNtaxCnt+=1;
              }

              if(rs.getInt("BTAXAMT02")!=0){
								intNtaxCnt+=1;
              }
 					 }//while			

					 stmt.close();
					 rs.close();

					 if(intNtaxCnt>2){ //�����ٹ��� ������� 2���� �ʰ��ϸ� ���۾���.

					 }

           //�����ٹ������� ���װ谡 SUM ���� �ʾƼ� �ٽ� SUM��.
					 intBP40SUM[0] = intBP41000[0]+intBP42000[0]+intBP43000[0];
					 intBP40SUM[1] = intBP41000[1]+intBP42000[1]+intBP43000[1];
					 intBP40SUM[2] = intBP41000[2]+intBP42000[2]+intBP43000[2];

					/////////////////////////////////////////////////////////////////////////////////////////////
					//0 �����ٹ��� ==> ���޸���
					/////////////////////////////////////////////////////////////////////////////////////////////
					UpdateSql = new StringBuffer();
					UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET    \n");   
					UpdateSql.append( "  BWORKNM1='"+strWknm[0]+"'     \n");  //1�� �ٹ�ó��
					UpdateSql.append( " ,BWORKNO1='"+strWkresino[0]+"' \n");  //1�� ����ڵ�Ϲ�ȣ
					UpdateSql.append( " ,BWORKFR1='"+strStrtdt[0]+"'   \n");  //1�� �ٹ��Ⱓfr
					UpdateSql.append( " ,BWORKTO1='"+strEnddt[0]+"'    \n");  //1�� �ٹ��Ⱓto
					UpdateSql.append( " ,BP11000="+intBP11000[0]+"     \n");  //1�� �޿�          
					UpdateSql.append( " ,BP12000="+intBP12000[0]+"     \n");	//1�� ��          
					UpdateSql.append( " ,BP13000="+intBP13000[0]+"     \n");	//1�� ������      
					UpdateSql.append( " ,BP10000="+intBP10SUM[0]+"     \n");	//1�� �ѱ޿���      
					UpdateSql.append( " ,BP41000="+intBP41000[0]+"     \n");	//1�� �ҵ漼      
					UpdateSql.append( " ,BP42000="+intBP42000[0]+"     \n");	//1�� ����ҵ漼  
					UpdateSql.append( " ,BP43000="+intBP43000[0]+"     \n");	//1�� ��Ư��      
					UpdateSql.append( " ,BP40000="+intBP40SUM[0]+"     \n");	//1�� ���װ�     
					UpdateSql.append( " ,BWORKNM2='"+strWknm[1]+"'     \n");	//2�� �ٹ�ó��         
					UpdateSql.append( " ,BWORKNO2='"+strWkresino[1]+"' \n");	//2�� ����ڵ�Ϲ�ȣ   
					UpdateSql.append( " ,BWORKFR2='"+strStrtdt[1]+"'   \n");	//2�� �ٹ��Ⱓfr       
					UpdateSql.append( " ,BWORKTO2='"+strEnddt[1]+"'    \n");	//2�� �ٹ��Ⱓto       
					UpdateSql.append( " ,BP21000="+intBP11000[1]+"     \n");	//2�� �޿�             
					UpdateSql.append( " ,BP22000="+intBP12000[1]+"     \n");	//2�� ��             
					UpdateSql.append( " ,BP23000="+intBP13000[1]+"     \n");	//2�� ������         
					UpdateSql.append( " ,BP20000="+intBP10SUM[1]+"     \n");	//2�� �ѱ޿���      
					UpdateSql.append( " ,BP51000="+intBP41000[1]+"     \n");	//2�� �ҵ漼        
					UpdateSql.append( " ,BP52000="+intBP42000[1]+"     \n");	//2�� ����ҵ漼    
					UpdateSql.append( " ,BP53000="+intBP43000[1]+"     \n");	//2�� ��Ư��        
					UpdateSql.append( " ,BP50000="+intBP40SUM[1]+"     \n");	//2�� ���װ�        
					UpdateSql.append( " ,BWORKNM3='"+strWknm[2]+"'     \n");  //3�� �ٹ�ó��       
					UpdateSql.append( " ,BWORKNO3='"+strWkresino[2]+"' \n");	//3�� ����ڵ�Ϲ�ȣ
					UpdateSql.append( " ,BWORKFR3='"+strStrtdt[2]+"'   \n");	//3�� �ٹ��Ⱓfr    
					UpdateSql.append( " ,BWORKTO3='"+strEnddt[2]+"'    \n");	//3�� �ٹ��Ⱓto    
					UpdateSql.append( " ,BP31000="+intBP11000[2]+"     \n");	//3�� �޿�          
					UpdateSql.append( " ,BP32000="+intBP12000[2]+"     \n");	//3�� ��          
					UpdateSql.append( " ,BP33000="+intBP13000[2]+"     \n");	//3�� ������      
					UpdateSql.append( " ,BP30000="+intBP10SUM[2]+"     \n");	//3�� �ѱ޿���      
					UpdateSql.append( " ,BP61000="+intBP41000[2]+"     \n");	//3�� �ҵ漼        
					UpdateSql.append( " ,BP62000="+intBP42000[2]+"     \n");	//3�� ����ҵ漼    
					UpdateSql.append( " ,BP63000="+intBP43000[2]+"     \n");	//3�� ��Ư��        
					UpdateSql.append( " ,BP60000="+intBP40SUM[2]+"     \n");	//3�� ���װ�  


          UpdateSql.append( " ,NTAXCD02='"+strNTAXCD02+"'     \n");	//�����  �߰��ٷ� �ڵ� (O01)

					UpdateSql.append( " ,BNTAX102="+intBP22000[0]+"     \n");	//1�� �����  �߰��ٷ�
					UpdateSql.append( " ,BNTAX202="+intBP22000[1]+"     \n");	//2�� �����  �߰��ٷ�
					UpdateSql.append( " ,BNTAX302="+intBP22000[2]+"     \n");	//3�� �����  �߰��ٷ�
					
					//UpdateSql.append( " ,CBP1000=CBP1000+"+intBP11000[3]+"     \n"); //�޿��հ�     
					//UpdateSql.append( " ,CBP2000=CBP2000+"+intBP12000[3]+"     \n"); //���հ�     
          //UpdateSql.append( " ,CBP3000=CBP3000+"+intBP13000[3]+"     \n"); //�������հ� 
          //UpdateSql.append( " ,CBPSUM =CBPSUM+"+intBP10SUM[3]+"      \n"); //�ѱ޿��հ�  

					//UpdateSql.append( " ,PENAMT01=PENAMT01+"+intBP31000[3]+"   \n"); //���ο����հ�  
					//UpdateSql.append( " ,INSAMT01=INSAMT01+"+intBP32000[3]+"   \n"); //�ǰ������հ�  
          //UpdateSql.append( " ,INSAMT02=INSAMT02+"+intBP33000[3]+"   \n"); //��뺸���հ�  
          //UpdateSql.append( " ,PENAMT03=PENAMT03+"+intBP34000[3]+"   \n"); //���������հ�      

					UpdateSql.append( "   WHERE APPYY =  '"+rows[j].getString(idxAPPYY)+"' " );
					UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
					logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
					gsmt = conn.getGauceStatement(UpdateSql.toString());
					gsmt.executeUpdate();
					gsmt.close();

				 } //getJobType
			}  //for j 
     			
			} //try
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