package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h010004_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");



				String  str4	= req.getParameter("v_str4");	//사용유무 checked
				String  str5	= req.getParameter("v_str5");	//레벨 1,2,3,4
				String  str6	= req.getParameter("v_str6");	//level 2 value
				String  str7	= req.getParameter("v_str7");	//level 3 value
				String  str9  = req.getParameter("v_str9"); //조직도 99999999
				String  str10  = req.getParameter("v_str10"); //조직구분
				String  str11  = req.getParameter("v_str11"); //조직구분
				String  str12  = req.getParameter("v_str12"); //level 4 value




				if (str1 == null){ str1 = "";}
				if (str2 == null){ str2 = "";}
				if (str3 == null){ str3 = "";}


				if (str4 == null){ str4 = "";}
				if (str5 == null){ str5 = "";}
				if (str6 == null){ str6 = "";}
				if (str7 == null){ str7 = "";}
				if (str9 == null){ str9 = "";}
				if (str10 == null){ str10 = "";}
				if (str11 == null){ str11 = "";}
				if (str12 == null){ str12 = "";}
					
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD", "DEPTNMK", "DEPTNM", "TREECD",
																				  "FRDT", "TODT", "DEPTPRT", "DEPTGB",
																				  "GROUPID", "USEYN", "REDTAXYN", "CHGYM",
																				  "DEPTCD_M", "LEVEL",  "GROUPID"}; //15

				int[] intArrCN = new int[] {  4, 70, 50,  8,  
																			8,  8,  4,  4,  
																			2,  1,  1,  6,  
																			4,  1,  2}; //15
				
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1}; //15

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					}
				}


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																																  \n");
					sql.append( " RTRIM(DEPTCD)  DEPTCD,   RTRIM(DEPTNMK) DEPTNMK,  RTRIM(DEPTNM) DEPTNM, \n");
					sql.append( " RTRIM(TREECD)  TREECD,   RTRIM(FRDT) FRDT, RTRIM(TODT) TODT,						\n");
					sql.append( " RTRIM(DEPTPRT)  DEPTPRT, RTRIM(DEPTGB) DEPTGB, 	RTRIM(GROUPID) GROUPID,	\n");
					sql.append( " RTRIM(USEYN)   USEYN,    RTRIM(REDTAXYN) REDTAXYN,										  	\n");
					sql.append( " RTRIM(CHGYM)   CHGYM,    RTRIM(DEPTCD_M)   DEPTCD_M,											  \n");
					sql.append( " RTRIM(LEVEL)   LEVEL	,  RTRIM(GROUPID)   GROUPID											\n");
					sql.append( " FROM PAYROLL.HCDEPT 																									  \n");

					if (str1!=null) {	sql.append( " WHERE DEPTCD like '" + str1 + "%' \n"); }
					if (str2!=null) {	sql.append( " AND DEPTNMK like '"  + str2 + "%' \n"); }
          if (str3!=null) {	sql.append( " AND CHGYM like '"  + str3 + "%' \n"); }

	

					if (str4.equals("F")) { sql.append( " AND USEYN <> '" + str4 + "' \n"); } 
					if (str5.equals("1")) {	//LEVEL - 2
						sql.append( " AND LEVEL = '2'													 \n"); 
					} else if (str5.equals("2")) {//LEVEL - 3
						sql.append( " AND SUBSTR(TREECD,1,2) LIKE '"+str6+"%'	 \n");
						sql.append( " AND LEVEL = '3'													 \n"); 
					} else if (str5.equals("3")) {//LEVEL - 4
						sql.append( " AND SUBSTR(TREECD,1,2) LIKE '"+str6+"%'  \n");
						sql.append( " AND SUBSTR(TREECD,3,2) LIKE '"+str7+"%'  \n");
						sql.append( " AND LEVEL = '4'													 \n"); 
					} else if (str5.equals("4")) {//LEVEL - 5
						sql.append( " AND SUBSTR(TREECD,1,2) LIKE '"+str6+"%'  \n");
						sql.append( " AND SUBSTR(TREECD,3,2) LIKE '"+str7+"%'  \n");
						sql.append( " AND SUBSTR(TREECD,5,2) LIKE '"+str12+"%' \n");
						sql.append( " AND LEVEL = '5'													 \n"); 
					} else if (str5.equals("5")) {
						sql.append( " AND SUBSTR(TREECD,1,2) LIKE '"+str6+"%'  \n");
						sql.append( " AND SUBSTR(TREECD,3,2) LIKE '"+str7+"%'  \n");
						sql.append( " AND SUBSTR(TREECD,5,2) LIKE '"+str12+"%' \n");
						sql.append( " AND LEVEL not in ('1','2','3','4')			 \n");
					}

					if (str9.equals("99999999")) {	sql.append(" AND TREECD NOT IN ('99999999') \n"); }
					if (!str10.equals(""))	{	sql.append(" AND TREECD LIKE '"+str10+"%' AND LEVEL>'"+str11+"' \n" ); }


					sql.append( " ORDER BY TREECD ASC \n" );

					logger.dbg.println( this, sql.toString() );

/*********************************************************************************************/
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