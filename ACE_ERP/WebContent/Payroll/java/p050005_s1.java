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
public class p050005_s1 extends HttpServlet {

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


//DROP TABLE PWINDPEN;			
//CREATE TABLE PWINDPEN (			
//EMPNO	CHAR(7) 	NOT NULL,	/*  ���*/
//FRDT	CHAR(8)	NOT NULL,	/*  ������*/
//DIV	VARCHAR(4)	NOT NULL,	/*  ��������*/
//PERAMT	NUMERIC(7, 0)	DEFAULT 0,	/*  ���κδ�*/
//SUPAMT	NUMERIC(7, 0)	DEFAULT 0,	/*  ȸ������*/
/* Primary key Define */			
//       CONSTRAINT PWINDPENPK PRIMARY KEY ( EMPNO)); 








				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* �μ� */
				"EMPNO",       /*���*/
				"EMPNMK",      /*����*/
				"FRDT",        /*������*/
				"TODT",        /*������*/
				"DIV",       /*�����ڵ�*/
				"DIVNM",       /*��������*/
				"PERAMT",      /*���κδ�*/
				"SUPAMT"       /*ȸ������*/


				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20,
					8, 	
					8, 	
					4,
					30,
					7, 	
					7

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,   
					-1,   
					-1,
					-1,
					-1,
					0,
					0
                    }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  ");
					sql.append( "  RTRIM(C.DEPTNM) AS DEPTNM, ");	  
					sql.append( "  A.EMPNO, ");   
					sql.append( "  B.EMPNMK, ");  
					sql.append( "  A.FRDT, ");   
					sql.append( "  A.TODT, ");   
					sql.append( "  A.DIV, ");   
					sql.append( "  D.MINORNM AS DIVNM, ");  
					sql.append( "  A.PERAMT, ");   
					sql.append( "  A.SUPAMT ");  


					sql.append( " from  PAYROLL.PWINDPEN A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
                    sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  A.DIV = D.MINORCD  AND D.MAJORCD = '1170' \n");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND B.DEPTCD  = '"  + str[0] + "' ");    //�μ�
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[1]+ "%' ");     //����
					sql.append( " ORDER BY B.DEPTCD  ASC , A.EMPNO ASC ");
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