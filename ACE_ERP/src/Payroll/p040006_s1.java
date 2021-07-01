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
public class p040006_s1 extends HttpServlet {

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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//퇴사일,1- 입사일,2
				str[1]	= req.getParameter("v_str2");		//기준일자부터
				str[2]	= req.getParameter("v_str3");		//기준일자까지
				str[3]	= req.getParameter("v_str4");		//부서코드
				str[4]	= req.getParameter("v_str5");		//사번

				for (int s=0;s<5;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* 사번 */
				"EMPNMK",       /*한글명*/
				"APPDT",	       /* 년월 */
				"DEPTCD",	/*  부서코드*/
				"DEPTNM",	/*  부서명*/
				"PAYGRDNM",	/* 직위코드*/
				"GRDDIVNM",	/*직급*/
				"PAYSEQNM",	/* 호봉코드 */
				"PAYBNKNM",	/*  은행코드*/
				"PAYNUM",	/*  계좌번호*/
				"PAYDT",     /*  퇴직급여일*/
				"RETDT",	/*  퇴직금지급일*/
				"AVGAMT",	/* 평균급여 */
				"AVGETC",	/* 수당평균 */
				"AVGYER",	/*  년차평균*/
				"AVGBOS",	/*  상여평균 */
				"JUSRET",	/*  퇴직금*/
				"RETJUH",	/*  퇴직전환금 */
				"T23000",	/*  퇴직소득세*/
				"T24000",	/*  퇴직주민세*/
				"STRTDT",	/*  입사일*/
				"ENDDT",	/*  퇴사일*/
				"S94000",	/*  차인지급액*/
				"S93000"
				};

				int[] intArrCN = new int[]{  
					7, 	    /* 사번 */      
					20,	     /*한글명*/     
					6,	        /* 년월 */  
					4,	 /*  부서코드*/     
					50,	 /*  부서명*/       
					30,	 /* 직위코드*/      
					30,	 /*직급*/           
					30,	 /* 호봉코드 */     
					30,	 /*  은행코드*/     
					25,	 /*  계좌번호*/     
					8,	  /*  퇴직급여일*/  
					8,	 /*  퇴직금지급일*/ 
					9,	 /* 평균급여 */     
					9,	 /* 수당평균 */     
					9,	 /*  년차평균*/     
					9,	 /*  상여평균 */    
					9,	 /*  퇴직금*/       
					9,	 /*  퇴직전환금 */  
					9,	 /*  퇴직소득세*/   
					9,	 /*  퇴직주민세*/   
					8,	 /*  입사일*/   
					8,	 /*  퇴사일*/   
					9,	 /*  차인지급액*/   
					9
         }; 

				int[] intArrCN2 = new int[]{
					-1,       /* 사번 */         
					-1,	       /*한글명*/        
					-1,           /* 년월 */     
					-1,	   /*  부서코드*/        
					-1,    /*  부서명*/    
						
					-1,	   /* 직위코드*/         
					-1,    /*직급*/              
					-1,	   /* 호봉코드 */        
					-1,	   /*  은행코드*/        
					-1,    /*  계좌번호*/ 
						
					-1,	    /*  퇴직급여일*/     
					-1,	   /*  퇴직금지급일*/    
					0,	   /* 평균급여 */        
					0,	   /* 수당평균 */        
					0,	   /*  년차평균*/ 
						
					0,	   /*  상여평균 */       
					0,	   /*  퇴직금*/          
					0,	   /*  퇴직전환금 */     
					0,	   /*  퇴직소득세*/      
					0,	   /*  퇴직주민세*/   
					-1,	   /*  입사일*/      
					-1,	   /*  퇴사일*/   
						
					0,	   /*  차인지급액*/      
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
					sql.append( " SELECT																																							\n");
					sql.append( "  I.EMPNO,										/*	사번 */       																			\n");	
					sql.append( "  A.EMPNMK,									/*	한글명*/      																			\n");	
					sql.append( "  I.APPDT,										/*	년월 */       																			\n");	
					sql.append( "  A.DEPTCD,									/*  부서코드*/    																			\n");	
					sql.append( "  C.DEPTNM AS DEPTNM,				/*  부서명*/      																			\n");	
					sql.append( "  E.MINORNM AS PAYGRDNM,			/*	직위코드*/    																			\n");	
					sql.append( "  F.MINORNM AS GRDDIVNM,			/*	직급*/        																			\n");	
					sql.append( "  G.MINORNM AS PAYSEQNM,			/*	호봉코드 */   																			\n");	
					sql.append( "  H.MINORNM AS PAYBNKNM,			/*  은행코드*/    																			\n");	
					sql.append( "  I.BNKNO AS PAYNUM,					/*  계좌번호*/    																			\n");	
					sql.append( "  I.PAYDT,										/*  퇴직급여일*/  																			\n");	
					sql.append( "  I.RETDT,										/*  퇴직금지급일*/																			\n");	
					sql.append( "  I.AVGAMT,									/*	평균급여 */   																			\n");	
					sql.append( "  I.AVGETC,									/*	수당평균 */   																			\n");	
					sql.append( "  I.AVGYER,									/*  년차평균*/    																			\n");	
					sql.append( "  I.AVGBOS,									/*  상여평균 */   																			\n");	
					sql.append( "  I.JUSRET,									/*  퇴직금*/      																			\n");	
					sql.append( "  I.RETJUH,									/*  퇴직전환금 */ 																			\n");	
					sql.append( "  I.T23000,									/*  퇴직소득세*/  																			\n");	
					sql.append( "  I.T24000,									/*  퇴직주민세*/  																			\n");	
					sql.append( "  I.STRTDT,									/*  입사일*/      																			\n");	
					sql.append( "  I.ENDDT,										/*  퇴사일*/      																			\n");	
					sql.append( "  I.S94000,									/*  차인지급액*/  																			\n");
					sql.append( "  I.S93000										/*  공제합계*/     																			\n");
					sql.append( " FROM PAYROLL.PRPAY I			  																												\n"); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON A ON A.EMPNO   = I.EMPNO														\n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT   C ON A.DEPTCD  = C.DEPTCD													\n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  D ON A.JOBGRPH = D.MINORCD AND D.MAJORCD = '2000'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  E ON A.PAYGRD  = E.MINORCD AND E.MAJORCD = '2002'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  F ON A.GRDDIV  = F.MINORCD AND F.MAJORCD = '2001'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  G ON A.PAYSEQ  = G.MINORCD AND G.MAJORCD = '1184'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  H ON I.BNKCD   = H.MINORCD AND H.MAJORCD = '1411'  \n");
					sql.append( " WHERE RTRIM(I.EMPNO) <> ''																													\n");
					sql.append( " AND I.PAYDIV='3'																																		\n");
																																																						
					if ( (!str[1].equals("")&&!str[1].equals("0")) && (!str[2].equals("")&&!str[2].equals("0")) )	{
						if ( str[0].equals("1") )	{
							sql.append( " AND I.ENDDT BETWEEN  '"  + str[1] + "' AND  '"  + str[2] + "' ");    //퇴사일자
						}else	{
							sql.append( " AND I.RETDT BETWEEN  '"  + str[1] + "' AND  '"  + str[2] + "' ");    //퇴직금지급일
						}
					}

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( "  AND A.DEPTCD ='" + str[3]+ "' ");     //부서
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( "  AND I.EMPNO = '" + str[4]+ "' ");     //사번

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