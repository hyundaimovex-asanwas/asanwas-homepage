/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005. 10. 18
* ��༳�� : AuthBean
**
* �����ð�	: ������ : ��������
*
*
******************************************/

package com.hmm.asan.asanway.admin;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.PagingHelper;

/**
* Admin ���� ����
*/
public class AuthBean {

    /**
     * Admin ����Ʈ
     * @author : ikara
     * @2005. 10. 18
     */

    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Admin User List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");

        String whereQuery = "";
        if( searchkey != null ){
            whereQuery = " AND " + searchkey + " LIKE '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);

        try{
            String totalQuery = "SELECT COUNT(*) count FROM asan.admin WHERE isdel = '0' AND  grade='1'";
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


            String listQuery = "SELECT idx,  id,name,email, regtime  FROM asan.admin WHERE  isdel = '0' AND  grade='1'";
            listQuery += whereQuery;
            listQuery += " order by idx desc";

            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

   /**
    * Admin ���� ����Ʈ - ����Ʈ value
    * @param request, response, admin_idx
    * @author : ikara
    * @2005. 11. 11
    */
  public void AuthList(HttpServletRequest request, HttpServletResponse response,  String idx){
		System.out.println("***** Auth  List *****");

		MultiDAO mdao = new MultiDAO();
		ArrayList list = null;

		try {
		    String query = "SELECT A.idx,A.name  FROM asan.menu A, asan.adminauth B " +
		    						" WHERE A.idx = B.menuidx AND A.isdel = '0'  AND B.isdel = '0' AND B.auth = '1' AND B.adminidx = " + idx  + " order by A.idx asc";

			list = mdao.selectQuery(query);
			request.setAttribute("authlist", list);

		}catch(Exception e){
			e.printStackTrace();
		}
	}	// End AuthList


  /**
   * Admin  �޴� �з�  ����Ʈ
   * @author : ikara
   * @2005. 11.11
   */
 public void CateList(HttpServletRequest request, HttpServletResponse response){
		System.out.println("***** AdminCate List *****");

		MultiDAO mdao = new MultiDAO();
		ArrayList list = null;
		try {
			String query = "SELECT idx,name FROM asan.menucate WHERE isdel = '0'  ";
			list = mdao.selectQuery(query);

			request.setAttribute("catelist", list);

		}catch(Exception e){
			e.printStackTrace();
		}
	}	// End CateList


 /**
  * Admin  �޴�  ����Ʈ - ���
  * @author : ikara
  * @2005. 11.11
  */
public void MenuList(HttpServletRequest request, HttpServletResponse response){
		System.out.println("***** menu List 1*****");

		MultiDAO mdao = new MultiDAO();
		ArrayList list = null;
		try {
			String query = "SELECT idx, cateidx, name FROM asan.menu WHERE isdel = '0'  ";
			list = mdao.selectQuery(query);
			request.setAttribute("menulist", list);

		}catch(Exception e){
			e.printStackTrace();
		}
}	// End MenuList


/**
 * Admin  �޴�  ����Ʈ - ����
 * @param request, response, admin_idx
 * @author : ikara
 * @2005. 11.11
 */
public void MenuList(HttpServletRequest request, HttpServletResponse response, String idx){
		System.out.println("***** menu List 2*****");

		MultiDAO mdao = new MultiDAO();
		ArrayList list = null;
		try {
		    String query = "SELECT A.idx, cateidx, A.name,COALESCE(B.auth,0) auth  FROM asan.menu A LEFT OUTER JOIN  asan.adminauth B " +
					" ON A.idx = B.menuidx AND A.isdel = '0'  AND B.isdel = '0'  AND B.adminidx = " + idx  + " order by A.idx asc";
			list = mdao.selectQuery(query);

			request.setAttribute("menulist", list);

		}catch(Exception e){
			e.printStackTrace();
		}
}	// End MenuList


   /**
    * Admin ���
    * @author : ikara
    * @2005. 11 . 11
    */
   public int Insert(HttpServletRequest request, HttpServletResponse response) {
       System.out.println("***** Admin User Insert*****");
       MultiDAO mdao = new MultiDAO();

       int result = 0;

       String reguser = "";
	   String regip = "";

       HttpSession session = request.getSession();

		reguser = (String)session.getAttribute("adminidx");
		regip = request.getRemoteHost();

		 //1.�ߺ�üũ (ȸ�� DB�� Admin DB��� üũ)
        String id = request.getParameter("id");
        String query = "SELECT SUM(cnt) count FROM ( " +
            	"SELECT COUNT(*) cnt  FROM asan.admin WHERE id='" + id + "' AND isdel = '0'" +
        		" UNION ALL " +
        		" SELECT COUNT(*) cnt  FROM asan.admin WHERE id='" + id + "' AND isdel = '0'" +
        		" ) A";
        int count = mdao.getRowCount(query);

        if(count > 0){
            return result = -1 ;		//���� �ߺ�
        }

        //2.max select
        query = "SELECT COALESCE(MAX(idx),0) + 1  FROM asan.admin";
        String adminidx = String.valueOf(mdao.getRowCount(query));
        String isdel = "0";
        String status = "1";

       try {
           //3. �������
           Enumeration params = request.getParameterNames();
           HashMap bean = new HashMap();

           while (params.hasMoreElements()) {
               String name = (String)params.nextElement();
               String value = request.getParameter(name);

               if(value != null && !value.equals(""))
                   bean.put(name, value);
           }
            bean.put("status", status);
            bean.put("isdel", isdel);
			bean.put("reguser", reguser);
			bean.put("regip", regip);

           bean.remove("y");
           bean.remove("x");
           bean.remove("cmd");
           bean.remove("password2");
           bean.remove("menuidx");
           bean.remove("auth");
           bean.remove("auth_check");

           result = mdao.insertQuery("asan.admin", bean);

           //4.���� ���
           if(result > 0 ){
	          String[] menuidx = request.getParameterValues("menuidx");
	          String[] auth = request.getParameterValues("auth");

	          for(int i = 0;  i < menuidx.length; i++ ){
	              if(auth[i].equals("1")){
		              HashMap authbean = new HashMap();

		              authbean.put("adminidx", adminidx);
		              authbean.put("menuidx", menuidx[i]);
		              authbean.put("auth", auth[i]);
		              authbean.put("isdel",isdel);
		              authbean.put("reguser", reguser);
		              authbean.put("regip", regip);

		              result = mdao.insertQuery("asan.adminauth",authbean);
	              }
	          }
           }

       }catch (Exception e) {
           e.printStackTrace();
           System.out.println(e.getMessage());
       }
       return result;
   }


   /**
    * Admin view
    * @author : ikara
    * @2005.11.11
    */

   public void Read(HttpServletRequest request, HttpServletResponse response){
       System.out.println("***** Admin User Read*****");

       MultiDAO mdao = new MultiDAO();
       ArrayList beans = null;

       //      �ش� ���� id �Ǵ� �ڵ� ��ȣ
       String idx = request.getParameter("idx");
       if(idx == null) idx ="";

       try {
           beans = mdao.selectQuery("SELECT  id,name,email,password  FROM asan.admin WHERE  isdel = 0 AND idx = " + idx );
           HashMap hm = (HashMap)beans.get(0);
           request.setAttribute("read", hm);

       }catch(Exception e){
           e.printStackTrace();
           System.out.println(e.getMessage());
       }
   }


    /**
    * Admin ����
    * @author : ikara
    * @2005. 11.11
    */

	public int Update(HttpServletRequest request, HttpServletResponse response) {
			System.out.println("***** Admin User Update****");
			int result = 0;

			MultiDAO mdao = new MultiDAO();

	       String lastuser = "";
		   String lastip = "";
		   String isdel = "0";

	       HttpSession session = request.getSession();
	       String idx = request.getParameter("idx");

	       lastuser = (String)session.getAttribute("adminidx");
	       lastip = request.getRemoteHost();

	       try {
	           //1. �������� ������Ʈ
	           Enumeration params = request.getParameterNames();
	           HashMap bean = new HashMap();

	           while (params.hasMoreElements()) {
	               String name = (String)params.nextElement();
	               String value = request.getParameter(name);
	               if(value != null && !value.equals(""))
	                   bean.put(name, value);
	           }
				bean.put("lastuser", lastuser);
				bean.put("lastip", lastip);

	           bean.remove("y");
	           bean.remove("x");
	           bean.remove("idx");
	           bean.remove("cmd");
	           bean.remove("password2");
	           bean.remove("menuidx");
	           bean.remove("auth");
	           bean.remove("auth_check");

	           result = mdao.updateQuery("asan.admin", bean, " WHERE idx=" + idx);

	           if(result > 0){
		           //2.���� ����
	                mdao.deleteQuery("DELETE FROM  asan.adminauth where adminidx = " + idx);

	                //3.���� ���
		          String[] menuidx = request.getParameterValues("menuidx");
		          String[] auth = request.getParameterValues("auth");

		          System.out.println(menuidx.length);
		          for(int i = 0;  i < menuidx.length; i++ ){
		              System.out.println(auth[i]);

		              if(auth[i].equals("1")){
			              HashMap authbean = new HashMap();

			              authbean.put("adminidx", idx);
			              authbean.put("menuidx", menuidx[i]);
			              authbean.put("auth", auth[i]);
			              authbean.put("isdel",isdel);
			              authbean.put("lastuser", lastuser);
			              authbean.put("lastip", lastip);

			              result = mdao.insertQuery("asan.adminauth",authbean);
		              }
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
     * Admin ����
     * @author : ikara
     * @2005. 11.11
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Admin User Delete*****");

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

            result = mdao.updateQuery("UPDATE asan.admin SET isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp WHERE idx = " + idx);

            //���� ���̺� ���� ������Ʈ
            if(result > 0){
                mdao.updateQuery("UPDATE asan.adminauth SET isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp WHERE adminidx = " + idx);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }



    /**
     * Admin ���� check
     * @author : ikara
     * @2005. 11.11
     */
	//	adminidx, menuidx��
	public boolean AuthCheck(HttpServletRequest request, HttpServletResponse response, String menuidx){
		System.out.println("***** Admin Auth*****");
		int result = 0;
		MultiDAO mdao = new MultiDAO();

		try {
			HttpSession session = request.getSession();
			String admingrade = (String)session.getAttribute("admingrade");
			String adminidx = (String)session.getAttribute("adminidx");

			 if(admingrade.trim().equals("0")){
		            return true ;						//���۰�����
		     }

			if(adminidx.trim().equals("")) adminidx ="0";
			if(menuidx.trim().equals("")) menuidx = "0";

			String query = "SELECT COUNT(*) FROM asan.adminauth WHERE adminidx =" + adminidx + " AND menuidx=" + menuidx;
			result = mdao.getRowCount(query);
			if(result > 0){
			    return true;
			}
			else{
			    return false;
			}

		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

}	//end
