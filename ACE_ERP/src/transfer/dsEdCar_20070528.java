package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class dsEdCar_20070528 extends HttpServlet {
 
	// ���������� ���� ���۹���� Post Ÿ���� ���
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

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				
				boolean isNotOnlyHeader = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }


				String str0 = GauceReq.getParameter("gstr0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; }
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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CAR_SEQ_NO", "CARTYPENO","ORDER_NO","CAR_NAME","CARGO_TYPE","CAR_CBM","CAR_TON","CTN_STDRD","IN_OUT","DIV_IO","EDT_DATE"}; 

				int[] intArrCN = new int[] { 10, 10,10,50,10,13,13,50,1,1,8}; 
			
				int[] intArrCN2 = new int[]{-1, -1,-1,-1,-1,2,2,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT A.CAR_SEQ_NO , A.CARTYPENO,IFNULL(A.ORDER_NO,'') AS ORDER_NO,CAR_NAME, \n")
						 .append("				CASE WHEN A.ORDER_NO IS NULL OR RTRIM(A.ORDER_NO) = '' THEN '����'  \n")
						 .append("						 WHEN M.CARGO_TYPE = '0001' THEN '�Ϲ�'  \n")
						 .append("						 WHEN M.CARGO_TYPE = '0003' THEN 'Ź��'  \n")
						 .append("						 WHEN M.CARGO_TYPE = '0004' THEN '�Ǽ����'  \n")
						 .append("				ELSE '�Ϲ�' END AS CARGO_TYPE, \n")
						 .append("				CAR_CBM,CAR_TON,CTN_STDRD,IFNULL(A.IN_OUT,'') AS IN_OUT ,IFNULL(M.DIV_IO,'') AS DIV_IO , \n")
						 .append("				IFNULL(A.EDT_DATE ,'') AS EDT_DATE \n")
						 .append("	 FROM TRANSFER.LTORDCAR A \n")
						 .append("				LEFT JOIN TRANSFER.LTORDERMST M ON M.ORDER_NO = A.ORDER_NO, \n")
						 .append("				TRANSFER.LTCARTYPE B, \n")
						 .append("				TRANSFER.LTUSER C \n")
						 .append("  WHERE A.CARTYPENO = B.CAR_TYPE \n")
						 .append("    AND A.CREATE_USR = C.USERID \n")
						 .append("    AND A.IN_OUT = '" + str0 + "' ");

					if(str3 != null ) sql.append(" AND  CAR_SEQ_NO  = '" + str3 + "'" );
					if(str2 != null ) sql.append(" AND  A.ORDER_NO  = '" + str2 + "'" );
					if(str1 != null ) sql.append(" AND  A.EDT_DATE  = '" + str1 + "'" );
					if(str4 != null ) sql.append(" AND  A.LINE_PART = '" + str4 + "'" );
					if(str5 != null ) sql.append(" AND  C.USERNM LIKE '" + str5 + "%'" );

					logger.dbg.println(this,sql.toString());

					stmt = conn.getGauceStatement(sql.toString());
	 				stmt.executeQuery(dSet);
				}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
			GauceRes.writeException("Sql",":",e.toString());
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