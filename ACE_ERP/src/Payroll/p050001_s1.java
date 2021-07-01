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
public class p050001_s1 extends HttpServlet {

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
				str[1]	= req.getParameter("v_str2");		//���





				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"STDYM",	   /* ���س�� */
				"GRDCD",       /*���*/
				"LOWAMT",       /*�������Ѿ�*/
				"HIGAMT",	       /* �������Ѿ� */
				"STDAMT",	/* ǥ�غ�������*/
				"INSAMT1",	/*  ���κδ�*/
				"INSAMT2",	/*  ȸ��δ�*/
				"INSSUM"	/* ����ȸ���հ�*/


				};

				int[] intArrCN = new int[]{  
					6, 	
					3,
					9, 
					9,	
					9,	
					9,	
					9,	
					9

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					0,
					0,
					0,

					0,
					0,
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
					sql.append( "  A.STDYM, ");	  
					sql.append( "  A.GRDCD, ");   
					sql.append( "  A.LOWAMT, ");  
					sql.append( "  A.HIGAMT, ");	
					sql.append( "  A.STDAMT, ");	
					sql.append( "  A.INSAMT1, ");	
					sql.append( "  A.INSAMT2, ");	
					sql.append( "  A.INSSUM  ");	


					sql.append( " from  PAYROLL.PWINSTBL A "); 
					//sql.append( " LEFT OUTER JOIN PAYROLL.PWRATE B ON  A.STDYM = B.APPYM AND RTRIM(B.INSGB) = '1' ");
					sql.append( " WHERE A.STDYM <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND A.STDYM  = '"  + str[0] + "' ");    //�������
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.GRDCD =" + str[1]+ " ");     //����
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