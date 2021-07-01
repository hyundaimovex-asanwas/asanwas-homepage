package com.hmm.asan.asanway.support;

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

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;
import com.hmm.asan.common.util.WEBConstants;

import com.oreilly.servlet.MultipartRequest;


/**
 * 고객지원
 */
public class QnaBean {
    
    private String dirName = WEBConstants.SUPPORT_UPLOADDIR;
    private int maxFileSize = WEBConstants.SUPPORT_UPLOADMAX;
    
    
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
            
            String totalQuery = ("select count(*) count from asan.qna where category = '"+category+"' and isdel = '0' ");          
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
            
            
            String listQuery = "select a.idx, a.category, a.section, a.email, a.title, a.content, a.group, a.level, a.order, a.status, a.reguser, a.regtime, a.hit, b.name " +
                    " from asan.qna a " +
                    " left outer join ( " +
                    " select idx, name from asan.member ) as b " +
                    " on a.reguser = b.idx " +
                    " where a.category = '"+category+"' and a.isdel = '0' ";
            listQuery += whereQuery;
            listQuery += " order by group desc, level asc";
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
     * @2005. 10. 21
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("News Insert");
        
        MultiDAO mdao = new MultiDAO();
        
        int result = 0;
        
        //String totalQuery = ("SELECT COUNT(*) count FROM asan.notice");
        String totalQuery = ("SELECT MAX(IDX) count FROM asan.qna");
        String count = String.valueOf(mdao.getRowCount(totalQuery));
        
        if(count.equals("null")){
            count = "1";
        }
        
        int maxNo = Integer.parseInt(count)+1;
        //System.out.println(" No : " + maxNo);
        try {
            HttpSession session = request.getSession();
            
            String category = request.getParameter("category");
            
                        
            Enumeration params = request.getParameterNames();            
            
            String reguser = (String)request.getParameter("reguser");
            
            HashMap bean = new HashMap(10, 5);            
            
            while (params.hasMoreElements()) {
                
                String name = (String)params.nextElement();
                String value = request.getParameter(name);
                
                //System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }
            bean.put("level", "1");
            bean.put("order", "1"); // 답변글 
            
            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("regtime", request.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("lastip", request.getRemoteHost());
            
            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");
            
            // Insert
            System.out.println(bean);
            result =  mdao.insertQuery("asan.qna", bean);
            
            if( result > 0 ) {
                SendMail(request, response, maxNo, reguser);            
            }
            
            request.setAttribute("category", category);
            
        }catch (Exception e) {
            e.printStackTrace();
        }
        return result;
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
        if(category == null) {
            category = "qna";
        }
        
        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select idx, section, content, title, regtime, hit, level, group, reguser from asan.qna where category= '"+category+"' and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);
            
            
/*            *//**
             * 이전글, 아랫글
             *//*
            prevBean = mdao.selectQuery("SELECT * FROM ASAN.QNA WHERE GROUP > 1 AND category = '"+category+"' and isdel = 0 ORDER BY GROUP fetch first 1 rows only ");
            if(prevBean != null && prevBean.size() > 0) {
                HashMap h1 = (HashMap)prevBean.get(0);
                request.setAttribute("preview", h1);
            }
            
            *//**
             * 다음글, 윗글
             *//*
            nextBean = mdao.selectQuery("SELECT * FROM ASAN.QNA WHERE GROUP > 1 ORDER BY GROUP DESC category = '"+category+"' and isdel = 0 and idx < '"+ idx +"' )");
            if(nextBean != null && nextBean.size() > 0) {
                HashMap h2 = (HashMap)nextBean.get(0);
                request.setAttribute("nextview", h2);
            }*/
            
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
                        
            String idx = request.getParameter("idx");
            String category = request.getParameter("category");
            
            Enumeration params = request.getParameterNames();
            
            HashMap bean = new HashMap(5, 5);
            while (params.hasMoreElements()) {            
                String name = (String)params.nextElement();
                String value = request.getParameter(name);
                
                System.out.println(name +" = " + value );
                
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }
            
            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());                        
            
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
                    
            result = mdao.updateQuery("asan.qna", bean, " where idx = "+idx);
            System.out.println("result = " + result);
            
            request.setAttribute("idx", idx);
            request.setAttribute("category", category);
            
        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        
        return result;
        
    }
    
    /**
     * Update 로 isdel = 1 삭제
     * 원본글 삭제시 답변글까지 삭제
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        String group = request.getParameter("idx");
        String category = request.getParameter("category");
        
        MultiDAO dao = new MultiDAO();
        int result = 0;
        
        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");
            
            result = dao.updateQuery("update asan.qna set isdel = '1', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where group = " + group);
            
            request.setAttribute("category", category);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Update 로 isdel = 1 삭제
     * 답변글 삭제시 해당 답변글만 삭제.
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int DeleteUpdate1(HttpServletRequest request, HttpServletResponse response){
        String idx = request.getParameter("idx");
        String category = request.getParameter("category");
        
        MultiDAO dao = new MultiDAO();
        int result = 0;
        
        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");
            
            result = dao.updateQuery("update asan.qna set isdel = '1', " +
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
    
    /*
    * 관리자 답변시 해당 고객에게 답변메일 보내기
    */    
   public void SendMail(HttpServletRequest request, HttpServletResponse response, int idx, String reguser) {
       MultiDAO mdao = new MultiDAO();        

       HashMap read = null;

       try {
/*            Enumeration params = request.getParameterNames();                                    
           while (params.hasMoreElements()) {
               
               String name = (String)params.nextElement();
               String value = request.getParameter(name);
               
               System.out.println(name + " ==> " + value);
           }       */     
           

           
           //String name = Utility.ko( (String)request.getParameter("name"));
           //String from = Utility.ko( (String)request.getParameter("email"));
           
           String name = "현대아산";
           String from = "ymchoi@hdasan.com";
           String title = "";
           String body = "";

           String to_name  = "";
           String to_email = "";
           
           // 내용 가져오기            
           title =  (String)request.getParameter("title");
           body = (String)request.getParameter("content");

           String content = "";                
           
           // 메일 받을 사람 정보 가져오기
           ArrayList aa = mdao.selectQuery("select * from asan.member where idx = "+ reguser);
           HashMap hhh = (HashMap)aa.get(0);
                      
           to_name = (String)hhh.get("NAME");  
           to_email = (String)hhh.get("EMAIL");
           
           System.out.println(to_name);
           System.out.println(to_email);
           
           //to_name = "김종문";
           //to_email = "caesarczar@naver.com";
           
           Properties props = System.getProperties();
           props.put("mail.smtp.host", "localhost");                
           
           Session ss = Session.getDefaultInstance(props, null);
           Message msg = new MimeMessage(ss);

           String pathfile = request.getSession().getServletContext().getRealPath("/mail/ask.htm");
           BufferedReader br = new BufferedReader(new FileReader(pathfile));
                           
           String line = null;
           while ((line = br.readLine()) != null) {
               line = line.trim();
               
               if(line.indexOf("##TITLE##") >= 0) { 
                   line = line.replaceAll("##TITLE##", title);
               }
               
               if(line.indexOf("##CONTENT##") >= 0) { 
                   line = line.replaceAll("##CONTENT##", body);
               }
               
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
               System.out.println("메일발송성공");
           } catch ( Exception ee) {
               System.out.println("메일발송실패");
               System.out.println(ee.getMessage());
               ee.printStackTrace();
           }
           
       } catch (Exception e){ 
           System.out.println(e.getMessage());
           e.printStackTrace();
       }
       
   }   
   
}