package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsCarInfo extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

				boolean isNotOnlyHeader = false;

				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				 
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
			  String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }
			  String str5 = GauceReq.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }
			  String str6 = GauceReq.getParameter("gstr6");   
					if (str6==null || str6.trim().length()==0 ) {   str6=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CAR_NO","PERSON_NO","PSN_KNAME","REG_NO","CARTYPENO", "TEL_NO" }; 

				int[] intArrCN = new int[] {16,10,30,13,10,16 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.CAR_NO, B.PERSON_NO, B.PSN_KNAME, \n")
						 .append( "				 IFNULL(B.REG_NO,'') AS REG_NO ,IFNULL(A.CARTYPENO,'') AS  CARTYPENO, IFNULL(B.TEL_NO,'') AS TEL_NO  \n")
						 .append( "		FROM TRANSFER.LTCARINFO A \n")
						 .append( "				 LEFT JOIN TRANSFER.LTPERSON B ON A.PERSON_NO = B.PERSON_NO \n")
						 .append( "	 WHERE A.CAR_NO <> '' \n")
						 .append( "    AND CAR_NO NOT IN (SELECT CAR_NO \n")
						 .append( "													FROM TRANSFER.LTACCPLCAR \n")
						 .append( "												 WHERE ACCSECTION = 'I' \n")
						 .append( "													 AND RTRN_DATE >= '" + str6 + "') ");

					if(str1 !=null) sql.append(" AND A.CAR_NO LIKE  '%" + str1 + "%' \n");
					if(str2 !=null) sql.append(" AND B.REG_NO = '" + str2 + "' \n");
					if(str3 !=null) sql.append(" AND B.PSN_KNAME LIKE '%" + str3 + "%' \n");
					if(str4 !=null) sql.append(" AND B.PERSON_NO LIKE '%" + str4 + "%' \n");
					if(str5 !=null) sql.append(" AND A.CARTYPENO = '" + str5 + "' \n");

					stmt = conn.getGauceStatement(sql.toString());
	 				stmt.executeQuery(dSet);
				}

/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
				//GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}