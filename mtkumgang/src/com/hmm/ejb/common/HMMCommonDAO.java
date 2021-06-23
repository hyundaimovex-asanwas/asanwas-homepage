/**
 * 작성일 : 2005-01-12
 * 작성자 : csangsu
 * Copy Write : Hyundai Merchant Marine Co. LTD.....
 */
package com.hmm.ejb.common;

import com.hmm.ejb.util.HMMException;

/**
 * HMM EJB Common.HMMCommonDAO.java.java
 */
public abstract class HMMCommonDAO {
	public abstract HMMCommonVO show(HMMCommonVO aVo) throws Exception;
	public abstract VOList list(HMMCommonVO aVo) throws Exception;
	public abstract void update(HMMCommonVO aVo) throws Exception;
	public abstract void delete(HMMCommonVO aVo) throws Exception;
	public abstract void create(HMMCommonVO aVo) throws Exception;
	public abstract VOList search(HMMCommonVO aVo) throws Exception;
	
	protected int makePageInfo(int targetPage, int listTotalCnt, VOList result)
	{
		int rowCnt = 0;
		if(result.getFetchDataSize() == 0)
		{
			rowCnt = VOList.ROWCOUNT;
		}else
		{
			rowCnt = result.getFetchDataSize();
		}
		int targetStartCnt = (targetPage - 1) * rowCnt; //시작카운트 계산
		//int targetEndCnt = targetStartCnt +rowCnt;
		// 페이지계산 헤더
		// 페이지 계산 시작
		int totPage = listTotalCnt / rowCnt;
		if( listTotalCnt % rowCnt > 0 )
		{
			totPage++;
		}
		result.setCurPage(targetPage);
		result.setTotPage(totPage);
		result.setTotRows(listTotalCnt);
		System.out.println("target start Cnt => " + targetStartCnt);
		return targetStartCnt;
	}

}
