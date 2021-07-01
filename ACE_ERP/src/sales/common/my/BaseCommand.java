package sales.common.my;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import sales.common.HDConstant;
import sales.common.StringUtil;

/**
 * BaseCommond
 * 기본적인 Servlet 사용 비지니스 로직이 들어간다 
 */
public abstract class BaseCommand {
	
	public StringBuffer[] arr_sql = new StringBuffer[50];
	public String returnPage = "";
	
	public String getJspRoot() {
		return "/jsp/";
	}
	
	public BaseCommand() {
		
	};

	/**
	 * 쿼리 
	 */
	public abstract void makeSql();

	/**
	 * 추상 클래스 각 커맨드는 구현해야한다 
	 * @param req
	 * @param res
	 * @return
	 * @throws ServletException
	 */
	public String execute(HttpServletRequest req, HttpServletResponse res)
			throws ServletException {
		// TODO Auto-generated method stub
		
		String proType = req.getParameter("process_flag");
		
		String returnPage = "";
		
		StringUtil.printMsg("글번호 나와라 ", req.getParameter("brd_no"), this);
		BaseDataClass param = new BaseDataClass(req);
		
		StringUtil.printMsg("글번호 나와라 2", param.get("brd_no"), this);
		Connection conn = null;
		try {
			conn = DBManager.getInstance().getConnection();
			
			makeSql();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (HDConstant.PROCESS_TYPE_SEARCH.equals(proType)) {
			returnPage = select(conn, req, res, param);
		} else if (HDConstant.PROCESS_TYPE_INSERET.equals(proType)) {
			returnPage = insert(conn, req, res, param);
		} else if (HDConstant.PROCESS_TYPE_UPDATE.equals(proType)) {
			returnPage = update(conn, req, res, param);
		} else if (HDConstant.PROCESS_TYPE_DELETE.equals(proType)) {
			returnPage = delete(conn, req, res, param);
		} else if (HDConstant.PROCESS_TYPE_MODIFY.equals(proType)) {
			returnPage = modify(conn, req, res, param);
		} else if (HDConstant.PROCESS_TYPE_EDIT.equals(proType)) {
			returnPage = edit(conn, req, res, param);
		} else if (HDConstant.PROCESS_TYPE_REPLY.equals(proType)) {
			returnPage = reply(conn, req, res, param);
		}
		return returnPage;
	}

	
	public abstract String select(Connection conn, HttpServletRequest req, HttpServletResponse res, BaseDataClass param);
	public abstract String insert(Connection conn, HttpServletRequest req, HttpServletResponse res, BaseDataClass param);
	public abstract String update(Connection conn, HttpServletRequest req, HttpServletResponse res, BaseDataClass param);
	public abstract String delete(Connection conn, HttpServletRequest req, HttpServletResponse res, BaseDataClass param);
	public abstract String modify(Connection conn, HttpServletRequest req, HttpServletResponse res, BaseDataClass param);
	public abstract String edit(Connection conn, HttpServletRequest req, HttpServletResponse res, BaseDataClass param);
	public abstract String reply(Connection conn, HttpServletRequest req, HttpServletResponse res, BaseDataClass param);
	
}
