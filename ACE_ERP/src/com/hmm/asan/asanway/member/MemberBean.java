package com.hmm.asan.asanway.member;

import java.io.PrintWriter;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;

/**
 * ������ - ȸ������
 */
public class MemberBean {


    /**
     *ȸ��  ����Ʈ
     * @author : ikara
     * @2005. 10. 27
     */

    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Member List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String mtype = request.getParameter("mtype");

        //ȸ�� ����
        String whereQuery = "";

        if( mtype == null || mtype == ""  || mtype.equals("null") || mtype.equals("")){
        }else if (mtype.equals("1")){
            whereQuery = " AND isreal = '" + mtype + "'";
        }else if (mtype.equals("2")){
            whereQuery = " AND  level = '" + mtype + "'";
        }

        if( searchkey != null  &&  searchkey != ""){
            whereQuery += " AND " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);

        try{
            String totalQuery = ("select count(*) count from asan.member where  idx > 0 ");
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
            String  totalMember =String.valueOf(mdao.getRowCount("select count(*) count from asan.member "));

            //���� ������ ȸ����
            String  todayMember =String.valueOf(mdao.getRowCount("select count(*) count from asan.member where  date(regtime) = current date "));


            String listQuery = "select idx,  id, name, email, mobile, tel, regtime, level  from asan.member where idx > 0 ";
            listQuery += whereQuery;
            listQuery += " order by idx desc";

            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);
            request.setAttribute("totalMember", totalMember);
            request.setAttribute("todayMember", todayMember);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    /**
     * ȸ��  read
     * @author : ikara
     * @2005. 10. 27
     */

    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Member Read *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        //      �ش� ���� id �Ǵ� �ڵ� ��ȣ
        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             * ȸ�� ����
             */
            beans = mdao.selectQuery("select id, pwd, name,regno,gender, birthday, birthgbn, area, addrgbn, zip, addr1, addr2," +
            		"telgbn, tel, fax, mobile,job, company, email, iswedding, istravel, isletter, agentname, agentregno, agentemail, " +
            		"agentzip, agentaddr1, agentaddr2, agenttel, isreal, level  from asan.member where  idx = " + idx);
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    /**
     * ȸ������  ����
     * @author : ikara
     * @2005. 10. 27
     */

    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Member Update *****");

        int result = 0;

        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

        HttpSession session = request.getSession();
        MultiDAO mdao = new MultiDAO();

        //      �������� ���� ����
        String isletter = (String)request.getParameter("isletter");
        if (isletter==null){
            isletter = "";
    	}

        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

        	bean.put("lastuser", session.getAttribute("adminidx"));
			bean.put("lastip", request.getRemoteHost());
			bean.put("lasttime", new Timestamp(System.currentTimeMillis()) );
			bean.put("isletter", isletter);

            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");
            bean.remove("idx");
            bean.remove("mtype");

            bean.remove("birthdayy");
            bean.remove("birthdaym");
            bean.remove("birthdayd");

            bean.remove("zip1");
            bean.remove("zip2");

            bean.remove("tel1");
            bean.remove("tel2");
            bean.remove("tel3");

            bean.remove("mobile1");
            bean.remove("mobile2");
            bean.remove("mobile3");

            bean.remove("email1");
            bean.remove("email2");
            bean.remove("email3");

            bean.remove("agentregno1");
            bean.remove("agentregno2");

            bean.remove("agentemail1");
            bean.remove("agentemail2");
            bean.remove("agentemail3");

            bean.remove("agentzip1");
            bean.remove("agentzip2");

            bean.remove("agenttel1");
            bean.remove("agenttel2");
            bean.remove("agenttel3");

             bean.remove("checkaddr");


