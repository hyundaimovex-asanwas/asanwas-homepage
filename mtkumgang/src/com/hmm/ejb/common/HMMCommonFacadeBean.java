/*
 * 작성된 날짜: 2005-01-10
 *
 * 이 생성된 파일에 대한 템플리트를 변경하려면 다음으로 이동하십시오.
 * 창&gt;환경설정&gt;Java&gt;코드 생성&gt;코드 및 주석
 */
package com.hmm.ejb.common;

import com.hmm.ejb.util.HMMException;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

/**
 * @author csangsu
 *
 * 이 생성된 유형 주석에 대한 템플리트를 변경하려면 다음으로 이동하십시오.
 * 창&gt;환경설정&gt;Java&gt;코드 생성&gt;코드 및 주석
 */
public abstract class HMMCommonFacadeBean implements SessionBean {
	protected SessionContext ctx = null;
	/* (비Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext ctx)
		throws EJBException, RemoteException {
			this.ctx = ctx;

	}

	/* (비Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
	}

	/* (비Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
	}

	/* (비Javadoc)
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
	}
	
	public void ejbCreate() throws CreateException {
	}
	
	public abstract HMMCommonVO show(HMMCommonVO aVo) throws  Exception;
	public abstract VOList list(HMMCommonVO aVo) throws  Exception;
	public abstract void update(HMMCommonVO aVo) throws  Exception;
	public abstract void delete(HMMCommonVO aVo) throws  Exception;
	public abstract void create(HMMCommonVO aVo) throws  Exception;
	public abstract VOList search(HMMCommonVO aVo) throws  Exception;
}
