package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class a160004_s55 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
	���� �������� �����Ͻ� �κ�-�޿�������Ȳ ����ٹ��ں���(Fheader �κ�)
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [2];
				str[0]	= req.getParameter("v_str1");		//���޳��
				str[1]	= req.getParameter("v_str2");		//���ޱ���

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"COUNTR", //������ �ο���   
					"PAYSUMR", // �ѱ޿�*/    
					"BP35000R", // �Ĵ� */   
					"BP24000R", // ���� */ 
					"S91000R", // ����+�Ĵ�*/  
					"T11000R", // �ҵ漼*/    
					"T12000R", // �ֹμ�*/      
					"BXTOTALR", // ��Ÿ������*/      
					"S93000R", // �����հ�*/  
					"S94000R",  //�����޾�              
					"CYYYY",   //�����           
					"CMM"     //�����             
				};

				int[] intArrCN = new int[]{  
					9,  //������ �ο��� 
					9,  // �ѱ޿�*/    
					9,  // �Ĵ� */    
					9, // ���� */    
					9, // ����+�Ĵ�*/  
					9,  // �ҵ漼*/    
					9,  // �ֹμ�*/    
					9,  // ��Ÿ������*
  					9,  //�����հ�     
					9,   //�����޾�              					         
					4,   //�����   
					2  ///�����/         
            	}; 

				int[] intArrCN2 = new int[]{
					0,  //������ �ο��� 
					0,  // �ѱ޿�*/     
					0,  // �Ĵ� */      
					0, // ���� */       
					0, // ����+�Ĵ�*/   
					0,  // �ҵ漼*/     
					0,  // �ֹμ�*/     
					0,  // ��Ÿ������*  
					0,  //�����հ�      
					0,   //�����޾�     
					-1,   //�����                    
					-1  ///�����/           
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();		/*REPORT 1.����(�ӿ�)*/
					sql.append(" SELECT  \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS COUNTR, --����� �ο��� */						\n ");
					sql.append("  COALESCE(B.PAYSUMR,0) AS PAYSUMR, -- �ѱ޿�*/                              \n ");
					sql.append("  COALESCE(B.BP35000R,0) AS BP35000R, -- �Ĵ� */                             \n ");
					sql.append("  COALESCE(B.BP24000R,0) AS BP24000R, --  ����*/                          \n ");
					sql.append("  COALESCE(B.S91000R,0) AS S91000R, -- ����+�Ĵ� */                          \n ");
					sql.append("  COALESCE(B.T11000R,0) AS T11000R, -- �ҵ漼*/                                \n ");
					sql.append("  COALESCE(B.T12000R,0) AS T12000R, -- �ֹμ�*/                                \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS BXTOTALR,   --��Ÿ������*/                         \n ");
					sql.append("  COALESCE(B.S93000R,0) AS S93000R, -- �����հ�*/                              \n ");
					sql.append("  COALESCE(B.S94000R,0) AS S94000R, -- �����޾�*/                              \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS CYYYY, --����� */                            \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS CMM   --����� */                            \n ");
					sql.append("    FROM                                               \n ");
					sql.append(" (SELECT                                               \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTR,														\n ");
					sql.append("  SUM(B.P35000) AS P35000R,-- ����� �Ĵ�*/				 						\n ");
					sql.append("  SUM(B.P24000) AS P24000R,-- ���� ���� */										\n ");
					sql.append("  SUM(H.BP35000) AS BP35000R,-- ����� �Ĵ�*/									\n ");
					sql.append("  SUM(H.GP35000) AS GP35000R,-- ���� ��*/											\n ");
					sql.append("  SUM(H.BP24000) AS BP24000R,-- ����� ���� */									\n ");
					sql.append("  SUM(H.GP24000) AS GP24000R,-- ���� ���� */									\n ");
					sql.append("  (SUM(B.P10000)+																\n ");
					sql.append("  SUM(B.P11000)+							-- ��å���� */						\n ");
					sql.append("  SUM(B.P11000)+							-- �ð��ܼ��� */					\n ");
 					sql.append("  SUM(B.P21000)+							--�ټӼ���*/						\n ");
					sql.append("  SUM(B.P22000)+							--�ڱ��ߺ� */						\n ");
					sql.append("  SUM(B.P23000)+							--�ξ簡������*/					\n ");
					sql.append("  SUM(H.GP24000)+							--���������� */						\n ");
					sql.append("  SUM(B.P25000)+							--�ⳳ����*/						\n ");
					sql.append("  SUM(B.P26000)+							--��������*/						\n ");
					sql.append("  SUM(B.P27000)+							--�������*/						\n ");
					sql.append("  SUM(B.P28000)+							--�ڰݼ���*/						\n ");
					sql.append("  SUM(B.P29000)+							--���ϰ�������*/					\n ");
					sql.append("  SUM(B.P30000)+							--����ܼ���*/						\n ");
					sql.append("  SUM(B.P31000)+							--Ư��������*/						\n ");
					sql.append("  SUM(B.P32000)+							--�����ٹ�����*/					\n ");
					sql.append("  SUM(B.P33000)+							--��������*/						\n ");
					sql.append("  SUM(B.P34000)+							--��������*/						\n ");
					sql.append("  SUM(H.GP35000)+								--�Ĵ�*/						\n ");
					sql.append("  SUM(B.P36000)+							--�к�����*/						\n ");
					sql.append("  SUM(B.P37000)+							--���ο��ݺ�����*/					\n ");
					sql.append("  SUM(B.P38000)+							--�ӿ���å����*/					\n ");
					sql.append("  SUM(B.P39000))						--�����ұ�*/							\n ");
					sql.append("  AS PAYSUMR,							--�޿�*/								\n ");
					sql.append( " SUM(B.S91000)AS S91000R,    --����+�Ĵ�*/							\n"); 
					sql.append("  SUM(B.T11000) AS T11000R, -- �ҵ漼*/											\n ");			
					sql.append("  SUM(B.T12000) AS T12000R, -- �ֹμ�*/											\n ");	
					sql.append("  (SUM(B.B11000)+						 -- �ǰ������*/						\n ");			
					sql.append("  SUM(B.B12000)+							 -- ���ο���*/	 					\n ");
					sql.append("  SUM(B.B13000)+																\n ");
					sql.append("  SUM(B.B14000)+							--������ȸ��*/						\n ");
					sql.append("  SUM(B.B15000)+							--���ο���*/						\n ");
					sql.append("  SUM(B.B16000)+							--����ȸ��*/						\n ");
					sql.append("  SUM(B.BX0010)+							--��Ÿ����1*/						\n ");
					sql.append("  SUM(B.BX0020)+							--��Ÿ����2*/						\n ");
					sql.append("  SUM(B.BX0030)+							--��Ÿ����3*/						\n ");
					sql.append("  SUM(B.BX0040)+																\n ");	
					sql.append("  SUM(B.APLAMT)+																\n ");
					sql.append("  SUM(B.APLRAT))																\n ");
					sql.append("  AS BXTOTALR ,	             --��Ÿ������*/										\n ");
					sql.append("  SUM(B.S93000) AS S93000R, -- �����հ�*/										\n ");
					sql.append("  SUM(B.S94000) AS S94000R  -- �����޾�*/										\n ");	
					sql.append("  FROM PAYROLL.PBPAY B                                 \n ");
					sql.append( " LEFT JOIN (  SELECT   G.EMPNO, G.APPDT, G.PAYDIV, \n");
					sql.append( "					    CASE WHEN G.P35000 > 100000 THEN  (G.P35000 - 100000) ELSE 0 END GP35000 , \n"); //�����Ĵ� , 10�������� ũ�� -10������ ���� ���� , ������ 0�� ����
					sql.append( "					    CASE WHEN G.P35000 >= 100000 THEN  100000 ELSE G.P35000 END BP35000 , \n"); //������Ĵ� 10����>= 10= �����, �� ������ �Ĵ밡 �����
					sql.append( "						CASE WHEN G.P24000 > 200000 THEN  (G.P24000 - 200000) ELSE 0 END GP24000 , \n"); //�������� , 20> -20����=  ���� , ������ 0�� ����
					sql.append( "						CASE WHEN G.P24000 >= 200000 THEN  200000 ELSE G.P24000 END BP24000 \n"); //���������, 20>= 20���� �����, < �����̰� �����
					sql.append( "        FROM PAYROLL.PBPAY G)H ON B.EMPNO = H.EMPNO AND H.APPDT ='"  + str[0] + "' AND H.PAYDIV ='"+str[1]+"' \n");					
					sql.append("  WHERE B.APPDT='"  + str[0] + "'                      \n ");
					sql.append( " AND B.DEPTCD IN(SELECT DEPTCD FROM PAYROLL.HCDEPT WHERE GROUPID='01'  AND USEYN='T' AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) ) "); //����
					if (str[1].equals("1")) sql.append( " AND B.PAYDIV IN( '1') "); //���ޱ���
					if (str[1].equals("5")) sql.append( " AND B.PAYDIV IN( '5')					"); //���ޱ���
					sql.append("  GROUP BY B.APPDT ");
					sql.append("  ) B ");
         
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