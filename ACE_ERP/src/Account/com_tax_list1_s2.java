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
public class com_tax_list1_s2 extends HttpServlet {
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
				String [] str = new String [1];
				str[0]	= req.getParameter("v_str1");		//TAXNBR

				for (int s=0;s<=0;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "GUBUN", "ATCODE",  "ATKORNAM","VEND_CD", "VEND_NM",
					                                "DEPTCD","DEPTNM",  "REMARK",  "TAXSUM",  "TAXVATAMT",
					                                "TAXNBR","TAXIODIV","TAXKND",  "TAXSEQ",  "CHAAMT", 
					                                "DAEAMT","TAXDAT",   "DIVCD"
				}; 

				int[] intArrCN = new int[] { 1,  7, 66, 13, 42,
					                           4, 50, 132, 15, 13, 
					                           11, 1,  1,  3, 15, 
					                           15, 8,  4 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1,  0,  0,
					                           -1, -1, -1, -1,  0, 
					                            0, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
           
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT Z.GUBUN,Z.ATCODE,                                                                        \n");
                    sql.append( "         CASE WHEN Z.GUBUN='V' AND Z.TAXIODIV='A' THEN '선급부가가치세'                           \n");
					sql.append( "              WHEN Z.GUBUN='V' AND Z.TAXIODIV='B' THEN '선수부가가치세'                           \n");
					sql.append( "              ELSE I.ATKORNAM END ATKORNAM,                                                       \n");
					sql.append( "         Z.VEND_CD,RTRIM(J.VEND_NM)VEND_NM,                                                       \n");
					sql.append( "         Z.DEPTCD,RTRIM(K.DEPTNM)DEPTNM,Z.REMARK,Z.TAXSUM,Z.TAXVATAMT,                            \n");
					sql.append( "         Z.TAXNBR,Z.TAXIODIV,Z.TAXKND,Z.TAXSEQ,Z.CHAAMT,                                          \n");
					sql.append( "         Z.DAEAMT,Z.TAXDAT, Y.DEPTCD DIVCD                                                        \n");
					sql.append( "  FROM(                                                                                           \n");
					sql.append( "   SELECT  'T1' GUBUN, H.ATCODE  ATCODE, H.VEND_CD,                                               \n");
					sql.append( "            H.DEPTCD, H.REMARK, 0 TAXSUM,  0 TAXVATAMT,                                           \n");
                    sql.append( "            H.TAXNBR, H.TAXIODIV,H.TAXKND,    '999'  TAXSEQ,                                      \n");
					sql.append( "            CASE WHEN H.TAXIODIV='A' THEN 0                                             \n");
					sql.append( "                 WHEN H.TAXIODIV='B' THEN H.TAXTOT END CHAAMT,                          \n");
					sql.append( "            CASE WHEN H.TAXIODIV='A' THEN H.TAXTOT                                      \n");
					sql.append( "                 WHEN H.TAXIODIV='B' THEN 0        END DAEAMT,                           \n");
					sql.append( "            H.TAXDAT                       \n");
					sql.append( "      FROM ACCOUNT.ATTAXMST H                                                                     \n");
					sql.append( "      WHERE H.TAXNBR ='"+str[0]+"'                                                                \n");
					sql.append( "    UNION ALL                                                                                     \n");
                    sql.append( "    SELECT 'T2' GUBUN, '' ATCODE , H.VEND_CD,                                                     \n");
					sql.append( "            H.DEPTCD, H.REMARK,    SUM(G.TAXSUM) TAXSUM,  0 TAXVATAMT,                                        \n");
					sql.append( "           '' TAXNBR, H.TAXIODIV,H.TAXKND,   MAX(G.TAXSEQ)  TAXSEQ,                                   \n");
					sql.append( "            SUM(CASE WHEN H.TAXIODIV='A'  AND H.TAXKND <> '4' THEN COALESCE(G.TAXSUM,0)                   \n");
					sql.append( "                              WHEN H.TAXIODIV='A' AND H.TAXKND = '4'  THEN COALESCE(G.TAXSUM,0)+COALESCE(G.TAXVATAMT,0) \n");
					sql.append( "                              WHEN H.TAXIODIV='B' THEN 0  END) CHAAMT,                                \n");
                    sql.append( "            SUM(CASE WHEN H.TAXIODIV='A' THEN 0                                             \n");
					sql.append( "                              WHEN H.TAXIODIV='B' AND H.TAXKND <> '4' THEN COALESCE(G.TAXSUM,0) \n");
					sql.append( "                              WHEN H.TAXIODIV='B' AND H.TAXKND = '4' THEN COALESCE(G.TAXSUM,0)+COALESCE(G.TAXVATAMT,0) END) DAEAMT,   \n");
					sql.append( "            H.TAXDAT                       \n");
					sql.append( "      FROM ACCOUNT.ATTAXDTL G, ACCOUNT.ATTAXMST H                                                 \n");
					sql.append( "     WHERE G.TAXNBR = H.TAXNBR                                                                    \n");
					sql.append( "          AND G.TAXNBR ='"+str[0]+"'                                                                 \n");
					sql.append( "     GROUP BY H.VEND_CD,  H.DEPTCD, H.REMARK,G.TAXNBR,H.TAXIODIV,H.TAXKND,H.TAXDAT    \n");
					sql.append( "    UNION ALL                                                                                     \n");
					sql.append( "    SELECT 'V' GUBUN,                                                                             \n");
					sql.append( "            CASE WHEN H.TAXIODIV='A' THEN '1112300'                                     \n");
					sql.append( "                      WHEN H.TAXIODIV='B' THEN '2101100'  END ATCODE,                        \n");
					sql.append( "            H.VEND_CD,                                                                            \n");
                    sql.append( "            H.DEPTCD, H.REMARK,   0 TAXSUM,  SUM(G.TAXVATAMT) TAXVATAMT,         \n");
					sql.append( "            G.TAXNBR, H.TAXIODIV, H.TAXKND,   MAX(G.TAXSEQ)  TAXSEQ,                     \n");
					sql.append( "            SUM(CASE WHEN H.TAXIODIV='A' THEN G.TAXVATAMT                                   \n");
					sql.append( "                              WHEN H.TAXIODIV='B' THEN 0  END) CHAAMT,                              \n");
					sql.append( "            SUM(CASE WHEN H.TAXIODIV='A' THEN 0                                                        \n");
					sql.append( "                              WHEN H.TAXIODIV='B' THEN G.TAXVATAMT END) DAEAMT,            \n");
					sql.append( "            H.TAXDAT                       \n");
					sql.append( "      FROM ACCOUNT.ATTAXDTL G, ACCOUNT.ATTAXMST H                                                 \n");
					sql.append( "     WHERE G.TAXNBR = H.TAXNBR                                                                    \n");
                    sql.append( "          AND G.TAXNBR ='"+str[0]+"'                                                                 \n");
					sql.append( "          AND G.TAXVATAMT<>'0'                                                                       \n");
					sql.append( "          AND H.TAXKND<>'4'                                                                       \n");
					sql.append( "     GROUP BY H.TAXIODIV, H.VEND_CD,  H.DEPTCD, H.REMARK,  G.TAXNBR, H.TAXIODIV, H.TAXKND,H.TAXDAT           \n");
					sql.append( "  )Z,                                                                                              \n");
					
					/*
					sql.append( "     LEFT JOIN ACCOUNT.ACTCODE I ON Z.ATCODE = I.ATCODE                                           \n");
					sql.append( "     LEFT JOIN ACCOUNT.GCZM_VENDER J ON Z.VEND_CD = J.VEND_CD                                     \n");
                    sql.append( "     LEFT JOIN PAYROLL.HCDEPT K ON Z.DEPTCD = K.DEPTCD AND K.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "     LEFT JOIN                                                                                    \n");
					sql.append( "     (SELECT B.DEPTCD,B.DEPTNM,SUBSTR(B.TREECD,1,4)TREECD1, SUBSTR(B.TREECD,1,4)||'0000' TREECD2  \n");
					sql.append( "        FROM PAYROLL.HCDEPT B WHERE B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)             \n");
					sql.append( "      ) X ON SUBSTR(K.TREECD,1,4) = SUBSTR(X.TREECD1,1,4)                                         \n");
					sql.append( "         AND Z.DEPTCD =X.DEPTCD                                                                   \n");
					sql.append( "     LEFT JOIN                                                                                    \n");
					sql.append( "     ( SELECT C.DEPTCD,C.DEPTNM,C.TREECD                                                          \n");
					sql.append( "         FROM PAYROLL.HCDEPT C WHERE C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)            \n");
					sql.append( "          AND SUBSTR(C.TREECD,5,4) = '0000'                                                       \n");
                    sql.append( "      )Y ON Y.TREECD = X.TREECD2                                                                  \n");
					sql.append( "                                                                                                  \n");
					*/
					sql.append( "  (  SELECT H.DEPTCD, H.DEPTNM, H.TREECD  \n");
					sql.append( "       FROM PAYROLL.HCDEPT H  \n");
					sql.append( "      WHERE H.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )  \n");
					sql.append( "  ) K,  \n");
					sql.append( "  ( SELECT B.DEPTCD,B.DEPTNM,SUBSTR(B.TREECD,1,4)TREECD1, SUBSTR(B.TREECD,1,4)||'0000' TREECD2   \n");
					sql.append( "      FROM PAYROLL.HCDEPT B \n");
					sql.append( "     WHERE B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "  ) X,\n");
					sql.append( "  ( SELECT C.DEPTCD,C.DEPTNM,C.TREECD    \n");
					sql.append( "      FROM PAYROLL.HCDEPT C \n");
					sql.append( "     WHERE C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)   \n");
					sql.append( "       AND SUBSTR(C.TREECD,5,4) = '0000'     )Y,\n");
					sql.append( "     ACCOUNT.ACTCODE I ,  ACCOUNT.GCZM_VENDER J \n");
					sql.append( "  WHERE Z.DEPTCD = K.DEPTCD  \n");
					sql.append( "    AND Z.ATCODE = I.ATCODE(+)   \n");
					sql.append( "    AND Z.VEND_CD = J.VEND_CD(+) \n");
					sql.append( "    AND SUBSTR(K.TREECD,1,4) = SUBSTR(X.TREECD1,1,4)  AND Z.DEPTCD =X.DEPTCD(+)  \n");
					sql.append( "    AND Y.TREECD = X.TREECD2     \n");
					sql.append( "    ORDER BY TAXSEQ,GUBUN,ATCODE \n");
				
					//logger.dbg.println(this,sql.toString());
					//System.out.println("com_tax_list1_s2::"+sql.toString()); 
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