/*
 * 2009-10-17 
 * 심동현
 * 보안강화를 위한 request 파라미타 받는 부분 SQL 인젝션 방지 유틸 추가
 * SecUtil.sqlFilter(파라미터)
 * */
package com.hmm.asan.www.member;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
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

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Date; 
import java.util.Calendar; 

import com.hmm.asan.common.dao.MultiDAO;
import com.hdasan.util.SecUtil;
//import com.hmm.asan.common.util.Utility;
 
/**
 * 회원가입
 */
public class MemberBean {
    /**
     * 회원  가입 확인
     * @author : ikara
     * @2005. 10. 29
     */

    public int JoinConfirm(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** JoinConfirm  *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
        String regno = SecUtil.sqlFilter(request.getParameter("regno1")).trim() + SecUtil.sqlFilter(request.getParameter("regno2")).trim();

        try{
	        String query = "select count(*) count from asan.member where regno='" + regno+ "' and (case when isdel = 'y' then 0 else 1 end) = 1 ";
	        int count = mdao.getRowCount(query);

	        if(count > 0)
	            result = 1; //주민 번호 중복 

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * ID중복 체크
     * @author : ikara
     * @2005. 10. 29
     */

    public int IdCheck(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** IdCheck    *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
        String id = SecUtil.sqlFilter(request.getParameter("id")).trim();
		if(id == null) id=""; else id=id.trim();

        try{
	        String query = "select count(*) count from asan.member where id='" + id+ "'";
	        int count = mdao.getRowCount(query);

	        if(count > 0)
	            result = 1;		//ID중복

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }


    /**
     * 우편번호 검색
     * @author : ikara
     * @2005. 10. 29
     */

    public int ZipSearch(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** ZipSearch *****");
        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        int result = 0;
        String dong = SecUtil.sqlFilter(request.getParameter("dong")).trim();

        try{
	        //String query = "select TDIRDA1,TDIRDA2, TDIRDA3, TDIRZIP  from ASAN.GTSADIRF where TDIRDA3 like '%" + dong+ "%'";
        	String query = "select ADDRESS1,ADDRESS2, ADDRESS3, POST_BOX, ZIP_CD  from SALES.TSY110 where ADDRESS3 like '%" + dong+ "%'";
	        list = mdao.selectQuery(query);
	        
            request.setAttribute("list", list);
            
            System.out.println("::::::::::::"+query);
            
            
        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }


    /**
     * 회원  가입
     * @author : ikara
     * @2005. 10. 29
	 * @Last Modify : Kim , Jong seob ( IMJK ) , 2006.06.01
     */

    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Member Insert  *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;

        //1.ID중복 확인
        String id = SecUtil.sqlFilter(request.getParameter("id"));
		if(id == null) id=""; else id=id.trim();
        String query = "select count(*) count from asan.member where id='" + id + "' ";
        int count1 = mdao.getRowCount(query);

        if(count1> 0){
            return result = -1 ;		//계정 중복
        }

        //2.주민번호 중복 확인 -- 탈퇴 회원 인 경우 는 제외.
        String regno = SecUtil.sqlFilter(request.getParameter("regno")) ;
        query = "select count(*) count from asan.member where regno='" + regno + "' and (case when isdel = 'y' then 0 else 1 end) = 1 ";
        int count2 = mdao.getRowCount(query);

        if(count2 > 0){
            return result = -2 ;		//주민 번호 중복
        }

        //3.max select
        query = "SELECT COALESCE(MAX(idx),0) + 1  FROM asan.member";
        String memberidx = String.valueOf(mdao.getRowCount(query));


        //4.회원 등급 확인
        String level = "";
        String isreal = (String)request.getParameter("isreal");
        if (isreal.equals("1")){
             level = "1";	//임시회원
    	}else{
    	     level = "0";	//정회원
    	}

        //5.뉴스레터 수신 여부
        String isletter = (String)request.getParameter("isletter");
        if (isletter==null || isletter.equals("")){
            isletter = ""; //비수신 
    	}
        else {
        	isletter = "1"; //수신 
        }

		//6.SMS 수신여부 ( 핸드폰 )
         String issms = (String)request.getParameter("issms");
        if ( issms == null || issms.equals("")){ 
			issms = "1"; //비수신   	
		}
		else {
			issms = "0"; //수신   	
		}

        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = SecUtil.sqlFilter(request.getParameter(name));
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }
 
            bean.put("isagree", "0");
            bean.put("level", level);
            bean.put("isletter", isletter);
			bean.put("issms", issms);
            bean.put("reguser", memberidx);
			bean.put("regip", request.getRemoteHost());
			bean.put("isfrom", "h"); //관광사이트 구분자 : m , 회사사이트 : h
			bean.put("isdel", "n"); //기본 : n, 탈퇴시 ;y 

            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");

            bean.remove("pwd2");

            bean.remove("regno1");
            bean.remove("regno2");  

            bean.remove("birthdayy");
            bean.remove("birthdaym");
            bean.remove("birthdayd");

            bean.remove("zip1");
            bean.remove("zip2");

            bean.remove("tel1");
            bean.remove("tel2");
            bean.remove("tel3");

			bean.remove("mobile1");
			bean.remove("mobile2");
			bean.remove("mobile3");

			bean.remove("email1");
			bean.remove("email2");
			bean.remove("email3");

            bean.remove("checkid");
            bean.remove("checkaddr");
			bean.remove("issmscheck");
			bean.remove("checkisletter");
			
			/* out print 
			HashMap newHash = (HashMap)bean.clone(); 
			System.out.println("MAP = "+newHash);  
			*/ 

			result = mdao.insertQuery("asan.member", bean);

			//insert 성공여부에 따라 메일 발송 .
			if ( result > 0 )
			{ 
				String fileString = "";
				String title = "";
				String content = "";
				
				String line = null;
				
				String pathfile = request.getSession().getServletContext().getRealPath("/mail/register.htm");
				BufferedReader br = new BufferedReader(new FileReader(pathfile));

				while ((line = br.readLine()) != null) {
				   line = line.trim();
				   if(line.indexOf("##name##") >= 0)
					   line = SecUtil.strReplace(line, "##name##", SecUtil.sqlFilter(request.getParameter("name")));
				   if(line.indexOf("##id##") >= 0)
					   line = SecUtil.strReplace(line,"##id##", SecUtil.sqlFilter(request.getParameter("id")));
				   if(line.indexOf("##pwd##") >= 0)
					   line = SecUtil.strReplace(line,"##pwd##", SecUtil.sqlFilter(request.getParameter("pwd")));
				   
					   Calendar gCal = Calendar.getInstance(); 
				       gCal.setTime(new Date()); 
				       int year = gCal.get(Calendar.YEAR); 
				       int month = gCal.get(Calendar.MONTH)+1;
				       int day = gCal.get(Calendar.DATE);
				        
					   line = SecUtil.strReplace(line,"##year##", String.valueOf(year));
					   line = SecUtil.strReplace(line,"##month##", String.valueOf(month));
					   line = SecUtil.strReplace(line,"##day##", String.valueOf(day));
				   
				   fileString += line + " \n";
				}
				br.close();

				title = "[현대아산] "+SecUtil.sqlFilter(request.getParameter("name"))+" 님에 회원가입을 축하 드립니다.";
				content = fileString;
				//result = SendMail(request, request.getParameter("email"), title, content, "1" );
				SendMail(request, request.getParameter("email"), title, content, "1" );
			   
			} 

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * 회원  read
     * @author : ikara
     * @2005. 10. 29
	 * @Last Modify : Kim , Jong seob ( IMJK ) , 2006.06.01
     */

    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Member Read *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        /* session 20110527 */
        HttpSession session = request.getSession();
        String id = session.getAttribute("memberid").toString().trim() ;
		if(id == null) id=""; else id=id.trim();
        /*cookie read
        String id = getCookie(request,"id");
        if(id == null) id ="";*/
        
		//System.out.println("***** id==="+id);

        try {
            /**
             * 회원 정보
             */
            beans = mdao.selectQuery("select id, pwd, name,regno,gender, birthday, birthgbn, area, addrgbn, zip, addr1, addr2," +
            		"telgbn, tel, fax, mobile,job, company, email, iswedding, istravel, isletter, agentname, agentregno, agentemail, " +
            		"agentzip, agentaddr1, agentaddr2, agenttel, isreal, level, issms  from asan.member where  id = '" + id + "' and (case when isdel = 'y' then 0 else 1 end) = 1 ");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    /**
     * 회원정보  수정
     * @author : ikara
     * @2005. 10. 27
	 * @Last Modify : Kim , Jong seob ( IMJK ) , 2006.06.01
     */

    public int Update(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Member Update *****");
        int result = 0;

        //HttpSession session = request.getSession();
		/* session 20110527 */
		HttpSession session = request.getSession();
		String id = session.getAttribute("memberid").toString().trim() ;
		if(id == null) id=""; else id=id.trim();           
        //cookie read
        //String id = getCookie(request,"id");
        
        
        MultiDAO mdao = new MultiDAO();

        //뉴스레터 수신 여부
        String isletter = (String)request.getParameter("isletter");
        if (isletter==null || isletter.equals("")){
            isletter = ""; //비수신 
    	}
        else {
        	isletter = "1"; //수신 
        }

		//SMS 수신여부 ( 핸드폰 )
        String issms = (String)request.getParameter("issms");
        if ( issms == null || issms.equals("")){ 
			issms = "1"; //비수신   	
		}
		else {
			issms = "0"; //수신   	
		}

        try {

            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = SecUtil.sqlFilter(request.getParameter(name));

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

        	//bean.put("lastuser", session.getAttribute("memberidx"));
			bean.put("lastip", request.getRemoteHost());
			bean.put("lasttime", new Timestamp(System.currentTimeMillis()) );
			bean.put("isletter", isletter);
			bean.put("issms", issms);

            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");
            bean.remove("pwd2");

            bean.remove("regno1");
            bean.remove("regno2");  
            
            bean.remove("birthdayy");
            bean.remove("birthdaym");
            bean.remove("birthdayd");

            bean.remove("zip1");
            bean.remove("zip2");

            bean.remove("tel1");
            bean.remove("tel2");
            bean.remove("tel3");
			
			bean.remove("email1");
			bean.remove("email2");
			bean.remove("email3");
			
			bean.remove("mobile1");
			bean.remove("mobile2");
			bean.remove("mobile3");
            
            bean.remove("issmscheck");
			bean.remove("checkisletter");
			
		
			//HashMap newHash = (HashMap)bean.clone(); 
			//System.out.println("MAP = "+newHash);   
			 
            result = mdao.updateQuery("asan.member", bean, " where id = '"+id + "'");

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return result;
    }

    /**
     * ID Search
     * @author : ikara
     * @2005. 10. 31
     * @Last Modify : Kim , Jong seob ( IMJK ) , 2006.06.09
     */
  
    public int IdSearch(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** IdSearch    *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String name = SecUtil.sqlFilter(request.getParameter("name"));
        if(name == null) name=""; else name=name.trim();

        String regno1 = SecUtil.sqlFilter(request.getParameter("regno1"));
        if(regno1 == null) regno1=""; else regno1=regno1.trim();

        String regno2 = SecUtil.sqlFilter(request.getParameter("regno2"));
        if(regno2 == null) regno2=""; else regno2=regno2.trim();

        String regno = regno1 + regno2;
        
        try{
            ArrayList beans = null;
            
            //탈퇴 회원은 아이디 찾기를 할수 없다.
	        beans = mdao.selectQuery("select id  from asan.member where name='" +name+ "' AND regno ='" + regno + "' and (case when isdel = 'y' then 0 else 1 end) = 1");
            if(beans != null && beans.size() > 0) {
                HashMap h1 = (HashMap)beans.get(0);
                request.setAttribute("id", h1.get("ID"));
                result = 1;					//id확인
            }

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * PWD Search
     * @author : ikara
     * @2005. 10. 31
     */

    public int PwdSearch(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** PwdSearch    *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String id = SecUtil.sqlFilter(request.getParameter("id"));
        if(id == null) id=""; else id=id.trim();

        String name = SecUtil.sqlFilter(request.getParameter("name"));
        if(name == null) name=""; else name=name.trim();

        String regno1 = SecUtil.sqlFilter(request.getParameter("regno1"));
        if(regno1 == null) regno1=""; else regno1=regno1.trim();

        String regno2 = SecUtil.sqlFilter(request.getParameter("regno2"));
        if(regno2 == null) regno2=""; else regno2=regno2.trim();
        
        String semail = SecUtil.sqlFilter(request.getParameter("semail"));
        if(semail == null ) semail = ""; else semail = semail.trim();

        String regno = regno1 + regno2;

        try{
            ArrayList beans = null;

            //탈퇴 한 회원인 비밀번호 찾기를 할수 없다.
	        beans = mdao.selectQuery("select email, pwd  from asan.member where id='" + id + "' AND name='" +name+ "' AND regno ='" + regno + "' and (case when isdel = 'y' then 0 else 1 end) = 1 ");
	        if(beans != null && beans.size() > 0) {
                HashMap h1 = (HashMap)beans.get(0);

                //비밀번호 확인  메일 발송
                String fileString = "";
                String title = "";
                String content = "";

                String pathfile = request.getSession().getServletContext().getRealPath("/mail/password.htm");
                BufferedReader br = new BufferedReader(new FileReader(pathfile));

                String line = null;
                while ((line = br.readLine()) != null) {
                    line = line.trim();

                    if(line.indexOf("##name##") >= 0)
                        line = SecUtil.strReplace(line,"##name##", name);

                    if(line.indexOf("##pwd##") >= 0)
                        line = SecUtil.strReplace(line,"##pwd##", (String)h1.get("PWD"));

                    fileString += line + " \n";
                }
                br.close();

	            title = "[현대아산]비밀번호확인메일입니다.";
	            content = fileString;
                //result = SendMail(request, (String)h1.get("EMAIL"), title, content, "1" );
	            if ( semail.equals("") ) //이메일 입력되지 않으면 기존 이메일 주소를 이용 
	            	result = SendMail(request, (String)h1.get("EMAIL"), title, content, "1" );
	            else
	            	result = SendMail(request, semail, title, content, "1" );
            }

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage()); 
        }
        return result; 
    }
    
    
    /**
     * User Delete ( withdrawal )
     * @author : IMJK ( Kim, Jongseob)
     * @2006. 06. 09
     */
    public int Withdrawal(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Member Delete  *****");
        int result = 0;
        
        MultiDAO mdao = new MultiDAO();

        //HttpSession session = request.getSession();
		/* session 20110527 */
		HttpSession session = request.getSession();
		String id = session.getAttribute("memberid").toString().trim() ;

        //cookie read
        //String id = getCookie(request,"id");
		if(id == null) id=""; else id=id.trim();
        
        String formid = SecUtil.sqlFilter(request.getParameter("id"));
        if(formid == null) formid=""; else formid = formid.trim();

        if ( !id.equals(formid) ) {
        	return result = -1; // cookie id != form id 
        }
        
        String name = SecUtil.sqlFilter(request.getParameter("name"));
        if(name == null) name=""; else name=name.trim();

        String regno1 = SecUtil.sqlFilter(request.getParameter("regno1"));
        if(regno1 == null) regno1=""; else regno1=regno1.trim();

        String regno2 = SecUtil.sqlFilter(request.getParameter("regno2"));
        if(regno2 == null) regno2=""; else regno2=regno2.trim();
        
        String pwd = SecUtil.sqlFilter(request.getParameter("pwd"));
        if(pwd == null ) pwd = ""; else pwd = pwd.trim();

        String regno = regno1 + regno2;
        
        try {
        	ArrayList beans = null;

 	        beans = mdao.selectQuery("select id, email  from asan.member where id='" + id + "' AND name='" +name+ "' AND regno ='" + regno + "' AND pwd ='" + pwd + "' and (case when isdel = 'y' then 0 else 1 end) = 1");
 	        
 	        if(beans != null && beans.size() > 0) {
        		
	            HashMap bean = new HashMap();
	        	bean.put("isdel", "y"); //탈퇴 처리.
				bean.put("lastip", request.getRemoteHost());
				bean.put("lasttime", new Timestamp(System.currentTimeMillis()) );
			
				HashMap h1 = (HashMap)beans.get(0);
				//탈퇴 확인  메일 발송
                String fileString = "";
                String title = "";
                String content = "";

                String pathfile = request.getSession().getServletContext().getRealPath("/mail/withdrawal.htm");
                BufferedReader br = new BufferedReader(new FileReader(pathfile));

                String line = null;
                while ((line = br.readLine()) != null) {
                    line = line.trim();

                    if(line.indexOf("##name##") >= 0)
                        line = SecUtil.strReplace(line,"##name##", name);

                    if(line.indexOf("##id##") >= 0)
                        line = SecUtil.strReplace(line,"##id##", id);

                    fileString += line + " \n";
                }
                br.close();

	            title = "[현대아산]탈퇴 확인메일입니다.";
	            content = fileString;
                SendMail(request, (String)h1.get("EMAIL"), title, content, "1" ); 
                
                result = mdao.updateQuery("asan.member", bean, " where id = '"+id + "'");
                
                //System.out.println("------------------------ result ---------------------"+result);
 	        }

        }catch (Exception e) { 
            //e.printStackTrace();
            System.out.println(e.getMessage());
        }
        

        return result;
    }

    /**
     * 메일 발송 (type - 1 : 회원 비밀 번호 찾기 , 2:14세 미만 법정대리인 확인 메일 발송 )
     * @author : ikara
     * @2005. 10. 31
     */

    public int SendMail(HttpServletRequest request, String toemail, String title, String content, String type ) {
        //System.out.println("***** SendMail    *****");

        String name = "현대아산";
        String from = "asan@hmm21.com";
        int result = 0;
        try{
            Properties props = System.getProperties();
            props.put("mail.smtp.host", "localhost");

            Session ss = Session.getDefaultInstance(props, null);
            Message msg = new MimeMessage(ss);

            msg.setFrom(new InternetAddress(from, name));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toemail, false));
            msg.setSubject(title);
            msg.setText(content);
            msg.setHeader("Content-Type", "text/html;charset=EUC-KR");

            msg.setSentDate(new java.util.Date());
            Transport.send(msg); 
             result = 1;
        } catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    
    /**
     * Cookie read
     * @author : IMJK ( Kim, Jongseob)
     * @2006. 06. 09
     */
	public static String getCookie(HttpServletRequest request, String name)	{
		Cookie[] cookies = request.getCookies();
	    if ((cookies != null) && (cookies.length > 0)) {
	       for(int i=0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
			    if (thisCookie.getName() != null && thisCookie.getName().equals(name)) {
					return thisCookie.getValue();
				}
			}
		}
		return null;
	}

}