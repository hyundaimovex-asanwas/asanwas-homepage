/*
 * Created on 2004-05-31
 */
package com.hmm.ejb.common;

import java.io.Serializable;
import java.util.Collection;

/**
 * @author ÃÖ»ó¼ö
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class ListChunk implements Serializable
{
	protected int curPage;
	protected int totPage;
	protected int totRows;
	protected Collection listData = null;
	protected Object masterVO = null;
	protected Object attachVO = null;
	protected Object ordinaryVO = null;
 
	public int getCurPage() { return curPage; }
	public int getTotPage() { return totPage; }
	public int getTotRows() { return totRows; }
	public Collection getListData() { return listData; }
	public Object getMasterVO() { return masterVO; }
	public Object getAttachVO() { return attachVO; }
	public Object getOrdinaryVO() { return ordinaryVO; }

	public void setCurPage(int curPage) { this.curPage=curPage; }
	public void setTotPage(int totPage) { this.totPage=totPage; }
	public void setTotRows(int totRows) { this.totRows=totRows; }
	public void setListData(Collection listData) { this.listData=listData; }
	public void setMasterVO(Object masterVO) { this.masterVO = masterVO; }
	public void setAttachVO(Object attachVO) { this.attachVO = attachVO; }
	public void setOrdinaryVO(Object ordinaryVO) { this.ordinaryVO = ordinaryVO; }
}
