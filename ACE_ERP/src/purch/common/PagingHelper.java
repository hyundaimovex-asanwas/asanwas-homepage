/**
 * @author jwpark
 * 
 * 리스트 화면에서 페이지관련 정보를 저장  
 */

//package com.hmm.asan.common.util;
package purch.common;

public class PagingHelper {

	private int totalcount; //전체 글수
	private int totalpage;  //전체 페이지

	private int curpage = 1; //현재 페이지 번호

	private int pagesize = 10; //한 페이지당 글수
	private int groupsize = 10; // 하단에 표시될 페이지 넘버 리스트 수

	private int before = 0; //이전 페이지 번호
	private int after = 0;  //다음 페이지 번호

	private int beforegroup = 0; //이전 그룹 번호
	private int aftergroup = 0;  //다음 그룹 번호

	private int[] pages;  //하단에 표시될 페이지 번호 리스트

	public PagingHelper() {
	}

	public PagingHelper(int pagesize, int groupsize) {
	    this.groupsize = groupsize;
	    this.pagesize = pagesize;
	}

	/**
	 * 저장 되어 있는 값으로 페이징 데이터 생성
	 */
	public void setPageNav(){
		System.out.println("셋 페이지 네비e--->");
		int totalpage = 0;
		int totalgroup = 0;
		int curgroup = 0;
		int startpage = 0;
		int endpage = 0;

		totalpage =(int)Math.ceil(getTotalcount() / getPagesize());
		
		if(getTotalcount() % getPagesize() > 0) totalpage++;
		setTotalpage(totalpage);
		System.out.println("totalpage--->" + getTotalpage());
		
		totalgroup =(int)Math.ceil(totalpage / getGroupsize());
		if(totalpage % getGroupsize() > 0) totalgroup++;

		curgroup = (int)(getCurpage() / getGroupsize());
		if(getCurpage() % getGroupsize() > 0) curgroup++;

		startpage	= (int)((curgroup-1) * getGroupsize()) + 1;
		endpage	= (int)(curgroup * getGroupsize());

		if(startpage <= getGroupsize()){
			setBeforegroup(0);
		}else{
			setBeforegroup(startpage-1);
		}

		if(getCurpage() > 1 )
			setBefore(getCurpage() - 1);
		else
			setBefore(0);

		int j = 0;
		if(totalpage > endpage){
			int res_pages[] =  new int[endpage - startpage + 1];
			for(int i = startpage; i <= endpage; i++) {
				res_pages[j] = i;
				j++;
			}
			setPages(res_pages);
		}else{
			int res_pages[] =  new int[totalpage - startpage + 1];
			for(int i = startpage; i <= totalpage; i++) {
				res_pages[j] = i;
				j++;
			}
			setPages(res_pages);
		}

		if(getCurpage() <  totalpage)
			setAfter(getCurpage() + 1);
		else
			setAfter(0);

		if(endpage >= totalpage){
			setAftergroup(0);
		}else{
			setAftergroup(endpage + 1);
		}
	}
	/**
	 * @return
	 */
	public int getAfter() {
		return after;
	}

	/**
	 * @return
	 */
	public int getBefore() {
		return before;
	}

	/**
	 * @return
	 */
	public int[] getPages() {
		return pages;
	}

	/**
	 * @param i
	 */
	public void setAfter(int i) {
		after = i;
	}

	/**
	 * @param i
	 */
	public void setBefore(int i) {
		before = i;
	}

	/**
	 * @param is
	 */
	public void setPages(int[] is) {
		pages = is;
	}

	/**
	 * @param i
	 */
	public void setTotalcount(int i) {
		System.out.println("이건 setTotalcount?--->" +i);		
		totalcount = i;
	}

	/**
	 * @return
	 */
	public int getCurpage() {
		return curpage;
	}

	/**
	 * @return
	 */
	public int getGroupsize() {
		return groupsize;
	}

	/**
	 * @return
	 */
	public int getPagesize() {
		return pagesize;
	}

	/**
	 * @return
	 */
	public int getTotalcount() {
		return totalcount;
	}

	/**
	 * @param i
	 */
	public void setCurpage(int i) {
		System.out.println("이건 호출setCurpage?--->" +i);
		curpage = i;
	}

	/**
	 * @param d
	 */
	public void setGroupsize(int d) {
		groupsize = d;
	}

	/**
	 * @param d
	 */
	public void setPagesize(int d) {
		pagesize = d;
	}


	/**
	 * @return
	 */
	public int getTotalpage() {
		return totalpage;
	}

	/**
	 * @param i
	 */
	public void setTotalpage(int i) {
		totalpage = i;
	}

	/**
	 * @return
	 */
	public int getAftergroup() {
		return aftergroup;
	}

	/**
	 * @return
	 */
	public int getBeforegroup() {
		return beforegroup;
	}

	/**
	 * @param i
	 */
	public void setAftergroup(int i) {
		aftergroup = i;
	}

	/**
	 * @param i
	 */
	public void setBeforegroup(int i) {
		beforegroup = i;
	}

}
