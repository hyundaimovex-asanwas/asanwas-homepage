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
public class a080006_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//예산년도
				str[2] = req.getParameter("v_str3");	//예산월fr
				str[3] = req.getParameter("v_str4");	//예산월to
				str[4] = req.getParameter("v_str5");	//예산본부
				str[5] = req.getParameter("v_str6");	//예산부서
				str[6] = req.getParameter("v_str7");	//계정명
				str[7] = req.getParameter("v_str8");	//계정코드
				str[8] = req.getParameter("v_str9");	//세세목
				str[9] = req.getParameter("v_str10");	//관리항목코드

				for(int i=0;i<=9;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"BGTYY","FDCODE","BGTDIV","BGTDPT",
					"BGTMM",  "FDCODE",   "ATCODE",  "ATKORNAM","SATCODE", "SATNM", "DEPTNM",
					"BASICBGT",  "ADDBGT",  "CHGABGT", "CHGTBGT",  "DEPTBGT", "REALBGT", "RESULTS",
					"BRESULTS","TOTRES"
				}; 

				int[] intArrCN = new int[] { 
						4,   2,   4,   4,
					 2,   2,   7,  66,   2,  40,  30, 
					15,  15,  15,  15,  15,  15,  15,
					15,  20 
				}; 
			
				int[] intArrCN2 = new int[]{ 
						-1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,  -1,  -1,
					 0,	  0,   0,	  0,   0,   0,   0,
					 0,   0
				};  

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																											\n");	
						sql.append( "  RTRIM(A.BGTYY)    BGTYY,       --년도       															\n");
						sql.append( "  RTRIM(A.FDCODE)    FDCODE,     --지점       														\n");
						sql.append( "  RTRIM(A.BGTDIV)    BGTDIV,       --신청본부 														\n");
						sql.append( "  RTRIM(A.BGTDPT)    BGTDPT,     --신천부서   													\n");
						sql.append( " RTRIM(A.BGTMM)    BGTMM,              																\n");
						sql.append( " RTRIM(A.FDCODE)   FDCODE,										/*지점구분*/					\n");
						sql.append( " RTRIM(A.ATCODE)   ATCODE,										/*계정코드*/						\n");
						sql.append( " RTRIM(F.ATKORNAM) ATKORNAM,									/*계정명*/						\n");
						sql.append( " RTRIM(A.SATCODE)  SATCODE,									/*세목코드*/						\n");
						sql.append( " RTRIM(E.CDNAM)    SATNM,										/*세목명*/							\n");
						sql.append( " RTRIM(H.CDNAM)    DEPTNM,                  /*부서명*/                  							\n");
						sql.append( " nvl(SUM(A.BASICBGT),0)   BASICBGT,				/*배정액*/										\n");
						sql.append( " nvl(SUM(A.ADDBGT),0)			ADDBGT,					/*추가예산*/							\n");
						sql.append( " nvl(SUM(A.CHGABGT),0)    CHGABGT,				/*항목전용*/									\n");
						sql.append( " nvl(SUM(A.CHGTBGT),0)		CHGTBGT,				/*기간전용*/								\n");
						sql.append( " nvl(SUM(A.DEPTBGT),0)		DEPTBGT,				/*부서전용*/								\n");
						sql.append( " nvl(SUM(A.REALBGT),0)		REALBGT,				/*실행예산*/								\n");
						sql.append( " nvl(SUM(A.RESULTS),0)		RESULTS,				/*실적*/										\n");
						sql.append( " nvl(SUM(A.RESULTS),0)		BRESULTS,				/*결재전실적*/						\n");
						sql.append( "  nvl(SUM(A.RESULTS) +SUM(A.BRESULTS),0)  TOTRES		/*결재전실적 + 실적*/		\n");
						sql.append( " FROM ACCOUNT.BGTDTL A																				\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE=F.ATCODE									\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTREFCODE C ON F.ATCODE=C.ATCODE AND A.ATCODE=C.ATCODE  AND C.TYPE='B'					\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON A.SATCODE=E.CDCODE AND C.CDCODE=E.CMTYPE			\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL H ON A.BGTDPT = H.CDCODE AND H.CMTYPE IN('0003') 			\n");
						sql.append( " WHERE 1 = 1 																			\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'							\n");	//지점코드 
						if(!str[1].equals("")) sql.append( " AND A.BGTYY   = '"+str[1]+"'							\n");	//예산년도 
						if(!str[2].equals("")) sql.append( " AND A.BGTMM  BETWEEN '"+str[2]+"' AND '"+str[3]+"'	\n");	//예산월   
						if(!str[4].equals("")) sql.append( " AND A.BGTDIV  = '"+str[4]+"'							\n");	//예산본부 
						if(!str[5].equals("")) sql.append( " AND A.BGTDPT  = '"+str[5]+"'							\n");	//예산부서 
						if(!str[6].equals("")) sql.append( " AND F.ATKORNAM LIKE '"+str[6]+"%'					\n");	//계정명   
						if(!str[7].equals("")) sql.append( " AND A.ATCODE  = '"+str[7]+"'							\n");	//계정코드 
						if(!str[8].equals("")) sql.append( " AND A.SATCODE = '"+str[8]+"'							\n");	//세세목   
						if(!str[9].equals("")) sql.append( " AND A.FSREFCD = '"+str[9]+"'							\n");	//관리항목
						sql.append( " GROUP BY A.BGTYY,A.FDCODE,A.BGTDIV,A.BGTDPT,A.FDCODE,A.ATCODE,F.ATKORNAM,A.SATCODE,E.CDNAM,H.CDNAM,A.BGTMACT,A.BGTMM,A.BGTDIV	\n");	
						sql.append( " ORDER BY BGTMM,ATKORNAM,SATNM																		\n");

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