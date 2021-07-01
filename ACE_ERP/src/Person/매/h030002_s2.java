package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import gauce.util.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h030002_s2 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		//GauceStatement stmt =null;
    Statement stmt  =null;
		//Connection conn = null;
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
				
				String [] str = new String [22];
				str[0]	= req.getParameter("v_str1");		//재직유무
				str[1]	= req.getParameter("v_str2");		//부서코드
				str[2]	= req.getParameter("v_str3");		//직종구분
				str[3]	= req.getParameter("v_str4");		//직위코드
				str[4]	= req.getParameter("v_str5");		//LEVEL
				str[5]	= req.getParameter("v_str6");		//TREECD
				str[6]	= req.getParameter("v_str7");		//자격증코드
				str[7]	= req.getParameter("v_str8");		//입사일자 fr
				str[8]	= req.getParameter("v_str9");		//입사일자 to
				str[9]	= req.getParameter("v_str10");	//승진일자 fr
				str[10]	= req.getParameter("v_str11");	//승진일자 to
				str[11] = req.getParameter("v_str12");	//퇴사일자 fr
				str[12] = req.getParameter("v_str13");	//퇴사일자 to
				str[13] = req.getParameter("v_str14");	//생년월일 fr
				str[14] = req.getParameter("v_str15");	//생년월일 to
				str[15] = req.getParameter("v_str16");	//현재년
				str[16] = req.getParameter("v_str17");	//현재년월
				str[17] = req.getParameter("v_str18");	//별정직구분
				str[18] = req.getParameter("v_str19");	//발령구분
				str[19] = req.getParameter("v_str20");	//발령구분
				str[20] = req.getParameter("v_str21");	//발령구분
				str[21] = req.getParameter("v_Strr22");	//ORDER BY (ASC/DESC)

				for (int s=0;s<=21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO", "EMPNMK",  "DEPTCD", "DEPTNM",  "TREECD",         
                                          "CNT",   "GUBUN",   "PAYGNM", "PAYGRD",  "PAYSEQ",             
                                          "SEX",   "GRSTRTDT","STRTDT", "LAMDT",   "BIRDT",
                                          "PERAGE","LSTEDU",  "PGCNM",  "PGCCD",   "ETC",
																					"SEQ",   "BANDOK"//, "ORDCD","ORDNM"
																				};

				int[] intArrCN = new int[]  {  7,   30,   4,  30,   8,          
                                       5,    1,  30,   4,   4,          
                                       1,    8,   8,   8,   8,          
                                       4,   60,  30,   4,  30,
																			 5,   10//,   2,  30
																	  }; 

				int[] intArrCN2 = new int[] { -1,   -1,  -1,  -1,  -1,
																	  	-1,   -1,  -1,  -1,  -1,
																		  -1,   -1,  -1,  -1,  -1,
																		  -1,   -1,  -1,  -1,  -1,
																			-1,   -1//,  -1,  -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					//본부 부서 팀별 현황
					sql.append( " SELECT X.EMPNO, ");
					sql.append( " X.EMPNMK, ");
					sql.append( " Y.DEPTCD, ");
					sql.append( " CASE WHEN Y.LEVEL = '2' OR Y.LEVEL = '1' THEN '' || Y.DEPTNM END AS DEPTNM, ");
					sql.append( " X.TREECD, COALESCE(X.CNT,0) CNT, X.GUBUN, ");
					sql.append( "	X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, ");
					sql.append( "	X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, ");
					sql.append( " X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ ");
					//sql.append( " ,X.ORDCD,X.ORDNM ");
					sql.append( " FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, ");
					sql.append( "	    SUBSTR(B.TREECD,1,4) TREECD, ");
					sql.append( "     COUNT(A.EMPNO) CNT, MAX('2') AS GUBUN, ");
					sql.append( "	    '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, ");
					sql.append( "	    '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, ");
					sql.append( "	    '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ ");
					//sql.append( " ,K.ORDCD,M.ORDNM ");
					sql.append( " FROM PAYROLL.HIPERSON A ");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HOORDER K ON A.EMPNO = K.EMPNO ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD ");
					
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}
					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'");
					if (!str[17].equals("A")) sql.append( " AND A.EMPDIV = '2' ");
					if (!str[18].equals("")) sql.append( " AND K.APPDT <> '' AND K.ORDCD IN ('"+str[18]+"') ");

					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.SEX = '"+str[20]+"' \n");

					sql.append( " GROUP BY SUBSTR(B.TREECD,1,4)) X ");
					//sql.append( " GROUP BY SUBSTR(B.TREECD,1,4),K.ORDCD,M.ORDNM) X ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT Y ON X.TREECD = SUBSTR(Y.TREECD,1,4) AND Y.LEVEL IN ('1','2')   ");

					sql.append( "	UNION ");

					sql.append( " SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, ");
					sql.append( " CASE WHEN Y.LEVEL = '2' OR Y.LEVEL = '1' THEN '   ' || Y.DEPTNM END AS DEPTNM, ");
					sql.append( "	X.TREECD, COALESCE(X.CNT,0) CNT, X.GUBUN, ");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, ");
					sql.append( "	X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, ");
					sql.append( "	X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ ");
					//sql.append( " ,X.ORDCD,X.ORDNM ");
					sql.append( "	FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, ");
					sql.append( "       SUBSTR(TREECD,1,4) TREECD , COUNT(A.EMPNO) CNT , MAX('21') AS GUBUN, ");
					sql.append( "	       '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, ");
					sql.append( " '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, ");
					sql.append( " '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ ");
					//sql.append( " ,K.ORDCD,M.ORDNM ");
					sql.append( " FROM PAYROLL.HIPERSON A ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HOORDER K ON A.EMPNO = K.EMPNO ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD ");

					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}
					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'");
					if (!str[17].equals("A")) sql.append( " AND A.EMPDIV = '2' ");
					if (!str[18].equals("")) sql.append( " AND K.APPDT <> '' AND K.ORDCD IN ('"+str[18]+"') ");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.SEX = '"+str[20]+"' \n");

					sql.append( " AND SUBSTR(B.TREECD,5,4)='0000' ");
					sql.append( "	GROUP BY SUBSTR(TREECD,1,4)) X ");
					//sql.append( "	GROUP BY SUBSTR(TREECD,1,4),K.ORDCD,M.ORDNM) X ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT y ON X.TREECD = SUBSTR(Y.TREECD,1,4) AND Y.LEVEL IN('1','2') ");

					sql.append( "	UNION ");

					sql.append( "	SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, ");
					sql.append( "	CASE WHEN Y.LEVEL = '3' THEN '   ' || Y.DEPTNM END AS DEPTNM, ");
					sql.append( "	X.TREECD, COALESCE(X.CNT,0) CNT, X.GUBUN, ");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, ");
					sql.append( "	X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, ");
					sql.append( " X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ ");
					//sql.append( " ,X.ORDCD,X.ORDNM ");
					sql.append( " FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, ''DEPTCD, ''DEPTNM, ");
					sql.append( "      SUBSTR(B.TREECD,1,6) TREECD , COUNT(A.EMPNO) CNT , MAX('3') AS GUBUN, ");
					sql.append( "      '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, ");
					sql.append( " '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, ");
					sql.append( " '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ ");
					//sql.append( " ,K.ORDCD,M.ORDNM ");
					sql.append( "	FROM PAYROLL.HIPERSON A ");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HOORDER K ON A.EMPNO = K.EMPNO ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD ");

					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}
					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'");
					if (!str[17].equals("A")) sql.append( " AND A.EMPDIV = '2' ");
					if (!str[18].equals("")) sql.append( " AND K.APPDT <> '' AND K.ORDCD IN ('"+str[18]+"') ");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.SEX = '"+str[20]+"' \n");

					sql.append( " AND SUBSTR(B.TREECD,5,2)<>'00' ");
					sql.append( " GROUP BY SUBSTR(B.TREECD,1,6)) X ");
					//sql.append( " GROUP BY SUBSTR(B.TREECD,1,6),K.ORDCD,M.ORDNM) X ");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT y ON X.TREECD = SUBSTR(Y.TREECD,1,6) AND Y.LEVEL IN('3') ");

					sql.append( "	UNION ");

					sql.append( "	SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, ");
					sql.append( " CASE WHEN Y.LEVEL = '3' THEN '   ' || Y.DEPTNM END AS DEPTNM, ");
					sql.append( " X.TREECD,COALESCE(X.CNT,0) CNT, X.GUBUN, ");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, ");
					sql.append( " X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, ");
					sql.append( " X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ ");
					//sql.append( " ,X.ORDCD,X.ORDNM ");
					sql.append( " FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, ");
					sql.append( "	      SUBSTR(TREECD,1,6) TREECD , COUNT(A.EMPNO) CNT , MAX('31') AS GUBUN, ");
					sql.append( "	    '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, ");
					sql.append( "  '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, ");
					sql.append( "  '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ ");
					//sql.append( "  ,K.ORDCD,M.ORDNM ");
					sql.append( "	FROM PAYROLL.HIPERSON A ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HOORDER K ON A.EMPNO = K.EMPNO ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD ");
					
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}
					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'");
					if (!str[17].equals("A")) sql.append( " AND A.EMPDIV = '2' ");
					if (!str[18].equals("")) sql.append( " AND K.APPDT <> '' AND K.ORDCD IN ('"+str[18]+"') ");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.SEX = '"+str[20]+"' \n");
					
					sql.append( " AND SUBSTR(B.TREECD,5,2)<>'00' AND SUBSTR(B.TREECD,7,2)='00' ");
					sql.append( "	AND (SELECT COUNT(H.TREECD) FROM PAYROLL.HCDEPT H ");
					sql.append( " WHERE SUBSTR(B.TREECD,1,6) = SUBSTR(H.TREECD,1,6) AND SUBSTR(H.TREECD,7,2)<>'00')>0 ");
					sql.append( " GROUP BY SUBSTR(TREECD,1,6)) X ");
					//sql.append( " GROUP BY SUBSTR(TREECD,1,6),K.ORDCD,M.ORDNM) X ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT y ON X.TREECD = SUBSTR(Y.TREECD,1,6) AND Y.LEVEL IN('3') ");

					sql.append( " UNION ");

					sql.append( " SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, ");
					sql.append( "	CASE WHEN Y.LEVEL = '4' THEN '     ' || Y.DEPTNM END AS DEPTNM, ");
					sql.append( "	X.TREECD,COALESCE(X.CNT,0) CNT, X.GUBUN, ");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, ");
					sql.append( " X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, ");
					sql.append( "	X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ ");
					//sql.append( " ,X.ORDCD,X.ORDNM ");
					sql.append( " FROM(SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, ");
					sql.append( "	     B.TREECD, COUNT(A.EMPNO) CNT , MAX('4') AS GUBUN, ");
					sql.append( "	       '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, ");
					sql.append( "	'' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, ");
					sql.append( " '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ ");
					//sql.append( " ,K.ORDCD,M.ORDNM ");
					sql.append( "	FROM PAYROLL.HIPERSON A ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HOORDER K ON A.EMPNO = K.EMPNO ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD ");

					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}
					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'");
					if (!str[17].equals("A")) sql.append( " AND A.EMPDIV = '2' ");
					if (!str[18].equals("")) sql.append( " AND K.APPDT <> '' AND K.ORDCD IN ('"+str[18]+"') ");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.SEX = '"+str[20]+"' \n");
					
					sql.append( " AND SUBSTR(B.TREECD,5,2)<>'00' AND SUBSTR(B.TREECD,7,2)<>'00' ");
					sql.append( " GROUP BY TREECD) X  ");
					//sql.append( " GROUP BY TREECD,K.ORDCD,M.ORDNM) X  ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT Y ON X.TREECD = Y.TREECD AND Y.LEVEL IN('4') ");

					sql.append( "	UNION ");

					sql.append( " SELECT RTRIM(A.EMPNO) EMPNO, RTRIM(A.EMPNMK) EMPNMK, RTRIM(A.DEPTCD) DEPTCD, ");
					sql.append( "	CASE WHEN B.LEVEL = '1' THEN '   ' || B.DEPTNM ");
					sql.append( "			 WHEN B.LEVEL = '2' THEN '   ' || B.DEPTNM ");
					sql.append( "      WHEN B.LEVEL = '3' THEN '   ' || B.DEPTNM ");
					sql.append( "	     WHEN B.LEVEL = '4' THEN '     ' || B.DEPTNM ");
					sql.append( "	END AS DEPTNM, ");
					sql.append( "	RTRIM(B.TREECD) TREECD,0 as CNT, '5' as GUBUN, ");
					sql.append( " RTRIM(C.MINORNM) AS PAYGNM, RTRIM(A.PAYGRD) AS PAYGRD, RTRIM(A.PAYSEQ) AS PAYSEQ, RTRIM(A.SEX) AS SEX, ");
					sql.append( "	RTRIM(A.GRSTRTDT) AS GRSTRTDT,    RTRIM(A.STRTDT) AS STRTDT, RTRIM(A.LAMDT) AS LAMDT, ");
					sql.append( " RTRIM(A.BIRDT)  AS BIRDT,    2005-CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE, ");
					sql.append( " RTRIM(G.SCHNM) || '' || RTRIM(JJ.MINORNM) AS LSTEDU,  RTRIM(J.MINORNM) AS PGCNM,  ");
					sql.append( " RTRIM(J.MINORCD) AS PGCCD, '' AS ETC, ");
					sql.append( " 0 AS SEQ, 'default' AS BANDOK,C.SEQ AS GRD_SEQ ");
					//sql.append( " ,K.ORDCD,M.ORDNM ");
					sql.append( " FROM PAYROLL.HIPERSON A LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HIEDUC G ON A.EMPNO = G.EMPNO ");
					sql.append( "			AND G.GRAYY = (SELECT MAX(GRAYY) AS GRAYY ");
					sql.append( "	    FROM PAYROLL.HIEDUC ");
					sql.append( "			WHERE EMPNO = A.EMPNO) ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE J ON G.PGCCD  = J.MINORCD AND J.MAJORCD = '1129' ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE JJ ON G.EDCCD = JJ.MINORCD AND JJ.MAJORCD = '1115' ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HOORDER K ON A.EMPNO = K.EMPNO ");
					//sql.append( " LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD ");
			
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}
					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'");
					if (!str[17].equals("A")) sql.append( " AND A.EMPDIV = '2' ");
					//if (!str[18].equals("")) sql.append( " AND K.ORDCD IN ('"+str[18]+"') ");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.SEX = '"+str[20]+"' \n");

					if (str[21].equals("1")) 	{
						sql.append( " ORDER BY PAYGRD, PAYSEQ DESC, EMPNMK ASC \n");
					}else {
						sql.append( " ORDER BY PAYGRD, PAYSEQ ASC, EMPNMK ASC \n");
					}

					//sql.append( "	ORDER BY TREECD ASC , GUBUN ASC, GRD_SEQ ASC ");

				  //logger.dbg.println(this, sql.toString());

/*********************************************************************************************/

		//			stmt = conn.getGauceStatement(sql.toString());
	 	//	    stmt.executeQuery(dSet);

		      stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery(sql.toString());

					GauceDataRow row =null;
					
					int seq = 1;
					
					while(rs.next()){

							row = dSet.newDataRow();

							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(1)));
              row.addColumnValue(gauceUtil.UniToEuc(rs.getString(2)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(3)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(4)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(5)));
							row.addColumnValue(rs.getInt(6));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(7)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(8)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(9)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(10)));
              row.addColumnValue(gauceUtil.UniToEuc(rs.getString(11)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(12)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(13)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(14)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(15)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(16)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(17)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(18)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(19)));
              row.addColumnValue(gauceUtil.UniToEuc(rs.getString(20)));
							
             	if(rs.getString(7).equals("5")) {
								row.addColumnValue(seq);
								seq++;

							}else{
								row.addColumnValue(0);

							}

							dSet.addDataRow(row);
          }
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
