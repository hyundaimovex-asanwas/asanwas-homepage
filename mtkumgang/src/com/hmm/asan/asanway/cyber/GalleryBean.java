package com.hmm.asan.asanway.cyber;

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
 * 관리
 */
public class GalleryBean {

    private String dirName = WEBConstants.GALLERYUPLOADDIR;
    private int maxFileSize = WEBConstants.GALLERYUPLOADMAX;


    /**
     * 리스트
     * @author : Mr.K JM
     * @2005. 10. 10
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String whereQuery = "";
        String section1 = request.getParameter("section1");
        if( section1 != null && !section1.equals("")){
            whereQuery += " and section1='" + section1 + "'";
        }

        String section2 = request.getParameter("section2");
        if( section2 != null && !section2.equals("")){
            whereQuery += " and section2='" + section2 + "'";
        }

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");

        if( searchkey != null ){
            whereQuery += " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        String category = request.getParameter("category");
        if(category == null) category = "gallery";

        PagingHelper helper = new PagingHelper(8, 10);
        try{

            /*	        conn = UtilDB.getConnection("jdbc/asan");
             pstmt = conn.prepareStatement("SELECT * FROM SYSIBM.SYSVIEWS");
             rs   = pstmt.executeQuery();*/

            String totalQuery = ("select count(*) count from asan.gallery where category = '"+category+"' and isdel = '0' ");
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


            String listQuery = "select a.idx, a.title, a.hit, a.status, a.regtime, file, sysfile from asan.gallery a, " +
                    " asan.fileinfo b , (select max(idx) idx, boardidx from asan.fileinfo where boardname='"+category+"' GROUP BY boardidx ) c  " +
                    " where a.idx=b.boardidx and b.boardidx= c.boardidx and b.idx = c.idx and a.isdel = 0 and a.category = '"+category+"' ";
            listQuery += whereQuery;
            listQuery += " order by a.idx desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 추가
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT max(idx) count FROM asan.gallery");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }

        int maxNo = Integer.parseInt(count)+1;
        //System.out.println(" No : " + maxNo);
        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);
            //System.out.println("dirname = " + dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String category = multi.getParameter("category");
            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);

            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                //System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }


            bean.put("regid", session.getAttribute("adminid") );
            bean.put("regname", session.getAttribute("adminname") );

            bean.put("reguser", session.getAttribute("adminidx"));
            //bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));
            bean.put("regip", request.getRemoteHost());

            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");

            //System.out.println(bean);
            result =  mdao.insertQuery("asan.gallery", bean);
            //System.out.println("insert result = " + result);

            if(result > 0 ) {
                Enumeration files = multi.getFileNames();

                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);
                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put("file" , filename);
                        fileBean.put("sysfile", sysfilename);
                        fileBean.put("boardname", category);
                        fileBean.put("boardidx", String.valueOf(maxNo));

                        //System.out.println("Gallery File = " + fileBean);
                        //System.out.println(fileBean);
                        mdao.insertQuery("asan.fileinfo", fileBean);
                    }
                }
            }

            request.setAttribute("category", category);

        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            try {
                PrintWriter out = response.getWriter();
                response.setContentType("text/plain");
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB를 넘었습니다.")+"');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }

    /**
     * 글 내용 보기
     * @author : Mr.K JM
     * @2005. 10. 12
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

/*        ArrayList prevBean = null;
        ArrayList nextBean = null;*/

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";
        String category = request.getParameter("category");

        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select g.idx, title, g.category, f.idx fileidx, file, sysfile, section1, section2 from asan.gallery g, asan.fileinfo f " +
                    " where g.category= '"+category+"' and f.boardname= '"+ category +"' and  isdel = 0 and g.idx = f.boardidx and g.idx =  '" + idx + "' order by fileidx desc");
            request.setAttribute("read", beans);


/*            *//**
             * 이전글, 아랫글
             *//*
            prevBean = mdao.selectQuery("select idx, title, regtime, hit from asan.gallery " +
                    " where idx = (select min(idx) idx from asan.gallery where category = 'gallery' and isdel = 0 and idx > '"+ idx +"' )");
            if(prevBean != null && prevBean.size() > 0) {
                HashMap h1 = (HashMap)prevBean.get(0);
                request.setAttribute("preview", h1);
            }

            *//**
             * 다음글, 윗글
             *//*
            nextBean = mdao.selectQuery("select idx, title, regtime, hit from asan.gallery " +
                    " where idx = (select max(idx) idx from asan.gallery where category = 'gallery' and isdel = 0 and idx < '"+ idx +"' )");
            if(nextBean != null && nextBean.size() > 0) {
                HashMap h2 = (HashMap)nextBean.get(0);
                request.setAttribute("nextview", h2);
            }*/

        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 내용 수정
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int Update(HttpServletRequest request, HttpServletResponse response) {
        int result = 0;

        MultiDAO mdao = new MultiDAO();

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            String category = multi.getParameter("category");
            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgsdel = multi.getParameter("imgsdel");

            if( imgsdel!= null) {
                bean.put("imgs", "");
                bean.put("sysimgs", "");
            }

            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("fileidxlist");
            bean.remove("fileidxdelfg");
            bean.remove("fileidxcheck");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");

            result = mdao.updateQuery("asan.gallery", bean, " where idx = "+idx);
            //System.out.println("result = " + result);


            String fileidxlist[] = multi.getParameterValues("fileidxlist");
            String filedelfg[] = multi.getParameterValues("fileidxdelfg");

            for(int i = 0; fileidxlist != null && i < fileidxlist.length; i++) {
                System.out.println(filedelfg[i]);
                if(filedelfg[i].equals("1"))
                    mdao.updateQuery("delete from asan.fileinfo where idx =  " + fileidxlist[i] );
            }


            if( result > 0 ) {

                // 파일 업로드
                Enumeration files = multi.getFileNames();

                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);

                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put("file" , filename);
                        fileBean.put("sysfile", sysfilename);
                        fileBean.put("boardname", category);
                        fileBean.put("boardidx", idx);

                        System.out.println(fileBean);

                        mdao.insertQuery("asan.fileinfo", fileBean);
                    }
                }
            }

            request.setAttribute("idx", idx);
            request.setAttribute("category", category);

        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            try {
                PrintWriter out = response.getWriter();
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB를 넘었습니다.")+"');history.back();</script>");
                out.close();
            } catch(Exception e1){}
        }

        return result;

    }

    /**
     * Update 로 isdel = 1 삭제
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        String idx = request.getParameter("idx");
        String category = request.getParameter("category");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.gallery set isdel = '1', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where idx = " + idx);

            request.setAttribute("category", category);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}