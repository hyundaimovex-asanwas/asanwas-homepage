package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a080004_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//�����ڵ�     
				str[1] = req.getParameter("v_str2");	//���籸��     
				str[2] = req.getParameter("v_str3");	//�ۼ����� from
				str[3] = req.getParameter("v_str4");	//�ۼ����� to  
				str[4] = req.getParameter("v_str5");	//�����û���� 
				str[5] = req.getParameter("v_str6");	//�����       
				str[6] = req.getParameter("v_str7");	//���μ�     
				str[7] = req.getParameter("v_str8");	//����μ�     

				for(int i=0;i<=7;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK",      "FDCODE",		"BGTDPT",		"BGTRQST", "BGTRQNO", 
					"BGTRQAMT", "BGTRQNOTE","BGTRQSEQ", "BGTDIV",  "DEPTCD",  
					"EMPNO",   	"WRDT",			"ATCODE",		"FSREFCD", "SATCODE", 
					"ATKORNAM", "DEPTNM",	  "CDNAM"
				}; 

				int[] intArrCN = new int[] { 
					 1,   2,   4,   1,  12,  
					15,  30,	 2,   4,   4,   
					 7,   8,	 7,   4,	 2,  
					66,	 50,  40
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,   
					 0,  -1,  -1,  -1,  -1,  
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT                                                                      								\n");
						sql.append( "  'F' AS CHK,														/*����*/                            \n");
						sql.append( "  RTRIM(A.FDCODE)    FDCODE,							/*�����ڵ�*/                        \n");
						sql.append( "  RTRIM(A.BGTDPT)    BGTDPT,							/*����μ�*/                        \n");
						sql.append( "  RTRIM(A.BGTRQST)   BGTRQST,						/*���籸��*/                        \n");
						sql.append( "  RTRIM(A.BGTRQNO)   BGTRQNO,						/*��û����ȣ*/                      \n");
						sql.append( "  SUM(COALESCE(B.BGTRQAMT,0)) BGTRQAMT,	/*�����û�ݾ�*/                    \n");
						sql.append( "  RTRIM(A.BGTRQNOTE) BGTRQNOTE,					/*����*/                            \n");
						if(!str[4].equals("")) sql.append( " RTRIM(B.BGTRQSEQ) BGTRQSEQ,   /*�����û����*/				\n");
						else sql.append( " '' AS  BGTRQSEQ,  																											\n");
						sql.append( "  RTRIM(A.BGTDIV)    BGTDIV,        		/*���꺻��*/                             	\n");
						sql.append( "  RTRIM(A.DEPTCD)    DEPTCD,        	/*���μ�*/                             	\n");
						sql.append( "  RTRIM(A.EMPNO)     EMPNO,         	/*�����*/                               	\n");
						sql.append( "  RTRIM(A.WRDT)      WRDT,          		/*�ۼ�����*/                             	\n");
						sql.append( "  RTRIM(A.ATCODE)    ATCODE,        	/*��������*/                             	\n");
						sql.append( "  RTRIM(A.FSREFCD)   FSREFCD,       	/*�����׸��ڵ�*/                         \n");
						sql.append( "  RTRIM(A.SATCODE)   SATCODE,       /*����*/                                 		\n");
						sql.append( "  RTRIM(F.ATKORNAM)  ATKORNAM,      /*���������*/                           \n");
						sql.append( "  RTRIM(C.DEPTNM)    DEPTNM,        	/*���μ���*/                           	\n");
						sql.append( "  RTRIM(D.EMPNMK)    EMPNMK,        	/*����ڸ�*/                             	\n");
						sql.append( "  RTRIM(E.CDNAM)     CDNAM          	/*�������*/                             	\n");
						sql.append( "  FROM ACCOUNT.BGTRQMST A 			                    							\n");
						sql.append( "  LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE = F.ATCODE 				\n");
						sql.append( "  LEFT JOIN ACCOUNT.BGTRQDTL1 B ON A.FDCODE=B.FDCODE AND A.BGTRQNO=B.BGTRQNO \n");
						sql.append( "  LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD  = C.DEPTCD                         \n");
						sql.append( "  LEFT JOIN PAYROLL.HIPERSON D ON A.EMPNO = D.EMPNO                          \n");
						sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL E ON A.SATCODE = E.CDCODE AND E.CMTYPE='1022'   \n");
						sql.append( "  WHERE A.FDCODE IS NOT NULL                                									\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE     = '"+str[0]+"'											\n");	//�����ڵ�     
						if(!str[1].equals("")) sql.append( " AND A.BGTRQST    = '"+str[1]+"'											\n");	//���籸��     
						if(!str[2].equals("")) sql.append( " AND A.WRDT BETWEEN '"+str[2]+"' AND '"+str[3]+"'				\n");	//�ۼ�����
						if(!str[4].equals("")) sql.append( " AND B.BGTRQDIV   = '"+str[4]+"'											\n");	//��û���� 
						if(!str[5].equals("")) sql.append( " AND D.EMPNMK LIKE  '"+str[5]+"%'										\n");	//����ڸ�      
						if(!str[6].equals("")) sql.append( " AND C.DEPTNM LIKE  '"+str[6]+"%'										\n");	//���μ�     
						if(!str[7].equals("")) sql.append( " AND A.BGTDPT     = '"+str[7]+"'											\n");	//����μ�     
						sql.append( " GROUP BY A.FDCODE,A.BGTDPT,A.BGTRQST,A.BGTRQNO,A.BGTRQNOTE,A.BGTDIV,A.DEPTCD,A.EMPNO,	\n");
						sql.append( "          A.WRDT,  A.ATCODE,A.FSREFCD,A.SATCODE,F.ATKORNAM, C.DEPTNM,D.EMPNMK,E.CDNAM	\n");
						if(!str[4].equals("")) sql.append( "  ,B.BGTRQSEQ																										\n");
						sql.append( " ORDER BY FDCODE,BGTRQNO																																\n");

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