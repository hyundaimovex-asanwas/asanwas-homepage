package common;
//package common; 이건 안쓰는구만..

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.hdasan.util.SecUtil; //보안유틸 by 현대아산 전산팀

public class hdasan_login extends HttpServlet {
			  

	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;
		String query = "";

		try {
			service = loader.newService();
			context = service.getContext();
			//logger = context.getLogger();
			
			GauceRequest GauceReq = service.getGauceRequest();
	    	      GauceResponse GauceRes = service.getGauceResponse();
			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();   
				
				String str1	= SecUtil.sqlFilter(req.getParameter("gstr1"));
				String str2	= SecUtil.sqlFilter(req.getParameter("gstr2"));
				String str3 = req.getRemoteAddr();
				
        String str4 = str1.substring(0,1);
				str1 = str1.replace('\'',' ');
				str1 = str1.replace('-',' ');
				
				GauceRes.enableFirstRow(dSet);

				dSet.addDataColumn(new GauceDataColumn("userid", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("password", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("username", GauceDataColumn.TB_STRING, 30));
				dSet.addDataColumn(new GauceDataColumn("autlevel", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("ipaddr", GauceDataColumn.TB_STRING, 15));
				dSet.addDataColumn(new GauceDataColumn("strsys", GauceDataColumn.TB_STRING, 3));
				dSet.addDataColumn(new GauceDataColumn("strdate", GauceDataColumn.TB_STRING, 8));
				dSet.addDataColumn(new GauceDataColumn("enddate", GauceDataColumn.TB_STRING, 8));
				dSet.addDataColumn(new GauceDataColumn("regman", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("regdate", GauceDataColumn.TB_STRING, 8));
 				dSet.addDataColumn(new GauceDataColumn("modman", GauceDataColumn.TB_STRING, 10));
 				dSet.addDataColumn(new GauceDataColumn("moddate", GauceDataColumn.TB_STRING, 8));
 				dSet.addDataColumn(new GauceDataColumn("pcipadr", GauceDataColumn.TB_STRING, 15));
				dSet.addDataColumn(new GauceDataColumn("curdate", GauceDataColumn.TB_STRING, 10));

				dSet.addDataColumn(new GauceDataColumn("DEPTCD", GauceDataColumn.TB_STRING, 4));
				dSet.addDataColumn(new GauceDataColumn("DEPTNM", GauceDataColumn.TB_STRING, 70));
 				dSet.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING, 2));
 				dSet.addDataColumn(new GauceDataColumn("FDNAME", GauceDataColumn.TB_STRING, 20));
 				dSet.addDataColumn(new GauceDataColumn("COCODE", GauceDataColumn.TB_STRING, 2));
				dSet.addDataColumn(new GauceDataColumn("CONAME", GauceDataColumn.TB_STRING, 20));
				dSet.addDataColumn(new GauceDataColumn("JOBDTY", GauceDataColumn.TB_STRING, 4));

		    if (!GauceReq.isBuilderRequest()) {		
					if(str4.equals("1")||str4.equals("2")){

						query = " SELECT A.USERID, 'yap0610' as PASSWORD, A.USERNAME, A.AUTLEVEL, A.IPADDR, A.STRSYS, A.STRDATE, "
									+ "        A.ENDDATE, A.REGMAN, A.REGDATE, A.MODMAN, A.MODDATE,'' AS PCIPADR, CURRENT DATE CURDATE,"
									+ "        B.DEPTCD, RTRIM(C.DEPTNM)DEPTNM, C.FDCODE, RTRIM(D.FDNAME)FDNAME, C.COCODE, RTRIM(E.CONAME)CONAME, B.JOBDTY"
									+ " FROM COMMON.USERFILE A  "
                  + "   LEFT JOIN PAYROLL.HIPERSON B ON A.USERID =  B.EMPNO"
									+ "   LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD"
									+ "   LEFT JOIN ACCOUNT.FIELDCODE D ON C.FDCODE = D.FDCODE"
									+ "   LEFT JOIN ACCOUNT.COMPANY E ON C.COCODE = E.COCODE"
									+ " WHERE A.USERID  = '" + str1 + "'"
									+ "   AND A.PASSWORD = '" + str2 + "'";
					}else{

						query = " SELECT A.USERID, 'yap0610' as PASSWORD, A.USERNAME, A.AUTLEVEL, A.IPADDR, A.STRSYS, A.STRDATE, "
									+ "        A.ENDDATE, A.REGMAN, A.REGDATE, A.MODMAN, A.MODDATE,'' AS PCIPADR, CURRENT DATE CURDATE,"
									+ "        B.DEPTCD, RTRIM(C.DEPTNM)DEPTNM, C.FDCODE, RTRIM(D.FDNAME)FDNAME, C.COCODE, RTRIM(E.CONAME)CONAME, B.JOBDTY"
									+ " FROM COMMON.USERFILE A  "
                  + "   LEFT JOIN PAYROLL.T_HIPERSON B ON A.USERID =  B.EMPNO"
									+ "   LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD"
									+ "   LEFT JOIN ACCOUNT.FIELDCODE D ON C.FDCODE = D.FDCODE"
									+ "   LEFT JOIN ACCOUNT.COMPANY E ON C.COCODE = E.COCODE"
									+ " WHERE A.USERID  = '" + str1 + "'"
									+ "   AND A.PASSWORD = '" + str2 + "'";

				  }

			    stmt = conn.getGauceStatement(query);
			 		stmt.executeQuery(dSet);
			   	}
  		  	} catch(Exception e) {
		    	//logger.err.println(this,e);
		  	} finally {
		  		if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  	dSet.flush();
		  	GauceRes.commit(query);
		  	GauceRes.close();
		} catch (Exception e) {
	   		//logger.err.println(this, e);
		} finally {
		    loader.restoreService(service);
  		}
	}
}