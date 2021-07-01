/*
 * �ۼ��� ��¥: 2005-01-10
 *
 * �� ������ ���Ͽ� ���� ���ø�Ʈ�� �����Ϸ��� �������� �̵��Ͻʽÿ�.
 * â&gt;ȯ�漳��&gt;Java&gt;�ڵ� ����&gt;�ڵ� �� �ּ�
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
 * �� ������ ���� �ּ��� ���� ���ø�Ʈ�� �����Ϸ��� �������� �̵��Ͻʽÿ�.
 * â&gt;ȯ�漳��&gt;Java&gt;�ڵ� ����&gt;�ڵ� �� �ּ�
 */
public abstract class HMMCommonFacadeBean implements SessionBean {
	protected SessionContext ctx = null;
	/* (��Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext ctx)
		throws EJBException, RemoteException {
			this.ctx = ctx;

	}

	/* (��Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
	}

	/* (��Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
	}

	/* (��Javadoc)
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
