package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h080004_s1 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
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
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [25];
				str[0]	= req.getParameter("v_str1");		//��������
				str[1]	= req.getParameter("v_str2");		//�μ��ڵ�
				str[2]	= req.getParameter("v_str3");		//��������
				str[3]	= req.getParameter("v_str4");		//�����ڵ�
				str[4]	= req.getParameter("v_str5");		//�Ի籸��
				str[5]	= req.getParameter("v_str6");		//�Ի����� fr
				str[6]	= req.getParameter("v_str7");		//�Ի����� to
				str[7]	= req.getParameter("v_str8");		//�������� fr
				str[8]	= req.getParameter("v_str9");		//�������� to
				str[9]  = req.getParameter("v_str10");	//������� fr
				str[10] = req.getParameter("v_str11");	//������� to
				str[11] = req.getParameter("v_str12");	//������� fr
				str[12] = req.getParameter("v_str13");	//������� to
				str[13] = req.getParameter("v_str14");	//�����
				str[14] = req.getParameter("v_str15");	//������
				str[15] = req.getParameter("v_str16");	//����������
				str[16] = req.getParameter("v_str17");	//LEVEL
				str[17] = req.getParameter("v_str18");  //TREECD
				str[18] = req.getParameter("v_str19");	//���ޱ���
				str[19] = req.getParameter("v_str20");	//����
				str[20] = req.getParameter("v_str21");	//ȣ��
				str[21] = req.getParameter("v_str22");	//ȣ�� ODER BY (ASC/DESC)

				for (int s=0;s<=21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV","EDCDNM", "EDCCNM",         
                                          "EMPDIV","FRDT","TODT","PAYDIV","RESINO",             
                                          "PICTURE","GRSTRTDT","STRTDT","DEPTCD","PAYGRD",
                                          "JOBGRPH","JOBDTY","GRDDIV","GRDDIVNM","PAYSEQ","FSAMDT",
                                          "ENDDT","USESTS","COSTDIV","DPOFFDT","LAMDT",
                                          "LRMDT","BIRDT","GLDIV","HOBBY","NMC",
                                          "RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
                                          "OADDR01","OADDR02","CZIPCD","CADDR01","CADDR02",
                                          "TELNO","HPNO","OFFTELNO","EMAIL","HDFAMNM",
                                          "HDFAMRET","HDFAMJOB","LABUNIYN","RELESAMT","MOVESAMT",
                                          "MRTDIV","MRTNO","REFCD","PAYBNKCD","PAYACNT",
                                          "HOUSDIV","MRYDT","ENGLVL","TOESCR","JPTSCR",
                                          "DELFSCR","TOFSCR","DALFSCR","TEPSSCR","ETCLNG",
                                          "HWGRDCD","EXGRDCD","PWGRDCD","ACGRDCD","DEPTNM",
																					"PAYGNM",/*"LCSTNM","GETDT","LCSNO","ISSPART",*/
																					"DEPTPNM","CADDR","LSTEDU","PERAGE","WRKDAT",
																					"ASSGB","AFRDT","ATODT","ASSNO","ASSINST",
																					"ASSAMT","RECPAMT","ASSNAME","GRAYY","DUYEAR"
																					,"TREECD","SEQ1","SEQ2"
																				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,30,30,          
                                       4,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       4,  4,  4, 30, 4,  8,           
                                       8,  4,  4,  8,  8,           
                                       8,  8,  1, 40, 20,         
                                       4, 40,  4, 40,  6,         
                                      70, 70,  6, 70, 70,       
                                      15, 15,  4, 30, 14,       
                                       4, 30,  1,  5,  5,      
                                       4, 20,  4,  4, 20,         
                                       4,  8,  1,  4,  4,       
                                       4,  4,  4,  4, 50, 
                                       1,  1,  1,  1, 70,
																			30,/* 30,  8, 20, 30,*/
																		  30,150, 60,  4,  4,
																			 1,  8,  8, 20, 50,
																			 9,  6, 20,  4,  2
																			,8,  3,  3

																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,-1,-1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		  0,  0,  0,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, /*-1, -1, -1, -1,*/
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																			0,  0, -1, -1,  0
																		,-1,  0,  0
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

						if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  DISTINCT  \n");
					sql.append( "				A.EMPNO,A.REGDIV,A.EMPNMK,'' AS CARRDIV,A.RECDIV, WW.MINORNM AS EDCDNM,WWW.MINORNM AS EDCCNM, \n");
					sql.append( "				A.EMPDIV,RTRIM(A.FRDT) AS FRDT,RTRIM(A.TODT) AS TODT,A.PAYDIV,A.RESINO, \n");
					sql.append( "				A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,A.PAYGRD, \n");
					sql.append( "				A.JOBGRPH,A.JOBDTY,A.GRDDIV,RTRIM(P.MINORNM) GRDDIVNM,RTRIM(A.PAYSEQ) PAYSEQ,RTRIM(A.FSAMDT) AS FSAMDT,	\n");
					sql.append( "				RTRIM(A.ENDDT) AS ENDDT,A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT, \n");
					sql.append( "				RTRIM(A.LRMDT) AS LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC, \n");
					sql.append( "				A.RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD, \n");
					sql.append( "				A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02, \n");
					sql.append( "				A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM, \n");
					sql.append( "				A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, \n");
					sql.append( "				A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT, \n");
					sql.append( "				A.HOUSDIV,RTRIM(A.MRYDT) AS MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR, \n");
					sql.append( "				A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG, \n");
					sql.append( "				A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,B.DEPTNM,	\n");
					sql.append( "				C.MINORNM AS PAYGNM, /*E.MINORNM AS LCSTNM,RTRIM(D.GETDT) AS GETDT,D.LCSNO,D.ISSPART,*/	\n");
					sql.append( "				F.MINORNM DEPTPNM, RTRIM(A.CADDR01) || ' ' || RTRIM(CADDR02) AS CADDR, \n");
					sql.append( "       G.SCHNM AS LSTEDU, CASE WHEN TRIM(A.GRSTRTDT)='' THEN A.STRTDT  \n");
					sql.append( "		WHEN TRIM(A.GRSTRTDT)<>'' THEN " + str[13] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) END WRKDAT, ");
					sql.append( "       " + str[13] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE, \n");
					sql.append( "				H.ASSGB, RTRIM(H.FRDT) AS AFRDT, RTRIM(H.TODT) AS ATODT, H.ASSNO, H.ASSINST, \n");
					sql.append( "				COALESCE(H.ASSAMT,0) AS ASSAMT,COALESCE(H.RECPAMT,0) AS RECPAMT, H.ASSNAME, \n");
					sql.append( "       G.GRAYY, COALESCE(I.DUYEAR,0) AS DUYEAR \n");
					sql.append( "       , B.TREECD, IFNULL(C.SEQ,0) AS SEQ1, IFNULL(K.SEQ,0) AS SEQ2 \n");
					sql.append( "			  FROM PAYROLL.T_HIPERSON A, PAYROLL.HCORDCOD M \n");
					sql.append( "       LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n");
					sql.append( "				LEFT OUTER JOIN PAYROLL.T_HIEDUC G ON A.EMPNO = G.EMPNO \n");
					sql.append( "                       AND G.GRAYY = (SELECT MAX(GRAYY) AS GRAYY FROM PAYROLL.T_HIEDUC WHERE EMPNO = A.EMPNO) \n");
					sql.append( "                       AND G.SEQ = (SELECT MAX(SEQ) AS SEQ FROM PAYROLL.T_HIEDUC WHERE EMPNO = A.EMPNO)  \n");
					sql.append( "       LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' \n");
					sql.append( "       LEFT OUTER JOIN PAYROLL.HCLCODE P ON A.GRDDIV = P.MINORCD AND P.MAJORCD = '2001' \n");
					sql.append( "       LEFT OUTER JOIN PAYROLL.T_HILICENS D ON A.EMPNO = D.EMPNO \n");
					sql.append( "       LEFT OUTER JOIN PAYROLL.HCLCODE E ON D.LCSTYPE = E.MINORCD AND E.MAJORCD = '1127' \n");
					sql.append( "				LEFT OUTER JOIN PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111' \n");
					sql.append( "       LEFT OUTER JOIN PAYROLL.HCLCODE K ON B.GROUPID = K.MINORCD AND K.MAJORCD = '2051' ");
					sql.append( "				LEFT OUTER JOIN PAYROLL.T_HIASSUR H ON A.EMPNO = H.EMPNO \n");
					sql.append( "       LEFT OUTER JOIN PAYROLL.HCLCODE WW ON G.EDCDIV  = WW.MINORCD AND WW.MAJORCD = '1118' ");
					sql.append( "       LEFT OUTER JOIN PAYROLL.HCLCODE WWW ON G.EDCCD  = WWW.MINORCD AND WWW.MAJORCD = '1115' ");

					sql.append( "				LEFT OUTER JOIN PAYROLL.PBPAY I ON A.EMPNO = I.EMPNO AND I.APPDT = '" + str[14] + "' \n");
					
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
				//	}else if (str[0].equals("0")) {
				//		sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1','2','3') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "' \n");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'  \n");
					//if (!str[4].equals("")) sql.append( " AND D.LCSTYPE = '" + str[4] + "' \n");

					if (!str[4].equals("")){
						 sql.append( " AND A.EMPDIV = '" + str[4] + "' \n");
					}else{
						 sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//
          }

					if (!str[5].equals(""))		sql.append( " AND A.STRTDT BETWEEN '" + str[5] + "' AND '" + str[6] + "' \n");
					//if (!str[7].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'  \n");
					if (!str[9].equals(""))		sql.append( " AND A.ENDDT BETWEEN '" + str[9] + "' AND '" + str[10] + "' \n");
					if (!str[11].equals(""))	sql.append( " AND A.BIRDT BETWEEN '" + str[11] + "' AND '" + str[12] + "' \n");
					
					/* ȭ����ȸ �ڷ� ���ý�
					if (str[15].equals("A")) {
						sql.append( " AND A.EMPDIV IN ('3') \n");	//�ѱ��ΰ����
					}else{
						sql.append( " AND A.EMPDIV IN ('3','4','5','6') \n");	//�ѱ��ΰ����,�İ߰����,���ߵ���,�İ�
					}
					*/
 /*
				    if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[5] +"'  \n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[5] +"'  \n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] + "' \n");
					if (str[4].equals("4")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[5] +"'  \n");
					if (str[4].equals("5")) sql.append( " AND RTRIM(B.TREECD)= '" + str[5] + "'      \n");  
*/

  
				    if (str[16].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[17] +"'  \n");
					if (str[16].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[17] +"'  \n");
					if (str[16].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[17] + "' \n");
					if (str[16].equals("4")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[17] +"'  \n");
					if (str[16].equals("5")) sql.append( " AND RTRIM(B.TREECD)= '" + str[17] + "'      \n");  
 

					if (!str[18].equals("")) sql.append( " AND A.GRDDIV = '" + str[18] + "' \n");

					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.SEX = '"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[20]+"' \n");

					if (str[21].equals("1")) 	{
						sql.append( " ORDER BY GRDDIV, PAYSEQ DESC, EMPNMK ASC \n");
					}else {
						sql.append( " ORDER BY GRDDIV, PAYSEQ ASC, EMPNMK ASC \n");
					}

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