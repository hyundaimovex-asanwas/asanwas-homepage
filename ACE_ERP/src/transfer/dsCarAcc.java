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
public class dsCarAcc extends HttpServlet {
 
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

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				
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

				String[] strArrCN = new String[]{	"CAR_SEQ_NO","ACCSECTION","CAR_NO","CAR_TYPE","PERSON_NO",
																					"LD_CARGO","LD_CARGONM","OFF_CARGO","OFF_CARGONM","PURPOSE",
																					"LEAD_FEE","PERSON_CNT","START_DATE","START_TIME","RTRN_DATE",
																					"RTRN_TIME","BAECHA_NO","ACCESS_NO","RDS_GOODS","REMARK",
																					"CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_UST"}; 

				int[] intArrCN = new int[] {	10,  1, 12,  10,  10,
																			10, 50, 10,  50, 100,
																			 1, 13,  8,   4,   8,
																			 4, 10, 10, 100, 256,
																			 8, 10,  8,  10
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	CAR_SEQ_NO,ACCSECTION,CAR_NO,CAR_TYPE,PERSON_NO, \n")
						 .append( "					LD_CARGO,LD_CARGONM,OFF_CARGO,OFF_CARGONM,PURPOSE, \n")
						 .append( "					LEAD_FEE,PERSON_CNT,START_DATE,START_TIME,RTRN_DATE, \n")
						 .append( "					RTRN_TIME,BAECHA_NO,ACCESS_NO,RDS_GOODS,REMARK, \n")
						 .append( "					CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_UST \n")
						 .append( "		FROM TRANSFER.LTCARACC \n")
						 .append( "  WHERE CAR_SEQ_NO IS NOT NULL " );

					if(str1 != null ) {		sql.append( "AND CAR_SEQ_NO = '" +str1 + "'" ) ;} 
					if(str2 != null ) {		sql.append( "AND ACCSECTION = '" +str2 + "'" ) ;}   
					if(str3 != null ) {		sql.append( "AND CAR_NO = '" +str3 + "'" ) ;}   
					if(str4 != null && str5 != null) {		sql.append( "AND (START_DATE concat START_TIME BETWEEN '" + str4 + "' AND '"+str5 + "'" );  		sql.append( " OR RTRN_DATE concat  RTRN_TIME BETWEEN '" + str4 + "' AND '"+str5 + "')" ) ;} 

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