/**
 * 작성일 : 2005-01-12
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.common;

import com.hmm.ejb.util.HMMException;

import javax.ejb.EJBHome;

/**
 * HMM EJB Common.HMMCommonDelegate.java.java
 */
public interface HMMCommonDelegate {
//	public abstract EJBHome getEJBHome() throws Exception;
	public abstract HMMCommonVO show(HMMCommonVO aVo) throws Exception;
	public abstract VOList list(HMMCommonVO aVo) throws Exception;
	public abstract void update(HMMCommonVO aVo) throws Exception;
	public abstract void delete(HMMCommonVO aVo) throws Exception;
	public abstract void create(HMMCommonVO aVo) throws Exception;
	public abstract VOList search(HMMCommonVO aVo) throws Exception;
}
