/*
 * 20091017 심동현 보안강화를 위한 request 파라미타 받는 부분 SQL 인젝션 방지 유틸 추가
 * SecUtil.sqlFilter(파라미터)
 * 
 * 20111128 심동현 통합 웹 회원용 서블릿 복사 생성
 * 20111206 심동현 중복체크 : 이름, 생년월일, 성별 로만 가능 
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
public class ApassBean {
    /**
     * 회원  가입 확인
     * @author : sdh
     * @2011. 12. 07
     */

    public int JoinConfirm(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** JoinConfirm  *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
		String name = SecUtil.sqlFilter(request.getParameter("name")).trim();
        String regno = SecUtil.sqlFilter(request.getParameter("regno1")).trim() + SecUtil.sqlFilter(request.getParameter("regno2")).trim();
		String regno1 = SecUtil.sqlFilter(request.getParameter("regno1")).trim();
		String regno2 = SecUtil.sqlFilter(request.getParameter("regno2")).trim();
		String no2 = regno2.substring(0,1);
		String birthday = "";
		String gender="";
		// 생년월일 만들기.. 성별도..
			if(no2.equals("1")){
				birthday = "19"+request.getParameter("regno1");
				gender="M";
			}else if(no2.equals("2")){
				birthday = "19"+request.getParameter("regno1");
				gender="F";
			}else if(no2.equals("3")){
				birthday = "20"+request.getParameter("regno1");
				gender="M";
			}else if(no2.equals("4")){
				birthday = "20"+request.getParameter("regno1");
				gender="F";
			}	
		// 주민번호 수집 안하므로, 이름, 생년월일, 성별 로만 중복체크...

        try{
	        String query = "select count(*) count from asan.wb0080" +	        	           " where isdel in ('N','n') " +	        	           "   and nm    ='" + name+ "' " +	        	           "   and gender='" + gender+ "' " +	        	           "   and b_day ='" + birthday+ "' ";
	        int count = mdao.getRowCount(query);

	        if(count > 0)
	            result = 17; //이름, 생년월일, 성별 로 체크해서 중복 데이터 

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * mail 중복 체크
     * @author : sdh
     * @2011. 12. 07
     */
    public int EmailCheck(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** EmailCheck    *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
        String email = SecUtil.sqlFilter(request.getParameter("email")).trim();
		if(email == null) email=""; else email=email.trim();

        try{
	        String query = "select count(*) as count from ASAN.WB0080 where M_AED='" + email+ "'";
	        int count = mdao.getRowCount(query);

	        if(count > 0)
	            result = 1;		//email 중복

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

	
	/**
	  * 별명 중복 체크
	  * @author : sdh
	  * @2011. 12. 07
	  */
	 public int PnmCheck(HttpServletRequest request, HttpServletResponse response) {
		 //System.out.println("***** PnmCheck    *****");
		 MultiDAO mdao = new MultiDAO();

		 int result = 0;
		 String pnm = SecUtil.sqlFilter(request.getParameter("pnm")).trim();
		 if(pnm == null) pnm=""; else pnm=pnm.trim();

		 try{
			 String query = "select count(*) as count from ASAN.WB0080 where PNM='" + pnm+ "'";
			 int count = mdao.getRowCount(query);

			 if(count > 0)
				 result = 1;		//email 중복

		 }catch (Exception e) {
			 e.printStackTrace();
			 System.out.println(e.getMessage());
		 }
		 return result;
	 }



    /**
     * 회원  가입
     * @author : sdh
     * @2011. 12. 07
     */

    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** Member Insert  *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;

        //1. 이메일 중복 확인
		String email = SecUtil.sqlFilter(request.getParameter("M_AED")).trim();
		if(email == null) email=""; else email=email.trim();
		String query = "select count(*) as count from ASAN.WB0080 where M_AED='" + email+ "'";
        int count1 = mdao.getRowCount(query);
        if(count1> 0){
            return result = -1 ;		//email 중복
        }

        //2.max select 왜냐면.. 이걸.. oldid란에 같이 넣어줄 것이거든.ㅠ_ㅠ
        query = "SELECT COALESCE(MAX(WB_SID),0) + 1  FROM ASAN.WB0080 ";
        String memberidx = String.valueOf(mdao.getRowCount(query));



        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = SecUtil.sqlFilter(request.getParameter(name));
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }
 
            
//			System.out.println("email = "+bean.get("M_AED"));
//			System.out.println("M_AED=="+bean.get("M_AED"));
//			System.out.println("PNM=="+bean.get("PNM"));
//			System.out.println("NM=="+bean.get("NM"));
//			System.out.println("B_DAY=="+bean.get("B_DAY"));
//			System.out.println("GENDER=="+bean.get("GENDER"));
//			System.out.println("pwd1=="+bean.get("pwd1"));
//			System.out.println("pwd2=="+bean.get("pwd2"));
//			System.out.println("checkemail=="+bean.get("checkmail"));
//			System.out.println("checkpnm=="+bean.get("checkpnm"));
//			System.out.println("NC_Q=="+bean.get("NC_Q"));
//			System.out.println("NC_A=="+bean.get("NC_A"));
//			System.out.println("TOUCH=="+bean.get("TOUCH"));
//			System.out.println("YN_MAIL=="+bean.get("YN_MAIL"));
//			System.out.println("YN_SMS=="+bean.get("YN_SMS"));
//
//			System.out.println("H_TOUCH=="+bean.get("H_TOUCH"));
//			System.out.println("H_ZIP=="+bean.get("H_ZIP"));
//			System.out.println("H_ADDR1=="+bean.get("H_ADDR1"));
//			System.out.println("H_ADDR2=="+bean.get("H_ADDR2"));
//
//			System.out.println("C_TOUCH=="+bean.get("C_TOUCH"));
//			System.out.println("C_ZIP=="+bean.get("C_ZIP"));
//			System.out.println("C_ADDR1=="+bean.get("C_ADDR1"));
//			System.out.println("C_ADDR2=="+bean.get("C_ADDR2"));
            
			query = "INSERT INTO ASAN.WB0080 " +				"(M_AED, BMILNO, NC_Q, NC_A, PNM, NM, GENDER, B_DAY, TOUCH, " +				" H_ZIP, H_ADDR1, H_ADDR2, H_TOUCH, C_ZIP, C_ADDR1, C_ADDR2," +				" C_TOUCH, YN_MAIL, YN_SMS, ISGUBN, ISFROM,	ISDEL, OLDID) VALUES (" +				" '"+bean.get("M_AED")+"',ENCRYPT('"+bean.get("pwd1")+"','a$an1108'),'"+bean.get("NC_Q")+"'," +				" '"+bean.get("NC_A")+"','"+bean.get("PNM")+"','"+bean.get("NM")+"','"+bean.get("GENDER")+"'," +				" '"+bean.get("B_DAY")+"','"+bean.get("TOUCH")+"'," +				" '"+bean.get("H_ZIP")+"','"+bean.get("H_ADDR1")+"','"+bean.get("H_ADDR2")+"','"+bean.get("H_TOUCH")+"'," +				" '"+bean.get("C_ZIP")+"','"+bean.get("C_ADDR1")+"','"+bean.get("C_ADDR2")+"','"+bean.get("C_TOUCH")+"'," +				" '"+bean.get("YN_MAIL")+"','"+bean.get("YN_SMS")+"','a','i','n','"+memberidx+"')";
			
			//System.out.println(query);
			
			result = mdao.insertQuery(query);

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
					   line = SecUtil.strReplace(line, "##name##", SecUtil.sqlFilter(request.getParameter("NM")));
				   if(line.indexOf("##email##") >= 0)
					   line = SecUtil.strReplace(line,"##email##", SecUtil.sqlFilter(request.getParameter("M_AED")));
				   
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

				title = "[현대아산Apass] 회원가입 내역을 안내해 드립니다.";
				content = fileString;
				//result = SendMail(request, request.getParameter("email"), title, content, "1" );
				SendMail(request, request.getParameter("M_AED"), title, content, "1" );
			   
			} 

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * 회원  read
     * [20111201] 심동현 새 테이블에 맞춰 쿼리 수정
     */

    public void Read(HttpServletRequest request, HttpServletResponse response){
        //System.out.println("***** MemberInfo Read *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        /* 통합 쪽에 와서 조회하려면 1번 더 로그인! */
		HttpSession session = request.getSession();
		String email = session.getAttribute("memberaed").toString().trim() ;
		if(email == null) email=""; else email=email.trim();
        /*cookie read
        String id = getCookie(request,"id");
        if(id == null) id ="";*/
        
		//System.out.println("***** id==="+id);

        try {
            /**
             * 회원 정보
             */
            //beans = mdao.selectQuery("select id, pwd, name,regno,gender, birthday, birthgbn, area, addrgbn, zip, addr1, addr2," +
            //		"telgbn, tel, fax, mobile,job, company, email, iswedding, istravel, isletter, agentname, agentregno, agentemail, " +
            //		"agentzip, agentaddr1, agentaddr2, agenttel, isreal, level, issms  from asan.member where  id = '" + id + "' and (case when isdel = 'y' then 0 else 1 end) = 1 ");
            beans = mdao.selectQuery(""
               	  + " SELECT M_AED, NC_Q, NC_A, PNM, NM, CASE GENDER WHEN 'M' THEN '남' WHEN 'F' THEN '여' END AS GENDER, B_DAY, TOUCH, "
				  + "        H_ZIP, H_ADDR1, H_ADDR2, H_TOUCH, C_ZIP, C_ADDR1, C_ADDR2, C_TOUCH, YN_MAIL, YN_SMS, "
				  + "        ISGUBN, ISFROM, ISDEL, OLDID, I_DATE, U_DATE "
				  + "	FROM ASAN.WB0080 "
				  + "  WHERE M_AED='"+email+"' "
				  + "    AND ISDEL = 'n' ");
			   
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }



	/**
     * 회원정보  수정
	 * @author : sdh
	 * @2011. 12. 07
	 */
	public int Update1(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("***** Member Update *****");
		MultiDAO mdao = new MultiDAO();
		int result = 0;
		String query="";
		
		/* session 20110527 */
		HttpSession session = request.getSession();
		String email = session.getAttribute("memberaed").toString().trim() ;
		if(email == null) email=""; else email=email.trim();           

		String bmilno = SecUtil.sqlFilter(request.getParameter("pwd"));
		String n_bmilno = SecUtil.sqlFilter(request.getParameter("pwd1"));
        
		try {
			query ="  UPDATE ASAN.WB0080 " +
					" SET BMILNO=ENCRYPT('" + n_bmilno + "','a$an1108') " +
					" where m_aed = '" + email +"' " +
					" and isdel in ('N','n')  ";

			result = mdao.insertQuery(query);

		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		return result;
	}


	/**
	 * 비밀번호 변경
	 * @author : sdh
	 * @2011. 12. 07
	 */
	public int BUpdate(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("***** Member Update *****");
		MultiDAO mdao = new MultiDAO();
		int result = 0;
		String query="";
		
		/* session 20110527 */
		HttpSession session = request.getSession();
		String email = session.getAttribute("memberaed").toString().trim() ;
		if(email == null) email=""; else email=email.trim();           

		String bmilno = SecUtil.sqlFilter(request.getParameter("pwd"));
		String n_bmilno = SecUtil.sqlFilter(request.getParameter("pwd1"));
        
		try {
			query ="  UPDATE ASAN.WB0080 " +					" SET BMILNO=ENCRYPT('" + n_bmilno + "','a$an1108') " +
					" where m_aed = '" + email +"' " +
					" and bmilno = ENCRYPT('"+ bmilno +"','a$an1108') " +
					" and isdel in ('N','n')  ";

			result = mdao.insertQuery(query);

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