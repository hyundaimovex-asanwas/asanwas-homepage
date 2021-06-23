package com.hmm.asan.www.support;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;
import com.hmm.asan.common.util.WEBConstants;

import com.oreilly.servlet.MultipartRequest;


/**
 * 고객지원
 */
public class PollBean {

    private String dirName = WEBConstants.POLL_UPLOADDIR;
    private int maxFileSize = WEBConstants.POLL_UPLOADMAX;


    /**
     * 리스트
     * List(request, response, category);
     * @author : Mr.K JM
     * @ 2005. 10. 21
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");

        String whereQuery = "";
        if( searchkey != null ){
            whereQuery = " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(5, 10);
        try{

            String totalQuery = ("select count(*) count from asan.poll where isdel = '0' and status = '1' ");
            totalQuery += whereQuery;
            int num = mdao.getRowCount(totalQuery);

            helper.setTotalcount(num);

            String selectPage = request.getParameter("page");
            int page = 0;
            if(selectPage == null || selectPage.equals("")) {
                page = 1;
            }else{
                page = Integer.parseInt(selectPage);
            }

            helper.setCurpage(page);
            helper.setPageNav();


            String listQuery = "select idx, title, startdate, enddate, regtime, status from asan.poll where isdel = '0' and status = '1' ";
            listQuery += whereQuery;
            listQuery += " order by regtime desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 글 내용 보기
     * @author : Mr.K JM
     * @2005. 10. 21
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        ArrayList readbean = null;

        String idx = request.getParameter("idx");
        if(idx == null) {
            ArrayList b = mdao.selectQuery("select IDX from asan.poll where isdel = 0 and status = 1 order by idx desc FETCH FIRST 1 ROWS ONLY");
            HashMap hh = (HashMap)b.get(0);
            idx = (String)hh.get("IDX");
        }

        String category = request.getParameter("category");
        try {
            /**
             * 현재 게시물 내용 보기
             */
            readbean = mdao.selectQuery("select a.idx, b.idx itemidx, a.title, a.startdate, a.enddate, a.status, a.regtime, b.item, b.img, b.sysimg, b.hit " +
                    " from asan.poll a, asan.pollitem b where a.idx = b.pollidx and a.idx = '"+idx+"'");
            request.setAttribute("readitem", readbean);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }


    public int UpdateHit(HttpServletRequest request, HttpServletResponse response){
        String itemidx = request.getParameter("itemidx");
        String idx = request.getParameter("idx");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();

            result = dao.updateQuery("update asan.pollitem  set hit = hit + 1 "+
                            " where idx = " + itemidx);

            request.setAttribute("idx", idx);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 메인
     * @author : ikara
     * @2005. 11.17
     */
       public void List(HttpServletRequest request, HttpServletResponse response, int count) {
           ArrayList list = null;
           MultiDAO mdao = new MultiDAO();

           try{
               String listQuery = "select idx, title, startdate, enddate, regtime, status from asan.poll where isdel = '0' and status = '1' ";
               listQuery += " order by idx desc ";
               listQuery += " FETCH FIRST " + count + " ROWS ONLY ";
               list = mdao.selectQuery(listQuery);

               request.setAttribute("_polllist", list);

           } catch (Exception e) {
               e.printStackTrace();
           }

       }


}