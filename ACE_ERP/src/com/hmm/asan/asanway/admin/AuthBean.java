/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005. 10. 18
* 요약설명 : AuthBean
**
* 수정시간	: 수정인 : 수정내용
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
* Admin 계정 관리
*/
public class AuthBean {

    /**
     * Admin 리스트
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
    * Admin 권한 리스트 - 리스트 value
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
   * Admin  메뉴 분류  리스트
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
  * Admin  메뉴  리스트 - 등록
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
 * Admin  메뉴  리스트 - 수정
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
    * Admin 등록
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

		 //1.중복체크 (회원 DB와 Admin DB모두 체크)
        String id = request.getParameter("id");
        String query = "SELECT SUM(cnt) count FROM ( " +
            	"SELECT COUNT(*) cnt  FROM asan.admin WHERE id='" + id + "' AND isdel = '0'" +
        		" UNION ALL " +
        		" SELECT COUNT(*) cnt  FROM asan.admin WHERE id='" + id + "' AND isdel = '0'" +
        		" ) A";
        int count = mdao.getRowCount(query);

        if(count > 0){
            return result = -1 ;		//계정 중복
        }

        //2.max select
        query = "SELECT COALESCE(MAX(idx),0) + 1  FROM asan.admin";
        String adminidx = String.valueOf(mdao.getRowCount(query));
        String isdel = "0";
        String status = "1";

       try {
           //3. 계정등록
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

           //4.권한 등록
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

       //      해당 글의 id 또는 코드 번호
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
    * Admin 수정
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
	           //1. 계정정보 업데이트
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
		           //2.권한 삭제
	                mdao.deleteQuery("DELETE FROM  asan.adminauth where adminidx = " + idx);

	                //3.권한 등록
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
     * Admin 삭제
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

            //권한 테이블 권한 업데이트
            if(result > 0){
                mdao.updateQuery("UPDATE asan.adminauth SET isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp WHERE adminidx = " + idx);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }



    /**
     * Admin 권한 check
     * @author : ikara
     * @2005. 11.11
     */
	//	adminidx, menuidx로
	public boolean AuthCheck(HttpServletRequest request, HttpServletResponse response, String menuidx){
		System.out.println("***** Admin Auth*****");
		int result = 0;
		MultiDAO mdao = new MultiDAO();

		try {
			HttpSession session = request.getSession();
			String admingrade = (String)session.getAttribute("admingrade");
			String adminidx = (String)session.getAttribute("adminidx");

			 if(admingrade.trim().equals("0")){
		            return true ;						//수퍼관리자
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
