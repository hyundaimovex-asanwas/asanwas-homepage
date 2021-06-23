package com.hmm.ejb.http;

import java.io.Serializable;

import com.hmm.ejb.http.vo.EJBDefVO;

public class HttpServiceRequest implements Serializable {

    private EJBDefVO remoteService;
    private String methodName;
    private String[] paramTypesName;
    private Object[] args;

    /**
     * Constructor when using a stateless service
     * @param remoteService
     * @param methodToCall
     * @param paramTypes
     * @param args
     */
    public HttpServiceRequest(EJBDefVO remoteService, String methodToCall,
                              Class[] paramTypes, Object[] args) {
        this.remoteService = remoteService;
        this.methodName = methodToCall;
        setParamTypes(paramTypes);
        this.args = args;
    }

    public EJBDefVO getRemoteService() {
        return remoteService;
    }

    public void setRemoteService(EJBDefVO remoteService) {
        this.remoteService = remoteService;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    /**
     * @return The array of params of the invoked method.
     */
    public Class[] getParamTypes() {
        ClassLoader curClassLoader = this.getClass().getClassLoader();
        Class[] result = new Class[paramTypesName.length];
        for (int i = 0; i < paramTypesName.length; i++) {
            String type = paramTypesName[i];
            Class arg = null;
            if (type == null)
                arg = null;
            else if (type.equals("int"))
                arg = Integer.TYPE;
            else if (type.equals("boolean"))
                arg = Boolean.TYPE;
            else if (type.equals("float"))
                arg = Float.TYPE;
            else if (type.equals("byte"))
                arg = Byte.TYPE;
            else if (type.equals("short"))
                arg = Short.TYPE;
            else if (type.equals("char"))
                arg = Character.TYPE;
            else if (type.equals("long"))
                arg = Long.TYPE;
            else if (type.equals("double"))
                arg = Double.TYPE;
            else
                try {
                    arg = Class.forName(type);
                } catch (ClassNotFoundException e) {
                    throw new RuntimeException(e.getLocalizedMessage());
                }
            result[i] = arg;
        }
        return result;
    }

    public void setParamTypes(Class[] paramTypes) {
        paramTypesName = new String[paramTypes.length];
        for (int i = 0; i < paramTypes.length; i++) {
            Class type = paramTypes[i];
            paramTypesName[i] = type.getName();
        }
    }

    public Object[] getArgs() {
        return args;
    }

    public void setArgs(Object[] args) {
        this.args = args;
    }
}