package com.hmm.asan.www.support;

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
            
            HttpSession session = request.getSession();            
            String memberidx = (String)session.getAttribute("memberidx");
            
            /*	        conn = UtilDB.getConnection("jdbc/asan");
             pstmt = conn.prepareStatement("SELECT * FROM SYSIBM.SYSVIEWS");
             rs   = pstmt.executeQuery();*/
            
            String totalQuery = ("select count(*) count from asan.qna where category = '"+category+"' and isdel = '0' and REGUSER = '"+memberidx+"'");          
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
            
            
            String listQuery = "select idx, category, section, email, title, content, group, level, order, reguser, regtime, lastuser " +
                    " from asan.qna  " +
                    " where category = 'qna' and isdel = '0' and reguser = '"+memberidx+"' ";
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
        
        String totalQuery = ("SELECT COUNT(IDX) count FROM asan.qna");
        String count = String.valueOf(mdao.getRowCount(totalQuery));
        
        if(count.equals("null")){
            count = "1";
        }
        
        int maxNo = Integer.parseInt(count)+1;
        //System.out.println(" No : " + maxNo);
        try {
            HttpSession session = request.getSession();
                        
            HashMap bean = new HashMap(10, 5);
            Enumeration params = request.getParameterNames();                                    
            while (params.hasMoreElements()) {
                
                String name = (String)params.nextElement();
                String value = request.getParameter(name);
                
                //System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }
                        
            
            bean.put("reguser", session.getAttribute("memberidx"));
            //bean.put("regtime", request.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));
            bean.put("regip", request.getRemoteHost());
            bean.put("group", maxNo+"");
            
            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");
            bean.remove("adminemail");
            bean.remove("name");
            bean.remove("adminname");
            
            // Insert
            System.out.println(bean);
            result =  mdao.insertQuery("asan.qna", bean);
            
            if( result > 0 ) {
                SendMail(request, response, maxNo);            
            }
                        
            
        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
        
    /**
     * 글 내용 보기
     * @author : Mr.K JM
     * @2005. 10. 21
     */
    public void Read(HttpServletRequest request, HttpServletResponse response, String category){
        
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        
        ArrayList prevBean = null;
        ArrayList nextBean = null;
        
        String idx = request.getParameter("idx");
        if(idx == null) idx ="";
        
        String group = request.getParameter("group");
        if(group == null) group ="";
        
        
        try {
            HttpSession session = request.getSession();
            String memberidx = (String)session.getAttribute("memberidx");
            
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select idx, section, title, content, regtime from asan.qna where category = 'qna' and isdel = '0' and idx = '"+idx+"'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);
            
            
            /**
             * 이전글, 아랫글
             */           /** SELECT IDX,GROUP FROM asan.qna WHERE GROUP < 11 ORDER BY GROUP DESC */
            prevBean = mdao.selectQuery("select  idx, title, group, level from asan.qna where group < '"+group+"' order by group desc, level DESC fetch first 1 rows only");
            if(prevBean != null && prevBean.size() > 0) {
                HashMap h1 = (HashMap)prevBean.get(0);
                request.setAttribute("preview", h1);
            }
            
            /**
             * 다음글, 윗글
             */
            nextBean = mdao.selectQuery("select  idx, title, group, level from asan.qna where group > '"+group+"' order by group desc, level DESC fetch first 1 rows only");
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
     * 고객문의 등록시 해당 관리자에게 메일 발송하기
     */    
    public void SendMail(HttpServletRequest request, HttpServletResponse response, int idx) {
        MultiDAO mdao = new MultiDAO();        

        HashMap read = null;

        try {
/*            Enumeration params = request.getParameterNames();                                    
            while (params.hasMoreElements()) {
                
                String name = (String)params.nextElement();
                String value = request.getParameter(name);
                
                System.out.println(name + " ==> " + value);
            }       */     
            
            String name = Utility.ko( (String)request.getParameter("name"));
            String from = Utility.ko( (String)request.getParameter("email"));
            String title = "";
            String body = "";

            String to_name  = "";
            String to_email = "";
            
            // 내용 가져오기            
            title = Utility.ko( (String)request.getParameter("title") );
            body = Utility.ko( (String)request.getParameter("content"));

            String content = "";                
            
            to_name = request.getParameter("adminname");  
            to_email = request.getParameter("adminemail");
            
            System.out.println(to_name);
            System.out.println(to_email);
            
            /*to_name = "김종문";
            to_email = "czar.pe.kr@gmail.com";*/
            
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