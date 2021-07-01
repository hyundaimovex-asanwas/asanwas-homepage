// Decompiled by DJ v3.2.2.67 Copyright 2002 Atanas Neshkov  Date: 2006-05-24 ¿ÀÈÄ 7:04:35
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   PagingHelper.java

package com.hmm.asan.common.util;


public class PagingHelper
{

    public PagingHelper()
    {
        curpage = 1;
        pagesize = 10;
        groupsize = 10;
        before = 0;
        after = 0;
        beforegroup = 0;
        aftergroup = 0;
    }

    public PagingHelper(int pagesize, int groupsize)
    {
        curpage = 1;
        this.pagesize = 10;
        this.groupsize = 10;
        before = 0;
        after = 0;
        beforegroup = 0;
        aftergroup = 0;
        this.groupsize = groupsize;
        this.pagesize = pagesize;
    }

    public void setPageNav()
    {
        int totalpage = 0;
        int totalgroup = 0;
        int curgroup = 0;
        int startpage = 0;
        int endpage = 0;
        totalpage = (int)Math.ceil(getTotalcount() / getPagesize());
        if(getTotalcount() % getPagesize() > 0)
            totalpage++;
        setTotalpage(totalpage);
        totalgroup = (int)Math.ceil(totalpage / getGroupsize());
        if(totalpage % getGroupsize() > 0)
            totalgroup++;
        curgroup = getCurpage() / getGroupsize();
        if(getCurpage() % getGroupsize() > 0)
            curgroup++;
        startpage = (curgroup - 1) * getGroupsize() + 1;
        endpage = curgroup * getGroupsize();
        if(startpage <= getGroupsize())
            setBeforegroup(0);
        else
            setBeforegroup(startpage - 1);
        if(getCurpage() > 1)
            setBefore(getCurpage() - 1);
        else
            setBefore(0);
        int j = 0;
        if(totalpage > endpage)
        {
            int res_pages[] = new int[(endpage - startpage) + 1];
            for(int i = startpage; i <= endpage; i++)
            {
                res_pages[j] = i;
                j++;
            }

            setPages(res_pages);
        } else
        {
            int res_pages[] = new int[(totalpage - startpage) + 1];
            for(int i = startpage; i <= totalpage; i++)
            {
                res_pages[j] = i;
                j++;
            }

            setPages(res_pages);
        }
        if(getCurpage() < totalpage)
            setAfter(getCurpage() + 1);
        else
            setAfter(0);
        if(endpage >= totalpage)
            setAftergroup(0);
        else
            setAftergroup(endpage + 1);
    }

    public int getAfter()
    {
        return after;
    }

    public int getBefore()
    {
        return before;
    }

    public int[] getPages()
    {
        return pages;
    }

    public void setAfter(int i)
    {
        after = i;
    }

    public void setBefore(int i)
    {
        before = i;
    }

    public void setPages(int is[])
    {
        pages = is;
    }

    public void setTotalcount(int i)
    {
        totalcount = i;
    }

    public int getCurpage()
    {
        return curpage;
    }

    public int getGroupsize()
    {
        return groupsize;
    }

    public int getPagesize()
    {
        return pagesize;
    }

    public int getTotalcount()
    {
        return totalcount;
    }

    public void setCurpage(int i)
    {
        curpage = i;
    }

    public void setGroupsize(int d)
    {
        groupsize = d;
    }

    public void setPagesize(int d)
    {
        pagesize = d;
    }

    public int getTotalpage()
    {
        return totalpage;
    }

    public void setTotalpage(int i)
    {
        totalpage = i;
    }

    public int getAftergroup()
    {
        return aftergroup;
    }

    public int getBeforegroup()
    {
        return beforegroup;
    }

    public void setAftergroup(int i)
    {
        aftergroup = i;
    }

    public void setBeforegroup(int i)
    {
        beforegroup = i;
    }

    private int totalcount;
    private int totalpage;
    private int curpage;
    private int pagesize;
    private int groupsize;
    private int before;
    private int after;
    private int beforegroup;
    private int aftergroup;
    private int pages[];
}