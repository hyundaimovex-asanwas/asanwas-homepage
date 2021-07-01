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
public class mtotalbal_popup_s1 extends HttpServlet {
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
				String []  str	= new String [15];
				str[0]  = req.getParameter("v_str1");		//지점코드
				str[1]  = req.getParameter("v_str2");		//회계기간 from
				str[2]  = req.getParameter("v_str3");		//회계기간 to
				str[3]  = req.getParameter("v_str4");		//현계정코드
				str[4]  = req.getParameter("v_str5");		//검색년도
				str[5]  = req.getParameter("v_str6");		//전기이월
				str[6]  = req.getParameter("v_str7");		//관리항목1 코드
				str[7]  = req.getParameter("v_str8");		//관리항목1 값
				str[8]  = req.getParameter("v_str9");		//관리항목2 코드
				str[9]  = req.getParameter("v_str10");	//관리항목2 값
				str[10] = req.getParameter("v_str11");	//관리항목3 코드
				str[11] = req.getParameter("v_str12");	//관리항목3 값
				str[12] = req.getParameter("v_str13");	//항목선택 CNT

				for(int i=0;i<=12;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATDECR","ATCODE","ATKORNAM","ACTDAT","DETOT",
																					"CRTOT","SLPVLA","REMARK","VENDER",
																					"LEVELS","FDCODE", "FSDAT","FSNBR" ,"SSDAT","SSNBR"
				}; 

