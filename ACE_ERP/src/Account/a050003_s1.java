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
public class a050003_s1 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//사업소         
				str[1] = req.getParameter("v_str2");	//신고일자       
				str[2] = req.getParameter("v_str3");	//신고년도       
				str[3] = req.getParameter("v_str4");	//기수구분       
				str[4] = req.getParameter("v_str5");	//신고구분
				str[5] = req.getParameter("v_str6");	//신고일자 
				str[6] = req.getParameter("v_str7");	//현재일자fr       
				str[7] = req.getParameter("v_str8");	//현재일자to     

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"COCODE","VATYY","GISU","GUBUN","COROWNO","REPORTDT",
					"CONAME","COPRNAME","COREGNO","TEL1","TEL2",
					"ADDR","BANKCD","BANNAM","BRANCH","ACCTNO","CLOSEDAY","CLOSERSN",
					"SEMUNAME","MANAGENO","SEMUTEL","SBILLAMT","RBILLAMT",
					"TAXDATE","CURDT",
					"UPTAE22","JONGMOK22","UPCODE22","AMOUNT22",
					"UPTAE23","JONGMOK23","UPCODE23","AMOUNT23",
					"UPTAE24","JONGMOK24","UPCODE24","AMOUNT24",
					"JONGMOK25","UPCODE25","AMOUNT25","AMOUNT26",
					
					"UPTAE57","JONGMOK57","UPCODE57","AMOUNT57",
					"UPTAE58","JONGMOK58","UPCODE58","AMOUNT58","AMOUNT59",
					
					"TAX0001","STAX0001","TAX0002","STAX0002","TAX0003","STAX0003","TAX0004","STAX0004","TAX0005","STAX0005", 					
					"TAX0006","STAX0006","TAX0007","STAX0007","TAX0008","STAX0008","TAX0009","STAX0009","TAX0010","STAX0010",
					"TAX0011","STAX0011","TAX0012","STAX0012","TAX0013","STAX0013","TAX0014","STAX0014","TAX0015","STAX0015",
					"TAX0016","STAX0016","TAX0017","STAX0017","TAX0018","STAX0018","TAX0019","STAX0019","TAX0020","STAX0020",
					"TAX0021","STAX0021","TAX0022","STAX0022","TAX0023","STAX0023","TAX0024","STAX0024","TAX0025","STAX0025",
					"TAX0026","STAX0026","TAX0027","STAX0027","TAX0028","STAX0028","TAX0029","STAX0029","TAX0030","STAX0030",
					"TAX0031","STAX0031","TAX0032","STAX0032","TAX0033","STAX0033","TAX0034","STAX0034","TAX0035","STAX0035",
					"TAX0036","STAX0036","TAX0037","STAX0037","TAX0038","STAX0038","TAX0039","STAX0039","TAX0040","STAX0040",
					"TAX0041","STAX0041","TAX0042","STAX0042","TAX0043","STAX0043","TAX0044","STAX0044","TAX0045","STAX0045",
					"TAX0046","STAX0046","TAX0047","STAX0047","TAX0048","STAX0048","TAX0049","STAX0049","TAX0050","STAX0050",
					"TAX0051","STAX0051","TAX0052","STAX0052","TAX0053","STAX0053"
				}; 
												
				int[] intArrCN = new int[] { 
					 2,   4,   1,   1,  13,   8,
					32,  12,  10,  14,  14,
					72,   5,  50,  20,  22,  12, 20,
					12,  10,  14,  15,  15,
					13,   8,
					20,  20,   6,  15,
					20,  20,   6,  15,
					20,  20,   6,  15,
					20,   6,  15,  15,

					20,  20,   6,  15,
					20,  20,   6,  15, 15,

					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15,  15,  15,  15,  15,
					15,  15,  15,  15,  15,	 15
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,	 -1,
					-1,  -1,  -1,  -1,  -1, 
					-1,  -1,  -1,  -1,  -1,  -1,	-1, 
					-1,  -1,  -1,   0,	 0, 
					-1,  -1,  
					-1,  -1,  -1,   0,
					-1,  -1,  -1,   0,
					-1,  -1,  -1,   0,
					-1,  -1,   0,   0,
					
					-1,  -1,  -1,   0,
					-1,  -1,  -1,   0,   0,

					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0,   0,   0,   0,   0,  
					 0,   0,   0,   0,   0,		0 
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT X.COCODE, X.VATYY, X.GISU, X.GUBUN,X.COROWNO,X.REPORTDT,			\n");
						sql.append( " X.COROWNO,  --주민(법인)등록번호																		\n");
						sql.append( " X.CONAME,   --상호																									\n");
						sql.append( " X.COPRNAME, --성명(대표자)																					\n");
						sql.append( " X.COREGNO,  --사업자등록번호																				\n");
						sql.append( " X.TEL1,     --전화(사업장)																					\n");
						sql.append( " X.TEL2,     --전화(주소지)																					\n");
						sql.append( " X.ADDR,     --사업장주소																						\n");
						sql.append( " X.BANKCD,   --거래은행																							\n");
						sql.append( " X.BANNAM,   --거래은행명																						\n");
						sql.append( " X.BRANCH,   --거래은행지점명																				\n");
						sql.append( " X.ACCTNO,   --계좌번호																							\n");
						sql.append( " X.CLOSEDAY, --폐업일자																							\n");
						sql.append( " X.CLOSERSN, --폐업사유																							\n");
						sql.append( " X.SEMUNAME, --세무대리인(성명)																			\n");
						sql.append( " X.MANAGENO, --세무대리인(사업자등록번호)														\n");
						sql.append( " X.SEMUTEL,  --세무대리인(전화)																			\n");
						sql.append( " X.SBILLAMT, --계산서교부금액																				\n");
						sql.append( " X.RBILLAMT, --계산서수취금액																				\n");
						sql.append( " X.TAXDATE,  --신고기간																							\n");
						sql.append( " X.CURDT,    --현재일자																							\n");
						sql.append( " MAX(X.UPTAE22)   UPTAE22,  --업태(22)                               \n");
						sql.append( " MAX(X.JONGMOK22) JONGMOK22,--종목(22)                               \n");
						sql.append( " MAX(X.UPCODE22)  UPCODE22, --업종코드(22)                           \n");
						sql.append( " MAX(X.AMOUNT22)  AMOUNT22, --금액(22)                               \n");
						sql.append( " MAX(X.UPTAE23)	 UPTAE23,  MAX(X.JONGMOK23) JONGMOK23, 							\n");
						sql.append( " MAX(X.UPCODE23) UPCODE23, MAX(X.AMOUNT23) AMOUNT23, 								\n");
						sql.append( " MAX(X.UPTAE24) UPTAE24,MAX(X.JONGMOK24) JONGMOK24,									\n");
						sql.append( " MAX(X.UPCODE24) UPCODE24,MAX(X.AMOUNT24) AMOUNT24,									\n");
						sql.append( " MAX(X.JONGMOK25) JONGMOK25,MAX(X.UPCODE25) UPCODE25,								\n");
						sql.append( " MAX(X.AMOUNT25) AMOUNT25,MAX(X.AMOUNT26) AMOUNT26,									\n");
						sql.append( " MAX(X.UPTAE57) UPTAE57,MAX(X.JONGMOK57) JONGMOK57,									\n");
						sql.append( " MAX(X.UPCODE57) UPCODE57,MAX(X.AMOUNT57) AMOUNT57,									\n");
						sql.append( " MAX(X.UPTAE58) UPTAE58,MAX(X.JONGMOK58) JONGMOK58,									\n");
						sql.append( " MAX(X.UPCODE58) UPCODE58,MAX(X.AMOUNT58) AMOUNT58,MAX(X.AMOUNT59) AMOUNT59,	\n");

					for(int i=1;i<=52;i++) {	
						if (i<10) { 
							sql.append( "	MAX(X.TAX000"+i+") TAX000"+i+",MAX(X.STAX000"+i+") STAX000"+i+",	\n");
						}else {
							sql.append( "	MAX(X.TAX00"+i+") TAX00"+i+",MAX(X.STAX00"+i+") STAX00"+i+",			\n");
						}
						if (i==52) {
							sql.append( "	MAX(X.TAX0053) TAX0053,MAX(X.STAX0053) STAX0053										\n");
							sql.append( " FROM (SELECT B.COCODE,B.VATYY,B.GISU,B.GUBUN,E.COROWNO,A.REPORTDT,\n");
							sql.append( "				A.CONAME,A.COPRNAME,A.COREGNO,A.TEL1,A.TEL2,								\n");
							sql.append( "				A.ADDR,A.BANKCD,F.BANNAM,A.BRANCH,A.ACCTNO,A.CLOSEDAY,A.CLOSERSN,\n");
							sql.append( "				A.SEMUNAME,A.MANAGENO,A.SEMUTEL,A.SBILLAMT,A.RBILLAMT,			\n");
							sql.append( "				'"+str[5]+"' AS TAXDATE,'"+str[6]+"' AS CURDT,							\n");
							sql.append( "				CASE WHEN C.SEQNO='1' THEN C.UPTAE END AS UPTAE22,					\n");
							sql.append( "				CASE WHEN C.SEQNO='1' THEN C.JONGMOK END AS JONGMOK22,			\n");
							sql.append( "				CASE WHEN C.SEQNO='1' THEN C.UPCODE END AS UPCODE22,				\n");
							sql.append( "				CASE WHEN C.SEQNO='1' THEN C.AMOUNT END AS AMOUNT22,				\n");
							sql.append( "				CASE WHEN C.SEQNO='2' THEN C.UPTAE END AS UPTAE23,					\n");
							sql.append( "				CASE WHEN C.SEQNO='2' THEN C.JONGMOK END AS JONGMOK23,			\n");
							sql.append( "				CASE WHEN C.SEQNO='2' THEN C.UPCODE END AS UPCODE23,				\n");
							sql.append( "				CASE WHEN C.SEQNO='2' THEN C.AMOUNT END AS AMOUNT23,				\n");
							sql.append( "				CASE WHEN C.SEQNO='3' THEN C.UPTAE END AS UPTAE24,					\n");
							sql.append( "				CASE WHEN C.SEQNO='3' THEN C.JONGMOK END AS JONGMOK24,			\n");
							sql.append( "				CASE WHEN C.SEQNO='3' THEN C.UPCODE END AS UPCODE24,				\n");
							sql.append( "				CASE WHEN C.SEQNO='3' THEN C.AMOUNT END AS AMOUNT24,				\n");
							sql.append( "				CASE WHEN C.SEQNO='4' THEN C.JONGMOK END AS JONGMOK25,			\n");
							sql.append( "				CASE WHEN C.SEQNO='4' THEN C.UPCODE END AS UPCODE25,				\n");
							sql.append( "				CASE WHEN C.SEQNO='4' THEN C.AMOUNT END AS AMOUNT25,				\n");
							sql.append( "				CASE WHEN C.SEQNO='5' THEN C.AMOUNT END AS AMOUNT26,				\n");
							sql.append( "				CASE WHEN D.SEQNO='1' THEN D.UPTAE   END AS UPTAE57,				\n");
							sql.append( "				CASE WHEN D.SEQNO='1' THEN D.JONGMOK END AS JONGMOK57,			\n");
							sql.append( "				CASE WHEN D.SEQNO='1' THEN D.UPCODE  END AS UPCODE57,				\n");
							sql.append( "				CASE WHEN D.SEQNO='1' THEN D.AMOUNT  END AS AMOUNT57,				\n");
							sql.append( "				CASE WHEN D.SEQNO='2' THEN D.UPTAE   END AS UPTAE58,				\n");
							sql.append( "				CASE WHEN D.SEQNO='2' THEN D.JONGMOK END AS JONGMOK58,			\n");
							sql.append( "				CASE WHEN D.SEQNO='2' THEN D.UPCODE  END AS UPCODE58,				\n");
							sql.append( "				CASE WHEN D.SEQNO='2' THEN D.AMOUNT  END AS AMOUNT58,				\n");
							sql.append( "				CASE WHEN D.SEQNO='3' THEN D.AMOUNT  END AS AMOUNT59,				\n");
						}
					}
					
					for(int i=1;i<=52;i++) {	
						if (i<10) { 
							sql.append( " CASE WHEN B.VATCD='000"+i+"' THEN nvl(B.SALESAMT,0) END AS TAX000"+i+",	\n");
							sql.append( " CASE WHEN B.VATCD='000"+i+"' THEN nvl(B.VATAMT,0)	 END AS STAX000"+i+",	\n");
						}else {
							sql.append( " CASE WHEN B.VATCD='00"+i+"' THEN nvl(B.SALESAMT,0) END AS TAX00"+i+",		\n");
							sql.append( " CASE WHEN B.VATCD='00"+i+"' THEN nvl(B.VATAMT,0)	  END AS STAX00"+i+",		\n");
						}
					}
						sql.append( "		CASE WHEN B.VATCD='0053' THEN nvl(B.SALESAMT,0) END AS TAX0053,					\n");
						sql.append( "   CASE WHEN B.VATCD='0053' THEN nvl(B.VATAMT,0)   END AS STAX0053					\n");
						sql.append( " FROM ACCOUNT.VATMST A, ACCOUNT.VATDTL B															\n");
						sql.append( " 	LEFT JOIN ACCOUNT.TAXSTD C ON A.COCODE=C.COCODE AND A.VATYY=C.VATYY	AND A.GISU=C.GISU AND A.GUBUN=C.GUBUN			\n");
						sql.append( "	LEFT JOIN ACCOUNT.FREETAXAMT D ON A.COCODE=D.COCODE	AND A.VATYY=D.VATYY AND A.GISU=D.GISU AND A.GUBUN=D.GUBUN \n");
						sql.append( "	LEFT JOIN ACCOUNT.COMPANY E ON A.COCODE=E.COCODE										\n");
						sql.append( "	LEFT JOIN ACCOUNT.BANKCODE F ON A.BANKCD=F.BANCOD										\n");
						sql.append( " WHERE A.COCODE=B.COCODE AND A.VATYY=B.VATYY AND A.GISU=B.GISU AND A.GUBUN=B.GUBUN	\n");
						sql.append( " ) X																																	\n");
						sql.append( " WHERE X.COCODE IS NOT NULL																								\n");
						if(!str[0].equals("")) sql.append( " AND X.COCODE='"+str[0]+"'			/*사업소*/		\n");
						if(!str[1].equals("")) sql.append( " AND X.VATYY='"+str[1]+"'				/*신고년도*/	\n");
						if(!str[2].equals("")) sql.append( " AND X.GISU='"+str[2]+"'				/*기수*/			\n");
						if(!str[3].equals("")) sql.append( " AND X.GUBUN='"+str[3]+"'				/*신고구분*/	\n");
						if(!str[4].equals("")) sql.append( " AND X.REPORTDT='"+str[4]+"'		/*신고일자*/	\n");
						sql.append( " GROUP BY X.COCODE, X.VATYY, X.GISU, X.GUBUN,X.COROWNO,X.REPORTDT,		\n");
						sql.append( " X.CONAME,X.COPRNAME,X.COREGNO,X.TEL1,X.TEL2,												\n");
						sql.append( " X.ADDR,X.BANKCD,X.BANNAM,X.BRANCH,X.ACCTNO,X.CLOSEDAY,X.CLOSERSN,		\n");
						sql.append( " X.SEMUNAME,X.MANAGENO,X.SEMUTEL,X.SBILLAMT,X.RBILLAMT,							\n");
						sql.append( " X.TAXDATE,X.CURDT					  																				\n");

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