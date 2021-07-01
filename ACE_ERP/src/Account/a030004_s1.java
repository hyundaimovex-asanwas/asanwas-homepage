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
public class a030004_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //지점
				String  str2  = req.getParameter("v_str2"); //년도
				String  str3  = req.getParameter("v_str3"); //기간 from 하루 전
				String  str4  = req.getParameter("v_str4"); //기간 from
				String  str5  = req.getParameter("v_str5"); //기간 to

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATDECR", "ACTDAT", "ATCODE", "ATKORNAM", "FSNBR", 
												"REMARK", "DETOT", "CRTOT", "SLPVAL" ,"SSNBR","FDCODE"
				}; 

				int[] intArrCN = new int[]{  1, 8, 7, 66, 15, 
											132, 15, 15, 15,15,2,
				}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1, 
											-1, 0, 0, 0,-1,-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
					if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT '' ATDECR, '"+str2+"0100' ACTDAT, '' ATCODE, '' ATKORNAM, '' FSNBR,  '' REMARK, \n" );
					sql.append( "        nvl(SUM(A.DETOT),0) DETOT, nvl(SUM(A.CRTOT),0) CRTOT,    		                 \n" );
					sql.append( "        nvl(SUM(A.DETOT-A.CRTOT),0) SLPVAL ,'' SSNBR,''FDCODE 				             \n" );
					sql.append( " FROM  ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B  									         \n" );
					sql.append( " WHERE A.ATCODE=B.ATCODE 																 \n" );
					
					if(str1.equals("")){ //전체
						sql.append( "  AND ((A.FDCODE= '01' AND A.ATCODE= '1110110') OR (A.FDCODE= '02' AND A.ATCODE= '1110110')  \n" );
						sql.append( "     OR(A.FDCODE= '03' AND A.ATCODE= '1110120') OR (A.FDCODE= '04' AND A.ATCODE= '1110110')) \n" );
					}else if(str1.equals("03")){ //금강산
						sql.append( "  AND A.FDCODE= '"+str1+"' 				\n" );
						sql.append( "  AND A.ATCODE= '1110120'  				\n" );
					}else{ //본사,서울, 개성
						sql.append( "  AND A.FDCODE= '"+str1+"' 				\n" );
						sql.append( "  AND A.ATCODE= '1110110'  				\n" );
					}

					sql.append( " AND B.ATUSEYN = 'Y' 							\n" );
			
					if(!str3.substring(4,8).equals("1231")){
		  				sql.append( " AND A.ACTDAT BETWEEN '"+str2+"0100' AND '"+str3+"'  	  \n" );
					}else if(str3.substring(4,8).equals("1231")){
		                sql.append( " AND A.ACTDAT BETWEEN '"+str2+"0100' AND '"+str2+"0100'  \n" );
					}

					sql.append( " UNION ALL  \n" );

					sql.append( " SELECT C.ATDECR ATDECR, C.ACTDAT ACTDAT, C.ATCODE ATCODE, C.ATKORNAM ATKORNAM,  			\n" );
					sql.append( "        C.FSDAT||C.FSNBR FSNBR, D.REMARK REMARK, nvl(C.DETOT,0) DETOT,  					\n" );
					sql.append( "        nvl(C.CRTOT,0) CRTOT, nvl(C.SLPVAL,0) SLPVAL, C.SSDAT||C.SSNBR SSNBR,D.FDCODE  	\n" );

					sql.append( " FROM  ACCOUNT.FSLIPDTL D RIGHT JOIN  														\n" );
					sql.append( "	(SELECT B.ATDECR ATDECR, B.ATCODE ATCODE, B.ATKORNAM ATKORNAM,  						\n" );
					sql.append( "           A.ACTDAT ACTDAT, A.DEAMT DETOT, A.CRAMT CRTOT, 									\n" );
					sql.append( "	        CASE WHEN B.ATDECR='1' THEN A.DEAMT-A.CRAMT ELSE A.CRAMT-A.DEAMT END AS SLPVAL,	\n" );
					sql.append( "	        A.FDCODE FDCODE, A.FSDAT FSDAT, A.FSNBR FSNBR, A.FSSEQ FSSEQ,A.SSDAT, A.SSNBR  	\n" );
					sql.append( "	   FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE B  											\n" );
					sql.append( "	  WHERE A.ATCODE=B.ATCODE AND B.ATUSEYN = 'Y'  											\n" );

					if(str1.equals("")){ //전체
						sql.append( "  AND ((A.FDCODE= '01' AND A.ATCODE= '1110110') OR (A.FDCODE= '02' AND A.ATCODE= '1110110')  \n" );
						sql.append( "     OR(A.FDCODE= '03' AND A.ATCODE= '1110120') OR (A.FDCODE= '04' AND A.ATCODE= '1110110')) \n" );
					}else if(str1.equals("03")){ //금강산
						sql.append( "  AND A.FDCODE= '"+str1+"' \n" );
						sql.append( "  AND A.ATCODE= '1110120'  \n" );
					}else{ //본사,서울, 개성
						sql.append( "  AND A.FDCODE= '"+str1+"' \n" );
						sql.append( "  AND A.ATCODE= '1110110'  \n" );
					}

					sql.append( "	AND A.ACTDAT BETWEEN '"+str4+"' AND '"+str5+"'  \n" );
					sql.append( "	) C ON C.FDCODE=D.FDCODE AND C.FSDAT=D.FSDAT AND C.FSNBR=D.FSNBR ANd C.FSSEQ=D.FSSEQ    \n" );
					sql.append( " UNION ALL  																				\n" );

					sql.append( " SELECT '' ATDECR, A.ACTDAT ACTDAT, '9999999' ATCODE, '' ATKORNAM, '' FSNBR,  '' REMARK,   \n" );
					sql.append( "        nvl(SUM(A.DETOT),0) DETOT, nvl(SUM(A.CRTOT),0) CRTOT,  		\n" );
					sql.append( "        nvl(SUM(A.DETOT-A.CRTOT),0) SLPVAL,'' SSNBR,''FDCODE    		\n" );
					sql.append( " FROM  ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B  							\n" );


					sql.append( " WHERE A.ATCODE=B.ATCODE 										        \n" );
           
					if(str1.equals("")){ //전체
						sql.append( "  AND ((A.FDCODE= '01' AND A.ATCODE= '1110110') OR (A.FDCODE= '02' AND A.ATCODE= '1110110')  \n" );
						sql.append( "     OR(A.FDCODE= '03' AND A.ATCODE= '1110120') OR (A.FDCODE= '04' AND A.ATCODE= '1110110')) \n" );
					}else if(str1.equals("03")){ //금강산
						sql.append( "  AND A.FDCODE= '"+str1+"' 																\n" );
						sql.append( "  AND A.ATCODE= '1110120'  																\n" );
					}else{ //본사,서울, 개성
						sql.append( "  AND A.FDCODE= '"+str1+"' 																\n" );
						sql.append( "  AND A.ATCODE= '1110110'  																\n" );
					}
					sql.append( " AND B.ATUSEYN = 'Y' 																			\n" );
					if(!str1.equals("")) {
						sql.append( " AND A.FDCODE = '"+str1+"'  																\n" );
					}
					sql.append( " AND A.ACTDAT BETWEEN '"+str4+"' AND '"+str5+"'  				\n" );
					sql.append( " GROUP BY A.ACTDAT                                             \n" );
					sql.append( " HAVING nvl(SUM(A.DETOT),0)<>0 OR nvl(SUM(A.CRTOT),0)<>0  		\n" );
					sql.append( " ORDER BY 2,3,10                                               \n" );


					//logger.dbg.println(this,sql.toString());
					
					//System.out.println("a030004_s1:"+sql.toString());
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