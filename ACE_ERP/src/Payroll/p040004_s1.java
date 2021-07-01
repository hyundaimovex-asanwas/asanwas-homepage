package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class p040004_s1 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//������ں���
				str[1]	= req.getParameter("v_str2");		//������ڱ���
				str[2]	= req.getParameter("v_str3");		//����

				for (int s=0;s<3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					 "APPDT",			//���
					 "EMPNO",			//���                                          
					 "EMPDIV",		//�Ի籸�� 1������",2������               
					 "EMPNMK",		//����                                          
					 "DEPTNM",		//�μ�                                     
					 "PAYGRDNM",	//����
					 "STRTDT",		//�Ի���                                   
					 "ENDDT",			//�����                                   
					 "DUYEAR",		//�ٹ���                                  
					 "DUYMM",			//�ٹ���                                  
					 "DUDAY",			//�ٹ���                                  
					 "CADDR01",   //�ּ� 1                                 
					 "CADDR02",   //�ּ� 2                                 
					 "BASDAY1",		//�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                                   
					 "BASDAY2",		//�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                                   
					 "BASDAY3",		//�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                                  
					 "BASDAY4",   //�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)
					 "BASMAX1",   //���ٹ�/��Ÿ�ٹ� ������                                 
					 "BASMAX2",   //���ٹ�/��Ÿ�ٹ� ������                               
					 "BASMAX3",   //���ٹ�/��Ÿ�ٹ� ������
					 "BASMAX4",   //���ٹ�/��Ÿ�ٹ� ������
					 "BASAMT1",   //�޿�(�⺻��+��å����+�ð��ܼ���)                                  
					 "BASAMT2",   //�޿�(�⺻��+��å����+�ð��ܼ���)                                  
					 "BASAMT3",   //�޿�(�⺻��+��å����+�ð��ܼ���)
					 "BASAMT4",   //�޿�(�⺻��+��å����+�ð��ܼ���)
					 "BASBUS1",   //�� 3��                                  
					 "BASBUS2",   //�� 12,1��                                  
					 "BASBUS3",   //�� 9,11��
					 "BASBUS4",   //�� 5,7��
					 "BAEDAY1",		//��Ÿ�ٹ��� (��Ÿ����)                                 
					 "BAEDAY2",		//��Ÿ�ٹ��� (��Ÿ����)                                   
					 "BAEDAY3",		//��Ÿ�ٹ��� (��Ÿ����)                                  
					 "BAEDAY4",		//��Ÿ�ٹ��� (��Ÿ����)    
					 "BAEAMT1",		//��Ÿ�����                                  
					 "BAEAMT2",		//��Ÿ�����                                   
					 "BAEAMT3",		//��Ÿ�����                                  
					 "BAEAMT4",		//��Ÿ�����    
					 "YEAQTY",		//�����ϼ�                                  
					 "YEAPAY",		//��������                                   
					 "AVGYER",		//��ճ�������  
					 "AVGAMT",		//��ձ޿�    
					 "AVGBOS",		//��ջ�    
					 "AVGETC",		//��ձ�Ÿ����    
					 "P21000",		//�ټӼ���    
					 "P22000",		//�ڱ��ߺ�    
					 "P24000",		//����������    
					 "P29000",		//���ϰ�������    
					 "P38000",		//�ӿ���å����
					 "P27000",    //�������  �߰�
					 "PX0000",		//��Ÿ����    
					 "JUSPAY",		//�޿�    
					 "JUSRET",		//������    
					 "JUSYER",		//��������    
					 "JUSBOS",		//��    
					 "S91000",		//�����հ�    
					 "S94000",		//�����޾�    
					 "T21000",		//���ټ�-�ҵ漼                             
					 "T22000",		//�ֹμ�                              
					 "T23000",		//���ټ�-�ҵ漼                             
					 "T24000",		//�ֹμ�                              
					 "P43000",		//���ο���                              
					 "P41000",		//�ǰ�����                              
					 "P42000",		//��뺸��                           
					 "RETJUH",		//������ȯ�� 
					 "BX0010",		//��Ÿ����1
					 "BX0020",		//��Ÿ����2                                
					 "BX0030",		//��Ÿ����3                                
					 "BX0040",		//��Ÿ����4
 					 "S93000",		//�����հ�                               
 					 "RESINO",		//�����հ�                               
					 
					 "REF1",			
					 "REF2",			
					 "REF3",			
					 "REF4",
					 "REF"
				};

				int[] intArrCN = new int[]{  

					 6,						//���                                    
					 7,     			//���                                    
					 4, 					//�Ի籸�� 1������",2������               
					 20,    			//����                                    
					 40,					//�μ�                                    
					 30,					//����                                    
					 8, 					//�Ի���                                  
					 8, 					//�����                                  
					 2, 					//�ٹ���                                  
					 2, 					//�ٹ���                                  
					 2, 					//�ٹ���                                  
					 70,					//�ּ� 1                                  
					 70,					//�ּ� 2                                  
					 2,           //�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                      
					 2,           //�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                       
					 2,           //�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                      
					 2, 					//�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���) 
					 2,           //���ٹ�/��Ÿ�ٹ� ������                    
					 2,           // ���ٹ�/��Ÿ�ٹ� ������                    
					 2, 					// ���ٹ�/��Ÿ�ٹ� ������                 
					 2, 					//  ���ٹ�/��Ÿ�ٹ� ������                
					 9,           //�޿�(�⺻��+��å����+�ð��ܼ���)                      
					 9,           //�޿�(�⺻��+��å����+�ð��ܼ���)                      
					 9, 					//�޿�(�⺻��+��å����+�ð��ܼ���)        
					 9, 					//�޿�(�⺻��+��å����+�ð��ܼ���)        
					 9, 					//�� 3��                                
					 9,    				//�� 12,1��                             
					 9, 					//�� 9,11��                             
					 9, 					//�� 5,7��                              
					 2,           //��Ÿ�ٹ��� (��Ÿ����)                    
					 2,           //��Ÿ�ٹ��� (��Ÿ����)                      
					 2,           //��Ÿ�ٹ��� (��Ÿ����)                     
					 2, 					//��Ÿ�ٹ��� (��Ÿ����)                   
					 9,  					//��Ÿ�����                              
					 9,   				//��Ÿ�����                              
					 9,  					//��Ÿ�����                              
					 9, 					//��Ÿ�����                              
					 9, 					//�����ϼ�                                
					 9,  					//��������                                
					 9, 					//��ճ�������                            
					 9, 					//��ձ޿�                                
					 9, 					//��ջ�                                
					 9, 					//��ձ�Ÿ����                            
					 9, 					//�ټӼ���                                
					 9, 					//�ڱ��ߺ�                              
					 9, 					//����������                              
					 9, 					//���ϰ�������                            
					 9, 					//�ӿ���å����
					 9,           //�������  �߰�
					 9, 					//��Ÿ����                                
					 9, 					//�޿�                                    
					 9, 					//������                                  
					 9, 					//��������                                
					 9, 					//��                                    
					 9, 					//�����հ�                                
					 9, 					//�����޾�                                
					 9, 					//���ټ�-�ҵ漼                           
					 9, 					//�ֹμ�                                  
					 9, 					//���ټ�-�ҵ漼                           
					 9, 					//�ֹμ�                                  
					 9, 					//���ο���                                
					 9, 					//�ǰ�����                                
					 9, 					//��뺸��                                
					 9, 					//������ȯ��                              
					 9, 					//��Ÿ����1                               
					 9, 					//��Ÿ����2                               
					 9, 					//��Ÿ����3                               
					 9, 					//��Ÿ����4                               
 					 9, 					//�����հ�                                
 					 13, 					//�����հ�                                

					 20,
					 20,
					 20,
					 20,
					 20
           }; 

				int[] intArrCN2 = new int[]{

					 -1,					//���                                    
					 -1,    			//���                                    
					 -1, 					//�Ի籸�� 1������",2������               
					 -1,   				//����                                    
					 -1, 					//�μ�                                    
					 -1, 					//����                                    
					 -1, 					//�Ի���                                  
					 -1, 					//�����                                  
					 0,  					//�ٹ���                                  
					 0,  					//�ٹ���                                  
					 0,  					//�ٹ���                                  
					-1, 					//�ּ� 1                                  
					-1, 					//�ּ� 2                                  
					 0,           //�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                
					 0,           //�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                      
					 0,           //�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)                     
					 0,  					//�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���) 
					 0,           //���ٹ�/��Ÿ�ٹ� ������                   
					 0,           //���ٹ�/��Ÿ�ٹ� ������                   
					 0,  					//���ٹ�/��Ÿ�ٹ� ������                 
					 0,  					//���ٹ�/��Ÿ�ٹ� ������                
					 0,           //�޿�(�⺻��+��å����+�ð��ܼ���)                     
					 0,           //�޿�(�⺻��+��å����+�ð��ܼ���)                     
					 0,  					//�޿�(�⺻��+��å����+�ð��ܼ���)        
					 0,  					//�޿�(�⺻��+��å����+�ð��ܼ���)        
					 0,  					//�� 3��                                
					 0,   				//�� 12,1��                             
					 0,  					//�� 9,11��                             
					 0,  					//�� 5,7��                              
					 0,           //��Ÿ�ٹ��� (��Ÿ����)                   
					 0,           //��Ÿ�ٹ��� (��Ÿ����)                     
					 0,           //��Ÿ�ٹ��� (��Ÿ����)                    
					 0,  					//��Ÿ�ٹ��� (��Ÿ����)                   
					 0,  					//��Ÿ�����                              
					 0,  					//��Ÿ�����                              
					 0,  					//��Ÿ�����                              
					 0,  					//��Ÿ�����                              
					 0,  					//�����ϼ�                                
					 0,  					//��������                                
					 0,  					//��ճ�������                            
					 0,  					//��ձ޿�                                
					 0,  					//��ջ�                                
					 0,  					//��ձ�Ÿ����                            
					 0,  					//�ټӼ���                                
					 0,  					//�ڱ��ߺ�                              
					 0,  					//����������                              
					 0,  					//���ϰ�������                            
					 0,  					//�ӿ���å����
					 0,           //�������  �߰�
					 0,  					//��Ÿ����                                
					 0,  					//�޿�                                    
					 0,  					//������                                  
					 0,  					//��������                                
					 0,  					//��                                    
					 0,  					//�����հ�                                
					 0,  					//�����޾�                                
					 0, 					//���ټ�-�ҵ漼                           
					 0, 					//�ֹμ�                                  
					 0, 					//���ټ�-�ҵ漼                           
					 0, 					//�ֹμ�                                  
					 0, 					//���ο���                                
					 0, 					//�ǰ�����                                
					 0,  					//��뺸��                                
					 0,  					//������ȯ��                              
					 0,  					//��Ÿ����1                               
					 0,  					//��Ÿ����2                               
					 0,  					//��Ÿ����3                               
					 0,  					//��Ÿ����4                               
 					 0,  					//�����հ�                                
 					 -1,  					//�����հ�
					 
					 -1,
					 -1,
					 -1,
					 -1,
					 -1
           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append("   SELECT																																					\n");
					sql.append("     B.APPDT,    /*���                                    */											\n");
					sql.append("     B.EMPNO,   /*���                                     */											\n");
					sql.append("     A.EMPDIV,  /*�Ի籸�� 1������,2������                 */											\n");
					sql.append("     A.EMPNMK,  /*����                                     */											\n");
					sql.append("     C.DEPTNM,  /*�μ�                                     */											\n");
					sql.append("     D.MINORNM AS PAYGRDNM, /*����                         */											\n");
					sql.append("     B.STRTDT, /*�Ի���                                    */											\n");
					sql.append("     B.ENDDT,  /*�����                                    */											\n");
					sql.append("     B.DUYEAR,  /*�ٹ���                                   */											\n");
					sql.append("     B.DUYMM,   /*�ٹ���                                   */											\n");
					sql.append("     B.DUDAY,   /*�ٹ���                                   */											\n");
					sql.append("     RTRIM(A.CADDR01) AS CADDR01,   /*�ּ� 1               */											\n");
					sql.append("     RTRIM(A.CADDR02) AS CADDR02,   /*�ּ� 2               */											\n");
					sql.append("     B.BASDAY1, /*�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)  */											\n");
					sql.append("     B.BASDAY2,  /*�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���) */											\n");
					sql.append("     B.BASDAY3,  /*�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���) */											\n");
					sql.append("     B.BASDAY4,   /*�ٹ��� �޿�(�⺻��+��å����+�ð��ܼ���)*/											\n");
					sql.append("     B.BASMAX1,   /*���ٹ�/��Ÿ�ٹ� ������                 */											\n");
					sql.append("     B.BASMAX2,   /* ���ٹ�/��Ÿ�ٹ� ������                */											\n");
					sql.append("     B.BASMAX3,   /* ���ٹ�/��Ÿ�ٹ� ������                */											\n");
					sql.append("     B.BASMAX4,   /*  ���ٹ�/��Ÿ�ٹ� ������               */											\n");
					sql.append("     B.BASAMT1,   /*�޿�(�⺻��+��å����+�ð��ܼ���)       */											\n");
					sql.append("     B.BASAMT2,   /*�޿�(�⺻��+��å����+�ð��ܼ���)       */											\n");
					sql.append("     B.BASAMT3,   /*�޿�(�⺻��+��å����+�ð��ܼ���)       */											\n");
					sql.append("     B.BASAMT4,   /*�޿�(�⺻��+��å����+�ð��ܼ���)       */											\n");
					sql.append("     B.BASBUS1,   /*�� 3��                               */											\n");
					sql.append("     B.BASBUS2,   /*�� 12,1��                            */											\n");
					sql.append("     B.BASBUS3,   /*�� 9,11��                            */											\n");
					sql.append("     B.BASBUS4,   /*�� 5,7��                             */											\n");
					sql.append("     B.BAEDAY1,  /*��Ÿ�ٹ��� (��Ÿ����)                   */											\n");
					sql.append("     B.BAEDAY2,  /*��Ÿ�ٹ��� (��Ÿ����)                   */											\n");
					sql.append("     B.BAEDAY3,  /*��Ÿ�ٹ��� (��Ÿ����)                   */											\n");
					sql.append("     B.BAEDAY4,  /*��Ÿ�ٹ��� (��Ÿ����)                   */											\n");
					sql.append("     B.BAEAMT1,  /*��Ÿ�����                              */											\n");
					sql.append("     B.BAEAMT2,  /*��Ÿ�����                              */											\n");
					sql.append("     B.BAEAMT3,  /*��Ÿ�����                              */											\n");
					sql.append("     B.BAEAMT4,  /*��Ÿ�����                              */											\n");
					sql.append("     B.YEAQTY,   /*�����ϼ�                                */											\n");
					sql.append("     B.YEAPAY,   /*��������                                */											\n");
					sql.append("     B.AVGYER,   /*��ճ�������                            */											\n");
					sql.append("     B.AVGAMT,   /*��ձ޿�                                */											\n");
					sql.append("     B.AVGBOS,   /*��ջ�                                */											\n");
					sql.append("     B.AVGETC,   /*��ձ�Ÿ����                            */											\n");
					sql.append("     B.P21000,   /*�ټӼ���                                */											\n");
					sql.append("     B.P22000,   /*�ڱ��ߺ�                              */											\n");
					sql.append("     B.P24000,   /*����������                              */											\n");
					sql.append("     B.P29000,   /*���ϰ�������                            */											\n");
					sql.append("     B.P38000,   /*�ӿ���å����                            */											\n");
					sql.append("     B.P27000,   /*�������			                           */											\n");
					sql.append("     B.PX0000,   /*��Ÿ����                                */											\n");
					sql.append("     B.JUSPAY,   /*�޿�                                    */											\n");
					sql.append("     B.JUSRET,   /*������                                  */											\n");
					sql.append("     B.JUSYER,   /*��������                                */											\n");
					sql.append("     B.JUSBOS,   /*��                                    */											\n");
					sql.append("     B.S91000,   /*�����հ�                                */											\n");
					sql.append("     B.S94000,   /*�����޾�                                */											\n");
					sql.append("     B.T21000, /*���ټ�-�ҵ漼                             */											\n");
					sql.append("     B.T22000, /*�ֹμ�                                    */											\n");
					sql.append("     B.T23000, /*���ټ�-�ҵ漼                             */											\n");
					sql.append("     B.T24000, /*�ֹμ�                                    */											\n");
					sql.append("     B.P43000, /*���ο���                                  */											\n");
					sql.append("     B.P41000, /*�ǰ�����                                  */											\n");
					sql.append("     B.P42000,  /*��뺸��                                 */											\n");
					sql.append("     B.RETJUH,  /*������ȯ��                               */											\n");
					sql.append("     B.BX0010,  /*��Ÿ����1                                */											\n");
					sql.append("     B.BX0020,  /*��Ÿ����2                                */											\n");
					sql.append("     B.BX0030,  /*��Ÿ����3                                */											\n");
					sql.append("     B.BX0040,  /*��Ÿ����4                                */											\n");
					sql.append("     B.S93000,   /*�����հ�                                */											\n");
					sql.append("     A.RESINO,  /*�ֹι�ȣ                                 */											\n");
					sql.append("		 RTRIM(B.REF1) REF1,																													\n");	
					sql.append("		 RTRIM(B.REF2) REF2,																													\n");
					sql.append("		 RTRIM(B.REF3) REF3,																													\n");
					sql.append("		 RTRIM(B.REF4) REF4,																													\n");
					sql.append("		 RTRIM(B.REF) REF				/*��������*/																					\n");
					sql.append(" FROM  PAYROLL.PRPAY B																														\n");
					sql.append(" LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=B.EMPNO																	\n");
					sql.append(" LEFT JOIN PAYROLL.HCDEPT C  ON  A.DEPTCD = C.DEPTCD															\n");
					sql.append(" LEFT JOIN PAYROLL.HCLCODE D ON  A.PAYGRD = D.MINORCD  AND D.MAJORCD = '2002'			\n");
					sql.append(" WHERE RTRIM(B.EMPNO) <> ''																												\n");
					sql.append(" AND B.PAYDIV IN ('3')	--����																										\n");
					
					if ( (!str[0].equals("")&&!str[0].equals("0")) && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND B.ENDDT BETWEEN  '"  + str[0] + "' AND  '"  + str[1] + "' ");											//�������-��������
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[2]+ "%'	\n");   //����

					sql.append(" ORDER BY B.ENDDT DESC, B.APPDT DESC																							\n");

					//logger.dbg.println(this,sql.toString());

/*********************************************************************************************/
                    
					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}
		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();
		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}