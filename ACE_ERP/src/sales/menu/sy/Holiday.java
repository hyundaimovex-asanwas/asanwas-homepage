/**
 *
 */
package sales.menu.sy;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDCookieManager;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

/**
 * @@author kimkr69
 *
 */
public class Holiday extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
        command(req, res);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
        command(req, res);
    }

    public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException {
        /*
         * Parameter : proType (업무 구분 파라미터)
         */
        String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
        System.out.println("#################################### " + this.getClass() + " Message ####################################\n");

        /*
         * DESC :  업무구분
         */
        if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {                // 초기화

        } else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {    // 조회
            select(req, res);
        } else  {        // 적용 (저장, 삭제, 수정)
            apply( req, res);
        }
    }

    /**
     * 기능 : 조회 method
     * @@param req
     * @@param res
     *
     */  public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
        /*****************************************************************************
         * Gauce Object 설정
         *****************************************************************************/
        System.out.println("# Command : 조회");

        res.setContentType("text/html;charset=ksc5601");

        ServiceLoader loader = new ServiceLoader(req, res);     // Service Loader
        GauceService service = null;
        GauceContext context = null;
        Logger log = null;                                         // Log

        GauceRequest gceReq = null;                             // Request
        GauceResponse gceRes = null;                             // Response

        /* DataBase */
        GauceDBConnection conn = null;                             // Database Connection
        GauceStatement stmt = null;

        String query = "";            // SELECT절  변수
        String whereQuery =  "";    // WHERE절  변수
        try {
            service = loader.newService();
            context = service.getContext();
            log = context.getLogger();

            gceReq = service.getGauceRequest();
            gceRes = service.getGauceResponse();

            // Database Connection
            conn = service.getDBConnection();

            /**********************************************************************************
             * Command
             **********************************************************************************
             * Parameter 설정
             * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다
             **********************************************************************************/

                    // 모든 사업장 얻어옴
                    query   += ""
                            + "\n\t" + "SELECT "
                            + "\n\t" + "    * "
                            + "\n\t" + "FROM "
                            + "\n\t" + "    SALES.TSY100 "
                            + "\n\t" + "WHERE 1=1 ";

                    query += whereQuery;

                     /**********************************************************************************
                     * DataSet 초기화
                     * DataSet에 추가될 DB의 필드를 초기화 시킨다
                     **********************************************************************************/
//                     쿼리 실행
                    stmt = conn.getGauceStatement(query);

                    stmt.executeQuery(query); // DataSet set

                    System.out.println("# Query : " + query);

                    stmt.close();
             gceRes.commit();
             gceRes.close();


        }catch (Exception e) {
            e.printStackTrace();
            // Error Log 처리 요망 (log4j 사용여부)
        } finally {
            if (conn != null) {
                try {
                    stmt.close();
                    conn.close(true);
                } catch (Exception e) {
                    e.printStackTrace();
                    loader.restoreService(service);
                }
            }
        }
    }

    /**
     * 기능 : 입력, 수정, 삭제
     * @@param req
     * @@param res
     *
     */
    public void apply(HttpServletRequest req, HttpServletResponse res) {

        ServiceLoader loader = new ServiceLoader(req, res);     // Service Loader
        GauceService service = null;
        GauceContext context = null;
        Logger log = null;                 // Log

        GauceRequest gceReq = null;     // Request
        GauceResponse gceRes = null;     // Response

        /* DataBase */
        GauceDBConnection conn = null;     // Database Connection
        GauceStatement stmt = null;

        String insertQuery = "";
        String updateQuery = "";
        String deleteQuery = "";

        try {
            service = loader.newService();
            context = service.getContext();
            log = context.getLogger();


            /*
             * Request Parameter
             */
            String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
            String caln_date = HDUtil.nullCheckStr(req.getParameter("caln_date"));
            String yoil_cd = HDUtil.nullCheckStr(req.getParameter("yoil_cd"));
            String yoil_nm = "";
            String holiday_nm = HDUtil.nullCheckStr(StringUtil.encoding(req.getParameter("holiday_nm")));
            /**
             * @@Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
             **/
			HDCookieManager hdCookie = new HDCookieManager(req, res);
			String vusrid = hdCookie.getCookieValue("vusrid",req); // empno
			
			String fParamEmpno = "";
			String fParamIp = "";
			if (vusrid != null || !vusrid.equals("") ||  vusrid.length() > 0) {
				fParamEmpno = vusrid;
			} else {
				fParamEmpno = "tester";
			}

			 fParamIp = req.getRemoteAddr();
			
			 String iParamEmpno = fParamEmpno;
			 String iParamIp = fParamIp;
/*
            insertQuery += "\n"
                        + "\n\t" + "INSERT INTO SALES.TSY010 "
                        + "\n\t" + "    ("
                        + "\n\t" + "        caln_date, "
                        + "\n\t" + "        yoil_cd, "
                        + "\n\t" + "        yoil_nm, "
                        + "\n\t" + "        holiday_nm,  "
                        + "\n\t" + "        u_empno , "
                        + "\n\t" + "        u_date , "
                        + "\n\t" + "        u_ip "
                        + "\n\t" + "    )"
                        + "\n\t" + "VALUES ("
                        + "\n\t" + "            ?, ?, ?, ?, ?, CURRENT TIMESTAMP, ? "
                        + "\n\t" + "       )"
                        + "\n";

            updateQuery += "\n"
                        + "\n\t" + "UPDATE SALES.TSY100"
                        + "\n\t" + "    SET"
                        + "\n\t" + "        yoil_cd = ?,"
                        + "\n\t" + "        yoil_nm = ?,"
                        + "\n\t" + "        holiday_nm = ?,"
                        + "\n\t" + "        u_empno = ?,"
                        + "\n\t" + "        u_date = CURRENT TIMESTAMP,"
                        + "\n\t" + "        u_ip = ? "
                        + "\n\t" + "WHERE 1=1 "
                        + "\n\t" + "    AND caln_date=?";


            deleteQuery += "\n"
                        + "\n\t" + "DELETE FROM SALES.TSY100 "
                        + "\n\t" + "WHERE 1=1 "
                        + "\n\t" + "    AND caln_date=?";

*/
            insertQuery += "\n"
                + "\n\t" + "INSERT INTO SALES.TSY010 "
                + "\n\t" + "    ("
                + "\n\t" + "        head, "
                + "\n\t" + "        detail, "
                + "\n\t" + "        detail_nm,  "
                + "\n\t" + "        u_empno , "
                + "\n\t" + "        u_date , "
                + "\n\t" + "        u_ip "
                + "\n\t" + "    )"
                + "\n\t" + "VALUES ("
                + "\n\t" + "            'SY004', ?, ?, ?, CURRENT TIMESTAMP, ? "
                + "\n\t" + "       )"
                + "\n";

    updateQuery += "\n"
                + "\n\t" + "UPDATE SALES.TSY010"
                + "\n\t" + "    SET"
                + "\n\t" + "        detail_nm = ?,"
                + "\n\t" + "        u_empno = ?,"
                + "\n\t" + "        u_date = CURRENT TIMESTAMP,"
                + "\n\t" + "        u_ip = ? "
                + "\n\t" + "WHERE head = 'SY004'  "
                + "\n\t" + "    AND detail = ? ";


    deleteQuery += "\n"
                + "\n\t" + "DELETE FROM SALES.TSY010 "
                + "\n\t" + "WHERE head = 'SY004' "
                + "\n\t" + "    AND detail = ? ";
            // Database Connection
            conn = service.getDBConnection();

                // 입력
                if (proType.equals(HDConstant.PROCESS_TYPE_INSERET)) {
                    System.out.println("# Command : 저장");
                    System.out.println("# Query : " + insertQuery);
                    switch(Integer.parseInt(yoil_cd)){
                    case 1 :
                        yoil_nm = "일";
                    case 2 :
                        yoil_nm = "월";
                    case 3 :
                        yoil_nm = "화";
                    case 4 :
                        yoil_nm = "수";
                    case 5 :
                        yoil_nm = "목";
                    case 6 :
                        yoil_nm = "금";
                    case 0 :
                        yoil_nm = "토";
              }

                    stmt = conn.getGauceStatement(insertQuery);


                    stmt.setString(1, caln_date);          // 휴일날짜
                    stmt.setString(2, holiday_nm);        // 휴일명
                    // **** 쿠키 ***** //
                    stmt.setString(3, iParamEmpno);    // 수정자 사번
                    stmt.setString(4, iParamIp);            // 수정자 ip

                    stmt.execute();
                    stmt.close();
                    System.out.println("# Command : 휴일명 ==> " + holiday_nm);
                }
                // 수정
                if (proType.equals(HDConstant.PROCESS_TYPE_MODIFY)) {
                    System.out.println("# Command : 수정");
                    System.out.println("# Query : " + updateQuery);


                    stmt = conn.getGauceStatement(updateQuery);

                    stmt.setString(1, holiday_nm);  // 휴일명
                    stmt.setString(2, iParamEmpno);        // 수정자 사번
                    stmt.setString(3, iParamIp);            // 수정자 ip
                    stmt.setString(4, caln_date);        // 휴일날짜

                    stmt.execute();
                    stmt.close();
                }

                // 삭제
                if (proType.equals(HDConstant.PROCESS_TYPE_DELETE)) {
                    System.out.println("# Command : 삭제");
                    System.out.println("# Query : " + deleteQuery);


                    stmt = conn.getGauceStatement(deleteQuery);

                    stmt.setString(1, caln_date);        // 휴일날짜

                    stmt.execute();

                    stmt.close();
                }
        } catch (Exception e) {
            //gceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close(true);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            loader.restoreService(service);
        }

        System.out.println("\n\n");
    }
}