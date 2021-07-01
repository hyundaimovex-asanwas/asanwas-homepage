package com.hmm.ejb.http;

import com.hmm.ejb.http.vo.EJBDefVO;

public interface ServiceFactory {

    /**
     * Retrieves a ref on a service
     * @param service
     * @return The reference on the service
     */
    Object getService(EJBDefVO service);
}
