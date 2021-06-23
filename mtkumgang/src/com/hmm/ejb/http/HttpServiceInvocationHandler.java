package com.hmm.ejb.http;

import javax.ejb.EJBObject;

import com.hmm.ejb.http.vo.EJBDefVO;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class HttpServiceInvocationHandler implements InvocationHandler {

    private Object _remote = null;
    private EJBDefVO _service = null;

    private int _connectionMode;

    /**
     * This constructor is used for a stateless service
     */
    public HttpServiceInvocationHandler(EJBDefVO p_service) {
        _service = p_service;
    }

    /**
     * This method is called on every call on the interface
     */
    public Object invoke(Object p_proxy, Method p_method, Object[] p_args) throws Throwable {
        return HttpSessionClient.getInstance().invoke(_service, p_method, p_args);
    }
}