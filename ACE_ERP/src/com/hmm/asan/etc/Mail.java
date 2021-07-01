package com.hmm.asan.etc;

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
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.hmm.asan.common.util.Utility;
import com.hmm.asan.common.util.WEBConstants;
import com.oreilly.servlet.MultipartRequest;

public class Mail {
    /**
     * 윤리상담 고충 처리
     * @author : ikara
     * @2005. 11.29
     */

    private String dirName = WEBConstants.ASANSINMOONGOUPLOADDIR ;
    private int maxFileSize = WEBConstants.ASANSINMOONGOUPLOADMAX;

    public int Sinmoongo(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Sinmoongo    *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
        String fileString = "";

        HttpSession session = request.getSession();

        try{
            String pathfile = request.getSession().getServletContext().getRealPath("/mail/sinmoongo.htm");
            BufferedReader br = new BufferedReader(new FileReader(pathfile));

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String toname = multi.getParameter("toname");
            if(toname == null) toname=""; else toname=toname.trim();

            String tomail = multi.getParameter("tomail");
            if(tomail == null) tomail=""; else tomail=tomail.trim();

            String fname = multi.getParameter("fname");
            if(fname == null) fname=""; else fname=fname.trim();

            String fmail = multi.getParameter("fmail");
            if(fmail == null) fmail=""; else fmail=fmail.trim();

            String title = multi.getParameter("title");
            String content = Utility.nl2br(request.getParameter("content"));


            String line = null;
            while ((line = br.readLine()) != null) {
                line = line.trim();

                if(line.indexOf("##FNAME##") >= 0)
                    line = line.replaceAll("##FNAME##", fname);

                if(line.indexOf("##FMAIL##") >= 0)
                    line = line.replaceAll("##FMAIL##", fmail);

                if(line.indexOf("##TITLE##") >= 0)
                    line = line.replaceAll("##TITLE##", title);

                if(line.indexOf("##CONTENT##") >= 0)
                    line = line.replaceAll("##CONTENT##", content);

                fileString += line + " \n";
            }
            br.close();

            String filename = Utility.ko(multi.getOriginalFileName("file"));    // filename
            String sysfilename = multi.getFilesystemName("file");   // sysfilename

            File f = multi.getFile("file");

            title = "[현대아산]윤리상담/고충 처리메일입니다.";
            content = fileString;
            result = SendMail(request, tomail, toname, fmail, fname, title, content, filename, sysfilename, dirName);


        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * 메일 발송
     * @author : ikara
     * @2005. 11.29
     */

    public int SendMail(HttpServletRequest request, String tomail, String toname, String fmail, String fname, String title, String content, String filename, String  sysfilename, String filepath ) {
        System.out.println("***** SendMail    *****");
        int result = 0;
        try{
            Properties props = System.getProperties();
            props.put("mail.smtp.host", "localhost");

            Session ss = Session.getDefaultInstance(props, null);
            MimeMessage  msg = new MimeMessage(ss);

            msg.setFrom(new InternetAddress(fmail, fname));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(tomail, false));
            msg.setSubject(title);

            // 내용///////////////////////////////////////////////////////////
            Multipart mp = new MimeMultipart();

            //**메시지**
            MimeBodyPart mbp = new MimeBodyPart();
            mbp.setContent( content, "text/html;charset=euc-kr" );
            mp.addBodyPart( mbp );
            mbp = null;

            //**파일첨부**
            try {
               if( filename.trim().length() != 0 ) {
                MimeBodyPart mbp2 =  new MimeBodyPart();
                FileDataSource fds = new FileDataSource( filepath+"/"+sysfilename );
                mbp2.setDataHandler( new DataHandler(fds) );
                mbp2.setFileName( new String(filename.getBytes("KSC5601"), "8859_1") );
                mp.addBodyPart( mbp2 );
                mbp2 = null;
             }
            }catch( Exception e1 ) {
                String err = e1.toString();
                System.out.println( "in JiniMailSender : 파일전송중 에러 : "+err );
            }
            msg.setContent(mp);

            msg.setSentDate(new java.util.Date());
            Transport.send(msg);
            result =  1 ;
        } catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

}