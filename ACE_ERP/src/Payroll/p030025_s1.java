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
public class p030025_s1 extends HttpServlet {

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

				String[] strArrCN = new String[]{ 
				"APPYY",	  "EMPNO",	  "EMPNMK",	  "MGENO",	  "DEPTCD",	        
				"PAYGRD",	  "PAYSEQ",	  "STRTDT",	  "ENDDT",	  "DEPTNMK",				
				"PAYGRDNM", "PAYSEQNM", "ADDR1", 	  "ADDR2",	  "RESINO",	 				
				"SEX",	    "RESIGB",	  "RESINA",   "RESINACD",	"COTRYGB",	 			
				"FSINGLE",	"NATION",	  "NATIONCD", "HOUSEYN",	"YETAGB",	 				
				"CWORKNM",	"CWORKNO",	"CWORKFR",	"CWORKTO",	"CREDUFR",	 			
				"CREDUTO",	"CP11000",	"CP12000",	"CP13000",	"CP10000",	 			
				"BWORKNM1",	"BWORKNO1",	"BWORKFR1",	"BWORKTO1",	"BREDUFR1",	 			
				"BREDUTO1",	"BP11000",	"BP12000",	"BP13000",	"BP10000",	 			
				"BWORKNM2",	"BWORKNO2",	"BWORKFR2",	"BWORKTO2",	"BREDUFR2",	 			
				"BREDUTO2",	"BP21000",	"BP22000",	"BP23000",	"BP20000",	 			
				"BWORKNM3",	"BWORKNO3",	"BWORKFR3",	"BWORKTO3",	"BREDUFR3",	 			
				"BREDUTO3",	"BP31000",	"BP32000",	"BP33000",	"BP30000",	 			
				"CBP1000",	"CBP2000",	"CBP3000",	"CBPSUM",	  "NTAXCD01",	 			
				"NTAXCD02",	"NTAXCD03",	"NTAXCD04",	"NTAXCD05",	"CNTAX01",	 			
				"CNTAX02",	"CNTAX03",	"CNTAX04",	"CNTAX05",	"CNTAXSUM",	 			
				"BNTAX101",	"BNTAX102",	"BNTAX103",	"BNTAX104",	"BNTAX105",	 			
				"BNTAX1SUM","BNTAX201",	"BNTAX202",	"BNTAX203",	"BNTAX204",	 			
				"BNTAX205",	"BNTAX2SUM","BNTAX301",	"BNTAX302",	"BNTAX303",	 			
				"BNTAX304",	"BNTAX305",	"BNTAX3SUM","NTAXSUM01","NTAXSUM02",			
				"NTAXSUM03","NTAXSUM04","NTAXSUM05","NTAXSUM",	"CREDAMT01",			
				"BREDAMT01","BREDAMT02","BREDAMT03","REDSUM",	  "CCP41000",	 			
				"CCP42000",	"CCP43000",	"CCP40000",	"BP41000",	"BP42000",	 			
				"BP43000",	"BP40000",	"BP51000",	"BP52000",	"BP53000",	 			
				"BP50000",	"BP61000",	"BP62000",	"BP63000",	"BP60000",	 			
				"CP41000",	"CP42000",	"CP43000",	"CP40000",	"BA41000",	 			
				"BA42000",	"BA43000",	"BA40000",	"TOTPAY",	  "DUDPAY",	 				
				"LABPAY",	  "BAAMT01",	"BAAMT02",	"BACNT03",	"BAAMT03",	 			
				"ADCNT01",	"ADAMT01",	"ADCNT02",	"ADAMT02",	"ADAMT03",	 			
				"ADCNT04",	"ADAMT04",	"ADCNT05",	"ADAMT05",	"ADCNT06",	 			
				"ADAMT06",	"PENAMT01",	"PENAMT03",	"INSAMT01",	"INSAMT02",	 			
				"INSAMT03",	"INSAMT04",	"MEDSUM",	  "EDUSUM",	  "HOUAMT01",	 			
				"HOUAMT02",	"HOUAMT03",	"CONAMT",	  "SPCSUM",	  "STDSUM",	 				
				"OFFSUM",	  "PESAMT01",	"PESAMT02",	"SMAAMT",	  "SAVAMT01",	 			
				"SAVAMT02",	"SAVAMT03",	"SAVAMT04",	"INVSUM",	  "CRDSUM",	 				
				"ASSSUM",  	"FNDSUM",	  "ETCSUM",	  "TAXSTDAMT","TAXSUM",	 				
				"TREDAMT01","TREDAMT02","TREDSUM",	"DEDAMT01",	"DEDAMT02",	 			
				"DEDAMT03",	"DEDAMT04",	"DEDAMT05",	"DEDSUM",	  "SENDGB",	 				
				"CHKAMT01",	"CONLMT10",	"CONLMT30",	"CONLMT31",	"CONLMT40",	 			
				"CONLMT41", "BP456_10", "BP456_20", "BP456_30", "BP456_00"
  		};  
					                              
