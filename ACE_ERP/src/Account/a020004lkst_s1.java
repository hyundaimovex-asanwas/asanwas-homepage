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
public class a020004lkst_s1 extends HttpServlet {
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
			  
			  String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//회계일자 FR
				str[1]	= req.getParameter("v_str2");		//회계일자 TO
        str[2]	= req.getParameter("v_str3");		//결재권자 사번
				str[3]	= req.getParameter("v_str4");		//전표상태
				str[4]	= req.getParameter("v_str5");		//전결전표일자
				str[5]	= req.getParameter("v_str6");		//지점
				str[6]	= req.getParameter("v_str7");		//적요
				str[7]	= req.getParameter("v_str8");		//결재구분 01-회계, 02-예산, 06-자금

				for (int s=0;s<=7;s++) {
					if(str[s]==null) str[s] = "";
				}

				

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",	  "FDCODE",  "FSDAT",	"FSNBR",	   "SEQ",
					                                "ACCSGNID", "EMPNO", "EMPNMK", "REMARK", "FSAMT",
				                                  "ACCSGNEND" , "ACTDAT", "ACCSGNDAT" ,"FROMGB", "TOGB",
					                                "BIGO", "FSDATNBR", "FDNAME","BGTGB","SSDATNBR", "FSSTAT"}; 

				int[] intArrCN = new int[]{  1, 2, 9, 6, 2,
					                           7, 7, 20, 66,15,
					                           1, 8, 8,  2, 2 ,
					                           50, 16, 20, 4, 16, 1}; 
			
				int[] intArrCN2 = new int[]{ -1, -1,-1, -1, -1,
					                           -1, -1, -1, -1, 0,
					                           -1, -1, -1, -1, -1,
				                             -1, -1, -1, -1, -1, -1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					if(str[3].equals("A")){ //전체

						sql.append( " SELECT '' CHK,   A.FDCODE FDCODE,  A.FSDAT FSDAT,  A.FSNBR FSNBR,  A.SEQ,              \n ");
						sql.append( "        ACCSGNID, A.EMPNO,             \n ");
						sql.append( "        CASE WHEN (RTRIM(E.EMPNMK)='' OR E.EMPNMK IS NULL) THEN G.EMPNMK ELSE E.EMPNMK END EMPNMK,            \n ");
						sql.append( "        B.REMARK, B.FSAMT,            \n ");
						sql.append( "        A.ACCSGNEND,  B.ACTDAT,  A.ACCSGNDAT, A.FROMGB, A.TOGB,      \n ");
						sql.append( "        A.BIGO, A.FSDAT||'-'||A.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,\n ");
						sql.append( "        RTRIM(A.BGTGB)BGTGB,  \n ");
						sql.append( "        B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT \n ");
						sql.append( " FROM ACCOUNT.ACTSGNSTS A, ACCOUNT.FSLIPMST B,                       \n ");
						sql.append( "      (SELECT C.FDCODE,  C.FSDAT,  C.FSNBR,  MAX(C.SEQ) AS SEQ       \n ");
						sql.append( "         FROM ACCOUNT.ACTSGNSTS C, ACCOUNT.FSLIPMST D  \n " );
						sql.append( "        WHERE C.FDCODE =D.FDCODE                       \n " );
						sql.append( "          AND C.FSDAT = D.FSDAT                        \n " );
						sql.append( "          AND C.FSNBR = D.FSNBR                        \n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (D.ACTDAT>='"+ str[0]+"' AND  D.ACTDAT <='"+ str[1]+"') ");
						sql.append( "        GROUP BY C.FDCODE,C.FSDAT,C.FSNBR )X  \n " );
					 
						sql.append( " LEFT JOIN PAYROLL.HIPERSON E ON A.EMPNO = E.EMPNO                   \n " );
						sql.append( " LEFT JOIN ACCOUNT.FIELDCODE F ON A.FDCODE = F.FDCODE                \n " );
						sql.append( " LEFT JOIN PAYROLL.T_HIPERSON G ON A.EMPNO = G.EMPNO                 \n " );
						sql.append( " WHERE A.FDCODE =B.FDCODE                                            \n " );
						sql.append( " AND A.FSDAT = B.FSDAT                                               \n " );
						sql.append( " AND A.FSNBR= B.FSNBR                                                \n " );
						sql.append( " AND A.FDCODE =X.FDCODE    \n " );
						sql.append( " AND A.FSDAT = X.FSDAT     \n " );
						sql.append( " AND A.FSNBR= X.FSNBR      \n " );
						sql.append( " AND A.SEQ = X.SEQ         \n " );
			
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') ");
						if(!str[5].equals(""))sql.append( "    AND A.FDCODE ='"+ str[5]+"'" );
						if(!str[2].equals(""))sql.append( "    AND A.ACCSGNID='"+ str[2]+"'" );
						if(!str[3].equals("")&&!str[3].equals("A"))sql.append( "    AND A.ACCSGNEND='"+ str[3]+"'");
						if(str[7].equals("06"))sql.append( "   AND (A.TOGB ='06')");
						if(str[7].equals("02"))sql.append( "   AND (A.TOGB ='02')");
						if(str[7].equals("01"))sql.append( "   AND (A.TOGB<>'02' AND A.TOGB<>'06' AND A.TOGB<>'01')");
						if(!str[6].equals(""))sql.append( "    AND B.REMARK LIKE '%"+ str[6]+"%'" );

						sql.append( " UNION ALL       \n " );

						sql.append( "  SELECT '' CHK,   B.FDCODE FDCODE,  B.FSDAT FSDAT,  B.FSNBR FSNBR,  ''SEQ,                           \n " );
						sql.append( "           '' ACCSGNID, B.EMPNO,                                                                      \n " );
						sql.append( "           CASE WHEN (RTRIM(E.EMPNMK)='' OR E.EMPNMK IS NULL) THEN G.EMPNMK ELSE E.EMPNMK END EMPNMK, \n " );
						sql.append( "           B.REMARK, B.FSAMT,                                                                         \n " );
						sql.append( "           B.FSSTAT ACCSGNEND,  B.ACTDAT,  '' ACCSGNDAT, '' FROMGB,  '' TOGB,                               \n " );
						sql.append( "           '' BIGO, B.FSDAT||'-'||B.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,                             \n " );
						sql.append( "           '' BGTGB,                                                                                  \n " );
						sql.append( "           B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT                                                             \n " );
						sql.append( "    FROM  ACCOUNT.FSLIPMST B                                                                        \n " );
						sql.append( "    LEFT JOIN PAYROLL.HIPERSON E ON B.EMPNO = E.EMPNO                                                 \n " );
						sql.append( "    LEFT JOIN ACCOUNT.FIELDCODE F ON B.FDCODE = F.FDCODE                                              \n " );
						sql.append( "    LEFT JOIN PAYROLL.T_HIPERSON G ON B.EMPNO = G.EMPNO                                               \n " );
						sql.append( "    WHERE B.FDCODE <>''                                                                          \n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') ");
            if(!str[5].equals(""))sql.append( "    AND B.FDCODE ='"+ str[5]+"'" );
						sql.append( "    AND B.FSSTAT IN ('N','B')                                                 \n " );
						sql.append( "    ORDER BY FDCODE, FSDAT DESC, FSNBR                                                                \n " );
					
					}else if(str[3].equals("B")||str[3].equals("N")){  //반송, 대기
						sql.append( "  SELECT '' CHK,   B.FDCODE FDCODE,  B.FSDAT FSDAT,  B.FSNBR FSNBR,  ''SEQ,                           \n " );
						sql.append( "           '' ACCSGNID, B.EMPNO,                                                                      \n " );
						sql.append( "           CASE WHEN (RTRIM(E.EMPNMK)='' OR E.EMPNMK IS NULL) THEN G.EMPNMK ELSE E.EMPNMK END EMPNMK, \n " );
						sql.append( "           B.REMARK, B.FSAMT,                                                                         \n " );
						sql.append( "           B.FSSTAT ACCSGNEND,  B.ACTDAT,  '' ACCSGNDAT, '' FROMGB,  '' TOGB,                               \n " );
						sql.append( "           '' BIGO, B.FSDAT||'-'||B.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,                             \n " );
						sql.append( "           '' BGTGB,                                                                                  \n " );
						sql.append( "           B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT                                                             \n " );
						sql.append( "    FROM  ACCOUNT.FSLIPMST B                                                                         \n " );
						sql.append( "    LEFT JOIN PAYROLL.HIPERSON E ON B.EMPNO = E.EMPNO                                                 \n " );
						sql.append( "    LEFT JOIN ACCOUNT.FIELDCODE F ON B.FDCODE = F.FDCODE                                              \n " );
						sql.append( "    LEFT JOIN PAYROLL.T_HIPERSON G ON B.EMPNO = G.EMPNO                                               \n " );
						sql.append( "    WHERE B.FDCODE <>''                                                                          \n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') ");
            if(!str[5].equals(""))sql.append( "    AND B.FDCODE ='"+ str[5]+"'" );
						sql.append( "    AND B.FSSTAT ='"+ str[3]+"'                                                \n " );
						sql.append( "    ORDER BY FDCODE, FSDAT DESC, FSNBR                                                                \n " );

					}else{
						sql.append( " SELECT '' CHK,   A.FDCODE,  A.FSDAT,  A.FSNBR,  A.SEQ,              \n ");
						sql.append( "        ACCSGNID, A.EMPNO,             \n ");
						sql.append( "        CASE WHEN (RTRIM(E.EMPNMK)='' OR E.EMPNMK IS NULL) THEN G.EMPNMK ELSE E.EMPNMK END EMPNMK,            \n ");
						sql.append( "        B.REMARK, B.FSAMT,            \n ");
						sql.append( "        A.ACCSGNEND,  B.ACTDAT,  A.ACCSGNDAT, A.FROMGB, A.TOGB,      \n ");
						sql.append( "        A.BIGO, A.FSDAT||'-'||A.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,\n ");
						sql.append( "        RTRIM(A.BGTGB)BGTGB,  \n ");
						sql.append( "        B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT \n ");
						sql.append( " FROM ACCOUNT.ACTSGNSTS A, ACCOUNT.FSLIPMST B,                       \n ");
						sql.append( "      (SELECT C.FDCODE,  C.FSDAT,  C.FSNBR,  MAX(C.SEQ) AS SEQ       \n ");
						sql.append( "         FROM ACCOUNT.ACTSGNSTS C, ACCOUNT.FSLIPMST D  \n " );
						sql.append( "        WHERE C.FDCODE =D.FDCODE                       \n " );
						sql.append( "          AND C.FSDAT = D.FSDAT                        \n " );
						sql.append( "          AND C.FSNBR = D.FSNBR                        \n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (D.ACTDAT>='"+ str[0]+"' AND  D.ACTDAT <='"+ str[1]+"') ");
						sql.append( "        GROUP BY C.FDCODE,C.FSDAT,C.FSNBR )X  \n " );
					 
						sql.append( " LEFT JOIN PAYROLL.HIPERSON E ON A.EMPNO = E.EMPNO                   \n " );
						sql.append( " LEFT JOIN ACCOUNT.FIELDCODE F ON A.FDCODE = F.FDCODE                \n " );
						sql.append( " LEFT JOIN PAYROLL.T_HIPERSON G ON A.EMPNO = G.EMPNO                 \n " );
						sql.append( " WHERE A.FDCODE =B.FDCODE                                            \n " );
						sql.append( " AND A.FSDAT = B.FSDAT                                               \n " );
						sql.append( " AND A.FSNBR= B.FSNBR                                                \n " );
						sql.append( " AND A.FDCODE =X.FDCODE    \n " );
						sql.append( " AND A.FSDAT = X.FSDAT     \n " );
						sql.append( " AND A.FSNBR= X.FSNBR      \n " );
						sql.append( " AND A.SEQ = X.SEQ         \n " );
			
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') ");
						if(!str[5].equals(""))sql.append( "    AND A.FDCODE ='"+ str[5]+"'" );
						if(!str[2].equals(""))sql.append( "    AND A.ACCSGNID='"+ str[2]+"'" );
						if(!str[3].equals("")&&!str[3].equals("A"))sql.append( "    AND A.ACCSGNEND='"+ str[3]+"'");
						if(str[7].equals("06"))sql.append( "   AND (A.TOGB ='06')");
						if(str[7].equals("02"))sql.append( "   AND (A.TOGB ='02')");
						if(str[7].equals("01"))sql.append( "   AND (A.TOGB!='02' AND A.TOGB!='06')");
						if(!str[6].equals(""))sql.append( "    AND B.REMARK LIKE '%"+ str[6]+"%'" );
						
						//sql.append( "   ORDER BY A.FDCODE, A.FSDAT DESC, A.FSNBR  " );
				  }
					logger.dbg.println(this,sql.toString());
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