// Decompiled by DJ v3.2.2.67 Copyright 2002 Atanas Neshkov  Date: 2006-05-24 ¿ÀÈÄ 5:57:16
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   NewsBean.java

package com.hmm.asan.www.cyber;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NewsBean
{ 

    public NewsBean(String category)
    {
        this.category = category;
    }

    

    public String List2(HttpServletRequest request, HttpServletResponse response)
    {
        System.out.println("***** News List2 *****");
        String listQuery ="";
        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;
        String searchyear = request.getParameter("searchyear");
        String searchmonth = request.getParameter("searchmonth");
        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String whereQuery = "";
        if(searchyear != null && !searchyear.equals(""))
            whereQuery = whereQuery + " and year(regtime) = '" + searchyear + "'";
        if(searchmonth != null && !searchmonth.equals(""))
            whereQuery = whereQuery + " and month(regtime)  = '" + searchmonth + "'";
        if(searchkey != null)
            whereQuery = whereQuery + " and " + searchkey + " like '%" + searchvalue + "%'";
        PagingHelper helper = new PagingHelper(10, 10);
        try
        {
            String totalQuery = "select count(*) count from asan.notice where category = '" + category + "' and isdel = '0' and status='1'";
            totalQuery = totalQuery + whereQuery;
            int num = mdao.getRowCount(totalQuery);
            helper.setTotalcount(num);
            String selectPage = request.getParameter("page");
            int page = 0;
            if(selectPage == null || selectPage.equals(""))
                page = 1;
            else
                page = Integer.parseInt(selectPage);
            helper.setCurpage(page);
            helper.setPageNav();
            listQuery = "select idx, title, sysimgfile, summary, regtime, hit, status from asan.notice where category = '" + category + "' and isdel = '0'  and status='1'";
            listQuery = listQuery + whereQuery;
            listQuery = listQuery + " order by regtime desc";
            //list = mdao.selectQuery(listQuery, page, helper.getPagesize());
            request.setAttribute("list", list);
            request.setAttribute("helper", helper);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return listQuery;
    }

     
    public void List(HttpServletRequest request, HttpServletResponse response)
    {
        System.out.println("***** News List *****");
        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;
        String searchyear = request.getParameter("searchyear");
        String searchmonth = request.getParameter("searchmonth");
        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String whereQuery = "";
        if(searchyear != null && !searchyear.equals(""))
            whereQuery = whereQuery + " and year(regtime) = '" + searchyear + "'";
        if(searchmonth != null && !searchmonth.equals(""))
            whereQuery = whereQuery + " and month(regtime)  = '" + searchmonth + "'";
        if(searchkey != null)
            whereQuery = whereQuery + " and " + searchkey + " like '%" + searchvalue + "%'";
        PagingHelper helper = new PagingHelper(10, 10);
        try
        {
            String totalQuery = "select count(*) count from asan.notice where category = '" + category + "' and isdel = '0' and status='1'";
            totalQuery = totalQuery + whereQuery;
            int num = mdao.getRowCount(totalQuery);
            helper.setTotalcount(num);
            String selectPage = request.getParameter("page");
            int page = 0;
            if(selectPage == null || selectPage.equals(""))
                page = 1;
            else
                page = Integer.parseInt(selectPage);
            helper.setCurpage(page);
            helper.setPageNav();
            String listQuery = "select idx, title, sysimgfile, summary, regtime, hit, status from asan.notice where category = '" + category + "' and isdel = '0'  and status='1'";
            listQuery = listQuery + whereQuery;
            listQuery = listQuery + " order by regtime desc";
            list = mdao.selectQuery(listQuery, page, helper.getPagesize(),request,response);
            //request.setAttribute("listQuery", listQuery);
            request.setAttribute("list", list);
            request.setAttribute("helper", helper);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public void Read(HttpServletRequest request, HttpServletResponse response)
    {
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        ArrayList prevBean = null;
        ArrayList nextBean = null;
        String searchyear = request.getParameter("searchyear");
        String searchmonth = request.getParameter("searchmonth");
        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String whereQuery = "";
        if(searchyear != null && !searchyear.equals(""))
            whereQuery = whereQuery + " and year(regtime) = '" + searchyear + "'";
        if(searchmonth != null && !searchmonth.equals(""))
            whereQuery = whereQuery + " and month(regtime)  = '" + searchmonth + "'";
        if(searchkey != null)
            whereQuery = whereQuery + " and " + searchkey + " like '%" + searchvalue + "%'";
        String idx = request.getParameter("idx");
        if(idx == null)
            idx = "";
        try
        {
            beans = mdao.selectQuery("select idx, title, content, hit, regtime, imgfile, sysimgfile from asan.notice where category= '" + category + "' and isdel = '0' and status='1' and  idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);
            prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.notice A,  (select idx from asan.notice where category = '" + category + "' and isdel = 0 and status = '1' and regtime >'" + Utility.getDb2Time(hm.get("REGTIME").toString(), 1) + "' order by regtime ASC fetch first 1 rows only) B" + " WHERE A.idx= B.idx");
            if(prevBean != null && prevBean.size() > 0)
            {
                HashMap h1 = (HashMap)prevBean.get(0);
                request.setAttribute("preview", h1);
            }
            nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.notice A,  (select idx from asan.notice where category = '" + category + "' and isdel = 0 and status = '1' and regtime < '" + Utility.getDb2Time(hm.get("REGTIME").toString(), 0) + "' order by regtime DESC fetch first 1 rows only) B" + " WHERE A.idx = B.idx");
            if(nextBean != null && nextBean.size() > 0)
            {
                HashMap h2 = (HashMap)nextBean.get(0);
                request.setAttribute("nextview", h2);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    public void List(HttpServletRequest request, HttpServletResponse response, int count)
    {
        ArrayList list = null;
        MultiDAO mdao = new MultiDAO();
        try
        {
            String listQuery = "select idx, title, sysimgfile, summary, regtime, hit, status from asan.notice where category = '" + category + "' and isdel = '0'  and status='1'";
            listQuery = listQuery + " order by regtime desc ";
            listQuery = listQuery + " FETCH FIRST " + count + " ROWS ONLY ";
            list = mdao.selectQuery(listQuery);
            request.setAttribute("_newslist", list);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    private String category;
}