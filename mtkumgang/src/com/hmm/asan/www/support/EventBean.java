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
 * Event
 */
public class EventBean {
    
    private String dirName = WEBConstants.EVNET_UPLOADDIR;
    private int maxFileSize = WEBConstants.EVENT_UPLOADMAX;
    
    
    /**
     * 리스트
     * List(request, response, category);
     * @author : Mr.K JM
     * @ 2005. 10. 21
     */
    public void List(HttpServletRequest request, HttpServletResponse response, String category) {
        
        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;
        
        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        
        String whereQuery = "";
        if( searchkey != null ){
            whereQuery = " and " + searchkey + " like '%" + searchvalue + "%'";
        }
        
        PagingHelper helper = new PagingHelper(10, 10);
        try{
            
            /*	        conn = UtilDB.getConnection("jdbc/asan");
             pstmt = conn.prepareStatement("SELECT * FROM SYSIBM.SYSVIEWS");
             rs   = pstmt.executeQuery();*/
            
            String totalQuery = ("select count(*) count from asan.event where category = '"+category+"' and status = 1 and isdel = '0' ");          
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
            
            
            String listQuery = "select idx, title, startdate, enddate, regtime, progress, hit, status, img, sysimg " +
                    " from asan.event where category = '"+category+"' and status = 1 and  isdel = '0' ";
            listQuery += whereQuery;
            //listQuery += " order by idx desc";
            listQuery += " order by enddate desc, startdate desc ";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());
            
            request.setAttribute("list", list);
            request.setAttribute("helper", helper);
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        
        ArrayList prevBean = null;
        ArrayList nextBean = null;
        
        String idx = request.getParameter("idx");
        if(idx == null) idx ="";
        
        String category = request.getParameter("category");
        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select idx, title, startdate, enddate, img, sysimg, content, regtime, hit from asan.event " +
                    "where category= '"+category+"' and status = 1 and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);
            
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
    

}