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
public class p040004_s2 extends HttpServlet {

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

				"EMPNO",	/* ��� */
				"APPYM",	/* ��� */
				"PAYDIV",	/*  ���ޱ���*/
				"PAYDIVNM",	/* ���ޱ��и�*/
				"PAYDT",    /*  �����޿�������*/
				"ENDDT",	/* ����� */

				"DUYEAR",	/*  �ٹ����*/
				"DUYMM",	/*  �ٹ����� */
				"DUDAY",	/*  �ٹ��ϼ� */

				"P10000",	/*  �⺻�޿�*/
				"P11000",	/*  ��å���� */
				"P12000",	/*  �ð��ܼ���*/
				"P21000",	/*  �ټӼ���*/
				"P22000",	/*  �ڱ��ߺ�*/
				"P23000",	/*  �ξ簡������*/

				"P25000",	/*  �ⳳ����*/
				"P27000",	/*  �������*/
				"P28000",	/*  �ڰݼ���*/
				"P29000",	/*  ���ϰ�������*/
				"P30000",	/*  ����ܼ���*/

				"P31000",	/*  Ư��������*/
				"P32000",	/*  �����ٹ�����*/

		    "P34000",	/*  ��������*/	
				"P35000",	/*  �󿩱�*/	
				"P38000",	/*  �ӿ���å����*/	
				"TOTSUM"	/*  �����հ�*/	
				};

				int[] intArrCN = new int[]{  
					7, 	  /* ��� */          
					6,	  /* ��� */          
					4,	  /*  ���ޱ���*/      
					30,	  /* ���ޱ��и�*/       
					8,	  /*  ������*/
					8,	  /* ����� */        
					2,	  /*  �ٹ����*/      
					2,	  /*  �ٹ����� */     
					2,	  /*  �ٹ��ϼ� */     
					9,	  /*  �⺻�޿�*/      
					9,	  /*  ��å���� */     
					9,	  /*  �ð��ܼ���*/    
					9,	  /*  �ټӼ���*/      
					9,	  /*  �ڱ��ߺ�*/    
					9,	  /*  �ξ簡������*/  
					9,	  /*  �ⳳ����*/      
					9,	  /*  �������*/      
					9,	  /*  �ڰݼ���*/      
					9,	  /*  ���ϰ�������*/  
					9,	  /*  ����ܼ���*/    
					9,	  /*  Ư��������*/    
					9,	  /*  �����ٹ�����*/  
					9,	  /*  ��������*/	    
					9,	  /*  �󿩱�*/	    
					9, 	  /*  �ӿ���å����*/	
					9 	  /*  �����հ�*/	
         }; 

				int[] intArrCN2 = new int[]{
					-1,   /* ��� */            
					-1,	  /* ��� */            
					-1,   /*  ���ޱ���*/        
					-1,	  /* ���ޱ��и�*/         
					-1,   /*  ������*/  
					-1,	  /* ����� */          
					0,   /*  �ٹ����*/        
					0,	  /*  �ٹ����� */       
					0,	  /*  �ٹ��ϼ� */       
					0,   /*  �⺻�޿�*/        
					0,	  /*  ��å���� */       
					0,	  /*  �ð��ܼ���*/      
					0,	  /*  �ټӼ���*/        
					0,	  /*  �ڱ��ߺ�*/      
					0,	  /*  �ξ簡������*/    
					0,    /*  �ⳳ����*/        
					0,	  /*  �������*/        
					0,	  /*  �ڰݼ���*/        
					0,	  /*  ���ϰ�������*/    
					0,	  /*  ����ܼ���*/      
					0,	  /*  Ư��������*/      
					0,	  /*  �����ٹ�����*/    
					0,	  /*  ��������*/	    
					0,	  /*  �󿩱�*/	        
					0,	  /*  �ӿ���å����*/	
					0	  /*  �����հ�*/	
          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT                                                                         ");
					sql.append(" G.EMPNO,   G.APPYM,   G.PAYDIV ,   G.PAYDIV, D.MINORNM AS PAYDIVNM, G.PAYDT,   ");
					sql.append(" G.ENDDT,   G.DUYEAR,   G.DUYMM ,   G.DUDAY,                                    ");
					sql.append(" G.P10000, G.P11000, G.P12000, G.P21000, G.P22000,                              ");
					sql.append(" G.P23000, G.P25000, G.P27000, G.P28000, G.P29000,                              ");
					sql.append(" G.P30000, G.P31000, G.P32000, G.P34000, G.P35000,G.P38000,											");
					sql.append(" ( G.P10000+ G.P11000+ G.P12000+ G.P21000+ G.P22000+  G.P23000+									");
					sql.append(" G.P25000+ G.P27000+ G.P28000+ G.P29000+ G.P30000+ G.P31000+										");
					sql.append(" G.P32000+ G.P34000+ G.P35000+G.P38000) AS TOTSUM																");
					sql.append(" FROM PAYROLL.PRAVGPAY G                                                        ");
					sql.append(" LEFT JOIN PAYROLL.HCLCODE D ON G.PAYDIV =D.MINORCD AND D.MAJORCD = '1120'			");
					sql.append(" LEFT OUTER JOIN PAYROLL.HIPERSON A ON  G.EMPNO = A.EMPNO												");
					sql.append(" WHERE RTRIM(G.EMPNO) <> ' '																										");

					if ( !str[0].equals("")&&!str[0].equals("0") )
						sql.append( " AND G.EMPNO =  '"  + str[0] + "'  ");    //���
					if (!str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND G.APPYM =  '" + str[1]+ "' ");     //���

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