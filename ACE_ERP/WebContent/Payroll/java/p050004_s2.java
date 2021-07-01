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
public class p050004_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//���


//DROP TABLE HIFAMILY;			
//CREATE TABLE HIFAMILY (			
//EMPNO	CHAR(7)	NOT NULL,	/*���*/
//SEQ	NUMERIC(2, 0)	NOT NULL,	/*����*/
//RESINO	CHAR(13)	,	/*�ֹι�ȣ*/
//FAMNM	VARCHAR(20)	,	/*����*/
//REFCD	VARCHAR(4)	,	/*��������*/
//SCHNM	VARCHAR(40)	,	/*�����б���*/
//CMPNM	VARCHAR(60)	,	/*������*/
//LSTEDC	VARCHAR(4)	,	/*�з��ڵ�*/
//LIVEYN	CHAR(1)	,	/*���ſ���*/
//GETYN	CHAR(1)	,	/*�ҵ濩��*/
//PAYYN	CHAR(1)	,	/*��������*/
//DISYN	CHAR(1)	,	/*�������*/
//SPTYN	CHAR(1)	,	/*�Ǻξ���*/
//MEDINYN	CHAR(1)	,	/*�Ƿ������*/
//EDUEXYN	CHAR(1)	,	/*���ڱ�����*/
/* Primary key Define */			
//       CONSTRAINT HIFAMILYPK PRIMARY KEY (EMPNO, SEQ));			






				for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"FAMNM",	   /* �������� */
				"RESINO",       /*�����ֹ�*/
				"REFCDNM",      /*��������*/
				"LSTEDCNM"    /*�з»���*/


				};

				int[] intArrCN = new int[]{  
					20, 	
					13,
					30,
					30

            	}; 

				int[] intArrCN2 = new int[]{
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
					sql.append( "  SELECT  ");
					sql.append( "  A.FAMNM, ");	  
					sql.append( "  A.RESINO, ");   
					sql.append( "  D.MINORNM AS  REFCDNM,");  //��������
					sql.append( "  E.MINORNM AS  LSTEDCNM ");  //�з»���


					sql.append( " from  PAYROLL.HIFAMILY A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE D ON  A.REFCD = D.MINORCD  AND D.MAJORCD = '1132'   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE E ON  A.LSTEDC = E.MINORCD  AND E.MAJORCD = '1137'  ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND A.EMPNO  = '"  + str[0] + "' ");    //���
					sql.append( " ORDER BY A.SEQ ASC ");
					//logger.err.println(this,sql.toString());
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