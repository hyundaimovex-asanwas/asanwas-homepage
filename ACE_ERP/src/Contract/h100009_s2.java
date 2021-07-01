package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class h100009_s2 extends HttpServlet {

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
	���� �������� �����Ͻ� �κ�-�޿�������Ȳ ���ο�����(Fheader �κ�)
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
				str[7]	= req.getParameter("v_str8");		//����

				for (int s=0;s<8;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"COUNTP", // ������ �ο���   
					"P10000", // �⺻�޿�*/     
					"P11000", // ��å���� */
					"P30000", /* ����ܼ���-�������*/
					"P31000", /* Ư�������� - �����ٹ�����*/
					"P12000", // �ð��ܼ��� */  
					"PXTOTAL",// ��Ÿ����4*/   
					"S91000", // �����հ�*/     
					"T11000", // �ҵ漼*/       
					"T12000", // �ֹμ�*/       
					"B11000", // �ǰ������*/   
					"B12000", // ���ο���*/     
					"BXTOTAL",                 
					"S93000",// �����հ�*/      
					"S94000",// �����޾�*/
					"B13000",
					"B23000",
					"B17000",
					"B23170",
					"CYYYYO", //������          
					"CMMO",    //������         
					"COUNTR", //������ �ο���   
					"P10000R", // �⺻�޿�*/    
					"P11000R", // ��å���� */  
					"P30000R", /* ����ܼ���-�������*/         
					"P31000R", /* Ư�������� - �����ٹ�����*/   
					"P12000R", // �ð��ܼ��� */ 
					"PXTOTALR", // ��Ÿ����4*/  
					"S91000R", // �����հ�*/    
					"T11000R", // �ҵ漼*/      
					"T12000R", // �ֹμ�*/      
					"B11000R", // �ǰ������*/  
					"B12000R", // ���ο���*/    
					"BXTOTALR",                
					"S93000R", // �����հ�*/    
					"S94000R", // �����޾�*/  
					"B13000R",
					"B23000R",
					"B17000R",
					"B23170R",
					"CYYYY",   //�����           
					"CMM",     //�����           
					"TODATEE",  //���ó�¥    
					"CTITLE"   //���� 
				};

				int[] intArrCN = new int[]{  
					6, // ������ �ο���   
					9, // �⺻�޿�*/     
					9, // ��å���� */
					9,/* ����ܼ���-�������*/       
					9,/* Ư�������� - �����ٹ�����*/ 
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
					9,9,9,9,
					4, //������          
					2,    //������         
					9, //������ �ο���   
					9, // �⺻�޿�*/    
					9, // ��å���� */
					9,/* ����ܼ���-�������*/         
					9,/* Ư�������� - �����ٹ�����*/   
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
					9,9,9,9,
					4, //�����           
					2,    //�����           
					8,    //���ó�¥   
					20  
            	}; 

				int[] intArrCN2 = new int[]{
					0, // ������ �ο���   
					0, // �⺻�޿�*/     
					0, // ��å���� */ 
					0,/* ����ܼ���-�������*/       
					0,/* Ư�������� - �����ٹ�����*/ 
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
					0,0,0,0,
					-1, //������          
					-1,    //������         
					0, //������ �ο���   
					0, // �⺻�޿�*/    
					0, // ��å���� */
					0, /* ����ܼ���-�������*/         
					0, /* Ư�������� - �����ٹ�����*/   
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
					0,0,0,0,
					-1, //�����           
					-1, //�����           
					-1, //���ó�¥  
					-1  //����
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();	/*REPORT 1.���ο�*/
					sql.append(" SELECT  \n ");
					sql.append("  COALESCE(A.COUNTP,0) AS COUNTP, --������ �ο���*/                            \n ");
					sql.append("  COALESCE(A.P10000,0) AS P10000, -- �⺻�޿�*/                                \n ");
					sql.append("  COALESCE(A.P11000,0) AS P11000, -- ��å���� */                               \n ");
					sql.append("  COALESCE(A.P30000,0) AS P30000, -- /* ����ܼ���-�������*/                  \n ");
					sql.append("  COALESCE(A.P31000,0) AS P31000, -- /* Ư�������� - �����ٹ�����*/            \n ");
					sql.append("  COALESCE(A.P12000,0) AS P12000, -- �ð��ܼ��� */                             \n ");
					sql.append("  COALESCE(A.PXTOTAL,0) AS PXTOTAL, -- ��Ÿ�����հ�*/                          \n ");
					sql.append("  COALESCE(A.S91000,0) AS S91000, -- �����հ�*/                                \n ");
					sql.append("  COALESCE(A.T11000,0) AS T11000, -- �ҵ漼*/                                  \n ");
					sql.append("  COALESCE(A.T12000,0) AS T12000, -- �ֹμ�*/                                  \n ");
					sql.append("  COALESCE(A.B11000,0) AS B11000, -- �ǰ������*/                              \n ");
					sql.append("  COALESCE(A.B12000,0) AS B12000, -- ���ο���*/                                \n ");
					sql.append("  COALESCE(A.BXTOTAL,0) AS BXTOTAL,                                            \n ");
					sql.append("  COALESCE(A.S93000,0) AS S93000,-- �����հ�*/                                 \n ");
					sql.append("  COALESCE(A.S94000,0) AS S94000,-- �����޾�*/                                 \n ");
					sql.append("  COALESCE(A.B13000,0) AS B13000,-- ��뺸��*/                                 \n ");
					sql.append("  COALESCE(A.B23000,0) AS B23000,-- ȸ��������뺸��*/                         \n ");
					sql.append("  COALESCE(A.B17000,0) AS B17000,-- ���纸��*/                                 \n ");
					sql.append("  COALESCE(A.B23170,0) AS B23170,-- ȸ������ ���+����*/                       \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS CYYYYO, --������ */													 \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS CMMO,    --������ */													 \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS COUNTR, --������ �ο��� */													 \n ");
					sql.append("  COALESCE(B.P10000R,0) AS P10000R, -- �⺻�޿�*/                              \n ");
					sql.append("  COALESCE(B.P11000R,0) AS P11000R, -- ��å���� */                             \n ");
					sql.append("  COALESCE(B.P30000R,0) AS P30000R, -- /* ����ܼ���-�������*/                \n ");
					sql.append("  COALESCE(B.P31000R,0) AS P31000R , -- /* Ư�������� - �����ٹ�����*/         \n ");
					sql.append("  COALESCE(B.P12000R,0) AS P12000R, -- �ð��ܼ��� */                           \n ");
					sql.append("  COALESCE(B.PXTOTALR,0) AS PXTOTALR, -- ��Ÿ����4*/                           \n ");
					sql.append("  COALESCE(B.S91000R,0) AS S91000R, -- �����հ�*/                              \n ");
					sql.append("  COALESCE(B.T11000R,0) AS T11000R, -- �ҵ漼*/                                \n ");
					sql.append("  COALESCE(B.T12000R,0) AS T12000R, -- �ֹμ�*/                                \n ");
					sql.append("  COALESCE(B.B11000R,0) AS B11000R, -- �ǰ������*/                            \n ");
					sql.append("  COALESCE(B.B12000R,0) AS B12000R, -- ���ο���*/                              \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS BXTOTALR,                                          \n ");
					sql.append("  COALESCE(B.S93000R,0) AS S93000R, -- �����հ�*/                              \n ");
					sql.append("  COALESCE(B.S94000R,0) AS S94000R, -- �����޾�*/                              \n ");
          sql.append("  COALESCE(B.B13000R,0) AS B13000R, -- ��뺸��*/                              \n ");
					sql.append("  COALESCE(B.B23000R,0) AS B23000R, -- ȸ������ ��뺸��*/                     \n ");
					sql.append("  COALESCE(B.B17000R,0) AS B17000R, -- ���纸��*/                              \n ");
					sql.append("  COALESCE(B.B23170R,0) AS B23170R, -- ȸ������ ���+����*/                    \n ");
					sql.append("  '"+str[1].substring(0,4)+"' AS CYYYY, --����� */                            \n ");
					sql.append("  '"+str[1].substring(4,6)+"' AS CMM,   --����� */                            \n ");
					sql.append("  RTRIM('" + str[7] + "') AS TODATEE,    --���ó�¥*/													 \n ");
          sql.append("  ''  CTITLE    --����*/																											 \n ");
					sql.append("  FROM   																																			 \n ");
					sql.append(" (SELECT																																			 \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTR,																										 \n ");
					sql.append("  SUM(B.P10000) AS P10000R,-- �⺻�޿�*/																			 \n ");
					sql.append("  SUM(B.P11000) AS P11000R,-- ��å���� */																			 \n ");
					sql.append("  SUM(B.P30000) AS P30000R,-- /* ����ܼ���-�������*/											   \n ");
					sql.append("  SUM(B.P31000) AS P31000R,-- /* Ư�������� - �����ٹ�����*/									 \n ");
					sql.append("  SUM(B.P12000) AS P12000R,-- �ð��ܼ��� */																		 \n ");
					sql.append("  (SUM(B.P21000)+																															 \n ");
					sql.append("  SUM(B.P22000)+																															 \n ");
					sql.append("  SUM(B.P23000)+																															 \n ");
					sql.append("  SUM(B.P24000)+																															 \n ");
					sql.append("  SUM(B.P25000)+																															 \n ");
					sql.append("  SUM(B.P26000)+																															 \n ");
					sql.append("  SUM(B.P27000)+																															 \n ");
					sql.append("  SUM(B.P28000)+																															 \n ");
					sql.append("  SUM(B.P29000)+																															 \n ");
					sql.append("  SUM(B.P32000)+																															 \n ");
					sql.append("  SUM(B.P33000)+																															 \n ");
					sql.append("  SUM(B.P34000)+																															 \n ");
					sql.append("  SUM(B.P36000)+																															 \n ");
					sql.append("  SUM(B.P37000)+																															 \n ");
					sql.append("  SUM(B.P38000)+																															 \n ");
					sql.append("  SUM(B.P39000)+																															 \n ");
					sql.append("  SUM(B.P35000)+																											    		 \n ");
					sql.append("  SUM(B.PX0010)+																															 \n ");
					sql.append("  SUM(B.PX0020)+																															 \n ");
					sql.append("  SUM(B.PX0030)+																															 \n ");
					sql.append("  SUM(B.PX0040)) AS PXTOTALR, -- ��Ÿ����4*/																	 \n ");			
					sql.append("  SUM(B.S91000) AS S91000R, -- �����հ�*/																			 \n ");			
					sql.append("  SUM(B.T11000) AS T11000R, -- �ҵ漼*/																				 \n ");			
					sql.append("  SUM(B.T12000) AS T12000R, -- �ֹμ�*/																				 \n ");			
					sql.append("  SUM(B.B11000) AS B11000R, -- �ǰ������*/																		 \n ");			
					sql.append("  SUM(B.B12000) AS B12000R, -- ���ο���*/																			 \n ");			
					sql.append("  (SUM(B.P41000)+																															 \n ");
					sql.append("  SUM(B.P42000)+																															 \n ");
					sql.append("  SUM(B.T21000)+																															 \n ");
					sql.append("  SUM(B.T22000)+																															 \n ");
					sql.append("  SUM(B.T23000)+																															 \n ");
					sql.append("  SUM(B.B14000)+																															 \n ");
					sql.append("  SUM(B.B15000)+																															 \n ");
					sql.append("  SUM(B.B16000)+																															 \n ");
					sql.append("  SUM(B.BX0010)+																															 \n ");
					sql.append("  SUM(B.BX0020)+																															 \n ");
					sql.append("  SUM(B.BX0030)+																															 \n ");
					sql.append("  SUM(B.BX0040)+																															 \n ");
					sql.append("  SUM(B.APLAMT)+																															 \n ");
					sql.append("  SUM(B.APLRAT)+SUM(B.COAAMT)+SUM(B.COLAMT))																	 \n ");
					sql.append("  AS BXTOTALR ,																																 \n ");
					sql.append("  SUM(B.S93000) AS S93000R, -- �����հ�*/																			 \n ");
					sql.append("  SUM(B.S94000) AS S94000R, -- �����޾�*/																			 \n ");
					sql.append("  SUM(B.B13000) AS B13000R, -- ��뺸��*/																			 \n ");
					sql.append("  SUM(B.B23000) AS B23000R, -- ��� ȸ������*/ 																 \n ");
					sql.append("  SUM(B.B17000) AS B17000R, -- ���� ȸ������*/	  														 \n ");
					sql.append("  SUM(B.B23000)+ SUM(B.B17000) AS B23170R	-- ���+���� ȸ������*/  						 \n ");
					sql.append("  FROM PAYROLL.PBPAY B																												 \n ");
					sql.append("  WHERE B.APPDT='"  + str[1] + "'																							 \n ");

					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN ('1','3','4') \n ");   //���ޱ���
          if (str[2].equals("5"))	sql.append( " AND B.PAYDIV IN ('5') \n ");   //���ޱ���
          if (str[2].equals("T")) sql.append( " AND B.PAYDIV IN ('T') \n ");   //���ޱ���	
					if (str[2].equals("K")) sql.append( " AND B.PAYDIV IN ('K') \n ");   //���ޱ���	

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3] + "' \n ");   //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '" + str[4] + "' \n ");		//����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' \n ");		//����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6] + "' \n ");		// ����
					sql.append("  GROUP BY B.APPDT																														 \n ");
					sql.append("  ) B																																					 \n ");
					sql.append(" LEFT JOIN (SELECT																														 \n ");
					sql.append("  B.APPDT,																																		 \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTP,																										 \n ");
					sql.append("  SUM(B.P10000) AS P10000,-- �⺻�޿�*/																				 \n ");
					sql.append("  SUM(B.P11000) AS P11000,-- ��å���� */																			 \n ");
					sql.append("  SUM(B.P30000) AS P30000,/* ����ܼ���-�������*/														 \n ");
					sql.append("  SUM(B.P31000) AS P31000,/* Ư�������� - �����ٹ�����*/											 \n ");
					sql.append("  SUM(B.P12000) AS P12000,-- �ð��ܼ��� */																		 \n ");
					sql.append("  (SUM(B.P21000)+					--�ټӼ���*/																				 \n "); 
					sql.append("  SUM(B.P22000)+					--�ڱ��ߺ� */																			 \n ");	 
					sql.append("  SUM(B.P23000)+					--�ξ簡������*/																		 \n ");	 
					sql.append("  SUM(B.P24000)+					--���������� */																			 \n ");	 
					sql.append("  SUM(B.P25000)+					--�ⳳ����*/																				 \n ");	 
					sql.append("  SUM(B.P26000)+					--��������*/																				 \n ");	 
					sql.append("  SUM(B.P27000)+					--�������*/																				 \n ");	 
					sql.append("  SUM(B.P28000)+					--�ڰݼ���*/																				 \n ");	 
					sql.append("  SUM(B.P29000)+					--���ϰ�������*/																		 \n ");
					sql.append("  SUM(B.P32000)+					--�����ٹ�����*/																		 \n ");	 
					sql.append("  SUM(B.P33000)+					--��������*/																				 \n ");	 
					sql.append("  SUM(B.P34000)+					--��������*/																				 \n ");	 
					sql.append("  SUM(B.P36000)+					--�к�����*/																			 \n ");	 
					sql.append("  SUM(B.P37000)+					--���ο��ݺ�����*/																	 \n ");	 
					sql.append("  SUM(B.P38000)+					--�ӿ���å����*/																		 \n ");	 
					sql.append("  SUM(B.P39000)+					--�����ұ�*/																				 \n ");	 
					sql.append("  SUM(B.P35000)+    			--�Ĵ�*/																					   \n ");	 
					sql.append("  SUM(B.PX0010)+					--��Ÿ����1*/																				 \n ");	 
					sql.append("  SUM(B.PX0020)+					--��Ÿ����2*/																				 \n ");	 
					sql.append("  SUM(B.PX0030)+					--��Ÿ����3*/																				 \n ");	 
					sql.append("  SUM(B.PX0040)) AS PXTOTAL, -- ��Ÿ�����հ�*/																 \n ");
					sql.append("  SUM(B.S91000) AS S91000,   -- �����հ�*/																		 \n ");
					sql.append("  SUM(B.T11000) AS T11000,   -- �ҵ漼*/																			 \n ");
					sql.append("  SUM(B.T12000) AS T12000,   -- �ֹμ�*/																			 \n ");
					sql.append("  SUM(B.B11000) AS B11000,   -- �ǰ������*/																	 \n ");
					sql.append("  SUM(B.B12000) AS B12000,   -- ���ο���*/																		 \n ");
					sql.append("  (SUM(B.P41000)+         --����ǰ�����*																			 \n ");  
					sql.append("  SUM(B.P42000)+          --�����뺸��*/																		 \n "); 
					sql.append("  SUM(B.T21000)+          --����ҵ漼*/																			 \n "); 
					sql.append("  SUM(B.T22000)+          --�����ֹμ�*/																			 \n "); 
					sql.append("  SUM(B.T23000)+          --�����Ư��*/																			 \n "); 
					sql.append("  SUM(B.B14000)+          --������ȸ��*/																			 \n "); 
					sql.append("  SUM(B.B15000)+          --���ο���*/																			   \n "); 
					sql.append("  SUM(B.B16000)+          --����ȸ��*/																				 \n "); 
					sql.append("  SUM(B.BX0010)+          --��Ÿ����1*/																				 \n "); 
					sql.append("  SUM(B.BX0020)+          --��Ÿ����2*/																				 \n "); 
					sql.append("  SUM(B.BX0030)+          --��Ÿ����3*/																				 \n "); 
					sql.append("  SUM(B.BX0040)+																															 \n ");
					sql.append("  SUM(B.APLAMT)+																															 \n ");
					sql.append("  SUM(B.APLRAT)+SUM(B.COAAMT)+SUM(B.COLAMT))																	 \n ");
					sql.append("  AS BXTOTAL,																																	 \n ");
					sql.append("  SUM(B.S93000) AS S93000,-- �����հ�*/																				 \n ");
					sql.append("  SUM(B.S94000) AS S94000,-- �����޾�*/																				 \n ");
          sql.append("  SUM(B.B13000) AS B13000,-- ��뺸��*/																				 \n ");
					sql.append("  SUM(B.B23000) AS B23000,-- ��� ȸ������*/																	 \n ");
					sql.append("  SUM(B.B17000) AS B17000,-- ���� ȸ������*/																   \n ");
					sql.append("  SUM(B.B23000)+ SUM(B.B17000) AS B23170 	-- ���+���� ȸ������*/							 \n ");
					sql.append("  FROM PAYROLL.PBPAY B																												 \n ");
					sql.append("  WHERE B.APPDT='"  + str[0] + "'																							 \n ");
					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN ('1','3','4') \n ");   //���ޱ���
					if (str[2].equals("5")) sql.append( " AND B.PAYDIV IN ('5') \n ");   //���ޱ���
          if (str[2].equals("T")) sql.append( " AND B.PAYDIV IN ('T') \n ");   //���ޱ���	
          if (str[2].equals("K")) sql.append( " AND B.PAYDIV IN ('K') \n ");   //���ޱ���	
					
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3] + "' \n ");   //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '" + str[4] + "' \n ");   //�����ڵ�
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' \n ");		//�����ڵ�
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6] + "' \n ");		//�����ڵ�
					sql.append("  GROUP BY B.APPDT																														 \n ");
					sql.append("  ) A ON  A.APPDT='"  + str[0] + "'																						 \n ");

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