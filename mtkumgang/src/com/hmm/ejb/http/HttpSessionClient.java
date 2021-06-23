package com.hmm.ejb.http;

import org.apache.commons.codec.binary.Base64;

import com.hmm.ejb.http.vo.EJBDefVO;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.rmi.RemoteException;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class HttpSessionClient {

    private static int requestNb;

    private static final String UNAUTHENTICATED_SERVLET = "/httpSession";

    /** Default call method is http*/
    private static final String DEFAULT_PROTOCOL = "http";

    /** Default Server Host*/
    private static final String SERVER_HOST = "localHost";

    /** Default Server Port*/
    private static final int SERVER_PORT = 9080;

    /** Default Server File*/
    private static final String SERVER_CONTEXT = "WinsWEB";

    /** Default Server File*/
    private static final int DEFAULT_THREAD_COUNT = 1;

    /** BSF default mime type */
    private static final String MIME_TYPE = "application/x-bsf";



    /** The method used to transmit the call, the default is http but it can be https
     * to secure the communication ..
     */
    private String protocol;

    /** Where is the server */
    private String host;

    /**
     * The context used at deployment time.
     */
    private String context;


    /** Used for authentification */
    private String login;

    /** password used for basic authentification */
    private String pass;

    /** Http Port used */
    private int port = -1;

    /** The number of parallel thread used to perform the http call. */
    private int maxThreadCount = DEFAULT_THREAD_COUNT;

    /** The number of thread that are currently making a call */
    private int curUsedThread = 0;

    // Singleton attribute
    protected static HttpSessionClient _instance = null;

    /**
     * Default constructor
     */
    protected HttpSessionClient() {
        super();
        System.out.println( "Session client created." );

    }

    /**
     * Invokes a stateless remote service
     */
    public Object invoke( EJBDefVO p_service, Method m, Object[] args )
            throws Throwable {
        Object result = null;

        HttpServiceRequest request = new HttpServiceRequest(
                p_service, m.getName(), m.getParameterTypes(), args );

        //Making the http call
        result = invokeHttp( request );

        return result;
    }


    /**
     * Performs the http call.
     */
    private Object invokeHttp( HttpServiceRequest request ) throws Throwable {
	
        String file = getUnauthenticatedServerFile();

        int port = ( this.port == -1 ) ? SERVER_PORT : this.port;
        String host = ( this.host == null ) ? SERVER_HOST : this.host;
        String protocol = (this.protocol == null ) ? DEFAULT_PROTOCOL : this.protocol;

        try {
            int currentRequestNb = requestNb++;
            //System.out.println( "Start remote call " + currentRequestNb + " " + request.getMethodName() );

            HttpServiceResponse httpResponse;

            URL url = new URL( protocol, host, port, file );
			URLConnection con = url.openConnection();
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setUseCaches(false);

            ObjectOutputStream oos = new ObjectOutputStream(
            															new GZIPOutputStream(con.getOutputStream()));
//			new java.util.zip.GZIPOutputStream(httpURLConnection.getOutputStream()) con.getOutputStream() );
            oos.writeObject( request );
            oos.close();

            ObjectInputStream ois = new ObjectInputStream(new GZIPInputStream(con.getInputStream()));
            httpResponse = (HttpServiceResponse) ois.readObject();
            ois.close();

            //System.out.println( "Ending remote call " + currentRequestNb );
            if ( httpResponse.isExceptionThrown() )
                throw httpResponse.getThrowable();
            return httpResponse.getResult();

        } catch( java.io.IOException e ) {
        	e.printStackTrace();
            if (e instanceof RemoteException){
                throw e;
            }else{
                String message = "Failure during the http remote call on http://"
                        + host + ":" + port + file;
                e.printStackTrace();
                throw new RemoteException( message, e );
            }
        } catch( ClassNotFoundException e ) {
        	e.printStackTrace();
            String message = "Failure during the http remote call";
			e.printStackTrace();
            throw new RemoteException( message, e );
        }
    }



 
    /**
     * Singleton instanciation
     */
    public static HttpSessionClient getInstance() throws IllegalStateException {
        if ( _instance == null ) {
            _instance = new HttpSessionClient();
        }
        return _instance;
    }

    private boolean isAuthenticatedCall() {
        return login != null && pass != null;
    }


    public void setHost( String host ) {
        this.host = host;
    }

    /**
     * sets the used protocol. The default one is http but you can set it to
     * https to use a secure communication.
     * @param protocol
     */
    public void setProtocol( String protocol) {
        this.protocol = protocol;
    }

    /**
     * @deprecated setServerContext should be used instead.
     * @param serverFile the deployment context and the servlet. For instance /myApp/httpSession.
     */
    public void setServerFile( String serverFile ) {
        if ( ! serverFile.endsWith("httpSession")){
            throw new RuntimeException("You must use the method setContext() instead" +
                    " of the method setServerFile to define your remote call.");
        }
        String context = serverFile.substring(0, serverFile.length() - 11);
        setContext(context);
    }

    /**
     * Set the context used at deployment time. For instance if the packaging of
     * the remoting war inside of the ear use the context myApp, you should call
     * setContext("myApp") on the HttpServiceFactory to reach the server.
     *
     * @param context
     */
    public void setContext(String context) {
        while (context.endsWith("/")){
            context = context.substring(0,context.length() -1 );
        }
        this.context = context;
        System.out.println( "Server context is " + context);
    }

    /**
     * @return the server file to call for a unauthenticated call
     */
    private String getUnauthenticatedServerFile(){
        StringBuffer sb = new StringBuffer();
        sb.append('/');
        if (context != null){
            sb.append(context);
        }else{
            sb.append(SERVER_CONTEXT);
        }
        sb.append(UNAUTHENTICATED_SERVLET);
        return sb.toString();
    }

    public void setPort( int port ) {
        this.port = port;
    }

    public int getThreadCount() {
        return maxThreadCount;
    }

    public void setThreadCount( int threadCount ) {
        this.maxThreadCount = threadCount;

        System.out.println( "Max concurrent thread set to " + threadCount );
    }


    public void setLogin(String login) {
        this.login = login;
    }

    public void setPassword(String pass) {
        this.pass = pass;
    }
}