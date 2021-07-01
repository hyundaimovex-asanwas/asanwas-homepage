package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import gauce.util.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h080004_s2 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
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
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				
				String [] str = new String [25];
				str[0]	= req.getParameter("v_str1");		//��������
				str[1]	= req.getParameter("v_str2");		//�μ��ڵ�
				str[2]	= req.getParameter("v_str3");		//��������
				str[3]	= req.getParameter("v_str4");		//�����ڵ�
				str[4]	= req.getParameter("v_str5");		//LEVEL
				str[5]	= req.getParameter("v_str6");		//TREECD
				str[6]	= req.getParameter("v_str7");		//�Ի籸��
				str[7]	= req.getParameter("v_str8");		//�Ի����� fr
				str[8]	= req.getParameter("v_str9");		//�Ի����� to
				str[9]	= req.getParameter("v_str10");	//�������� fr
				str[10]	= req.getParameter("v_str11");	//�������� to
				str[11] = req.getParameter("v_str12");	//������� fr
				str[12] = req.getParameter("v_str13");	//������� to
				str[13] = req.getParameter("v_str14");	//������� fr
				str[14] = req.getParameter("v_str15");	//������� to
				str[15] = req.getParameter("v_str16");	//�����
				str[16] = req.getParameter("v_str17");	//������
				str[17] = req.getParameter("v_str18");	//����������
				str[18] = req.getParameter("v_str19");	//���ޱ���
				str[19] = req.getParameter("v_str20");	//����
				str[20] = req.getParameter("v_str21");	//ȣ��
				str[21] = req.getParameter("v_str22");	//ȣ�� ODER BY (ASC/DESC)

				for (int s=0;s<=21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO", "EMPNMK",  "DEPTCD", "DEPTNM",  "TREECD",         
                                          "CNT",   "GUBUN",   "PAYGNM", "PAYGRD",  "PAYSEQ",             
                                          "SEX",   "GRSTRTDT","STRTDT", "LAMDT",   "BIRDT",
                                          "PERAGE","LSTEDU",  "PGCNM",  "PGCCD",   "ETC",
																					"SEQ",   "BANDOK",	"GRD_SEQ","GRDDIV"
																				};

				int[] intArrCN = new int[]  {  7,   30,   4,  30,   8,          
                                       5,    1,  30,   4,   4,          
                                       1,    8,   8,   8,   8,          
                                       4,   60,  30,   4,  30,
																			 5,   10,   3,   4
																	  }; 

				int[] intArrCN2 = new int[] { -1,   -1,  -1,  -1,  -1,
																	  	-1,   -1,  -1,  -1,  -1,
																		  -1,   -1,  -1,  -1,  -1,
																		  -1,   -1,  -1,  -1,  -1,
																			-1,   -1,   0,  -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					//���� �μ� ���� ��Ȳ
					sql.append( " SELECT X.EMPNO, \n");
					sql.append( " X.EMPNMK, \n");
					sql.append( " Y.DEPTCD, \n");
					sql.append( " CASE WHEN Y.LEVEL = '2' OR Y.LEVEL = '1' THEN '' || Y.DEPTNM END AS DEPTNM, \n");
					sql.append( " X.TREECD, COALESCE(X.CNT,0) CNT, X.GUBUN, \n");
					sql.append( "	X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, \n");
					sql.append( "	X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, \n");
					sql.append( " X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ, X.GRDDIV \n");
					sql.append( " FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, \n");
					sql.append( "	    SUBSTR(B.TREECD,1,4) TREECD, \n");
					sql.append( "     COUNT(A.EMPNO) CNT, MAX('2') AS GUBUN, \n");
					sql.append( "	    '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, \n");
					sql.append( "	    '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, \n");
					sql.append( "	    '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ, '' AS GRDDIV \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A \n");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n");
					
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') \n");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'	\n");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'		\n");
/*
					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'	\n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'			\n");
*/
                    if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[5] +"'  \n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[5] +"'  \n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] + "' \n");
					if (str[4].equals("4")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[5] +"'  \n");
					if (str[4].equals("5")) sql.append( " AND RTRIM(B.TREECD)= '" + str[5] + "'      \n");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'						\n");
					if (!str[7].equals("")) sql.append( " AND A.STRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'		\n");
					//if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'	\n");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'	\n");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'	\n");
					
					if (str[17].equals("A")) {
						sql.append( " AND A.EMPDIV IN ('3') \n");	//�ѱ��ΰ����
					}else{
						sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//�ѱ��ΰ����
					}

					if (!str[18].equals("")) sql.append( " AND A.GRDDIV = '" + str[18] + "'															\n");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.SEX = '"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[20]+"' \n");

					sql.append( " GROUP BY SUBSTR(B.TREECD,1,4)) X																											\n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT Y ON X.TREECD = SUBSTR(Y.TREECD,1,4) AND Y.LEVEL IN ('1','2')\n");

					sql.append( "	UNION \n");

					sql.append( " SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, \n");
					sql.append( " CASE WHEN Y.LEVEL = '2' OR Y.LEVEL = '1' THEN '   ' || Y.DEPTNM END AS DEPTNM, \n");
					sql.append( "	X.TREECD, COALESCE(X.CNT,0) CNT, X.GUBUN, \n");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, \n");
					sql.append( "	X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, \n");
					sql.append( "	X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ, X.GRDDIV \n");
					sql.append( "	FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, \n");
					sql.append( "       SUBSTR(TREECD,1,4) TREECD , COUNT(A.EMPNO) CNT , MAX('21') AS GUBUN, \n");
					sql.append( "	       '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, \n");
					sql.append( " '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, \n");
					sql.append( " '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ, '' AS GRDDIV \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n");

					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') \n");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'	\n");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'		\n");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'	\n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'			\n");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'						\n");
					if (!str[7].equals("")) sql.append( " AND A.STRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'		\n");
					//if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'	\n");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'	\n");
					
					if (str[17].equals("A")) {
						sql.append( " AND A.EMPDIV IN ('3') \n");	//�ѱ��ΰ����
					}else{
						sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//�ѱ��ΰ����
					}

					if (!str[18].equals("")) sql.append( " AND A.GRDDIV = '" + str[18] + "' \n");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.SEX = '"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[20]+"' \n");

					sql.append( " AND SUBSTR(B.TREECD,5,4)='0000' \n");
					sql.append( "	GROUP BY SUBSTR(TREECD,1,4)) X	\n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT y ON X.TREECD = SUBSTR(Y.TREECD,1,4) AND Y.LEVEL IN('1','2') \n");

					sql.append( "	UNION \n");

					sql.append( "	SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, \n");
					sql.append( "	CASE WHEN Y.LEVEL = '3' THEN '   ' || Y.DEPTNM END AS DEPTNM, \n");
					sql.append( "	X.TREECD, COALESCE(X.CNT,0) CNT, X.GUBUN, \n");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, \n");
					sql.append( "	X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, \n");
					sql.append( " X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ, X.GRDDIV \n");
					sql.append( " FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, ''DEPTCD, ''DEPTNM, \n");
					sql.append( "      SUBSTR(B.TREECD,1,6) TREECD , COUNT(A.EMPNO) CNT , MAX('3') AS GUBUN, \n");
					sql.append( "      '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, \n");
					sql.append( " '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, \n");
					sql.append( " '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ, '' AS GRDDIV \n");
					sql.append( "	FROM PAYROLL.T_HIPERSON A \n");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n");

					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') \n");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'	\n");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'		\n");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'	\n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'			\n");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'															\n");
					if (!str[7].equals("")) sql.append( " AND A.STRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'		\n");
					//if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'	\n");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'	\n");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'	\n");
					
					if (str[17].equals("A")) {
						sql.append( " AND A.EMPDIV IN ('3') \n");	//�ѱ��ΰ����
					}else{
						sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//�ѱ��ΰ����
					}

					if (!str[18].equals("")) sql.append( " AND A.GRDDIV = '" + str[18] + "' \n	\n");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.SEX = '"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[20]+"' \n");

					sql.append( " AND SUBSTR(B.TREECD,5,2)<>'00' \n");
					sql.append( " GROUP BY SUBSTR(B.TREECD,1,6)) X \n");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT y ON X.TREECD = SUBSTR(Y.TREECD,1,6) AND Y.LEVEL IN('3') \n");

					sql.append( "	UNION \n");

					sql.append( "	SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, \n");
					sql.append( " CASE WHEN Y.LEVEL = '3' THEN '   ' || Y.DEPTNM END AS DEPTNM, \n");
					sql.append( " X.TREECD,COALESCE(X.CNT,0) CNT, X.GUBUN, \n");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, \n");
					sql.append( " X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, \n");
					sql.append( " X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ, X.GRDDIV \n");
					sql.append( " FROM (SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, \n");
					sql.append( "	      SUBSTR(TREECD,1,6) TREECD , COUNT(A.EMPNO) CNT , MAX('31') AS GUBUN, \n");
					sql.append( "	    '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, \n");
					sql.append( "  '' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, \n");
					sql.append( "  '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ, '' AS GRDDIV \n");
					sql.append( "	FROM PAYROLL.T_HIPERSON A \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n");
					
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') \n");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'	\n");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'		\n");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'	\n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'			\n");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'						\n");
					if (!str[7].equals("")) sql.append( " AND A.STRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'		\n");
					//if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'	\n");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'	\n");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'	\n");
					
					if (str[17].equals("A")) {
						sql.append( " AND A.EMPDIV IN ('3') \n");	//�ѱ��ΰ����
					}else{
						sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//�ѱ��ΰ����
					}

					if (!str[18].equals("")) sql.append( " AND A.GRDDIV = '" + str[18] + "' \n");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.SEX = '"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[20]+"' \n");
					
					sql.append( " AND SUBSTR(B.TREECD,5,2)<>'00' AND SUBSTR(B.TREECD,7,2)='00' \n");
					sql.append( "	AND (SELECT COUNT(H.TREECD) FROM PAYROLL.HCDEPT H \n");
					sql.append( " WHERE SUBSTR(B.TREECD,1,6) = SUBSTR(H.TREECD,1,6) AND SUBSTR(H.TREECD,7,2)<>'00')>0 \n");
					sql.append( " GROUP BY SUBSTR(TREECD,1,6)) X \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT y ON X.TREECD = SUBSTR(Y.TREECD,1,6) AND Y.LEVEL IN('3') \n");

					sql.append( " UNION \n");

					sql.append( " SELECT X.EMPNO, X.EMPNMK, Y.DEPTCD, \n");
					sql.append( "	CASE WHEN Y.LEVEL = '4' THEN '     ' || Y.DEPTNM END AS DEPTNM, \n");
					sql.append( "	X.TREECD,COALESCE(X.CNT,0) CNT, X.GUBUN, \n");
					sql.append( " X.PAYGNM,X.PAYGRD,X.PAYSEQ,X.SEX,X.GRSTRTDT, \n");
					sql.append( " X.STRTDT,X.LAMDT,X.BIRDT,X.PERAGE,X.LSTEDU, \n");
					sql.append( "	X.PGCNM,X.PGCCD,X.ETC,X.SEQ,X.BANDOK,X.GRD_SEQ, X.GRDDIV \n");
					sql.append( " FROM(SELECT MAX('') EMPNO, MAX('') EMPNMK, '' DEPTCD, '' DEPTNM, \n");
					sql.append( "	     B.TREECD, COUNT(A.EMPNO) CNT , MAX('4') AS GUBUN, \n");
					sql.append( "	       '' AS PAYGNM, '' AS PAYGRD,'' AS PAYSEQ,'' AS SEX,'' AS GRSTRTDT, \n");
					sql.append( "	'' AS STRTDT,'' AS LAMDT,'' AS BIRDT,0 AS PERAGE,'' AS LSTEDU, \n");
					sql.append( " '' AS PGCNM,'' AS PGCCD,'' AS ETC, 0 AS SEQ, 'band' AS BANDOK, 0 AS GRD_SEQ, '' AS GRDDIV \n");
					sql.append( "	FROM PAYROLL.T_HIPERSON A \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n");

					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') \n");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'	\n");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'		\n");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'	\n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'			\n");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'															\n");
					if (!str[7].equals("")) sql.append( " AND A.STRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'		\n");
					//if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'	\n");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'	\n");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'	\n");
					
					if (str[17].equals("A")) {
						sql.append( " AND A.EMPDIV IN ('3') \n");	//�ѱ��ΰ����
					}else{
						sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//�ѱ��ΰ����
					}

					if (!str[18].equals("")) sql.append( " AND A.GRDDIV = '" + str[18] + "' \n");
					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.SEX = '"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[20]+"' \n");
					
					sql.append( " AND SUBSTR(B.TREECD,5,2)<>'00' AND SUBSTR(B.TREECD,7,2)<>'00' \n");
					sql.append( " GROUP BY TREECD) X \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT Y ON X.TREECD = Y.TREECD AND Y.LEVEL IN('4') \n");

					sql.append( "	UNION \n");

					sql.append( " SELECT RTRIM(A.EMPNO) EMPNO, RTRIM(A.EMPNMK) EMPNMK, RTRIM(A.DEPTCD) DEPTCD, \n");
					sql.append( "	CASE WHEN B.LEVEL = '1' THEN '   ' || B.DEPTNM \n");
					sql.append( "			 WHEN B.LEVEL = '2' THEN '   ' || B.DEPTNM \n");
					sql.append( "      WHEN B.LEVEL = '3' THEN '   ' || B.DEPTNM \n");
					sql.append( "	     WHEN B.LEVEL = '4' THEN '     ' || B.DEPTNM \n");
					sql.append( "	END AS DEPTNM, \n");
					sql.append( "	RTRIM(B.TREECD) TREECD,0 as CNT, '5' as GUBUN, ");
					sql.append( " RTRIM(C.MINORNM) AS PAYGNM, RTRIM(A.PAYGRD) AS PAYGRD, RTRIM(A.PAYSEQ) AS PAYSEQ, RTRIM(A.SEX) AS SEX, \n");
					sql.append( "	RTRIM(A.GRSTRTDT) AS GRSTRTDT,    RTRIM(A.STRTDT) AS STRTDT, RTRIM(A.LAMDT) AS LAMDT, \n");
					sql.append( " RTRIM(A.BIRDT)  AS BIRDT,    2005-CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE, \n");
					sql.append( " RTRIM(G.SCHNM) || '' || RTRIM(JJ.MINORNM) AS LSTEDU,  RTRIM(J.MINORNM) AS PGCNM,  \n");
					sql.append( " RTRIM(J.MINORCD) AS PGCCD, '' AS ETC, \n");
					sql.append( " 0 AS SEQ, 'default' AS BANDOK,C.SEQ AS GRD_SEQ,A.GRDDIV \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.T_HIEDUC G ON A.EMPNO = G.EMPNO \n");
					sql.append( "			AND G.GRAYY = (SELECT MAX(GRAYY) AS GRAYY \n");
					sql.append( "	    FROM PAYROLL.T_HIEDUC \n");
					sql.append( "			WHERE EMPNO = A.EMPNO) \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE J ON G.PGCCD  = J.MINORCD AND J.MAJORCD = '1129' \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE JJ ON G.EDCCD = JJ.MINORCD AND JJ.MAJORCD = '1115' \n");
			
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					sql.append( " AND B.DEPTCD NOT IN ('') AND B.TREECD NOT IN ('99999999') \n");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'	\n");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'		\n");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'	\n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'	\n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'			\n");

					if (!str[6].equals("")) sql.append( " AND D.LCSTYPE = '" + str[6] + "'						\n");
					if (!str[7].equals("")) sql.append( " AND A.STRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'		\n");
					//if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'	\n");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'	\n");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'	\n");
					
					if (str[17].equals("A")) {
						sql.append( " AND A.EMPDIV IN ('3') \n");	//�ѱ��ΰ����
					}else{
						sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//�ѱ��ΰ����
					}

					if (!str[18].equals("")) sql.append( " AND A.GRDDIV = '" + str[18] + "' \n");

					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.SEX = '"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[20]+"' \n");

					if (str[21].equals("1")) 	{
						sql.append( " ORDER BY GRDDIV, PAYSEQ DESC, EMPNMK ASC \n");
					}else {
						sql.append( " ORDER BY GRDDIV, PAYSEQ ASC, EMPNMK ASC \n");
					}

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
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(21)));
							row.addColumnValue(gauceUtil.UniToEuc(rs.getString(22)));
							
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
