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
public class p040005_s1 extends HttpServlet {

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
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					 "EMPNO",                                             
					 "EMPDIV",  //�Ի籸�� 1������",2������               
					 "EMPNMK",                                            
					 "ENDDT",                                             
					 "DEPTNM", //�μ�                                     
					 "PAYGRDNM", //����                                   
					 "STRTDT", //�Ի���                                   
					 "ENDDT",  //�����                                   
					 "DUYEAR",  //�ٹ���                                  
					 "DUYMM",   //�ٹ���                                  
					 "DUDAY",   //�ٹ���                                  
					 "CADDR01",   //�ּ�                                  
					 "APPYM",                                             
					 "SUM_P1", //�⺻�޿�+��å����+�ð��ܼ��� ����   			
					 "SUM_P2", //�⺻�޿�+��å����+�ð��ܼ��� ����				
					 "SUM_P3", //�⺻�޿�+��å����+�ð��ܼ��� ����				
					 "SUM_P4", //�⺻�޿�+��å����+�ð��ܼ��� ����				
					 "BUSPAY1", //�� 1����                              
					 "BUSPAY2", //�� 3����                              
					 "BUSPAY3", //�� 5����                              
					 "BUSPAY4", //�� 7����                              
					 "BUSPAY5", //�� 9����                              
					 "BUSPAY6", //�� 11����                             
					 "BUSPAY7", //�� 12����(200%)                       
					 "RETRAT",  //�ֱ�3�����޿�                           
					 "YEAPAY",  //��������                                
					 "MONAVG",  //��ձ޿�(�⺻�޿�+��å����+�ð��ܼ��� ) 
					 "MONBUS",  //��ջ�                                
					 "MONCOM",  //��ռ���                                
					 "P21000",  //�ټӼ���                                
					 "P22000",  //�ڱ��ߺ�                              
					 "P24000",  //����������                              
					 "P29000",  //���ϰ�������                            
					 "P38000",  //�ӿ���å����                            
					 "P21000_2",  //�ټӼ���                                
					 "P22000_2",  //�ڱ��ߺ�                              
					 "P24000_2",  //����������                              
					 "P29000_2",  //���ϰ�������                            
					 "P38000_2",  //�ӿ���å����                            
					 "P21000_3",  //�ټӼ���                                
					 "P22000_3",  //�ڱ��ߺ�                              
					 "P24000_3",  //����������                              
					 "P29000_3",  //���ϰ�������                            
					 "P38000_3",  //�ӿ���å����                            
					 "P21000_4",  //�ټӼ���                                
					 "P22000_4",  //�ڱ��ߺ�                              
					 "P24000_4",  //����������                              
					 "P29000_4",  //���ϰ�������                            
					 "P38000_4",  //�ӿ���å����                            
					 "PX0010",  //��Ÿ��                    				      
					 "PX0020",  //��Ÿ��                				          
					 "PX0030",  //��Ÿ��                				          
					 "PX0040",  //��Ÿ��                				          
					 "S91000",  //�����޿�                                
					 "RETPAY",  //������                                  
					 "T11000",  //���ټ�                                  
					 "T12000",  //�ֹμ�                                  
					 "B11000",  //�ǰ������                              
					 "B12000",  //���ο���                                
					 "B13000",  //��뺸��                                
					 "T92000",  //������ȯ��                    
					 "BX0010",  //��Ÿ����1                               
					 "BX0020",  //��Ÿ����2                               
					 "BX0030",  //��Ÿ����3                               
					 "BX0040"   //��Ÿ����4                               
                                                      				



				};

				int[] intArrCN = new int[]{  
					 7,   //���                                          
					 4,  //�Ի籸�� 1������",2������               
					 20,   //����                                         
					 8,    //�����                                         
					 30, //�μ�                                     
					 30, //����                                   
					 8, //�Ի���                                   
					 8,  //�����                                   
					 2,  //�ٹ���                                  
					 2,   //�ٹ���                                  
					 2,   //�ٹ���                                  
					 70,   //�ּ�                                  
					 6,   //����⵵                                          
					 9, //�⺻�޿�+��å����+�ð��ܼ��� ����   			
					 9, //�⺻�޿�+��å����+�ð��ܼ��� ����				
					 9, //�⺻�޿�+��å����+�ð��ܼ��� ����				
					 9, //�⺻�޿�+��å����+�ð��ܼ��� ����				
					 9, //�� 1����                              
					 9, //�� 3����                              
					 9, //�� 5����                              
					 9, //�� 7����                              
					 9, //�� 9����                              
					 9, //�� 11����                             
					 9, //�� 12����(200%)                       
					 10,  //�ֱ�3�����޿�                           
					 10,  //��������                                
					 10,  //��ձ޿�(�⺻�޿�+��å����+�ð��ܼ��� ) 
					 10,  //��ջ�                                
					 10,  //��ռ���                                
					 9,  //�ټӼ���                                
					 9,  //�ڱ��ߺ�                              
					 9,  //����������                              
					 9,  //���ϰ�������                            
					 9,  //�ӿ���å����                            
					 9,  //�ټӼ���                                
					 9,  //�ڱ��ߺ�                              
					 9,  //����������                              
					 9,  //���ϰ�������                            
					 9,  //�ӿ���å����                            
					 9,  //�ټӼ���                                
					 9,  //�ڱ��ߺ�                              
					 9,  //����������                              
					 9,  //���ϰ�������                            
					 9,  //�ӿ���å����                            
					 9,  //�ټӼ���                                
					 9,  //�ڱ��ߺ�                              
					 9,  //����������                              
					 9,  //���ϰ�������                            
					 9,  //�ӿ���å����                            
					 9,  //��Ÿ��                    				      
					 9,  //��Ÿ��                				          
					 9,  //��Ÿ��                				          
					 9,  //��Ÿ��                				          
					 9,  //�����޿�                                
					 10,  //������                                  
					 9,  //���ټ�                                  
					 9,  //�ֹμ�                                  
					 9,  //�ǰ������                              
					 9,  //���ο���                                
					 9,  //��뺸��                                
					 9,  //������ȯ��                     
					 9,  //��Ÿ����1                               
					 9,  //��Ÿ����2                               
					 9,  //��Ÿ����3                               
					 9   //��Ÿ����4                               

            	}; 

				int[] intArrCN2 = new int[]{
					 -1,   //���                                          
					 -1,  //�Ի籸�� 1������",2������               
					 -1,   //����                                         
					 -1,    //�����                                         
					 -1, //�μ�                                     
					 -1, //����                                   
					 -1, //�Ի���                                   
					 -1,  //�����                                   
					 0,  //�ٹ���                                  
					 0,   //�ٹ���                                  
					 0,   //�ٹ���                                  
					 -1,   //�ּ�                                  
					 -1,   //����⵵                                          
					 0, //�⺻�޿�+��å����+�ð��ܼ��� �����ֱ�����0     			
					 0, //�⺻�޿�+��å����+�ð��ܼ��� ����	�ֱ�����1  			
					 0, //�⺻�޿�+��å����+�ð��ܼ��� ����	�ֱ�����2  			
					 0, //�⺻�޿�+��å����+�ð��ܼ��� ����	�ֱ�����3  			
					 0, //�� 1����                              
					 0, //�� 3����                              
					 0, //�� 5����                              
					 0, //�� 7����                              
					 0, //�� 9����                              
					 0, //�� 11����                             
					 0, //�� 12����(200%)                       
					 0,  //�ֱ�3�����޿�                           
					 0,  //��������                                
					 0,  //��ձ޿�(�⺻�޿�+��å����+�ð��ܼ��� ) 
					 0,  //��ջ�                                
					 0,  //��ռ���                                
					 0,  //�ټӼ���                                
					 0,  //�ڱ��ߺ�                              
					 0,  //����������                              
					 0,  //���ϰ�������                            
					 0,  //�ӿ���å����                            
					 0,  //�ټӼ���                                
					 0,  //�ڱ��ߺ�                              
					 0,  //����������                              
					 0,  //���ϰ�������                            
					 0,  //�ӿ���å����                            
					 0,  //�ټӼ���                                
					 0,  //�ڱ��ߺ�                              
					 0,  //����������                              
					 0,  //���ϰ�������                            
					 0,  //�ӿ���å����                            
					 0,  //�ټӼ���                                
					 0,  //�ڱ��ߺ�                              
					 0,  //����������                              
					 0,  //���ϰ�������                            
					 0,  //�ӿ���å����                            
					 0,  //��Ÿ�� �ֱ�����0                   				      
					 0,  //��Ÿ��  �ֱ�����1                   				          
					 0,  //��Ÿ��  �ֱ�����2                   				          
					 0,  //��Ÿ��  �ֱ�����3                  				          
					 0,  //�����޿�                                
					 0,  //������                                  
					 0,  //���ټ�                                  
					 0,  //�ֹμ�                                  
					 0,  //�ǰ������                              
					 0,  //���ο���                                
					 0,  //��뺸��                                
					 0,  //������ȯ��                   
					 0,  //��Ÿ����1                               
					 0,  //��Ÿ����2                               
					 0,  //��Ÿ����3                               
					 0   //��Ÿ����4                               


                     }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
