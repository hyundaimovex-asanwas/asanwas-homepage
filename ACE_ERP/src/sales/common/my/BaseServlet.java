package sales.common.my;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import sales.common.StringUtil;

public class BaseServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException {
		performTask(req,res);
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException  {
		performTask(req,res);
	}
	
	public void performTask (HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException  {
		
		String actId = "";												
			
			actId = req.getParameter("actId"); // 호출할 Action ID
		
		
		// 일반 서블릿
		BaseCommand command = null;
		
		String page = null; 
		StringUtil.printMsg("actId-- ",actId, this);
		try {
			command = (BaseCommand)BaseCommandMap.getCommandHandler(actId);
			
			page = command.execute(req, res);
			
			StringUtil.printMsg("RETURN PAGE",page, this);
			dispatch(req, res, page);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void dispatch(HttpServletRequest req, HttpServletResponse res, String page) throws ServletException, IOException {
		   try {
			   
			   RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
			   dispatcher.forward(req, res);
		   } catch (Exception e) {
			   e.printStackTrace();
			   StringUtil.printMsg("BaseServlet Exception", this);
				
		   }
	   }
}
