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
public class a080003_s11 extends HttpServlet {
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
				str[3] = req.getParameter("v_str4");	//예산본부

				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"ATCODE", "ATKORNAM","SATNM", "SATCODE",//"APPROVAL",
					"BGTMM01","CHGMM01","BGTMM02","CHGMM02",
					"BGTMM03","CHGMM03","BGTMM04","CHGMM04",
					"BGTMM05","CHGMM05","BGTMM06","CHGMM06",
					"BGTMM07","CHGMM07","BGTMM08","CHGMM08",
					"BGTMM09","CHGMM09","BGTMM10","CHGMM10",
					"BGTMM11","CHGMM11","BGTMM12","CHGMM12",
					"BGTSUM", "CHGSUM",
					"APPROVAL01","APPROVAL02","APPROVAL03","APPROVAL04",
					"APPROVAL05","APPROVAL06","APPROVAL07","APPROVAL08",
					"APPROVAL09","APPROVAL10","APPROVAL11","APPROVAL12"
				}; 

				int[] intArrCN = new int[] { 
					 7,  66,  40,		2,//  1,
					15,  15,  15,  15,   
					15,  15,  15,  15,   
					15,  15,  15,  15,   
					15,  15,  15,  15,   
					15,  15,  15,  15,
					15,  15,  15,  15,
					15,  15,
           1,   1,   1,   1,
           1,   1,   1,   1,
           1,   1,   1,   1
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,// -1,
					 0,   0,	 0,   0,
					 0,	  0,	 0,   0,
					 0,	  0,	 0,   0,
					 0,	  0,	 0,   0,
					 0,	  0,	 0,   0,
					 0,	  0,	 0,   0,
					 0,   0,
          -1,  -1,  -1,  -1,
          -1,  -1,  -1,  -1,
          -1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																																								\n");	
						sql.append( "  MAX(X.ATCODE) ATCODE, MAX(X.ATKORNAM) ATKORNAM,																			\n");	
						sql.append( "  MAX(X.CDNAM)  SATNM,	 MAX(X.SATCODE)  SATCODE,/*X.APPROVAL,*/												\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM01),0) BGTMM01,COALESCE(SUM(X.CHGMM01),0) CHGMM01,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM02),0) BGTMM02,COALESCE(SUM(X.CHGMM02),0) CHGMM02,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM03),0) BGTMM03,COALESCE(SUM(X.CHGMM03),0) CHGMM03,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM04),0) BGTMM04,COALESCE(SUM(X.CHGMM04),0) CHGMM04,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM05),0) BGTMM05,COALESCE(SUM(X.CHGMM05),0) CHGMM05,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM06),0) BGTMM06,COALESCE(SUM(X.CHGMM06),0) CHGMM06,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM07),0) BGTMM07,COALESCE(SUM(X.CHGMM07),0) CHGMM07,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM08),0) BGTMM08,COALESCE(SUM(X.CHGMM08),0) CHGMM08,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM09),0) BGTMM09,COALESCE(SUM(X.CHGMM09),0) CHGMM09,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM10),0) BGTMM10,COALESCE(SUM(X.CHGMM10),0) CHGMM10,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM11),0) BGTMM11,COALESCE(SUM(X.CHGMM11),0) CHGMM11,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM12),0) BGTMM12,COALESCE(SUM(X.CHGMM12),0) CHGMM12,								\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM01),0)+ COALESCE(SUM(X.BGTMM02),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM03),0)+ COALESCE(SUM(X.BGTMM04),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM05),0)+ COALESCE(SUM(X.BGTMM06),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM07),0)+ COALESCE(SUM(X.BGTMM08),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM09),0)+ COALESCE(SUM(X.BGTMM10),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.BGTMM11),0)+ COALESCE(SUM(X.BGTMM12),0) AS BGTSUM,										\n");	
						sql.append( "  COALESCE(SUM(X.CHGMM01),0)+ COALESCE(SUM(X.CHGMM02),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.CHGMM03),0)+ COALESCE(SUM(X.CHGMM04),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.CHGMM05),0)+ COALESCE(SUM(X.CHGMM06),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.CHGMM07),0)+ COALESCE(SUM(X.CHGMM08),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.CHGMM09),0)+ COALESCE(SUM(X.CHGMM10),0)+															\n");	
						sql.append( "  COALESCE(SUM(X.CHGMM11),0)+ COALESCE(SUM(X.CHGMM12),0) AS CHGSUM,										\n");					
						sql.append( "  MAX(X.APPROVAL01)APPROVAL01,MAX(X.APPROVAL02)APPROVAL02,MAX(X.APPROVAL03)APPROVAL03, \n");
						sql.append( "  MAX(X.APPROVAL04)APPROVAL04,MAX(X.APPROVAL05)APPROVAL05,MAX(X.APPROVAL06)APPROVAL06, \n");	
						sql.append( "  MAX(X.APPROVAL07)APPROVAL07,MAX(X.APPROVAL08)APPROVAL08,MAX(X.APPROVAL09)APPROVAL09, \n");	
						sql.append( "  MAX(X.APPROVAL10)APPROVAL10,MAX(X.APPROVAL11)APPROVAL11,MAX(X.APPROVAL12)APPROVAL12  \n");	
						sql.append( "  FROM (SELECT RTRIM(A.ATCODE) ATCODE, RTRIM(F.ATKORNAM) ATKORNAM,											\n");	
						sql.append( "  RTRIM(S.CDNAM) CDNAM,  /*세목명*/	  RTRIM(A.SATCODE)  SATCODE,/*A.APPROVAL,*/				\n");	
						sql.append( "  CASE WHEN A.BGTMM='01' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM01,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='01' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM01,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='02' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM02,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='02' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM02,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='03' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM03,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='03' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM03,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='04' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM04,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='04' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM04,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='05' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM05,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='05' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM05,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='06' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM06,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='06' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM06,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='07' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM07,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='07' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM07,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='08' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM08,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='08' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM08,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='09' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM09,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='09' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM09,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='10' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM10,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='10' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM10,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='11' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM11,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='11' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM11,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='12' THEN SUM(COALESCE(A.REALBGT,0)-COALESCE(A.BASICBGT,0)) END AS BGTMM12,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='12' THEN SUM(COALESCE(A.BASICBGT,0))  END AS CHGMM12,								\n");	
						sql.append( "  CASE WHEN A.BGTMM='01' THEN MAX(APPROVAL)  END AS APPROVAL01, \n");
						sql.append( "  CASE WHEN A.BGTMM='02' THEN MAX(APPROVAL)  END AS APPROVAL02, \n");	
						sql.append( "  CASE WHEN A.BGTMM='03' THEN MAX(APPROVAL)  END AS APPROVAL03, \n");	
						sql.append( "  CASE WHEN A.BGTMM='04' THEN MAX(APPROVAL)  END AS APPROVAL04, \n");	
						sql.append( "  CASE WHEN A.BGTMM='05' THEN MAX(APPROVAL)  END AS APPROVAL05, \n");
						sql.append( "  CASE WHEN A.BGTMM='06' THEN MAX(APPROVAL)  END AS APPROVAL06, \n");	
						sql.append( "  CASE WHEN A.BGTMM='07' THEN MAX(APPROVAL)  END AS APPROVAL07, \n");	
						sql.append( "  CASE WHEN A.BGTMM='08' THEN MAX(APPROVAL)  END AS APPROVAL08, \n");	
						sql.append( "  CASE WHEN A.BGTMM='09' THEN MAX(APPROVAL)  END AS APPROVAL09, \n");
						sql.append( "  CASE WHEN A.BGTMM='10' THEN MAX(APPROVAL)  END AS APPROVAL10, \n");	
						sql.append( "  CASE WHEN A.BGTMM='11' THEN MAX(APPROVAL)  END AS APPROVAL11, \n");	
						sql.append( "  CASE WHEN A.BGTMM='12' THEN MAX(APPROVAL)  END AS APPROVAL12  \n");	
						sql.append( "  FROM ACCOUNT.BGTDTL A																	 \n");	
						sql.append( "  LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE = F.ATCODE						\n");	

						sql.append( "  LEFT JOIN ACCOUNT.BGTMST C ON A.FDCODE=C.FDCODE AND A.BGTYY=C.BGTYY /*예산관리MST*/	\n");	
						sql.append( "        AND A.BGTDIV=C.BGTDIV   AND A.BGTDPT=C.BGTDPT  AND A.ATCODE=C.ATCODE						\n");	
						sql.append( "        AND A.FSREFCD=C.FSREFCD AND A.SATCODE=C.SATCODE																\n");	
						sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL S ON A.SATCODE=S.CDCODE AND A.FSREFCD=S.CMTYPE /*세목*/		\n");	
						sql.append( "  WHERE A.FDCODE IS NOT NULL  									\n");	
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'				\n");	//지점코드
						if(!str[1].equals("")) sql.append( " AND A.BGTYY   = '"+str[1]+"'				\n");	//예산년도
						if(!str[2].equals("")) sql.append( " AND A.BGTDPT  = '"+str[2]+"'				\n");	//예산부서
						if(!str[3].equals("")) sql.append( " AND A.BGTDIV  = '"+str[3]+"'				\n");	//예산본부
						sql.append( " GROUP BY A.ATCODE,F.ATKORNAM,S.CDNAM,A.SATCODE,A.BGTMM,A.INITBGT			\n");
						sql.append( ") X																														\n");
						sql.append( " GROUP BY X.ATCODE,X.ATKORNAM,X.CDNAM,X.SATCODE											\n");	
						sql.append( " ORDER BY ATKORNAM,SATNM																				\n");

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