package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.*;

public class p030030_t3 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
			
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();		

				String strAppdt = reqGauce.getParameter("v_str1");		//�޿����

				//logger.dbg.println(this,"strAppdt::"+strAppdt);

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
		

				GauceStatement gsmt = null;
        /****************************************************
         ���α׷� : �������� ����¡������ �޿� �ݿ�
				 �ۼ����� : 2011.02.20
				 �� �� �� : ������
				 �۾����� : �޿���� ==> �������� ����¡�� ���� �ݿ�==> �޿����װ�� 
				 �� �̷� ������ �۾��� �ؾ���.

				 ����   ������	3080035	2110001
								������	3080141	2110002
								������	3080087	2110003
								������	3080114	2110004
								ä����	3080143	2110005
								�迵��	3080086	2110006
        �� ������� 2011�⵵�� ����� ����Ǿ ���� ó���ؾ� ��.
				*****************************************************/
        int idxAPPYY = userSet.indexOfColumn("APPYY");   //�ͼӳ⵵
				
				GauceDataRow[] rows = userSet.getDataRows();

       	StringBuffer SelectSql = null;
				StringBuffer UpdateSql = null;

				Statement stmt = null;
				ResultSet rs = null;
	       

        for (int j = 0; j < rows.length; j++){ 
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT A.APPYY,                                     \n" ); 
						SelectSql.append( "        CASE WHEN A.EMPNO ='3080035' THEN '2110001'  \n" ); 
            SelectSql.append( "             WHEN A.EMPNO ='3080141' THEN '2110002'  \n" ); 
            SelectSql.append( "             WHEN A.EMPNO ='3080087' THEN '2110003'  \n" ); 
						SelectSql.append( "             WHEN A.EMPNO ='3080114' THEN '2110004'  \n" ); 
						SelectSql.append( "             WHEN A.EMPNO ='3080143' THEN '2110005'  \n" ); 
            SelectSql.append( "             WHEN A.EMPNO ='3080086' THEN '2110006'  \n" ); 
            SelectSql.append( "             ELSE A.EMPNO END EMPNO,                 \n" );
						SelectSql.append( "        A.BA41000, A.BA42000                         \n" );
						SelectSql.append( "   FROM PAYROLL.YCPAY10 A                            \n" ); 
						SelectSql.append( "  WHERE A.APPYY= '"+rows[j].getString(idxAPPYY)+"'   \n" ); 
						//SelectSql.append( "    AND A.EMPNO= '1990005'   \n" ); 

						SelectSql.append( "  ORDER BY A.EMPNO                                   \n" ); 

						//logger.dbg.println(this,"SelectSql.toString()::"+SelectSql.toString());
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){ 

								UpdateSql = new StringBuffer();
								UpdateSql.append( "  UPDATE PAYROLL.PBPAY SET     \n");
								UpdateSql.append( "  T21000="+rs.getLong("BA41000")+" \n");
								UpdateSql.append( " ,T22000="+rs.getLong("BA42000")+" \n");
								UpdateSql.append( "   WHERE APPDT = '"+strAppdt+"' " );
								UpdateSql.append( "     AND EMPNO = '"+rs.getString("EMPNO")+"'  " );
								//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
								gsmt = conn.getGauceStatement(UpdateSql.toString());
								gsmt.executeUpdate();
								gsmt.close();
						}
					}//if
				}//for  

			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}
      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
  /**
  public void Step(String strempno){

     ServiceLoader loader = null;
		 GauceService service = null;
		 GauceContext context = null;
		 Logger logger = null; 

		 loader = new ServiceLoader(req, res);
	 	 service = loader.newService();
	 	 context = service.getContext();
	 	 logger = context.getLogger();

		 logger.dbg.println(this,"strempno"+strempno);

     //System.out.println("strempno"+strempno); 
	}
	**/
}



/**
class Step{
  public Step(String strempno){
		System.out.println("strempno"+strempno); 
  }
};

**/