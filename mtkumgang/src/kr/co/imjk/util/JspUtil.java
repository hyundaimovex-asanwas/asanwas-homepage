/*
 * 이 클래스에는 JSP 페이지와 관련된 유틸리티 메소드를 추가합니다.
 */
 
package kr.co.imjk.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

public class JspUtil{
    /**
     * JSP 페이지에서 useBean 테그로 생성된 Instance의 referance를 다른 Bean의 주소값으로 바꾸어 주는 메소드<br>
     * Tomcat 에서는 useBeanInstance = newBeanInstance 형태로 최초로 생성된 instance가 바뀌지 않으므로 <br>
     * 새로운 referance를 jspContext에 넣어주어야 <jsp:getProperty> 테그를 사용할 수 있다. <br>
     * 기타 JSP Container 일 경우에는 상관없이 referance를 할당하기만 하면 된다.
     *
     * parameter : <br>
     *  - jspContext : PageContext<br>
     *  - beanName : useBean 테그에서 instance 생성시 사용된 id 이름<br>
     *  - beanInstance : useBean 테그로 최초로 생성된 instance<br>
     *  - newInstance : beanInstance를 대체할 새로운 bean instance<br>
     *
     * @ author : SIM JAE JIN
     * @ date : 2001-07-24
     * @ e-mail : sim11@miraenet.com
     *
     */
    public static Object setInstance(PageContext jspContext, String beanName, Object newInstance){
        String server = jspContext.getServletConfig().getServletContext().getServerInfo();                
        // Tomcat Servlet & JSP Container
        if(server.indexOf("Tomcat") != -1){            
            jspContext.setAttribute(beanName, newInstance, PageContext.PAGE_SCOPE);
        }
        // Etc Servlet & JSP Container
        return newInstance;
    }
    
    /**
     * 세션값을 가지고 올때 세션이나 바인딩된 값이 없을때 Exception이 발생하므로 이를 검사하여 null값을 리턴하는 메소드
     *
     * @ author : SIM JAE JIN
     * @ date : 2001-08-21
     * @ e-mail : sim11@miraenet.com
     *     
     */
    public static String getAttribute(HttpSession session, String key){
        return getAttribute(session, key, null);
    }
    
    public static String getAttribute(HttpSession session, String key, String defValue){
        String value = null;
        if(session != null){
            Object o = session.getAttribute(key);
            if(o != null){
                value = o.toString();  
            }else{
                value = defValue;
            }
        }else{
            value = defValue;
        }
        return value;
    }    
    
    /**
     * JSP 파일을 include 할때 한글 파라미터가 깨지는 현상을 막기위한 메소드<br>
     * 톰캣에서는 인클루드 걸기전에 어떤 파라미터라도 한번 받으면 한글이 별다른 인코딩 절차 없이 <br>
     * 전달되어 지고, 그렇지 않으면 한글이 깨지므로 무조건 파라미터를 받기를 시도하는 메소드.<br>
     * 톰캣의 버그는 언제나 끝날런지 ~~ .. -_-;;
     *
     * @ author : SIM JAE JIN
     * @ date : 2001-09-03
     * @ e-mail : sim11@miraenet.com
     */
    public static String includeKSC(String ksc, HttpServletRequest req){
        req.getParameter("tomcat_bug");
        return (ksc);
    }
}