package com.hmm.asan.asanway.member;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
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
 * ������ - ȸ������
 */
public class HrMemberBean {
    private String dirName = WEBConstants.HRDBUPLOADDIR;
    private int maxFileSize = WEBConstants.HRDBUPLOADMAX;

    /**
     * ������ ȸ�� ����Ʈ
     * @author : ikara
     * @2005. 12. 06
     */

    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Hrmember List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String whereQuery  = "";
        String searchkey1 = request.getParameter("searchkey1");
        String searchkey2 = request.getParameter("searchkey2");
        String searchvalue = request.getParameter("searchvalue");

        //����
        if( searchkey1 == null  ||  searchkey1.equals("null") ||  searchkey1.equals("")){}else{
            whereQuery += " AND country = '" + searchkey1 + "'";
        }

        //����
        if( searchkey2 == null  ||  searchkey2.equals("null") ||  searchkey2.equals("")){}else{
            whereQuery += " AND jobgroup = '" + searchkey2 + "'";
        }

        //�̸�
        if( searchvalue == null  ||  searchvalue.equals("null") ||  searchvalue.equals("")){}else{
            whereQuery += " AND fname || lname || mname  like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);

        try{
            String totalQuery = ("select count(*) count from asan.hrdb where  idx > 0 AND isdel = '0' ");
            totalQuery += whereQuery;
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

            //��ü �Ϲ� ȸ��
            String  totalMember =String.valueOf(mdao.getRowCount("select count(*) count from asan.hrdb "));

            String listQuery = "select idx, fname,lname,mname, jobgroup, company, position, country, regtime  from asan.hrdb where idx > 0 and isdel = '0'";
            listQuery += whereQuery;
            listQuery += " order by idx desc";

            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);
            request.setAttribute("totalMember", totalMember);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * ������ ȸ�� ���
     * @author : ikara
     * @2005. 12 .06
     */

    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Hrmember Insert  *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
        String query = "";
        String isdel = "0";
        String section = "";

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);
            //System.out.println("dirname = " + dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());


            //1.max select
            query = "SELECT COALESCE(MAX(idx),0) + 1  FROM asan.hrdb";
            String maxNo = String.valueOf(mdao.getRowCount(query));

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regip", request.getRemoteHost());

            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");

            bean.remove("regday");

            bean.remove("czip1");
            bean.remove("czip2");

            bean.remove("hzip1");
            bean.remove("hzip2");

            bean.remove("tel11");
            bean.remove("tel12");
            bean.remove("tel13");

            bean.remove("tel21");
            bean.remove("tel22");
            bean.remove("tel23");

            bean.remove("mobile1");
            bean.remove("mobile2");
            bean.remove("mobile3");

            bean.remove("fax1");
            bean.remove("fax2");
            bean.remove("fax3");

            bean.remove("email1");
            bean.remove("email2");

            bean.remove("birthdayy");
            bean.remove("birthdaym");
            bean.remove("birthdayd");

            //�з� ����
            bean.remove("enteryear");
            bean.remove("graduyear");
            bean.remove("school");

            //�ֿ�������
            bean.remove("stdate");
            bean.remove("enddate");
            bean.remove("career");


            //���˻��� ����
            bean.remove("contactdate");
            bean.remove("content");

            //1.�⺻��������
            result =  mdao.insertQuery("asan.hrdb", bean);

             if(result > 0 ) {
                 //2. ���� ���� ����
                Enumeration files = multi.getFileNames();

                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);
                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put(name , filename);
                        fileBean.put("sys"+name, sysfilename);