				int[] intArrCN = new int[] {  1,   7,  66,  10,   9,
																			9,   9, 132,  32,
																			6,   2,   9,   6, 9,   6	}; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  -1,  -1,   0,
																			0,   0,  -1,  -1,
																		 -1,  -1,  -1,  -1,  -1,  -1 }; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT X.ATDECR AS ATDECR, X.ATCODE AS ATCODE, X.ATKORNAM AS ATKORNAM, X.ACTDAT AS ACTDAT,               	\n");	
						sql.append( "	        SUM(X.DETOT) AS DETOT,SUM(X.CRTOT) AS CRTOT,SUM(X.SLPVLA) AS SLPVLA,												    	\n");
						sql.append( "         X.REMARK AS REMARK, X.VENDER AS VENDER, X.LEVELS AS LEVELS,X.FDCODE,X.FSDAT,X.FSNBR	,X.SSDAT,X.SSNBR\n");
						sql.append( "  FROM (                                                                                                  	\n");	
						sql.append( "  SELECT RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM, '"+str[4]+"/00/00' AS ACTDAT,	\n");	
						sql.append( "         SUM(A.DEAMT) AS DETOT, SUM(A.CRAMT) AS CRTOT,                                                    	\n");
						sql.append( "         SUM(CASE WHEN B.ATDECR='1' THEN A.DEAMT-A.CRAMT ELSE A.CRAMT-A.DEAMT END) AS SLPVLA,              \n");
						sql.append( "         '' AS REMARK,'' AS VENDER,SUBSTR('"+str[4]+"',3,2)||'0000' LEVELS,																\n");
						sql.append( "					'' AS FDCODE, '' AS FSDAT,'' AS FSNBR,''AS SSDAT, '' AS SSNBR   																	\n");
						sql.append( "  FROM ACCOUNT.GENENLED A                                                           															\n");
						sql.append( "  LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE=B.ATCODE                                                             					\n");
						if(str[12].equals("1"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("1"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ	   \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ	   \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E3 ON A.FDCODE = E3.FDCODE  AND A.FSDAT = E3.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E3.FSNBR    AND A.FSSEQ = E3.FSSEQ 	 \n");
						sql.append( " WHERE 1=1																																						\n");
						if(str[12].equals("1"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"') 	   \n");
						if(str[12].equals("3"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("3"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"')   	 \n");
						if(str[12].equals("3"))sql.append( " AND (E3.FSREFCD ='"+str[10]+"' AND E3.FSREFVAL ='"+str[11]+"') 	 \n");
						
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'                                                         \n");
						if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[4]+"0100' AND '"+str[5]+"'                            \n");
						if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'                                \n");
						sql.append( " GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM, ACTDAT                                                         	\n");
						sql.append( " ) X                                                         																							\n");
						sql.append( " GROUP BY X.ATDECR,X.ATCODE,X.ATKORNAM,X.ACTDAT,X.REMARK,X.VENDER,X.LEVELS,X.FDCODE,X.FSDAT,X.FSNBR,X.SSDAT,X.SSNBR	\n");
						
						sql.append( " UNION ALL	\n");
						
						sql.append( "  SELECT /*+ use_hash( b a )  */                         \n");
						sql.append( "         B.ATDECR AS ATDECR,B.ATCODE AS ATCODE,B.ATKORNAM AS ATKORNAM,                         \n");
						sql.append( "					SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||SUBSTR(A.ACTDAT,7,2) AS ACTDAT, \n");
						sql.append( "					A.DEAMT AS DETOT, A.CRAMT AS CRTOT,                                                   \n");
						sql.append( "					CASE WHEN B.ATDECR='1' THEN A.DEAMT-A.CRAMT ELSE A.CRAMT-A.DEAMT END AS SLPVLA,       \n");
						sql.append( "					C.REMARK,G.VEND_NM AS VENDER, SUBSTR(A.ACTDAT,3,4)||SUBSTR(A.ACTDAT,7,2) LEVELS,      \n");
						sql.append( "					A.FDCODE FDCODE , A.FSDAT, A.FSNBR, A.SSDAT, A.SSNBR                                   \n");
						sql.append( "		 FROM ACCOUNT.GENENLED A                                                											\n");
						sql.append( "		 LEFT JOIN ACCOUNT.FSLIPDTL C ON A.FDCODE = C.FDCODE                                          		\n");
						sql.append( "		  							AND A.FSDAT = C.FSDAT                                                                     \n");
						sql.append( "		  							AND A.FSNBR = C.FSNBR                                                                     \n");
						sql.append( "		  							AND A.FSSEQ = C.FSSEQ                                                                     \n");
						sql.append( "		 LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE                                         \n");
						sql.append( "		 LEFT JOIN ACCOUNT.GENENREF D ON A.FDCODE = D.FDCODE  AND A.FSDAT = D.FSDAT                 \n");
						sql.append( "		 														 AND A.FSNBR = D.FSNBR    AND A.FSSEQ = D.FSSEQ                 \n");
						sql.append( "		 														 AND D.FSREFCD='0020'                                           \n");
						if(str[12].equals("1"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("1"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ	   \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ	   \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E3 ON A.FDCODE = E3.FDCODE  AND A.FSDAT = E3.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E3.FSNBR    AND A.FSSEQ = E3.FSSEQ 	 \n");
						sql.append( "		 LEFT JOIN ACCOUNT.GCZM_VENDER G ON D.FSREFVAL = G.VEND_CD                                  \n");
						sql.append( "		WHERE 1 = 1                                                                  					\n");
						if(!str[0].equals(""))sql.append( "		  AND A.FDCODE='"+str[0]+"'		                                   \n");
						if(!str[1].equals(""))sql.append( "		  AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'             \n");
						if(!str[3].equals(""))sql.append( "		  AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'             \n");
						if(str[12].equals("1"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"') 	   \n");
						if(str[12].equals("3"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("3"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"')   	 \n");
						if(str[12].equals("3"))sql.append( " AND (E3.FSREFCD ='"+str[10]+"' AND E3.FSREFVAL ='"+str[11]+"') 	 \n");
						
						sql.append( " UNION ALL	\n");
						
						sql.append( " SELECT /*+ use_hash( b a )  */												\n");		
						sql.append( "        RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM,												\n");		
						sql.append( "        SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'32' AS ACTDAT,															\n");
						sql.append( "				 SUM(A.DEAMT) AS DETOT, SUM(A.CRAMT) AS CRTOT,																											\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR='1' THEN A.DEAMT-A.CRAMT ELSE A.CRAMT-A.DEAMT END) AS SLPVLA,								\n");
						sql.append( "        '' AS REMARK,'' AS VENDER,SUBSTR(A.ACTDAT,3,4)||'32' LEVELS,																				\n");
						sql.append( "        '' AS FDCODE,'' AS FSDAT,'' AS FSNBR,''AS SSDAT, '' AS SSNBR 			  															\n");
						sql.append( " FROM ACCOUNT.GENENLED A																																\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE=B.ATCODE																															\n");

						if(str[12].equals("1"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("1"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ	   \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ	   \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E3 ON A.FDCODE = E3.FDCODE  AND A.FSDAT = E3.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E3.FSNBR    AND A.FSSEQ = E3.FSSEQ 	 \n");
						sql.append( " WHERE 1=1																																									\n");
						if(str[12].equals("1"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"') 	   \n");
						if(str[12].equals("3"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("3"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"')   	 \n");
						if(str[12].equals("3"))sql.append( " AND (E3.FSREFCD ='"+str[10]+"' AND E3.FSREFVAL ='"+str[11]+"') 	 \n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'																													\n");
						if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'																\n");
						if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'																\n");
						sql.append( " GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM,																																	\n");
						sql.append( " SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'32', SUBSTR(A.ACTDAT,3,4)||'32'										\n");
						
						sql.append( " UNION ALL	\n");
						
						sql.append( " SELECT /*+ use_hash( b a )  */																\n");
						sql.append( "        RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, '누계' AS ATKORNAM,																\n");
						sql.append( "        SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'33' AS ACTDAT,															\n");
						sql.append( "        SUM(A.DEAMT) AS DETOT, SUM(A.CRAMT) AS CRTOT,																											\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR='1' THEN A.DEAMT-A.CRAMT ELSE A.CRAMT-A.DEAMT END) AS SLPVLA,								\n");
						sql.append( "        '' AS REMARK,'' AS VENDER,SUBSTR(A.ACTDAT,3,4)||'33' LEVELS,																				\n");
						sql.append( "        '' AS FDCODE,'' AS FSDAT,'' AS FSNBR,''AS SSDAT, '' AS SSNBR     																	\n");
						sql.append( " FROM ACCOUNT.GENENLED A																																\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE=B.ATCODE																														\n");

						if(str[12].equals("1"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("1"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ	   \n");
						if(str[12].equals("2"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT	   \n");
						if(str[12].equals("2"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ	   \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E1 ON A.FDCODE = E1.FDCODE  AND A.FSDAT = E1.FSDAT 		 \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E1.FSNBR    AND A.FSSEQ = E1.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E2 ON A.FDCODE = E2.FDCODE  AND A.FSDAT = E2.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E2.FSNBR    AND A.FSSEQ = E2.FSSEQ 	 \n");
						if(str[12].equals("3"))sql.append( " LEFT JOIN ACCOUNT.GENENREF E3 ON A.FDCODE = E3.FDCODE  AND A.FSDAT = E3.FSDAT 	   \n");
						if(str[12].equals("3"))sql.append( "															 AND A.FSNBR = E3.FSNBR    AND A.FSSEQ = E3.FSSEQ 	 \n");
						sql.append( " WHERE 1=1																																									\n");
						if(str[12].equals("1"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("2"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"') 	   \n");
						if(str[12].equals("3"))sql.append( " AND (E1.FSREFCD ='"+str[6]+"'  AND E1.FSREFVAL ='"+str[7]+"')     \n");
						if(str[12].equals("3"))sql.append( " AND (E2.FSREFCD ='"+str[8]+"'  AND E2.FSREFVAL ='"+str[9]+"')   	 \n");
						if(str[12].equals("3"))sql.append( " AND (E3.FSREFCD ='"+str[10]+"' AND E3.FSREFVAL ='"+str[11]+"') 	 \n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'																													\n");
						if(!str[3].equals(""))  sql.append( " AND A.ATCODE ='"+str[3]+"'																												\n");
						if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'																\n");
						
						sql.append( " GROUP BY B.ATDECR,B.ATCODE,B.ATKORNAM,																																		\n");
						sql.append( " SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'33',SUBSTR(A.ACTDAT,3,4)||'33'											\n");
						
						sql.append( " ORDER BY LEVELS \n");

						//System.out.println("mtotalbal_popup_s1::"+sql.toString());					
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