				int[] intArrCN = new int[]{ 
				4,	7,	20,	4,	4,															
				4,	4,	 8, 8,  70,
				30,	30, 70,	70,	60,															
				1,	1,	40,	2,	1,															
				1,	40,	2,	1,	1,															
				40,	10,	8,	8,	8,															
				8,	11,	11,	11,	11,															
				40,	10,	8,	8,	8,															
				8,	11,	11,	11,	11,															
				40,	10,	8,	8,	8,															
				8,	11,	11,	11,	11,															
				40,	10,	8,	8,	8,															
				8,	11,	11,	11,	11,															
				11,	11,	11,	11,	3,															
				3,	3,	3,	3,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	10,	10,															
				10,	10,	10,	11,	10,															
				11,	8,	8,	2,	8,															
				2,	8,	2,	8,	8,															
				2,	8,	2,	8,	2,															
				8,	10,	10,	10,	10,															
				10,	10,	10,	8,	8,															
				8,	8,	10,	10,	8,															
				11,	8,	8,	10,	10,															
				10,	10,	10,	10,	8,															
				10,	10,	10,	11,	10,															
				10,	10,	10,	10,	10, 														
				10,	10,	10,	10,	1,															
				11,	11,	11,	11,	11,															
				11,	11,	11,	11,	11	                																		                          
			 }; 
			
