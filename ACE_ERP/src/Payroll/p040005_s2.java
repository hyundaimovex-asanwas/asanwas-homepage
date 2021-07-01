package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
//퇴직금내역조회에서의 정산영수증 출력서블릿
// class 이름은 화일명과 항상 동일해야 함.
public class p040005_s2 extends HttpServlet {

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

				String [] str= new String[1] ;
        str[0] = req.getParameter("v_str1");   // 사번


		  	for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",	             "EMPNO",	       "EMPNMK",	    "PAYGRD",      	"PAYSEQ",
																													"CADDR01",	     "CADDR02",	   "RESINO",	      "PC11000",	    "PC12000",
																													"PC13000",	     "PC10000",	     "BCWKNM1",	  "BCRESINO1",	"BC11000",	
																													"BC12000",	     "BC13000",	     "BC10000",	    "BCWKNM2",	  "BCRESINO2",	
																													"BC21000",	     "BC22000",	     "BC23000",	    "BC20000",	    "PBC1000",	
																													"PBC2000",	     "PBC3000",	     "TWKSUM",	    "PC21000",	    "PC22000",   "PC23000",
																													"PC20000",	     "PB10000",	     "PB20000",	    "PB30000",	    "BA0101YN",	
																													"BA0102CNT",	 "BA0103CNT",	 "BA0104CNT",	"BA0105CNT",	"AD0101CNT",
																													"AD0102CNT",	 "AD0103CNT",	 "AD0104YN",	  "AD0105CNT",	"BAAMT01",
																													"BAAMT02",	     "BAAMT03",	   "BASUM",	      "ADAMT01",	    "ADAMT02",	
																													"ADAMT03",	     "ADAMT04",	   "ADAMT05",	  "ADSUM",	      "PENSUM",	
																													"INSAMT01",	   "INSAMT02",	   "INSAMT03",	  "INSAMT04",	  "INSSUM",	
																													"MEDAMT01",	   "MEDAMT02",	 "MEDSUM",	    "EDUAMT01",	  "EDUAMT02",
																													"EDUAMT021",	 "EDUAMT022",	 "EDUAMT023",	"EDUAMT024",	"EDUAMT025",
																													"EDUAMT03",	   "EDUAMT031",	 "EDUAMT032",	"EDUAMT033",	"EDUAMT034",
																													"EDUAMT035",	 "EDUAMT04",	 "EDUAMT041",	"EDUAMT042",	"EDUAMT043",
																													"EDUAMT044",	 "EDUAMT045",	 "EDUAMT05",	"EDUAMT051",	"EDUAMT052",
																													"EDUAMT053",	 "EDUAMT054",	 "EDUAMT055",	"EDUSUM",	      "HOUAMT01",	
																													"HOUAMT02",	   "HOUAMT03",	 "HOUAMT04",	"HOUSUM",	    "CONAMT01",	
																													"CONAMT02",	   "CONAMT03",	 "CONAMT04",	"CONAMT05",	  "CONAMT06",	
																													"CONSUM",	     "MARCNT01",	 "MARCNT02",	"MARCNT03",	  "MARSUM",	
																													"SPCSUM",	       "STDSUM",	     "OFFSUM",	    "ETCAMT011",	"ETCAMT01",
																													"ETCAMT02",	   "ETCAMT031",  "ETCAMT032",	"ETCAMT033",	"ETCAMT034",	
																													"ETCAMT03",	   "ETCAMT04",	   "ETCSUM",	    "TSTDSUM",	    "STDTAX",	   "REDAMT01",	
																													"REDAMT02",	   "REDSUM",	     "DEDAMT01",	"DEDAMT02",	  "DEDAMT03",
																													"DEDAMT04",	   "DEDAMT05",	 "DEDSUM",	    "PB40000",	    "PB41000",	
																													"PB42000",	     "PB43000",	     "PB51000",	    "PB52000",	    "PB53000",	
																													"PB50000",	     "PB61000",	     "PB62000",	    "PB63000",	    "PB60000",	
																													"PB71000",	     "PB72000",	     "PB73000",	    "PB70000",	    "CASHSUM",	
																													"RELAT1",	       "FAMNM1",	     "RESINO1",	    "RELAT2",	      "FAMNM2",	
																													"RESINO2",	     "RELAT3",	       "FAMNM3",	    "RESINO3",	    "RELAT4",	
																													"FAMNM4",	       "RESINO4",	     "RELAT5",	      "FAMNM5",	      "RESINO5",	
																													"RELAT6",	       "FAMNM6",	     "RESINO6",	    "RELAT7",	      "FAMNM7",	
																													"RESINO7",	     "RELAT8",	       "FAMNM8",	    "RESINO8",	    "RELAT9",	
																													"FAMNM9",	       "RESINO9",	     "PROSTS",
					                                                "PAYGRDNM",	   "DEPTNM",	     "PAYSEQNM",	"STRTDT",	      "ENDDT",	      "RESSUM"
					};  
					                              
																											

				int[] intArrCN = new int[]{  6,	7,	20,	4,	4,	
																								70,	70,	13,	9,	9,
																								9,	9,	30,	20,	9,	
																								9,	9,	9,	30,	20,	
																								9,	9,	9,	9,	9,
																								9,	9,	9,	9,  9,	9,	
																								9,	9,	9,	9,	1,	
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
																								9,	9,	9,	9,	9,
																								9,	9,	9,	9,	9,	
																								1,	20,	13,	1,	20,
																								13,	1,	20,	13,	1,	
																								20,	13,	1,	20,	13,
																								1,	20,	13,	1,	20,
																								13,	1,	20,	13,	1,
																								20,	13,	1,
						                                    30,	70,	30,	8,	8,	9
					}; 
			
				int[] intArrCN2 = new int[]{ -1,	-1,	-1,	-1,	-1,	
																								-1,	-1,	-1,	0,	0,	
																								0,	0,	-1,	-1,	0,
																								0,	0,	0,	-1,	-1,	
																								0,	0,	0,	0,	0,
																								0,	0,	0,	0,  0, 	0,	
																								0,	0,	0,	0,	-1,	
																								0,	0,	0,	0,	0,	
																								0,	0,	-1,	0,	0,
																								0,	0,	0,	0,	0,
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,
																								0,	0,	0,	0,	0,
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,  0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,
																								0,	0,	0,	0,	0,	
																								0,	0,	0,	0,	0,	
																								-1,	-1,	-1,	-1,	-1,
																								-1,	-1,	-1,	-1,	-1,
																								-1,	-1,	-1,	-1,	-1,
																								-1,	-1,	-1,	-1,	-1,	
																								-1,	-1,	-1,	-1,	-1,	
																								-1,	-1,	-1,
					                                      -1,	-1,	-1,	-1,	-1,0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "    	SELECT ");
          sql.append( "    	A.APPDT, ");
					sql.append("\n").append( "    	A.EMPNO,            B.EMPNMK,       A.PAYGRD,         A.PAYSEQ,          A.CADDR01,         "); 
					sql.append("\n").append( "    	A.CADDR02,       A.RESINO,       A.PC11000,        A.PC12000,         A.PC13000,					"); 
					sql.append("\n").append( "    	A.PC10000,         A.BCWKNM1,     A.BCRESINO1,    A.BC11000,        A.BC12000,				"); 
					sql.append("\n").append( "    	A.BC13000,         A.BC10000,     A.BCWKNM2,      A.BCRESINO2,    A.BC21000,					"); 
					sql.append("\n").append( "    	A.BC22000,         A.BC23000,     A.BC20000,        A.PBC1000,         A.PBC2000,				"); 
					sql.append("\n").append( "    	A.PBC3000,         A.TWKSUM,     A.PC21000,         A.PC22000,         A.PC23000,	       A.PC20000,				"); 
					sql.append("\n").append( "    	A.PB10000,         A.PB20000,      A.PB30000,         A.BA0101YN,       A.BA0102CNT,		"); 
					sql.append("\n").append( "    	A.BA0103CNT,      A.BA0104CNT,  A.BA0105CNT,    A.AD0101CNT,     A.AD0102CNT,	"); 
					sql.append("\n").append( "    	A.AD0103CNT,      A.AD0104YN,    A.AD0105CNT,    A.BAAMT01,        A.BAAMT02,			"); 
					sql.append("\n").append( "    	A.BAAMT03,        A.BASUM,         A.ADAMT01,       A.ADAMT02,        A.ADAMT03,				"); 
					sql.append("\n").append( "    	A.ADAMT04,        A.ADAMT05,     A.ADSUM,           A.PENSUM,         A.INSAMT01,				"); 
					sql.append("\n").append( "    	A.INSAMT02,       A.INSAMT03,    A.INSAMT04,       A.INSSUM,         A.MEDAMT01,			"); 
					sql.append("\n").append( "    	A.MEDAMT02,      A.MEDSUM,       A.EDUAMT01,      A.EDUAMT02,     A.EDUAMT021,		"); 
					sql.append("\n").append( "    	A.EDUAMT022,    A.EDUAMT023,    A.EDUAMT024,    A.EDUAMT025,    A.EDUAMT03,		"); 
					sql.append("\n").append( "    	A.EDUAMT031,    A.EDUAMT032,    A.EDUAMT033,    A.EDUAMT034,    A.EDUAMT035,	"); 
					sql.append("\n").append( "    	A.EDUAMT04,      A.EDUAMT041,    A.EDUAMT042,    A.EDUAMT043,    A.EDUAMT044,	"); 
					sql.append("\n").append( "    	A.EDUAMT045,    A.EDUAMT05,     A.EDUAMT051,    A.EDUAMT052,    A.EDUAMT053,		"); 
					sql.append("\n").append( "    	A.EDUAMT054,    A.EDUAMT055,    A.EDUSUM,        A.HOUAMT01,      A.HOUAMT02,		"); 
					sql.append("\n").append( "    	A.HOUAMT03,     A.HOUAMT04,     A.HOUSUM,         A.CONAMT01,      A.CONAMT02,		"); 
					sql.append("\n").append( "    	A.CONAMT03,     A.CONAMT04,     A.CONAMT05,     A.CONAMT06,      A.CONSUM,				"); 
					sql.append("\n").append( "    	A.MARCNT01,     A.MARCNT02,     A.MARCNT03,      A.MARSUM,         A.SPCSUM,				"); 
					sql.append("\n").append( "    	A.STDSUM,         A.OFFSUM,        A.ETCAMT011,      A.ETCAMT01,      A.ETCAMT02,		"); 
					sql.append("\n").append( "    	A.ETCAMT031,    A.ETCAMT032,    A.ETCAMT033,    A.ETCAMT034,    A.ETCAMT03,			"); 
					sql.append("\n").append( "    	A.ETCAMT04,      A.ETCSUM,        A.TSTDSUM,        A.STDTAX,         A.REDAMT01,     A.REDAMT02,			"); 
					sql.append("\n").append( "    	A.REDSUM,         A.DEDAMT01,     A.DEDAMT02,      A.DEDAMT03,    A.DEDAMT04,			"); 
					sql.append("\n").append( "    	A.DEDAMT05,      A.DEDSUM,       A.PB40000,          A.PB41000,       A.PB42000,					"); 
					sql.append("\n").append( "    	A.PB43000,         A.PB51000,       A.PB52000,          A.PB53000,        A.PB50000,				"); 
					sql.append("\n").append( "    	A.PB61000,         A.PB62000,       A.PB63000,          A.PB60000,        A.PB71000,				"); 
					sql.append("\n").append( "    	A.PB72000,         A.PB73000,       A.PB70000,          A.CASHSUM,      A.RELAT1,					"); 
					sql.append("\n").append( "    	A.FAMNM1,          A.RESINO1,       A.RELAT2,           A.FAMNM2,         A.RESINO2,				"); 
					sql.append("\n").append( "    	A.RELAT3,           A.FAMNM3,        A.RESINO3,         A.RELAT4,          A.FAMNM4,				"); 
					sql.append("\n").append( "    	A.RESINO4,         A.RELAT5,        A.FAMNM5,           A.RESINO5,       A.RELAT6,					"); 
					sql.append("\n").append( "    	A.FAMNM6,         A.RESINO6,       A.RELAT7,            A.FAMNM7,        A.RESINO7,				"); 
					sql.append("\n").append( "    	A.RELAT8,          A.FAMNM8,        A.RESINO8,          A.RELAT9,         A.FAMNM9,					"); 
					sql.append("\n").append( "    	A.RESINO9,        A.PROSTS	,       																																						"); 
          sql.append("\n").append( "    	RTRIM(C.MINORNM) AS PAYGRDNM,  D.DEPTNM,  RTRIM(E.MINORNM) AS PAYSEQNM,  "); 
					sql.append("\n").append( "    	B.STRTDT,          B.ENDDT,(A.STDTAX-A.REDSUM-A.DEDSUM) RESSUM  "); 
					sql.append("\n").append( "  	FROM PAYROLL.YCPAYCOL A																																											"); 

					sql.append("\n").append( "  LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO  "                                      );
					sql.append("\n").append( "  LEFT JOIN PAYROLL.HCLCODE  C ON RTRIM(A.PAYGRD) = RTRIM(C.MINORCD) AND C.MAJORCD='2002' ");
					sql.append("\n").append( "  LEFT JOIN PAYROLL.HCDEPT D ON RTRIM(A.DEPTCD) = RTRIM(D.DEPTCD) "                                      );
					sql.append("\n").append( "  LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYSEQ = RTRIM(E.MINORCD) AND E.MAJORCD='1184' ");
					sql.append("\n").append( " WHERE A.EMPNO  = '" + str[0]+"' " );
				  sql.append("\n").append( "     AND A.APPDT  = SUBSTR(B.ENDDT,1,6) ");
				  sql.append("\n").append( "     AND A.PAYDIV = '3' ");


					 sql.append("\n").append( "    ORDER BY D.TREECD, C.SEQ ");


    
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