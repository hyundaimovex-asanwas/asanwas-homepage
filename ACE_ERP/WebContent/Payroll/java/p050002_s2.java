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
public class p050002_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//���س��
				str[1]	= req.getParameter("v_str2");		//�μ�
				str[2]	= req.getParameter("v_str3");		//����
				str[3]	= req.getParameter("v_str4");		//���豸��


//DROP TABLE PWINDIPN_H;		//�ǰ�����	
//CREATE TABLE PWINDIPN_H (			
//APPYM	CHAR(6)	NOT NULL,	/*  ������*/
//RESINO	CHAR(13)	NOT NULL,	/* �ֹι�ȣ*/
//EMPNO	CHAR(7) 	NOT NULL,	/*  ���*/
//STDAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  �ҵ����*/
//GRDCD	NUMERIC(3, 0)	DEFAULT 0,	/*  ������*/
//INSGETCOD	CHAR(1)	,	/*  ����ȣ*/
//INSREDCOD	CHAR(2)	,	/*  �����ȣ*/
//JANGREF	CHAR(1)	,	/*  ���������*/
//BUYANG	NUMERIC(2, 0)	DEFAULT 0,	/*  �Ǻξ��ڼ�*/
//INSAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  �������*/
//MEDSNO	VARCHAR(20)	,	/*  �����ȣ*/
//GETDT	CHAR(8)	,	/*  �������*/
//LOSDT	CHAR(8)	,	/*  �������*/
//REPDT	CHAR(8)	,	/*  �Ű�����*/
///* Primary key Define */			
//       CONSTRAINT PWINDIPN_HPK PRIMARY KEY (APPYM,RESINO)); 			


//DROP TABLE PWINDIPN_Y;			//���ο���
//CREATE TABLE PWINDIPN_Y (			
//APPYM	CHAR(6)	NOT NULL,	/*  ������*/
//RESINO	CHAR(13)	NOT NULL,	/* �ֹι�ȣ*/
//EMPNO	CHAR(7) 	NOT NULL,	/*  ���*/
//STDAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  �ҵ����*/
//GRDCD	NUMERIC(3, 0)	DEFAULT 0,	/*  ������*/
//INSGETCOD	CHAR(1)	,	/*  ����ȣ*/
//JANGREF	CHAR(1)	,	/*  ���������*/
//INSAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  �������*/
//MEDSNO	VARCHAR(20)	,	/*  �����ȣ*/
//GETDT	CHAR(8)	,	/*  �������*/
//LOSDT	CHAR(8)	,	/*  �������*/
//REPDT	CHAR(8)	,	/*  �Ű�����*/
///* Primary key Define */			
//       CONSTRAINT PWINDIPN_YPK PRIMARY KEY (APPYM,RESINO)); 			
///* Table Refference */			
//






				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* �μ� */
				"EMPNO",       /*���*/
				"EMPNMK",       /*����*/
				"APPYM",	       /* ������ */
				"RESINO",	/* �ֹι�ȣ*/
				"GRDCD",	/*  ���*/
				"STDAMT",	/*  ǥ�غ�������*/
				"INSAMT",	/* �������*/
				"MEDSNO",	/*  ����ȣ*/
				"GETDT",	/*  �������*/
				"LOSDT",	/*  �������*/
				"REPDT"	    /* �Ű�����*/


				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20, 
					6,	
					13,
						
					3,	
					9,	
					9,	
					20,	
					8,
						
					8,	
					8

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,
					-1,
					-1,

					0,
					0,
					0,
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
					sql.append( "  C.DEPTNM AS DEPTNM, ");	  
					sql.append( "  A.EMPNO, ");   
					sql.append( "  B.EMPNMK, ");  
					sql.append( "  A.APPYM, ");	
					sql.append( "  A.RESINO, ");	
					sql.append( "  A.GRDCD, ");	
					sql.append( "  A.STDAMT, ");	
					sql.append( "  A.INSAMT, ");	
					sql.append( "  A.MEDSNO, ");	
					sql.append( "  A.GETDT, ");	
					sql.append( "  A.LOSDT, ");	
					sql.append( "  A.REPDT  ");	


					sql.append( " from  PAYROLL.PWINDIPN_Y A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND A.APPYM  = '"  + str[0] + "' ");    //���س��
					if ( !str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND B.DEPTCD  = '"  + str[1] + "' ");    //�μ�
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[2]+ "%' ");     //����
					//if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND A.INSGB = '" + str[3]+ "' ");     //���豸��
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