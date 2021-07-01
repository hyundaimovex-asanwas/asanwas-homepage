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
public class a040010_s7f extends HttpServlet {
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
				String [] str = new String [3];
				str[0]	= req.getParameter("v_str1");		//현장코드
				str[1]	= req.getParameter("v_str2");		//가전표일자
				str[2]	= req.getParameter("v_str3");		//가전표번호

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",  "FSDAT",  "FSNBR",  "FSSEQ",  "ATCODE",
					                                "ATKORNAM","ATDECR", "REMARK", "CHAAMT", "DAEAMT",  
					                                "FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05", 
				                                  "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09",
					                                "FSREFCD01", "FSREFCD02", "FSREFCD03", "FSREFCD04", "FSREFCD05",
                                          "FSREFCD06", "FSREFCD07", "FSREFCD08", "FSREFCD09",
                                          "FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",
					                                "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09",
					                                "FSREFNM01","FSREFNM02","FSREFNM03","FSREFNM04","FSREFNM05",
					                                "FSREFNM06","FSREFNM07","FSREFNM08","FSREFNM09",
					                                "FSRVALNM01","FSRVALNM02","FSRVALNM03","FSRVALNM04","FSRVALNM05",
					                                "FSRVALNM06","FSRVALNM07","FSRVALNM08","FSRVALNM09",
					                                "TYPE01",    "TYPE02",     "TYPE03",   "TYPE04",   "TYPE05",
					                                "TYPE06",    "TYPE07",     "TYPE08",   "TYPE09",
					                                "ARBALDIV01","ARBALDIV02","ARBALDIV03","ARBALDIV04","ARBALDIV05",
                                          "ARBALDIV06","ARBALDIV07","ARBALDIV08","ARBALDIV09",
					                                "CNT", "DOCUMCD", "DOCUMNM", "FSWRKDIV",
					                                "WRDT",	"WRID",	"UPDT",	"UPID" , "BANJAEYN","FSSTAT", "DOCUVAL"
																				};

				int[] intArrCN = new int[]{  2, 9,  6,  5,  7,
					                          66, 1, 66, 15, 15, 
					                           2, 2, 2, 2, 2, 
					                           2, 2, 2, 2,
                                     4, 4,  4,  4,  4,
					                           4, 4,  4,  4,  
					                          30,30, 30, 30, 30, 
					                          30,30, 30, 30, 
					                          40,40, 40, 40, 40, 
					                          40,40, 40, 40, 
					                          40,40, 40, 40, 40, 
					                          40,40, 40, 40,
                                     1, 1,  1,  1,  1,
					                           1, 1,  1,  1,  
					                           1, 1,  1,  1,  1,
					                           1, 1,  1,  1,  
					                           1,3,40,1, 
                                     8, 7,  8,  7, 1 ,1 ,20
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, 0,  0, 
                                     -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
																		 -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                            0, -1, -1, -1,
					                           -1, -1, -1, -1, -1 , -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, X.ATCODE,      \n ");
					sql.append( "    X.ATKORNAM,X.ATDECR,X.REMARK,X.CHAAMT,X.DAEAMT,          \n ");
					sql.append( "    MAX(FSREFSEQ01)FSREFSEQ01,   MAX(FSREFSEQ02)FSREFSEQ02, \n ");
					sql.append( "    MAX(FSREFSEQ03)FSREFSEQ03,   MAX(FSREFSEQ04)FSREFSEQ04, \n ");
					sql.append( "    MAX(FSREFSEQ05)FSREFSEQ05,   MAX(FSREFSEQ05)FSREFSEQ06, \n ");
					sql.append( "    MAX(FSREFSEQ07)FSREFSEQ07,   MAX(FSREFSEQ06)FSREFSEQ08, \n ");
					sql.append( "    MAX(FSREFSEQ09)FSREFSEQ09,                              \n ");  
					sql.append( "	   MAX(FSREFCD01)FSREFCD01,   MAX(FSREFNM01)FSREFNM01,    \n "); 
					sql.append( "	   MAX(FSREFVAL01)FSREFVAL01, MAX(FSRVALNM01)FSRVALNM01,  \n "); 
					sql.append( "	   MAX(FSREFCD02)FSREFCD02,   MAX(FSREFNM02)FSREFNM02,    \n "); 
					sql.append( "	   MAX(FSREFVAL02)FSREFVAL02, MAX(FSRVALNM02)FSRVALNM02,  \n "); 
					
					sql.append( "	   MAX(FSREFCD03)FSREFCD03,   MAX(FSREFNM03)FSREFNM03,   MAX(FSREFVAL03)FSREFVAL03,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM03) IS NULL OR RTRIM(FSRVALNM03)='' THEN FSREFVAL03 ELSE FSRVALNM03 END) AS FSRVALNM03,  \n "); 
					sql.append( "	   MAX(FSREFCD04)FSREFCD04,   MAX(FSREFNM04)FSREFNM04,   MAX(FSREFVAL04)FSREFVAL04,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM04) IS NULL OR RTRIM(FSRVALNM04)='' THEN FSREFVAL04 ELSE FSRVALNM04 END) AS FSRVALNM04,  \n "); 
					sql.append( "	   MAX(FSREFCD05)FSREFCD05,   MAX(FSREFNM05)FSREFNM05,   MAX(FSREFVAL05)FSREFVAL05,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM05) IS NULL OR RTRIM(FSRVALNM05)='' THEN FSREFVAL05 ELSE FSRVALNM05 END) AS FSRVALNM05,  \n "); 
					sql.append( "	   MAX(FSREFCD06)FSREFCD06,   MAX(FSREFNM06)FSREFNM06,   MAX(FSREFVAL06)FSREFVAL06,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM06) IS NULL OR RTRIM(FSRVALNM06)='' THEN FSREFVAL06 ELSE FSRVALNM06 END) AS FSRVALNM06,  \n "); 
					sql.append( "	   MAX(FSREFCD07)FSREFCD07,   MAX(FSREFNM07)FSREFNM07,   MAX(FSREFVAL07)FSREFVAL07,  \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM07) IS NULL OR RTRIM(FSRVALNM07)='' THEN FSREFVAL07 ELSE FSRVALNM07 END) AS FSRVALNM07,  \n "); 
					sql.append( "	   MAX(FSREFCD08)FSREFCD08,   MAX(FSREFNM08)FSREFNM08,   MAX(FSREFVAL08)FSREFVAL08,  \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM08) IS NULL OR RTRIM(FSRVALNM08)='' THEN FSREFVAL08 ELSE FSRVALNM08 END) AS FSRVALNM08,  \n "); 
					sql.append( "	   MAX(FSREFCD09)FSREFCD09,   MAX(FSREFNM09)FSREFNM09,   MAX(FSREFVAL09)FSREFVAL09,  \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM09) IS NULL OR RTRIM(FSRVALNM09)='' THEN FSREFVAL09 ELSE FSRVALNM09 END) AS FSRVALNM09,  \n "); 
		
					sql.append( "    MAX(TYPE01)TYPE01,   MAX(TYPE02)TYPE02,   \n");
					sql.append( "    MAX(TYPE03)TYPE03,   MAX(TYPE04)TYPE04,   \n");
					sql.append( "    MAX(TYPE05)TYPE05,   MAX(TYPE06)TYPE06,   \n");
					sql.append( "    MAX(TYPE07)TYPE07,   MAX(TYPE08)TYPE08,   \n");
					sql.append( "    MAX(TYPE09)TYPE09,                        \n");

					sql.append( "    MAX(ARBALDIV01)ARBALDIV01,   MAX(ARBALDIV02)ARBALDIV02,\n");
					sql.append( "    MAX(ARBALDIV03)ARBALDIV03,   MAX(ARBALDIV04)ARBALDIV04,\n");
					sql.append( "    MAX(ARBALDIV05)ARBALDIV05,   MAX(ARBALDIV06)ARBALDIV06,\n");
					sql.append( "    MAX(ARBALDIV07)ARBALDIV07,   MAX(ARBALDIV08)ARBALDIV08,\n");
					sql.append( "    MAX(ARBALDIV09)ARBALDIV09,                             \n");
        
					sql.append( "        (COUNT(X.FSREFCD01)+COUNT(X.FSREFCD02)+COUNT(X.FSREFCD03)+COUNT(X.FSREFCD04)+COUNT(X.FSREFCD05)      \n ");
					sql.append( "        +COUNT(X.FSREFCD06)+COUNT(X.FSREFCD07)+COUNT(X.FSREFCD08)+COUNT(X.FSREFCD09))CNT ,                    \n ");
					sql.append( "        X.DOCUMCD, X.DOCUMNM, X.FSWRKDIV, \n ");
					sql.append( "        X.WRDT, X.WRID, X.UPDT, X.UPID , X.BANJAEYN ,X.FSSTAT, X.DOCUVAL \n ");
					sql.append( "  FROM(  \n ");
					sql.append( "        SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE,\n ");
					sql.append( "               CASE WHEN B.ATCODE='1' THEN '노무비'        \n ");
					sql.append( "   			           WHEN B.ATCODE='2' THEN '외주비'       \n ");
					sql.append( "   			           WHEN B.ATCODE='3' THEN '장비비'       \n ");
					sql.append( "   			           WHEN B.ATCODE='4' THEN '자재비'       \n ");
					sql.append( "   			           WHEN B.ATCODE='5' THEN '전도금(경비)' \n ");
					sql.append( "   			           WHEN B.ATCODE='6' THEN '외주비부가세'       \n ");
					sql.append( "   			           WHEN B.ATCODE='7' THEN '장비비부가세'       \n ");
					sql.append( "   			           WHEN B.ATCODE='8' THEN '자재비부가세'       \n ");
					sql.append( "   			           WHEN B.ATCODE='9' THEN '경비부가세'   \n ");
					sql.append( "   	          ELSE D.ATKORNAM END  ATKORNAM              \n ");
					sql.append( "               ,B.ATDECR, B.REMARK,  \n ");
					sql.append( "                CASE WHEN B.ATDECR='1' THEN B.FSAMT ELSE '' END CHAAMT,                     \n ");
					sql.append( "								 CASE WHEN B.ATDECR='2' THEN B.FSAMT ELSE '' END DAEAMT,                     \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFSEQ END FSREFSEQ01, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFSEQ END FSREFSEQ02, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFSEQ END FSREFSEQ03, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFSEQ END FSREFSEQ04, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFSEQ END FSREFSEQ05, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFSEQ END FSREFSEQ06, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFSEQ END FSREFSEQ07, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFSEQ END FSREFSEQ08, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFSEQ END FSREFSEQ09, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFCD END FSREFCD01,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFCD END FSREFCD02,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFCD END FSREFCD03,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFCD END FSREFCD04,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFCD END FSREFCD05,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFCD END FSREFCD06,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFCD END FSREFCD07,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFCD END FSREFCD08,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFCD END FSREFCD09,   \n ");
					
					sql.append( "							   CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFVAL END FSREFVAL08, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFVAL END FSREFVAL09, \n ");          
					
					sql.append( "							   CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(F.CDNAM) END FSREFNM01,  \n ");  
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(F.CDNAM)END FSREFNM02,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(F.CDNAM) END FSREFNM03,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(F.CDNAM) END FSREFNM04,  \n ");  
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(F.CDNAM) END FSREFNM05,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(F.CDNAM) END FSREFNM06,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(F.CDNAM) END FSREFNM07,  \n ");  
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(F.CDNAM) END FSREFNM08,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(F.CDNAM) END FSREFNM09,  \n "); 
         
					sql.append( "							   CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(G.CDNAM) END FSRVALNM07, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(G.CDNAM) END FSRVALNM08, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(G.CDNAM) END FSRVALNM09, \n "); 

					sql.append( "	               CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(H.TYPE) END TYPE01,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(H.TYPE) END TYPE02,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(H.TYPE) END TYPE03,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(H.TYPE) END TYPE04,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(H.TYPE) END TYPE05,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(H.TYPE) END TYPE06,    \n "); 
					sql.append( "								 CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(H.TYPE) END TYPE07,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(H.TYPE) END TYPE08,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(H.TYPE) END TYPE09,    \n "); 

					sql.append( "	               CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(H.ARBALDIV) END ARBALDIV01,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(H.ARBALDIV) END ARBALDIV02,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(H.ARBALDIV) END ARBALDIV03,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(H.ARBALDIV) END ARBALDIV04,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(H.ARBALDIV) END ARBALDIV05,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(H.ARBALDIV) END ARBALDIV06,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(H.ARBALDIV) END ARBALDIV07,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(H.ARBALDIV) END ARBALDIV08,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(H.ARBALDIV) END ARBALDIV09,\n "); 

					sql.append( "		             B.DOCUMCD,RTRIM(E.CDNAM)DOCUMNM, B.FSWRKDIV, B.BANJAEYN, \n ");      
					sql.append( "	               B.WRDT, B.WRID, B.UPDT, B.UPID , A.FSSTAT, B.DOCUVAL \n ");
					sql.append( "					  FROM ACCOUNT.MFSLIPMST A                                                                             \n ");
					sql.append( "					  LEFT JOIN ACCOUNT.MFSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR     \n ");
					sql.append( "					  LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ   \n ");
					sql.append( "					  LEFT JOIN ACCOUNT.ACTCODE D ON D.ATCODE = B.ATCODE                                                  \n ");			
					sql.append( "           LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE= B.DOCUMCD AND E.CMTYPE='0052'  \n ");
					sql.append( "	          LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD = F.CDCODE AND F.CMTYPE='0050'   \n "); 
					sql.append( "	          LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE  \n "); 
					sql.append( "           LEFT JOIN ACCOUNT.ACTREFCODE H ON B.ATCODE = H.ATCODE AND CAST(C.FSREFSEQ AS NUMERIC) = H.ARSEQ \n");
					
					sql.append( "					 WHERE A.FDCODE IS NOT NULL                                                                                         \n ");
					if(!str[0].equals("")) { sql.append( " AND A.FDCODE = '"+str[0]+"' \n "); }                                                  
					if(!str[1].equals("")) { sql.append( " AND A.FSDAT = '"+str[1]+"' \n"); }                                                 
					if(!str[2].equals("")) { sql.append( " AND A.FSNBR = '"+str[2]+"' \n"); }                                                   
					sql.append( "                          ) X                                                                                  \n ");
					sql.append( " GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ,X.ATCODE,X.ATKORNAM,X.ATDECR,X.REMARK,X.CHAAMT,X.DAEAMT,X.DOCUMCD, X.DOCUMNM, X.FSWRKDIV, X.WRDT, X.WRID, X.UPDT, X.UPID,X.BANJAEYN ,X.FSSTAT,X.DOCUVAL \n ");
					sql.append( " ORDER BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ                                                                \n ");
				
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