package com.hmm.asan.www.company;

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


/**
 * �����  Ceo ����  ����
 */
public class ActivityBean {

    private String dirName = WEBConstants.CEOTRENDUPLOADDIR;
    private int maxFileSize = WEBConstants.CEOTRENDUPLOADMAX;

    /**
     * ����� Ceo ���� ����Ʈ
     * @author : ikara
     * @2005. 10. 14
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Ceo ���� List *****");

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

            String totalQuery = ("select count(*) count from asan.ceotrend where category = 'ceotrend' and isdel = '0' and status='1'");
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

            String listQuery = "select idx, title, content, sysimg1, sysimg2, sysimg3, regtime, hit, status from asan.ceotrend where category = 'ceotrend' and isdel = '0' and status='1' ";
            listQuery += whereQuery;
            listQuery += " order by regtime desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);


        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

    }



    /**
     * ����� Ceo ���� read
     * @author : ikara
     * @2005. 10. 14
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Ceo ���� Read *****");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;


        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             * ���� �Խù� ���� ����
             */
            beans = mdao.selectQuery("select idx, title, content, sysimg1, sysimg2, sysimg3, regtime, hit, status from asan.ceotrend where category= 'ceotrend' and isdel = '0' and status='1' and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
}


