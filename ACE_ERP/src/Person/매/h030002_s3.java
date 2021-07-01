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

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h030002_s3 extends HttpServlet {

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
				
				String [] str = new String [22];
				str[0]	= req.getParameter("v_str1");		//��������
				str[1]	= req.getParameter("v_str2");		//�μ��ڵ�
				str[2]	= req.getParameter("v_str3");		//��������
				str[3]	= req.getParameter("v_str4");		//�����ڵ�
				str[4]	= req.getParameter("v_str5");		//LEVEL
				str[5]	= req.getParameter("v_str6");		//TREECD
				str[6]	= req.getParameter("v_str7");		//�ڰ����ڵ�
				str[7]	= req.getParameter("v_str8");		//�Ի����� fr
				str[8]	= req.getParameter("v_str9");		//�Ի����� to
				str[9]	= req.getParameter("v_str10");	//�������� fr
				str[10]	= req.getParameter("v_str11");	//�������� to
				str[11]  = req.getParameter("v_str12");	//������� fr
				str[12] = req.getParameter("v_str13");	//������� to
				str[13] = req.getParameter("v_str14");	//������� fr
				str[14] = req.getParameter("v_str15");	//������� to
				str[15] = req.getParameter("v_str16");	//�����
				str[16] = req.getParameter("v_str17");	//������
				str[17] = req.getParameter("v_str18");	//����������
				str[18] = req.getParameter("v_str19");	//�߷ɱ���
				str[19] = req.getParameter("v_str20");	//ȣ��
				str[20] = req.getParameter("v_str21");	//����
				str[21] = req.getParameter("v_str22");  //ORDER BY (ASC/DESC)

				for (int s=0;s<=21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNMK","NME","NMC","EMPNO","RESINO",
																					"BIRDT","GLDIVNM","SEXNM","DEPTNM","PAYGNM",
																					"PAYSNM","JOBNM","DPOFFDT","ORDDT","LAMDT",
																					"GRSTRTDT","STRTDT","ENDDT","EDIVNM","SCHNM",
																					"BLOOD","TELNO","EMPADD","PICFILE","RILIGNM"
																					,"TREECD","SEQ"//, "ORDCD","ORDNM"
																				};

				int[] intArrCN = new int[]  {  20,   40,   20,   7,   13,          
                                        8,    6,    6,  30,   30,          
                                       30,   30,    8,   8,    8,          
                                        8,    8,    8,  30,   60,
																			  2,   15,   70,  100,  30
																			 ,8,    3//,    2,  30

																	  }; 

				int[] intArrCN2 = new int[] { -1,   -1,  -1,  -1,  -1,
																	  	-1,   -1,  -1,  -1,  -1,
																		  -1,   -1,  -1,  -1,  -1,
																		  -1,   -1,  -1,  -1,  -1,
																			-1,   -1,  -1,  -1,  -1
																			,-1,   0//,  -1,  -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
			
					sql.append( " SELECT \n");
					sql.append( " RTRIM(A.EMPNMK) AS EMPNMK, \n");                          //--����
					sql.append( " RTRIM(A.NME) AS NME, \n");                                //--����
					sql.append( " RTRIM(A.NMC) AS NMC, \n");                                //--����
					sql.append( " RTRIM(A.EMPNO) AS EMPNO, \n");                            //--���
					sql.append( " RTRIM(A.RESINO) AS RESINO, \n");                          //--�ֹι�ȣ
					sql.append( " RTRIM(A.BIRDT) AS BIRDT, \n");                            //--�������
					sql.append( " CASE WHEN A.GLDIV ='1' THEN '���' \n");                  //--���
					sql.append( "      WHEN A.GLDIV ='2' THEN '����' END AS GLDIVNM, \n");  //--����
					sql.append( " CASE WHEN A.SEX = '1' THEN '��' \n");                     //--����:��
					sql.append( "      WHEN A.SEX = '2' THEN '��' END AS SEXNM, \n");       //--����:��
					sql.append( " RTRIM(B.DEPTNM) AS DEPTNM, \n");                          //--�μ�
					sql.append( " RTRIM(C.MINORNM) AS PAYGNM, \n");                         //--����
					sql.append( " RTRIM(F.MINORNM) AS PAYSNM, \n");                         //--��ȣ
					sql.append( " RTRIM(D.MINORNM) AS JOBNM, \n");                          //--����
					sql.append( " RTRIM(A.DPOFFDT) AS DPOFFDT, \n");                        //--�μ��߷���
					sql.append( " RTRIM(A.ORDDT) AS ORDDT, \n");														//--�����߷���
					sql.append( " RTRIM(A.LAMDT) AS LAMDT, \n");                            //--������
					sql.append( " RTRIM(A.GRSTRTDT) AS GRSTRTDT, \n");                      //--�׷��Ի���
					sql.append( " RTRIM(A.STRTDT) AS STRTDT, \n");                          //--�Ի���
					sql.append( " RTRIM(A.STRTDT) AS ENDDT, \n");                           //--�����
					sql.append( " RTRIM(I.MINORNM) AS EDIVNM, \n");                         //--�Ի籸��
					sql.append( " RTRIM(G.SCHNM) AS SCHNM, \n");                            //--��ű�
					sql.append( " RTRIM(H.BLOOD) AS BLOOD, \n");                            //--������
					sql.append( " RTRIM(A.TELNO) AS TELNO, \n");                            //--��ȭ��ȣ
					sql.append( " RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS EMPADD, \n");   //--�ּ�
					sql.append( " 'http://203.242.32.198/services/servlet/Person.h030001_s0?v_str1=' || A.EMPNO AS PICFILE, \n ");	//--����
					sql.append( " RTRIM(K.MINORNM) AS RILIGNM \n");													//--����
					sql.append( " , B.TREECD,C.SEQ ");																			//--������,SEQ
					//sql.append( " ,KK.ORDCD,M.ORDNM ");																			//--�߷ɱ���
					sql.append( " FROM PAYROLL.HIPERSON A \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON B.DEPTCD = A.DEPTCD ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE C ON C.MINORCD = A.PAYGRD  AND C.MAJORCD = '2002' \n");	//--����
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON D.MINORCD = A.JOBKIND AND D.MAJORCD = '2034' \n");	//--����
					sql.append( " LEFT OUTER JOIN PAYROLL.HILICENS DD ON A.EMPNO = DD.EMPNO									\n");	//--�ڰ���
//					sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON E.MINORCD = A.BIRCITY AND E.MAJORCD = '2011' \n");	//--��ŵ�
					sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON F.MINORCD = A.PAYSEQ  AND F.MAJORCD ='1184' \n");	//--��ȣ
					sql.append( " LEFT JOIN PAYROLL.HCLCODE I ON I.MINORCD = A.RECDIV  AND I.MAJORCD ='2035' \n");	//--�Ի籸��
//					sql.append( " LEFT JOIN PAYROLL.HCLCODE J ON J.MINORCD = A.JOBGRPH AND J.MAJORCD='2000' \n");	//--����
					sql.append( " LEFT JOIN PAYROLL.HCLCODE K ON K.MINORCD = A.RILIGN  AND K.MAJORCD='1117' \n");	//--����
					sql.append( " LEFT JOIN PAYROLL.HIEDUC G ON G.EMPNO = A.EMPNO \n");
					sql.append( "														 AND G.GRAYY = (SELECT MAX(Z.GRAYY) AS GRAYY \n");
					sql.append( "														 FROM PAYROLL.HIEDUC Z \n");
					sql.append( "														 WHERE Z.EMPNO = A.EMPNO) \n");
					sql.append( " LEFT JOIN PAYROLL.HIASSUR H ON H.EMPNO = A.EMPNO \n");	//--������
					//sql.append( " LEFT OUTER JOIN PAYROLL.HOORDER KK ON A.EMPNO = KK.EMPNO ");		//--�߷�
					//sql.append( " LEFT OUTER JOIN PAYROLL.HCORDCOD M ON KK.ORDCD = M.ORDCD ");		//--����

					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[5] + "'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[5] + "'");

					if (!str[6].equals("")) sql.append( " AND DD.LCSTYPE = '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[13].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[13] + "' AND '" + str[14] + "'");
					if (!str[17].equals("A")) sql.append( " AND A.EMPDIV = '2' ");
					//if (!str[18].equals("")) sql.append( " AND KK.ORDCD IN ('"+str[18]+"') ");

					if (!str[19].equals("")&&!str[19].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[19]+"' \n");
					if (!str[20].equals("")&&!str[20].equals("0")) sql.append( " AND A.SEX = '"+str[20]+"' \n");

					if (str[21].equals("1")) 	{
						sql.append( " ORDER BY PAYGRD, PAYSEQ DESC, EMPNMK ASC \n");
					}else {
						sql.append( " ORDER BY PAYGRD, PAYSEQ ASC, EMPNMK ASC \n");
					}
					
					//sql.append( " ORDER BY B.TREECD ASC, C.SEQ ASC ");

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
