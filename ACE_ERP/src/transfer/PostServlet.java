package transfer;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class PostServlet extends javax.servlet.http.HttpServlet {
    protected void doGet (HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException
    {
        res.setContentType("text/plain;charset=euc-kr");
        PrintWriter out = res.getWriter();
        out.println("Hey, don't call by GET Method");
        out.close();
    }        


    protected void doPost (HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException
    {
        res.setContentType("text/plain;charset=euc-kr");
        PrintWriter out = res.getWriter();
        String name = null;
        try{ name = req.getParameterValues("name")[0];}catch(Exception e){}
        String address = null;
        try{ address = req.getParameterValues("address")[0];}catch(Exception e){}
        String msg= null;
        try{ msg= req.getParameterValues("msg")[0];}catch(Exception e){}

        out.println("name : " + name);
        out.println("address : " + address);
        out.println("msg : " + msg);
        out.println("date : " + new java.util.Date());
        out.close();
    }
}