                        mdao.updateQuery("asan.hrdb", fileBean, " where idx = " + maxNo);
                    }
                }

                //3.�з� ���� ����
                String[] enteryear =  multi.getParameterValues("enteryear");
                String[] graduyear =  multi.getParameterValues("graduyear");
                String[] school =  multi.getParameterValues("school");
                section = "1";
	  	        for(int i = 0;  i < enteryear.length; i++ ){
  	                  HashMap schbean = new HashMap();
  		              schbean.put("hidx", maxNo);
  		              schbean.put("section", section);
  		              schbean.put("sdate", enteryear[i]);
  		              schbean.put("edate", graduyear[i]);
  		              schbean.put("content", school[i]);
  		              schbean.put("isdel", isdel);
  		              schbean.put("reguser", session.getAttribute("adminidx"));
  		              schbean.put("regip", request.getRemoteHost());

  		              result = mdao.insertQuery("asan.hrdbadd",schbean);
	  	          }

                //4.�ֿ� ��� ���� ����
	  	        String[] stdate =  multi.getParameterValues("stdate");
	  	        String[] enddate =  multi.getParameterValues("enddate");
	  	        String[] career =  multi.getParameterValues("career");
	  	        section = "2";
		  	    for(int i = 0;  i < stdate.length; i++ ){
		                  HashMap schbean = new HashMap();
			              schbean.put("hidx", maxNo);
			              schbean.put("section", section);
			              schbean.put("sdate", stdate[i]);
			              schbean.put("edate", enddate[i]);
			              schbean.put("content", career[i]);
			              schbean.put("isdel", isdel);
			              schbean.put("reguser", session.getAttribute("adminidx"));
			              schbean.put("regip", request.getRemoteHost());

			              result = mdao.insertQuery("asan.hrdbadd",schbean);
	  	         }

                //5.���˻��� ����
	  	        String[] contactdate =  multi.getParameterValues("contactdate");
	  	        String[] content =  multi.getParameterValues("content");
	  	        section = "3";
		  	    for(int i = 0;  i < contactdate.length; i++ ){
	                  HashMap schbean = new HashMap();
		              schbean.put("hidx", maxNo);
		              schbean.put("section", section);
		              schbean.put("sdate", contactdate[i]);
		              schbean.put("content", content[i]);
		              schbean.put("isdel", isdel);
		              schbean.put("reguser", session.getAttribute("adminidx"));
		              schbean.put("regip", request.getRemoteHost());

		              result = mdao.insertQuery("asan.hrdbadd",schbean);
		        }
            }

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }


    /**
     * ������ ȸ�� read
     * @author : ikara
     * @2005. 12. 06
     */

    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Hrmember Read *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        ArrayList scholarship = null;
        ArrayList career = null;
        ArrayList contact = null;

        //      �ش� ���� id �Ǵ� �ڵ� ��ȣ
        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             * ȸ�� ����
             */
            beans = mdao.selectQuery("select *  from asan.hrdb where  idx = " + idx);
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

            /*�з� ���� */
            scholarship = mdao.selectQuery("SELECT sdate, edate, content FROM asan.hrdbadd where  hidx = " + idx + " AND section='1' AND isdel='0'");
            request.setAttribute("scholarship", scholarship);


            /*�ֿ��� ���� */
            career = mdao.selectQuery("SELECT sdate, edate, content FROM asan.hrdbadd where  hidx = " + idx + " AND section='2' AND isdel='0'");
            request.setAttribute("career", career);


            /*���˻��� ���� */
            contact = mdao.selectQuery("SELECT sdate, edate, content FROM asan.hrdbadd where  hidx = " + idx + " AND section='3' AND isdel='0'");
            request.setAttribute("contact", contact);


        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
    /**
     * ������ ȸ�� edit
     * @author : ikara
     * @2005. 12. 06
     */

    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Hrmember Update *****");
        MultiDAO mdao = new MultiDAO();
        int result = 0;

        String query = "";
        String isdel = "0";
        String section = "";

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);
            //System.out.println("dirname = " + dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            if(idx == null){
                idx = "";
            }

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgfiledel = multi.getParameter("imgfiledel");

            if( imgfiledel != null) {
                bean.put("imgfile", "");
                bean.put("sysimgfile", "");
            }

            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");
            bean.remove("imgfiledel");
            bean.remove("idx");

            bean.remove("regday");

            bean.remove("czip1");
            bean.remove("czip2");

            bean.remove("hzip1");
            bean.remove("hzip2");

            bean.remove("tel11");
            bean.remove("tel12");
            bean.remove("tel13");

            bean.remove("tel21");
            bean.remove("tel22");
            bean.remove("tel23");

            bean.remove("mobile1");
            bean.remove("mobile2");
            bean.remove("mobile3");

            bean.remove("fax1");
            bean.remove("fax2");
            bean.remove("fax3");

            bean.remove("email1");
            bean.remove("email2");

            bean.remove("birthdayy");
            bean.remove("birthdaym");
            bean.remove("birthdayd");

            //�з� ����
            bean.remove("enteryear");
            bean.remove("graduyear");
            bean.remove("school");

            //�ֿ�������
            bean.remove("stdate");
            bean.remove("enddate");
            bean.remove("career");


            //���˻��� ����
            bean.remove("contactdate");
            bean.remove("content");

            //1.�⺻����������Ʈ
            result = mdao.updateQuery("asan.hrdb", bean, " where idx = "+idx);
            System.out.println(result);
             if(result > 0 ) {
                 //2. ���� ���� ����
                Enumeration files = multi.getFileNames();

                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);
                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put(name , filename);
                        fileBean.put("sys"+name, sysfilename);

                        mdao.updateQuery("asan.hrdb", fileBean, " where idx = " + idx);
                    }
                }

                //3. ���� �߰�  ���� ����
               mdao.deleteQuery("DELETE FROM  asan.hrdbadd  where hidx = " + idx);

                //4.�з� ���� ����
                String[] enteryear =  multi.getParameterValues("enteryear");
                String[] graduyear =  multi.getParameterValues("graduyear");
                String[] school =  multi.getParameterValues("school");
                section = "1";
	  	        for(int i = 0;  i < enteryear.length; i++ ){
  	                  HashMap schbean = new HashMap();
  		              schbean.put("hidx", idx);
  		              schbean.put("section", section);
  		              schbean.put("sdate", enteryear[i]);
  		              schbean.put("edate", graduyear[i]);
  		              schbean.put("content", school[i]);
  		              schbean.put("isdel", isdel);
  		              schbean.put("reguser", session.getAttribute("adminidx"));
  		              schbean.put("regip", request.getRemoteHost());

  		              result = mdao.insertQuery("asan.hrdbadd",schbean);
	  	          }

                //5.�ֿ� ��� ���� ����
	  	        String[] stdate =  multi.getParameterValues("stdate");
	  	        String[] enddate =  multi.getParameterValues("enddate");
	  	        String[] career =  multi.getParameterValues("career");
	  	        section = "2";
		  	    for(int i = 0;  i < stdate.length; i++ ){
		                  HashMap schbean = new HashMap();
			              schbean.put("hidx", idx);
			              schbean.put("section", section);
			              schbean.put("sdate", stdate[i]);
			              schbean.put("edate", enddate[i]);
			              schbean.put("content", career[i]);
			              schbean.put("isdel", isdel);
			              schbean.put("reguser", session.getAttribute("adminidx"));
			              schbean.put("regip", request.getRemoteHost());

			              result = mdao.insertQuery("asan.hrdbadd",schbean);
	  	         }

                //6.���˻��� ����
	  	        String[] contactdate =  multi.getParameterValues("contactdate");
	  	        String[] content =  multi.getParameterValues("content");
	  	        section = "3";
		  	    for(int i = 0;  i < contactdate.length; i++ ){
	                  HashMap schbean = new HashMap();
		              schbean.put("hidx", idx);
		              schbean.put("section", section);
		              schbean.put("sdate", contactdate[i]);
		              schbean.put("content", content[i]);
		              schbean.put("isdel", isdel);
		              schbean.put("reguser", session.getAttribute("adminidx"));
		              schbean.put("regip", request.getRemoteHost());

		              result = mdao.insertQuery("asan.hrdbadd",schbean);
		        }
            }
            request.setAttribute("idx", idx);

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }



    /**
     * ������ ȸ�� ����
     * @author : ikara
     * @2005. 12. 06
     */

    public int Delete(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Hrmember Delete *****");

        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

        MultiDAO mdao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String lastuser = (String)session.getAttribute("adminidx");
            String lastip = request.getRemoteHost();

            //������ȸ������ ������Ʈ
            result = mdao.updateQuery("UPDATE    asan.hrdb SET isdel = '1'  where idx = " + idx);

            //�߰� ���� ������Ʈ
            mdao.updateQuery("UPDATE    asan.hrdbadd SET isdel = '1'  where hidx = " + idx);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    /**
     * ������ ȸ�� ���� ����
     * @author : ikara
     * @2005. 12. 06
     */

    public int DeleteAll(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Hrmember Delete All*****");

        MultiDAO mdao = new MultiDAO();
        int result = 1;

        try {
            HttpSession session = request.getSession();
            String lastuser = (String)session.getAttribute("adminidx");
            String lastip = request.getRemoteHost();

            String[] idx =  request.getParameterValues("chk");
      	    for(int i = 0;  i < idx.length; i++ ){
      	      mdao.updateQuery("UPDATE   asan.hrdb SET isdel = '1'  where idx = " + idx[i]);
      	      mdao.updateQuery("UPDATE   asan.hrdbadd SET isdel = '1'  where hidx = " + idx[i]);
            }

        }catch (Exception e){
            result = 0;
            e.printStackTrace();
        }
        return result;
    }


    /**
     *������ ȸ�� ���� backup��   ����Ʈ
     * @author : ikara
     * @2005. 11. 09
     */

    public void ExcelList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Hrmember Excel List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        try{
            String listQuery = "SELECT * FROM asan.hrdb A, " +
            		" (SELECT hidx, MAX(sdate1) sdate1, MAX(edate1) edate1, MAX(content1) content1,MAX(sdate2) sdate2 , MAX(edate2) edate2, MAX(content2) content2,MAX(sdate3) sdate3 , MAX(content3) content3 FROM " +
            		" (SELECT  C.hidx, sdate sdate1, edate edate1, content content1, '0' sdate2, '0' edate2,'0' content2, '0' sdate3, '0' content3 FROM asan.hrdbadd C," +
            		" (SELECT MAX(idx) idx FROM asan.hrdbadd WHERE isdel = '0' AND section = '1' GROUP BY hidx) D " +
            		" WHERE C.idx = D.idx AND isdel = '0' AND section = '1' " +
            		" UNION ALL " +
            		" SELECT  C.hidx, '0' sdate1, '0' edate1, '0' content1, sdate sdate2, edate edate2,content content2, '0' sdate3, '0' content3 FROM asan.hrdbadd C, " +
            		" (SELECT MAX(idx) idx FROM asan.hrdbadd WHERE isdel = '0' AND section = '2' GROUP BY hidx) D" +
            		" WHERE C.idx = D.idx AND isdel = '0' AND section = '2'" +
            		" UNION ALL " +
            		" SELECT  C.hidx, '0' sdate1, '0' edate1, '0' content1, '0' sdate2, '0' edate2, '0' content2, sdate sdate3, content content3 FROM asan.hrdbadd C, " +
            		" (SELECT MAX(idx) idx FROM asan.hrdbadd WHERE isdel = '0' AND section = '3' GROUP BY hidx) D" +
            		" WHERE C.idx = D.idx AND isdel = '0' AND section = '3'" +
            		" )  as tmp" +
            		" GROUP BY  hidx) B WHERE A.idx = B.hidx";

            list = mdao.selectQuery(listQuery);
            request.setAttribute("excellist", list);
            System.out.println(listQuery);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}