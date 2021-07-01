package common.groupware;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.io.IOException;

/**
 * GroupWare요청사항을 가우스를 통하지 않고 서버로 전송 처리하는 프로그램
 * @author 권혁수
 * @version 1.0, 2009.12.02
 * @see
 */
public class GroupWareServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException ,IOException {
		try
		{
			String ENO_NO = req.getParameter("ENO_NO").substring(3);
			//System.out.println("그룹웨어 미결재현황개수 ENO_NO [" + ENO_NO + "]");
			//int cnt = 0;

			GroupWareDAO gw = new GroupWareDAO();
			int cnt = gw.getAppCnt( ENO_NO );

			//System.out.println(cnt);
			res.setContentType("text/html");
			PrintWriter pw = res.getWriter();
			pw.println(cnt);
			pw.close();

		} catch (Exception e) {
			System.out.println("GroupWareServlet ........ Error !!");
			e.printStackTrace();
		}
	}
    public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
		res.setContentType("text/html;charset=euc-kr");

		doGet(req,res);
   }
}
