/**
 * 작성일 : 2005-06-01
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.common.web;

import java.util.Collections;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Properties;

import javax.ejb.EJBHome;
import javax.ejb.EJBLocalHome;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import com.hmm.ejb.http.HttpServiceFactory;

/**
 * ServiceLocator.java.java
 */
public class ServiceLocator {
	private InitialContext ic;
	private Map cache;
	public static String PROVIDER_URL = "corbaloc::203.242.32.213:2809,:203.242.32.216:2809";
	public static String PRIFIX_EJB = "cell/clusters/ClusterServer/";
	public static String HOST_URL = "hmmejb.hmm21.com";
	public static int HOST_PORT = 80;
	public static String HOST_CONTEXT = "WinsWEB";
	
	private HttpServiceFactory factory = null;

	private static ServiceLocator me;

	static {
		me = new ServiceLocator();
	}

	private ServiceLocator() {
		cache = Collections.synchronizedMap(new HashMap());
	}

	public HttpServiceFactory getServiceFactory()
	{
		if(factory == null)
		{
			factory = new HttpServiceFactory(HOST_URL, HOST_PORT,HOST_CONTEXT);
		}
		return factory;
	}
	
	public InitialContext getInitialContext()
		throws Exception //   throws NamingException
	{
		try {
			if (ic == null) {
				Properties props = new Properties();
				props.put(Context.INITIAL_CONTEXT_FACTORY, "com.ibm.websphere.naming.WsnInitialContextFactory");
				props.put(Context.PROVIDER_URL, PROVIDER_URL);
				ic = new InitialContext(props);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return ic;
	}

	static public ServiceLocator getInstance() {
		return me;
	}

	/**
	 * will get the ejb Local home factory. If this ejb home factory has already been
	 * clients need to cast to the type of EJBHome they desire
	 *
	 * @return the EJB Home corresponding to the homeName
	 */
	public EJBLocalHome getLocalHome(String jndiHomeName) throws Exception {
		EJBLocalHome home = null;
		try {
			if (cache.containsKey(ServiceLocator.PRIFIX_EJB + jndiHomeName)) {
				home = (EJBLocalHome) cache.get(ServiceLocator.PRIFIX_EJB + jndiHomeName);
			} else {
				home = (EJBLocalHome) (new InitialContext()).lookup(ServiceLocator.PRIFIX_EJB + jndiHomeName);
				cache.put(jndiHomeName, home);
			}
		} catch (NamingException ne) {
			throw new Exception(ne);
		} catch (Exception e) {
			throw new Exception(e);
		}
		return home;
	}

	/**
	 * lookup(name, null);
	 * @return EJBObject remote interface.
	 * @param jndiHomeName The string representation of the Bean object.
	 */
	public EJBHome getRemoteHome(String jndiHomeName) throws Exception {
		EJBHome home = null;
		try {
			if (cache.containsKey(ServiceLocator.PRIFIX_EJB + jndiHomeName)) {
				home = (EJBHome) cache.get(ServiceLocator.PRIFIX_EJB + jndiHomeName);
			} else {
				Object objref = getInitialContext().lookup(ServiceLocator.PRIFIX_EJB + jndiHomeName);
				Class clazz = objref.getClass();
				System.out.println(clazz);
				home = (EJBHome) PortableRemoteObject.narrow(objref, clazz);
				cache.put(jndiHomeName, home);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return home;
	}

	/**
	 * ServiceLocator에서 가지는 Cache정보를 초기화 시킨다.
	 */
	public void initialize() {
		if (!cache.isEmpty()) {
			System.out.println("ServiceLocator cache data Intialize");
			cache = new HashMap();
		}
	}

	public static void main(String args[])
	{
		for(int i = 0; i < 10; i++)
		{
			long startTime = System.currentTimeMillis();
			try
			{
				EJBHome home = ServiceLocator.getInstance().getRemoteHome("ejb/bulk/ContinueVoyEJB");
			} catch (Exception e)
			{
				e.printStackTrace();
			}
			long endTime = System.currentTimeMillis();
			System.out.println("Process Time => " + ((endTime - startTime)));
		}
	}
}
