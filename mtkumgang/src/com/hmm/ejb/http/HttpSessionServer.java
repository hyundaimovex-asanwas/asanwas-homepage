package com.hmm.ejb.http;

import com.hmm.ejb.common.web.ServiceLocator;
import com.hmm.ejb.http.vo.EJBDefVO;

import javax.ejb.EJBHome;
import javax.ejb.EJBObject;
import javax.ejb.Handle;
import javax.ejb.EJBException;
import javax.naming.Context;
import javax.rmi.PortableRemoteObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.rmi.NoSuchObjectException;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.Hashtable;
import java.util.Map;
import java.security.Principal;

public class HttpSessionServer extends HttpServlet {

    private static Context _ejbContext;


    /**
     * Uses the properties defined in the servlet environment to instantiate the
     * principalManager and the initial context properties.
     */
    public void init() throws ServletException {
		try
		{
			_ejbContext = ServiceLocator.getInstance().getInitialContext();
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
    }
    
    protected void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException
    {
    	System.out.println("bbb");
    	doPost(request, response);
    }

    /**
     * The only http call used by the client side is POST in order to deal with unlimited (??)
     * size of stream.
     */
    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

		long startTime = System.currentTimeMillis();
        //Extract the serviceRequest from the stream
        HttpServiceRequest httpServiceRequest = getHttpServiceRequest( request );
        HttpServiceResponse httpServiceResponse = null;
        EJBObject remoteRef;

        try {


            //retrieve the service reference
            remoteRef = getEjbReference( httpServiceRequest, request );

            //We can make the remote call
            httpServiceResponse = processRemoteCall( remoteRef, httpServiceRequest, request );

        } catch( NoSuchObjectException e ) {
			e.printStackTrace();
        } catch (Exception e)
		{
			e.printStackTrace();
		}
        writeHttpServiceResponse( response, httpServiceResponse );
        long endTime = System.currentTimeMillis();
        System.out.println("working time = > " + (endTime - startTime));
    }

    /**
     * Retrieves the reference to the EJBObject by the definition or by the cache depending
     * on the request.
     */
    private EJBObject getEjbReference( HttpServiceRequest httpServiceRequest, HttpServletRequest request ) throws Exception {
        return getRemote( httpServiceRequest.getRemoteService() );
    }


    /**
     */
    private HttpServiceResponse processRemoteCall( EJBObject remoteService,
                                                   HttpServiceRequest httpServiceRequest, HttpServletRequest request )
            throws NoSuchObjectException {

        HttpServiceResponse httpServiceResponse;
        try {
            String p_methodName = httpServiceRequest.getMethodName();
            Class[] paramTypes = httpServiceRequest.getParamTypes();
            Object[] p_args = httpServiceRequest.getArgs();

            Object remoteResult = null;

            if ( remoteService == null )
                throw new IllegalArgumentException
                        ( "UserSessionBean : The remote must be not null" );

            if ( p_methodName == null )
                throw new IllegalArgumentException
                        ( "UserSessionBean : The invoked method must be not null" );


            Method invokedMethod = remoteService.getClass().getMethod( p_methodName,
                                                                       paramTypes );

            System.out.println( "Invoking : " + p_methodName );
            remoteResult = invokedMethod.invoke( remoteService, narrowArgs( p_args ) );

            httpServiceResponse = new HttpServiceResponse( remoteResult );
        } catch( InvocationTargetException e ) {
            if ( e.getTargetException() instanceof NoSuchObjectException ) {
                NoSuchObjectException noSuchObjectException = (NoSuchObjectException) e.getTargetException();
                throw noSuchObjectException;
            }

            //The target exception is the only result sent back on the client
            httpServiceResponse = new HttpServiceResponse( e.getTargetException() );
        } catch( NoSuchMethodException ex ) {
            throw new RuntimeException( ex.getLocalizedMessage() );
        } catch( IllegalAccessException ex ) {
            throw new RuntimeException( ex.getLocalizedMessage() );
        }
        return httpServiceResponse;
    }

    /**
     * writes the response in the http stream
     */
    private void writeHttpServiceResponse( HttpServletResponse response, HttpServiceResponse httpServiceResponse ) throws IOException {
        OutputStream outputStream =  new java.util.zip.GZIPOutputStream(response.getOutputStream());
        ObjectOutputStream oos = new ObjectOutputStream( outputStream );
        oos.writeObject( httpServiceResponse );
        oos.close();
    }

    /**
     * gets the request from the http stream
     */
    private HttpServiceRequest getHttpServiceRequest( HttpServletRequest request )
            throws IOException {
        //On recupere la requete dans le flux d'entree
        ObjectInputStream ois = new ObjectInputStream( new java.util.zip.GZIPInputStream(request.getInputStream()));

        HttpServiceRequest httpServiceRequest = null;
        try {
            httpServiceRequest = (HttpServiceRequest)
                    ois.readObject();
        } catch( ClassNotFoundException e ) {
        	e.printStackTrace();
            throw new RuntimeException(e.getLocalizedMessage());
        }
        ois.close();
        return httpServiceRequest;
    }


    /**
     * Used for a call on a stateless service. The first time this method is called
     * on a service the remote service is created by the invocation of the create method
     * on the EJBHome.
     */
    private EJBObject getRemote( EJBDefVO p_service ) throws Exception {
        EJBObject result = null;
		EJBHome home = ServiceLocator.getInstance().getRemoteHome(p_service.getJndiName());
        Method createMethod = home.getClass().getMethod( "create", null );
         result = (EJBObject) createMethod.invoke( home, null );
        return result;
    }

    /**
     * Allows the session to have remote EJBObject as arguments
     */
    private static Object[] narrowArgs( Object[] p_args ) {
        if ( p_args == null ) return null;
        int length = p_args.length;
        Object[] result = new Object[ length ];
        for ( int i = 0 ; i < length ; i++ ) {
            if ( p_args[ i ] instanceof Remote )
                result[ i ] = PortableRemoteObject.narrow( p_args[ i ], EJBObject.class );
            else
                result[ i ] = p_args[ i ];
        }
        return result;
    }
}