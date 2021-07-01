package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class p020007_s63 extends HttpServlet {

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
	���� �������� �����Ͻ� �κ�-�޿�������Ȳ �󼼺���
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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"SEQ", // �ٹ�������   
          "MINORCD", // �ٹ����ڵ�   
          "DEPTNM", // �ٹ�����   
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
					"DB13000","DB23000","DB17000","DB23170",
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
					"DB13000R","DB23000R","DB17000R","DB23170R",
					"DCYYYY", //�����           
					"DCMM"    //�����           
				};

				int[] intArrCN = new int[]{  
					3, // �ٹ�������   
          4, // �ٹ����ڵ�   
					30, // �ٹ�����   
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
					9,9,9,9,
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
					9,9,9,9,
					4, //�����           
					2    //�����           
          }; 

				int[] intArrCN2 = new int[]{
					0, // �ٹ�������   
					-1, // �ٹ����ڵ� 
					-1, // �ٹ����� 
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
					0,0,0,0,
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
					0,0,0,0,
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
					StringBuffer sql = new StringBuffer();		/*3.�׿� ����*/
					sql.append(" SELECT																																				 \n ");
					sql.append("  B.SEQ, B.MINORCD, B.DEPTNM,																									 \n ");
					sql.append("  COALESCE(A.COUNTP,0) AS DCOUNTP, -- ������ �ο���                            \n ");
					sql.append("  COALESCE(A.P10000,0) AS DP10000, -- �⺻�޿�*/                               \n ");
					sql.append("  COALESCE(A.P11000,0) AS DP11000, -- ��å���� */                              \n ");
					sql.append("  COALESCE(A.P12000,0) AS DP12000, -- �ð��ܼ��� */                            \n ");
					sql.append("  COALESCE(A.PXTOTAL,0) AS DPXTOTAL, -- ��Ÿ�����հ�*/                         \n ");
					sql.append("  COALESCE(A.S91000,0) AS DS91000, -- �����հ�*/                               \n ");
					sql.append("  COALESCE(A.T11000,0) AS DT11000, -- �ҵ漼*/                                 \n ");
					sql.append("  COALESCE(A.T12000,0) AS DT12000, -- �ֹμ�*/                                 \n ");
					sql.append("  COALESCE(A.B11000,0) AS DB11000, -- �ǰ������*/                             \n ");
					sql.append("  COALESCE(A.B12000,0) AS DB12000, -- ���ο���*/                               \n ");
					sql.append("  COALESCE(A.BXTOTAL,0) AS DBXTOTAL,                                           \n ");
					sql.append("  COALESCE(A.S93000,0) AS DS93000,-- �����հ�*/                                \n ");
					sql.append("  COALESCE(A.S94000,0) AS DS94000,-- �����޾�*/                                \n ");
					sql.append("  COALESCE(A.B13000,0) AS DB13000,-- ��뺸��*/                                \n ");
					sql.append("  COALESCE(A.B23000,0) AS DB23000,-- ȸ��������뺸��*/                        \n ");
					sql.append("  COALESCE(A.B17000,0) AS DB17000,-- ���纸��*/                                \n ");
					sql.append("  COALESCE(A.B23170,0) AS DB23170,-- ȸ���������+����*/                       \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS DCYYYYO, --������                             \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS DCMMO,    --������                            \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS DCOUNTR, --������ �ο���                             \n ");
					sql.append("  COALESCE(B.P10000R,0) AS DP10000R, -- �⺻�޿�*/                             \n ");
					sql.append("  COALESCE(B.P11000R,0) AS DP11000R, -- ��å���� */                            \n ");
					sql.append("  COALESCE(B.P12000R,0) AS DP12000R, -- �ð��ܼ��� */                          \n ");
					sql.append("  COALESCE(B.PXTOTALR,0) AS DPXTOTALR, -- ��Ÿ����4*/                          \n ");
					sql.append("  COALESCE(B.S91000R,0) AS DS91000R, -- �����հ�*/                             \n ");
					sql.append("  COALESCE(B.T11000R,0) AS DT11000R, -- �ҵ漼*/                               \n ");
					sql.append("  COALESCE(B.T12000R,0) AS DT12000R, -- �ֹμ�*/                               \n ");
					sql.append("  COALESCE(B.B11000R,0) AS DB11000R, -- �ǰ������*/                           \n ");
					sql.append("  COALESCE(B.B12000R,0) AS DB12000R, -- ���ο���*/                             \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS DBXTOTALR,                                         \n ");
					sql.append("  COALESCE(B.S93000R,0) AS DS93000R, -- �����հ�*/                             \n ");
					sql.append("  COALESCE(B.S94000R,0) AS DS94000R, -- �����޾�*/                             \n ");
					sql.append("  COALESCE(B.B13000R,0) AS DB13000R,                                           \n ");
					sql.append("  COALESCE(B.B23000R,0) AS DB23000R,                                           \n ");
					sql.append("  COALESCE(B.B17000R,0) AS DB17000R,                                           \n ");
					sql.append("  COALESCE(B.B23170R,0) AS DB23170R,                                           \n ");
					sql.append("  '"+str[1].substring(0,4)+"' AS DCYYYY, --�����                              \n ");
					sql.append("  '"+str[1].substring(4,6)+"' AS DCMM    --�����                              \n ");
					sql.append("    FROM																																			 \n ");
					sql.append("  ( \n ");
					sql.append("  -- ����                                                                                      \n ");
					sql.append("  SELECT                                                                                       \n ");
					sql.append("     B.PRTSEQ AS SEQ,                                                                          \n ");
 					sql.append("	  (CASE WHEN B.PRTCOD='' THEN 'XXX' ELSE B.PRTCOD END) AS MINORCD,                         	 \n ");
					sql.append("	  (CASE WHEN B.PRTDEPTNM=''THEN 'XXXX' ELSE B.PRTDEPTNM END) AS DEPTNM,                   	 \n ");
					sql.append("     COUNT(B.EMPNO) AS COUNTR,                                                                 \n ");
					sql.append("     SUM(B.P10000) AS P10000R, SUM(B.P11000) AS P11000R, SUM(B.P12000) AS P12000R,             \n ");
					sql.append("    (SUM(B.P21000)+ SUM(B.P22000)+ SUM(B.P23000)+ SUM(B.P24000)+  SUM(B.P25000)+               \n ");
					sql.append("     SUM(B.P26000)+ SUM(B.P27000)+ SUM(B.P28000)+ SUM(B.P29000)+  SUM(B.P30000)+               \n ");
					sql.append("     SUM(B.P31000)+ SUM(B.P32000)+ SUM(B.P33000)+ SUM(B.P34000)+  SUM(B.P36000)+               \n ");
					sql.append("     SUM(B.P37000)+ SUM(B.P38000)+ SUM(B.P39000)+ SUM(B.P35000)+  SUM(B.PX0010)+               \n ");
					sql.append("     SUM(B.PX0020)+ SUM(B.PX0030)+ SUM(B.PX0040)) AS PXTOTALR, -- ��Ÿ����4*/                  \n ");
					sql.append("     SUM(B.S91000) AS S91000R,  SUM(B.T11000) AS T11000R, SUM(B.T12000) AS T12000R,            \n ");
					sql.append("     SUM(B.B11000) AS B11000R,  SUM(B.B12000) AS B12000R,                                      \n ");
					sql.append("    (SUM(B.P41000)+ SUM(B.P42000)+ SUM(B.T21000)+ SUM(B.T22000)+ SUM(B.T23000)+                \n ");
					sql.append("     SUM(B.B14000)+ SUM(B.B15000)+ SUM(B.B16000)+ SUM(B.BX0010)+                               \n ");
					sql.append("     SUM(B.BX0020)+ SUM(B.BX0030)+ SUM(B.BX0040)+ SUM(B.APLAMT)+ SUM(B.APLRAT)+                \n ");
					sql.append("     SUM(B.COAAMT)+ SUM(B.COLAMT)) AS BXTOTALR ,                                               \n ");
					sql.append("     SUM(B.S93000) AS S93000R, -- �����հ�*/                                                   \n ");
					sql.append("     SUM(B.S94000) AS S94000R, -- �����޾�*/                                                   \n ");
					sql.append("     SUM(B.B13000) AS B13000R,		                                                             \n ");
					sql.append("     SUM(B.B23000) AS B23000R,                                                                 \n ");
					sql.append("     SUM(B.B17000) AS B17000R,                                                                 \n ");
					sql.append("     SUM(B.B23000)+ SUM(B.B17000) AS B23170R                                                   \n ");
					sql.append("    FROM PAYROLL.PBPAY B                                                                       \n ");
					sql.append("   WHERE B.APPDT='"  + str[1] + "'                                                             \n ");
					sql.append("     AND (B.PRTCOD<>'01' )                                                                     \n ");
					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN( '1','3','4') "); //���ޱ���
					if (str[2].equals("5")) sql.append( " AND B.PAYDIV IN( '5') ");					//���ޱ���
	        if (str[2].equals("6")) sql.append( " AND B.PAYDIV IN( '6') ");					//���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD  = '" + str[3] + "' \n ");	//�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH = '" + str[4] + "' \n ");  //����
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD  = '" + str[5] + "' \n ");	//����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV  = '" + str[6] + "' \n ");	//����			 
					sql.append("   GROUP BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   ORDER BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   )B                                                                                          \n ");
					sql.append("    LEFT JOIN                                                                                  \n ");
					sql.append("  (                                                                                            \n ");
					sql.append("   --����                                                                                      \n ");
					sql.append("   SELECT                                                                                      \n ");
					sql.append("     B.PRTSEQ AS SEQ,                                                                          \n ");
					sql.append("	  (CASE WHEN B.PRTCOD='' THEN 'XXX' ELSE B.PRTCOD END) AS MINORCD,                         	 \n ");
					sql.append("	  (CASE WHEN B.PRTDEPTNM=''THEN 'XXXX' ELSE B.PRTDEPTNM END) AS DEPTNM,                   	 \n ");
  				sql.append("     COUNT(B.EMPNO) AS COUNTP,                                                                 \n ");
					sql.append("     SUM(B.P10000) AS P10000,SUM(B.P11000) AS P11000,SUM(B.P12000) AS P12000,                  \n ");
					sql.append("    (SUM(B.P21000)+ SUM(B.P22000)+ SUM(B.P23000)+ SUM(B.P24000)+ SUM(B.P25000)+                \n ");
					sql.append("     SUM(B.P26000)+ SUM(B.P27000)+ SUM(B.P28000)+ SUM(B.P29000)+ SUM(B.P30000)+                \n ");
					sql.append("     SUM(B.P31000)+ SUM(B.P32000)+ SUM(B.P33000)+ SUM(B.P34000)+ SUM(B.P36000)+                \n ");
					sql.append("     SUM(B.P37000)+ SUM(B.P38000)+ SUM(B.P39000)+ SUM(B.P35000)+ SUM(B.PX0010)+                \n ");
					sql.append("     SUM(B.PX0020)+ SUM(B.PX0030)+ SUM(B.PX0040)) AS PXTOTAL,                                  \n ");
					sql.append("     SUM(B.S91000) AS S91000, SUM(B.T11000) AS T11000, SUM(B.T12000) AS T12000,                \n ");
					sql.append("     SUM(B.B11000) AS B11000, SUM(B.B12000) AS B12000,                                         \n ");
					sql.append("    (SUM(B.P41000)+ SUM(B.P42000)+ SUM(B.T21000)+ SUM(B.T22000)+ SUM(B.T23000)+                \n ");
					sql.append("     SUM(B.B14000)+ SUM(B.B15000)+ SUM(B.B16000)+ SUM(B.BX0010)+                               \n ");
					sql.append("     SUM(B.BX0020)+ SUM(B.BX0030)+ SUM(B.BX0040)+ SUM(B.APLAMT)+ SUM(B.APLRAT)+                \n ");
					sql.append("     SUM(B.COAAMT)+ SUM(B.COLAMT)) AS BXTOTAL ,                                                \n ");
					sql.append("     SUM(B.S93000) AS S93000, SUM(B.S94000) AS S94000,                                         \n ");
          sql.append("     SUM(B.B13000) AS B13000,		                                                     \n ");
          sql.append("     SUM(B.B23000) AS B23000,                                                        \n ");
          sql.append("     SUM(B.B17000) AS B17000,                                                        \n ");
          sql.append("     SUM(B.B23000)+ SUM(B.B17000) AS B23170                                          \n ");
					sql.append("    FROM PAYROLL.PBPAY B                                                                       \n ");
					sql.append("   WHERE B.APPDT='"  + str[0] + "'                                                             \n ");
					sql.append("     AND (B.PRTCOD<>'01' )                                                    \n ");
					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN( '1','3','4') "); //���ޱ���
					if (str[2].equals("5")) sql.append( " AND B.PAYDIV IN( '5') ");					//���ޱ���
	        if (str[2].equals("6")) sql.append( " AND B.PAYDIV IN( '6') ");					//���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD  = '" + str[3] + "' \n ");	//�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH = '" + str[4] + "' \n ");  //����
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD  = '" + str[5] + "' \n ");	//����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV  = '" + str[6] + "' \n ");	//����			
					sql.append("   GROUP BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   --ORDER BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   ) A ON A.MINORCD = B.MINORCD                                                                \n ");
					sql.append("   ORDER BY SEQ, MINORCD, DEPTNM                                                               \n ");

				
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