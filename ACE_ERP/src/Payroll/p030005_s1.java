package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p030005_s1 extends HttpServlet {

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

				String [] str= new String[10] ;
        str[0] = req.getParameter("v_str1");  //귀속년도
				str[1] = req.getParameter("v_str2");	//부서
				str[2] = req.getParameter("v_str3");	//성명
				str[3] = req.getParameter("v_str4");	//Level
				str[4] = req.getParameter("v_str5");	//treecd
				str[5] = req.getParameter("v_str6");	//귀속연도
				str[6] = req.getParameter("v_str7");	//사번

		  	for (int s=0;s<=6;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",	     "EMPNO",	     "EMPNMK",			"PAYGRD",      	"PAYSEQ",
																					"CADDR01",	   "CADDR02",	   "CADDNM",			"RESINO",			  "PC11000",	  "PC12000",
																					"PC13000",	   "PC10000",	   "BCWKNM1",			"BCRESINO1",		"BC11000",	
																					"BC12000",	   "BC13000",	   "BC10000",	    "BCWKNM2",			"BCRESINO2",	
																					"BC21000",	   "BC22000",	   "BC23000",	    "BC20000",	    "PBC1000",	
																					"PBC2000",	   "PBC3000",	   "TWKSUM",	    "PC21000",	    "PC22000",    "PC23000",
																					"PC20000",	   "PB10000",	   "PB20000",	    "PB30000",	    "BA0101YN",	
																					"BA0102CNT",	 "BA0103CNT",	 "BA0104CNT",		"BA0105CNT",		"AD0101CNT",
																					"AD0102CNT",	 "AD0103CNT",	 "AD0104YN",	  "AD0105CNT",	  "BAAMT01",
																					"BAAMT02",	   "BAAMT03",	   "BASUM",	      "ADAMT01",	    "ADAMT02",	
																					"ADAMT03",	   "ADAMT04",	   "ADAMT05",		   "ADSUM",				"PENSUM",	
																					"INSAMT01",	   "INSAMT02",	 "INSAMT03",	  "INSAMT04",			"INSSUM",	
																					"MEDAMT01",	   "MEDAMT02",	 "MEDSUM",	    "EDUAMT01",			"EDUAMT02",
																					"EDUAMT021",	 "EDUAMT022",	 "EDUAMT023",		"EDUAMT024",		"EDUAMT025",
																					"EDUAMT03",	   "EDUAMT031",	 "EDUAMT032",		"EDUAMT033",		"EDUAMT034",
																					"EDUAMT035",	 "EDUAMT04",	 "EDUAMT041",		"EDUAMT042",		"EDUAMT043",
																					"EDUAMT044",	 "EDUAMT045",	 "EDUAMT05",		"EDUAMT051",		"EDUAMT052",
																					"EDUAMT053",	 "EDUAMT054",	 "EDUAMT055",		"EDUSUM",	      "HOUAMT01",	
																					"HOUAMT02",	   "HOUAMT03",	 "HOUAMT04",		"HOUSUM",				"CONAMT01",	
																					"CONAMT02",	   "CONAMT03",	 "CONAMT04",		"CONAMT05",			"CONAMT06",	
																					"CONSUM",	     "MARCNT01",	 "MARCNT02",		"MARCNT03",			"MARSUM",	
																					"SPCSUM",	     "STDSUM",	   "OFFSUM",	    "ETCAMT011",		"ETCAMT01",
																					"ETCAMT02",	   "ETCAMT031",  "ETCAMT032",		"ETCAMT033",		"ETCAMT034",	
																					"ETCAMT03S",	 "ETCAMT04",	 "ETCSUM",	    "TSTDSUM",	    "STDTAX",	   "REDAMT01",	
																					"REDAMT02",	   "REDSUM",	   "DEDAMT01",		"DEDAMT02",			"DEDAMT03",
																					"DEDAMT04",	   "DEDAMT05",	 "DEDSUM",	    "PB40000",	    "PB41000",	
																					"PB42000",	   "PB43000",	   "PB51000",	    "PB52000",	    "PB53000",	
																					"PB50000",	   "PB61000",	   "PB62000",	    "PB63000",	    "PB60000",	
																					"PB71000",	   "PB72000",	   "PB73000",	    "PB70000",	    "CASHSUM",	
																					"RELAT1",	     "FAMNM1",	   "RESINO1",	    "RELAT2",	      "FAMNM2",	
																					"RESINO2",	   "RELAT3",	   "FAMNM3",	    "RESINO3",	    "RELAT4",	
																					"FAMNM4",	     "RESINO4",	   "RELAT5",	    "FAMNM5",	      "RESINO5",	
																					"RELAT6",	     "FAMNM6",	   "RESINO6",	    "RELAT7",	      "FAMNM7",	
																					"RESINO7",	   "RELAT8",	   "FAMNM8",	    "RESINO8",	    "RELAT9",	
																					"FAMNM9",	     "RESINO9",	   "PROSTS",
					                                "PAYGRDNM",	   "DEPTNM",	   "PAYSEQNM",		"STRTDT",	      "ENDDT",		"RESSUM",
																					"TOTCNT01",		 "TOTCNT02",
																					"ETCAMT01S",	 "ETCAMT02S",	 "ETCAMT03S",		"ETCAMT04S",		
																					"REF11", "REF12", "REF13", "REF14", "REF15", "REF16", "REF17",	"REF18",
																					"REF21", "REF22", "REF23", "REF24", "REF25", "REF26", "REF27",	"REF28",
																					"REF31", "REF32", "REF33", "REF34", "REF35", "REF36", "REF37",	"REF38",
																					"REF41", "REF42", "REF43", "REF44", "REF45", "REF46", "REF47",	"REF48",
																					"REF51", "REF52", "REF53", "REF54", "REF55", "REF56", "REF57",	"REF58",
																					"REF61", "REF62", "REF63", "REF64", "REF65", "REF66", "REF67",	"REF68",
																					"REF71", "REF72", "REF73", "REF74", "REF75", "REF76", "REF77",	"REF78",
																					"REF81", "REF82", "REF83", "REF84", "REF85", "REF86", "REF87",  "REF88",
																					"REF91", "REF92", "REF93", "REF94", "REF95", "REF96", "REF97",  "REF98",
																					"ETCAMT011S","BA0101CNT","AD0106CNT","CURDT3",
																					"DEDAMT01S", "DEDAMT02S",	"DEDAMT03S",	"DEDAMT04S",	"DEDAMT05S",
																					"ADAMT05S",  "PENSUMS",		"REDAMT01S",	"REDAMT02S","ETCAMT05", "RCNT",
																					"AD0107CNT", "ADAMT07","ETCAMT05","HOUAMT02S","HOUAMT34S","HOUAMT01S","FNDSUMS",
																					
																					"BFSTRDT1","BP141000","BP142000","BP143000","BFSTRDT2","BP241000","BP242000","BP243000",
																					"BTAXAMT101","BTAXAMT201","HOUAMT05"
                                         // "TREF11","TREF12","TREF13","TREF14","TREF15","TREF16",
					                               // "TREF21","TREF22","TREF23","TREF24","TREF25","TREF26", "TCNT"
				};  
					                              
				int[] intArrCN = new int[]{ 6,	7,	20,	4,	4,	
																		70,	70,140,	13,12,	9,
																		9,	12,	30,	20,	9,	
																		9,	9,	9,	30,	20,	
																		9,	9,	9,	9,	12,
																		9,	9, 12,	9,  9,	9,	
																		9, 12,	9,	9,	1,	
																		2,	2,	2,	2,	2,
																		2,	2,	1,	2,	9,	
																		9,	9,	9,	9,	9,
																		9,	9,	9,	9,	9,
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	2,	
																		9,	9,	9,	9,	9,	
																		2,	9,	9,	9,	9,	
																		9,	2,	9,	9,	9,	
																		9,	9,	2,	9,	9,	
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9,
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9,
																		9,	9,	9,	9,	9, 9,
																		9,	9,	9,	9,	9,
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9,
																		9,	9, 12,	9,	12,
																		9,	9,	9,	9,	9,	
																		1,	20,	13,	1,	20,
																		13,	1,	20,	13,	1,	
																		20,	13,	1,	20,	13,
																		1,	20,	13,	1,	20,
																		13,	1,	20,	13,	1,
																		20,	13,	1,
																		30,	70,	30,	8,	8,	9,
																		3,  3,
																		9,	9,	9,	9,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		1,  1,  1,  1,  1,  1,  1,  1,
																		9,  2,  2,  8,
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9,	4,
																		2,	9,	9,	9,	18,	9,	9,          
																	   
																		17, 9, 9, 9, 17, 9, 9, 9,
																		9,9,9

					                          //9,	9,	9,	9, 9, 9,
					                          //9,	9,	9,	9, 9, 9,  4
					}; 
			
				int[] intArrCN2 = new int[]{-1,	-1,	-1,	-1,	-1,	
																		-1,	-1,	-1, -1,	 0,	 0,	
																		 0,	 0,	-1,	-1,	 0,
																		 0,	 0,	 0,	-1,	-1,	
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,  0,  0,	
																		 0,	 0,	 0,	 0,	-1,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	-1,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,  0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,  0,	 0,	 0,	
																		 0,	 0,	 0,  0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,  0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,
																	 	 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		-1,	-1,	-1,	-1,	-1,
																		-1,	-1,	-1,	-1,	-1,
																		-1,	-1,	-1,	-1,	-1,
																		-1,	-1,	-1,	-1,	-1,	
																		-1,	-1,	-1,	-1,	-1,	
																		-1,	-1,	-1,
					                          -1,	-1,	-1,	-1,	-1,	 0,
																		 0,  0,
																		 0,	 0,	 0,	 0,	// 0
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		 -1,	-1,	-1,	-1,	-1,	 -1, -1,	-1,
																		  0,   0,	 0, -1,
																		  0,	 0,	 0,	 0,	 0,	
																		  0,	 0,	 0,	 0,	0,	0,
																		  0,	 0,	 0,	 0,	0,	0,	0,      
																		 
																	      -1,0,0,0,-1,0,0,0,
																			0,0,0

																		//	0,	 0,	 0,	 0,	0, 0,
																		//	0,	 0,	 0,	 0,	0, 0, 0 
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();


          sql.append(" SELECT                                                                                                                                         \n");
					sql.append(" A.APPDT,      (A.EMPNO)EMPNO ,    A.EMPNMK,    A.PAYGRD,    A.PAYSEQ,                                                                                  \n");
					sql.append(" A.CADDR01,    A.CADDR02,  RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS CADDNM,                                                               \n");
					sql.append(" A.RESINO,                                                                                                                                      \n");
					sql.append(" --현근무처                                                                                                                                     \n");
					sql.append(" A.PC11000,    A.PC12000,  A.PC13000,   A.PC10000,                                                                                              \n");
					sql.append(" --전근무처1                                                                                                                                    \n");
					sql.append(" A.BCWKNM1,                                                                                                                                     \n");
					sql.append(" CASE WHEN BCRESINO1 <> '' THEN SUBSTR(BCRESINO1,1,3) || '-' || SUBSTR(BCRESINO1,4,2) || '-' ||SUBSTR(BCRESINO1,6,5) ELSE '' END AS BCRESINO1,  \n");
					sql.append(" A.BC11000,    A.BC12000,  A.BC13000,   A.BC10000,                                                                                              \n");
					sql.append(" --전근무처2                                                                                                                                    \n");
					sql.append(" A.BCWKNM2,                                                                                                                                     \n");
					sql.append(" CASE WHEN BCRESINO2 <> '' THEN SUBSTR(BCRESINO2,1,3) || '-' || SUBSTR(BCRESINO2,4,2) || '-' ||SUBSTR(BCRESINO2,6,5) ELSE '' END AS BCRESINO2,  \n");
					sql.append(" A.BC21000,    A.BC22000,  A.BC23000,   A.BC20000,                                                                                              \n");
					sql.append(" --급여, 상여, 인정상여 계                                                                                                                      \n");
          sql.append(" A.PBC1000,    A.PBC2000,  A.PBC3000,                                                                                                           \n");
					sql.append(" --근무별 소득명세계                                                                                                                            \n");
					sql.append(" A.TWKSUM,                                                                                                                                      \n");
					sql.append(" --비과세소득                                                                                                                                   \n");
					sql.append(" A.PC21000,    A.PC22000,  A.PC23000,   A.PC20000,                                                                                              \n");
					sql.append(" --총급여, 근로소득공제, 근로소득금액                                                                                                           \n");
					sql.append(" A.PB10000,    A.PB20000,  A.PB30000,                                                                                                           \n");
					sql.append(" A.BA0101YN,                                                                                                                                    \n");
					sql.append(" COALESCE(A.BA0102CNT,0) BA0102CNT,                                                                                                             \n");
					sql.append(" COALESCE(A.BA0103CNT,0) BA0103CNT,  COALESCE(A.BA0104CNT,0) BA0104CNT,                                                                         \n");
					sql.append(" COALESCE(A.BA0105CNT,0) BA0105CNT,  COALESCE(A.AD0101CNT,0) AD0101CNT,                                                                         \n");
					sql.append(" COALESCE(A.AD0102CNT,0) AD0102CNT,  COALESCE(A.AD0103CNT,0) AD0103CNT,                                                                         \n");
					sql.append(" COALESCE(A.AD0104YN,0)  AD0104YN,   COALESCE(A.AD0105CNT,0) AD0105CNT,                                                                         \n");
					sql.append(" COALESCE(A.BAAMT01,0)   BAAMT01,    COALESCE(A.BAAMT02,0)   BAAMT02,   COALESCE(A.BAAMT03,0)  BAAMT03,  COALESCE(A.BASUM,0)    BASUM,          \n");
					sql.append(" COALESCE(A.ADAMT01,0)   ADAMT01,    COALESCE(A.ADAMT02,0)   ADAMT02,   COALESCE(A.ADAMT03,0)  ADAMT03,  COALESCE(A.ADAMT04,0)  ADAMT04,        \n");
          sql.append(" COALESCE(A.ADAMT05,0)   ADAMT05,    COALESCE(A.ADSUM,0)     ADSUM,     COALESCE(A.PENSUM,0)   PENSUM,                                          \n");
					sql.append(" COALESCE(A.INSAMT01,0)  INSAMT01,   COALESCE(A.INSAMT02,0)  INSAMT02,  COALESCE(A.INSAMT03,0) INSAMT03, COALESCE(A.INSAMT04,0) INSAMT04,       \n");
					sql.append(" COALESCE(A.INSSUM,0)    INSSUM,                                                                                                                \n");
					sql.append(" COALESCE(A.MEDAMT01,0)  MEDAMT01,   COALESCE(A.MEDAMT02,0) MEDAMT02,   COALESCE(A.MEDSUM,0)    MEDSUM,                                         \n");
					sql.append(" COALESCE(A.EDUAMT01,0)  EDUAMT01,                                                                                                              \n");
					sql.append(" COALESCE(A.EDUAMT02,0)  EDUAMT02,   COALESCE(A.EDUAMT021,0) EDUAMT021, COALESCE(A.EDUAMT022,0) EDUAMT022,                                      \n");
					sql.append(" COALESCE(A.EDUAMT023,0) EDUAMT023,  COALESCE(A.EDUAMT024,0) EDUAMT024, COALESCE(A.EDUAMT025,0) EDUAMT025,                                      \n");
					sql.append(" COALESCE(A.EDUAMT03,0)  EDUAMT03,   COALESCE(A.EDUAMT031,0) EDUAMT031, COALESCE(A.EDUAMT032,0) EDUAMT032,                                      \n");
					sql.append(" COALESCE(A.EDUAMT033,0) EDUAMT033,  COALESCE(A.EDUAMT034,0) EDUAMT034, COALESCE(A.EDUAMT035,0) EDUAMT035,                                      \n");
					sql.append(" COALESCE(A.EDUAMT04,0)  EDUAMT04,   COALESCE(A.EDUAMT041,0) EDUAMT041, COALESCE(A.EDUAMT042,0) EDUAMT042,                                      \n");
					sql.append(" COALESCE(A.EDUAMT043,0) EDUAMT043,  COALESCE(A.EDUAMT044,0) EDUAMT044, COALESCE(A.EDUAMT045,0) EDUAMT045,                                      \n");
					sql.append(" COALESCE(A.EDUAMT05,0)  EDUAMT05,   COALESCE(A.EDUAMT051,0) EDUAMT051, COALESCE(A.EDUAMT052,0) EDUAMT052, COALESCE(A.EDUAMT053,0) EDUAMT053,   \n");
					sql.append(" COALESCE(A.EDUAMT054,0) EDUAMT054,  COALESCE(A.EDUAMT055,0) EDUAMT055, COALESCE(A.EDUSUM,0)    EDUSUM,                                         \n");
					sql.append(" COALESCE(A.HOUAMT01,0)  HOUAMT01,   COALESCE(A.HOUAMT02,0)  HOUAMT02,  COALESCE(A.HOUAMT03,0)  HOUAMT03,                                       \n");
					sql.append(" COALESCE(A.HOUAMT04,0)  HOUAMT04,   COALESCE(A.HOUAMT05,0)  HOUAMT05  ,COALESCE(A.HOUSUM,0)    HOUSUM,                                                                            \n");
          sql.append(" COALESCE(A.CONAMT01,0)  CONAMT01,   COALESCE(A.CONAMT02,0)  CONAMT02,  COALESCE(A.CONAMT03,0)  CONAMT03,                                       \n");
					sql.append(" COALESCE(A.CONAMT04,0)  CONAMT04,   COALESCE(A.CONAMT05,0)  CONAMT05,  COALESCE(A.CONAMT06,0)  CONAMT06,  COALESCE(A.CONSUM,0)    CONSUM,      \n");
					sql.append(" COALESCE(A.MARCNT01,0)  MARCNT01,   COALESCE(A.MARCNT02,0)  MARCNT02,  COALESCE(A.MARCNT03,0)  MARCNT03,  COALESCE(A.MARSUM,0)    MARSUM,      \n");
					sql.append(" COALESCE(A.SPCSUM,0)    SPCSUM,     COALESCE(A.STDSUM,0)    STDSUM,    COALESCE(A.OFFSUM,0)    OFFSUM,                                         \n");
					sql.append(" COALESCE(A.ETCAMT011,0) ETCAMT011,  COALESCE(A.ETCAMT01,0)  ETCAMT01,  COALESCE(A.ETCAMT02,0)  ETCAMT02,                                       \n");
					sql.append(" COALESCE(A.ETCAMT031,0) ETCAMT031,  COALESCE(A.ETCAMT032,0) ETCAMT032, COALESCE(A.ETCAMT033,0) ETCAMT033,                                      \n");
					sql.append(" COALESCE(A.ETCAMT034,0) ETCAMT034,  COALESCE(A.ETCAMT03S,0) ETCAMT03S,                                                                         \n");
					sql.append(" COALESCE(A.ETCAMT04,0)  ETCAMT04,   COALESCE(A.ETCSUM,0)    ETCSUM,    COALESCE(A.TSTDSUM,0)   TSTDSUM,   COALESCE(A.STDTAX,0)    STDTAX,      \n");
					sql.append(" COALESCE(A.REDAMT01,0)  REDAMT01,   COALESCE(A.REDAMT02,0)  REDAMT02,  COALESCE(A.REDSUM,0)    REDSUM,                                         \n");
					sql.append(" COALESCE(A.DEDAMT01,0)  DEDAMT01,   COALESCE(A.DEDAMT02,0)  DEDAMT02,  COALESCE(A.DEDAMT03,0)  DEDAMT03,  COALESCE(A.DEDAMT04,0)  DEDAMT04,    \n");
					sql.append(" COALESCE(A.DEDAMT05,0)  DEDAMT05,   COALESCE(A.DEDSUM,0)    DEDSUM,                                                                            \n");
					sql.append(" COALESCE(A.PB40000,0)   PB40000,    COALESCE(A.PB41000,0)   PB41000,   COALESCE(A.PB42000,0)   PB42000,   COALESCE(A.PB43000,0)   PB43000,     \n");
					sql.append(" COALESCE(A.PB51000,0)   PB51000,    COALESCE(A.PB52000,0)   PB52000,   COALESCE(A.PB53000,0)   PB53000,   COALESCE(A.PB50000,0)   PB50000,     \n");
					sql.append(" COALESCE(A.PB61000,0)   PB61000,    COALESCE(A.PB62000,0)   PB62000,   COALESCE(A.PB63000,0)   PB63000,   COALESCE(A.PB60000,0)   PB60000,     \n");
					sql.append(" COALESCE(A.PB71000,0)   PB71000,    COALESCE(A.PB72000,0)   PB72000,   COALESCE(A.PB73000,0)   PB73000,   COALESCE(A.PB70000,0)   PB70000,     \n");
          sql.append(" COALESCE(A.CASHSUM,0)   CASHSUM,                                                                                                               \n");
 					sql.append(" RTRIM(A.RELAT1) RELAT1,  RTRIM(A.FAMNM1) FAMNM1,   A.RESINO1,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT2) RELAT2,  RTRIM(A.FAMNM2) FAMNM2,   A.RESINO2,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT3) RELAT3,  RTRIM(A.FAMNM3) FAMNM3,   A.RESINO3,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT4) RELAT4,  RTRIM(A.FAMNM4) FAMNM4,   A.RESINO4,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT5) RELAT5,  RTRIM(A.FAMNM5) FAMNM5,   A.RESINO5,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT6) RELAT6,  RTRIM(A.FAMNM6) FAMNM6,   A.RESINO6,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT7) RELAT7,  RTRIM(A.FAMNM7) FAMNM7,   A.RESINO7,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT8) RELAT8,  RTRIM(A.FAMNM8) FAMNM8,   A.RESINO8,                                                                                  \n");
					sql.append(" RTRIM(A.RELAT9) RELAT9,  RTRIM(A.FAMNM9) FAMNM9,   A.RESINO9,                                                                                  \n");
					sql.append(" A.PROSTS,  RTRIM(C.MINORNM) AS PAYGRDNM,  D.DEPTNM,  RTRIM(E.MINORNM) AS PAYSEQNM,                                                             \n");
					sql.append(" A.STRTDT,  A.ENDDT,      COALESCE(A.STDTAX-A.REDSUM-A.DEDSUM,0) AS RESSUM,                                                                     \n");
					sql.append(" COALESCE(A.BA0101YN+A.BA0102CNT+A.BA0103CNT+A.BA0104CNT+A.BA0105CNT,0) AS TOTCNT01,                                                            \n");
					sql.append(" COALESCE(A.AD0101CNT+A.AD0102CNT,0) AS TOTCNT02,                                                                                               \n");
					sql.append(" COALESCE(A.ETCAMT01S,0)ETCAMT01S, COALESCE(A.ETCAMT02S,0)ETCAMT02S, COALESCE(A.ETCAMT03S,0)ETCAMT03S, COALESCE(A.ETCAMT04S,0)ETCAMT04S,        \n");
          sql.append(" A.REF11,A.REF12,A.REF13,A.REF14,A.REF15,A.REF16,A.REF17,A.REF18,                                                                               \n");
					sql.append(" A.REF21,A.REF22,A.REF23,A.REF24,A.REF25,A.REF26,A.REF27,A.REF28,                                                                               \n");
					sql.append(" A.REF31,A.REF32,A.REF33,A.REF34,A.REF35,A.REF36,A.REF37,A.REF38,                                                                               \n");
					sql.append(" A.REF41,A.REF42,A.REF43,A.REF44,A.REF45,A.REF46,A.REF47,A.REF48,                                                                               \n");
					sql.append(" A.REF51,A.REF52,A.REF53,A.REF54,A.REF55,A.REF56,A.REF57,A.REF58,                                                                               \n");
					sql.append(" A.REF61,A.REF62,A.REF63,A.REF64,A.REF65,A.REF66,A.REF67,A.REF68,                                                                               \n");
					sql.append(" A.REF71,A.REF72,A.REF73,A.REF74,A.REF75,A.REF76,A.REF77,A.REF78,                                                                               \n");
					sql.append(" A.REF81,A.REF82,A.REF83,A.REF84,A.REF85,A.REF86,A.REF87,A.REF88,                                                                               \n");
					sql.append(" A.REF91,A.REF92,A.REF93,A.REF94,A.REF95,A.REF96,A.REF97,A.REF98,                                                                               \n");
					sql.append(" COALESCE(A.ETCAMT011S,0)ETCAMT011S,                                                                                                            \n");
					sql.append(" COALESCE(A.BA0101CNT+A.BA0102CNT+A.BA0103CNT+A.BA0104CNT+A.BA0105CNT,0)BA0101CNT,COALESCE(A.AD0106CNT,0)AD0106CNT,                             \n");
					sql.append(" CASE WHEN SUBSTR(A.STRTDT,1,4)  = '2009' THEN A.STRTDT                                                                                         \n");
					sql.append("      WHEN SUBSTR(A.STRTDT,1,4) != '2009' THEN '2009' || '0101'                                                                                 \n");
					sql.append(" END AS CURDT3,                                                                                                                                 \n");
					sql.append(" COALESCE(A.DEDAMT01S,0)DEDAMT01S,  COALESCE(A.DEDAMT02S,0)DEDAMT02S,  COALESCE(A.DEDAMT03S,0)DEDAMT03S,                                        \n");
          sql.append(" COALESCE(A.DEDAMT04S,0)DEDAMT04S,  COALESCE(A.DEDAMT05S,0)DEDAMT05S,                                                                           \n");
					sql.append(" COALESCE(A.ADAMT05S,0)ADAMT05S,    COALESCE(A.PENSUMS,0)PENSUMS,                                                                               \n");
					sql.append(" COALESCE(A.REDAMT01S,0)REDAMT01S,  COALESCE(A.REDAMT02S,0)REDAMT02S,  COALESCE(A.ETCAMT05,0) ETCAMT05, 0 RCNT,                                 \n");
					sql.append("                                                                                                                                                \n");
					sql.append(" COALESCE(A.AD0107CNT,0) AD0107CNT, COALESCE(A.ADAMT07,0)   ADAMT07,   COALESCE(A.ETCAMT05,0) ETCAMT05,                                         \n");
					sql.append(" COALESCE(A.HOUAMT02S,0) HOUAMT02S, COALESCE(A.HOUAMT03S + A.HOUAMT04S+A.HOUAMT05S,0) AS HOUAMT34S , COALESCE(A.HOUAMT01S,0)   HOUAMT01S,                   \n");
					sql.append(" COALESCE(A.FNDSUMS,0)   FNDSUMS ,																												\n");
					sql.append(" CASE WHEN Y.STRTDT1<>'' THEN SUBSTR(Y.STRTDT1,1,8)|| '~' ||SUBSTR(Y.ENDDT1,1,8) ELSE '' END AS BFSTRDT1,								\n");
					sql.append(" COALESCE(Y.BP141000,0)BP141000, COALESCE(Y.BP142000,0)BP142000, COALESCE(Y.BP143000,0)BP143000,				 \n");
					sql.append(" CASE WHEN Y.STRTDT2<>'' THEN SUBSTR(Y.STRTDT2,1,8)|| '~' ||SUBSTR(Y.ENDDT2,1,8) ELSE '' END AS BFSTRDT2,								\n");
					sql.append(" COALESCE(Y.BP241000,0)BP241000, COALESCE(Y.BP242000,0)BP242000, COALESCE(Y.BP243000,0)BP243000,					\n");
					sql.append(" COALESCE(Y.BTAXAMT101,0)BTAXAMT101,COALESCE(Y.BTAXAMT201,0)BTAXAMT201											\n");
					sql.append(" FROM PAYROLL.YCPAYCOL A                                                                                                                        \n");
					sql.append(" LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO = B.EMPNO                                                                                              \n");
					sql.append(" LEFT JOIN PAYROLL.HCLCODE  C ON RTRIM(A.PAYGRD) = RTRIM(C.MINORCD) AND C.MAJORCD='2002'                                                        \n");
					sql.append(" LEFT JOIN PAYROLL.HCDEPT   D ON RTRIM(A.DEPTCD) = RTRIM(D.DEPTCD)  AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                       \n");
					sql.append(" LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYSEQ = RTRIM(E.MINORCD) AND E.MAJORCD='1184'                                                               \n");				

	        	    sql.append(" LEFT JOIN(SELECT   F.EMPNO		,MAX(F.YYYY)YYYY ,SUM(CASE WHEN F.SEQ='1' THEN (F.BTAXAMT01)ELSE 0 END) AS BTAXAMT101	\n");
					sql.append("								,SUM(CASE WHEN F.SEQ='2' THEN (F.BTAXAMT01)ELSE 0 END) AS BTAXAMT201  \n");
					sql.append("								,MAX(CASE WHEN F.SEQ='1' THEN (F.STRTDT)ELSE '' END) AS STRTDT1			\n");
					sql.append("								,MAX(CASE WHEN F.SEQ='1' THEN (F.ENDDT) ELSE  ''END)  AS ENDDT1		 \n");
					sql.append("                                ,SUM(CASE WHEN F.SEQ='1' THEN (F.BP41000) ELSE 0 END)  AS BP141000	  \n");
				  	sql.append("								,SUM(CASE WHEN F.SEQ='1' THEN (F.BP42000) ELSE 0 END)  AS BP142000    \n");
					sql.append("								,SUM(CASE WHEN F.SEQ='1' THEN (F.BP43000) ELSE 0 END)  AS BP143000	\n");
					sql.append("								,MAX(CASE WHEN F.SEQ='2' THEN (F.STRTDT)ELSE '' END) AS STRTDT2		\n");
					sql.append("								,MAX(CASE WHEN F.SEQ='2' THEN (F.ENDDT) ELSE '' END)  AS ENDDT2			\n");
			        sql.append("								,SUM(CASE WHEN F.SEQ='2' THEN (F.BP41000) ELSE 0 END)  AS BP241000		\n");
					sql.append("								,SUM(CASE WHEN F.SEQ='2' THEN (F.BP42000) ELSE 0 END)  AS BP242000		\n");
					sql.append("								,SUM(CASE WHEN F.SEQ='2' THEN (F.BP43000) ELSE 0 END)  AS BP243000		\n");
					sql.append("			FROM PAYROLL.YCBEFOFF F																		\n");
					sql.append("GROUP BY F.EMPNO)Y ON A.EMPNO=Y.EMPNO AND SUBSTR(A.APPDT,1,4) = Y.YYYY 											\n");
					//sql.append(" LEFT JOIN PAYROLL.YCBEFOFF X ON A.EMPNO = X.EMPNO                                                      \n");

					sql.append( " WHERE A.APPDT  = '" + str[0] + "'																											    	  \n");
				  sql.append( "   AND A.EMPNMK  LIKE '" +str[2] + "%'																											    \n");
				  sql.append( "   AND A.PAYDIV IN ('Y','T')																															    	\n");
					sql.append( "   AND (B.USESTS != '3' OR ( B.USESTS = '3' AND (B.ENDDT >='20090101' OR A.EMPNO ='3060027'))) \n");
          //if (str[2].equals("")) sql.append("\n").append( " AND (B.USESTS != '3' OR ( B.USESTS = '3' AND (B.ENDDT >='20090101' OR A.EMPNO ='3060027')))\n");
					//if (!str[2].equals("")) sql.append("\n").append( " AND (B.USESTS != '3' OR ( B.USESTS = '3' AND B.ENDDT >='20090101') )										 \n");
					if (str[3].equals("1")) sql.append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] +"'  \n");
					if (str[3].equals("2")) sql.append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] + "' \n");
					if (str[3].equals("3")) sql.append( " AND SUBSTR(D.TREECD,1,6)= '" + str[4] +"'  \n");
					if (str[3].equals("4")) sql.append( " AND RTRIM(D.TREECD)= '" + str[4] + "'      \n");

					if (!str[6].equals("")) sql.append("\n").append( " AND A.EMPNO= '" + str[6] + "' \n");
  				//sql.append("\n").append( " ORDER BY D.TREECD, C.SEQ \n");
					sql.append("\n").append( " ORDER BY A.EMPNMK \n");
					
							
          /*

					sql.append(" SELECT ");
          sql.append(" A.APPDT, ");
					sql.append("\n").append( " A.EMPNO,      A.EMPNMK,     A.PAYGRD,      A.PAYSEQ,      A.CADDR01,											"); 
					sql.append("\n").append( " A.CADDR02,    RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS CADDNM,											");
					sql.append("\n").append( " A.RESINO,     A.PC11000,    A.PC12000,     A.PC13000,																		"); 
					sql.append("\n").append( " A.PC10000,    A.BCWKNM1,																																	");
					sql.append("\n").append( " CASE WHEN BCRESINO1 <> '' THEN SUBSTR(BCRESINO1,1,3) || '-' || SUBSTR(BCRESINO1,4,2) || '-' ||SUBSTR(BCRESINO1,6,5) ELSE '' END AS BCRESINO1, ");
					sql.append("\n").append( " A.BC11000,    A.BC12000,																																	"); 
					sql.append("\n").append( " A.BC13000,    A.BC10000,    A.BCWKNM2,																										");
					sql.append("\n").append( " CASE WHEN BCRESINO2 <> '' THEN SUBSTR(BCRESINO2,1,3) || '-' || SUBSTR(BCRESINO2,4,2) || '-' ||SUBSTR(BCRESINO2,6,5) ELSE '' END AS BCRESINO2, ");
					sql.append("\n").append( " A.BC21000,		 A.BC22000,    A.BC23000,     A.BC20000,     A.PBC1000,     A.PBC2000,			"); 
					sql.append("\n").append( " A.PBC3000,    A.TWKSUM,     A.PC21000,     A.PC22000,     A.PC23000,	A.PC20000,					"); 
					sql.append("\n").append( " A.PB10000,    A.PB20000,    A.PB30000,     A.BA0101YN,    COALESCE(A.BA0102CNT,0) BA0102CNT,	"); 
					sql.append("\n").append( " COALESCE(A.BA0103CNT,0) BA0103CNT,  COALESCE(A.BA0104CNT,0) BA0104CNT,									");
					sql.append("\n").append( " COALESCE(A.BA0105CNT,0) BA0105CNT,  COALESCE(A.AD0101CNT,0) AD0101CNT,									");
					sql.append("\n").append( " COALESCE(A.AD0102CNT,0) AD0102CNT,	 COALESCE(A.AD0103CNT,0) AD0103CNT,									"); 
					sql.append("\n").append( " COALESCE(A.AD0104YN,0)  AD0104YN,   COALESCE(A.AD0105CNT,0) AD0105CNT, COALESCE(A.BAAMT01,0)  BAAMT01,   COALESCE(A.BAAMT02,0)	BAAMT02,								"); 
					sql.append("\n").append( " COALESCE(A.BAAMT03,0)   BAAMT03,    COALESCE(A.BASUM,0)     BASUM,     COALESCE(A.ADAMT01,0)  ADAMT01,   COALESCE(A.ADAMT02,0) ADAMT02,  COALESCE(A.ADAMT03,0)  ADAMT03,		"); 
					sql.append("\n").append( " COALESCE(A.ADAMT04,0)   ADAMT04,    COALESCE(A.ADAMT05,0)   ADAMT05,   COALESCE(A.ADSUM,0)    ADSUM,     COALESCE(A.PENSUM,0)  PENSUM,   COALESCE(A.INSAMT01,0) INSAMT01,	"); 
					sql.append("\n").append( " COALESCE(A.INSAMT02,0)  INSAMT02,   COALESCE(A.INSAMT03,0) INSAMT03,   COALESCE(A.INSAMT04,0) INSAMT04,        ");
					sql.append("\n").append( " COALESCE(A.INSSUM,0)		 INSSUM,     COALESCE(A.MEDAMT01,0) MEDAMT01,		COALESCE(A.MEDAMT02,0) MEDAMT02,				"); 
					sql.append("\n").append( " COALESCE(A.MEDSUM,0)		 MEDSUM,     COALESCE(A.EDUAMT01,0) EDUAMT01,   COALESCE(A.EDUAMT02,0) EDUAMT02, COALESCE(A.EDUAMT021,0) EDUAMT021,	"); 
					sql.append("\n").append( " COALESCE(A.EDUAMT022,0) EDUAMT022,  COALESCE(EDUAMT022,0) EDUAMT022, COALESCE(A.EDUAMT023,0) EDUAMT023, COALESCE(A.EDUAMT024,0)  EDUAMT024,  COALESCE(A.EDUAMT025,0)  EDUAMT025, COALESCE(A.EDUAMT03,0)	EDUAMT03,									"); 
					sql.append("\n").append( " COALESCE(A.EDUAMT031,0) EDUAMT031,  COALESCE(EDUAMT031,0) EDUAMT031, COALESCE(A.EDUAMT032,0) EDUAMT032, COALESCE(A.EDUAMT033,0)  EDUAMT033,  COALESCE(A.EDUAMT034,0)  EDUAMT034, COALESCE(A.EDUAMT035,0)	EDUAMT035,								"); 
					sql.append("\n").append( " COALESCE(A.EDUAMT04,0)  EDUAMT04,   COALESCE(EDUAMT04,0)  EDUAMT04,	COALESCE(A.EDUAMT041,0) EDUAMT041, COALESCE(A.EDUAMT042,0)  EDUAMT042,  COALESCE(A.EDUAMT043,0)  EDUAMT043, COALESCE(A.EDUAMT044,0)	EDUAMT044,								"); 
					sql.append("\n").append( " COALESCE(A.EDUAMT045,0) EDUAMT045,  COALESCE(EDUAMT045,0) EDUAMT045, COALESCE(A.EDUAMT05,0)  EDUAMT05,  COALESCE(A.EDUAMT051,0)  EDUAMT051,  COALESCE(A.EDUAMT052,0)  EDUAMT052, COALESCE(A.EDUAMT053,0)	EDUAMT053,								"); 
					sql.append("\n").append( " COALESCE(A.EDUAMT054,0) EDUAMT054,  COALESCE(EDUAMT054,0) EDUAMT054, COALESCE(A.EDUAMT055,0) EDUAMT055, COALESCE(A.EDUSUM,0)     EDUSUM,     COALESCE(A.HOUAMT01,0)   HOUAMT01,  COALESCE(A.HOUAMT02,0)	HOUAMT02,									"); 
					sql.append("\n").append( " COALESCE(A.HOUAMT03,0)  HOUAMT03,   COALESCE(HOUAMT03,0)  HOUAMT03,	COALESCE(A.HOUAMT04,0)  HOUAMT04,  COALESCE(A.HOUSUM,0)     HOUSUM,     COALESCE(A.CONAMT01,0)   CONAMT01,  COALESCE(A.CONAMT02,0)	CONAMT02,									"); 
					sql.append("\n").append( " COALESCE(A.CONAMT03,0)  CONAMT03,   COALESCE(CONAMT03,0)  CONAMT03,	COALESCE(A.CONAMT04,0)  CONAMT04,  COALESCE(A.CONAMT05,0)   CONAMT05,   COALESCE(A.CONAMT06,0)   CONAMT06,  COALESCE(A.CONSUM,0)		CONSUM,										"); 
					sql.append("\n").append( " COALESCE(A.MARCNT01,0)  MARCNT01,   COALESCE(MARCNT01,0)  MARCNT01,	COALESCE(A.MARCNT02,0)  MARCNT02,  COALESCE(A.MARCNT03,0)   MARCNT03,   COALESCE(A.MARSUM,0)		 MARSUM,    COALESCE(A.SPCSUM,0)		SPCSUM,										"); 
					sql.append("\n").append( " COALESCE(A.STDSUM,0)    STDSUM,     COALESCE(STDSUM,0)    STDSUM,		COALESCE(A.OFFSUM,0)    OFFSUM,    COALESCE(A.ETCAMT011,0)  ETCAMT011,  COALESCE(A.ETCAMT01,0)   ETCAMT01,  COALESCE(A.ETCAMT02,0)	ETCAMT02,									"); 
					sql.append("\n").append( " COALESCE(A.ETCAMT031,0) ETCAMT031,  COALESCE(ETCAMT031,0) ETCAMT031, COALESCE(A.ETCAMT032,0) ETCAMT032, COALESCE(A.ETCAMT033,0)  ETCAMT033,  COALESCE(A.ETCAMT034,0)  ETCAMT034, COALESCE(A.ETCAMT03S,0)	ETCAMT03S,									"); 
					sql.append("\n").append( " COALESCE(A.ETCAMT04,0)  ETCAMT04,   COALESCE(ETCAMT04,0)  ETCAMT04,	COALESCE(A.ETCSUM,0)    ETCSUM,    COALESCE(A.TSTDSUM,0)    TSTDSUM,    COALESCE(A.STDTAX,0)		 STDTAX,    COALESCE(A.REDAMT01,0)	REDAMT01,		COALESCE(A.REDAMT02,0) REDAMT02,	");
					sql.append("\n").append( " COALESCE(A.REDSUM,0)		 REDSUM,     COALESCE(REDSUM,0)		 REDSUM,		COALESCE(A.DEDAMT01,0)  DEDAMT01,  COALESCE(A.DEDAMT02,0)   DEDAMT02,   COALESCE(A.DEDAMT03,0)   DEDAMT03,  COALESCE(A.DEDAMT04,0)	DEDAMT04,									"); 
					sql.append("\n").append( " COALESCE(A.DEDAMT05,0)  DEDAMT05,   COALESCE(DEDAMT05,0)  DEDAMT05,	COALESCE(A.DEDSUM,0)    DEDSUM,    COALESCE(A.PB40000,0)    PB40000,    COALESCE(A.PB41000,0)    PB41000,   COALESCE(A.PB42000,0)		PB42000,									"); 
					sql.append("\n").append( " COALESCE(A.PB43000,0)	 PB43000,    COALESCE(PB43000,0)   PB43000,		COALESCE(A.PB51000,0)   PB51000,   COALESCE(A.PB52000,0)    PB52000,    COALESCE(A.PB53000,0)    PB53000,   COALESCE(A.PB50000,0)		PB50000,									"); 
					sql.append("\n").append( " COALESCE(A.PB61000,0)	 PB61000,    COALESCE(PB61000,0)   PB61000,		COALESCE(A.PB62000,0)   PB62000,   COALESCE(A.PB63000,0)    PB63000,    COALESCE(A.PB60000,0)    PB60000,   COALESCE(A.PB71000,0)		PB71000,									"); 
					sql.append("\n").append( " COALESCE(A.PB72000,0)	 PB72000,    COALESCE(PB72000,0)   PB72000,		COALESCE(A.PB73000,0)   PB73000,   COALESCE(A.PB70000,0)    PB70000,    COALESCE(A.CASHSUM,0)    CASHSUM,   ");								 
					sql.append("\n").append( " RTRIM(A.RELAT1) RELAT1,				"); 
					sql.append("\n").append( " RTRIM(A.FAMNM1) FAMNM1,     A.RESINO1,     RTRIM(A.RELAT2) RELAT2,  RTRIM(A.FAMNM2) FAMNM2,  A.RESINO2,			"); 
					sql.append("\n").append( " RTRIM(A.RELAT3) RELAT3,     RTRIM(A.FAMNM3) FAMNM3,      A.RESINO3,     RTRIM(A.RELAT4) RELAT4,      A.FAMNM4,	"); 
					sql.append("\n").append( " A.RESINO4,    RTRIM(A.RELAT5) RELAT5,      RTRIM(A.FAMNM5) FAMNM5,      A.RESINO5,     RTRIM(A.RELAT6) RELAT6,	"); 
					sql.append("\n").append( " RTRIM(A.FAMNM6) FAMNM6,     A.RESINO6,    RTRIM(A.RELAT7) RELAT7,       RTRIM(A.FAMNM7) FAMNM7,      A.RESINO7,			"); 
					sql.append("\n").append( " RTRIM(A.RELAT8) RELAT8,     RTRIM(A.FAMNM8) FAMNM8,      A.RESINO8,     RTRIM(A.RELAT9) RELAT9, RTRIM(A.FAMNM9) FAMNM9,	    "); 
					sql.append("\n").append( " A.RESINO9,    A.PROSTS,																																	"); 
          sql.append("\n").append( " RTRIM(C.MINORNM) AS PAYGRDNM,  D.DEPTNM,  RTRIM(E.MINORNM) AS PAYSEQNM,									"); 
					sql.append("\n").append( " A.STRTDT,     A.ENDDT,COALESCE(A.STDTAX-A.REDSUM-A.DEDSUM,0) AS RESSUM,									"); 
					sql.append("\n").append( " COALESCE(A.BA0101YN+A.BA0102CNT+A.BA0103CNT+A.BA0104CNT+A.BA0105CNT,0) AS TOTCNT01,			");
					sql.append("\n").append( " COALESCE(A.AD0101CNT+A.AD0102CNT,0) AS TOTCNT02,																					");
					sql.append("\n").append( " COALESCE(A.ETCAMT01S,0)ETCAMT01S, COALESCE(A.ETCAMT02S,0)ETCAMT02S, COALESCE(A.ETCAMT03S,0)ETCAMT03S, COALESCE(A.ETCAMT04S,0)ETCAMT04S,	");
					sql.append("\n").append( " A.REF11,A.REF12,A.REF13,A.REF14,A.REF15,A.REF16,A.REF17,A.REF18,													");
					sql.append("\n").append( " A.REF21,A.REF22,A.REF23,A.REF24,A.REF25,A.REF26,A.REF27,A.REF28,													");
					sql.append("\n").append( " A.REF31,A.REF32,A.REF33,A.REF34,A.REF35,A.REF36,A.REF37,A.REF38,													");
					sql.append("\n").append( " A.REF41,A.REF42,A.REF43,A.REF44,A.REF45,A.REF46,A.REF47,A.REF48,													");
					sql.append("\n").append( " A.REF51,A.REF52,A.REF53,A.REF54,A.REF55,A.REF56,A.REF57,A.REF58,													");
					sql.append("\n").append( " A.REF61,A.REF62,A.REF63,A.REF64,A.REF65,A.REF66,A.REF67,A.REF68,													");
					sql.append("\n").append( " A.REF71,A.REF72,A.REF73,A.REF74,A.REF75,A.REF76,A.REF77,A.REF78,													");
					sql.append("\n").append( " A.REF81,A.REF82,A.REF83,A.REF84,A.REF85,A.REF86,A.REF87,A.REF88,													");
					sql.append("\n").append( " A.REF91,A.REF92,A.REF93,A.REF94,A.REF95,A.REF96,A.REF97,A.REF98,													");
					sql.append("\n").append( " COALESCE(A.ETCAMT011S,0)ETCAMT011S, COALESCE(A.BA0101CNT+A.BA0102CNT+A.BA0103CNT+A.BA0104CNT+A.BA0105CNT,0)BA0101CNT,COALESCE(A.AD0106CNT,0)AD0106CNT,  		");
					sql.append("\n").append( " CASE WHEN SUBSTR(A.STRTDT,1,4)  = '"+str[5]+"' THEN A.STRTDT															");
					sql.append("\n").append( "      WHEN SUBSTR(A.STRTDT,1,4) != '"+str[5]+"' THEN '"+str[5]+"' || '0101'								");
					sql.append("\n").append( " END AS CURDT3,																																						\n");
					sql.append("\n").append( " COALESCE(A.DEDAMT01S,0)DEDAMT01S, COALESCE(A.DEDAMT02S,0)DEDAMT02S,  COALESCE(A.DEDAMT03S,0)DEDAMT03S,    COALESCE(A.DEDAMT04S,0)DEDAMT04S,    COALESCE(A.DEDAMT05S,0)DEDAMT05S,											");
					sql.append("\n").append( " COALESCE(A.ADAMT05S,0)ADAMT05S,  COALESCE(A.PENSUMS,0)PENSUMS,    COALESCE(A.REDAMT01S,0)REDAMT01S,    COALESCE(A.REDAMT02S,0)REDAMT02S,    COALESCE(A.ETCAMT05,0) ETCAMT05, 0 RCNT,	");

					sql.append("\n").append( " COALESCE(A.AD0107CNT,0) AD0107CNT, COALESCE(A.ADAMT07,0)   ADAMT07,	COALESCE(A.ETCAMT05,0)  ETCAMT05,		COALESCE(A.HOUAMT02S,0)   HOUAMT02S, \n");
					sql.append("\n").append( " COALESCE(A.HOUAMT03S + A.HOUAMT04S,0) AS HOUAMT34S , COALESCE(A.HOUAMT01S,0)   HOUAMT01S,	COALESCE(A.FNDSUMS,0)  FNDSUMS	 \n");

					//sql.append("\n").append( " 0 TREF11, 0 TREF12, 0 TREF13, 0 TREF14, 0 TREF15, 0 TREF16,");
					//sql.append("\n").append( " 0 TREF21, 0 TREF22, 0 TREF23, 0 TREF24, 0 TREF25, 0 TREF26, 0 TCNT ");

					sql.append("\n").append( " FROM PAYROLL.YCPAYCOL A																																	"); 
					sql.append("\n").append( " LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO = B.EMPNO																				");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE  C ON RTRIM(A.PAYGRD) = RTRIM(C.MINORCD) AND C.MAJORCD='2002'	");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCDEPT   D ON RTRIM(A.DEPTCD) = RTRIM(D.DEPTCD)	AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)			  							");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYSEQ = RTRIM(E.MINORCD) AND E.MAJORCD='1184'					");
					sql.append("\n").append( " WHERE A.APPDT  = '" + str[0] + "'																												");
				  sql.append("\n").append( " AND A.EMPNMK  LIKE '" +str[2] + "%'																											");
				  sql.append("\n").append( " AND A.PAYDIV IN ('Y','T')																																");
					sql.append("\n").append( " AND (B.USESTS != '3' OR ( B.USESTS = '3' AND (B.ENDDT >='20090101' OR A.EMPNO ='3060027')))\n");
          //if (str[2].equals("")) sql.append("\n").append( " AND (B.USESTS != '3' OR ( B.USESTS = '3' AND (B.ENDDT >='20090101' OR A.EMPNO ='3060027')))\n");
					//if (!str[2].equals("")) sql.append("\n").append( " AND (B.USESTS != '3' OR ( B.USESTS = '3' AND B.ENDDT >='20090101') )										 \n");


					if (str[3].equals("1")) sql.append("\n").append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] +"'");
					if (str[3].equals("2")) sql.append("\n").append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] + "'");
					if (str[3].equals("3")) sql.append("\n").append( " AND SUBSTR(D.TREECD,1,6)= '" + str[4] +"'");
					if (str[3].equals("4")) sql.append("\n").append( " AND RTRIM(D.TREECD)= '" + str[4] + "'");

					if (!str[6].equals("")) sql.append("\n").append( " AND A.EMPNO= '" + str[6] + "'");

          //sql.append("\n").append( " AND A.EMPNO IN ('2000001','2010017','1990045','1990043','1990012') ");


					//sql.append("\n").append( " ORDER BY D.TREECD, C.SEQ \n");
					sql.append("\n").append( " ORDER BY A.EMPNMK \n");
          
					*/ 
					logger.dbg.println(this, sql.toString());

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