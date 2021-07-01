package com.hmm.asan.www.cyber;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sun.awt.SunHints.Value;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;
import com.hmm.asan.common.util.WEBConstants;

import com.oreilly.servlet.MultipartRequest;


/**
 * 관리자 News 관리
 */
public class NewsletterBean {

    private String dirName = WEBConstants.NEWSLETTER_UPLOADDIR;
    private int maxFileSize = WEBConstants.NEWSLETTER_UPLOADMAX;


    /**
     * 리스트
     * @author : Mr.K JM
     * @2005. 10. 10
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String category = request.getParameter("category");
        if(category == null) category = "user";

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

            String totalQuery = ("select count(*) count from asan.letter where category = '" + category + "' and isdel = '0' ");
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

            String listQuery = "select idx, category, title, sendday, status, regtime from asan.letter where category = '" + category + "' and isdel = '0' ";
            listQuery += whereQuery;
            listQuery += " order by regtime desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            /**
             * 발송 결과
             */


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
        //System.out.println("News Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT COUNT(*) count FROM asan.letter");
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

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);

            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regip", request.getRemoteHost());

            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");

            // 등록
            result =  mdao.insertQuery("asan.letter", bean);
            //System.out.println("insert result = " + result);


            String img = (String)multi.getParameter("img");


            if(result > 0 ) {

                if (img.equals("etc")) {

                    Enumeration files = multi.getFileNames();

                    while(files.hasMoreElements()) {
                        String name = (String)files.nextElement();              // fileform name
                        String filename = (multi.getOriginalFileName(name));    // filename
                        String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                        //String ContentType = (multi.getContentType(name));    // file contenttype

                        File f = multi.getFile(name);
                        if( f != null ) {
                            HashMap fileBean = new HashMap();

                            fileBean.put("img" , filename);
                            fileBean.put("sysimg", sysfilename);

                            System.out.println(fileBean);

                            mdao.updateQuery("asan.letter", fileBean, " where idx = " + maxNo);
                        }
                    }
                } else {
                    mdao.updateQuery("update asan.letter set img = '"+ img +"', sysimg = '"+ img +"' where idx = " + maxNo);
                }
            }

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error Message = " + e.getMessage());
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

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";
        String category = request.getParameter("category");
        if( category == null) category = "user";
        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select idx, category, title, content, hit, regtime, img, sysimg from asan.letter " +
                    "where category= '" + category + "' and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);


            /**
            *
            * 이전글
            */
           prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.letter A, " +
                   " (select idx from asan.letter where category = '" + category + "' and isdel = 0 and regtime >'"+ Utility.getDb2Time(hm.get("REGTIME").toString(), 1) +"' order by regtime ASC fetch first 1 rows only) B" +
                   " WHERE A.idx= B.idx");
           if(prevBean != null && prevBean.size() > 0) {
               HashMap h1 = (HashMap)prevBean.get(0);
               request.setAttribute("preview", h1);
           }

           /**
            *
            * 다음글
            */
           nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.letter A, " +
                   " (select idx from asan.letter where category = '" + category + "' and isdel = 0 and regtime < '"+ Utility.getDb2Time(hm.get("REGTIME").toString(),0) +"' order by regtime DESC fetch first 1 rows only) B" +
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

            String imagedel = multi.getParameter("imagedel");

            if( imagedel != null) {
                bean.put("img", "");
                bean.put("sysimg", "");
            }

            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());

            bean.remove("imagedel");
            bean.remove("idx");
            bean.remove("x");
            bean.remove("y");
            bean.remove("img");
            bean.remove("regday");

            result = mdao.updateQuery("asan.letter", bean, " where idx = "+idx);
            System.out.println("result = " + result);

            String img = multi.getParameter("img");

            if( result > 0 ) {

                if (img.equals("etc")) {

                    Enumeration files = multi.getFileNames();

                    while(files.hasMoreElements()) {
                        String name = (String)files.nextElement();              // fileform name
                        String filename = (multi.getOriginalFileName(name));    // filename
                        String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                        //String ContentType = (multi.getContentType(name));    // file contenttype

                        File f = multi.getFile(name);
                        if( f != null ) {
                            HashMap fileBean = new HashMap();

                            fileBean.put("img", filename);
                            fileBean.put("sysimg", sysfilename);

                            System.out.println(fileBean);

                            mdao.updateQuery("asan.letter", fileBean, " where idx = " + idx);
                        }
                    }
                } else {
                    mdao.updateQuery("update asan.letter set img = '"+ img +"', sysimg = '"+ img +"' where idx = " + idx);
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

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.letter set isdel = '1', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where idx = " + idx);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }


    public int UpdateStatus(HttpServletRequest request, HttpServletResponse response){
        String idx = request.getParameter("idx");
        String status = request.getParameter("status");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.letter set status = '"+status+"', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where idx = " + idx);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }




    /**
     * 수신자 리스트
     */
    public void NewsletterMemberList(HttpServletRequest request, HttpServletResponse response) {

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String category = "user";

        String whereQuery = "";
        if( searchkey != null ){
            whereQuery = " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);
        try{

            String totalQuery = ("select count(*) count from asan.lettermem where isdel = '0'  AND category='" + category + "'");
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

            String listQuery = "select idx, name, email, regtime from asan.lettermem where isdel = '0' AND category='" + category + "'";
            listQuery += whereQuery;
            listQuery += " order by idx desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

            // 전체 회원 count
            String tQuery = "select count(*) count from asan.lettermem where isdel = '0' AND category='" + category + "'";
            int c = mdao.getRowCount(tQuery);
            request.setAttribute("totalcount", String.valueOf(c));

            // 금일 수신회원
            String todayQuery = "select count(*) todaycount from asan.lettermem where date(regtime) = date(current date) and isdel = '0' AND category='" + category + "'";
            int todaycount = mdao.getRowCount(todayQuery);
            request.setAttribute("todaycount", String.valueOf(todaycount));

        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }

    }


    /**
     * 뉴스레터 발송
     */

    public void SendMail(HttpServletRequest request, HttpServletResponse response) {
        MultiDAO mdao = new MultiDAO();

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";
        String category = request.getParameter("category");
        if( category == null) category = "user";


        ArrayList beans = null;
        HashMap read = null;

        int yes = 0;
        int no = 0;

        try {
            String name = "현대아산";
            String from = "webmaster@hmm21.com";
            String title = "";
            String img = "";
            String sysimg = "";
            String body = "";

            String to_name  = "";
            String to_email = "";

            // 뉴스레터 내용 가져오기
            Read(request, response);
            read = (HashMap)request.getAttribute("read");
            title = Utility.ko( (String)read.get("TITLE") );
            img =   Utility.ko( (String)read.get("IMG") );
            sysimg =   Utility.ko( (String)read.get("SYSIMG") );
            body = Utility.ko( (String)read.get("CONTENT"));

            // 수신자 리스트 가져오기
            beans = mdao.selectQuery("select name, email from asan.lettermem where category = '"+category+"' and isdel = '0'");
            //System.out.println(beans.size());
            for(int i = 0; i < beans.size(); i++) {
                String content = "";
                HashMap hm = (HashMap)beans.get(i);

                to_name = Utility.ko( (String)hm.get("NAME"));
                to_email = Utility.ko( (String)hm.get("EMAIL"));

                Properties props = System.getProperties();
                props.put("mail.smtp.host", "localhost");

                Session ss = Session.getDefaultInstance(props, null);
                Message msg = new MimeMessage(ss);

                String pathfile = request.getSession().getServletContext().getRealPath("/mail/newsletter.htm");
                BufferedReader br = new BufferedReader(new FileReader(pathfile));

                String line = null;
                while ((line = br.readLine()) != null) {
                    line = line.trim();
                    if(line.indexOf("##IMG##") >= 0)
                        line = line.replaceAll("##IMG##", img);

                    if(line.indexOf("##SYSIMG##") >= 0)
                        line = line.replaceAll("##SYSIMG##", sysimg);

                    if(line.indexOf("##TITLE##") >= 0)
                        line = line.replaceAll("##TITLE##", title);

                    if(line.indexOf("##CONTENT##") >= 0)
                        line = line.replaceAll("##CONTENT##", body);

                    content += line + " \n";
                }
                br.close();

                msg.setFrom(new InternetAddress(from, name));
                msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to_email, false));

                msg.setSubject(title);
                msg.setText(content);
                msg.setHeader("Content-Type", "text/html;charset=EUC-KR");
                msg.setSentDate(new java.util.Date());

                try {
                    Transport.send(msg);
                    mdao.insertQuery("insert into asan.letterrs(letteridx, name, email, status) values('"+idx+"','"+to_name+"','"+to_email+"','1')");
                    ++yes;
                } catch ( Exception e1) {
                    mdao.insertQuery("insert into asan.letterrs(letteridx, name, email, status) values('"+idx+"','"+to_name+"','"+to_email+"','0')");
                    ++no;
                    System.out.println(e1.getMessage());
                    e1.printStackTrace();
                }

                mdao.updateQuery("update asan.letter set sendday = '"+Utility.getCurrentDate()+"' where idx = '"+idx+"'");

                request.setAttribute("yes", String.valueOf(yes));
                request.setAttribute("no", String.valueOf(no));
            }


        } catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

}