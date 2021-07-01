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
public class a050001_s1 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//지점
				String  str2 = req.getParameter("v_str2");	//년도
				String  str3 = req.getParameter("v_str3");	//기수기간from
				String  str4 = req.getParameter("v_str4");	//기수기간from
				String  str5 = req.getParameter("v_str5");	//매입/매출 구분

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","TAXYY",  "TAXKIDIV","TAXIODIV","TAXDIV",
					"TAXKND","TAXDAT",  "WRDT","VEND_CD","VEND_ID",
					"VEND_NM","VD_DIRECT","ADDRESS1","BSNS_CND","BSNS_KND",
					"TAXTERMFR","TAXTERMTO","SHTCNT","BLKCNT","TAXSUM",
					"TAXVATAMT"
				}; 

				int[] intArrCN = new int[]{
					 2,  4,  1,  1,  2,
					 1,  8,  8, 13, 13,
					30, 62,132, 62, 62,
					 8,  8,  7,  2, 15,
					13
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1, 
					-1, -1, -1, -1, -1, 
				  -1, -1, -1, -1, -1, 
					-1, -1,  0,  0,  0, 
					 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					String year = str3.substring(0,4);
					
/*					
					sql.append( " SELECT MAX(X.COCODE) FDCODE,MAX(X.TAXYY) TAXYY,MAX(X.TAXKIDIV) TAXKIDIV,									\n");
					sql.append( " 			 MAX(X.TAXIODIV) TAXIODIV,MAX(X.TAXDIV) TAXDIV,MAX(X.TAXKND) TAXKND,								\n");
					sql.append( " 			 MAX(X.TAXDAT) TAXDAT,MAX(X.WRDT) WRDT,RTRIM(X.VEND_CD) VEND_CD,										\n");
					sql.append( " 			 RTRIM(X.VEND_ID) VEND_ID,RTRIM(X.VEND_NM) VEND_NM,RTRIM(X.VD_DIRECT) VD_DIRECT,		\n");
					sql.append( " 			 RTRIM(X.ADDRESS1) ADDRESS1,RTRIM(X.BSNS_CND) BSNS_CND,RTRIM(X.BSNS_KND) BSNS_KND,	\n");
					sql.append( " 			 RTRIM(X.TAXTERMFR) TAXTERMFR,RTRIM(X.TAXTERMTO) TAXTERMTO,COUNT(X.SHTCNT) SHTCNT,	\n");
					sql.append( " 			 14-LENGTH(VARCHAR(SUM(X.TAXSUM))) BLKCNT,SUM(X.TAXSUM) TAXSUM,SUM(X.TAXVATAMT)	TAXVATAMT	\n");
					sql.append( " FROM(SELECT																							\n");
					sql.append( " RTRIM(A.COCODE)      COCODE,    --지점									\n");
					sql.append( " SUBSTR(A.TAXDAT,1,4) TAXYY,     --년도									\n");
					sql.append( " RTRIM(A.TAXKIDIV)    TAXKIDIV,  --기수									\n");
					sql.append( " RTRIM(A.TAXIODIV)    TAXIODIV,  --계산서구분						\n");
					sql.append( " RTRIM(A.TAXDIV)      TAXDIV,    --귀속구분							\n");
					sql.append( " RTRIM(A.TAXKND)      TAXKND,    --계산서종류						\n");
					sql.append( " RTRIM(A.TAXDAT)      TAXDAT,    --계산서일자						\n");
					sql.append( " RTRIM(A.WRDT)        WRDT,      --작성일자							\n");
					sql.append( " RTRIM(A.VEND_CD)     VEND_CD,   --거래처코드						\n");
					sql.append( " RTRIM(B.VEND_ID)     VEND_ID,   --등록번호							\n");
					sql.append( " RTRIM(B.VEND_NM)     VEND_NM,   --상호									\n");
					sql.append( " RTRIM(B.VD_DIRECT)   VD_DIRECT, --대표자명							\n");
					sql.append( " RTRIM(B.ADDRESS1)    ADDRESS1,  --사업장주소						\n");
					sql.append( " RTRIM(B.BSNS_CND)    BSNS_CND,  --업태									\n");
					sql.append( " RTRIM(B.BSNS_KND)    BSNS_KND,  --종목									\n");
					sql.append( " CASE WHEN A.TAXKIDIV='1' THEN '"+year+"0101'						\n");
					sql.append( " 		 WHEN A.TAXKIDIV='2' THEN '"+year+"0401'						\n");
					sql.append( " 		 WHEN A.TAXKIDIV='3' THEN '"+year+"0701'						\n");
					sql.append( " 		 WHEN A.TAXKIDIV='4' THEN '"+year+"1001' END AS TAXTERMFR, --거래기간FR \n");
					sql.append( " CASE WHEN A.TAXKIDIV='1' THEN '"+year+"0331'						\n");
					sql.append( " 		 WHEN A.TAXKIDIV='2' THEN '"+year+"0630'						\n");
					sql.append( " 		 WHEN A.TAXKIDIV='3' THEN '"+year+"0930'						\n");
					sql.append( " 		 WHEN A.TAXKIDIV='4' THEN '"+year+"1231' END AS TAXTERMTO, --거래기간TO	\n");
					sql.append( " COUNT(B.VEND_ID)  AS SHTCNT,				--매수							\n");
					sql.append( " 0 AS BLKCNT,												--공란수						\n");
					sql.append( " nvl(A.TAXSUM,0) TAXSUM,					--공급가액					\n");
					sql.append( " nvl(A.TAXVATAMT,0) TAXVATAMT			--세액							\n");
					sql.append( " FROM ACCOUNT.ATTAXMST A							--신고서매입자료		\n");
					sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD=B.VEND_CD	\n");
					sql.append( " WHERE B.VEND_ID <>''																		\n");
					if(!str1.equals(""))  sql.append( " AND A.COCODE = '"+str1+"'					\n");
					if(!str2.equals(""))  sql.append( " AND SUBSTR(A.TAXDAT,1,4) ='"+str2+"'					\n");
					if(!str3.equals(""))  sql.append( " AND A.TAXDAT BETWEEN '"+str3+"' AND '"+str4+"'	\n");
					if(!str5.equals(""))  sql.append( " AND A.TAXIODIV = '"+str5+"'		\n");
					if(str5.equals("A")) sql.append( " AND A.TAXKND IN ('1','2','4')	\n");    //매입 과세구분 2007.12.27 정영식 현금영수증 7 추가 ==> 현금영수증,카드는 따로 신고하기 때문에 사용안함.
					if(str5.equals("B")) sql.append( " AND A.TAXKND IN ('1','2')			\n");    //매출 과세구분
					sql.append( " AND A.GUBUN <> '1' 	\n");    //전자세금계산서 발행/수취분이 아닌 건
					sql.append( " GROUP BY A.COCODE,SUBSTR(A.TAXDAT,1,4),A.TAXKIDIV,A.TAXIODIV,		\n");
					sql.append( "					 A.TAXDIV,A.TAXKND,A.TAXDAT,A.WRDT,A.VEND_CD,B.VEND_ID,	\n");
					sql.append( "  				 B.VEND_NM,B.VD_DIRECT,B.ADDRESS1,B.BSNS_CND,B.BSNS_KND,A.TAXSUM,A.TAXVATAMT,A.TAXNBR	\n");
					sql.append( " ) X																															\n");
					sql.append( " GROUP BY X.VEND_CD,X.VEND_ID,X.VEND_NM,X.VD_DIRECT,X.ADDRESS1,	\n");
					sql.append( " X.BSNS_CND,X.BSNS_KND,X.TAXTERMFR,X.TAXTERMTO										\n");
					sql.append( " ORDER BY VEND_ID																								\n");
*/
					sql.append( " SELECT MAX(X.COCODE) FDCODE,MAX(X.TAXYY) TAXYY,MAX(X.TAXKIDIV) TAXKIDIV,										\n");
					sql.append( " 			 MAX(X.TAXIODIV) TAXIODIV,MAX(X.TAXDIV) TAXDIV,MAX(X.TAXKND) TAXKND,										\n");
					sql.append( " 			 MAX(X.TAXDAT) TAXDAT,MAX(X.WRDT) WRDT,RTRIM(X.VEND_CD) VEND_CD,										\n");
					sql.append( " 			 RTRIM(X.VEND_ID) VEND_ID,RTRIM(X.VEND_NM) VEND_NM,RTRIM(X.VD_DIRECT) VD_DIRECT,					\n");
					sql.append( " 			 RTRIM(X.ADDRESS1) ADDRESS1,RTRIM(X.BSNS_CND) BSNS_CND,RTRIM(X.BSNS_KND) BSNS_KND,		\n");
					sql.append( " 			 RTRIM(X.TAXTERMFR) TAXTERMFR,RTRIM(X.TAXTERMTO) TAXTERMTO,COUNT(X.SHTCNT) SHTCNT,		\n");
					sql.append( " 			 14-LENGTH(SUM(X.TAXSUM)) BLKCNT,SUM(X.TAXSUM) TAXSUM,SUM(X.TAXVATAMT)	TAXVATAMT		\n");
					sql.append( " FROM(SELECT																			\n");
					sql.append( " RTRIM(A.COCODE)      COCODE,    --지점									\n");
					sql.append( " SUBSTR(A.TAXDAT,1,4) TAXYY,     --년도										\n");
					sql.append( " RTRIM(A.TAXKIDIV)    TAXKIDIV,  --기수											\n");
					sql.append( " RTRIM(A.TAXIODIV)    TAXIODIV,  --계산서구분								\n");
					sql.append( " RTRIM(A.TAXDIV)      TAXDIV,    --귀속구분									\n");
					sql.append( " RTRIM(A.TAXKND)      TAXKND,    --계산서종류								\n");
					sql.append( " RTRIM(A.TAXDAT)      TAXDAT,    --계산서일자								\n");
					sql.append( " RTRIM(A.WRDT)        WRDT,      --작성일자									\n");
					sql.append( " RTRIM(A.VEND_CD)     VEND_CD,   --거래처코드							\n");
					sql.append( " RTRIM(B.VEND_ID)     VEND_ID,   --등록번호									\n");
					sql.append( " RTRIM(B.VEND_NM)     VEND_NM,   --상호									\n");
					sql.append( " RTRIM(B.VD_DIRECT)   VD_DIRECT, --대표자명								\n");
					sql.append( " RTRIM(B.ADDRESS1)    ADDRESS1,  --사업장주소						\n");
					sql.append( " RTRIM(B.BSNS_CND)    BSNS_CND,  --업태									\n");
					sql.append( " RTRIM(B.BSNS_KND)    BSNS_KND,  --종목									\n");
					sql.append( " CASE WHEN A.TAXKIDIV='1' THEN '"+year+"0101'							\n");
					sql.append( " 		 WHEN A.TAXKIDIV='2' THEN '"+year+"0401'								\n");
					sql.append( " 		 WHEN A.TAXKIDIV='3' THEN '"+year+"0701'								\n");
					sql.append( " 		 WHEN A.TAXKIDIV='4' THEN '"+year+"1001' END AS TAXTERMFR, --거래기간FR \n");
					sql.append( " CASE WHEN A.TAXKIDIV='1' THEN '"+year+"0331'									\n");
					sql.append( " 		 WHEN A.TAXKIDIV='2' THEN '"+year+"0630'										\n");
					sql.append( " 		 WHEN A.TAXKIDIV='3' THEN '"+year+"0930'										\n");
					sql.append( " 		 WHEN A.TAXKIDIV='4' THEN '"+year+"1231' END AS TAXTERMTO, --거래기간TO	\n");
					sql.append( " COUNT(B.VEND_ID)  AS SHTCNT,				--매수								\n");
					sql.append( " 0 AS BLKCNT,												--공란수						\n");
					sql.append( " nvl(A.TAXSUM,0) TAXSUM,					--공급가액									\n");
					sql.append( " nvl(A.TAXVATAMT,0) TAXVATAMT			--세액										\n");
					sql.append( " FROM ACCOUNT.ATTAXMST A							--신고서매입자료		\n");
					sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD=B.VEND_CD			\n");
					sql.append( " WHERE B.VEND_ID IS NOT NULL															\n");
					
					//if(!str1.equals(""))  sql.append( " AND A.COCODE = '"+str1+"'										\n");
					if(!str1.equals(""))  sql.append( " AND A.COCODE IN ('01','02','04')							\n");
					if(!str2.equals(""))  sql.append( " AND SUBSTR(A.TAXDAT,1,4) ='"+str2+"'						\n");
					if(!str3.equals(""))  sql.append( " AND A.TAXDAT BETWEEN '"+str3+"' AND '"+str4+"'			\n");
					if(!str5.equals(""))  sql.append( " AND A.TAXIODIV = '"+str5+"'										\n");
					if(str5.equals("A")) sql.append( " AND A.TAXKND IN ('1','2','4')									\n");    //매입 과세구분 2007.12.27 정영식 현금영수증 7 추가 ==> 현금영수증,카드는 따로 신고하기 때문에 사용안함.
					if(str5.equals("B")) sql.append( " AND A.TAXKND IN ('1','2')											\n");    //매출 과세구분
					sql.append( " AND A.GUBUN <> '1' 																		\n");    //전자세금계산서 발행/수취분이 아닌 건
					sql.append( " GROUP BY A.COCODE,SUBSTR(A.TAXDAT,1,4),A.TAXKIDIV,A.TAXIODIV,		\n");
					sql.append( "					 A.TAXDIV,A.TAXKND,A.TAXDAT,A.WRDT,A.VEND_CD,B.VEND_ID,	\n");
					sql.append( "  				 B.VEND_NM,B.VD_DIRECT,B.ADDRESS1,B.BSNS_CND,B.BSNS_KND,A.TAXSUM,A.TAXVATAMT,A.TAXNBR	\n");
					sql.append( " ) X																														\n");
					sql.append( " GROUP BY X.VEND_CD,X.VEND_ID,X.VEND_NM,X.VD_DIRECT,X.ADDRESS1,					\n");
					sql.append( " X.BSNS_CND,X.BSNS_KND,X.TAXTERMFR,X.TAXTERMTO											\n");
					sql.append( " ORDER BY VEND_ID																								\n");
					
					
					//System.out.println("a050001_s1: " + sql.toString());	
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