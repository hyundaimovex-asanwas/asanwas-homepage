/*
 * �ۼ��� ��¥: 2005-01-10
 *
 * �� ������ ���Ͽ� ���� ���ø�Ʈ�� �����Ϸ��� �������� �̵��Ͻʽÿ�.
 * â&gt;ȯ�漳��&gt;Java&gt;�ڵ� ����&gt;�ڵ� �� �ּ�
 */
package com.hmm.ejb.common;

import java.rmi.RemoteException;

/**
 * @author csangsu
 *
 * �� ������ ���� �ּ��� ���� ���ø�Ʈ�� �����Ϸ��� �������� �̵��Ͻʽÿ�.
 * â&gt;ȯ�漳��&gt;Java&gt;�ڵ� ����&gt;�ڵ� �� �ּ�
 */
public interface HMMEJBCommonInterface {
	public abstract HMMCommonVO show(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract VOList list(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract void update(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract void delete(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract void create(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract VOList search(HMMCommonVO aVo) throws RemoteException, Exception;
}
