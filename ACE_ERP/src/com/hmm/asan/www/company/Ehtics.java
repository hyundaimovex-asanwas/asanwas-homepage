// Decompiled by Jad v1.5.8f. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Ehtics.java

package com.hmm.asan.www.company;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;
import java.io.*;
import java.sql.Timestamp;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import com.hdasan.util.SecUtil;

public class Ehtics
{

    public Ehtics()
    {
        dirName = "/was/file_upload/ethics07";
        maxFileSize = 0x6400000;
    }

    public int Insert(HttpServletRequest request, HttpServletResponse response)
    {
        MultiDAO mdao = new MultiDAO();
        int result = 0;
        String totalQuery = "SELECT COUNT(IDX) count FROM asan.ethics07";
        String count = String.valueOf(mdao.getRowCount(totalQuery));
        if(count.equals("null"))
            count = "1";
        int maxNo = Integer.parseInt(count) + 1;
        System.out.println(" No : " + maxNo);
        try
        {
            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());
            Enumeration params = multi.getParameterNames();
            HttpSession session = request.getSession();
            System.out.println(" No : " + maxNo);
            HashMap bean = new HashMap(10, 5F);
            while(params.hasMoreElements()) 
            {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }
            bean.put("regid", (String)session.getAttribute("memberidx") != null ? ((Object) ((String)session.getAttribute("memberidx"))) : "nologin");
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));
            bean.put("regip", request.getRemoteHost() != null ? ((Object) (request.getRemoteHost())) : "");
            System.out.println("title" + bean.get("title"));
            System.out.println("content" + bean.get("content"));
            bean.remove("File_name");
            bean.remove("y");
            bean.remove("x");
            result = mdao.insertQuery("asan.ethics07", bean);
            for(Enumeration files = multi.getFileNames(); files.hasMoreElements();)
            {
                String name = (String)files.nextElement();
                String filename = multi.getFilesystemName(name);
                String originalFilename = multi.getOriginalFileName(name);
                String ContentType = multi.getContentType(name);
                java.io.File f = multi.getFile(name);
                System.out.println("name: " + name);
                System.out.println("filename: " + filename);
                System.out.println("originalFilename: " + originalFilename);
                if(f != null)
                {
                    String s = new String(name);
                    int nameSize = s.length();
                    String name_num = s.substring(nameSize - 1);
                    HashMap fileBean = new HashMap();
                    fileBean.put(name, filename);
                    mdao.updateQuery("ASAN.Ethics07", fileBean, " where idx = " + maxNo);
                }
            }

            if(result > 0)	 //저장 후 메일 보내기~
                SendMail(request, response, maxNo, (String)bean.get("title"), (String)bean.get("content"), (String)bean.get("regname"), (String)bean.get("regemail"));
        }
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    public void SendMail(HttpServletRequest request, HttpServletResponse response, int idx, String title1, String content1, String regname, String regemail)
    {
        MultiDAO mdao = new MultiDAO();
        HashMap read = null;
        try
        {
            String name = regname;
            String from = regemail;
            String title = "";
            String body = "";
            String to_name = "";
            String to_email = "";
            title = title1;
            body = content1;
            String content = "";
            System.out.println("name:" + name);
            System.out.println("from:" + from);
            System.out.println("title:" + title);
            System.out.println("body:" + body);
            to_name = "\uC724\uB9AC\uACBD\uC601\uD300";
            to_email = "ethics@hdasan.com";
            java.util.Properties props = System.getProperties();
            props.put("mail.smtp.host", "localhost");
            Session ss = Session.getDefaultInstance(props, null);
            Message msg = new MimeMessage(ss);
            String pathfile = request.getSession().getServletContext().getRealPath("/mail/ask.htm");
            BufferedReader br = new BufferedReader(new FileReader(pathfile));
            for(String line = null; (line = br.readLine()) != null;)
            {
                line = line.trim();
                if(line.indexOf("##TITLE##") >= 0)
				line = SecUtil.strReplace(line, "##TITLE##", title );
                    //line = line.replaceAll("##TITLE##", title);
                    
                if(line.indexOf("##CONTENT##") >= 0)
					line = SecUtil.strReplace(line, "##CONTENT##", body );
                    //line = line.replaceAll("##CONTENT##", body);
                    
                content = content + line + " \n";
            }

            br.close();
            msg.setFrom(new InternetAddress(from, name));
            msg.setRecipients(javax.mail.Message.RecipientType.TO, InternetAddress.parse(to_email, false));
            msg.setSubject(title);
            msg.setText(content);
            msg.setHeader("Content-Type", "text/html;charset=EUC-KR");
            msg.setSentDate(new Date());
            try
            {
                Transport.send(msg);
                System.out.println("\uBA54\uC77C\uBC1C\uC1A1\uC131\uACF5");
            }
            catch(Exception ee)
            {
                System.out.println("\uBA54\uC77C\uBC1C\uC1A1\uC2E4\uD328");
                System.out.println(ee.getMessage());
                ee.printStackTrace();
            }
        }
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private String dirName;
    private int maxFileSize;
}
