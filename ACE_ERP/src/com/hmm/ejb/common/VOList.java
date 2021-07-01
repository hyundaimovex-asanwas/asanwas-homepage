/*
 * Created on 2004-05-31
 */
package com.hmm.ejb.common;

import java.util.ArrayList;

/**
 * @author �ֻ��
 */
public class VOList extends ListChunk
{
	// bean for ����Ʈ�� ����� ������ ������ ã�� ����� bean�� arraylist�� ��� ����
	public final static int ROWCOUNT=15;
	public final static int PAGECOUNT=10;
	private int fetchDataSize = 0; // �ѹ��� ������ ������ ����

	public VOList() 
	{
	}

	public VOList(int curPage, int totPage, int totRows, ArrayList listData)
	{
		setCurPage(curPage);
		setTotPage(totPage);
		setTotRows(totRows);
		if(getFetchDataSize() > 0)
		{
			setDataFetchSize(listData);
		}else
		{
			setListData(listData);
		}
	}

	public void setVOList(ArrayList al)
	{
		if(getFetchDataSize() > 0)
		{
			setDataFetchSize(al);
		}else
		{
			setListData(al);
		}
	}
	
	private void setDataFetchSize(ArrayList al)
	{
		setListData(al.subList(0, getFetchDataSize()));
	}

	public void setFetchDataSize(int fetchDataSize)
	{
		this.fetchDataSize = fetchDataSize;
	}

	public int getFetchDataSize()
	{
		return fetchDataSize;
	}
}
