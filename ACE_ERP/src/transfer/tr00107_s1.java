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
public class tr00107_s1 extends HttpServlet {
 
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
				String str7 = GauceReq.getParameter("gstr7");   
					if (str7==null || str7.trim().length()==0 ) {   str7=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CAR_SEQ_NO","TYPE","ORDER_NO","LINE_PART","CARTYPENO","LD_DATE","PERSON_NO_C","CAR_TYPE","REMARK","CTN_STDRD","EDT_DATE","LCT_URL","IN_OUT","CAR_NO","PERSON_NO","START_TIME","ACCESS_NO" ,"RTRN_DATE","RTRN_TIME","CHECK","PASS","CAR_CNT","CAR_TYPENM"}; 

				int[] intArrCN = new int[] {10,20,10,10,10,8,10,10,100,100,8,60,1,20,10,5,10,8,4,1,1,3,20}; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	A.CAR_SEQ_NO, \n")
						 .append( "					CASE WHEN  A.ORDER_NO ='' OR A.ORDER_NO IS NULL THEN '복짐' \n")
						 .append( "					ELSE '일반' END AS TYPE,A.ORDER_NO, \n")
						 .append( "					IFNULL(A.LINE_PART,'') AS LINE_PART,A.CARTYPENO, \n")
						 .append( "					A.LD_DATE,A.PERSON_NO PERSON_NO_C,A.CAR_TYPE,A.REMARK, \n")
						 .append( "					A.CTN_STDRD,A.EDT_DATE,A.LCT_URL,A.IN_OUT, \n")
						 .append( "					IFNULL(B.CAR_NO,'') AS CAR_NO ,IFNULL(B.PERSON_NO,'') AS PERSON_NO, \n")
						 .append( "					IFNULL(START_TIME,'') AS START_TIME,IFNULL(ACCESS_NO,'') AS ACCESS_NO, \n")
						 .append( "					IFNULL(RTRN_DATE,'') AS RTRN_DATE , IFNULL(RTRN_TIME,'') AS RTRN_TIME, \n")
						 .append( "					'' AS CHECK ,'' AS PASS, A.CAR_CNT, '' AS CAR_TYPENM \n")
						 .append( "		FROM TRANSFER.LTORDCAR A \n")
						 .append( "				 LEFT JOIN TRANSFER.LTCARACC B ON A.CAR_SEQ_NO = B.CAR_SEQ_NO \n");

					if(str7 !=null )	sql.append(	"  AND B.ACCSECTION = '" + str7 + "'") ;

					sql.append( " WHERE A.CAR_SEQ_NO IS NOT NULL ") ; 

					if(str1 !=null)		sql.append( " AND A.CAR_SEQ_NO = '" + str1 + "'") ; 
					if(str2 !=null )	sql.append( " AND B.RTRN_DATE >= '" + str2 + "'") ; 
					if(str4 !=null )	sql.append( " AND A.LINE_PART = '" + str4 + "'") ; 				 
					if(str5 !=null )	sql.append(" AND A.ORDER_NO LIKE '" + str5 + "%'") ; 	

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