				int[] intArrCN2 = new int[]{-1,	-1,	-1,	-1,	-1,	
																		-1,	-1,	-1, -1,	-1,
					                          -1,	-1,	-1, -1,	-1,
																		-1,	 0,	-1, -1,	 0,
					                           0,	-1,	-1, -1,	-1,
                                    -1,	-1,	-1, -1,	-1,
					                          -1,	 0,	 0,	 0,	 0,	
                                    -1,	-1,	-1, -1,	-1,
                                    -1,	 0,	 0,	 0,	 0,	
                                    -1,	-1,	-1, -1,	-1,
                                    -1,	 0,	 0,	 0,	 0,	
					                          -1,	-1,	-1, -1,	-1,
                                    -1,	 0,	 0,	 0,	 0,	
                                     0,	 0,	 0,	 0,	-1,
					                          -1,	-1,	-1, -1,	 0,
                                     0,	 0,	 0,	 0,	 0,	
                                     0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,
	                                   0,	 0,	 0,	 0,	-1,	
                                     0,	 0,	 0,	 0,	 0,
                                     0,	 0,	 0,	 0,	 0										
																
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
          
					sql.append("  SELECT                                                                              \n");
					sql.append("  A.APPYY,    A.EMPNO,    A.EMPNMK,   A.MGENO,    A.DEPTCD,                           \n");
					sql.append("  A.PAYGRD,   A.PAYSEQ,   B.STRTDT,   B.ENDDT,    C.DEPTNMK,                          \n");
					sql.append("  D.MINORNM AS PAYGRDNM,  E.MINORNM AS PAYSEQNM,  A.ADDR1,    A.ADDR2,    A.RESINO,   \n");
					sql.append("  A.SEX,      A.RESIGB,   A.RESINA,   A.RESINACD, A.COTRYGB,                          \n");
					sql.append("  A.FSINGLE,  A.NATION,   A.NATIONCD, A.HOUSEYN,  A.YETAGB,                           \n");
					sql.append("  A.CWORKNM,  A.CWORKNO,  A.CWORKFR,  A.CWORKTO,  A.CREDUFR,                          \n");
					sql.append("  A.CREDUTO,  A.CP11000,  A.CP12000,  A.CP13000,  A.CP10000,                          \n");
					sql.append("  A.BWORKNM1, A.BWORKNO1, A.BWORKFR1, A.BWORKTO1, A.BREDUFR1,                         \n");
					sql.append("  A.BREDUTO1, A.BP11000,  A.BP12000,  A.BP13000,  A.BP10000,                          \n");
					sql.append("  A.BWORKNM2, A.BWORKNO2, A.BWORKFR2, A.BWORKTO2, A.BREDUFR2,                         \n");
					sql.append("  A.BREDUTO2, A.BP21000,  A.BP22000,  A.BP23000,  A.BP20000,                          \n");
					sql.append("  A.BWORKNM3, A.BWORKNO3, A.BWORKFR3, A.BWORKTO3, A.BREDUFR3,                         \n");
					sql.append("  A.BREDUTO3, A.BP31000,  A.BP32000,  A.BP33000,  A.BP30000,                          \n");
					sql.append("  A.CBP1000,  A.CBP2000,  A.CBP3000,  A.CBPSUM,   A.NTAXCD01,                         \n");
					sql.append("  A.NTAXCD02, A.NTAXCD03, A.NTAXCD04, A.NTAXCD05, A.CNTAX01,                          \n");
					sql.append("  A.CNTAX02,  A.CNTAX03,  A.CNTAX04,  A.CNTAX05,  A.CNTAXSUM,                         \n");
					sql.append("  A.BNTAX101, A.BNTAX102, A.BNTAX103, A.BNTAX104, A.BNTAX105,                         \n");
					sql.append("  A.BNTAX1SUM,A.BNTAX201, A.BNTAX202, A.BNTAX203, A.BNTAX204,                         \n");
					sql.append("  A.BNTAX205, A.BNTAX2SUM,A.BNTAX301, A.BNTAX302, A.BNTAX303,                         \n");
					sql.append("  A.BNTAX304, A.BNTAX305, A.BNTAX3SUM,A.NTAXSUM01,A.NTAXSUM02,                        \n");
					sql.append("  A.NTAXSUM03,A.NTAXSUM04,A.NTAXSUM05,A.NTAXSUM,  A.CREDAMT01,                        \n");
					sql.append("  A.BREDAMT01,A.BREDAMT02,A.BREDAMT03,A.REDSUM,   A.CCP41000,                         \n");
					sql.append("  A.CCP42000, A.CCP43000, A.CCP40000, A.BP41000,  A.BP42000,                          \n");
					sql.append("  A.BP43000,  A.BP40000,  A.BP51000,  A.BP52000,  A.BP53000,                          \n");
					sql.append("  A.BP50000,  A.BP61000,  A.BP62000,  A.BP63000,  A.BP60000,                          \n");
					sql.append("  A.CP41000,  A.CP42000,  A.CP43000,  A.CP40000,  A.BA41000,                          \n");
					sql.append("  A.BA42000,  A.BA43000,  A.BA40000,  A.TOTPAY,   A.DUDPAY,                           \n");
					sql.append("  A.LABPAY,   A.BAAMT01,  A.BAAMT02,  A.BACNT03,  A.BAAMT03,                          \n");
					sql.append("  A.ADCNT01,  A.ADAMT01,  A.ADCNT02,  A.ADAMT02,  A.ADAMT03,                          \n");
					sql.append("  A.ADCNT04,  A.ADAMT04,  A.ADCNT05,  A.ADAMT05,  A.ADCNT06,                          \n");
					sql.append("  A.ADAMT06,  A.PENAMT01, A.PENAMT03, A.INSAMT01, A.INSAMT02,                         \n");
					sql.append("  A.INSAMT03, A.INSAMT04, A.MEDSUM,   A.EDUSUM,   A.HOUAMT01,                         \n");
					sql.append("  A.HOUAMT02, A.HOUAMT03, A.CONAMT,   A.SPCSUM,   A.STDSUM,                           \n");
					sql.append("  A.OFFSUM,   A.PESAMT01, A.PESAMT02, A.SMAAMT,   A.SAVAMT01,                         \n");
					sql.append("  A.SAVAMT02, A.SAVAMT03, A.SAVAMT04, A.INVSUM,   A.CRDSUM,                           \n");
					sql.append("  A.ASSSUM,   A.FNDSUM,   A. ETCSUM,  A.TAXSTDAMT,A. TAXSUM,                          \n");
					sql.append("  A.TREDAMT01,A.TREDAMT02,A.TREDSUM,  A.DEDAMT01, A.DEDAMT02,                         \n");
					sql.append("  A.DEDAMT03, A.DEDAMT04, A.DEDAMT05, A.DEDSUM,   A.SENDGB,                           \n");
					sql.append("  A.CHKAMT01, A.CONLMT10, A.CONLMT30, A.CONLMT31, A.CONLMT40,                         \n");
					sql.append("  A.CONLMT41,                                                                         \n");
					sql.append("  A.BP41000+A.BP51000+A.BP61000 AS BP456_10,                                          \n");
					sql.append("  A.BP42000+A.BP52000+A.BP62000 AS BP456_20,                                          \n");
					sql.append("  A.BP43000+A.BP53000+A.BP63000 AS BP456_30,                                          \n");
					sql.append("  A.BP40000+A.BP50000+A.BP60000 AS BP456_00                                           \n");
					sql.append("  FROM PAYROLL.YCPAY10 A                                                              \n");
					sql.append("  LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO  = B.EMPNO   AND B.USESTS IN ('1','2','3')  \n");
					sql.append("  LEFT JOIN PAYROLL.HCDEPT C   ON A.DEPTCD = C.DEPTCD  AND C.CHGYM='200801'           \n");
					sql.append("  LEFT JOIN PAYROLL.HCLCODE D  ON A.PAYGRD = D.MINORCD AND D.MAJORCD ='2002'          \n");
					sql.append("  LEFT JOIN PAYROLL.HCLCODE E  ON A.PAYSEQ = E.MINORCD AND E.MAJORCD ='1184'          \n");
					sql.append(" WHERE A.APPYY  = '" + str[0] + "'																											    	  \n");
				  sql.append("   AND A.EMPNMK  LIKE '" +str[2] + "%'																											    \n");
					sql.append("   AND (B.USESTS != '3'                                                                         \n");
					sql.append("       OR (B.USESTS= '3' AND (B.ENDDT >='20100101' OR A.EMPNO IN ('3080035','3080141','3080087','3080114','3080143','3080086'))))  \n");
  
					if (str[3].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[4] +"'  \n");
					if (str[3].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[4] + "' \n");
					if (str[3].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[4] +"'  \n");
					if (str[3].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[4] + "'      \n");

					if (!str[6].equals("")) sql.append("\n").append( " AND A.EMPNO= '" + str[6] + "' \n");
  				//sql.append("\n").append( " ORDER BY D.TREECD, C.SEQ \n");
					sql.append("\n").append( " ORDER BY A.EMPNMK \n");
					
					//sql.append("    \n");

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