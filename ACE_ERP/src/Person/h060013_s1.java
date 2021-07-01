package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h060013_s1 extends HttpServlet {

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
				String  str1= req.getParameter("v_str1");  //고과년월
				String  str2= req.getParameter("v_str2");  //부서
				String  str3= req.getParameter("v_str3");  //직위
				String  str4= req.getParameter("v_str4");  //성명
				String  str5= req.getParameter("v_str5");  //level
				String  str6= req.getParameter("v_str6");  //treecd

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
				if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
				
				if (str2.equals("A000")){str2 ="";}  //현대아산 선택시 전체부서조회됨.
				if (str3.equals("0")){str3 ="";}       //직위가 전체일경우
                 
				 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{
					
					"CHK",   "EVAYM",	   "EMPNO",	"EMPNMK",   "DEPTCD","DEPTNM",  "PAYGRD","PAYGRDNM", "GRSTRTDT", "STRTDT", 					
					"SEQ1",  "EMPNMK1",  "SEQ2",  "EMPNMK2",  "SEQ3",  "EMPNMK3", "SEQ4",  "EMPNMK4",  "SEQ5",  "EMPNMK5",  
					"SEQ6",  "EMPNMK6",  "SEQ7",  "EMPNMK7",  "SEQ8",  "EMPNMK8", "SEQ9",  "EMPNMK9",  "SEQ10", "EMPNMK10", 
					"SEQ11", "EMPNMK11", "SEQ12", "EMPNMK12", "SEQ13", "EMPNMK13","SEQ14", "EMPNMK14", "SEQ15", "EMPNMK15", 
					"SEQ16", "EMPNMK16", "SEQ17", "EMPNMK17", "SEQ18", "EMPNMK18","SEQ19", "EMPNMK19", "SEQ20", "EMPNMK20", 
					"SEQ21", "EMPNMK21", "SEQ22", "EMPNMK22", "SEQ23", "EMPNMK23","SEQ24", "EMPNMK24", "SEQ25", "EMPNMK25", 
					"SEQ26", "EMPNMK26", "SEQ27", "EMPNMK27", "SEQ28", "EMPNMK28","SEQ29", "EMPNMK29", "SEQ30", "EMPNMK30", 
					"SEQ31", "EMPNMK31", "SEQ32", "EMPNMK32", "SEQ33", "EMPNMK33","SEQ34", "EMPNMK34", "SEQ35", "EMPNMK35", 
					"SEQ36", "EMPNMK36", "SEQ37", "EMPNMK37", "SEQ38", "EMPNMK38","SEQ39", "EMPNMK39", "SEQ40", "EMPNMK40", 
					"SEQ41", "EMPNMK41", "SEQ42", "EMPNMK42", "SEQ43", "EMPNMK43","SEQ44", "EMPNMK44", "SEQ45", "EMPNMK45", 
					"SEQ46", "EMPNMK46", "SEQ47", "EMPNMK47", "SEQ48", "EMPNMK48","SEQ49", "EMPNMK49", "SEQ50", "EMPNMK50", 
					"SEQ51", "EMPNMK51", "SEQ52", "EMPNMK52", "SEQ53", "EMPNMK53","SEQ54", "EMPNMK54", "SEQ55", "EMPNMK55", 
					"SEQ56", "EMPNMK56", "SEQ57", "EMPNMK57", "SEQ58", "EMPNMK58","SEQ59", "EMPNMK59", "SEQ60", "EMPNMK60", 
			    "TREECD",  "SEQ",  "PAYSEQ" 
				}; 


				int[] intArrCN = new int[]{   
					 1,  6,  7, 20,  4, 50,  4,  30,  8,   8,  
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20,        
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20,                 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 8 ,  4, 4 
				}; 
	 		
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
				  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,                     
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1 
				};  


				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
          
					sql.append( " SELECT X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, X.DEPTCD, RTRIM(X.DEPTNM) DEPTNM ,X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT,X.STRTDT,                                                                                                                \n");
					sql.append( "        MAX(X.SEQ1)SEQ1,   MAX(X.EMPNMK1)EMPNMK1,   MAX(X.SEQ2)SEQ2,   MAX(X.EMPNMK2)EMPNMK2,   MAX(X.SEQ3)SEQ3,   MAX(X.EMPNMK3)EMPNMK3,   MAX(X.SEQ4)SEQ4,   MAX(X.EMPNMK4)EMPNMK4,   MAX(X.SEQ5)SEQ5,   MAX(X.EMPNMK5)EMPNMK5,    \n");
					sql.append( "        MAX(X.SEQ6)SEQ6,   MAX(X.EMPNMK6)EMPNMK6,   MAX(X.SEQ7)SEQ7,   MAX(X.EMPNMK7)EMPNMK7,   MAX(X.SEQ8)SEQ8,   MAX(X.EMPNMK8)EMPNMK8,   MAX(X.SEQ9)SEQ9,   MAX(X.EMPNMK9)EMPNMK9,   MAX(X.SEQ10)SEQ10, MAX(X.EMPNMK10)EMPNMK10,  \n");
					sql.append( "        MAX(X.SEQ11)SEQ11, MAX(X.EMPNMK11)EMPNMK11, MAX(X.SEQ12)SEQ12, MAX(X.EMPNMK12)EMPNMK12, MAX(X.SEQ13)SEQ13, MAX(X.EMPNMK13)EMPNMK13, MAX(X.SEQ14)SEQ14, MAX(X.EMPNMK14)EMPNMK14, MAX(X.SEQ15)SEQ15, MAX(X.EMPNMK15)EMPNMK15,  \n");
					sql.append( "        MAX(X.SEQ16)SEQ16, MAX(X.EMPNMK16)EMPNMK16, MAX(X.SEQ17)SEQ17, MAX(X.EMPNMK17)EMPNMK17, MAX(X.SEQ18)SEQ18, MAX(X.EMPNMK18)EMPNMK18, MAX(X.SEQ19)SEQ19, MAX(X.EMPNMK19)EMPNMK19, MAX(X.SEQ20)SEQ20, MAX(X.EMPNMK20)EMPNMK20,  \n");
					sql.append( "        MAX(X.SEQ21)SEQ21, MAX(X.EMPNMK21)EMPNMK21, MAX(X.SEQ22)SEQ22, MAX(X.EMPNMK22)EMPNMK22, MAX(X.SEQ23)SEQ23, MAX(X.EMPNMK23)EMPNMK23, MAX(X.SEQ24)SEQ24, MAX(X.EMPNMK24)EMPNMK24, MAX(X.SEQ25)SEQ25, MAX(X.EMPNMK25)EMPNMK25,  \n");
					sql.append( "        MAX(X.SEQ26)SEQ26, MAX(X.EMPNMK26)EMPNMK26, MAX(X.SEQ27)SEQ27, MAX(X.EMPNMK27)EMPNMK27, MAX(X.SEQ28)SEQ28, MAX(X.EMPNMK28)EMPNMK28, MAX(X.SEQ29)SEQ29, MAX(X.EMPNMK29)EMPNMK29, MAX(X.SEQ30)SEQ30, MAX(X.EMPNMK30)EMPNMK30,  \n");
					sql.append( "        MAX(X.SEQ31)SEQ31, MAX(X.EMPNMK31)EMPNMK31, MAX(X.SEQ32)SEQ32, MAX(X.EMPNMK32)EMPNMK32, MAX(X.SEQ33)SEQ33, MAX(X.EMPNMK33)EMPNMK33, MAX(X.SEQ34)SEQ34, MAX(X.EMPNMK34)EMPNMK34, MAX(X.SEQ35)SEQ35, MAX(X.EMPNMK35)EMPNMK35,  \n");
					sql.append( "        MAX(X.SEQ36)SEQ36, MAX(X.EMPNMK36)EMPNMK36, MAX(X.SEQ37)SEQ37, MAX(X.EMPNMK37)EMPNMK37, MAX(X.SEQ38)SEQ38, MAX(X.EMPNMK38)EMPNMK38, MAX(X.SEQ39)SEQ39, MAX(X.EMPNMK39)EMPNMK39, MAX(X.SEQ40)SEQ40, MAX(X.EMPNMK40)EMPNMK40,  \n");
					sql.append( "        MAX(X.SEQ41)SEQ41, MAX(X.EMPNMK41)EMPNMK41, MAX(X.SEQ42)SEQ42, MAX(X.EMPNMK42)EMPNMK42, MAX(X.SEQ43)SEQ43, MAX(X.EMPNMK43)EMPNMK43, MAX(X.SEQ44)SEQ44, MAX(X.EMPNMK44)EMPNMK44, MAX(X.SEQ45)SEQ45, MAX(X.EMPNMK45)EMPNMK45,  \n");
					sql.append( "        MAX(X.SEQ46)SEQ46, MAX(X.EMPNMK46)EMPNMK46, MAX(X.SEQ47)SEQ47, MAX(X.EMPNMK47)EMPNMK47, MAX(X.SEQ48)SEQ48, MAX(X.EMPNMK48)EMPNMK48, MAX(X.SEQ49)SEQ49, MAX(X.EMPNMK49)EMPNMK49, MAX(X.SEQ50)SEQ50, MAX(X.EMPNMK50)EMPNMK50,  \n");
					sql.append( "        MAX(X.SEQ51)SEQ51, MAX(X.EMPNMK51)EMPNMK51, MAX(X.SEQ52)SEQ52, MAX(X.EMPNMK52)EMPNMK52, MAX(X.SEQ53)SEQ53, MAX(X.EMPNMK53)EMPNMK53, MAX(X.SEQ54)SEQ54, MAX(X.EMPNMK54)EMPNMK54, MAX(X.SEQ55)SEQ55, MAX(X.EMPNMK55)EMPNMK55,  \n");
					sql.append( "        MAX(X.SEQ56)SEQ56, MAX(X.EMPNMK56)EMPNMK56, MAX(X.SEQ57)SEQ57, MAX(X.EMPNMK57)EMPNMK57, MAX(X.SEQ58)SEQ58, MAX(X.EMPNMK58)EMPNMK58, MAX(X.SEQ59)SEQ59, MAX(X.EMPNMK59)EMPNMK59, MAX(X.SEQ60)SEQ60, MAX(X.EMPNMK60)EMPNMK60,  \n");
					sql.append( "        MAX(X.TREECD) TREECD, MAX(X.SEQ)SEQ, MAX(X.PAYSEQ) PAYSEQ                                         \n");
					sql.append( "   FROM(                                                                                                  \n");
					sql.append( "        SELECT 'F' CHK,    A.EVAYM,  A.EMPNO, D.EMPNMK, A.DEPTCD,                                         \n");
					sql.append( " 	             E.DEPTNM,  A.PAYGRD, (F.MINORNM) PAYGRDNM, A.GRSTRTDT, A.STRTDT,                            \n");
					sql.append( "                E.TREECD,  F.SEQ,    D.PAYSEQ,                                                            \n");
					sql.append( " 			CASE B.EVASEQ WHEN 1 THEN B.EMPNOH END AS SEQ1,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 2 THEN B.EMPNOH END AS SEQ2,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 3 THEN B.EMPNOH END AS SEQ3,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 4 THEN B.EMPNOH END AS SEQ4,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 5 THEN B.EMPNOH END AS SEQ5,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 6 THEN B.EMPNOH END AS SEQ6,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 7 THEN B.EMPNOH END AS SEQ7,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 8 THEN B.EMPNOH END AS SEQ8,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 9 THEN B.EMPNOH END AS SEQ9,                                                    \n");
					sql.append( " 			CASE B.EVASEQ WHEN 10 THEN B.EMPNOH END AS SEQ10,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 11 THEN B.EMPNOH END AS SEQ11,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 12 THEN B.EMPNOH END AS SEQ12,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 13 THEN B.EMPNOH END AS SEQ13,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 14 THEN B.EMPNOH END AS SEQ14,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 15 THEN B.EMPNOH END AS SEQ15,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 16 THEN B.EMPNOH END AS SEQ16,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 17 THEN B.EMPNOH END AS SEQ17,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 18 THEN B.EMPNOH END AS SEQ18,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 19 THEN B.EMPNOH END AS SEQ19,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 20 THEN B.EMPNOH END AS SEQ20,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 21 THEN B.EMPNOH END AS SEQ21,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 22 THEN B.EMPNOH END AS SEQ22,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 23 THEN B.EMPNOH END AS SEQ23,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 24 THEN B.EMPNOH END AS SEQ24,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 25 THEN B.EMPNOH END AS SEQ25,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 26 THEN B.EMPNOH END AS SEQ26,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 27 THEN B.EMPNOH END AS SEQ27,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 28 THEN B.EMPNOH END AS SEQ28,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 29 THEN B.EMPNOH END AS SEQ29,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 30 THEN B.EMPNOH END AS SEQ30,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 31 THEN B.EMPNOH END AS SEQ31,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 32 THEN B.EMPNOH END AS SEQ32,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 33 THEN B.EMPNOH END AS SEQ33,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 34 THEN B.EMPNOH END AS SEQ34,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 35 THEN B.EMPNOH END AS SEQ35,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 36 THEN B.EMPNOH END AS SEQ36,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 37 THEN B.EMPNOH END AS SEQ37,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 38 THEN B.EMPNOH END AS SEQ38,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 39 THEN B.EMPNOH END AS SEQ39,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 40 THEN B.EMPNOH END AS SEQ40,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 41 THEN B.EMPNOH END AS SEQ41,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 42 THEN B.EMPNOH END AS SEQ42,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 43 THEN B.EMPNOH END AS SEQ43,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 44 THEN B.EMPNOH END AS SEQ44,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 45 THEN B.EMPNOH END AS SEQ45,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 46 THEN B.EMPNOH END AS SEQ46,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 47 THEN B.EMPNOH END AS SEQ47,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 48 THEN B.EMPNOH END AS SEQ48,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 49 THEN B.EMPNOH END AS SEQ49,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 50 THEN B.EMPNOH END AS SEQ50,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 51 THEN B.EMPNOH END AS SEQ51,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 52 THEN B.EMPNOH END AS SEQ52,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 53 THEN B.EMPNOH END AS SEQ53,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 54 THEN B.EMPNOH END AS SEQ54,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 55 THEN B.EMPNOH END AS SEQ55,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 56 THEN B.EMPNOH END AS SEQ56,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 57 THEN B.EMPNOH END AS SEQ57,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 58 THEN B.EMPNOH END AS SEQ58,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 59 THEN B.EMPNOH END AS SEQ59,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 60 THEN B.EMPNOH END AS SEQ60,                                                  \n");
					sql.append( " 			CASE B.EVASEQ WHEN 1 THEN C.EMPNMK END AS EMPNMK1,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 2 THEN C.EMPNMK END AS EMPNMK2,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 3 THEN C.EMPNMK END AS EMPNMK3,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 4 THEN C.EMPNMK END AS EMPNMK4,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 5 THEN C.EMPNMK END AS EMPNMK5,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 6 THEN C.EMPNMK END AS EMPNMK6,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 7 THEN C.EMPNMK END AS EMPNMK7,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 8 THEN C.EMPNMK END AS EMPNMK8,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 9 THEN C.EMPNMK END AS EMPNMK9,                                                 \n");
					sql.append( " 			CASE B.EVASEQ WHEN 10 THEN C.EMPNMK END AS EMPNMK10,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 11 THEN C.EMPNMK END AS EMPNMK11,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 12 THEN C.EMPNMK END AS EMPNMK12,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 13 THEN C.EMPNMK END AS EMPNMK13,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 14 THEN C.EMPNMK END AS EMPNMK14,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 15 THEN C.EMPNMK END AS EMPNMK15,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 16 THEN C.EMPNMK END AS EMPNMK16,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 17 THEN C.EMPNMK END AS EMPNMK17,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 18 THEN C.EMPNMK END AS EMPNMK18,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 19 THEN C.EMPNMK END AS EMPNMK19,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 20 THEN C.EMPNMK END AS EMPNMK20,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 21 THEN C.EMPNMK END AS EMPNMK21,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 22 THEN C.EMPNMK END AS EMPNMK22,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 23 THEN C.EMPNMK END AS EMPNMK23,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 24 THEN C.EMPNMK END AS EMPNMK24,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 25 THEN C.EMPNMK END AS EMPNMK25,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 26 THEN C.EMPNMK END AS EMPNMK26,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 27 THEN C.EMPNMK END AS EMPNMK27,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 28 THEN C.EMPNMK END AS EMPNMK28,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 29 THEN C.EMPNMK END AS EMPNMK29,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 30 THEN C.EMPNMK END AS EMPNMK30,                                               \n");
          sql.append( " 			CASE B.EVASEQ WHEN 31 THEN C.EMPNMK END AS EMPNMK31,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 32 THEN C.EMPNMK END AS EMPNMK32,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 33 THEN C.EMPNMK END AS EMPNMK33,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 34 THEN C.EMPNMK END AS EMPNMK34,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 35 THEN C.EMPNMK END AS EMPNMK35,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 36 THEN C.EMPNMK END AS EMPNMK36,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 37 THEN C.EMPNMK END AS EMPNMK37,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 38 THEN C.EMPNMK END AS EMPNMK38,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 39 THEN C.EMPNMK END AS EMPNMK39,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 40 THEN C.EMPNMK END AS EMPNMK40,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 41 THEN C.EMPNMK END AS EMPNMK41,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 42 THEN C.EMPNMK END AS EMPNMK42,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 43 THEN C.EMPNMK END AS EMPNMK43,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 44 THEN C.EMPNMK END AS EMPNMK44,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 45 THEN C.EMPNMK END AS EMPNMK45,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 46 THEN C.EMPNMK END AS EMPNMK46,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 47 THEN C.EMPNMK END AS EMPNMK47,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 48 THEN C.EMPNMK END AS EMPNMK48,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 49 THEN C.EMPNMK END AS EMPNMK49,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 50 THEN C.EMPNMK END AS EMPNMK50,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 51 THEN C.EMPNMK END AS EMPNMK51,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 52 THEN C.EMPNMK END AS EMPNMK52,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 53 THEN C.EMPNMK END AS EMPNMK53,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 54 THEN C.EMPNMK END AS EMPNMK54,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 55 THEN C.EMPNMK END AS EMPNMK55,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 56 THEN C.EMPNMK END AS EMPNMK56,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 57 THEN C.EMPNMK END AS EMPNMK57,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 58 THEN C.EMPNMK END AS EMPNMK58,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 59 THEN C.EMPNMK END AS EMPNMK59,                                               \n");
					sql.append( " 			CASE B.EVASEQ WHEN 60 THEN C.EMPNMK END AS EMPNMK60                                                \n");
					sql.append( " 	  FROM PAYROLL.HVEMPS A                                                                                \n");
					sql.append( " 	  LEFT JOIN PAYROLL.HVHEMPS  B ON A.EVAYM = B.EVAYM  AND  A.EMPNO = B.EMPNO                            \n");
					sql.append( " 	  LEFT JOIN PAYROLL.CIPERSON C ON B.EMPNOH = C.EMPNO  --고과자                                         \n");
					sql.append( " 	  LEFT JOIN PAYROLL.CIPERSON D ON A.EMPNO = D.EMPNO   --피고과자                                       \n");
					sql.append( " 	  LEFT JOIN PAYROLL.HCDEPT   E ON A.DEPTCD = E.DEPTCD                                                  \n");
					sql.append( " 	  LEFT JOIN PAYROLL.HCLCODE  F ON A.PAYGRD = F.MINORCD AND F.MAJORCD='2002'                            \n");
					sql.append( " 	 WHERE A.EVAYM='" + str1 +"'                                                                           \n");
					//sql.append( " 	   AND A.EVAYM = B.EVAYM                                                                               \n");
					//sql.append( " 	   AND A.EMPNO = B.EMPNO                                                                               \n");
					sql.append( "      AND (D.ENDDT='' OR SUBSTR(D.ENDDT,1,6)> '" + str1 +"')                                              \n" ); 
					sql.append( " )X                                                                                                       \n");
					sql.append( " WHERE X.EVAYM =  '" + str1 +"'    \n");
					sql.append( "   AND X.PAYGRD LIKE '" + str3 +"%'    \n");
					  
					if(!str4.equals(""))  sql.append( " AND X.EMPNMK LIKE '" + str4 +"%'    \n");

					if (str5.equals("2")) sql.append( " AND SUBSTR(X.TREECD,1,4) LIKE '"+ str6 + "%' \n");
					if (str5.equals("3")) sql.append( " AND SUBSTR(X.TREECD,1,4) LIKE '"+ str6 + "%' \n");
					if (str5.equals("4")) sql.append( " AND SUBSTR(X.TREECD,1,6) LIKE '"+ str6 + "%' \n");
					if (str5.equals("5")) sql.append( " AND RTRIM(X.TREECD) LIKE '" + str6 + "%'     \n");
					sql.append( " GROUP BY X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, X.DEPTCD, X.DEPTNM, X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT,X.STRTDT \n");

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