sql.append("   SELECT                                                                                  \n");
sql.append("            A.EMPNO,                                                                       \n");
sql.append("            A.EMPDIV,  --�Ի籸�� 1������,2������                                          \n");
sql.append("            A.EMPNMK,                                                                      \n");
sql.append("            A.ENDDT,                                                                       \n");
sql.append("            E.DEPTNM, --�μ�                                                               \n");
sql.append("            F.MINORNM AS PAYGRDNM, --����                                                  \n");
sql.append("            A.STRTDT, --�Ի���                                                             \n");
sql.append("            A.ENDDT,  --�����                                                             \n");
sql.append("            A.DUYEAR,  --�ٹ���                                                            \n");
sql.append("            A.DUYMM,   --�ٹ���                                                            \n");
sql.append("            A.DUDAY,   --�ٹ���                                                            \n");
sql.append("            A.CADDR01,   --�ּ�                                                            \n");
sql.append("            C.APPYM,                                                                       \n");
sql.append("           (C.P10000+C.P11000+C.P12000) AS SUM_P1, --�⺻�޿�+��å����+�ð��ܼ��� ����     \n");
sql.append("           (C2.P10000+C2.P11000+C2.P12000) AS SUM_P2, --�⺻�޿�+��å����+�ð��ܼ��� ����  \n");
sql.append("           (C3.P10000+C3.P11000+C3.P12000) AS SUM_P3, --�⺻�޿�+��å����+�ð��ܼ��� ����  \n");
sql.append("           (C4.P10000+C4.P11000+C4.P12000) AS SUM_P4, --�⺻�޿�+��å����+�ð��ܼ��� ����  \n");
sql.append("            B.BUSPAY1, --�� 1����                                                        \n");
sql.append("            B.BUSPAY2, --�� 3����                                                        \n");
sql.append("            B.BUSPAY3, --�� 5����                                                        \n");
sql.append("            B.BUSPAY4, --�� 7����                                                        \n");
sql.append("            B.BUSPAY5, --�� 9����                                                        \n");
sql.append("            B.BUSPAY6, --�� 11����                                                       \n");
sql.append("            B.BUSPAY7, --�� 12����(200%)                                                 \n");
sql.append("            B.RETRAT,  --�ֱ�3�����޿�                                                     \n");
sql.append("            B.YEAPAY,  --��������                                                          \n");
sql.append("            B.MONAVG,  --��ձ޿�(�⺻�޿�+��å����+�ð��ܼ��� )                           \n");
sql.append("            B.MONBUS,  --��ջ�                                                          \n");
sql.append("            B.MONCOM,  --��ռ���                                                          \n");
sql.append("            C.P21000,  --�ټӼ���                                                          \n");
sql.append("            C.P22000,  --�ڱ��ߺ�                                                        \n");
sql.append("            C.P24000,  --����������                                                        \n");
sql.append("            C.P29000,  --���ϰ�������                                                      \n");
sql.append("            C.P38000,  --�ӿ���å����                                                      \n");
sql.append("            C2.P21000 AS P21000_2,  --�ټӼ���                                             \n");
sql.append("            C2.P22000 AS P22000_2,  --�ڱ��ߺ�                                           \n");
sql.append("            C2.P24000 AS P24000_2,  --����������                                           \n");
sql.append("            C2.P29000 AS P29000_2,  --���ϰ�������                                         \n");
sql.append("            C2.P38000 AS P38000_2,  --�ӿ���å����                                         \n");
sql.append("            C3.P21000 AS P21000_3,  --�ټӼ���                                             \n");
sql.append("            C3.P22000 AS P22000_3,  --�ڱ��ߺ�                                           \n");
sql.append("            C3.P24000 AS P24000_3,  --����������                                           \n");
sql.append("            C3.P29000 AS P29000_3,  --���ϰ�������                                         \n");
sql.append("            C3.P38000 AS P38000_3,  --�ӿ���å����                                         \n");
sql.append("            C4.P21000 AS P21000_4,  --�ټӼ���                                             \n");
sql.append("            C4.P22000 AS P22000_4,  --�ڱ��ߺ�                                           \n");
sql.append("            C4.P24000 AS P24000_4,  --����������                                           \n");
sql.append("            C4.P29000 AS P29000_4,  --���ϰ�������                                         \n");
sql.append("            C4.P38000 AS P38000_4,  --�ӿ���å����                                         \n");
sql.append("            (C.PX0010+C.PX0020+C.PX0030+C.PX0040) AS PX0010, --��Ÿ��                      \n");
sql.append("            (C2.PX0010+C2.PX0020+C2.PX0030+C2.PX0040) AS PX0020, --��Ÿ��                  \n");
sql.append("            (C3.PX0010+C3.PX0020+C3.PX0030+C3.PX0040) AS PX0030, --��Ÿ��                  \n");
sql.append("            (C4.PX0010+C4.PX0020+C4.PX0030+C4.PX0040) AS PX0040, --��Ÿ��                  \n");
sql.append("            D.S91000, --�����޿�                                                           \n");
sql.append("            B.RETPAY, --������                                                             \n");
sql.append("            D.T11000, --���ټ�                                                             \n");
sql.append("            D.T12000, --�ֹμ�                                                             \n");
sql.append("            D.B11000, --�ǰ������                                                         \n");
sql.append("            D.B12000, --���ο���                                                           \n");
sql.append("            D.B13000, --��뺸��                                                           \n");
sql.append("            COALESCE(D.T92000,0) AS T92000, --������ȯ��                                   \n");
sql.append("            D.BX0010, --��Ÿ����1                                                          \n");
sql.append("            D.BX0020, --��Ÿ����2                                                          \n");
sql.append("            D.BX0030, --��Ÿ����3                                                          \n");
sql.append("            D.BX0040  --��Ÿ����4                                                          \n");
sql.append("   FROM  PAYROLL.PRPAY B                                                                 \n");
sql.append("        LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=B.EMPNO                                       \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C ON A.EMPNO=C.EMPNO  AND C.APPYM=SUBSTR(A.ENDDT,1,6)   \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C2 ON A.EMPNO=C2.EMPNO                                       \n");
sql.append("        AND C2.APPYM=SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -1 MONTH),1,4) || \n");
sql.append("            SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -1 MONTH),6,2)      \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C3 ON A.EMPNO=C3.EMPNO                                       \n");
sql.append("        AND C3.APPYM=SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -2 MONTH),1,4) || \n");
sql.append("            SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -2 MONTH),6,2)      \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C4 ON A.EMPNO=C4.EMPNO                                       \n");
sql.append("        AND C4.APPYM=SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -3 MONTH),1,4) || \n");
sql.append("            SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -3 MONTH),6,2)      \n");
sql.append("        LEFT JOIN PAYROLL.PBPAY D ON A.EMPNO=D.EMPNO AND SUBSTR(A.ENDDT,1,6)=D.APPDT       \n");
sql.append("        LEFT JOIN PAYROLL.HCDEPT E  ON  A.DEPTCD = E.DEPTCD                                \n");
sql.append("        LEFT JOIN PAYROLL.HCLCODE F ON  A.PAYGRD = F.MINORCD  AND F.MAJORCD = '2002'       \n");
sql.append("  WHERE A.EMPNO <> ' '                                                                     \n");
if ( (!str[0].equals("")&&!str[0].equals("0")) && (!str[1].equals("")&&!str[1].equals("0")) )
	sql.append( " AND A.ENDDT BETWEEN  '"  + str[0] + "' AND  '"  + str[1] + "' ");    //�������
if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[2]+ "%' ");     //����

sql.append("          order by a.enddt desc, c.appym desc                                              \n");

					logger.err.println(this,sql.toString());
/*********************************************************************************************/
                     // System.out.println(sql);
						//logger.err.println(this,"1");
					stmt = conn.getGauceStatement(sql.toString());

	 		    stmt.executeQuery(dSet);
					//logger.err.println(this,"2");

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