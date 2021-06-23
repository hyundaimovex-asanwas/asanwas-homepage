/*
 * 작성된 날짜: 2005-01-10
 *
 * 이 생성된 파일에 대한 템플리트를 변경하려면 다음으로 이동하십시오.
 * 창&gt;환경설정&gt;Java&gt;코드 생성&gt;코드 및 주석
 */
package com.hmm.ejb.common;

import java.rmi.RemoteException;

/**
 * @author csangsu
 *
 * 이 생성된 유형 주석에 대한 템플리트를 변경하려면 다음으로 이동하십시오.
 * 창&gt;환경설정&gt;Java&gt;코드 생성&gt;코드 및 주석
 */
public interface HMMEJBCommonInterface {
	public abstract HMMCommonVO show(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract VOList list(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract void update(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract void delete(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract void create(HMMCommonVO aVo) throws RemoteException, Exception;
	public abstract VOList search(HMMCommonVO aVo) throws RemoteException, Exception;
}
