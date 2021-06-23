package com.hmm.ejb.http;

import java.lang.reflect.Proxy;
import java.util.Hashtable;
import java.util.Map;

import com.hmm.ejb.http.vo.EJBDefVO;


public class HttpServiceFactory implements ServiceFactory {

    private static Map _serviceCache = new Hashtable();


    public HttpServiceFactory() {
        super();
    }

    public HttpServiceFactory(String host, int port, String serverContext) {
        this(null, host, port, serverContext);
    }

    public HttpServiceFactory(String protocole, String host, int port, String serverContext) {
        super();
        this.setProtocol(protocole);
        this.setHost(host);
        this.setPort(port);
        this.setServerContext(serverContext);
    }

    /**
     * Uses the ejbDefinition to return a DynamicProxy that will present the
     * "good face" to the client.
     */
    public Object getService(EJBDefVO p_service) {

        HttpServiceInvocationHandler service = null;
        Object dynamicProxy = null;

        dynamicProxy = _serviceCache.get(p_service);
        if (dynamicProxy == null) {
            service = new HttpServiceInvocationHandler(p_service);
            dynamicProxy = Proxy.newProxyInstance(HttpServiceInvocationHandler.class.getClassLoader(),
                    new Class[]{p_service.getRemoteClass()}, service);
            _serviceCache.put(p_service, dynamicProxy);
        }
        return dynamicProxy;
    }

    public void setPort(int port) {
        HttpSessionClient.getInstance().setPort(port);
    }

    public void setHost(String host) {
        HttpSessionClient.getInstance().setHost(host);
    }

    public void setProtocol(String protocole){
        HttpSessionClient.getInstance().setProtocol(protocole);
    }


    /**
     * @deprecated Use setServerContext() instead.
     * @param file
     */
    public void setServerFile(String file) {
        HttpSessionClient.getInstance().setServerFile(file);
    }

    /**
     * Set the context used at deployment time. For instance if the packaging of
     * the remoting war inside of the ear use the context myApp, you should call
     * setContext("myApp") on the HttpServiceFactory to reach the server.
     * @param context
     */
    public void setServerContext(String context){
        HttpSessionClient.getInstance().setContext(context);

    }

    public void setThreadCount(int count) {
        HttpSessionClient.getInstance().setThreadCount(count);
    }

    public void setLogin(String login) {
        HttpSessionClient.getInstance().setLogin(login);
    }

    public void setPassword(String password){
        HttpSessionClient.getInstance().setPassword(password);
    }
}