            result = mdao.updateQuery("asan.member", bean, " where idx = "+idx);
            request.setAttribute("idx", idx);

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return result;
    }



    /**
     * ȸ�� ����
     * @author : ikara
     * @2005. 10. 27
     */
    public int Delete(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Member Delete *****");

        String idx = request.getParameter("idx");
        String id = request.getParameter("id");
        if(idx == null){
            idx = "";
            id = "";
        }

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String lastuser = (String)session.getAttribute("adminidx");
            String lastip = request.getRemoteHost();

            //ȸ������ ����
            result = dao.deleteQuery("DELETE FROM  asan.member  where idx = " + idx);

            //ȸ���� �ۼ��� �� ���� ���� (id�� ���� �Ѵ�.-������ idx�� �ߺ� )
            if(result > 0){
                //dao.deleteQuery("DELETE FROM  asan.member  where idx = " + idx);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }



    /**
     * ȸ�� ��� ������Ʈ
     * @author : ikara
     * @2005. 10. 27
     */
    public int UpdateLevel(HttpServletRequest request, HttpServletResponse response){
        String idx = request.getParameter("idx");
        String level = request.getParameter("level");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.member set level = '"+level+"', " +
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
     *ȸ�� ���� backup��   ����Ʈ
     * @author : ikara
     * @2005. 11. 09
     */

    public void ExcelList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Member Excel List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        try{
            String listQuery = "select idx,  id, pwd, name, regno, gender, birthday, birthgbn, area, addrgbn, zip, addr1,addr2, " +
            		"telgbn, tel, fax, mobile, job, company, email, istravel, isletter, agentname, agentregno, agentemail, agentzip," +
            		"agentaddr1, agentaddr2, agenttel, isreal, level,  regtime from asan.member where idx > 0 ";
            listQuery += " order by idx ASC";

            list = mdao.selectQuery(listQuery);
            request.setAttribute("excellist", list);
            System.out.println(listQuery);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    /**
     * ȸ�����
     * @author : ikara
     * @2005. 11.09
     */
    public void Stat(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Member Stat *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;
        HashMap areahm = null;

        try {
            //������
            String areaQuery = " SELECT " +
            		"SUM(CASE WHEN area = '1' Then 1 ELSE 0 END) cnt1, " +																							//���� => ����
            		"FLOAT(ROUND(SUM(CASE WHEN area = '1' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent1, " +								//���� (%)
            		"SUM(CASE WHEN area = '4'  OR area='8' Then 1 ELSE 0 END) cnt2, " +																	//��õ, ��� => ��⵵
            		"FLOAT(ROUND(SUM(CASE WHEN area = '4'  OR area='8' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent2, " +			//��⵵ (%)
            		"SUM(CASE WHEN area = '9' Then 1 ELSE 0 END) cnt3, " +																						//���� => ������
            		"FLOAT(ROUND(SUM(CASE WHEN area = '9' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent3, " +								//������ (%)
            		"SUM(CASE WHEN area = '6' OR area='10'  OR area='11'  Then 1 ELSE 0 END) cnt4, " +											//���� , �泲 , ���  => ��û��
            		"FLOAT(ROUND(SUM(CASE WHEN area = '6' OR area='10'  OR area='11'  Then 1 ELSE 0 END)*100/COUNT(*),1)) percent4, " +		//��û�� (%)
            		"SUM(CASE WHEN area = '2' OR area='3'  OR area='7'  OR area='14'  OR area='15' Then 1 ELSE 0 END) cnt5, " +	//�λ�, �뱸, ��� , �泲 , ���  => ���
            		"FLOAT(ROUND(SUM(CASE WHEN area = '2' OR area='3'  OR area='7'  OR area='14'  OR area='15' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent5, " +		//��� (%)
            		"SUM(CASE WHEN area = '5' OR area='12'  OR area='13'  Then 1 ELSE 0 END) cnt6, " +											//���� , ���� , ����  => ����
            		"FLOAT(ROUND(SUM(CASE WHEN area = '5' OR area='12'  OR area='13'  Then 1 ELSE 0 END)*100/COUNT(*),1)) percent6, " +		//���� (%)
            		"SUM(CASE WHEN area = '16' Then 1 ELSE 0 END) cnt7, " +																						//����  => ����
            		"FLOAT(ROUND(SUM(CASE WHEN area = '16' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent7, " +							//���� (%)
            		"COUNT(*) totalcount  " +																																				//��ü count
            		" FROM asan.member";
            list = mdao.selectQuery(areaQuery);
            areahm = (HashMap)list.get(0);
            request.setAttribute("arealist", areahm);

            //���Ѱ��� ����
            String travelQuery =  " SELECT " +
	    			"SUM(CASE WHEN istravel = '0' Then 1 ELSE 0 END) cnt1, " +																	//����
	    			"FLOAT(ROUND(SUM(CASE WHEN istravel = '0' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent1, " +		//���� (%)
	    			"SUM(CASE WHEN istravel = '1'   Then 1 ELSE 0 END) cnt2, " +																	//����
	    			"FLOAT(ROUND(SUM(CASE WHEN istravel = '1' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent2 " + 		//���� (%)
	    			" FROM asan.member";
            list = mdao.selectQuery(travelQuery);
	         areahm = (HashMap)list.get(0);
	         request.setAttribute("travellist", areahm);

            //����
            String genderQuery =  " SELECT " +
			"SUM(CASE WHEN gender = 'M' Then 1 ELSE 0 END) cnt1, " +																	//��
			"FLOAT(ROUND(SUM(CASE WHEN gender = 'M' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent1, " +		//�� (%)
			"SUM(CASE WHEN gender = 'F'   Then 1 ELSE 0 END) cnt2, " +																	//��
			"FLOAT(ROUND(SUM(CASE WHEN gender = 'F' Then 1 ELSE 0 END)*100/COUNT(*),1)) percent2 " + 		//�� (%)
			" FROM asan.member";

            list = mdao.selectQuery(genderQuery);
            areahm = (HashMap)list.get(0);
            request.setAttribute("genderlist", areahm);

        }catch (Exception e){
            e.printStackTrace();
        }

    }

}