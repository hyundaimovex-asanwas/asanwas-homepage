package com.hmm.asan.asanway.admin;

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



import com.oreilly.servlet.MultipartRequest;


/**
 * 운영자 게시판 관리
 */
public class NoticeBean {

    private String dirName;
    private int maxFileSize;
    private String category;

    /**
     * @param category
     */
    public NoticeBean(String category) {
        this.category = category;
    }

    /**
     * @param dirName
     * @param maxFileSize
     * @param category
     */
    public NoticeBean(String dirName, int maxFileSize,String category) {
        this.dirName = dirName;
        this.maxFileSize = maxFileSize;
        this.category = category;
    }


    /**
     * 리스트
     * @author : ikara
     * @2005. 11.11
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("****adminnotice List****");
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
            String totalQuery = ("select count(*) count from asan.adminbbs where category = '" + category  + "' and isdel = '0' ");
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

            ArrayList filelist = null;
            String fileQuery = "select idx, boardidx, file, sysfile from asan.fileinfo where boardname = 'adminbbs' AND category='" + category  + "'";
            filelist = mdao.selectQuery(fileQuery);
            request.setAttribute("filelist", filelist);

            String listQuery = "select A.idx,A.regname, A.title, A.regtime, A.hit, A.level, B.email  from asan.adminbbs A ,  asan.admin B " +
            							"  WHERE A.reguser = B.idx AND  A.category = '" + category  + "' and A.isdel = '0' ";
            listQuery += whereQuery;
            listQuery += " ORDER BY  group DESC, order ASC";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 추가
     * @author : ikara
     * @2005. 11.11
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("****adminnotice Insert****");

        MultiDAO mdao = new MultiDAO();

        int result = 0;
        String isdel = "0";

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String group = multi.getParameter("group");
            String level = multi.getParameter("level");
            String order = multi.getParameter("order");

            String totalQuery = ("SELECT MAX(IDX) count FROM asan.adminbbs");
            String count = String.valueOf(mdao.getRowCount(totalQuery));

            if(count.equals("null")){
                count = "1";
            }
            int maxNo = Integer.parseInt(count)+1;

            if (group == null || group.equals("") || group.equals("null")){	//일반글
                group = Integer.toString(maxNo);
                level = "0";
                order = "0";
            }else{																							//답변글
                level = Integer.toString(Integer.parseInt(level)+ 1);
                order = Integer.toString(Integer.parseInt(order) + 1);
            }

            //기존글 정렬 변경
            mdao.updateQuery("UPDATE asan.adminbbs  SET order =order + 1 " +
            		"	WHERE group=" + group + " AND order >  " + order + "  AND category ='"  + category + "' ");

            Enumeration params = multi.getParameterNames();
            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.remove("group");
            bean.remove("level");
            bean.remove("order");

            bean.put("group", group);
            bean.put("level", level);
            bean.put("order", order);
            bean.put("isdel", isdel);
            bean.put("regid", session.getAttribute("adminid") );
            bean.put("regname", session.getAttribute("adminname") );

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));
            bean.put("regip", request.getRemoteHost());

            bean.remove("cmd");
            bean.remove("filesize");
            bean.remove("filesizeK");
            bean.remove("filecount");
            bean.remove("file");
            bean.remove("files");
            bean.remove("y");
            bean.remove("x");

            // Insert
            result =  mdao.insertQuery("asan.adminbbs", bean);

            if(result > 0 ) {
                Enumeration files = multi.getFileNames();

                while (files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);

                    if( f != null ) {
                        HashMap fileBean = new HashMap();
                        fileBean.put("file", filename);
                        fileBean.put("sysfile", sysfilename);

                        fileBean.put("boardname", "adminbbs");
                        fileBean.put("boardidx", maxNo+ "");
                        fileBean.put("category", "adminnotice");

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
     * 내용 보기
     * @author : ikara
     * @2005. 11.11
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("****adminnotice Read****");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        ArrayList filebean = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");

        if(idx == null) idx ="";

        try {
            /**
             * 현재 글 내용
             */
            beans = mdao.selectQuery("select A.idx, regname, title,  content, hit, A.regtime, group, level, order, A.reguser  from asan.adminbbs A ,  asan.admin B " +
					"  WHERE A.reguser = B.idx AND  A.category = '" + category  + "' and A.idx = "  + idx + " and A.isdel = '0' ");

            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

