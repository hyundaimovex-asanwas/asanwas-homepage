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
         * Parameter : proType (���� ���� �Ķ����)
         */
        String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
        System.out.println("#################################### " + this.getClass() + " Message ####################################\n");

        /*
         * DESC :  ��������
         */
        if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {                // �ʱ�ȭ

        } else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {    // ��ȸ
            select(req, res);
        } else  {        // ���� (����, ����, ����)
            apply( req, res);
        }
    }

    /**
     * ��� : ��ȸ method
     * @@param req
     * @@param res
     *
     */  public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
        /*****************************************************************************
         * Gauce Object ����
         *****************************************************************************/
        System.out.println("# Command : ��ȸ");

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

        String query = "";            // SELECT��  ����
        String whereQuery =  "";    // WHERE��  ����
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
             * Parameter ����
             * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�
             **********************************************************************************/

                    // ��� ����� ����
                    query   += ""
                            + "\n\t" + "SELECT "
                            + "\n\t" + "    * "
                            + "\n\t" + "FROM "
                            + "\n\t" + "    SALES.TSY100 "
                            + "\n\t" + "WHERE 1=1 ";

                    query += whereQuery;

                     /**********************************************************************************
                     * DataSet �ʱ�ȭ
                     * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��
                     **********************************************************************************/
//                     ���� ����
                    stmt = conn.getGauceStatement(query);

                    stmt.executeQuery(query); // DataSet set

                    System.out.println("# Query : " + query);

                    stmt.close();
             gceRes.commit();
             gceRes.close();


        }catch (Exception e) {
            e.printStackTrace();
            // Error Log ó�� ��� (log4j ��뿩��)
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
     * ��� : �Է�, ����, ����
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
             * @@Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ�
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

                // �Է�
                if (proType.equals(HDConstant.PROCESS_TYPE_INSERET)) {
                    System.out.println("# Command : ����");
                    System.out.println("# Query : " + insertQuery);
                    switch(Integer.parseInt(yoil_cd)){
                    case 1 :
                        yoil_nm = "��";
                    case 2 :
                        yoil_nm = "��";
                    case 3 :
                        yoil_nm = "ȭ";
                    case 4 :
                        yoil_nm = "��";
                    case 5 :
                        yoil_nm = "��";
                    case 6 :
                        yoil_nm = "��";
                    case 0 :
                        yoil_nm = "��";
              }

                    stmt = conn.getGauceStatement(insertQuery);


                    stmt.setString(1, caln_date);          // ���ϳ�¥
                    stmt.setString(2, holiday_nm);        // ���ϸ�
                    // **** ��Ű ***** //
                    stmt.setString(3, iParamEmpno);    // ������ ���
                    stmt.setString(4, iParamIp);            // ������ ip

                    stmt.execute();
                    stmt.close();
                    System.out.println("# Command : ���ϸ� ==> " + holiday_nm);
                }
                // ����
                if (proType.equals(HDConstant.PROCESS_TYPE_MODIFY)) {
                    System.out.println("# Command : ����");
                    System.out.println("# Query : " + updateQuery);


                    stmt = conn.getGauceStatement(updateQuery);

                    stmt.setString(1, holiday_nm);  // ���ϸ�
                    stmt.setString(2, iParamEmpno);        // ������ ���
                    stmt.setString(3, iParamIp);            // ������ ip
                    stmt.setString(4, caln_date);        // ���ϳ�¥

                    stmt.execute();
                    stmt.close();
                }

                // ����
                if (proType.equals(HDConstant.PROCESS_TYPE_DELETE)) {
                    System.out.println("# Command : ����");
                    System.out.println("# Query : " + deleteQuery);


                    stmt = conn.getGauceStatement(deleteQuery);

                    stmt.setString(1, caln_date);        // ���ϳ�¥

                    stmt.execute();

                    stmt.close();
                }
        } catch (Exception e) {
            //gceRes.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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