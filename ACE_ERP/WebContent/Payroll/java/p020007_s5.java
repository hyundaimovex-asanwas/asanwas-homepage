package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class p020007_s5 extends HttpServlet {

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
	���� �������� �����Ͻ� �κ�-�޿�������Ȳ �󼼺�����
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//���޳��
				str[1]	= req.getParameter("v_str2");		//���޳������
				str[2]	= req.getParameter("v_str3");		//���ޱ���
				str[3]	= req.getParameter("v_str4");		//�μ�
				str[4]	= req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str6");		//����
				str[6]	= req.getParameter("v_str7");		//����






				for (int s=0;s<7;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"DEPTNM", // �μ���   
					"DCOUNTP", // ������ �ο���   
					"DP10000", // �⺻�޿�*/     
					"DP11000", // ��å���� */    
					"DP12000", // �ð��ܼ��� */  
					"DPXTOTAL", // ��Ÿ����4*/   
					"DS91000", // �����հ�*/     
					"DT11000", // �ҵ漼*/       
					"DT12000", // �ֹμ�*/       
					"DB11000", // �ǰ������*/   
					"DB12000", // ���ο���*/     
					"DBXTOTAL",                 
					"DS93000",// �����հ�*/      
					"DS94000",// �����޾�*/      
					"DCYYYYO", //������          
					"DCMMO",    //������         
					"DCOUNTR", //������ �ο���   
					"DP10000R", // �⺻�޿�*/    
					"DP11000R", // ��å���� */   
					"DP12000R", // �ð��ܼ��� */ 
					"DPXTOTALR", // ��Ÿ����4*/  
					"DS91000R", // �����հ�*/    
					"DT11000R", // �ҵ漼*/      
					"DT12000R", // �ֹμ�*/      
					"DB11000R", // �ǰ������*/  
					"DB12000R", // ���ο���*/    
					"DBXTOTALR",                
					"DS93000R", // �����հ�*/    
					"DS94000R", // �����޾�*/    
					"DCYYYY", //�����           
					"DCMM"    //�����           
				};

				int[] intArrCN = new int[]{  
					50, // �μ���   
					6, // ������ �ο���   
					9, // �⺻�޿�*/     
					9, // ��å���� */    
					9, // �ð��ܼ��� */  
					9, // ��Ÿ����4*/   
					9, // �����հ�*/     
					9, // �ҵ漼*/       
					9, // �ֹμ�*/       
					9, // �ǰ������*/   
					9, // ���ο���*/     
					9,                 
					9,// �����հ�*/      
					9,// �����޾�*/      
					4, //������          
					2,    //������         
					9, //������ �ο���   
					9, // �⺻�޿�*/    
					9, // ��å���� */   
					9, // �ð��ܼ��� */ 
					9, // ��Ÿ����4*/  
					9, // �����հ�*/    
					9, // �ҵ漼*/      
					9, // �ֹμ�*/      
					9, // �ǰ������*/  
					9, // ���ο���*/    
					9, //���� ��Ÿ�����հ�               
					9, // �����հ�*/    
					9, // �����޾�*/    
					4, //�����           
					2    //�����           
            	}; 

				int[] intArrCN2 = new int[]{
					-1, // �μ���   
					0, // ������ �ο���   
					0, // �⺻�޿�*/     
					0, // ��å���� */    
					0, // �ð��ܼ��� */  
					0, // ��Ÿ����4*/   
					0, // �����հ�*/     
					0, // �ҵ漼*/       
					0, // �ֹμ�*/       
					0, // �ǰ������*/   
					0, // ���ο���*/     
					0,                 
					0,// �����հ�*/      
					0,// �����޾�*/      
					-1, //������          
					-1,    //������         
					0, //������ �ο���   
					0, // �⺻�޿�*/    
					0, // ��å���� */   
					0, // �ð��ܼ��� */ 
					0, // ��Ÿ����4*/  
					0, // �����հ�*/    
					0, // �ҵ漼*/      
					0, // �ֹμ�*/      
					0, // �ǰ������*/  
					0, // ���ο���*/    
					0, //���� ��Ÿ�����հ�               
					0, // �����հ�*/    
					0, // �����޾�*/    
					-1, //�����           
					-1 //�����           
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT                                                 \n ");
					sql.append("  B.DEPTNM, --���غμ�                            \n ");
					sql.append("  COALESCE(A.COUNTP,0) AS DCOUNTP, --������ �ο���                             \n ");
					sql.append("  COALESCE(A.P10000,0) AS DP10000, -- �⺻�޿�*/                                \n ");
					sql.append("  COALESCE(A.P11000,0) AS DP11000, -- ��å���� */                               \n ");
					sql.append("  COALESCE(A.P12000,0) AS DP12000, -- �ð��ܼ��� */                             \n ");
					sql.append("  COALESCE(A.PXTOTAL,0) AS DPXTOTAL, -- ��Ÿ�����հ�*/                             \n ");
					sql.append("  COALESCE(A.S91000,0) AS DS91000, -- �����հ�*/                                \n ");
					sql.append("  COALESCE(A.T11000,0) AS DT11000, -- �ҵ漼*/                                 \n ");
					sql.append("  COALESCE(A.T12000,0) AS DT12000, -- �ֹμ�*/                                 \n ");
					sql.append("  COALESCE(A.B11000,0) AS DB11000, -- �ǰ������*/                             \n ");
					sql.append("  COALESCE(A.B12000,0) AS DB12000, -- ���ο���*/                               \n ");
					sql.append("  COALESCE(A.BXTOTAL,0) AS DBXTOTAL,                                           \n ");
					sql.append("  COALESCE(A.S93000,0) AS DS93000,-- �����հ�*/                                \n ");
					sql.append("  COALESCE(A.S94000,0) AS DS94000,-- �����޾�*/                                \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS DCYYYYO, --������                                    \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS DCMMO,    --������                                   \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS DCOUNTR, --������ �ο���                             \n ");
					sql.append("  COALESCE(B.P10000R,0) AS DP10000R, -- �⺻�޿�*/                               \n ");
					sql.append("  COALESCE(B.P11000R,0) AS DP11000R, -- ��å���� */                              \n ");
					sql.append("  COALESCE(B.P12000R,0) AS DP12000R, -- �ð��ܼ��� */                            \n ");
					sql.append("  COALESCE(B.PXTOTALR,0) AS DPXTOTALR, -- ��Ÿ����4*/                            \n ");
					sql.append("  COALESCE(B.S91000R,0) AS DS91000R, -- �����հ�*/                               \n ");
					sql.append("  COALESCE(B.T11000R,0) AS DT11000R, -- �ҵ漼*/                                \n ");
					sql.append("  COALESCE(B.T12000R,0) AS DT12000R, -- �ֹμ�*/                                \n ");
					sql.append("  COALESCE(B.B11000R,0) AS DB11000R, -- �ǰ������*/                            \n ");
					sql.append("  COALESCE(B.B12000R,0) AS DB12000R, -- ���ο���*/                              \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS DBXTOTALR,                                          \n ");
					sql.append("  COALESCE(B.S93000R,0) AS DS93000R, -- �����հ�*/                               \n ");
					sql.append("  COALESCE(B.S94000R,0) AS DS94000R, -- �����޾�*/                               \n ");
					sql.append("  '"+str[1].substring(0,4)+"' AS DCYYYY, --�����                                     \n ");
					sql.append("  '"+str[1].substring(4,6)+"' AS DCMM    --�����                                     \n ");
					sql.append("    FROM                                                \n ");
					sql.append(" (SELECT                                                \n ");
					sql.append("  C.TREECD,                             \n ");
					sql.append("  B.DEPTCD,                             \n ");
					sql.append("  RTRIM(C.DEPTNM) AS DEPTNM,                             \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTR,                             \n ");
					sql.append("  SUM(B.P10000) AS P10000R,-- �⺻�޿�*/                \n ");
					sql.append("  SUM(B.P11000) AS P11000R,-- ��å���� */               \n ");
					sql.append("  SUM(B.P12000) AS P12000R,-- �ð��ܼ��� */             \n ");
					sql.append("  (SUM(B.P21000)+               ");
					sql.append("  SUM(B.P22000)+                ");
					sql.append("  SUM(B.P23000)+                ");
					sql.append("  SUM(B.P24000)+                ");
					sql.append("  SUM(B.P25000)+                ");
					sql.append("  SUM(B.P26000)+                ");
					sql.append("  SUM(B.P27000)+                ");
					sql.append("  SUM(B.P28000)+                ");
					sql.append("  SUM(B.P29000)+                ");
					sql.append("  SUM(B.P30000)+                ");
					sql.append("  SUM(B.P31000)+                ");
					sql.append("  SUM(B.P32000)+                ");
					sql.append("  SUM(B.P33000)+                ");
					sql.append("  SUM(B.P34000)+                ");
					sql.append("  SUM(B.P36000)+                ");
					sql.append("  SUM(B.P37000)+                ");
					sql.append("  SUM(B.P38000)+                ");
					sql.append("  SUM(B.P39000)+                ");
					sql.append("  SUM(B.P35000)+                ");
					sql.append("  SUM(B.PX0010)+                ");
					sql.append("  SUM(B.PX0020)+                ");
					sql.append("  SUM(B.PX0030)+                ");
					sql.append("  SUM(B.PX0040)) AS PXTOTALR, -- ��Ÿ����4*/            \n ");
					sql.append("  SUM(B.S91000) AS S91000R, -- �����հ�*/               \n ");
					sql.append("  SUM(B.T11000) AS T11000R, -- �ҵ漼*/                 \n ");
					sql.append("  SUM(B.T12000) AS T12000R, -- �ֹμ�*/                 \n ");
					sql.append("  SUM(B.B11000) AS B11000R, -- �ǰ������*/             \n ");
					sql.append("  SUM(B.B12000) AS B12000R, -- ���ο���*/               \n ");
					sql.append("  (SUM(B.P41000)+ ");
					sql.append("  SUM(B.P42000)+ ");
					sql.append("  SUM(B.T21000)+ ");
					sql.append("  SUM(B.T22000)+ ");
					sql.append("  SUM(B.T23000)+ ");
					sql.append("  SUM(B.B13000)+ ");
					sql.append("  SUM(B.B14000)+ ");
					sql.append("  SUM(B.B15000)+ ");
					sql.append("  SUM(B.B16000)+ ");
					sql.append("  SUM(B.BX0010)+ ");
					sql.append("  SUM(B.BX0020)+ ");
					sql.append("  SUM(B.BX0030)+ ");
					sql.append("  SUM(B.BX0040)+ ");
					sql.append("  SUM(B.T31000)+ ");
					sql.append("  SUM(B.T33000)+ ");
					sql.append("  SUM(B.T92000)) ");
					sql.append("  AS BXTOTALR ,                                         \n ");
					sql.append("  SUM(B.S93000) AS S93000R, -- �����հ�*/                \n ");
					sql.append("  SUM(B.S94000) AS S94000R -- �����޾�*/                \n ");
					sql.append("  FROM PAYROLL.PBPAY B                                  \n ");
					sql.append("  LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append("  WHERE B.APPDT='"  + str[1] + "'                       \n ");
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' ");   //���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' "); //����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' "); // ����
					sql.append("  GROUP BY C.TREECD, B.DEPTCD, C.DEPTNM ");
					sql.append("  ORDER BY C.TREECD ) B            ");
					sql.append(" LEFT JOIN                                                       \n ");
					sql.append(" (SELECT                                                \n ");
					sql.append("  C.TREECD,                             \n ");
					sql.append("  B.DEPTCD,                             \n ");
					sql.append("  RTRIM(C.DEPTNM) AS DEPTNM,                             \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTP,                             \n ");
					sql.append("  SUM(B.P10000) AS P10000,-- �⺻�޿�*/                 \n ");
					sql.append("  SUM(B.P11000) AS P11000,-- ��å���� */                \n ");
					sql.append("  SUM(B.P12000) AS P12000,-- �ð��ܼ��� */              \n ");
					sql.append("  (SUM(B.P21000)+                  ");   // �ټӼ���*/      
					sql.append("  SUM(B.P22000)+                   ");	// �ڱ��ߺ� */    
					sql.append("  SUM(B.P23000)+                   ");	// �ξ簡������*/   
					sql.append("  SUM(B.P24000)+                   ");	// ���������� */    
					sql.append("  SUM(B.P25000)+                   ");	// �ⳳ����*/       
					sql.append("  SUM(B.P26000)+                   ");	// ��������*/       
					sql.append("  SUM(B.P27000)+                   ");	// �������*/       
					sql.append("  SUM(B.P28000)+                   ");	// �ڰݼ���*/       
					sql.append("  SUM(B.P29000)+                   ");	// ���ϰ�������*/   
					sql.append("  SUM(B.P30000)+                   ");	// ����ܼ���*/     
					sql.append("  SUM(B.P31000)+                   ");	// Ư��������*/     
					sql.append("  SUM(B.P32000)+                   ");	// �����ٹ�����*/   
					sql.append("  SUM(B.P33000)+                   ");	// ��������*/       
					sql.append("  SUM(B.P34000)+                   ");	// ��������*/       
					sql.append("  SUM(B.P36000)+                   ");	// �к�����*/     
					sql.append("  SUM(B.P37000)+                   ");	// ���ο��ݺ�����*/ 
					sql.append("  SUM(B.P38000)+                   ");	// �ӿ���å����*/   
					sql.append("  SUM(B.P39000)+                   ");	// �����ұ�*/       
					sql.append("  SUM(B.P35000)+                   ");	// �󿩱�*/         
					sql.append("  SUM(B.PX0010)+                   ");	// ��Ÿ����1*/      
					sql.append("  SUM(B.PX0020)+                   ");	// ��Ÿ����2*/      
					sql.append("  SUM(B.PX0030)+                   ");	// ��Ÿ����3*/      
					sql.append("  SUM(B.PX0040)) AS PXTOTAL, -- ��Ÿ�����հ�*/             \n ");
					sql.append("  SUM(B.S91000) AS S91000,   -- �����հ�*/                 \n ");
					sql.append("  SUM(B.T11000) AS T11000,   -- �ҵ漼*/                  \n ");
					sql.append("  SUM(B.T12000) AS T12000,  -- �ֹμ�*/                  \n ");
					sql.append("  SUM(B.B11000) AS B11000,  -- �ǰ������*/              \n ");
					sql.append("  SUM(B.B12000) AS B12000,  -- ���ο���*/                \n ");
					sql.append("  (SUM(B.P41000)+                     ");  // ����ǰ�����*
					sql.append("  SUM(B.P42000)+                       "); // ������뺸��*/
					sql.append("  SUM(B.T21000)+                       "); // ����ҵ漼*/  
					sql.append("  SUM(B.T22000)+                       "); // �����ֹμ�*/  
					sql.append("  SUM(B.T23000)+                       "); // �����Ư��*/  
					sql.append("  SUM(B.B13000)+                       "); // ���뺸��*/    
					sql.append("  SUM(B.B14000)+                       "); // ������ȸ��*/  
					sql.append("  SUM(B.B15000)+                       "); // ���ο���*/    
					sql.append("  SUM(B.B16000)+                       "); // ����ȸ��*/    
					sql.append("  SUM(B.BX0010)+                       "); // ��Ÿ����1*/   
					sql.append("  SUM(B.BX0020)+                       "); // ��Ÿ����2*/   
					sql.append("  SUM(B.BX0030)+                       "); // ��Ÿ����3*/   
					sql.append("  SUM(B.BX0040)+                       "); // ��Ÿ����4*/   
					sql.append("  SUM(B.T31000)+                       "); // ��¡�ҵ漼*/  
					sql.append("  SUM(B.T33000)+                       "); // ��¡�ֹμ�*/  
					sql.append("  SUM(B.T92000))                       "); // ������ȯ��*/  
					sql.append("  AS BXTOTAL ,                                          \n ");
					sql.append("  SUM(B.S93000) AS S93000, -- �����հ�*/                 \n ");
					sql.append("  SUM(B.S94000) AS S94000 -- �����޾�*/                 \n ");
					sql.append("  FROM PAYROLL.PBPAY B                                  \n ");
					sql.append("  LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD ");
					sql.append("  WHERE B.APPDT='"  + str[0] + "'                       \n ");
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' \n ");   //���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' \n ");    //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' \n ");  //����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' \n "); //����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' \n "); // ����
					sql.append("  GROUP BY C.TREECD, B.DEPTCD, C.DEPTNM ");
					sql.append("   ORDER BY C.TREECD) A                                                  \n ");

					sql.append("  ON A.TREECD=B.TREECD         ");
					sql.append("  ORDER BY A.TREECD        ");
					
					//logger.err.println(this,sql.toString());
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