            String group = (String)hm.get("GROUP");
            String order = (String)hm.get("ORDER");

            /**
             * 글에 등록된 파일 내용 가져오기
             */
            filebean = mdao.selectQuery("select idx, boardname, boardidx, file, sysfile, regtime from asan.fileinfo where boardname = 'adminbbs' AND category='" + category  + "' and boardidx = '" + idx + "'");
            request.setAttribute("fileread", filebean);

            /**
             * 이전 글
             */
            prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.adminbbs A, " +
                    " (select idx from asan.adminbbs where category = '" + category + "' and isdel = '0'  and group >=" + group + " and order < " + order + " order by group  ASC, order DESC  fetch first 1 rows only) B" +
                    " WHERE A.idx= B.idx");
            if(prevBean != null && prevBean.size() > 0) {
                HashMap h1 = (HashMap)prevBean.get(0);
                request.setAttribute("preview", h1);
            }

            /**
             * 다음 글
             */
            nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.adminbbs A, " +
                    " (select idx from asan.adminbbs where category = '" + category + "' and isdel = '0'  and group <= " + group + " and order  > " + order + " order by  group  DESC, order ASC fetch first 1 rows only) B" +
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
    * 수정
    * @author : ikara
    * @2005. 11.11
    */
    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("****adminnotice Update****");

        int result = 0;

        MultiDAO mdao = new MultiDAO();

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);
            String adminidx = (String)session.getAttribute("adminidx");

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());
            String idx = multi.getParameter("idx");

            // 1.작성자 확인
            String query = "SELECT count(*) count FROM asan.adminbbs WHERE category = '" + category + "' AND idx = " + idx + " AND reguser=" + adminidx + "";
            int count = mdao.getRowCount(query);

            if(count == 0 && !session.getAttribute("admingrade").toString().equals("0")){
                return result = -1 ;		//작성자가 일치 하지 않음
            }

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }


            bean.put("lastuser", adminidx);
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("cmd");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("fileidxlist");
            bean.remove("fileidxdelfg");
            bean.remove("fileidxcheck");

            result = mdao.updateQuery("asan.adminbbs", bean, " where idx = "+idx);
            //System.out.println("result = " + result);

            String fileidxlist[] = multi.getParameterValues("fileidxlist");
            String filedelfg[] = multi.getParameterValues("fileidxdelfg");

            for(int i = 0; fileidxlist != null && i < fileidxlist.length; i++) {
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

                    File f = multi.getFile(name);

                    if( f != null ) {

                        HashMap fileBean = new HashMap();

                        fileBean.put("file", filename);
                        fileBean.put("sysfile", sysfilename);

                        fileBean.put("boardname", "adminbbs");
                        fileBean.put("boardidx", idx+ "");
                        fileBean.put("category", "adminnotice");
                        mdao.insertQuery("asan.fileinfo", fileBean);

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
    * @2005.11.11
    */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("****adminnotice DeleteUpdate****");

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            // 1.작성자 확인
            String query = "SELECT count(*) count FROM asan.adminbbs WHERE category = '" + category + "' AND idx = " + idx + " AND reguser=" + adminidx + "";
            int count = dao.getRowCount(query);

            if(count == 0 && !session.getAttribute("admingrade").toString().equals("0")){
                return result = -1 ;		//작성자가 일치 하지 않음
            }

            result = dao.updateQuery("update asan.adminbbs set isdel = '1', " +
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