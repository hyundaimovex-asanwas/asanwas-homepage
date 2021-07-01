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
public class a030023_s4 extends HttpServlet {
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
				str[3] = req.getParameter("v_str4");	//거래처 from
				str[4] = req.getParameter("v_str5");	//거래처 to 
				str[5] = req.getParameter("v_str6");	//계정과목  
				str[6] = str[1].substring(4,6);	//01
				str[7] = str[1].substring(0,4);	//2006
              
				int str7   =  Integer.parseInt(str[6]);
				int str10  =  Integer.parseInt(str[7]);
				str7 = str7 - 1; //01
				String str8 = String.valueOf(str7);
				String str9 = "";
				if(0 < str7 && str7 <= 9) { //01
					str8 = "0" + str7;
					str9 = str[7] + str8;
				}else if(str7 == 0){
					str10 = str10 - 1;
					String str11 = String.valueOf(str10);
					str7 = 12;
					str9 = str11 + str7; //기간 from 전달
				}

				for(int i=0;i<=7;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "ACTDAT", "FSREFVAL", "CDNAM", "REMARK", "DETOT", "CRTOT", "ATCODE", }; 
				int[] intArrCN = new int[] {       8,   20,   40,  132,   15,   15, 7 }; 
				int[] intArrCN2 = new int[]{      -1,   -1,   -1,   -1,    0,    0, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					//2008.08.29 정영식 : 전기이월 조회 테이블 변경

					sql.append( " SELECT '20060000'   AS ACTDAT, \n" );
					sql.append( "        ''           AS FSREFVAL, \n" );
					sql.append( "        ''           AS CDNAM, \n" );
					sql.append( "        ''   AS REMARK,   \n" );
					sql.append( "        nvl(SUM(CASE WHEN B.ATDECR = '1'  THEN A.DETOT - A.CRTOT ELSE 0 END),0) AS DETOT, \n" );
					sql.append( "        nvl(SUM(CASE WHEN B.ATDECR = '2'  THEN A.CRTOT - A.DETOT ELSE 0 END),0) AS CRTOT,'000' AS ATCODE \n" );
					sql.append( " FROM ACCOUNT.FSREFTOT A,ACCOUNT.ACTCODE B \n" );
					sql.append( " WHERE A.ATCODE = B.ATCODE \n" );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"' \n" );
					sql.append( " AND A.ACTDAT BETWEEN '"+str9.substring(0,4)+"0100' AND '"+str9+"31' \n" );
					if(!str[5].equals(""))sql.append( " AND A.ATCODE = '"+str[5]+"' \n" );
					sql.append( " AND A.FSREFCD = '0020' \n" );
					if(!str[3].equals(""))sql.append( " AND A.FSREFVAL >= '"+str[3]+"' AND A.FSREFVAL <= '"+str[4]+"' \n" );
					sql.append( " AND B.ATUSEYN = 'Y' \n" );
					sql.append( " UNION ALL \n" );
					sql.append( " SELECT  E.ACTDAT    AS ACTDAT, \n" );
					sql.append( "        F.FSREFVAL  AS FSREFVAL, \n" );
					sql.append( "        G.CDNAM     AS CDNAM, \n" );
					sql.append( "        E.REMARK    AS REMARK, \n" );
					sql.append( "        E.DETOT     AS DETOT, \n" );
					sql.append( "        E.CRTOT     AS CRTOT, E.ATCODE  AS ATCODE \n" );
					sql.append( " FROM ( \n" );
					sql.append( "   SELECT  C.ACTDAT,D.REMARK,C.DETOT,C.CRTOT,C.FDCODE,C.FSDAT,C.FSNBR,C.FSSEQ,C.ATCODE \n" );
					sql.append( "   FROM ACCOUNT.FSLIPDTL D RIGHT JOIN \n" );
					sql.append( "   ( \n" );
					sql.append( "   SELECT 	A.ACTDAT     AS ACTDAT, \n" );
					sql.append( "          A.DEAMT      AS DETOT, \n" );
					sql.append( "          A.CRAMT      AS CRTOT, \n" );
					sql.append( "          A.FDCODE     AS FDCODE, \n" );
					sql.append( "          A.FSDAT      AS FSDAT, \n" );
					sql.append( "          A.FSNBR      AS FSNBR, \n" );
					sql.append( "          A.FSSEQ      AS FSSEQ, B.ATCODE     AS ATCODE \n" );
					sql.append( "   FROM ACCOUNT.GENENLED A,ACCOUNT.ACTCODE B \n" );
					sql.append( "   WHERE A.ATCODE = B.ATCODE \n" );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"' \n" );
					sql.append( "   AND SUBSTR(A.ACTDAT,1,6) BETWEEN '"+str[1]+"' AND '"+str[2]+"' \n" );
					if(!str[5].equals(""))sql.append( " AND A.ATCODE = '"+str[5]+"' \n" );
					sql.append( "   AND B.ATUSEYN = 'Y' \n" );
					sql.append( "   ) C \n" );
					sql.append( "   ON C.FDCODE = D.FDCODE \n" );
					sql.append( "   AND C.FSDAT  = D.FSDAT \n" );
					sql.append( "   AND C.FSNBR  = D.FSNBR \n" );
					sql.append( "   AND C.FSSEQ  = D.FSSEQ \n" );
					sql.append( " ) E LEFT JOIN ACCOUNT.GENENREF F \n" );
					sql.append( " ON E.FDCODE = F.FDCODE \n" );
					sql.append( " AND E.FSDAT  = F.FSDAT \n" );
					sql.append( " AND E.FSNBR  = F.FSNBR \n" );
					sql.append( " AND E.FSSEQ  = F.FSSEQ \n" );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL G \n" );
					sql.append( " ON F.FSREFVAL = G.CDCODE \n" );
					sql.append( " AND G.CMTYPE = '0020' \n" );
					sql.append( " WHERE F.FSREFCD = '0020' \n" );
					if(!str[3].equals(""))sql.append( " AND F.FSREFVAL >= '"+str[3]+"' AND F.FSREFVAL <= '"+str[4]+"' \n" );
					sql.append( " UNION ALL \n" );
					sql.append( " SELECT  A.ACTYYMM||'32' AS ACTDAT, \n" );
					sql.append( "        ''           AS FSREFVAL, \n" );
					sql.append( "        ''           AS CDNAM, \n" );
					sql.append( "        ''       AS REMARK, \n" );
					sql.append( "        nvl(SUM(A.DETOT),0) AS DETOT, \n" );
					sql.append( "        nvl(SUM(A.CRTOT),0) AS CRTOT , '888'  AS ATCODE\n" );
					sql.append( " FROM ACCOUNT.MFSREFTOT A,ACCOUNT.ACTCODE B \n" );
					sql.append( " WHERE A.ATCODE = B.ATCODE \n" );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"' \n" );
					sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"' \n" );
					if(!str[5].equals(""))sql.append( " AND A.ATCODE = '"+str[5]+"' \n" );
					sql.append( " AND A.FSREFCD = '0020' \n" );
					if(!str[3].equals(""))sql.append( " AND A.FSREFVAL >= '"+str[3]+"' AND A.FSREFVAL <= '"+str[4]+"' \n" );
					sql.append( " AND B.ATUSEYN = 'Y' \n" );
					sql.append( " GROUP BY A.ACTYYMM||'32' \n" );
					sql.append( " ORDER BY 1,2 \n" );

					//logger.dbg.println(this, sql.toString());
						
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