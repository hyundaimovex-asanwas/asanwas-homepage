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
public class p050003_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//���豸��
				str[1]	= req.getParameter("v_str2");		//���س��
				str[2]	= req.getParameter("v_str3");		//�μ�
				str[3]	= req.getParameter("v_str4");		//����

//EMPNO	CHAR(7) 	NOT NULL,	        /*  ���*/
//STDYM	CHAR(6)	NOT NULL,           	/*  ���*/
//INSCD	CHAR(1)	NOT NULL,            	/*  ���豸��*/
//STRYMD	CHAR(8)	,	                /*  ����ϼ�*/
//DUTMON	NUMERIC(2,0)	DEFAULT 0,	/*  �ٹ�����*/
//Y12000	NUMERIC(9,0)	DEFAULT 0,	/*  �⺸���Ѿ�*/
//M12100	NUMERIC(9,0)	DEFAULT 0,	/*  ����ǥ�غ�����*/
//M12000	NUMERIC(9,0)	DEFAULT 0,	/*  ����������*/
//M12200	NUMERIC(9,0)	DEFAULT 0,	/*  ����ҵ��*/
//OGRDCD	NUMERIC(3,0)	DEFAULT 0,	/*  �����*/
//M12300	NUMERIC(9,0)	DEFAULT 0,	/*  ���κ����*/
//NGRDCD	NUMERIC(3,0)	DEFAULT 0,	/*  �ŵ��*/
//S12000	NUMERIC(9,0)	DEFAULT 0,	/*  ǥ�غ�������*/
//N12301	NUMERIC(9,0)	DEFAULT 0,	/*  �������*/
//N12300	NUMERIC(9,0)	DEFAULT 0,	/*  ���������*/
//DIVAMT	NUMERIC(9,0)	DEFAULT 0,	/*  ����ݾ�*/
//DIVDT	CHAR(8)	,	                    /*  ��������*/




				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* �μ� */
				"EMPNO",       /*���*/
				"EMPNMK",       /*����*/

				"MEDSNO",	       /* ����ȣ */
				"M12300",	/* ���κ����*/

				"Y12000",	/*  �Ⱓ����*/
				"DUTMON",	/*  ����(�ٹ�����)*/
				"M12000",	/* ������*/
				"S12000",	/*  ��ǥ��*/
				"OGRDCD",	/*  �����*/

				"NGRDCD",	/*  �ŵ��*/
				"STDYM",	/*  ���*/
				"INSCD"	/*  ���豸��*/


				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20, 
					20, 

					9,	

					9,
						
					2,	//�ٹ�����
					9,	
					9,
						
					3,	
					3,
					6,	
					1

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,
					-1,
					0,

					0,
					0,
					0,
					0,
					0,
					0,
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
					sql.append( "  RTRIM(C.DEPTNM) AS DEPTNM, ");	  
					sql.append( "  A.EMPNO, ");   
					sql.append( "  B.EMPNMK, ");  
					sql.append( "  D.MEDSNO, ");	
					sql.append( "  A.M12300, ");
					
					sql.append( "  A.Y12000, ");	
					sql.append( "  A.DUTMON, ");	
					sql.append( "  A.M12000, ");	
					sql.append( "  A.S12000, ");	
					sql.append( "  A.OGRDCD, ");
					
					sql.append( "  A.NGRDCD,  ");	
					sql.append( "  A.STDYM, ");
					
					sql.append( "  A.INSCD  ");	

					sql.append( " from  PAYROLL.PWINSPAY  A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.PWINDIPN_H D ON  A.EMPNO = D.EMPNO     ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.INSGB = '" + str[0]+ "' ");     //���豸��
					if ( !str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND A.STDYM  = '"  + str[1] + "' ");    //���س��
					if ( !str[2].equals("")&&!str[2].equals("0"))
						sql.append( " AND B.DEPTCD  = '"  + str[2] + "' ");    //�μ�
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[3]+ "%' ");     //����
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