package com.hmm.asan.asanway.cyber;

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
 * 관리자  -아산인들의 수다 / 아산인들의 자료실
 */
public class AsanBean {

    private String dirName;
    private int maxFileSize;

    private String category;

    /**
     * @param category
     */
    public AsanBean(String category) {
        this.category = category;
    }


    /**
     * @param dirName
     * @param maxFileSize
     * @param category
     */
    public AsanBean(String dirName, int maxFileSize,String category) {
        this.dirName = dirName;
        this.maxFileSize = maxFileSize;
        this.category = category;
    }

    /**
     * 리스트
     * @author : ikara
     * @2005. 10. 24
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Asan List");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String whereQuery = "";

        if( searchkey != null ){
            whereQuery  = " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);
        try{

            String totalQuery = ("select count(*) count from asan.press where category = '"  + category + "' and isdel = '0' ");
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

            if (!category.equals("asantalk")){
                ArrayList filelist = null;
                String fileQuery = "select idx, boardidx, file, sysfile from asan.fileinfo where boardname = 'press' AND category='" + category +  "'" ;
                filelist = mdao.selectQuery(fileQuery);
                request.setAttribute("filelist", filelist);
            }

            String listQuery = "select idx, section, regname,  title, regtime, hit, status from asan.press where category = '"  + category + "' and isdel = '0' ";
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
     * 등록
     * @author : ikara
     * @2005. 10. 24
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Asan  Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT MAX(IDX) count FROM asan.press");
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

            //등록일
            String regtime = multi.getParameter("regday") + " " + Utility.getCurrentTime3();

            Enumeration params = multi.getParameterNames();
            HashMap bean = new HashMap(10, 5);

            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                //System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("status", "1" );				//front 게시
            bean.put("regid", session.getAttribute("adminid") );
            bean.put("regname", session.getAttribute("adminname") );

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", regtime);
            bean.put("regip", request.getRemoteHost());

            bean.remove("cmd");
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");

            if (!category.equals("asantalk")){
	            bean.remove("filesize");
	            bean.remove("filesizeK");
	            bean.remove("filecount");
	            bean.remove("file");
	            bean.remove("files");
            }

            // Insert
            result =  mdao.insertQuery("asan.press", bean);
            //System.out.println("insert result = " + result);


            if (result > 0 && !category.equals("asantalk")){
                Enumeration files = multi.getFileNames();

                while (files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    //System.out.println("name = " + name);
                    //System.out.println("filename = " + filename);

                    File f = multi.getFile(name);

                    if( f != null ) {

                        HashMap fileBean = new HashMap();
                        fileBean.put("file", filename);
                        fileBean.put("sysfile", sysfilename);

                        fileBean.put("boardname", "press");
                        fileBean.put("category", category  );
                        fileBean.put("boardidx", maxNo+ "");

                        // System.out.println("BBBBBBBB"+fileBean);
                        mdao.insertQuery("asan.fileinfo", fileBean);
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
     * @2005. 10. 24
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("Asan Read");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        ArrayList filebean = null;
        ArrayList viewmembean = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {

            /**
             * 글정보
             */
            beans = mdao.selectQuery("select idx, section, regname,  title,  content, hit, regtime  from asan.press where category = '" + category + "' and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);


            /**
             *첨부파일 정보
             */
            if(!category.equals("asantalk")){
                filebean = mdao.selectQuery("select idx, boardname, boardidx, file, sysfile, regtime from asan.fileinfo where boardname = 'press' and category = '" + category + "' and boardidx = '" + idx + "'");
                request.setAttribute("fileread", filebean);
            }


            /**
             * 공지/회람 게시판일 경우 미회람자 리스트
             */

            if(category.equals("asannotice")){
                viewmembean = mdao.selectQuery("SELECT (A.name || CASE WHEN C.cnt > 1 THEN '(' || A.id ||')' ELSE '' END) AS name  " +
                		" FROM asan.member A,(select name,count(*) cnt from asan.member where level = '2' group by name) C WHERE level = '2' AND A.name = C.name AND" +
                		"  NOT EXISTS (select midx from asan.viewmem B WHERE pidx = " + idx + "    AND A.idx = B.midx) ORDER BY A.name ASC");
                 request.setAttribute("viewmemlist", viewmembean);
            }

            /**
            *
            * 이전글
            */
           prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.press A, " +
                   " (select idx from asan.press where category = '" + category + "' and isdel = 0 and regtime >'"+ Utility.getDb2Time(hm.get("REGTIME").toString(), 1) +"' order by regtime ASC fetch first 1 rows only) B" +
                   " WHERE A.idx= B.idx");
           if(prevBean != null && prevBean.size() > 0) {
               HashMap h1 = (HashMap)prevBean.get(0);
               request.setAttribute("preview", h1);
           }

           /**
            *
            * 다음글
            */
           nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.press A, " +
                   " (select idx from asan.press where category = '" + category + "' and isdel = 0 and regtime < '"+ Utility.getDb2Time(hm.get("REGTIME").toString(),0) +"' order by regtime DESC fetch first 1 rows only) B" +
                   " WHERE A.idx = B.idx");
           if(nextBean != null && nextBean.size() > 0) {
               HashMap h2 = (HashMap)nextBean.get(0);
               request.setAttribute("nextview", h2);
           }

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    /**
     *
     * 수정
     * @author : ikara
     * @2005. 10. 24
     */
    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Asan Update");

        int result = 0;
        MultiDAO mdao = new MultiDAO();

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            String regtime = multi.getParameter("regday") + " " + Utility.getCurrentTime3();	//등록일

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                //System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("regtime", regtime);
            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("cmd");
            bean.remove("regday");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");

            if (!category.equals("asantalk")){
	            bean.remove("fileidxlist");
	            bean.remove("fileidxdelfg");
	            bean.remove("fileidxcheck");
            }

            result = mdao.updateQuery("asan.press", bean, " where idx = "+idx);
            //System.out.println("result = " + result);

            // asanpds 파일 정보 저장 start
            if (result > 0 && !category.equals("asantalk")){

	            String fileidxlist[] = multi.getParameterValues("fileidxlist");
	            String filedelfg[] = multi.getParameterValues("fileidxdelfg");

	            for(int i = 0; fileidxlist != null && i < fileidxlist.length; i++) {
	                //System.out.println(fileidxlist[i] + " = del : " + filedelfg[i]);
	                if(filedelfg[i].equals("1") ) {
	                    mdao.deleteQuery("delete from asan.fileinfo where idx =  " + fileidxlist[i] );
	                }
	            }

	            if(result > 0 ) {
	                Enumeration files = multi.getFileNames();

	                while (files.hasMoreElements()) {
	                    String name = (String)files.nextElement();              // fileform name
	                    String filename = (multi.getOriginalFileName(name));    // filename
	                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
	                    //String ContentType = (multi.getContentType(name));    // file contenttype
	                    //System.out.println(name + " = " + filename);

	                    File f = multi.getFile(name);
	                    if( f != null ) {
	                        HashMap fileBean = new HashMap();
                            fileBean.put("file", filename);
                            fileBean.put("sysfile", sysfilename);

                            fileBean.put("boardname", "press");
                            fileBean.put("category", category);
                            fileBean.put("boardidx", idx+ "");

                            //System.out.println("BBBBBBBB"+fileBean);
                            mdao.insertQuery("asan.fileinfo", fileBean);
	                    }
	                }
	            }
            } //asanpds 파일 저장 end

            //System.out.println("idx = "+ idx);
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
     * @2005. 10.24
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("Asan DeleteUpdate");

        String idx = request.getParameter("idx");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.press set isdel = '1', " +
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