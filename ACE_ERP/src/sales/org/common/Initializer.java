/*******************************************************************************
 * 1.Ŭ����   �� : Initializer.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
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