package com.hmm.asan.www.cyber;

import java.io.File;
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

import com.oreilly.servlet.MultipartRequest;

/**
 * 관리자  - 스크랩 마스터 공통 (신문, 잡지, 방송, 인터넷)
 */
public class ScrapBean {

    private String dirName;
    private int maxFileSize;

    private String category;

    /**
     * @param category
     */
    public ScrapBean(String category) {
        this.category = category;
    }


    /**
     * @param dirName
     * @param maxFileSize
     * @param category
     */
    public ScrapBean(String dirName, int maxFileSize,String category) {
        this.dirName = dirName;
        this.maxFileSize = maxFileSize;
        this.category = category;
    }

    /**
     * 리스트
     * @author : ikara
     * @2005. 11. 14
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Scrap List");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String pubdate = request.getParameter("pubdate");
        String section1 = request.getParameter("section1");
        String section2 = request.getParameter("section2");		//신문 (가판 /종합판/석간 리스트 )

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String whereQuery = "";

        if( pubdate == null  ||  pubdate.equals("") || pubdate.equals("null")){
            pubdate = Utility.getCurrentDate();
        }
        whereQuery  += " and pubdate='" + pubdate + "'";

        System.out.println(pubdate);

        if( section1 != null && !section1.equals("") ){
            whereQuery  += " and section1='" + section1 + "'";
        }

        if( section2 != null  && !section2.equals("")){
            whereQuery  += " and section2='" + section2 + "'";
        }

        if( searchkey != null ){
            whereQuery  += " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);
        try{

            String totalQuery = ("SELECT COUNT(*) count FROM asan.scrap WHERE category = '"  + category + "' AND isdel = '0' ");
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

            String listQuery = "SELECT idx, section1, section2,  title, content,  hit  FROM asan.scrap  WHERE category = '"  + category + "' AND isdel = '0' ";
            listQuery += whereQuery;
            listQuery += " ORDER BY pubdate DESC, idx DESC";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 등록
     * @author : ikara
     * @2005. 11. 14
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Scrap  Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT MAX(IDX) count FROM asan.scrap");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }
        int maxNo = Integer.parseInt(count)+1;

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            Enumeration params = multi.getParameterNames();
            HashMap bean = new HashMap(10, 5);

            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("status", "1" );				//front 게시
            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regip", request.getRemoteHost());

            bean.remove("cmd");
            bean.remove("y");
            bean.remove("x");

            result =  mdao.insertQuery("asan.scrap", bean);

            if(result > 0 && category.equals("magazine")) {
                Enumeration files = multi.getFileNames();

                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);
                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put(name , filename);
                        fileBean.put("sys"+name, sysfilename);

                        mdao.updateQuery("asan.scrap", fileBean, " where idx = " + maxNo);
                    }
                }
            }
        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Read
     * @author : ikara
     * @2005. 11. 14
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("Scrap Read");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             * 글정보
             */
            beans = mdao.selectQuery("SELECT idx, pubdate, section1, section2,  title,  content, fileloc, imgfile, sysimgfile, hit, regtime  FROM asan.scrap  WHERE category = '" + category + "' and isdel = '0' and idx = " + idx );
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    /**
     *
     * 수정
     * @author : ikara
     * @2005. 11. 14
     */
    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Scrap Update");

        int result = 0;
        MultiDAO mdao = new MultiDAO();

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

               // if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgfiledel = multi.getParameter("imgfiledel");

            if( imgfiledel != null) {
                bean.put("imgfile", "");
                bean.put("sysimgfile", "");
            }

            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("imgfiledel");
            bean.remove("cmd");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");

            result = mdao.updateQuery("asan.scrap ", bean, " where idx = "+idx);

            if(category.equals("magazine")){
                Enumeration files = multi.getFileNames();

                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);

                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put(name , filename);
                        fileBean.put("sys"+name, sysfilename);

                        System.out.println(fileBean);

                        mdao.updateQuery("asan.scrap", fileBean, " where idx = " + idx);
                    }
                }
            }

            request.setAttribute("idx", idx);

        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }

        return result;

    }

    /**
     * 삭제
     * @author : ikara
     * @2005. 11. 14
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("Scrap DeleteUpdate");

        String idx = request.getParameter("idx");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.scrap set isdel = '1', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where idx = " + idx);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}