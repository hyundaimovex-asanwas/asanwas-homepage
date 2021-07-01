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
public class a020001_s16 extends HttpServlet {
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
				String []  str	= new String [3];
				str[0] = req.getParameter("v_str1"); //fdcode	
				str[1] = req.getParameter("v_str2"); //fsdat	
				str[2] = req.getParameter("v_str3"); //fsnbr	 

				int intyyyy=0;
				
				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE",     "FSDAT",			"FSNBR",    "FSSEQ",      "ATCODE",
					"ATKORNAM",   "ATDECR",			"REMARK",   "CURAMT",     "CHAAMT",     
					"DAEAMT",	  "FOCHAAMT",   "FODAEAMT",	"FSRVALNM011","FSRVALNM012",
					"FSRVALNM013","FSRVALNM014","FSRVALNM015", "DETITLE",	"CURRENCY",   		 
					"COST",	 "FSSTAT",			"SSNBR",      "DOCUVAL", "DEPTNM"
				}; 

				int[] intArrCN = new int[] { 
					 2,   9,    6,   5,   7,
					66,   1,  132,  15,  15,
					15,  15,   15,  40,  40,  
					40,	 40,   40,  40,  40,   40, 
					 1,	 16,   20,  40
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,   0,
					 0,  -1,  -1,  -1,  -1,  
					-1,	 -1,  -1,  -1,  -1,  -1,  
					-1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

			 if (!GauceReq.isBuilderRequest()) {					
			

				Statement stmt0 = conn.createStatement();
				StringBuffer sql0 = new StringBuffer();
				sql0.append( " SELECT ACTDAT 								" );
				sql0.append( "   FROM ACCOUNT.FSLIPMST    		" );
				sql0.append( "  WHERE 1=1     								" );
				
				if(!str[0].equals("")) { sql0.append( " AND FDCODE = '"+str[0]+"' \n "); }                                                  
				if(!str[1].equals("")) { sql0.append( " AND FSDAT = '"+str[1]+"' \n"); }                                                 
				if(!str[2].equals("")) { sql0.append( " AND FSNBR = '"+str[2]+"' \n"); }  
				
				ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
				
				if(rs0.next()){
					 intyyyy = Integer.parseInt(rs0.getString(1).substring(0,4));
				}
				rs0.close();
				stmt0.close();

				StringBuffer sql = new StringBuffer();

				/*
				sql.append( " SELECT Y.FDCODE, Y.FSDAT, Y.FSNBR, Y.FSSEQ, Y.ATCODE,                                            \n");
				sql.append( "	       Y.ATKORNAM,Y.ATDECR,Y.REMARK,Y.CURAMT,Y.CHAAMT,Y.DAEAMT,                                  \n");	
				sql.append( "	       Y.FOCHAAMT,                                                                               \n");	
				sql.append( "	       Y.FODAEAMT,                                                                               \n");
				sql.append( "	       CASE WHEN LTRIM(RTRIM(Y.COSTCD))='N' THEN Y.FSRVALNM011 ELSE Y.COSTNM END FSRVALNM011,    \n");
				sql.append( "	       CASE WHEN (RTRIM(Y.FSRVALNM012)=''OR Y.FSRVALNM012 IS NULL) THEN Y.FSRVALNM02 ELSE Y.FSRVALNM012 END FSRVALNM012,  \n");	
				sql.append( "	       Y.FSRVALNM013,                                                                            \n");	
				sql.append( "	       Y.FSRVALNM014, Y.FSRVALNM015,                                                             \n");	
				sql.append( "	       Y.DETITLE, Y.CURRENCY, '' COST, Y.FSSTAT, Y.SSNBR, Y.DOCUVAL,Y.DEPTNM                     \n");
				sql.append( "	 FROM(                                                                                           \n");	
				sql.append( "	SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, X.ATCODE,																						\n");	
				sql.append( "	       X.ATKORNAM,X.ATDECR,X.REMARK,X.CURAMT,X.CHAAMT,X.DAEAMT,																	\n");	
				sql.append( "	       MAX(CASE WHEN X.ATDECR='1' AND X.CURRENCY='WON' AND DECIMAL(X.CURAMT,10,1)<>0 THEN '￦'||X.CURAMT											\n");	
				sql.append( "				          WHEN X.ATDECR='1' AND X.CURRENCY='USD' AND DECIMAL(X.CURAMT,10,1)<>0 THEN '＄'||X.CURAMT END) FOCHAAMT,				\n");	
				sql.append( "	       MAX(CASE WHEN X.ATDECR='2' AND X.CURRENCY='WON' AND DECIMAL(X.CURAMT,10,1)<>0 THEN '￦'||X.CURAMT											\n");	
				sql.append( "	                WHEN X.ATDECR='2' AND X.CURRENCY='USD' AND DECIMAL(X.CURAMT,10,1)<>0 THEN '＄'||X.CURAMT END) FODAEAMT,				\n");	
				//2008.01.22. 정영식 추가 (부서명을 부서 테이블에서 가져옴.)
				//2008.02.01  부서- 회계년도가 2007년 이전의 데이타는 관리항목에서 가져옴 
				//2008년도 부터는 부서테이블임.
				if(intyyyy>=2008){
					sql.append( "	       MAX(L.DEPTNM) FSRVALNM011,\n");	
				}else{
					sql.append( "	       MAX(FSRVALNM01) FSRVALNM011,\n");
				}
				
				sql.append( "	       MAX(CASE WHEN FSRVALNM02 = X.DETITLE THEN ''      		\n");	
				sql.append( "	                WHEN (X.ATCODE='2100520') THEN X.FSRVALNM07   \n");	
				sql.append( "	                ELSE X.FSRVALNM02 END )FSRVALNM012,     		\n");	
				sql.append( "	       MAX(CASE WHEN FSRVALNM03 = X.DETITLE OR X.FSREFCD03='0030' THEN ''                   		\n");	
				sql.append( "	       	   ELSE CASE WHEN RTRIM(FSRVALNM03) IS NULL OR RTRIM(FSRVALNM03)='' THEN FSREFVAL03  		\n");	
				sql.append( "	       				  ELSE FSRVALNM03 END                                                          		\n");	
				sql.append( "	       	   END )FSRVALNM013,                                                                 		\n");
				sql.append( "	       MAX(CASE WHEN FSRVALNM04 = X.DETITLE OR X.FSREFCD04='0030' THEN ''                       \n");	
				sql.append( "	       	   ELSE CASE WHEN RTRIM(FSRVALNM04) IS NULL OR RTRIM(FSRVALNM04)='' THEN FSREFVAL04  		\n");	
				sql.append( "									ELSE FSRVALNM04 END                                              	            	\n");	
				sql.append( "	       	    END )FSRVALNM014,                                                                 	\n");
				sql.append( "	       X.DETITLE,X.CURRENCY,'' COST,X.FSSTAT,X.SSNBR,X.DOCUVAL,													        \n");	
				sql.append( "	       MAX(Z.CDNAM) COSTNM, MAX(X.COSTCD)COSTCD, X.FSNUM,\n");	
				//2008.01.22. 정영식 추가 (부서명을 부서 테이블에서 가져옴.)
				//2008.02.01  부서- 회계년도가 2007년 이전의 데이타는 관리항목에서 가져옴 
									//                  2008년도 부터는 부서테이블임.
				if(intyyyy>=2008){
					sql.append( "	       MAX(L.DEPTNM)DEPTNM ,\n");	
				}else{
					sql.append( "	       MAX(FSRVALNM01)DEPTNM ,\n");	
				}
				sql.append( "	       MAX(X.FSRVALNM02)FSRVALNM02, \n");	
				sql.append( "	       MAX(CASE WHEN RTRIM(FSRVALNM05) IS NULL OR RTRIM(FSRVALNM05)='' THEN FSREFVAL05 \n");	
				sql.append( "	           ELSE FSRVALNM05 END) FSRVALNM015                                  \n");	
				sql.append( "	   FROM(                                                                                        \n");	
				sql.append( "	         SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE,                                  \n");	
				sql.append( "	                D.ATKORNAM ,B.ATDECR, B.REMARK,I.CURAMT,		                                    \n");	
				sql.append( "	                CASE WHEN B.ATDECR='1' THEN B.FSAMT ELSE '' END CHAAMT,													\n");	
				sql.append( "	                CASE WHEN B.ATDECR='2' THEN B.FSAMT ELSE '' END DAEAMT,													\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFCD END FSREFCD01,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFCD END FSREFCD02,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFCD END FSREFCD03,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFCD END FSREFCD04,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,											\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,											\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,											\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,											\n");	
				sql.append( "                 CASE WHEN C.FSREFSEQ ='05' AND B.ATCODE='4111500' THEN C.FSREFVAL                         \n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='06' AND B.ATCODE='1260000' THEN C.FSREFVAL                         \n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='07' AND B.ATCODE='1250000' THEN C.FSREFVAL ELSE '' END FSREFVAL05, \n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(F.CDNAM) END FSREFNM01,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(F.CDNAM)END FSREFNM02,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(F.CDNAM) END FSREFNM03,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(F.CDNAM) END FSREFNM04,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,									\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,									\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,									\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,									\n");	
				sql.append( "                 CASE WHEN C.FSREFSEQ ='05' AND B.ATCODE='4111500'  THEN RTRIM(G.CDNAM)                          \n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='06' AND B.ATCODE='1260000'  THEN RTRIM(G.CDNAM)                          \n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='07' AND B.ATCODE='1250000'  THEN RTRIM(G.CDNAM) ELSE '' END FSRVALNM05,  \n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='07' AND C.FSREFCD='0029' THEN                                              \n");	
				sql.append( "	                		 CASE WHEN RTRIM(K.VEND_NM)='' OR K.VEND_NM IS NULL THEN C.FSREFVAL ELSE RTRIM(K.VEND_NM) END \n");
				sql.append( "	                 END FSRVALNM07,                                                                                  \n");
				sql.append( "	                CASE WHEN C.FSREFCD='0030' THEN C.FSREFVAL ELSE 'N' END COSTCD,                 \n");	
				sql.append( "	                H.DETITLE, I.CURRENCY,A.FSSTAT,A.SSDAT||'-'||A.SSNBR AS SSNBR,E.CDNAM DOCUVAL, B.FSNUM		\n");	
				sql.append( "	         FROM ACCOUNT.FSLIPMST A																																\n");	
				sql.append( "	         LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE=B.FDCODE AND A.FSDAT=B.FSDAT AND A.FSNBR=B.FSNBR                        \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE=C.FDCODE AND A.FSDAT=C.FSDAT AND A.FSNBR=C.FSNBR AND B.FSSEQ = C.FSSEQ  \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.ACTCODE D ON D.ATCODE=B.ATCODE                                                                 \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE=B.DOCUMCD AND E.CMTYPE='0052'                                           \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD=F.CDCODE AND F.CMTYPE='0050'                                           \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL=G.CDCODE AND C.FSREFCD=G.CMTYPE                                       \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.GCZM_VENDER K ON C.FSREFVAL = K.VEND_CD AND C.FSREFCD='0029'                                    \n");	
				sql.append( "	         --세목                                                                                                           \n");	
				sql.append( "	         LEFT JOIN(SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE, F.CDNAM AS DETITLE																\n");	
				sql.append( "	                   FROM ACCOUNT.FSLIPMST A																																								\n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR				\n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.ACTCODE D ON D.ATCODE = B.ATCODE                                                                     \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.ACTREFCODE D2 ON D.ATCODE = D2.ATCODE                                                                \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFCD = G.CDCODE AND G.CMTYPE='0019'                                          \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL F ON G.CDCODE  = F.CMTYPE   AND F.CDCODE=C.FSREFVAL                                            \n");	
				sql.append( "	                   WHERE B.FDCODE = '"+str[0]+"'                                                                                          \n");	
				sql.append( "	                     AND B.FSDAT = '"+str[1]+"'                                                                                           \n");	
				sql.append( "	                     AND B.FSNBR = '"+str[2]+"'                                                                                           \n");	
				sql.append( "	                     AND C.FSREFCD = G.CDCODE --AND D2.TYPE='B'                                                                            \n");	
				sql.append( "	                   ) H  ON H.FDCODE = B.FDCODE AND H.FSDAT = B.FSDAT AND H.FSNBR = B.FSNBR                                                \n");	
				sql.append( "	                     AND H.FSSEQ = B.FSSEQ   AND H.ATCODE = B.ATCODE                             \n");	
				sql.append( "	         --통화명                                                                                                                         \n");	
				sql.append( "	         LEFT JOIN(SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE, G.CDNAM AS CURRENCY,D.FSREFVAL AS CURAMT                         \n");	
				sql.append( "	                   FROM ACCOUNT.FSLIPMST A                                                                                                \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR                        \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPREF D ON A.FDCODE = D.FDCODE AND A.FSDAT = D.FSDAT AND A.FSNBR = D.FSNBR  AND B.FSSEQ = D.FSSEQ \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD = F.CDCODE AND F.CMTYPE='0050'                                               \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE                                           \n");	
				sql.append( "	                   WHERE B.FDCODE = '"+str[0]+"'                                                                                          \n");	
				sql.append( "	                     AND B.FSDAT = '"+str[1]+"'                                                                                           \n");	
				sql.append( "	                     AND B.FSNBR = '"+str[2]+"'                                                                                           \n");	
				sql.append( "	                     AND C.FSREFCD = '1043'                                                                                               \n");	
				sql.append( "	                     AND D.FSREFCD = '1045' AND D.FSREFVAL<>'0' AND D.FSREFVAL<>'-'																												\n");	
				sql.append( "	                   ) I  ON I.FDCODE = B.FDCODE AND I.FSDAT = B.FSDAT AND I.FSNBR = B.FSNBR                                                \n");	
				sql.append( "	                    AND I.FSSEQ = B.FSSEQ   AND I.ATCODE = B.ATCODE               \n");	
				sql.append( "	           WHERE A.FDCODE IS NOT NULL                                                                                                                           	\n");	
				sql.append( "	           AND A.FDCODE = '"+str[0]+"'                                                                                                                    \n");	
				sql.append( "	           AND A.FSDAT = '"+str[1]+"'                                                                                                                    	\n");	
				sql.append( "	           AND A.FSNBR = '"+str[2]+"'                                                                                                                    	\n");	
				sql.append( "	                          ) X                                                                                                                           	\n");	
				
				sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL Z ON X.COSTCD = Z.CDCODE AND Z.CMTYPE='0030'  \n"); 
				//2008.01.22. 정영식 추가 (부서명을 부서 테이블에서 가져옴.)
				//2008.02.01  부서- 회계년도가 2007년 이전의 데이타는 관리항목에서 가져옴 
				//2008년도 부터는 부서테이블임.
				if(intyyyy>=2008){
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT L ON L.DEPTCD = X.FSREFVAL01 AND L.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
				}
				sql.append( "	  GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ,X.ATCODE,X.ATKORNAM,X.ATDECR,X.REMARK,X.CURAMT,X.CHAAMT,X.DAEAMT,                                          \n");	
				sql.append( "	           X.DETITLE,X.CURRENCY,X.FSSTAT,X.SSNBR,X.DOCUVAL,X.FSNUM                                                                                                    			\n");	
				sql.append( "	  ) Y 																								\n");
				sql.append( "	   																									\n");
				sql.append( "	  ORDER BY Y.FDCODE, Y.FSDAT, Y.FSNUM, Y.FSNBR, Y.FSSEQ        	\n");	
				*/
				
				
				sql.append( " SELECT Y.FDCODE, Y.FSDAT, Y.FSNBR, Y.FSSEQ, Y.ATCODE,                                            							\n");
				sql.append( "	       Y.ATKORNAM,Y.ATDECR,Y.REMARK,Y.CURAMT,Y.CHAAMT,Y.DAEAMT,                                  						\n");	
				sql.append( "	       Y.FOCHAAMT,                                                                               													\n");	
				sql.append( "	       Y.FODAEAMT,                                                                               													\n");
				
				//sql.append( "	       CASE WHEN (LTRIM(RTRIM(Y.COSTCD))='N' OR LTRIM(RTRIM(Y.COSTCD))='-')  THEN Y.FSRVALNM011 ELSE Y.COSTNM END FSRVALNM011,    	\n");
				//2016.07.21 JYS ==> 예수금은 원가코드 대신 부서로 보여줌
				sql.append( "	       CASE WHEN (LTRIM(RTRIM(Y.COSTCD))='N' OR LTRIM(RTRIM(Y.COSTCD))='-')  THEN Y.FSRVALNM011    	\n");
				sql.append( "               ELSE CASE WHEN Y.ATCODE ='2101200' THEN Y.FSRVALNM011 ELSE Y.COSTNM END END FSRVALNM011,    	\n");
				
				//2017.02.28 JYS 일단 막자...
				sql.append( "	       CASE WHEN (RTRIM(Y.FSRVALNM012)=''OR Y.FSRVALNM012 IS NULL) THEN Y.FSRVALNM02 ELSE Y.FSRVALNM012 END FSRVALNM012,  \n");	
				/*
				sql.append( "	       CASE WHEN BB.CREDGB IN ('1','2') THEN \n");
				sql.append( "	       		CASE WHEN (RTRIM(Y.FSRVALNM012)=''OR Y.FSRVALNM012 IS NULL) THEN '★'||Y.FSRVALNM02 ELSE '★'||Y.FSRVALNM012 END  \n");
				sql.append( "	        ELSE  \n");
				sql.append( "	            CASE WHEN (RTRIM(Y.FSRVALNM012)=''OR Y.FSRVALNM012 IS NULL) THEN Y.FSRVALNM02 ELSE Y.FSRVALNM012 END \n");
				sql.append( "	        END FSRVALNM012, \n");
				*/
				
				sql.append( "	       CASE WHEN (RTRIM(Y.FSRVALNM013)='DUMMY') THEN ' ' ELSE Y.FSRVALNM013 END FSRVALNM013,					\n");	
				sql.append( "	       Y.FSRVALNM014, Y.FSRVALNM015,                                                             											\n");	
				sql.append( "	       Y.DETITLE, Y.CURRENCY, '' COST, Y.FSSTAT, Y.SSNBR, Y.DOCUVAL,Y.DEPTNM                     					\n");
				sql.append( "	 FROM(                                                                                           														\n");	
				sql.append( "	SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, X.ATCODE,																		\n");	
				sql.append( "	       X.ATKORNAM,X.ATDECR,X.REMARK,X.CURAMT,X.CHAAMT,X.DAEAMT,														\n");	
				//sql.append( "	       MAX(CASE WHEN X.ATDECR='1' AND X.CURRENCY='WON' AND TO_NUMBER(X.CURAMT)<>0  THEN '￦'||X.CURAMT										\n");	
				//sql.append( "		            WHEN X.ATDECR='1' AND X.CURRENCY='USD' AND TO_NUMBER(X.CURAMT)<>0  THEN '＄'||X.CURAMT END) FOCHAAMT,				\n");	
				//sql.append( "	       MAX(CASE WHEN X.ATDECR='2' AND X.CURRENCY='WON' AND TO_NUMBER(X.CURAMT)<>0  THEN '￦'||X.CURAMT									\n");	
				//sql.append( "	                WHEN X.ATDECR='2' AND X.CURRENCY='USD' AND TO_NUMBER(X.CURAMT)<>0 THEN '＄'||X.CURAMT END) FODAEAMT,					\n");	
				
				//2014.04.04. jys  출력물 외화금액 ....
				sql.append( "	       MAX(CASE WHEN X.ATDECR='1' AND X.CURRENCY='WON' AND (X.CURAMT)<>'0'  THEN '￦'||X.CURAMT									\n");	
				sql.append( "	                WHEN X.ATDECR='1' AND X.CURRENCY='USD' AND (X.CURAMT)<>'0'  THEN '＄'||X.CURAMT									\n");
				sql.append( "		            WHEN X.ATDECR='1' AND X.CURRENCY='CNY' AND (X.CURAMT)<>'0'  THEN '￥'||X.CURAMT END) FOCHAAMT,		    		\n");	
				sql.append( "	       MAX(CASE WHEN X.ATDECR='2' AND X.CURRENCY='WON' AND (X.CURAMT)<>'0'  THEN '￦'||X.CURAMT									\n");	
				sql.append( "	                WHEN X.ATDECR='2' AND X.CURRENCY='USD' AND (X.CURAMT)<>'0'  THEN '＄'||X.CURAMT                   				\n");
				sql.append( "	                WHEN X.ATDECR='2' AND X.CURRENCY='CNY' AND (X.CURAMT)<>'0'  THEN '￥'||X.CURAMT END) FODAEAMT,					\n");
				
				//2008.01.22. 정영식 추가 (부서명을 부서 테이블에서 가져옴.)
				//2008.02.01  부서- 회계년도가 2007년 이전의 데이타는 관리항목에서 가져옴 
				//2008년도 부터는 부서테이블임.
				if(intyyyy>=2008){
					sql.append( "	       MAX(L.DEPTNM) FSRVALNM011,																										\n");	
				}else{
					sql.append( "	       MAX(FSRVALNM01) FSRVALNM011,																									\n");
				}
				
				sql.append( "	       MAX(CASE WHEN FSRVALNM02 = X.DETITLE THEN ''      		\n");	
				sql.append( "	                WHEN (X.ATCODE='2100520') THEN X.FSRVALNM07   \n");	
				sql.append( "	                ELSE X.FSRVALNM02 END )FSRVALNM012,     		\n");	
				sql.append( "	       MAX(CASE WHEN FSRVALNM03 = X.DETITLE OR X.FSREFCD03='0030' THEN ''                   		\n");	
				sql.append( "	       	   ELSE CASE WHEN RTRIM(FSRVALNM03) IS NULL OR RTRIM(FSRVALNM03)='' THEN FSREFVAL03  		\n");	
				sql.append( "	       				  ELSE FSRVALNM03 END                                                          		\n");	
				sql.append( "	       	   END )FSRVALNM013,                                                                 		\n");
				sql.append( "	       MAX(CASE WHEN FSRVALNM04 = X.DETITLE OR X.FSREFCD04='0030' THEN ''                       \n");	
				sql.append( "	       	   ELSE CASE WHEN RTRIM(FSRVALNM04) IS NULL OR RTRIM(FSRVALNM04)='' THEN FSREFVAL04  		\n");	
				sql.append( "									ELSE FSRVALNM04 END                                              	            	\n");	
				sql.append( "	       	    END )FSRVALNM014,                                                                 	\n");
				sql.append( "	       X.DETITLE,X.CURRENCY,'' COST,X.FSSTAT,X.SSNBR,X.DOCUVAL,													        \n");	
				sql.append( "	       MAX(Z.CDNAM) COSTNM, MIN(X.COSTCD)COSTCD, X.FSNUM,\n");	
				//2008.01.22. 정영식 추가 (부서명을 부서 테이블에서 가져옴.)
				//2008.02.01  부서- 회계년도가 2007년 이전의 데이타는 관리항목에서 가져옴 
									//                  2008년도 부터는 부서테이블임.
				if(intyyyy>=2008){
					sql.append( "	       MAX(L.DEPTNM)DEPTNM ,																												\n");	
				}else{
					sql.append( "	       MAX(FSRVALNM01)DEPTNM ,																											\n");	
				}
				sql.append( "	       MAX(X.FSRVALNM02)FSRVALNM02, MAX(X.FSREFVAL02)FSREFVAL02,										\n");	
				sql.append( "	       MAX(CASE WHEN RTRIM(FSRVALNM05) IS NULL OR RTRIM(FSRVALNM05)='' THEN FSREFVAL05 					\n");	
				sql.append( "	           ELSE FSRVALNM05 END) FSRVALNM015                                  															\n");	
				sql.append( "	   FROM(                                                                                        														\n");	
				sql.append( "	         SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE,                                  							\n");	
				sql.append( "	                D.ATKORNAM ,B.ATDECR, B.REMARK,NVL(TRIM(I.CURAMT),0) CURAMT,		                           			\n");	
				sql.append( "	                CASE WHEN B.ATDECR='1' THEN B.FSAMT ELSE 0 END CHAAMT,													\n");	
				sql.append( "	                CASE WHEN B.ATDECR='2' THEN B.FSAMT ELSE 0 END DAEAMT,													\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFCD END FSREFCD01,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFCD END FSREFCD02,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFCD END FSREFCD03,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFCD END FSREFCD04,												\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,											\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,											\n");	
				//sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,											\n");	
				//2017.02.24.JYS 재무팀요청 외상매입금(지급어음) 어음번호 대힌....만기일로 
				//sql.append( "	                CASE WHEN C.FSREFSEQ ='03' AND B.ATCODE!='2100120' THEN C.FSREFVAL                  \n");
				//sql.append( "	                     WHEN C.FSREFSEQ ='06' AND B.ATCODE='2100120'  THEN C.FSREFVAL END FSREFVAL03,  \n");
				//2017.05.25.JYS 재무팀요청 외상매입금(지급어음), 미지급금(지급어음) 어음번호 대힌....만기일로
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' AND B.ATCODE NOT IN ('2100120','2100530') THEN C.FSREFVAL                  \n");
				sql.append( "	                     WHEN C.FSREFSEQ ='06' AND B.ATCODE IN ('2100120','2100530')  THEN C.FSREFVAL END FSREFVAL03,  \n");
				
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,											\n");	
				sql.append( "                   CASE WHEN C.FSREFSEQ ='05' AND B.ATCODE='4111500' THEN C.FSREFVAL                         			\n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='06' AND B.ATCODE='1260000' THEN C.FSREFVAL                         			\n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='07' AND B.ATCODE='1250000' THEN C.FSREFVAL ELSE '' END FSREFVAL05, \n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(F.CDNAM) END FSREFNM01,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(F.CDNAM)END FSREFNM02,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(F.CDNAM) END FSREFNM03,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(F.CDNAM) END FSREFNM04,										\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,									\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,									\n");	
				//sql.append( "	                CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,									\n");	
				//2017.02.24.JYS 재무팀요청 외상매입금(지급어음) 어음번호 대힌....만기일로
				//sql.append( "	                CASE WHEN C.FSREFSEQ ='03' AND B.ATCODE!='2100120' THEN RTRIM(G.CDNAM)               	\n");
				//sql.append( "	                     WHEN C.FSREFSEQ ='06' AND B.ATCODE='2100120'  THEN RTRIM(G.CDNAM) END FSRVALNM03,	\n");
				//2017.05.25.JYS 재무팀요청 외상매입금(지급어음), 미지급금(지급어음) 어음번호 대힌....만기일로
				sql.append( "	                CASE WHEN C.FSREFSEQ ='03' AND B.ATCODE NOT IN ('2100120','2100530') THEN RTRIM(G.CDNAM)               	\n");
				sql.append( "	                     WHEN C.FSREFSEQ ='06' AND B.ATCODE IN ('2100120','2100530')  THEN RTRIM(G.CDNAM) END FSRVALNM03,	\n");
				
				sql.append( "	                CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,									\n");	
				sql.append( "                   CASE WHEN C.FSREFSEQ ='05' AND B.ATCODE='4111500'  THEN RTRIM(G.CDNAM)                          \n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='06' AND B.ATCODE='1260000'  THEN RTRIM(G.CDNAM)                          	\n");	
				sql.append( "                 		 WHEN C.FSREFSEQ ='07' AND B.ATCODE='1250000'  THEN RTRIM(G.CDNAM) ELSE '' END FSRVALNM05,  			\n");	
				sql.append( "	                CASE WHEN C.FSREFSEQ ='07' AND C.FSREFCD='0029' THEN                                              								\n");	
				sql.append( "	                		 CASE WHEN RTRIM(K.VEND_NM)='' OR K.VEND_NM IS NULL THEN C.FSREFVAL ELSE RTRIM(K.VEND_NM) END \n");
				sql.append( "	                 END FSRVALNM07,                                                                                  													\n");
				sql.append( "	                CASE WHEN C.FSREFCD='0030' THEN C.FSREFVAL ELSE 'N' END COSTCD,                 										\n");	
				sql.append( "	                H.DETITLE, I.CURRENCY,A.FSSTAT,A.SSDAT||'-'||A.SSNBR AS SSNBR,E.CDNAM DOCUVAL, B.FSNUM					\n");	
				sql.append( "	         FROM ACCOUNT.FSLIPMST A																																\n");	
				sql.append( "	         LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE=B.FDCODE AND A.FSDAT=B.FSDAT AND A.FSNBR=B.FSNBR                  \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE=C.FDCODE AND A.FSDAT=C.FSDAT AND A.FSNBR=C.FSNBR AND B.FSSEQ = C.FSSEQ  \n");	
				sql.append( "	         LEFT JOIN ACCOUNT.ACTCODE D ON D.ATCODE=B.ATCODE                                                                 					\n");	
				sql.append( "	         LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE=B.DOCUMCD AND E.CMTYPE='0052'                                           		\n");	
				sql.append( "	         LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD=F.CDCODE AND F.CMTYPE='0050'                                           		\n");	
				sql.append( "	         LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL=G.CDCODE AND C.FSREFCD=G.CMTYPE                                       	\n");	
				sql.append( "	         LEFT JOIN ACCOUNT.GCZM_VENDER K ON C.FSREFVAL = K.VEND_CD AND C.FSREFCD='0029'                                    	\n");	
				sql.append( "	         --세목                                                                                                           													\n");	
				sql.append( "	         LEFT JOIN(SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE, F.CDNAM AS DETITLE									\n");	
				sql.append( "	                   FROM ACCOUNT.FSLIPMST A																														\n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR	\n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.ACTCODE D ON D.ATCODE = B.ATCODE                                                                     	\n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.ACTREFCODE D2 ON D.ATCODE = D2.ATCODE                                                                \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFCD = G.CDCODE AND G.CMTYPE='0019'                                    \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL F ON G.CDCODE  = F.CMTYPE   AND F.CDCODE=C.FSREFVAL                           \n");	
				sql.append( "	                   WHERE B.FDCODE = '"+str[0]+"'                                                                                          						\n");	
				sql.append( "	                     AND B.FSDAT = '"+str[1]+"'                                                                                           							\n");	
				sql.append( "	                     AND B.FSNBR = '"+str[2]+"'                                                                                           							\n");	
				sql.append( "	                     AND C.FSREFCD = G.CDCODE --AND D2.TYPE='B'                                                                            			\n");	
				sql.append( "	                   ) H  ON H.FDCODE = B.FDCODE AND H.FSDAT = B.FSDAT AND H.FSNBR = B.FSNBR                                        	\n");	
				sql.append( "	                     AND H.FSSEQ = B.FSSEQ   AND H.ATCODE = B.ATCODE                             												\n");	
				sql.append( "	         --통화명                                                                                                                         									\n");	
				sql.append( "	         LEFT JOIN(SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE, G.CDNAM AS CURRENCY,                 	\n");	
				//sql.append( "	                   (CASE WHEN RTRIM(D.FSREFVAL)<> '0' THEN '0' ELSE D.FSREFVAL END ) AS CURAMT                    	\n");
				sql.append( "	                   D.FSREFVAL AS CURAMT                    	\n");
				sql.append( "	                   FROM ACCOUNT.FSLIPMST A                                                                                                												\n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR                        	\n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.FSLIPREF D ON A.FDCODE = D.FDCODE AND A.FSDAT = D.FSDAT AND A.FSNBR = D.FSNBR  AND B.FSSEQ = D.FSSEQ \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD = F.CDCODE AND F.CMTYPE='0050'                               \n");	
				sql.append( "	                   LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE                    \n");	
				sql.append( "	                   WHERE B.FDCODE = '"+str[0]+"'                                                                                          				\n");	
				sql.append( "	                     AND B.FSDAT = '"+str[1]+"'                                                                                           					\n");	
				sql.append( "	                     AND B.FSNBR = '"+str[2]+"'                                                                                           					\n");	
				sql.append( "	                     AND C.FSREFCD = '1043'                                                                                               					\n");	
				sql.append( "	                     AND D.FSREFCD = '1045' AND D.FSREFVAL<>'0' AND D.FSREFVAL<>'-'												\n");	
				sql.append( "	                   ) I  ON I.FDCODE = B.FDCODE AND I.FSDAT = B.FSDAT AND I.FSNBR = B.FSNBR                                       \n");	
				sql.append( "	                    AND I.FSSEQ = B.FSSEQ   AND I.ATCODE = B.ATCODE               															\n");	
				sql.append( "	           WHERE A.FDCODE IS NOT NULL                                                                                                                	\n");	
				sql.append( "	           AND A.FDCODE = '"+str[0]+"'                                                                                                                    	\n");	
				sql.append( "	           AND A.FSDAT = '"+str[1]+"'                                                                                                                    		\n");	
				sql.append( "	           AND A.FSNBR = '"+str[2]+"'                                                                                                                    	\n");	
				sql.append( "	                          ) X                                                                                                                           				\n");	
				sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL Z ON X.COSTCD = Z.CDCODE AND Z.CMTYPE='0030'  												\n"); 
				if(intyyyy>=2008){
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT L ON L.DEPTCD = X.FSREFVAL01 								 											\n ");
				}
				sql.append( "	  GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ,X.ATCODE,X.ATKORNAM,X.ATDECR,X.REMARK,X.CURAMT,X.CHAAMT,X.DAEAMT,                        	\n");	
				sql.append( "	           X.DETITLE,X.CURRENCY,X.FSSTAT,X.SSNBR,X.DOCUVAL,X.FSNUM                                                                                                    			\n");	
				sql.append( "	  ) Y 																								\n");
				//sql.append( "	  LEFT JOIN ACCOUNT.BOND_ATTACH BB ON BB.VEND_CD = Y.FSREFVAL02 AND BB.CREDGB IN ('1','2') 																									\n");
				sql.append( "	  ORDER BY Y.FDCODE, Y.FSDAT, Y.FSNUM, Y.FSNBR, Y.FSSEQ        	\n");	
								
				//System.out.println("a020001_s16 : \n" + sql);
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