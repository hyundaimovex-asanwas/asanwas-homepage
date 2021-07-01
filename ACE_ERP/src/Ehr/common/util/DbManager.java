package Ehr.common.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//import com.sap.mw.jco.IFunctionTemplate;
//import com.sap.mw.jco.JCO;
import com.shift.gef.configuration.Configuration;
/*
 * �ܺ��� DB�� �����Ҷ� ����Ѵ�
 * SQL 2005 Standard Edition ���� �̱��� DB�� ����Ҽ� ���� ��쿡�� ���������� ����Ѵ�
 */
public final class DbManager {

	/*���� Server�� ���� */
	public static Connection getMyConnection()  {
		Connection con = null;
 		try {
		    Context ctx = new InitialContext();  //Interface = new Class
		    DataSource ds = (javax.sql.DataSource)ctx.lookup("jdbc/ASNHR");
		    con = ds.getConnection();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	/* MS-SQL�� �� HUNI-BILL�� ���� */
	public static Connection getFrsConnection()  {
		Connection con = null;
 		try {
 			Class.forName("weblogic.jdbc.sqlserver.SQLServerDriver");
 			Configuration config = Configuration.getInstance();
 			String url = config.getString("framework.ms.frs.url");
 			String id = config.getString("framework.ms.frs.id");
 			String password = config.getString("framework.ms.frs.password");
 			con = DriverManager.getConnection(url,id,password);
 			//con = DriverManager.getConnection("jdbc:bea:sqlserver://203.242.35.108:1433;databasename=hr_test","ehr","ehrpwd09");
		}
		catch (Exception e) {
			e.printStackTrace();

		}
		return con;
	}
	/* MS-SQL�� �� GroupWare �� ���� */
	public static Connection getGrwConnection()  {
		Connection con = null;
 		try {
 			Class.forName("weblogic.jdbc.sqlserver.SQLServerDriver");
 			Configuration config = Configuration.getInstance();
 			//String url = config.getString("framework.ms.frs.url");
 			//String id = config.getString("framework.ms.frs.id");
 			//String password = config.getString("framework.ms.frs.password");
 			//con = DriverManager.getConnection(url,id,password);
 			//con = DriverManager.getConnection("jdbc:bea:sqlserver://203.242.32.170:1433;databasename=HI_OFFICE_SMS","sms_uniHR","dlstktltmxpa");
		}
		catch (Exception e) {
			e.printStackTrace();

		}
		return con;
	}
	/* SAP �� ���� */
	/*
	public static JCO.Client getSAPConnection()
	{
		JCO.Client mConnection = null;
		try
		{

 			JCO.Pool pool = JCO.getClientPoolManager().getPool("POOL");
 	        if (pool == null) {
 	 			Configuration config = Configuration.getInstance();

 	 			String SAP_SAPCLIENT 	= config.getString("framework.sap.sap_sapclient");
 	 			String SAP_USERID 		= config.getString("framework.sap.sap_userid");
 	 			String SAP_PASSWORD 	= config.getString("framework.sap.sap_password");
 	 			String SAP_LANGUAGE 	= config.getString("framework.sap.sap_language");
 	 			String SAP_HOST 		= config.getString("framework.sap.sap_host");
 	 			String SAP_SYSTEMNUMBER = config.getString("framework.sap.sap_systemnumber");
 	          JCO.addClientPool("POOL",  // pool name
 	                            5,          // maximum number of connections
 	                           SAP_SAPCLIENT,
 	                          SAP_USERID,
 	                         SAP_PASSWORD,
 	                        SAP_LANGUAGE,
 	                       SAP_HOST,
 	                      SAP_SYSTEMNUMBER); // properties
 	        }
 	       mConnection = JCO.getClient("POOL");

			System.out.println("SAP ���� Ȯ�� !!!!");
		}
		catch (Exception ex)
		{
			//throw new Exception("Problem retrieving JCO.Function object.");
		 }
		return mConnection;
	}
	*/
	/*
	public static JCO.Client getSAPConnection()
	{
		JCO.Client mConnection = null;
		try
		{
 			Configuration config = Configuration.getInstance();

 			String SAP_SAPCLIENT 	= config.getString("framework.sap.sap_sapclient");
 			String SAP_USERID 		= config.getString("framework.sap.sap_userid");
 			String SAP_PASSWORD 	= config.getString("framework.sap.sap_password");
 			String SAP_LANGUAGE 	= config.getString("framework.sap.sap_language");
 			String SAP_HOST 		= config.getString("framework.sap.sap_host");
 			String SAP_SYSTEMNUMBER = config.getString("framework.sap.sap_systemnumber");

			mConnection = JCO.createClient(SAP_SAPCLIENT, SAP_USERID, SAP_PASSWORD, SAP_LANGUAGE, SAP_HOST, SAP_SYSTEMNUMBER);
			mConnection.connect();
			System.out.println("SAP ���� Ȯ�� !!!!");
		}
		catch (Exception ex)
		{
			//throw new Exception("Problem retrieving JCO.Function object.");
		 }
		return mConnection;
	}
	*/
	/* SAP �� ���� */
	/*
	public static JCO.Function createJCOFunction(JCO.Repository mRepository, String name) throws Exception
	{
		try
		{
			IFunctionTemplate ft = mRepository.getFunctionTemplate(name.toUpperCase());
			if (ft == null)
			  return null;
			return ft.getFunction();
		}
		catch (Exception ex)
		{
			throw new Exception("Problem retrieving JCO.Function object.");
		 }
	}
	*/
}
