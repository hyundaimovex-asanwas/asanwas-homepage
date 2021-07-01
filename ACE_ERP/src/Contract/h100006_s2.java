package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h100006_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//�μ�
				str[1]	= req.getParameter("v_str2");		//����
				str[2]	= req.getParameter("v_str3");		//���-�޿� ���� ��½� ���
				str[3]	= req.getParameter("v_str4");		//�������Կ�

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"DEPTNM",	   /* �μ� */
					"EMPNO",     /*���*/
					"EMPNMK",    /*����*/
					"FRDT",      /*������*/
					"TODT",      /*������*/
					"DIV",       /*�����ڵ�*/
					"DIVNM",     /*��������*/
					"INSUR",     /*�������*/
					"INSURNM",   /*��������̸�*/
					"TOTDAY",    /*�Ѻ��ԱⰣ*/
					"TOTCNT",    /*����Ƚ��*/
					"PERAMT",    /*���κδ�*/
					"SUPAMT",    /*ȸ������*/
					"TOTAMT",    /*�����*/
					"LASTMON",   /*�����*/
					"RESINO"     /*�ֹι�ȣ*/
				};

				int[] intArrCN = new int[]{  
					50,					 /* �μ� */      	
					7,	 				 /*���*/        
					20,	 				 /*����*/        
					8, 	 				 /*������*/      
					8, 	 				 /*������*/      
					4,	 				 /*�����ڵ�*/    
					30,	 				 /*��������*/    
					4, 	 				 /*�������*/    
					30,	 				 /*��������̸�*/
					10, 	  		 /*�Ѻ��ԱⰣ*/  
					5,	 				 /*����Ƚ��*/    
					9, 	 				 /*���κδ�*/    
					9,	 				 /*ȸ������*/    
					12, 	  		 /*�����*/      
					6,	 				 /*�����*/      
					13	 				 /*�ֹι�ȣ*/    
         }; 

				int[] intArrCN2 = new int[]{
					-1,					 /* �μ� */      
					-1,	 				 /*���*/        
					-1,  				 /*����*/        
					-1,  				 /*������*/      
					-1,	 				 /*������*/      
					-1,	 				 /*�����ڵ�*/    
					-1,	 				 /*��������*/    
					-1,	 				 /*�������*/    
					-1,	 				 /*��������̸�*/
					-1,  				 /*�Ѻ��ԱⰣ*/  
					0,   				 /*����Ƚ��*/    
					0,	 				 /*���κδ�*/    
					0,	 				 /*ȸ������*/    
					0,	 				 /*�����*/      
					-1,	 				 /*�����*/      
					-1	 				 /*�ֹι�ȣ*/    
         }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  ");
					sql.append( " RTRIM(C.DEPTNM) AS DEPTNM, ");	  
					sql.append( " RTRIM(A.EMPNO) EMPNO, ");   
					sql.append( " RTRIM(B.EMPNMK) EMPNMK, ");  
					sql.append( " A.FRDT, ");   
					sql.append( " A.TODT, ");   
					sql.append( " A.DIV, ");   
					sql.append( " D.MINORNM AS DIVNM, ");  
					sql.append( " A.INSUR, ");   
					sql.append( " F.MINORNM AS INSURNM, ");  
					sql.append( " A.TOTDAY, ");   
					sql.append( " A.TOTCNT, ");   
					sql.append( " A.PERAMT, ");   
					sql.append( " A.SUPAMT, ");   
					sql.append( " A.TOTAMT, ");   
					sql.append( " A.LASTMON, ");  
					sql.append( " B.RESINO ");  
					sql.append( " FROM PAYROLL.PWINDPEN A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.T_HIPERSON B ON  A.EMPNO = B.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
          sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  A.DIV = D.MINORCD  AND D.MAJORCD = '1170' \n");
          sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON  A.INSUR = F.MINORCD  AND F.MAJORCD = '1171' \n");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ''  \n ");
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND B.DEPTCD  = '"  + str[0] + "' ");    //�μ�
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[1]+ "%' ");   //����
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.EMPNO = '" + str[2]+ "' ");				//���
					if (!str[3].equals("")) sql.append( " AND A.LASTMON = '" + str[3] + "' ");													//��������

					sql.append( " ORDER BY B.DEPTCD  ASC , A.EMPNO ASC ");
					
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