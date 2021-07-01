/*******************************************************************************
 * 1.클래스   명 : Initializer.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2006-02-02
 ******************************************************************************/

package sales.org.common;


import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

import sales.org.common.code.CodeManager;
import sales.org.common.log.LogUtil;
import sales.org.common.property.CommonProperty;


public class Initializer extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void init() {
        LogUtil.info("initialize Start-----------------------------");
        initialize();
        LogUtil.info("initialize End-------------------------------");
    }

  public void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException {
        LogUtil.info("Refresh Start-----------------------------");
        initialize();
        LogUtil.info("Refresh End-------------------------------");
    }

  public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException {
        LogUtil.info("Refresh Start-----------------------------");
        initialize();
        LogUtil.info("Refresh End-------------------------------");
    }

    private void initialize() {
        try {
            ServletContext servletCtx = getServletConfig().getServletContext();
            CommonProperty.setWebAppHome(servletCtx.getRealPath(""));
            CommonProperty.init();
            CodeManager.init();
            CodeManager.testCode();
        } catch (Exception e) {
            LogUtil.error(e);
        }
    }

    private void uninitialize() {
    }

    public void destroy() {
        super.destroy();
        uninitialize();
    }
}