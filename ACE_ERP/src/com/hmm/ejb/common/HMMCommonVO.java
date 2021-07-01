/**
 * 작성일 : 2005-01-12
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.
 */
package com.hmm.ejb.common;

import java.io.Serializable;

import com.hmm.ejb.util.VOUtility;

/**
 * HMM EJB Common.HMMCommonVO.java.java
 */
public abstract class HMMCommonVO implements Serializable {
	private int targetPage = 1;
	private int pageRowCnt = 0;
	public static int EJB_IN = 1;
	public static int EJB_OUT = 2;
	public void printDebug(int inout)
	{
		try
		{
			VOUtility.getInstance().voToString(this, inout);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public int getTargetPage() {
		return targetPage;
	}

	public void setTargetPage(int targetPage) {
		this.targetPage = targetPage;
	}

	public int getPageRowCnt() {
		return pageRowCnt;
	}

	public void setPageRowCnt(int pageRowCnt) {
		this.pageRowCnt = pageRowCnt;
	}
}
