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
public class a080001_s1 extends HttpServlet {
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
				str[2] = req.getParameter("v_str3");	//예산부서
				str[3] = req.getParameter("v_str4");	//관리항목
				str[4] = req.getParameter("v_str5");	//예산계정
				str[5] = req.getParameter("v_str6");	//세세목  
				str[6] = req.getParameter("v_str7");	//전년도  
				str[7] = req.getParameter("v_str8");	//예산분류

				for(int i=0;i<=7;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","BGTYY","BGTMM","BGTDIV","BGTDPT",
					"ATCODE","FSREFCD","SATCODE","BGTTYPE","BGTMACT",
					"INITMAN","INITBGT","CHGMAN","CHGBGT","BASICBGT",
					"ADDBGT","CHGABGT","CHGTBGT","REALBGT","RESULTS",
					"BRESULTS","APPROVAL","CHGAPPROV","REMARK","BCHGMAN2",
					"BINITBGT2","BRESULTS2","SATNM","ATKORNAM"
				}; 

				int[] intArrCN = new int[] { 
					 2,   4,   2,   4,   4,   
					 7,		4,   2,   1,   2,   
					 4,	 15,   4,	 15,  15,
					15,  15,  15,  15,  15,
					15,		1,	 1,  40,  15,
					15,  15,  40,  66
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					 0,   0,	 0,   0,   0,
					 0,	  0,	 0,   0,   0,   
					 0,	 -1,	-1,  -1,   0,
					 0,   0,  -1,  -1  
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT															\n");	
						sql.append( " RTRIM(A.FDCODE)  FDCODE,          /*지점코드*/						\n");
						sql.append( " RTRIM(A.BGTYY)   BGTYY,           /*예산년도*/						\n");
						sql.append( " RTRIM(A.BGTMM)   BGTMM,           /*예산월*/						\n");
						sql.append( " RTRIM(A.BGTDIV)  BGTDIV,          /*예산본부*/						\n");
						sql.append( " RTRIM(A.BGTDPT)  BGTDPT,          /*예산부서*/						\n");
						sql.append( " RTRIM(A.ATCODE)  ATCODE,          /*계정코드*/						\n");
						sql.append( " RTRIM(A.FSREFCD) FSREFCD,         /*관리항목코드*/				    \n");
						sql.append( " RTRIM(A.SATCODE) SATCODE,         /*세목*/							\n");
						sql.append( " RTRIM(A.BGTTYPE) BGTTYPE,         /*관리타입*/						\n");
						sql.append( " RTRIM(A.BGTMACT) BGTMACT,         /*예산타입*/						\n");
						sql.append( " COALESCE(A.INITMAN,0) INITMAN,    /*당초인원*/						\n");
						sql.append( " COALESCE(A.INITBGT,0) INITBGT,    /*당초예산*/						\n");
						sql.append( " COALESCE(A.CHGMAN,0)  CHGMAN,			/*변동인원*/			\n");
						sql.append( " COALESCE(A.CHGBGT,0)  CHGBGT,			/*변동예산*/			\n");
						sql.append( " COALESCE(A.BASICBGT,0) BASICBGT,  /*기본예산*/				\n");
						sql.append( " COALESCE(A.ADDBGT,0)  ADDBGT,			/*추가전용*/			\n");
						sql.append( " COALESCE(A.CHGABGT,0) CHGABGT,    /*항목전용*/				\n");
						sql.append( " COALESCE(A.CHGTBGT,0) CHGTBGT,    /*기간예산*/				\n");
						sql.append( " COALESCE(A.REALBGT,0) REALBGT,    /*실행예산*/				\n");
						sql.append( " COALESCE(A.RESULTS,0) RESULTS,    /*실적*/   				\n");
						sql.append( " COALESCE(A.BRESULTS,0) BRESULTS,  /*결재전실적*/   			\n");
						sql.append( " RTRIM(A.APPROVAL) APPROVAL,				/*승인구분*/   	\n");
						sql.append( " RTRIM(A.CHGAPPROV) CHGAPPROV,			/*변동예산승인*/ 	    \n");
						sql.append( " RTRIM(A.REMARK) REMARK,						/*산출근거*/  \n");
						sql.append( " COALESCE(X.BCHGMAN,0)  BCHGMAN2,	/*전기인원*/				\n");
						sql.append( " COALESCE(X.BINITBGT,0) BINITBGT2,	/*전기예산*/				\n");
						sql.append( " COALESCE(X.BRESULTS,0) BRESULTS2,	/*전기실적*/				\n");
						sql.append( " RTRIM(S.CDNAM) SATNM,							/*세목명*/	\n");
						sql.append( " RTRIM(F.ATKORNAM) ATKORNAM				/*계정과목명*/		\n");
						sql.append( " FROM ACCOUNT.BGTDTL A, ACCOUNT.ACTCODE F, /*예산관리DTL*/											   \n");
						sql.append( "      ACCOUNT.COMMDTIL S,  /*세목*/                                                                    \n");
						sql.append( " 	   ACCOUNT.BGTMST C,    /*예산관리MST*/                                                              \n");
						sql.append( "      ( SELECT E.FDCODE,E.BGTYY,E.BGTMM,E.BGTDIV,                                   	               \n");
						sql.append( "               E.BGTDPT,E.ATCODE,E.FSREFCD,E.SATCODE,                            		               \n");
						sql.append( "               CASE WHEN E.CHGMAN=0 THEN E.INITMAN ELSE E.CHGMAN END AS BCHGMAN, /*전기인원*/    	   \n");
						sql.append( "               COALESCE(E.INITBGT,0) BINITBGT,/*전기예산*/                       		               \n");
						sql.append( "               COALESCE(E.RESULTS,0) BRESULTS /*전기실적*/                       		               \n");
						sql.append( "          FROM ACCOUNT.BGTDTL E                                                    	               \n");
						sql.append( "          LEFT JOIN ACCOUNT.BGTMST K ON E.FDCODE=K.FDCODE AND E.BGTYY=K.BGTYY  		               \n");
						sql.append( "                                    AND E.BGTDIV=K.BGTDIV AND E.BGTDPT=K.BGTDPT AND E.ATCODE=K.ATCODE \n");
						sql.append( "                                    AND E.FSREFCD=K.FSREFCD AND E.SATCODE=K.SATCODE                   \n");
						sql.append( "         WHERE E.FDCODE IS NOT NULL							\n");
						if(!str[0].equals("")) sql.append( " AND E.FDCODE  = '"+str[0]+"'	\n");	//지점코드
						if(!str[6].equals("")) sql.append( " AND E.BGTYY   = '"+str[6]+"'	\n");	//전년도
						if(!str[2].equals("")) sql.append( " AND E.BGTDPT  = '"+str[2]+"'	\n");	//예산부서
						if(!str[3].equals("")) sql.append( " AND E.FSREFCD = '"+str[3]+"'	\n");	//관리항목
						if(!str[4].equals("")) sql.append( " AND E.ATCODE  = '"+str[4]+"'	\n");	//예산계정
						if(!str[5].equals("")) sql.append( " AND E.SATCODE = '"+str[5]+"'	\n");	//세세목
						sql.append( "    	)X \n");
						
						sql.append( " WHERE A.FDCODE IS NOT NULL AND A.ATCODE = F.ATCODE				\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'	\n");	//지점코드
						if(!str[1].equals("")) sql.append( " AND A.BGTYY   = '"+str[1]+"' \n");	//예산년도
						if(!str[2].equals("")) sql.append( " AND A.BGTDPT  = '"+str[2]+"'	\n");	//예산부서
						if(!str[3].equals("")) sql.append( " AND A.FSREFCD = '"+str[3]+"'	\n");	//관리항목
						if(!str[4].equals("")) sql.append( " AND A.ATCODE  = '"+str[4]+"'	\n");	//예산계정
						if(!str[5].equals("")) sql.append( " AND A.SATCODE = '"+str[5]+"'	\n");	//세세목
						sql.append( "  AND A.SATCODE=S.CDCODE(+) AND A.FSREFCD=S.CMTYPE(+)   	\n");
						sql.append( "  AND A.FDCODE=C.FDCODE(+)  AND A.BGTYY=C.BGTYY(+)   AND A.BGTDIV=C.BGTDIV(+)   \n");
						sql.append( "  AND A.BGTDPT=C.BGTDPT(+)	 AND A.ATCODE=C.ATCODE(+) AND A.FSREFCD=C.FSREFCD(+) AND A.SATCODE=C.SATCODE(+)			\n");
						sql.append( "  AND A.BGTMM=X.BGTMM(+)	\n");
						sql.append( " ORDER BY BGTYY,BGTMM	\n");

						//System.out.println("a080001_s1 : \n" + sql.toString());		
						//logger.dbg.println(this,sql.toString() );
		
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