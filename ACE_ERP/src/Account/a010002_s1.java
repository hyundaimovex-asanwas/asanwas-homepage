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
public class a010002_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");
				String  str4	= req.getParameter("v_str4");

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE",	    "ATKORNAM",	 "ATPRTNAM",	 "ATDIV",  	  "ATGRP",	
                                          "ATDECR",	    "ATUSEYN",	 "ATUPCODE",	 "ATPRTSEQ",	"ATFORCURYN",	
                                          "ATCURTYPE",	"ATAPRYN",	 "ATAPRCODE",	 "ATDAYBALYN","ATSUPPLYN",	
                                          "ATTOTACCYN",	"ATSUMBALYN","ATBALSHTYN", "ATPROLSTYN","ATATTSHTYN",	
                                          "ATMAKYN",	  "ATWRKYN",	 "ATTRAYN",	   "ATETCYN",	  "ATOPPUSEYN",	
                                          "ATBDGRELYN",	"ATDEBTYN",  "ATTXT",	     "BASDAT",	  "ATUPCDNM",
					                                "ATAPRNAM",
                                          "WRDT",	      "WRID",	     "UPDT",	     "UPID",	    "DSUDT",
																					"COMMUSE",		"SUMLEVEL",  "FSREFCD",    "FUNDIV"
																				 }; 

				int[] intArrCN = new int[]{ 7,66,66, 1, 1,
					                          1, 1, 7, 7, 1,
					                          1, 1, 7, 1, 1,
					                          1, 1, 1, 1, 1,
					                          1, 1, 1, 1, 1,
					                          1, 1, 256, 8, 66,
					                          66,
					                          8, 7, 8, 7, 8,
																		1, 1, 4, 2}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1,  0, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1,
					                           -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT 																													\n");
					sql.append( " A.ATCODE,	    A.ATKORNAM,	  A.ATPRTNAM,	  A.ATDIV,	    A.ATGRP,	    					\n");
					sql.append( " A.ATDECR,	    A.ATUSEYN,	  nvl(A.ATUPCODE,'')ATUPCODE,  		  							\n");
					sql.append( " nvl(A.ATPRTSEQ,0)ATPRTSEQ,	  A.ATFORCURYN,	  													\n");
					sql.append( " A.ATCURTYPE,	A.ATAPRYN,	  A.ATAPRCODE,	A.ATDAYBALYN,	A.ATSUPPLYN,	 			\n");
					sql.append( " A.ATTOTACCYN,	A.ATSUMBALYN,	A.ATBALSHTYN,	A.ATPROLSTYN,	A.ATATTSHTYN,	 	\n");;
					sql.append( " A.ATMAKYN,	  A.ATWRKYN,	  A.ATTRAYN,	  A.ATETCYN,	  A.ATOPPUSEYN, 						\n");
					sql.append( " A.ATBDGRELYN,	A.ATDEBTYN,	  A.ATTXT,	      															\n");
					sql.append( " A.BASDAT,	    nvl(B.ATKORNAM,'') AS ATUPCDNM,  													\n");					
					sql.append( " nvl(C.ATKORNAM,'') AS ATAPRNAM,  																			\n");
					sql.append( " A.WRDT,	      A.WRID,	      nvl(A.UPDT,'')UPDT,	    													\n");
					sql.append( " nvl(A.UPID,'')UPID,	 nvl(A.DSUDT,'')DSUDT,       														\n");
					sql.append( " A.COMMUSE,A.SUMLEVEL,A.FSREFCD,	A.FUNDIV      													\n");
					sql.append( " FROM ACCOUNT.ACTCODE A 																					\n");
					sql.append( " LEFT JOIN  ACCOUNT.ACTCODE B ON B.ATCODE= A.ATUPCODE 									\n");
					sql.append( " LEFT JOIN  ACCOUNT.ACTCODE C ON C.ATCODE= A.ATAPRCODE 									\n");
					sql.append( " WHERE A.ATCODE IS NOT NULL																					\n");
                                          
					if (str1.equals("A")) sql.append( "   AND A.ATCODE LIKE '" + str2 + "%'													\n");
					if (str1.equals("A")) sql.append( "   AND A.ATKORNAM  LIKE '%" + str3 + "%'											\n");
					if (str1.equals("B")&&!str2.equals("")&&!str3.equals("")) {
						 	sql.append( " AND A.ATCODE BETWEEN '" + str2 + "' AND '" + str3 + "'											\n");
					}
					if (str1.equals("C")&&!str2.equals(""))
							sql.append( " AND A.ATKORNAM LIKE '%"+str2+"%' 																	\n");
					else if(str1.equals("C")&&!str3.equals(""))
							sql.append( " AND A.ATCODE LIKE '"+str3+"%' 																			\n");
					if (str4.equals("ATUSEYN")) sql.append( "   AND A.ATUSEYN ='Y'															\n");
							sql.append( " ORDER BY A.ATCODE 																						\n");					

					//System.out.println("# Query : " + sql);			
					//logger.dbg.println(this,sql.toString());
							
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