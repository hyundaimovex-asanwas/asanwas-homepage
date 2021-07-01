package com.hmm.asan.board;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;
import com.hmm.asan.common.util.WEBConstants;

import com.oreilly.servlet.MultipartRequest;


/**
 * 게시판
 */
public class BoardBean {

    private String dirName = WEBConstants.NEWSUPLOADDIR;
    private int maxFileSize = WEBConstants.NEWSUPLOADMAX;

    /**
     * ����Ʈ
     * @author : Mr.K JM
     * @2005. 10. 10
     */
    public int List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** board List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList count = null;
        ArrayList list = null;
        int result = 0;

        /**
         * ����¡
         */
        PagingHelper helper = new PagingHelper();

        try{

            /*	        conn = UtilDB.getConnection("jdbc/asan");
             pstmt = conn.prepareStatement("SELECT * FROM SYSIBM.SYSVIEWS");
             rs   = pstmt.executeQuery();*/

            String totalQuery = ("SELECT COUNT(*) count FROM SYSIBM.SYSDUMMY1");
            int num = mdao.getRowCount(totalQuery);

            helper.setTotalcount(num);

            String selectPage = request.getParameter("page");
            int page = 0;
            if(selectPage == null || selectPage.equals("")) {
                page = 1;
            }else{
                page = Integer.parseInt(selectPage);
            }

            helper.setCurpage(page);
            helper.setPageNav();


            String listQuery = "SELECT * FROM SYSIBM.SYSDUMMY1";

            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;

    }


