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
public class p050003_s2 extends HttpServlet {

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

//Table Name	�����޺���׳��ν���		Update:
//COLUMN	ATTRIBUTE	NULL	LABEL
//DROP TABLE PWMEDPAY;			
//CREATE TABLE PWMEDPAY (			
//STRDT	CHAR(4)	NOT NULL,	/*  ���س⵵*/
//INSCD	CHAR(1)	NOT NULL,	/*  �����ڵ�*/
//RESINO	CHAR(13)	NOT NULL,	/*  �ֹι�ȣ*/
//EMPNO	CHAR(7)	,	/*  ���*/
//MEDSO1	CHAR(4)	,	/*  ���ձ�ȣ*/
//MEDSO2	CHAR(6)	,	/*  ����*/
//MEDSO3	CHAR(6)	,	/*  ������ȣ*/
//MEDSO4	CHAR(4)	,	/*  ���������*/
//MEDSNO	CHAR(8)	,	/*  �ǰ���������ȣ*/
//NAME	CHAR(14)	,	/*  ����*/		
//GETDT	CHAR(8)	,	/*  �ڰ������*/		
//MEDAMT1	NUMERIC(15 , 0)	DEFAULT 0,	/*  ���⵵����ᳳ��*/		
//MEDAMT2	NUMERIC(15 , 0)	DEFAULT 0,	/*  �ǳ��κ����*/		
//M12100	NUMERIC(15 , 0)	DEFAULT 0,	/*  ���⵵�����Ѿ�*/		
//DUTMON	NUMERIC(2 , 0)	DEFAULT 0,	/*  �ٹ�����*/		
//OGRCD	NUMERIC(3 , 0)	DEFAULT 0,	/*  �������*/		
//NGRCD	NUMERIC(3 , 0)	DEFAULT 0,	/*  �������*/		
//CHK1	CHAR(1)	,	/*  Ȯ�ο���*/		
//CHK2	CHAR(1)	,	/*  ��������*/		
///* Primary key Define */					
//       CONSTRAINT PWMEDPAYPK PRIMARY KEY ( STRDT, INSCD, RESINO)); 					


				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* �μ� */
				"EMPNO",       /*���*/
				"EMPNMK",       /*����*/

				"RESINO",	       /* �ֹι�ȣ */
				"MEDSNO",	/* ��������ȣ*/

				"GETDT",	/*  �ڰ������*/
				"MEDAMT1",	/*  ���⵵����ᳳ��*/
				"MEDAMT2",	/* �ǳ��κ����*/
				"M12100",	/*  ���⵵�����Ѿ�*/
				"DUTMON",	/*  ����*/

				"NGRDCD",	/*  �������*/
				"STRDT",	/*  ���س⵵*/
				"INSCD"	/*  �����ڵ�*/

				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20, 
					13, 
					8,	
					8,
						
					15,	//���⵵����ᳳ��
					15,	
					15,
					2,
						
					3,
					4,	
					1

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,
					-1,
					-1,

					-1,
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
					sql.append( "  A.RESINO, ");	
					sql.append( "  RTRIM(A.MEDSNO) MEDSNO, ");
					
					sql.append( "  A.GETDT, ");	
					sql.append( "  A.MEDAMT1, ");	
					sql.append( "  A.MEDAMT2, ");	
					sql.append( "  A.M12100, ");	
					sql.append( "  A.DUTMON, ");	
					sql.append( "  A.NGRDCD, ");
					
					sql.append( "  A.STRDT,  ");	
					sql.append( "  A.INSCD ");
					

					sql.append( " from  PAYROLL.PWMEDPAY  A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.INSCD = '" + str[0]+ "' ");     //���豸��
					if ( !str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND A.STRDT  = '"  + str[1] + "' ");    //���س�
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