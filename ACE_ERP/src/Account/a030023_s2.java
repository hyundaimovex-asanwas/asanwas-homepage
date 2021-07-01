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
public class a030023_s2 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//기간 from
				str[2] = req.getParameter("v_str3");	//기간 to
				str[3] = req.getParameter("v_str4");	//거래처
				str[4] = req.getParameter("v_str5");	//계정과목from 
				str[5] = req.getParameter("v_str6");	//계정과목to  
				str[6] = str[1].substring(4,6);	//01
				str[7] = str[1].substring(0,4);	//2006

		        String stryymmdd = "";
						String strmm="";
						int intmm   =  Integer.parseInt(str[6]);
		        if(str[6].equals("01")){
							stryymmdd = str[7]+str[6]+"00";
						}else{
				      intmm = intmm - 1;
							if(intmm>0&&intmm<=9){
		             strmm = "0"+ intmm;  
							}else{
		             strmm = intmm +"";  
		          }
					stryymmdd = str[7]+strmm+"31";
				}

				for(int i=0;i<=7;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "ATCODE", "ATKORNAM", "ATKORNAM2", "ACTDAT", "GUBUN", "REMARK", "DETOT", "CRTOT","JANAMT", "FSREFVAL", "VEND_NM" }; 
				int[] intArrCN = new int[] {    7,   66,   66,  8,   2, 132,   15,   15,  15,    6,   62 }; 
				int[] intArrCN2 = new int[]{   -1,   -1,   -1, -1,  -1,  -1,    0,    0,   0,  -1,  -1 }; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.ATCODE AS ATCODE,                                                                  \n" );
					sql.append( "        B.ATKORNAM AS ATKORNAM, B.ATKORNAM AS ATKORNAM2,                                     \n" );
					sql.append( "        '"+str[7]+"0000' AS ACTDAT, '00'GUBUN,                                               \n" );
					sql.append( "        '' AS REMARK,                                                                        \n" );
					sql.append( "        nvl(SUM(CASE WHEN B.ATDECR = '1'  THEN A.DETOT - A.CRTOT ELSE 0 END),0) AS DETOT, \n" );
					sql.append( "        nvl(SUM(CASE WHEN B.ATDECR = '2'  THEN A.CRTOT - A.DETOT ELSE 0 END),0) AS CRTOT, \n" );
					sql.append( "        nvl(SUM(CASE WHEN B.ATDECR = '1'  THEN A.DETOT - A.CRTOT                          \n" );
					sql.append( "                        WHEN B.ATDECR = '2'  THEN A.CRTOT - A.DETOT END),0) AS JANAMT,       \n" );
					sql.append( "        A.FSREFVAL, Z.VEND_NM                                                                \n" );
					sql.append( " FROM ACCOUNT.FSREFTOT A, ACCOUNT.ACTCODE B, ACCOUNT.GCZM_VENDER Z               \n" );
					sql.append( " WHERE A.ATCODE = B.ATCODE AND Z.VEND_CD = A.FSREFVAL                                           \n" );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                               \n" );
					sql.append( " AND A.ACTDAT BETWEEN '"+str[7]+"0100' AND '"+stryymmdd+"'                                 \n" );
					if(!str[4].equals(""))sql.append( " AND A.ATCODE BETWEEN '" +str[4]+ "'  AND '" +str[5]+ "'                                   \n" );
					sql.append( " AND A.FSREFCD = '0020'                                                                    \n" );
					if(!str[3].equals(""))sql.append( " AND A.FSREFVAL = '" +str[3]+ "'                                                           \n" );
					sql.append( " AND B.ATUSEYN = 'Y'                                                                       \n" );
					sql.append( " GROUP BY  A.ATCODE, B.ATKORNAM, A.FSREFVAL, Z.VEND_NM                                       \n" );

					sql.append( " UNION ALL                                                                                   \n" );

					sql.append( " SELECT E.ATCODE  AS ATCODE,                                                                 \n" );
					sql.append( " E.ATKORNAM  AS ATKORNAM, E.ATKORNAM  AS ATKORNAM2,                                          \n" );
					sql.append( " E.ACTDAT    AS ACTDAT, SUBSTR(E.ACTDAT,7,2)GUBUN,                                           \n" );
					sql.append( " E.REMARK    AS REMARK,                                                                      \n" );
					sql.append( " nvl(E.DETOT,0)     AS DETOT,                                                             \n" );
					sql.append( " nvl(E.CRTOT,0)     AS CRTOT,                                                             \n" );
					sql.append( " nvl(CASE WHEN E.ATDECR = '1'  THEN E.DETOT - E.CRTOT                                     \n" );
					sql.append( "             WHEN E.ATDECR = '2'  THEN E.CRTOT - E.DETOT  END,0) AS JANAMT,                  \n" );
					sql.append( " F.FSREFVAL,Z.VEND_NM                                                                        \n" );
					sql.append( " FROM (                                                                                      \n" );
					sql.append( "	SELECT C.ATCODE, C.ATKORNAM, C.ACTDAT, D.REMARK, C.DETOT, C.CRTOT,                          \n" );
					sql.append( "   C.FDCODE, C.FSDAT, C.FSNBR, C.FSSEQ, C.ATDECR                                             \n" );
					sql.append( "   FROM ACCOUNT.FSLIPDTL D RIGHT JOIN                                                        \n" );
					sql.append( "   (                                                                                         \n" );
					sql.append( "		SELECT B.ATCODE     AS ATCODE,                                                            \n" );
					sql.append( "		A.ACTDAT     AS ACTDAT,                                                                   \n" );
					sql.append( "       B.ATKORNAM   AS ATKORNAM,                                                             \n" );
					sql.append( "       A.DEAMT      AS DETOT,                                                                \n" );
					sql.append( "       A.CRAMT      AS CRTOT,                                                                \n" );
					sql.append( "       A.FDCODE     AS FDCODE,                                                               \n" );
					sql.append( "       A.FSDAT      AS FSDAT,                                                                \n" );
					sql.append( "       A.FSNBR      AS FSNBR,                                                                \n" );
					sql.append( "       A.FSSEQ      AS FSSEQ,                                                                \n" );
					sql.append( "       B.ATDECR     AS ATDECR                                                                \n" );
					sql.append( "       FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE B                                            \n" );
					sql.append( "       WHERE A.ATCODE = B.ATCODE                                                             \n" );
					if(!str[0].equals(""))sql.append( "     AND A.FDCODE = '"+str[0]+"'                                                           \n" );
					sql.append( "     AND A.ACTDAT BETWEEN '"+str[1]+"01' AND '"+str[2]+"31'                                \n" );
					if(!str[4].equals(""))sql.append( "     AND A.ATCODE BETWEEN '" +str[4]+ "'  AND '" +str[5]+ "'                               \n" );
					sql.append( "       AND B.ATUSEYN = 'Y'                                                                   \n" );
					sql.append( "   ) C                                                                                       \n" );
					sql.append( "   ON C.FDCODE = D.FDCODE                                                                    \n" );
					sql.append( "   AND C.FSDAT  = D.FSDAT                                                                    \n" );
					sql.append( "   AND C.FSNBR  = D.FSNBR                                                                    \n" );
					sql.append( "   AND C.FSSEQ  = D.FSSEQ                                                                    \n" );
					sql.append( " ) E LEFT JOIN ACCOUNT.GENENREF F                                                            \n" );
					sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER Z ON Z.VEND_CD = F.FSREFVAL                                   \n" );
					sql.append( " ON E.FDCODE = F.FDCODE                                                                      \n" );
					sql.append( " AND E.FSDAT  = F.FSDAT                                                                      \n" );
					sql.append( " AND E.FSNBR  = F.FSNBR                                                                      \n" );
					sql.append( " AND E.FSSEQ  = F.FSSEQ                                                                      \n" );
					sql.append( " WHERE F.FSREFCD = '0020'                                                                    \n" );
					if(!str[3].equals(""))sql.append( " AND F.FSREFVAL = '"+str[3]+"'                                                             \n" );

					sql.append( " UNION ALL                                                                                   \n" );

					sql.append( " SELECT A.ATCODE  AS ATCODE,                                                                 \n" );
					sql.append( "        B.ATKORNAM AS ATKORNAM, B.ATKORNAM AS ATKORNAM2 ,                                    \n" );
					sql.append( " SUBSTR(A.ACTDAT,1,6)||'32' AS ACTDAT, '32'GUBUN,                                            \n" );
					sql.append( " ''        AS REMARK,                                                                        \n" );
					sql.append( " nvl(SUM(A.DETOT),0) AS DETOT,                                                            \n" );
					sql.append( " nvl(SUM(A.CRTOT),0) AS CRTOT,                                                            \n" );
					sql.append( " nvl(SUM(CASE WHEN B.ATDECR = '1'  THEN A.DETOT - A.CRTOT                                 \n" );
					sql.append( "                   WHEN B.ATDECR = '2'  THEN A.CRTOT - A.DETOT  END),0) AS JANAMT,           \n" );
					sql.append( " A.FSREFVAL,Z.VEND_NM                                                                        \n" );
					sql.append( " FROM ACCOUNT.FSREFTOT A, ACCOUNT.ACTCODE B, ACCOUNT.GCZM_VENDER Z                       \n" );
					sql.append( " WHERE A.ATCODE = B.ATCODE AND Z.VEND_CD = A.FSREFVAL                                                                   \n" );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                               \n" );
					sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"01' AND '"+str[2]+"31'                                    \n" );
					if(!str[4].equals(""))sql.append( " AND A.ATCODE BETWEEN '" +str[4]+ "'  AND '" +str[5]+ "'                                   \n" );
					sql.append( " AND A.FSREFCD = '0020'                                                                    \n" );
					if(!str[3].equals(""))sql.append( " AND A.FSREFVAL = '" +str[3]+ "'                                                           \n" );
					sql.append( " AND B.ATUSEYN = 'Y'                                                                         \n" );
					sql.append( " GROUP BY A.ATCODE, SUBSTR(A.ACTDAT,1,6)||'32',B.ATKORNAM, A.FSREFVAL,Z.VEND_NM              \n" );
					sql.append( " ORDER BY 1,4                                                                                \n" );

					//System.out.println("# Query : " + sql);
					//logger.dbg.println(this, sql.toString());
					
//*********************************************************************************************/
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