    /**
     * �Խ��� ���
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        /**
         * Count�� �̿��Ͽ� �Խ��� No�� ���Ѵ�.
         */
        String totalQuery = ("SELECT COUNT(*) count FROM SYSIBM.SYSDUMMY1");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }

        int maxNo = Integer.parseInt(count)+1;


        /**
         *  multi�� ��; �޾� DB�� �����ϰ�, ����; �����Ѵ�.
         */
        try {
            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();

                String value = (multi.getParameter(name));
                if(value != null && !value.equals(""))
                    bean.put(name, value);
                //out.println(name + "=" + value);
                //out.println("<br>");
            }

            bean.remove("y");
            bean.remove("x");

            mdao.insertQuery("tablename", bean);



            Enumeration files = multi.getFileNames();

            while (files.hasMoreElements()) {

                String name = (String)files.nextElement();
                String filename = (multi.getFilesystemName(name));
                String originalFilename = (multi.getOriginalFileName(name));
                String ContentType = (multi.getContentType(name));
                File f = multi.getFile(name);
                //out.println("name: " + name);
                //out.println("filename: " + filename);
                //out.println("originalFilename: " + originalFilename);
                //out.println("type: " + type);

                if (f != null) {
                    //out.println("f.toString(): " + f.toString());
                    //out.println("f.getName(): " + f.getName());
                    //out.println("f.exists(): " + f.exists());
                    //out.println("f.length(): " + f.length());


                    //name�� ���ڰ�; ���Ѵ�.
                    String s = new String(name);
                    int nameSize = s.length();
                    String name_num = s.substring(nameSize-1);

                    HashMap fileBean = new HashMap();

                    //����; ÷�� ����;�� ���� ó��
                    fileBean.put(name, filename);
                    fileBean.put("filedown"+name_num, filename);
                    fileBean.put("filesize"+name_num, new Long(f.length()).toString());

                    //--------------------------------------------deburg-------------------------------------------//
                    //System.out.println("CommunicationServlet@regist ----> name_num = "+name_num);

                    //System.out.println("CommunicationServlet@regist ----> name = "+name);
                    //System.out.println("CommunicationServlet@regist ----> filename = "+filename);

                    //System.out.println("CommunicationServlet@regist ----> filedown + name_num  = "+"filedown"+name_num);
                    //System.out.println("CommunicationServlet@regist ----> filename = "+filename);

                    //System.out.println("CommunicationServlet@regist ----> filesize + name_num = "+"filesize"+name_num);
                    //System.out.println("CommunicationServlet@regist ----> filesize = "+new Long(f.length()).toString());
                    //--------------------------------------------deburg-------------------------------------------//

                    mdao.updateQuery("tablename", fileBean, " where no = " + maxNo);
                }
                //out.println();

            }
        }catch (Exception e) {
            try {
                PrintWriter out = response.getWriter();
                response.setContentType("text/plain");
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("���� ũ�Ⱑ ")+fileSize+Utility.en("MB�� �Ѿ�4ϴ�.")+"');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }


    /**
     * ��d
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int Update(HttpServletRequest request, HttpServletResponse response) {

        int result = 0;

        //	�ش� ���� id �Ǵ� �ڵ� ��ȣ
        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

        MultiDAO mdao = new MultiDAO();

        /**
         *  multi�� ��; �޾� DB�� �����ϰ�, ����; �����Ѵ�.
         */

        try {

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(15);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = Utility.ko(multi.getParameter(name));

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.remove("y");
            bean.remove("x");

            mdao.updateQuery("tablename", bean, " where idx = "+idx);

            //����ó�� �κ�
            Enumeration files = multi.getFileNames();

            while (files.hasMoreElements()) {

                HashMap fileBean = new HashMap();

                String name = (String)files.nextElement();
                String filename = multi.getFilesystemName(name);
                String originalFilename = multi.getOriginalFileName(name);
                String ContentType = multi.getContentType(name);
                File f = multi.getFile(name);

                if (f != null) {

                    String s = new String(name);
                    int nameSize = s.length();
                    String name_num = s.substring(nameSize-1);

                    //��ο� ���� ÷�� ��;�� ��x ���� ��f
                    ArrayList oldFileDownBean = mdao.selectQuery("select filedown" + name_num + " from tablename where idx = "+idx);
                    HashMap oldFileDownValue = (HashMap)oldFileDownBean.get(0);
                    String oldFileDown = oldFileDownValue.get("filedown"+name_num).toString();

                    //��f ���� ��f
                    if(!oldFileDown.equals("")){
                        File file = new File(dirName + Utility.en(oldFileDown));
                        if(file.exists());
                        file.delete();
                    }

                    //out.println("<script>alert('"+Utility.en("���� ��d�ÿ� ��x ����; ��f�ϴµ� ���� �Ͽ��4ϴ�.")+"');history.back();</script>");
                    //out.close();

                    //����; ÷�� ��; ��츸 ����d�� �Է�
                    fileBean.put(Utility.ko(name), Utility.ko(filename));
                    fileBean.put("filedown"+name_num, Utility.ko(filename));
                    fileBean.put("filesize"+name_num, new Long(f.length()).toString());
                    fileBean.put("filecount"+name_num, new Integer(0));

                    mdao.updateQuery("tablename", fileBean, " where idx = " + idx);

                }
                //out.println();

            }

        }catch (Exception e) {
            try {
                PrintWriter out = response.getWriter();
                int fileSize = maxFileSize/(1024*1024);
                String url = request.getRequestURI()+"?";
                out.println("<script language='javascript'>location.href('"+url+"');</script>");
                out.close();
            } catch(Exception e1){}
        }
        return result;

    }


    /**
     * Delete ��f
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int Delete(HttpServletRequest request, HttpServletResponse response){

        int result = 0;
        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }


        MultiDAO mdao = (MultiDAO)request.getAttribute("dao");

        try {
            PrintWriter out = response.getWriter();

            ArrayList delFileDownBean = mdao.selectQuery("select filedown1, filedown2, filedown3, filedown4, filedown5 from tablename where idx = "+idx);

            HashMap delFile_values = (HashMap)delFileDownBean.get(0);

            //��f ���� ��f
            for(int i=1; i<6; i++){

                //---------- ���丮 ������ ��� x��
                if(delFile_values.get("filedown"+i).toString() != null || delFile_values.get("filedown"+i).toString().equals("")){
                    File file = new File(dirName + Utility.en(delFile_values.get("filedown"+i).toString()));

                    if(file.exists()) {
                        file.delete();
                    }
                }
            }

            mdao.deleteQuery("delete from tablename where idx = "+idx);

            /**
             * Redirection.
             */
            String url = request.getRequestURI()+"";
            out.println("<script language='javascript'>location.href('"+url+"');</script>");
            out.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }


    /**
     * Update ��f
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int uDelete(HttpServletRequest request, HttpServletResponse response){
        // ��f�� Notice idx�� ����� �´�.
        String idx = request.getParameter("idx");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String emailid = (String)session.getAttribute("adminlogin");

            result = dao.updateQuery("update eng_board set isdel = 1, lastuser='"+ emailid +"', lasttime = '"+ new Timestamp(System.currentTimeMillis()) +"' where idx = " + idx);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
}