package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a010002_s4 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String  str1	= req.getParameter("v_str1");
				
				if (str1 == null) str1 = "";
			
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE",	    "ATKORNAM",	 "ATPRTNAM",	 "ATDIV",  	  "ATGRP",	
                                          "ATDECR",	    "ATUSEYN",	 "ATUPCODE",	 "ATPRTSEQ",	"ATFORCURYN",	
                                          "ATCURTYPE",	"ATAPRYN",	 "ATAPRCODE",	 "ATDAYBALYN","ATSUPPLYN",	
                                          "ATTOTACCYN",	"ATSUMBALYN","ATBALSHTYN", "ATPROLSTYN","ATATTSHTYN",	
                                          "ATMAKYN",	  "ATWRKYN",	 "ATTRAYN",	   "ATETCYN",	  "ATOPPUSEYN",	
                                          "ATBDGRELYN",	"ATDEBTYN",  "ATTXT",	     "BASDAT",	  "ATUPCDNM",
                                          "WRDT",	      "WRID",	     "UPDT",	     "UPID",	    "DSUDT",																		 
																				 }; 

				int[] intArrCN = new int[]{ 7,66,66, 6, 6,
					                          6, 6, 7, 7, 6,
					                          6, 6, 7, 6, 6,
					                          6, 6, 6, 6, 6,
					                          6, 6, 6, 6, 6,
					                          6, 6, 256, 8, 66,
					                          8, 7, 8, 7, 8}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1,  0, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT                                                                                     											\n");
					sql.append( " 	A.ATCODE,      A.ATKORNAM,   A.ATPRTNAM,   																		\n");
					sql.append( " 	RTRIM(C.CDNAM)ATDIV,      RTRIM(D.CDNAM)ATGRP,																\n");					
					sql.append( " 	CASE A.ATDECR  WHEN '1' THEN '����'                                                      							\n");
					sql.append( " 								 WHEN '2' THEN '�뺯' END ATDECR,                                         				\n");
					sql.append( " 	CASE A.ATUSEYN WHEN 'Y' THEN '���' ELSE '�̻��' END ATUSEYN,                        				\n");
					sql.append( " 	A.ATUPCODE,nvl(A.ATPRTSEQ,0)ATPRTSEQ,                                                 							\n");
					sql.append( " 	CASE A.ATFORCURYN WHEN 'Y' THEN '���' ELSE '�̻��' END ATFORCURYN,              				\n");
					sql.append( " 	CASE A.ATCURTYPE  WHEN 'Y' THEN '���' ELSE '�̻��' END ATCURTYPE,                  				\n");
					sql.append( " 	CASE A.ATAPRYN    WHEN 'Y' THEN '���' ELSE '�̻��' END ATAPRYN,                        				\n");
					sql.append( " 	A.ATAPRCODE,                                                                             										\n");
					sql.append( " 	CASE A.ATDAYBALYN WHEN 'Y' THEN '���' ELSE '�����' END ATDAYBALYN,                     			\n");
					sql.append( " 	CASE A.ATSUPPLYN  WHEN 'Y' THEN '���' ELSE '�����' END ATSUPPLYN,                      			\n");
					sql.append( " 	CASE A.ATTOTACCYN WHEN 'Y' THEN '���' ELSE '�����' END ATTOTACCYN,                     		\n");
					sql.append( " 	CASE A.ATSUMBALYN WHEN 'Y' THEN '���' ELSE '�����' END ATSUMBALYN,                     		\n");
					sql.append( " 	CASE A.ATBALSHTYN WHEN 'Y' THEN '���' ELSE '�����' END ATBALSHTYN,                     		\n");
					sql.append( " 	CASE A.ATPROLSTYN WHEN 'Y' THEN '���' ELSE '�����' END ATPROLSTYN,                     		\n");
					sql.append( " 	CASE A.ATATTSHTYN WHEN 'Y' THEN '���' ELSE '�����' END ATATTSHTYN,                     			\n");
					sql.append( " 	CASE A.ATMAKYN    WHEN 'Y' THEN '���' ELSE '�����' END ATMAKYN,                        				\n");
					sql.append( " 	CASE A.ATWRKYN    WHEN 'Y' THEN '���' ELSE '�����' END ATWRKYN,                        			\n");
					sql.append( " 	CASE A.ATTRAYN    WHEN 'Y' THEN '���' ELSE '�����' END ATTRAYN,                        				\n");
					sql.append( " 	CASE A.ATETCYN    WHEN 'Y' THEN '���' ELSE '�����' END ATETCYN,                        				\n");
					sql.append( " 	CASE A.ATOPPUSEYN WHEN 'Y' THEN '���' ELSE '�����' END ATOPPUSEYN,                     		\n");
					sql.append( " 	CASE A.ATBDGRELYN WHEN 'Y' THEN '���' ELSE '�̻��' END ATBDGRELYN,                     		\n");
					sql.append( " 	CASE A.ATDEBTYN   WHEN 'Y' THEN '���' ELSE '�̻��' END ATDEBTYN,                       			\n");
					sql.append( " 	A.ATTXT,      A.BASDAT,  B.ATKORNAM AS ATUPCDNM,                                         					\n");
					sql.append( " 	A.WRDT,          A.WRID,         A.UPDT,         A.UPID,         A.DSUDT                 							\n");
					sql.append( " FROM ACCOUNT.ACTCODE A                                                                     							\n");
					sql.append( " LEFT JOIN  ACCOUNT.ACTCODE B ON B.ATUPCODE=A.ATCODE                                        			\n");
					sql.append( " LEFT JOIN  ACCOUNT.COMMDTIL C ON C.CDCODE=A.ATDIV AND C.CMTYPE='0033'                      	\n");
					sql.append( " LEFT JOIN  ACCOUNT.COMMDTIL D ON C.CDCODE=A.ATDIV AND D.CMTYPE='0034'                      	\n");
					sql.append( " WHERE A.ATCODE LIKE '" + str1 + "'																						\n");

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