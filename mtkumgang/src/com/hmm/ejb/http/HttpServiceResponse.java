package com.hmm.ejb.http;

import java.io.Serializable;

public class HttpServiceResponse implements Serializable {
    private Throwable throwable;
    private Object result;

    public HttpServiceResponse(Throwable throwable) {
        this.throwable = throwable;
    }

    public HttpServiceResponse(Object result) {
        this.result = result;
    }

    public Throwable getThrowable() {
        return throwable;
    }

    public void setThrowable(Throwable throwable) {
        this.throwable = throwable;
    }

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }

    public boolean isExceptionThrown() {
        if (throwable != null) return true;
        return false;
    }
}