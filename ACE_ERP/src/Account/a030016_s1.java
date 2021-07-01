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
public class a030016_s1 extends HttpServlet {
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
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//기간fr            
				str[2]	= req.getParameter("v_str3");		//기간to            
				str[3]	= req.getParameter("v_str4");		//계정fr      
				str[4]	= req.getParameter("v_str5");		//계정to
				str[5]	= req.getParameter("v_str6");		//관리항목갯수
				
				for (int s=0;s<=5;s++) {
					if (str[s]==null) str[s] = "";
				}
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "GUBUN","FDCODE","FSDAT","FSNBR","FSSEQ", "ACTDAT", 
					                                "DEAMT","CRAMT","SSDAT","SSNBR", "FSNUM",
					                                "ATCODE","ATKORNAM","REMARK", "JANAMT", "ATDECR",
					                                "FSREFVAL01","FSRVALNM01","FSREFVAL02","FSRVALNM02",
					                                "FSREFVAL03","FSRVALNM03","FSREFVAL04","FSRVALNM04",
					                                "FSREFVAL05","FSRVALNM05","FSREFVAL06","FSRVALNM06",
					                                "FSREFVAL07","FSRVALNM07","FSREFVAL08","FSRVALNM08",
					                                "FSREFVAL09","FSRVALNM09","ATCODE2"

				}; 

				int[] intArrCN = new int[]{  1,  2,  9,  6,  5,  8,
					                          15, 15,  9,  6,  3,
					                           7, 66,130, 15,  1,
					                          30, 40, 30, 40,
					                          30, 40, 30, 40,
					                          30, 40, 30, 40,
					                          30, 40, 30, 40,
					                          30, 40, 7
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, 
					                            0,  0, -1, -1, -1,
					                           -1, -1, -1,  0, -1,
					                           -1, -1, -1, -1,
					                           -1, -1, -1, -1,
					                           -1, -1, -1, -1,
					                           -1, -1, -1, -1,
					                           -1, -1, -1

				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {		
					
					String strdate="";   //
					String stryyyy="";
					String strfrdt="";  //from 일자의 날짜 format

					if (!str[1].substring(4,8).equals("0101")){  //1월1일 조회가 아닌경우
					  
						strfrdt= str[1];
						//strfrdt= str[1].substring(0,4)+"-"+ str[1].substring(4,6)+"-"+ str[1].substring(6,8);
						
						Statement stmt_10 = conn.createStatement();

						String sql_10 = "  SELECT TO_CHAR(TO_DATE( '"+strfrdt +"','YYYYMMDD')-1,'YYYY-MM-DD')  AS T_DATE "
													+ "   FROM DUAL " ; 
						ResultSet rs_10 = stmt_10.executeQuery(sql_10); 
					
						if(rs_10.next()){
							strdate= rs_10.getString(1);
						}
						strdate = strdate.substring(0,4)+ strdate.substring(5,7)+ strdate.substring(8,10);
						stryyyy =strdate.substring(0,4);
					}else{   //1월1일 조회인경우
						strdate = str[1];
						stryyyy = strdate.substring(0,4);
					}

					StringBuffer sql = new StringBuffer();
					
					//전기이월
					sql.append( "  SELECT  'A'GUBUN, ''FDCODE, ''FSDAT, ''FSNBR, ''FSSEQ,'00000000'ACTDAT,      \n " );
					sql.append( "          SUM(DEAMT)DEAMT, SUM(CRAMT)CRAMT,                                    \n " );
					sql.append( "          CASE WHEN D.ATDECR='1' THEN SUM(DEAMT)-SUM(CRAMT)                    \n " );
					sql.append( "               WHEN D.ATDECR='2' THEN SUM(CRAMT)-SUM(DEAMT) END  JANAMT,       \n " );
					sql.append( "          'A10000101' SSDAT, '' SSNBR, '' FSNUM, ''ATDECR,                     \n " );
					sql.append( "          A.ATCODE, '전기이월'ATKORNAM,''REMARK,                               \n " );
					sql.append( "          ''FSREFVAL01,''FSRVALNM01,''FSREFVAL02,''FSRVALNM02,                 \n " );
					sql.append( "          ''FSREFVAL03,''FSRVALNM03,''FSREFVAL04,''FSRVALNM04,                 \n " );
					sql.append( "          ''FSREFVAL05,''FSRVALNM05,''FSREFVAL06,''FSRVALNM06,                 \n " );
					sql.append( "          ''FSREFVAL07,''FSRVALNM07,''FSREFVAL08,''FSRVALNM08,                 \n " );
					sql.append( "          ''FSREFVAL09,''FSRVALNM09, A.ATCODE ATCODE2                          \n " );
					sql.append( "    FROM ACCOUNT.GENENLED A                                                    \n " );
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE  D ON D.ATCODE = A.ATCODE                        \n " );
					sql.append( "   WHERE A.FDCODE IS NOT NULL                                                          \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                       \n " );
					if(!str[1].equals("")&&!str[2].equals("")){
						if (!str[1].substring(4,8).equals("0101")){
						         sql.append( "  AND A.ACTDAT>='"+stryyyy+"0100' AND A.ACTDAT<='"+strdate+"'  \n " );
						}else{
					           sql.append( "  AND A.ACTDAT>='"+stryyyy+"0100' AND A.ACTDAT< '"+strdate+"'  \n " );
						}
					}
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"'  AND A.ATCODE<='"+str[4]+"' \n " );
					sql.append( "   GROUP BY A.ATCODE, D.ATDECR                                                 \n " );
					
					sql.append( "   UNION ALL                                                                   \n " );
					
					sql.append( "  SELECT 'B'GUBUN,X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ,X.ACTDAT,                                                                 \n " );
					sql.append( "         X.DEAMT, X.CRAMT, 0 JANAMT, X.SSDAT, X.SSNBR, X.FSNUM , X.ATDECR,                                                      \n " );
					sql.append( "         MAX(X.ATCODE)ATCODE, MAX(X.ATKORNAM)ATKORNAM, MAX(X.REMARK)REMARK,                                                     \n " );
					sql.append( "         MAX(FSREFVAL01)FSREFVAL01, MAX(FSRVALNM01)FSRVALNM01,                                                                  \n " );
					sql.append( "         MAX(FSREFVAL02)FSREFVAL02, MAX(FSRVALNM02)FSRVALNM02,                                                                  \n " );
					sql.append( "         MAX(FSREFVAL03)FSREFVAL03,                                                                                             \n " );
					sql.append( "         MAX(CASE WHEN RTRIM(FSRVALNM03) IS NULL OR RTRIM(FSRVALNM03)='' THEN FSREFVAL03 ELSE FSRVALNM03 END) AS FSRVALNM03,    \n " );
					sql.append( "         MAX(FSREFVAL04)FSREFVAL04,                                                                                             \n " );
					sql.append( "         MAX(CASE WHEN RTRIM(FSRVALNM04) IS NULL OR RTRIM(FSRVALNM04)='' THEN FSREFVAL04 ELSE FSRVALNM04 END) AS FSRVALNM04,    \n " );
					sql.append( "         MAX(FSREFVAL05)FSREFVAL05,                                                                                             \n " );
					sql.append( "         MAX(CASE WHEN RTRIM(FSRVALNM05) IS NULL OR RTRIM(FSRVALNM05)='' THEN FSREFVAL05 ELSE FSRVALNM05 END) AS FSRVALNM05,    \n " );
					sql.append( "         MAX(FSREFVAL06)FSREFVAL06,                                                                                             \n " );
					sql.append( "         MAX(CASE WHEN RTRIM(FSRVALNM06) IS NULL OR RTRIM(FSRVALNM06)='' THEN FSREFVAL06 ELSE FSRVALNM06 END) AS FSRVALNM06,    \n " );
					sql.append( "         MAX(FSREFVAL07)FSREFVAL07,                                                                                             \n " );
					sql.append( "         MAX(CASE WHEN RTRIM(FSRVALNM07) IS NULL OR RTRIM(FSRVALNM07)='' THEN FSREFVAL07 ELSE FSRVALNM07 END) AS FSRVALNM07,    \n " );
					sql.append( "         MAX(FSREFVAL08)FSREFVAL08,                                                                                             \n " );
					sql.append( "         MAX(CASE WHEN RTRIM(FSRVALNM08) IS NULL OR RTRIM(FSRVALNM08)='' THEN FSREFVAL08 ELSE FSRVALNM08 END) AS FSRVALNM08,    \n " );
					sql.append( "         MAX(FSREFVAL09)FSREFVAL09,                                                                                             \n " );
					sql.append( "         MAX(CASE WHEN RTRIM(FSRVALNM09) IS NULL OR RTRIM(FSRVALNM09)='' THEN FSREFVAL09 ELSE FSRVALNM09 END) AS FSRVALNM09,     \n " );
					sql.append( "         MAX(X.ATCODE) ATCODE2 \n " );
					sql.append( "     FROM(                                                                                             \n " );
					sql.append( "           SELECT A.FDCODE, A.ACTDAT, A.FSDAT,   A.FSNBR, A.FSSEQ,                                     \n " );
					sql.append( "                  A.ATCODE, D.ATKORNAM ATKORNAM, A.DEAMT, A.CRAMT,                                     \n " );
					sql.append( "                  H.SSDAT,  H.SSNBR, D.ATDECR,                                                         \n " );
					sql.append( "                  B.FSREFCD, B.FSREFVAL, C.FSREFSEQ,H.FSNUM,H.REMARK,                                  \n " );
					if(str[5].equals("2")){
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                           \n " );
					sql.append( "									 ''FSREFVAL03,''FSREFVAL04,''FSREFVAL05,''FSREFVAL06,                                 \n " );
					sql.append( "									 ''FSREFVAL07,''FSREFVAL08,''FSREFVAL09,                                              \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,                       \n " );
					sql.append( "									 ''FSRVALNM03,''FSRVALNM04,''FSRVALNM05,''FSRVALNM06,                                 \n " );
					sql.append( "									 ''FSRVALNM07,''FSRVALNM08,''FSRVALNM09                                               \n " );
					}else if(str[5].equals("3")){
 					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,                           \n " );
					sql.append( "                  ''FSREFVAL04,''FSREFVAL05,''FSREFVAL06, ''FSREFVAL07, ''FSREFVAL08, ''FSREFVAL09,    \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,                       \n " );
					sql.append( "                  ''FSRVALNM04,''FSRVALNM05,''FSRVALNM06,''FSRVALNM07,''FSRVALNM08,''FSRVALNM09        \n " );
					}else if(str[5].equals("4")){
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,                           \n " );
					sql.append( "                  ''FSREFVAL05,''FSREFVAL06, ''FSREFVAL07, ''FSREFVAL08, ''FSREFVAL09,                 \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,                       \n " );
					sql.append( "                  ''FSRVALNM05,''FSRVALNM06,''FSRVALNM07,''FSRVALNM08,''FSRVALNM09                     \n " );
					}else if(str[5].equals("5")){
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05,                           \n " );
					sql.append( "                  ''FSREFVAL06, ''FSREFVAL07, ''FSREFVAL08, ''FSREFVAL09,                              \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05,                       \n " );
					sql.append( "                  ''FSRVALNM06,''FSRVALNM07,''FSRVALNM08,''FSRVALNM09                                  \n " );
					}else if(str[5].equals("6")){
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06,                           \n " );
					sql.append( "                  ''FSREFVAL07, ''FSREFVAL08, ''FSREFVAL09,                                            \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06,                       \n " );
					sql.append( "                  ''FSRVALNM07,''FSRVALNM08,''FSRVALNM09                                               \n " );
					}else if(str[5].equals("7")){ 
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06,                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07,                           \n " );
					sql.append( "                  ''FSREFVAL08,''FSREFVAL09,                                                           \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06,                       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(G.CDNAM) END FSRVALNM07,                       \n " );
					sql.append( "                  ''FSRVALNM08,''FSRVALNM09                                                            \n " );
					}else if(str[5].equals("8")){
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,                         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,                         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05,                         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06,                         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07,                         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFVAL END FSREFVAL08,                         \n " );
					sql.append( "                  ''FSREFVAL09,                                                                      \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05,         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06,         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(G.CDNAM) END FSRVALNM07,         \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(G.CDNAM) END FSRVALNM08,         \n " );
					sql.append( "                  ''FSRVALNM09                                                            \n " );
					}else if(str[5].equals("9")){
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFVAL END FSREFVAL08,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFVAL END FSREFVAL09,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(G.CDNAM) END FSRVALNM07,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(G.CDNAM) END FSRVALNM08,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(G.CDNAM) END FSRVALNM09    \n " );
					}else{
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFVAL END FSREFVAL08,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFVAL END FSREFVAL09,       \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(G.CDNAM) END FSRVALNM07,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(G.CDNAM) END FSRVALNM08,   \n " );
					sql.append( "                  CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(G.CDNAM) END FSRVALNM09    \n " );
					}
					sql.append( "              FROM ACCOUNT.GENENLED A                                                                                                    \n " );
					sql.append( "              LEFT JOIN ACCOUNT.GENENREF B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR AND A.FSSEQ = B.FSSEQ      \n " );
					sql.append( "              LEFT JOIN ACCOUNT.FSLIPREF C ON B.FDCODE = C.FDCODE AND B.FSDAT = C.FSDAT AND B.FSNBR = C.FSNBR                            \n " );
					sql.append( "                                          AND B.FSSEQ = C.FSSEQ   AND B.FSREFCD = C.FSREFCD                                              \n " );
					sql.append( "              LEFT JOIN ACCOUNT.ACTCODE  D ON D.ATCODE = A.ATCODE                                                                        \n " );
					sql.append( "              LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE                                               \n " );
					sql.append( "              LEFT JOIN ACCOUNT.FSLIPDTL H ON A.FDCODE = H.FDCODE AND A.FSDAT = H.FSDAT                                                  \n " );
					sql.append( "                                          AND A.FSNBR = H.FSNBR   AND A.FSSEQ = H.FSSEQ                                                  \n " );
					sql.append( "        WHERE A.FDCODE IS NOT NULL                                                                                                               \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                                                                 \n " );
					if(!str[1].equals("")&&!str[2].equals(""))sql.append( "  AND A.ACTDAT>='"+str[1]+"' AND A.ACTDAT<='"+str[2]+"'                                                  \n " );
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"'  AND A.ATCODE<='"+str[4]+"'                                                 \n " );
					sql.append( "    ) X                                                                                                                                  \n " );
					sql.append( "    GROUP BY X.FDCODE, X.FSDAT, X.FSNBR,X.FSSEQ,X.DEAMT,X.CRAMT,X.ACTDAT,X.SSDAT, X.SSNBR ,X.FSNUM,X.ATDECR                              \n " );
					
					//월계
					sql.append( "  UNION ALL  \n " );
					
					sql.append( "  SELECT  'M'GUBUN,''FDCODE, ''FSDAT, ''FSNBR, ''FSSEQ,SUBSTR(A.ACTDAT,1,6)||98 ACTDAT,                 \n " );
					sql.append( "          SUM(DEAMT)DEAMT, SUM(CRAMT)CRAMT,0 JANAMT, 'A90000101' SSDAT, ''SSNBR, '' FSNUM, D.ATDECR,    \n " );
					sql.append( "          A.ATCODE, '       월    계'ATKORNAM,''REMARK,                                                 \n " );
					sql.append( "          ''FSREFVAL01,''FSRVALNM01,''FSREFVAL02,''FSRVALNM02,                               \n " );
					sql.append( "          ''FSREFVAL03,''FSRVALNM03,''FSREFVAL04,''FSRVALNM04,                               \n " );
					sql.append( "          ''FSREFVAL05,''FSRVALNM05,''FSREFVAL06,''FSRVALNM06,                               \n " );
					sql.append( "          ''FSREFVAL07,''FSRVALNM07,''FSREFVAL08,''FSRVALNM08,                               \n " );
					sql.append( "          ''FSREFVAL09,''FSRVALNM09, A.ATCODE ATCODE2                                                          \n " );
					sql.append( "    FROM ACCOUNT.GENENLED A                                                                  \n " );
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE  D ON D.ATCODE = A.ATCODE                                      \n " );
					sql.append( "   WHERE A.FDCODE IS NOT NULL                                                                        \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                     \n " );
					if(!str[1].equals("")&&!str[2].equals(""))sql.append( "  AND A.ACTDAT>='"+str[1]+"' AND A.ACTDAT<='"+str[2]+"'      \n " );
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"'  AND A.ATCODE<='"+str[4]+"'     \n " );
					sql.append( "   GROUP BY A.ATCODE, SUBSTR(A.ACTDAT,1,6)||98,D.ATDECR                                      \n " );
				
					//누계
					sql.append( "  UNION ALL  \n " );
					sql.append( "  SELECT  'T'GUBUN,''FDCODE, ''FSDAT, ''FSNBR, ''FSSEQ,SUBSTR(A.ACTDAT,1,6)||99 ACTDAT,               \n " );
					sql.append( "          SUM(DEAMT)DEAMT, SUM(CRAMT)CRAMT, 0 JANAMT, 'A99000101' SSDAT, ''SSNBR,'' FSNUM, D.ATDECR,  \n " );
					sql.append( "          A.ATCODE, '       누    계'ATKORNAM,''REMARK,                                               \n " );
					sql.append( "          ''FSREFVAL01,''FSRVALNM01,''FSREFVAL02,''FSRVALNM02,                                \n " );
					sql.append( "          ''FSREFVAL03,''FSRVALNM03,''FSREFVAL04,''FSRVALNM04,                                \n " );
					sql.append( "          ''FSREFVAL05,''FSRVALNM05,''FSREFVAL06,''FSRVALNM06,                                \n " );
					sql.append( "          ''FSREFVAL07,''FSRVALNM07,''FSREFVAL08,''FSRVALNM08,                                \n " );
					sql.append( "          ''FSREFVAL09,''FSRVALNM09, A.ATCODE ATCODE2                                                           \n " );
					sql.append( "    FROM ACCOUNT.GENENLED A                                                                   \n " );
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE  D ON D.ATCODE = A.ATCODE                                       \n " );
					sql.append( "   WHERE A.FDCODE IS NOT NULL                                                                         \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                      \n " );
					if(!str[1].equals("")&&!str[2].equals(""))sql.append( "  AND A.ACTDAT>='"+str[1]+"' AND A.ACTDAT<='"+str[2]+"'       \n " );
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"'  AND A.ATCODE<='"+str[4]+"'      \n " );
					sql.append( "   GROUP BY A.ATCODE, SUBSTR(A.ACTDAT,1,6)||99,D.ATDECR                                       \n " );
					
					sql.append( "   ORDER BY ATCODE,ACTDAT,SSDAT, SSNBR, FSNUM                                              \n " );
					
					//System.out.println("a030016_s1: " + sql.toString());		
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