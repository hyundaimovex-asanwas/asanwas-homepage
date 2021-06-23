/*
 * �� Ŭ�������� JSP �������� ���õ� ��ƿ��Ƽ �޼ҵ带 �߰��մϴ�.
 */
 
package kr.co.imjk.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

public class JspUtil{
    /**
     * JSP ���������� useBean �ױ׷� ������ Instance�� referance�� �ٸ� Bean�� �ּҰ����� �ٲپ� �ִ� �޼ҵ�<br>
     * Tomcat ������ useBeanInstance = newBeanInstance ���·� ���ʷ� ������ instance�� �ٲ��� �����Ƿ� <br>
     * ���ο� referance�� jspContext�� �־��־�� <jsp:getProperty> �ױ׸� ����� �� �ִ�. <br>
     * ��Ÿ JSP Container �� ��쿡�� ������� referance�� �Ҵ��ϱ⸸ �ϸ� �ȴ�.
     *
     * parameter : <br>
     *  - jspContext : PageContext<br>
     *  - beanName : useBean �ױ׿��� instance ������ ���� id �̸�<br>
     *  - beanInstance : useBean �ױ׷� ���ʷ� ������ instance<br>
     *  - newInstance : beanInstance�� ��ü�� ���ο� bean instance<br>
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
     * ���ǰ��� ������ �ö� �����̳� ���ε��� ���� ������ Exception�� �߻��ϹǷ� �̸� �˻��Ͽ� null���� �����ϴ� �޼ҵ�
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
     * JSP ������ include �Ҷ� �ѱ� �Ķ���Ͱ� ������ ������ �������� �޼ҵ�<br>
     * ��Ĺ������ ��Ŭ��� �ɱ����� � �Ķ���Ͷ� �ѹ� ������ �ѱ��� ���ٸ� ���ڵ� ���� ���� <br>
     * ���޵Ǿ� ����, �׷��� ������ �ѱ��� �����Ƿ� ������ �Ķ���͸� �ޱ⸦ �õ��ϴ� �޼ҵ�.<br>
     * ��Ĺ�� ���״� ������ �������� ~~ .. -_-;;
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