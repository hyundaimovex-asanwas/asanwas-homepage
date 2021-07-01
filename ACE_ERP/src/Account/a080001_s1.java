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
public class a080001_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//����⵵
				str[2] = req.getParameter("v_str3");	//����μ�
				str[3] = req.getParameter("v_str4");	//�����׸�
				str[4] = req.getParameter("v_str5");	//�������
				str[5] = req.getParameter("v_str6");	//������  
				str[6] = req.getParameter("v_str7");	//���⵵  
				str[7] = req.getParameter("v_str8");	//����з�

				for(int i=0;i<=7;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","BGTYY","BGTMM","BGTDIV","BGTDPT",
					"ATCODE","FSREFCD","SATCODE","BGTTYPE","BGTMACT",
					"INITMAN","INITBGT","CHGMAN","CHGBGT","BASICBGT",
					"ADDBGT","CHGABGT","CHGTBGT","REALBGT","RESULTS",
					"BRESULTS","APPROVAL","CHGAPPROV","REMARK","BCHGMAN2",
					"BINITBGT2","BRESULTS2","SATNM","ATKORNAM"
				}; 

				int[] intArrCN = new int[] { 
					 2,   4,   2,   4,   4,   
					 7,		4,   2,   1,   2,   
					 4,	 15,   4,	 15,  15,
					15,  15,  15,  15,  15,
					15,		1,	 1,  40,  15,
					15,  15,  40,  66
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					 0,   0,	 0,   0,   0,
					 0,	  0,	 0,   0,   0,   
					 0,	 -1,	-1,  -1,   0,
					 0,   0,  -1,  -1  
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT															\n");	
						sql.append( " RTRIM(A.FDCODE)  FDCODE,          /*�����ڵ�*/						\n");
						sql.append( " RTRIM(A.BGTYY)   BGTYY,           /*����⵵*/						\n");
						sql.append( " RTRIM(A.BGTMM)   BGTMM,           /*�����*/						\n");
						sql.append( " RTRIM(A.BGTDIV)  BGTDIV,          /*���꺻��*/						\n");
						sql.append( " RTRIM(A.BGTDPT)  BGTDPT,          /*����μ�*/						\n");
						sql.append( " RTRIM(A.ATCODE)  ATCODE,          /*�����ڵ�*/						\n");
						sql.append( " RTRIM(A.FSREFCD) FSREFCD,         /*�����׸��ڵ�*/				    \n");
						sql.append( " RTRIM(A.SATCODE) SATCODE,         /*����*/							\n");
						sql.append( " RTRIM(A.BGTTYPE) BGTTYPE,         /*����Ÿ��*/						\n");
						sql.append( " RTRIM(A.BGTMACT) BGTMACT,         /*����Ÿ��*/						\n");
						sql.append( " COALESCE(A.INITMAN,0) INITMAN,    /*�����ο�*/						\n");
						sql.append( " COALESCE(A.INITBGT,0) INITBGT,    /*���ʿ���*/						\n");
						sql.append( " COALESCE(A.CHGMAN,0)  CHGMAN,			/*�����ο�*/			\n");
						sql.append( " COALESCE(A.CHGBGT,0)  CHGBGT,			/*��������*/			\n");
						sql.append( " COALESCE(A.BASICBGT,0) BASICBGT,  /*�⺻����*/				\n");
						sql.append( " COALESCE(A.ADDBGT,0)  ADDBGT,			/*�߰�����*/			\n");
						sql.append( " COALESCE(A.CHGABGT,0) CHGABGT,    /*�׸�����*/				\n");
						sql.append( " COALESCE(A.CHGTBGT,0) CHGTBGT,    /*�Ⱓ����*/				\n");
						sql.append( " COALESCE(A.REALBGT,0) REALBGT,    /*���࿹��*/				\n");
						sql.append( " COALESCE(A.RESULTS,0) RESULTS,    /*����*/   				\n");
						sql.append( " COALESCE(A.BRESULTS,0) BRESULTS,  /*����������*/   			\n");
						sql.append( " RTRIM(A.APPROVAL) APPROVAL,				/*���α���*/   	\n");
						sql.append( " RTRIM(A.CHGAPPROV) CHGAPPROV,			/*�����������*/ 	    \n");
						sql.append( " RTRIM(A.REMARK) REMARK,						/*����ٰ�*/  \n");
						sql.append( " COALESCE(X.BCHGMAN,0)  BCHGMAN2,	/*�����ο�*/				\n");
						sql.append( " COALESCE(X.BINITBGT,0) BINITBGT2,	/*���⿹��*/				\n");
						sql.append( " COALESCE(X.BRESULTS,0) BRESULTS2,	/*�������*/				\n");
						sql.append( " RTRIM(S.CDNAM) SATNM,							/*�����*/	\n");
						sql.append( " RTRIM(F.ATKORNAM) ATKORNAM				/*���������*/		\n");
						sql.append( " FROM ACCOUNT.BGTDTL A, ACCOUNT.ACTCODE F, /*�������DTL*/											   \n");
						sql.append( "      ACCOUNT.COMMDTIL S,  /*����*/                                                                    \n");
						sql.append( " 	   ACCOUNT.BGTMST C,    /*�������MST*/                                                              \n");
						sql.append( "      ( SELECT E.FDCODE,E.BGTYY,E.BGTMM,E.BGTDIV,                                   	               \n");
						sql.append( "               E.BGTDPT,E.ATCODE,E.FSREFCD,E.SATCODE,                            		               \n");
						sql.append( "               CASE WHEN E.CHGMAN=0 THEN E.INITMAN ELSE E.CHGMAN END AS BCHGMAN, /*�����ο�*/    	   \n");
						sql.append( "               COALESCE(E.INITBGT,0) BINITBGT,/*���⿹��*/                       		               \n");
						sql.append( "               COALESCE(E.RESULTS,0) BRESULTS /*�������*/                       		               \n");
						sql.append( "          FROM ACCOUNT.BGTDTL E                                                    	               \n");
						sql.append( "          LEFT JOIN ACCOUNT.BGTMST K ON E.FDCODE=K.FDCODE AND E.BGTYY=K.BGTYY  		               \n");
						sql.append( "                                    AND E.BGTDIV=K.BGTDIV AND E.BGTDPT=K.BGTDPT AND E.ATCODE=K.ATCODE \n");
						sql.append( "                                    AND E.FSREFCD=K.FSREFCD AND E.SATCODE=K.SATCODE                   \n");
						sql.append( "         WHERE E.FDCODE IS NOT NULL							\n");
						if(!str[0].equals("")) sql.append( " AND E.FDCODE  = '"+str[0]+"'	\n");	//�����ڵ�
						if(!str[6].equals("")) sql.append( " AND E.BGTYY   = '"+str[6]+"'	\n");	//���⵵
						if(!str[2].equals("")) sql.append( " AND E.BGTDPT  = '"+str[2]+"'	\n");	//����μ�
						if(!str[3].equals("")) sql.append( " AND E.FSREFCD = '"+str[3]+"'	\n");	//�����׸�
						if(!str[4].equals("")) sql.append( " AND E.ATCODE  = '"+str[4]+"'	\n");	//�������
						if(!str[5].equals("")) sql.append( " AND E.SATCODE = '"+str[5]+"'	\n");	//������
						sql.append( "    	)X \n");
						
						sql.append( " WHERE A.FDCODE IS NOT NULL AND A.ATCODE = F.ATCODE				\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'	\n");	//�����ڵ�
						if(!str[1].equals("")) sql.append( " AND A.BGTYY   = '"+str[1]+"' \n");	//����⵵
						if(!str[2].equals("")) sql.append( " AND A.BGTDPT  = '"+str[2]+"'	\n");	//����μ�
						if(!str[3].equals("")) sql.append( " AND A.FSREFCD = '"+str[3]+"'	\n");	//�����׸�
						if(!str[4].equals("")) sql.append( " AND A.ATCODE  = '"+str[4]+"'	\n");	//�������
						if(!str[5].equals("")) sql.append( " AND A.SATCODE = '"+str[5]+"'	\n");	//������
						sql.append( "  AND A.SATCODE=S.CDCODE(+) AND A.FSREFCD=S.CMTYPE(+)   	\n");
						sql.append( "  AND A.FDCODE=C.FDCODE(+)  AND A.BGTYY=C.BGTYY(+)   AND A.BGTDIV=C.BGTDIV(+)   \n");
						sql.append( "  AND A.BGTDPT=C.BGTDPT(+)	 AND A.ATCODE=C.ATCODE(+) AND A.FSREFCD=C.FSREFCD(+) AND A.SATCODE=C.SATCODE(+)			\n");
						sql.append( "  AND A.BGTMM=X.BGTMM(+)	\n");
						sql.append( " ORDER BY BGTYY,BGTMM	\n");

						//System.out.println("a080001_s1 : \n" + sql.toString());		
						//logger.dbg.println(this,sql.toString() );
		
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