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
public class a020001_s10 extends HttpServlet {
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
				String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//ó���ⰣFR
				str[1]	= req.getParameter("v_str2");		//ó���ⰣTO
				str[2]	= req.getParameter("v_str3");		//����
				str[3]	= req.getParameter("v_str4");		//��������FR
				str[4]	= req.getParameter("v_str5");		//��������TO
				str[5]	= req.getParameter("v_str6");		//�ŷ�óFR
				str[6]	= req.getParameter("v_str7");		//�ŷ�óTO
				str[7]	= req.getParameter("v_str8");		//�űԱ���


				for (int s=0;s<=7;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",    "GUBUN",    "BANJAEYN", "FSDAT",  "FSNBR",   "ATDECR",
					                                "CHAAMT", "DAEAMT",   "REMARK", "FSREFVAL","VEND_NM",  "TOTAL",
					                                "FDCODE", "ATDECR",   "FSSEQ" 
				};                              
       
				int[] intArrCN = new int[]{ 1,  1,   1,   9,  6,  1,
																	 15, 15, 132,  20, 32, 15,
					                          2,  1,   5    
				}; 

				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1, -1,
																		 0,  0, -1, -1, -1,  0,
					                          -1, -1, -1
				};
																	 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
        
								
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT DISTINCT ''CHK, 'T'GUBUN, RTRIM(C.BANJAEYN)BANJAEYN, A.FSDAT, A.FSNBR,A.ATDECR, 	\n");
					sql.append( "         CASE WHEN A.ATDECR='1' THEN COALESCE(A.FSAMT,0)                										\n");
					sql.append( "              WHEN A.ATDECR='2' THEN 0 END CHAAMT,                      												\n");
					sql.append( "         CASE WHEN A.ATDECR='1' THEN 0                                  													\n");
					sql.append( "              WHEN A.ATDECR='2' THEN COALESCE(A.FSAMT,0) END DAEAMT,    									\n");
					sql.append( "         A.REMARK, B.FSREFVAL, D.VEND_NM , A.FSAMT TOTAL, A.FDCODE, A.ATDECR,A.FSSEQ   		\n");
					sql.append( "    FROM ACCOUNT.FSLIPDTL A, ACCOUNT.FSLIPREF B                         											\n");
					sql.append( "    LEFT JOIN ACCOUNT.BANJAEREL C ON A.FDCODE =C.FDCODE                 									\n");
					sql.append( "                                 AND A.FSDAT = C.TSDAT                  															\n");
					sql.append( "                                 AND A.FSNBR = C.TSNBR                  															\n");
					sql.append( "                                 AND A.FSSEQ = C.TSSEQ                  														\n");
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER D ON B.FSREFVAL = D.VEND_CD           								\n");
					sql.append( "   WHERE A.FDCODE =B.FDCODE                                             													\n");
					sql.append( "     AND A.FSDAT = B.FSDAT                                              															\n");
					sql.append( "     AND A.FSNBR = B.FSNBR                                              															\n");
					sql.append( "     AND A.FSSEQ = B.FSSEQ                                              														\n");
					sql.append( "     AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[4]+"'                 												\n");
					sql.append( "     AND B.FSREFCD ='0020'                                              															\n");
					sql.append( "     AND B.FSREFVAL BETWEEN '"+str[5]+"' AND '"+str[6]+"'               												\n");
					if(str[7].equals("0"))  sql.append( "     AND (C.BANJAEYN IS NULL) 																		\n");
					if(!str[7].equals("0")) sql.append( "     AND (C.BANJAEYN<>'Y')    																		\n");
					sql.append( "  UNION ALL                                                             																	\n");
					sql.append( "  SELECT ''CHK,'D'GUBUN, RTRIM(C.BANJAEYN)BANJAEYN, A.FSDAT, A.FSNBR,A.ATDECR,   				\n");
					sql.append( "          CASE WHEN A.ATDECR='1' THEN COALESCE(A.FSAMT,0)               										\n");
					sql.append( "               WHEN A.ATDECR='2' THEN 0 END CHAAMT,                     												\n");
					sql.append( "         CASE WHEN A.ATDECR='1' THEN 0                                  													\n");
					sql.append( "              WHEN A.ATDECR='2' THEN COALESCE(A.FSAMT,0) END DAEAMT,    									\n");
					sql.append( "         A.REMARK, B.FSREFVAL, D.VEND_NM , A.FSAMT TOTAL, A.FDCODE, A.ATDECR,A.FSSEQ   		\n");
					sql.append( "    FROM ACCOUNT.FSLIPDTL A, ACCOUNT.FSLIPREF B, ACCOUNT.BANJAEREL C    							\n");
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER D ON B.FSREFVAL = D.VEND_CD           								\n");
					sql.append( "   WHERE A.FDCODE =B.FDCODE                                             				\n");
					sql.append( "     AND A.FSDAT = B.FSDAT                                              						\n");
					sql.append( "     AND A.FSNBR = B.FSNBR                                              						\n");
					sql.append( "     AND A.FSSEQ = B.FSSEQ                                              					\n");
					sql.append( "     AND A.FDCODE =C.FDCODE                                             					\n");
					sql.append( "     AND A.FSDAT = C.BTSDAT                                             						\n");
					sql.append( "     AND A.FSNBR = C.BTSNBR                                             					\n");
					sql.append( "     AND A.FSSEQ = C.BTSSEQ                                             					\n");
					sql.append( "     AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[4]+"'                 			\n");
					sql.append( "     AND B.FSREFCD ='0020'                                              						\n");
					sql.append( "     AND B.FSREFVAL BETWEEN '"+str[5]+"' AND '"+str[6]+"'               			\n");
					sql.append( "     AND C.BANJAEYN<>'Y'                                                						\n");
					
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