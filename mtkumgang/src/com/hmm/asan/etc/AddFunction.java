package com.hmm.asan.etc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;


public class AddFunction {
    public int UpdateStatus(HttpServletRequest request, HttpServletResponse response){
        String idx = request.getParameter("idx");
        String status = request.getParameter("status");
        String tablename = request.getParameter("tablename");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan."+tablename+" set status = '"+status+"', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where idx = " + idx);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 
     * @author : Mr.K JM
     * int
     * @param request
     * @param response
     * @param tablename
     * @return
     */
    public int UpdateHit(HttpServletRequest request, HttpServletResponse response, String tablename){
        String idx = request.getParameter("idx");
        //String tablename = request.getParameter("tablename");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            result = dao.updateQuery("update asan."+tablename+" set hit = hit + 1  " +
                                    " where idx = " + idx);
            
            request.setAttribute("idx", idx);
            
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}