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
public class h060015_s1 extends HttpServlet {

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
				
				String [] str = new String[15];
				str[0]	= req.getParameter("v_str1");  //고과년월
				str[1]	= req.getParameter("v_str2");  //고과자사번
				str[2]	= req.getParameter("v_str3");  //부서코드
				str[3]	= req.getParameter("v_str4");  //level
				str[4]	= req.getParameter("v_str5");  //treecd
				str[5]	= req.getParameter("v_str6");  //직위 FROM     
				str[6]	= req.getParameter("v_str7");  //직위 TO
				str[7]	= req.getParameter("v_str8");  //직종    
				str[8]	= req.getParameter("v_str9");  //고과평정
				str[9]	= req.getParameter("v_str10"); //구분
				str[10] = req.getParameter("v_str11"); //조회[A],실행['']
				
				for(int i=0;i<=10;i++) {
					if(str[i] == null) str[i] = "";
				}
                 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ 
					"EVAYM"			,"GRPNM"			,"EMPNO"		,"EMPNMK",
					"DEPTCD"		,"DEPTNM"			,"PAYGRD"		,"PAYGRDNM",
					
					"EMPNOH1"	,"EMPNMH_1"		,"SCR1"			,"AVG1",
					"EMPNOH2"	,"EMPNMH_2"		,"SCR2"			,"AVG2",
					"EMPNOH3"	,"EMPNMH_3"		,"SCR3"			,"AVG3",
					"EMPNOH4"	,"EMPNMH_4"		,"SCR4"			,"AVG4",
					"EMPNOH5"	,"EMPNMH_5"		,"SCR5"			,"AVG5",
					"EMPNOH6"	,"EMPNMH_6"		,"SCR6"			,"AVG6",
					"EMPNOH7"	,"EMPNMH_7"		,"SCR7"			,"AVG7",
					"EMPNOH8"	,"EMPNMH_8"		,"SCR8"			,"AVG8",
					"EMPNOH9"	,"EMPNMH_9"		,"SCR9"			,"AVG9",
					"EMPNOH10"	,"EMPNMH_10"	,"SCR10"    	,"AVG10",
					
					"EMPNOH11"	,"EMPNMH_11"	,"SCR11"		,"AVG11",
					"EMPNOH12"	,"EMPNMH_12"	,"SCR12"		,"AVG12",
					"EMPNOH13"	,"EMPNMH_13"	,"SCR13"		,"AVG13",
					"EMPNOH14"	,"EMPNMH_14"	,"SCR14"		,"AVG14",
					"EMPNOH15"	,"EMPNMH_15"	,"SCR15"		,"AVG15",
					"EMPNOH16"	,"EMPNMH_16"	,"SCR16"		,"AVG16",
					"EMPNOH17"	,"EMPNMH_17"	,"SCR17"		,"AVG17",
					"EMPNOH18"	,"EMPNMH_18"	,"SCR18"		,"AVG18",
					"EMPNOH19"	,"EMPNMH_19"	,"SCR19"		,"AVG19",
					"EMPNOH20"	,"EMPNMH_20"	,"SCR20"    	,"AVG20",
					
					"EMPNOH21"	,"EMPNMH_21"	,"SCR21"		,"AVG21",
					"EMPNOH22"	,"EMPNMH_22"	,"SCR22"		,"AVG22",
					"EMPNOH23"	,"EMPNMH_23"	,"SCR23"		,"AVG23",
					"EMPNOH24"	,"EMPNMH_24"	,"SCR24"		,"AVG24",
					"EMPNOH25"	,"EMPNMH_25"	,"SCR25"		,"AVG25",
					"EMPNOH26"	,"EMPNMH_26"	,"SCR26"		,"AVG26",
					"EMPNOH27"	,"EMPNMH_27"	,"SCR27"		,"AVG27",
					"EMPNOH28"	,"EMPNMH_28"	,"SCR28"		,"AVG28",
					"EMPNOH29"	,"EMPNMH_29"	,"SCR29"		,"AVG29",
					"EMPNOH30"	,"EMPNMH_30"	,"SCR30"    	,"AVG30",
				
