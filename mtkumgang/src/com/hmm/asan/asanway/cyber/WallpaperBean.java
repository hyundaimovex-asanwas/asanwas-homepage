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
 * 관리자 - 월페이퍼 관리
 */
public class WallpaperBean {

    private String dirName = WEBConstants.WALLPAPERUPLOADDIR;
    private int maxFileSize = WEBConstants.WALLPAPERUPLOADMAX;


    /**
     * 목록
     * @author : ikara
     * @2005. 10. 25
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** wallpaper List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String category = "wallpaper";

        PagingHelper helper = new PagingHelper(4, 10);
        try{

            String totalQuery = ("select count(*) count from asan.ceotrend where category = '" +  category  + "' and isdel = '0' ");
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

            System.out.println(totalQuery);

            String listQuery = "select idx, img1, sysimg1, img2, sysimg2, img3, sysimg3,  status from asan.ceotrend where category = '" +  category  + "' and isdel = '0' ";
            listQuery += " order by idx desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    /**
     *  추가
     * @author : ikara
     * @2005. 10. 25
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("*****wallpaper Insert*****");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT MAX(IDX) count FROM asan.ceotrend");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }
        int maxNo = Integer.parseInt(count)+1;

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);
            //System.out.println("dirname = " + dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

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
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));
            bean.put("regip", request.getRemoteHost());

            // 불필요한 내용 삭제
            bean.remove("cmd");
            bean.remove("y");
            bean.remove("x");

            // Insert
            result =  mdao.insertQuery("asan.ceotrend", bean);

            if( result > 0 ) {
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

                        System.out.println(filename);

                        mdao.updateQuery("asan.ceotrend", fileBean, " where idx = " + maxNo);
                    }
                }
            }

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            try {
                PrintWriter out = response.getWriter();
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB를 넘었습니다.")+"');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }


    /**
     *  삭제
     * @author : ikara
     * @2005. 10. 25
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("*****wallpaper delete*****");

        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String lastuser = (String)session.getAttribute("adminidx");
            String lastip = request.getRemoteHost();

            result = dao.updateQuery("update asan.ceotrend set isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp where idx = " + idx);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}