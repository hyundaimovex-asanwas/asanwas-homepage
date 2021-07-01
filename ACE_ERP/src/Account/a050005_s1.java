package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a050005_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String  str1 = req.getParameter("v_str1");	//지점
				String  str2 = req.getParameter("v_str2");	//년도
				String  str3 = req.getParameter("v_str3");	//기수기간from
				String  str4 = req.getParameter("v_str4");	//기수기간from

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DISKET" }; 

				int[] intArrCN  = new int[]{ 170 }; 
			
				int[] intArrCN2 = new int[]{ -1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT X.TEXT1||X.TEXT2 AS DISKET																						\n");
					sql.append( " FROM (SELECT DATADIV||VEND_ID||VEND_NM||VD_DIRECT||ADDRS||									\n");
					sql.append( " 			BSNS_CND||BSNS_KND||TAXTERM||WRDT||FILLER AS TEXT1,'' AS TEXT2				\n");
					sql.append( " FROM ACCOUNT.AVATRPT7																												\n");
					sql.append( " WHERE FDCODE IS NOT NULL																													\n");
					if(!str1.equals(""))  sql.append( " AND FDCODE = '"+str1+"'																\n");
					if(!str2.equals(""))  sql.append( " AND ACCYY	 = '"+str2+"'																\n");
					if(!str3.equals(""))  sql.append( " AND ACCYYQT = '"+str3+"'															\n");
					sql.append( " ) X																																					\n");
					sql.append( " UNION ALL																																		\n");
					sql.append( " SELECT X.TEXT1||X.TEXT2 AS DISKET																						\n");
					sql.append( " FROM (SELECT DATADIV||VENDID||FILLER AS TEXT1,															\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(VENDCNT))='6'   THEN '000000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='5'   THEN '00000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='4'   THEN '0000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='3'   THEN '000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='2'   THEN '00'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='1'   THEN '0'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='0'   THEN '' ELSE '000000' END ||nvl(VENDCNT,0)||	\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(SHTCNT))='6'   THEN '000000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='5'   THEN '00000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='4'   THEN '0000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='3'   THEN '000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='2'   THEN '00'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='1'   THEN '0'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='0'   THEN '' ELSE '000000' END ||nvl(SHTCNT,0)||	\n");
					sql.append( " CASE WHEN 15-LENGTH(VARCHAR(REQAMT))='14' THEN '00000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='12' THEN '000000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='10' THEN '0000000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='8'  THEN '00000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='6'  THEN '000000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='4'  THEN '0000'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='3'  THEN '000'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='2'  THEN '00'													\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='1'  THEN '0'													\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='0'  THEN '' ELSE '00000000000000' END ||nvl(REQAMT,0)||	\n");
					sql.append( " CASE WHEN 14-LENGTH(VARCHAR(VATAMT))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='12' THEN '000000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='10' THEN '0000000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='8'  THEN '00000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='6'  THEN '000000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='4'  THEN '0000'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='3'  THEN '000'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='2'  THEN '00'													\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='1'  THEN '0'													\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='0'  THEN '' ELSE '0000000000000' END ||nvl(VATAMT,0)||	\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(VENDCNT1))='6'   THEN '000000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT1))='5'   THEN '00000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT1))='4'   THEN '0000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT1))='3'   THEN '000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT1))='2'   THEN '00'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT1))='1'   THEN '0'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT1))='0'   THEN '' ELSE '000000' END ||nvl(VENDCNT1,0)||	\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(SHTCNT1))='6'   THEN '000000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT1))='5'   THEN '00000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT1))='4'   THEN '0000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT1))='3'   THEN '000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT1))='2'   THEN '00'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT1))='1'   THEN '0'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT1))='0'   THEN '' ELSE '000000' END ||nvl(SHTCNT1,0)||	\n");
					sql.append( " CASE WHEN 15-LENGTH(VARCHAR(REQAMT1))='14' THEN '00000000000000'						\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='12' THEN '000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='10' THEN '0000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='8'  THEN '00000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='6'  THEN '000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='4'  THEN '0000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='3'  THEN '000'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='2'  THEN '00'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='1'  THEN '0'													\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT1))='0'  THEN '' ELSE '00000000000000' END ||nvl(REQAMT1,0)||	\n");
					sql.append( " CASE WHEN 14-LENGTH(VARCHAR(VATAMT1))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='12' THEN '000000000000'							\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='10' THEN '0000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='8'  THEN '00000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='6'  THEN '000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='4'  THEN '0000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='3'  THEN '000'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='2'  THEN '00'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='1'  THEN '0'													\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT1))='0'  THEN '' ELSE '0000000000000' END ||nvl(VATAMT1,0)||	\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(VENDCNT2))='6'   THEN '000000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT2))='5'   THEN '00000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT2))='4'   THEN '0000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT2))='3'   THEN '000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT2))='2'   THEN '00'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT2))='1'   THEN '0'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT2))='0'   THEN '' ELSE '000000' END ||nvl(VENDCNT2,0)||	\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(SHTCNT2))='6'   THEN '000000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT2))='5'   THEN '00000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT2))='4'   THEN '0000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT2))='3'   THEN '000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT2))='2'   THEN '00'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT2))='1'   THEN '0'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT2))='0'   THEN '' ELSE '000000' END ||nvl(SHTCNT2,0)||	\n");
					sql.append( " CASE WHEN 15-LENGTH(VARCHAR(REQAMT2))='14' THEN '00000000000000'						\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='12' THEN '000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='10' THEN '0000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='8'  THEN '00000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='6'  THEN '000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='4'  THEN '0000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='3'  THEN '000'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='2'  THEN '00'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='1'  THEN '0'													\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT2))='0'  THEN '' ELSE '00000000000000' END ||nvl(REQAMT2,0)||	\n");
					sql.append( " CASE WHEN 14-LENGTH(VARCHAR(VATAMT2))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='12' THEN '000000000000'							\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='10' THEN '0000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='8'  THEN '00000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='6'  THEN '000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='4'  THEN '0000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='3'  THEN '000'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='2'  THEN '00'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='1'  THEN '0'													\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT2))='0'  THEN '' ELSE '0000000000000' END ||nvl(VATAMT2,0) AS TEXT2	\n");
					sql.append( " FROM ACCOUNT.AVATRPT3																												\n");
					sql.append( " WHERE FDCODE IS NOT NULL																													\n");
					if(!str1.equals(""))  sql.append( " AND FDCODE = '"+str1+"'																\n");
					if(!str2.equals(""))  sql.append( " AND ACCYY  = '"+str2+"'																\n");
					if(!str3.equals(""))  sql.append( " AND ACCYYQT = '"+str3+"'															\n");
					sql.append( " ) X																																					\n");
					sql.append( " UNION ALL																																		\n");
					sql.append( " SELECT X.TEXT1||X.TEXT2 AS DISKET																						\n");
					sql.append( " FROM (SELECT DATADIV||VENDID||VENDSEQ||VENDIDVS||VENDNAME||BSNSCND||				\n");
					sql.append( " 			BSNSKND||WINEGM||WINESM||BOOKNUM||TAXATION||FILLER AS TEXT1,					\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(SHTCNT))='6'   THEN '000000'											\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='5'   THEN '00000'											\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='4'   THEN '0000'												\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='3'   THEN '000'												\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='2'   THEN '00'													\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='1'   THEN '0'													\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='0'   THEN '' ELSE '000000' END ||nvl(SHTCNT,0)||	\n");
					sql.append( " CASE WHEN 2-LENGTH(VARCHAR(BLKCNT))='1'   THEN '0'													\n");
					sql.append( " 		 WHEN 2-LENGTH(VARCHAR(BLKCNT))='0'   THEN '' END ||BLKCNT||						\n");
					sql.append( " CASE WHEN 14-LENGTH(VARCHAR(REQAMT))='13' THEN '0000000000000'							\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='12' THEN '000000000000'								\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='11' THEN '00000000000'								\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='10' THEN '0000000000'									\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='9'  THEN '000000000'									\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='8'  THEN '00000000'										\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='7'  THEN '0000000'										\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='6'  THEN '000000'											\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='5'  THEN '00000'											\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='4'  THEN '0000'												\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='3'  THEN '000'												\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='2'  THEN '00'													\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='1'  THEN '0'													\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='0'  THEN '' ELSE '0000000000000' END ||nvl(REQAMT,0)||	\n");
					sql.append( " CASE WHEN 13-LENGTH(VARCHAR(VATAMT))='12' THEN '000000000000'								\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='11' THEN '00000000000'								\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='10' THEN '0000000000'									\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='9'  THEN '000000000'									\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='8'  THEN '00000000'										\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='7'  THEN '0000000'										\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='6'  THEN '000000'											\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='5'  THEN '00000'											\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='4'  THEN '0000'												\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='3'  THEN '000'												\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='2'  THEN '00'													\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='1'  THEN '0'													\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='0'  THEN '' ELSE '000000000000' END ||nvl(VATAMT,0) AS TEXT2	\n");
					sql.append( " FROM ACCOUNT.AVATRPT1																												\n");
					sql.append( " WHERE FDCODE IS NOT NULL																													\n");
					if(!str1.equals(""))  sql.append( " AND FDCODE  = '"+str1+"'															\n");
					if(!str2.equals(""))  sql.append( " AND ACCYY   = '"+str2+"'															\n");
					if(!str3.equals(""))  sql.append( " AND ACCYYQT = '"+str3+"'															\n");
					sql.append( " ) X																																					\n");
					sql.append( " UNION ALL																																		\n");
					sql.append( " SELECT X.TEXT1||X.TEXT2 AS DISKET																						\n");
					sql.append( " FROM (SELECT DATADIV||VENDID||FILLER AS TEXT1,															\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(VENDCNT))='6'   THEN '000000'										\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='5'   THEN '00000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='4'   THEN '0000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='3'   THEN '000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='2'   THEN '00'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='1'   THEN '0'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(VENDCNT))='0'   THEN '' ELSE '000000' END ||nvl(VENDCNT,0)||	\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(SHTCNT))='6'   THEN '000000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='5'   THEN '00000'											\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='4'   THEN '0000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='3'   THEN '000'												\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='2'   THEN '00'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='1'   THEN '0'													\n");
					sql.append( "      WHEN 7-LENGTH(VARCHAR(SHTCNT))='0'   THEN '' ELSE '000000' END ||nvl(SHTCNT,0)||	\n");
					sql.append( " CASE WHEN 15-LENGTH(VARCHAR(REQAMT))='14' THEN '00000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='12' THEN '000000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='10' THEN '0000000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='8'  THEN '00000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='6'  THEN '000000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='4'  THEN '0000'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='3'  THEN '000'												\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='2'  THEN '00'													\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='1'  THEN '0'													\n");
					sql.append( "      WHEN 15-LENGTH(VARCHAR(REQAMT))='0'  THEN '' ELSE '00000000000000' END ||nvl(REQAMT,0)||	\n");
					sql.append( " CASE WHEN 14-LENGTH(VARCHAR(VATAMT))='13' THEN '0000000000000'							\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='12' THEN '000000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='11' THEN '00000000000'								\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='10' THEN '0000000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='9'  THEN '000000000'									\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='8'  THEN '00000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='7'  THEN '0000000'										\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='6'  THEN '000000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='5'  THEN '00000'											\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='4'  THEN '0000'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='3'  THEN '000'												\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='2'  THEN '00'													\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='1'  THEN '0'													\n");
					sql.append( "      WHEN 14-LENGTH(VARCHAR(VATAMT))='0'  THEN '' ELSE '0000000000000' END ||nvl(VATAMT,0) AS TEXT2	\n");
					sql.append( " FROM ACCOUNT.AVATRPT4																												\n");
					sql.append( " WHERE FDCODE IS NOT NULL																													\n");
					if(!str1.equals(""))  sql.append( " AND FDCODE = '"+str1+"'																\n");
					if(!str2.equals(""))  sql.append( " AND ACCYY	 = '"+str2+"'																\n");
					if(!str3.equals(""))  sql.append( " AND ACCYYQT = '"+str3+"'															\n");
					sql.append( " ) X																																					\n");
					sql.append( " UNION ALL																																		\n");	
					sql.append( " SELECT X.TEXT1||X.TEXT2 AS DISKET																						\n");
					sql.append( " FROM (SELECT DATADIV||VENDID||VENDSEQ||VENDIDVS||VENDNAME||BSNSCND||				\n");
					sql.append( " 			BSNSKND||WINEGM||WINESM||BOOKNUM||TAXATION||FILLER AS TEXT1,					\n");
					sql.append( " CASE WHEN 7-LENGTH(VARCHAR(SHTCNT))='6'   THEN '000000'											\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='5'   THEN '00000'											\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='4'   THEN '0000'												\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='3'   THEN '000'												\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='2'   THEN '00'													\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='1'   THEN '0'													\n");
					sql.append( " 		 WHEN 7-LENGTH(VARCHAR(SHTCNT))='0'   THEN '' ELSE '000000' END ||nvl(SHTCNT,0)||	\n");
					sql.append( " CASE WHEN 2-LENGTH(VARCHAR(BLKCNT))='1'   THEN '0'													\n");
					sql.append( " 		 WHEN 2-LENGTH(VARCHAR(BLKCNT))='0'   THEN '' END ||BLKCNT||						\n");
					sql.append( " CASE WHEN 14-LENGTH(VARCHAR(REQAMT))='13' THEN '0000000000000'							\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='12' THEN '000000000000'								\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='11' THEN '00000000000'								\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='10' THEN '0000000000'									\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='9'  THEN '000000000'									\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='8'  THEN '00000000'										\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='7'  THEN '0000000'										\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='6'  THEN '000000'											\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='5'  THEN '00000'											\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='4'  THEN '0000'												\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='3'  THEN '000'												\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='2'  THEN '00'													\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='1'  THEN '0'													\n");
					sql.append( " 		 WHEN 14-LENGTH(VARCHAR(REQAMT))='0'  THEN '' ELSE '0000000000000' END ||nvl(REQAMT,0)||	\n");
					sql.append( " CASE WHEN 13-LENGTH(VARCHAR(VATAMT))='12' THEN '000000000000'								\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='11' THEN '00000000000'								\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='10' THEN '0000000000'									\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='9'  THEN '000000000'									\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='8'  THEN '00000000'										\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='7'  THEN '0000000'										\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='6'  THEN '000000'											\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='5'  THEN '00000'											\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='4'  THEN '0000'												\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='3'  THEN '000'												\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='2'  THEN '00'													\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='1'  THEN '0'													\n");
					sql.append( " 		 WHEN 13-LENGTH(VARCHAR(VATAMT))='0'  THEN '' ELSE '000000000000' END ||nvl(VATAMT,0) AS TEXT2	\n");
					sql.append( " FROM ACCOUNT.AVATRPT2																												\n");
					sql.append( " WHERE FDCODE IS NOT NULL																													\n");
					if(!str1.equals(""))  sql.append( " AND FDCODE = '"+str1+"'																\n");
					if(!str2.equals(""))  sql.append( " AND ACCYY  = '"+str2+"'																\n");
					if(!str3.equals(""))  sql.append( " AND ACCYYQT = '"+str3+"'															\n");
					sql.append( " ) X																																					\n");

					//logger.dbg.println(this, sql.toString());

/*********************************************************************************************/
System.out.println("^^^^"+sql);
		      stmt = conn.getGauceStatement(sql.toString());
	 				stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
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