					"EMPNOH31"	,"EMPNMH_31"	,"SCR31"		,"AVG31",
					"EMPNOH32"	,"EMPNMH_32"	,"SCR32"		,"AVG32",
					"EMPNOH33"	,"EMPNMH_33"	,"SCR33"		,"AVG33",
					"EMPNOH34"	,"EMPNMH_34"	,"SCR34"		,"AVG34",
					"EMPNOH35"	,"EMPNMH_35"	,"SCR35"		,"AVG35",
					"EMPNOH36"	,"EMPNMH_36"	,"SCR36"		,"AVG36",
					"EMPNOH37"	,"EMPNMH_37"	,"SCR37"		,"AVG37",
					"EMPNOH38"	,"EMPNMH_38"	,"SCR38"		,"AVG38",
					"EMPNOH39"	,"EMPNMH_39"	,"SCR39"		,"AVG39",
					"EMPNOH40"	,"EMPNMH_40"	,"SCR40"    	,"AVG40",
					
					"GOGAGB" ,"TOTAVG"  ,"PAYSEQ"	,"STRTDT"
					
				}; 
					                                             
				int[] intArrCN = new int[]{   
					8,  30,  7,  20, 
					4,  50,  4,  30, 
				
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,

				 20,   5,  5,  5 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, -1, 
					-1, -1, -1, -1, 
					
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					

					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
				
					-1,  2,  2,  2
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

           if (str[9].equals("1")){ //정규직


		        sql.append( "  SELECT                                                                                                 \n");
            sql.append( "       X.EVAYM,  X.GRPNM, X.EMPNO, X.EMPNMK, X.DEPTCD, X.DEPTNM, X.PAYGRD, X.PAYGRDNM,                 \n");
            sql.append( "          MAX(X.EMPNOH1) EMPNOH1 ,   MAX(X.EMPNOH1)EMPNMH_1,   MAX(X.SCR1)SCR1,   MAX(X.AVG1)AVG1,     \n");
            sql.append( "          MAX(X.EMPNOH2) EMPNOH2 ,   MAX(X.EMPNOH2)EMPNMH_2,   MAX(X.SCR2)SCR2,   MAX(X.AVG2)AVG2,     \n");
            sql.append( "          MAX(X.EMPNOH3) EMPNOH3 ,   MAX(X.EMPNOH3)EMPNMH_3,   MAX(X.SCR3)SCR3,   MAX(X.AVG3)AVG3,     \n");
            sql.append( "          MAX(X.EMPNOH4) EMPNOH4 ,   MAX(X.EMPNOH4)EMPNMH_4,   MAX(X.SCR4)SCR4,   MAX(X.AVG4)AVG4,     \n");
            sql.append( "          MAX(X.EMPNOH5) EMPNOH5 ,   MAX(X.EMPNOH5)EMPNMH_5,   MAX(X.SCR5)SCR5,   MAX(X.AVG5)AVG5,     \n");
            sql.append( "          MAX(X.EMPNOH6) EMPNOH6 ,   MAX(X.EMPNOH6)EMPNMH_6,   MAX(X.SCR6)SCR6,   MAX(X.AVG6)AVG6,     \n");
            sql.append( "          MAX(X.EMPNOH7) EMPNOH7 ,   MAX(X.EMPNOH7)EMPNMH_7,   MAX(X.SCR7)SCR7,   MAX(X.AVG7)AVG7,     \n");
            sql.append( "          MAX(X.EMPNOH8) EMPNOH8 ,   MAX(X.EMPNOH8)EMPNMH_8,   MAX(X.SCR8)SCR8,   MAX(X.AVG8)AVG8,     \n");
            sql.append( "          MAX(X.EMPNOH9) EMPNOH9 ,   MAX(X.EMPNOH9)EMPNMH_9,   MAX(X.SCR9)SCR9,   MAX(X.AVG9)AVG9,     \n");
            sql.append( "          MAX(X.EMPNOH10) EMPNOH10,  MAX(X.EMPNOH10)EMPNMH_10,  MAX(X.SCR10)SCR10, MAX(X.AVG10)AVG10,   \n");
            sql.append( "          MAX(X.EMPNOH11) EMPNOH11,  MAX(X.EMPNOH11)EMPNMH_11,  MAX(X.SCR11)SCR11, MAX(X.AVG11)AVG11,   \n");
            sql.append( "          MAX(X.EMPNOH12) EMPNOH12,  MAX(X.EMPNOH12)EMPNMH_12,  MAX(X.SCR12)SCR12, MAX(X.AVG12)AVG12,   \n");
            sql.append( "          MAX(X.EMPNOH13) EMPNOH13 , MAX(X.EMPNOH13)EMPNMH_13,  MAX(X.SCR13)SCR13, MAX(X.AVG13)AVG13,   \n");
            sql.append( "          MAX(X.EMPNOH14) EMPNOH14 , MAX(X.EMPNOH14)EMPNMH_14,  MAX(X.SCR14)SCR14, MAX(X.AVG14)AVG14,   \n");
            sql.append( "          MAX(X.EMPNOH15) EMPNOH15 , MAX(X.EMPNOH15)EMPNMH_15,  MAX(X.SCR15)SCR15, MAX(X.AVG15)AVG15,   \n");
            sql.append( "          MAX(X.EMPNOH16) EMPNOH16 , MAX(X.EMPNOH16)EMPNMH_16,  MAX(X.SCR16)SCR16, MAX(X.AVG16)AVG16,   \n");
            sql.append( "          MAX(X.EMPNOH17) EMPNOH17 , MAX(X.EMPNOH17)EMPNMH_17,  MAX(X.SCR17)SCR17, MAX(X.AVG17)AVG17,   \n");
            sql.append( "          MAX(X.EMPNOH18) EMPNOH18 , MAX(X.EMPNOH18)EMPNMH_18,  MAX(X.SCR18)SCR18, MAX(X.AVG18)AVG18,   \n");
            sql.append( "          MAX(X.EMPNOH19) EMPNOH19 , MAX(X.EMPNOH19)EMPNMH_19,  MAX(X.SCR19)SCR19, MAX(X.AVG19)AVG19,   \n");
            sql.append( "          MAX(X.EMPNOH20) EMPNOH20,  MAX(X.EMPNOH20)EMPNMH_20,  MAX(X.SCR20)SCR20, MAX(X.AVG20)AVG20,   \n");
            sql.append( "          MAX(X.EMPNOH21) EMPNOH21,  MAX(X.EMPNOH21)EMPNMH_21,  MAX(X.SCR21)SCR21, MAX(X.AVG21)AVG21,   \n");
            sql.append( "          MAX(X.EMPNOH22) EMPNOH22,  MAX(X.EMPNOH22)EMPNMH_22,  MAX(X.SCR22)SCR22, MAX(X.AVG22)AVG22,   \n");
            sql.append( "          MAX(X.EMPNOH23) EMPNOH23 , MAX(X.EMPNOH23)EMPNMH_23,  MAX(X.SCR23)SCR23, MAX(X.AVG23)AVG23,   \n");
            sql.append( "          MAX(X.EMPNOH24) EMPNOH24 , MAX(X.EMPNOH24)EMPNMH_24,  MAX(X.SCR24)SCR24, MAX(X.AVG24)AVG24,   \n");
            sql.append( "          MAX(X.EMPNOH25) EMPNOH25 , MAX(X.EMPNOH25)EMPNMH_25,  MAX(X.SCR25)SCR25, MAX(X.AVG25)AVG25,   \n");
            sql.append( "          MAX(X.EMPNOH26) EMPNOH26 , MAX(X.EMPNOH26)EMPNMH_26,  MAX(X.SCR26)SCR26, MAX(X.AVG26)AVG26,   \n");
            sql.append( "          MAX(X.EMPNOH27) EMPNOH27 , MAX(X.EMPNOH27)EMPNMH_27,  MAX(X.SCR27)SCR27, MAX(X.AVG27)AVG27,   \n");
            sql.append( "          MAX(X.EMPNOH28) EMPNOH28 , MAX(X.EMPNOH28)EMPNMH_28,  MAX(X.SCR28)SCR28, MAX(X.AVG28)AVG28,   \n");
            sql.append( "          MAX(X.EMPNOH29) EMPNOH29 , MAX(X.EMPNOH29)EMPNMH_29,  MAX(X.SCR29)SCR29, MAX(X.AVG29)AVG29,   \n");
            sql.append( "          MAX(X.EMPNOH30) EMPNOH30,  MAX(X.EMPNOH30)EMPNMH_30,  MAX(X.SCR30)SCR30, MAX(X.AVG30)AVG30,   \n");
			      sql.append( "          MAX(X.EMPNOH21) EMPNOH31,  MAX(X.EMPNOH31)EMPNMH_31,  MAX(X.SCR31)SCR31, MAX(X.AVG31)AVG31,   \n");
            sql.append( "          MAX(X.EMPNOH22) EMPNOH32,  MAX(X.EMPNOH32)EMPNMH_32,  MAX(X.SCR32)SCR32, MAX(X.AVG32)AVG32,   \n");
            sql.append( "          MAX(X.EMPNOH23) EMPNOH33 , MAX(X.EMPNOH33)EMPNMH_33,  MAX(X.SCR33)SCR33, MAX(X.AVG33)AVG33,   \n");
            sql.append( "          MAX(X.EMPNOH24) EMPNOH34 , MAX(X.EMPNOH34)EMPNMH_34,  MAX(X.SCR34)SCR34, MAX(X.AVG34)AVG34,   \n");
            sql.append( "          MAX(X.EMPNOH25) EMPNOH35 , MAX(X.EMPNOH35)EMPNMH_35,  MAX(X.SCR35)SCR35, MAX(X.AVG35)AVG35,   \n");
            sql.append( "          MAX(X.EMPNOH26) EMPNOH36 , MAX(X.EMPNOH36)EMPNMH_36,  MAX(X.SCR36)SCR36, MAX(X.AVG36)AVG36,   \n");
            sql.append( "          MAX(X.EMPNOH27) EMPNOH37 , MAX(X.EMPNOH37)EMPNMH_37,  MAX(X.SCR37)SCR37, MAX(X.AVG37)AVG37,   \n");
            sql.append( "          MAX(X.EMPNOH28) EMPNOH38 , MAX(X.EMPNOH38)EMPNMH_38,  MAX(X.SCR38)SCR38, MAX(X.AVG38)AVG38,   \n");
            sql.append( "          MAX(X.EMPNOH29) EMPNOH39 , MAX(X.EMPNOH39)EMPNMH_39,  MAX(X.SCR39)SCR39, MAX(X.AVG39)AVG39,   \n");
            sql.append( "          MAX(X.EMPNOH30) EMPNOH40,  MAX(X.EMPNOH40)EMPNMH_40,  MAX(X.SCR40)SCR40, MAX(X.AVG30)AVG40,   \n");
            sql.append( "           X.GOGAGB,  X.TOTAVG, X.PAYSEQ, X.STRTDT                                                                       \n");
            sql.append( "  FROM (                                                                                                                 \n");
            sql.append( "  SELECT RTRIM(A.EVAYM) EVAYM,  RTRIM(D.MINORNM) GRPNM, A.EMPNO, RTRIM(E.EMPNMK) EMPNMK,                                 \n");
            sql.append( "          A.DEPTCD, RTRIM(B.DEPTNM) DEPTNM, A.PAYGRD PAYGRD, RTRIM(C.MINORNM) PAYGRDNM,                                  \n");
            sql.append( "          CASE K.EVASEQ WHEN 1 THEN K.EMPNOH END AS EMPNOH1,      COALESCE(A.SCR1,0)  SCR1,  COALESCE(A.AVG1,0)  AVG1,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 2 THEN K.EMPNOH END AS EMPNOH2,      COALESCE(A.SCR2,0)  SCR2,  COALESCE(A.AVG2,0)  AVG2,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 3 THEN K.EMPNOH END AS EMPNOH3,      COALESCE(A.SCR3,0)  SCR3,  COALESCE(A.AVG3,0)  AVG3,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 4 THEN K.EMPNOH END AS EMPNOH4,      COALESCE(A.SCR4,0)  SCR4,  COALESCE(A.AVG4,0)  AVG4,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 5 THEN K.EMPNOH END AS EMPNOH5,      COALESCE(A.SCR5,0)  SCR5,  COALESCE(A.AVG5,0)  AVG5,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 6 THEN K.EMPNOH END AS EMPNOH6,      COALESCE(A.SCR6,0)  SCR6,  COALESCE(A.AVG6,0)  AVG6,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 7 THEN K.EMPNOH END AS EMPNOH7,      COALESCE(A.SCR7,0)  SCR7,  COALESCE(A.AVG7,0)  AVG7,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 8 THEN K.EMPNOH END AS EMPNOH8,      COALESCE(A.SCR8,0)  SCR8,  COALESCE(A.AVG8,0)  AVG8,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 9 THEN K.EMPNOH END AS EMPNOH9,      COALESCE(A.SCR9,0)  SCR9,  COALESCE(A.AVG9,0)  AVG9,   \n");
            sql.append( "          CASE K.EVASEQ WHEN 10 THEN K.EMPNOH END AS EMPNOH10,    COALESCE(A.SCR10,0) SCR10, COALESCE(A.AVG10,0) AVG10,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 11 THEN K.EMPNOH END AS EMPNOH11,    COALESCE(A.SCR11,0) SCR11, COALESCE(A.AVG11,0) AVG11,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 12 THEN K.EMPNOH END AS EMPNOH12,    COALESCE(A.SCR12,0) SCR12, COALESCE(A.AVG12,0) AVG12,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 13 THEN K.EMPNOH END AS EMPNOH13,    COALESCE(A.SCR13,0) SCR13, COALESCE(A.AVG13,0) AVG13,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 14 THEN K.EMPNOH END AS EMPNOH14,    COALESCE(A.SCR14,0) SCR14, COALESCE(A.AVG14,0) AVG14,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 15 THEN K.EMPNOH END AS EMPNOH15,    COALESCE(A.SCR15,0) SCR15, COALESCE(A.AVG15,0) AVG15,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 16 THEN K.EMPNOH END AS EMPNOH16,    COALESCE(A.SCR16,0) SCR16, COALESCE(A.AVG16,0) AVG16,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 17 THEN K.EMPNOH END AS EMPNOH17,    COALESCE(A.SCR17,0) SCR17, COALESCE(A.AVG17,0) AVG17,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 18 THEN K.EMPNOH END AS EMPNOH18,    COALESCE(A.SCR18,0) SCR18, COALESCE(A.AVG18,0) AVG18,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 19 THEN K.EMPNOH END AS EMPNOH19,    COALESCE(A.SCR19,0) SCR19, COALESCE(A.AVG19,0) AVG19,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 20 THEN K.EMPNOH END AS EMPNOH20,    COALESCE(A.SCR20,0) SCR20, COALESCE(A.AVG20,0) AVG20,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 21 THEN K.EMPNOH END AS EMPNOH21,    COALESCE(A.SCR21,0) SCR21, COALESCE(A.AVG21,0) AVG21,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 22 THEN K.EMPNOH END AS EMPNOH22,    COALESCE(A.SCR22,0) SCR22, COALESCE(A.AVG22,0) AVG22,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 23 THEN K.EMPNOH END AS EMPNOH23,    COALESCE(A.SCR23,0) SCR23, COALESCE(A.AVG23,0) AVG23,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 24 THEN K.EMPNOH END AS EMPNOH24,    COALESCE(A.SCR24,0) SCR24, COALESCE(A.AVG24,0) AVG24,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 25 THEN K.EMPNOH END AS EMPNOH25,    COALESCE(A.SCR25,0) SCR25, COALESCE(A.AVG25,0) AVG25,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 26 THEN K.EMPNOH END AS EMPNOH26,    COALESCE(A.SCR26,0) SCR26, COALESCE(A.AVG26,0) AVG26,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 27 THEN K.EMPNOH END AS EMPNOH27,    COALESCE(A.SCR27,0) SCR27, COALESCE(A.AVG27,0) AVG27,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 28 THEN K.EMPNOH END AS EMPNOH28,    COALESCE(A.SCR28,0) SCR28, COALESCE(A.AVG28,0) AVG28,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 29 THEN K.EMPNOH END AS EMPNOH29,    COALESCE(A.SCR29,0) SCR29, COALESCE(A.AVG29,0) AVG29,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 30 THEN K.EMPNOH END AS EMPNOH30,    COALESCE(A.SCR30,0) SCR30, COALESCE(A.AVG30,0) AVG30,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 31 THEN K.EMPNOH END AS EMPNOH31,    COALESCE(A.SCR31,0) SCR31, COALESCE(A.AVG31,0) AVG31,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 32 THEN K.EMPNOH END AS EMPNOH32,    COALESCE(A.SCR32,0) SCR32, COALESCE(A.AVG32,0) AVG32,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 33 THEN K.EMPNOH END AS EMPNOH33,    COALESCE(A.SCR33,0) SCR33, COALESCE(A.AVG33,0) AVG33,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 34 THEN K.EMPNOH END AS EMPNOH34,    COALESCE(A.SCR34,0) SCR34, COALESCE(A.AVG34,0) AVG34,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 35 THEN K.EMPNOH END AS EMPNOH35,    COALESCE(A.SCR35,0) SCR35, COALESCE(A.AVG35,0) AVG35,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 36 THEN K.EMPNOH END AS EMPNOH36,    COALESCE(A.SCR36,0) SCR36, COALESCE(A.AVG36,0) AVG36,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 37 THEN K.EMPNOH END AS EMPNOH37,    COALESCE(A.SCR37,0) SCR37, COALESCE(A.AVG37,0) AVG37,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 38 THEN K.EMPNOH END AS EMPNOH38,    COALESCE(A.SCR38,0) SCR38, COALESCE(A.AVG38,0) AVG38,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 39 THEN K.EMPNOH END AS EMPNOH39,    COALESCE(A.SCR39,0) SCR39, COALESCE(A.AVG39,0) AVG39,  \n");
            sql.append( "          CASE K.EVASEQ WHEN 40 THEN K.EMPNOH END AS EMPNOH40,    COALESCE(A.SCR40,0) SCR40, COALESCE(A.AVG40,0) AVG40,  \n");
  
		      	sql.append( "     CASE WHEN A.TOTAVG >= '85' THEN '상'                                                                                \n");
            sql.append( "          WHEN A.TOTAVG < '85' AND A.TOTAVG >= '75' THEN '중상'                                                          \n");
            sql.append( "          WHEN A.TOTAVG < '75' AND A.TOTAVG >= '65' THEN '중'                                                            \n");
            sql.append( "          WHEN A.TOTAVG < '65' AND A.TOTAVG >= '55' THEN '중하'                                                          \n");
            sql.append( "          WHEN A.TOTAVG < '55' THEN '하' END AS GOGAGB,                         \n");
			      sql.append( "          COALESCE(A.TOTAVG,0) TOTAVG, IFNULL(E.PAYSEQ,0)PAYSEQ, A.STRTDT STRTDT                                                  \n");
            sql.append( "            FROM PAYROLL.HVEMPS A ,PAYROLL.HVHEMPS K                                                                     \n");
            sql.append( "          LEFT JOIN PAYROLL.cIPERSON E ON A.EMPNO=E.EMPNO                                                                \n");
            sql.append( "          LEFT JOIN PAYROLL.HCDEPT  B ON A.DEPTCD = B.DEPTCD                                                             \n");
            sql.append( "          LEFT JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD='2002'                                       \n");
            sql.append( "          LEFT JOIN PAYROLL.HCLCODE D ON C.MEMO   = D.MEMO    AND D.MAJORCD='2014'                                       \n");
            sql.append( "          LEFT JOIN PAYROLL.HCLCODE O ON E.JOBKIND= O.MINORCD AND D.MAJORCD='2034'                                       \n");
            sql.append( "            WHERE RTRIM(A.EMPNO) <> '' AND  A.EVAYM = K.EVAYM AND A.EMPNO = K.EMPNO                                      \n");
						if (str[10].equals("A")) {                                                                                                      
							                        sql.append( " AND (E.ENDDT='' OR SUBSTR(E.ENDDT,1,6)>'" + str[0] +"       ')										\n");
							if (!str[0].equals(""))	sql.append( " AND A.EVAYM = '" + str[0] +"'				 				            		\n");						
							if (str[3].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[4] + "'									\n");
							if (str[3].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[4] + "'											\n");
							
							if (!str[5].equals("")&&!str[6].equals(""))	sql.append( " AND C.SEQ	BETWEEN  " + str[5] +"	AND " + str[6] +"	\n"); 
							if (str[8].equals("T")) sql.append( " AND ABS(AVG1-AVG2) > 5.00						/*고과평정*/						\n");
							if (!str[9].equals("")) sql.append( " AND A.GRSREF = '"+ str[9] + "' \n");  
						}
           sql.append( " )X                                                                                                                      \n");
           sql.append( " GROUP BY  X.EVAYM,  X.GRPNM, X.EMPNO, X.EMPNMK, X.DEPTCD, X.DEPTNM, X.PAYGRD, X.PAYGRDNM, X.GOGAGB,  X.TOTAVG, X.PAYSEQ, X.STRTDT\n");
 			 }
       
					logger.dbg.println(this,sql.toString());

/*********************************************************************************************/
					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				} //IF !GauceReq
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