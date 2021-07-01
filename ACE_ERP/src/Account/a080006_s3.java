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
public class a080006_s3 extends HttpServlet {
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
				str[2] = req.getParameter("v_str3");	//�����fr
				str[3] = req.getParameter("v_str4");	//�����to
				str[4] = req.getParameter("v_str5");	//���꺻��
				str[5] = req.getParameter("v_str6");	//����μ�
				str[6] = req.getParameter("v_str7");	//������  
				str[7] = req.getParameter("v_str8");	//�����ڵ�
				str[8] = req.getParameter("v_str9");	//������  

				for(int i=0;i<=8;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE", "BGTYY","BGTMM","BGTDIV","BGTDPT",
					"DEPTNM", "ATCODE","ATKORNAM","SATCODE","SATNM", 
					//"INITBGT", "ADDBGT","AMTFROMB","AMTGIVETO","AMTFROMA", 
					//"AMTGVTOB", "DVTFRAMT","DVTTOAMT","SRESULT","RESULTS", 
					"INITBGT","BASICBGT","ADDBGT","CHGABGT","CHGTBGT","DEPTBGT","REALBGT","RESULTS",
					"BRESULTS","TOTRES"
					//"JANAMT"
				}; 

				int[] intArrCN = new int[] { 
					 2,   4,    2,   4,   4,
					30,   7,   66,	 2,  40,  
					//15,  15,   15,  15,  15,
					//15,  15,   15,  15,  15,
					15,  15,   15,  15,  15,  15,  15,  15,
					15,  20 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					 0,	  0,   0,	  0,   0,	  0,   0,   0,
					 0,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																																			\n");	
						sql.append( " RTRIM(A.FDCODE)		FDCODE,										/*��������*/										\n");
						sql.append( " RTRIM(A.BGTYY)		BGTYY,										/*����⵵*/										\n");
						sql.append( " RTRIM(A.BGTMM)		BGTMM,										/*�����*/											\n");
						sql.append( " RTRIM(A.BGTDIV)		BGTDIV,										/*���꺻��*/										\n");
						sql.append( " RTRIM(A.BGTDPT)		BGTDPT,										/*����μ�*/										\n");
						sql.append( " RTRIM(C.CDNAM)		DEPTNM,										/*�μ���*/											\n");
						sql.append( " RTRIM(A.ATCODE)   ATCODE,										/*�����ڵ�*/										\n");
						sql.append( " RTRIM(F.ATKORNAM) ATKORNAM,									/*������*/											\n");
						sql.append( " RTRIM(A.SATCODE)  SATCODE,									/*�����ڵ�*/										\n");
						sql.append( " RTRIM(E.CDNAM)    SATNM,										/*�����*/											\n");
						sql.append( " nvl(SUM(A.INITBGT),0)    INITBGT,				/*���ʿ���-������*/								\n");
						sql.append( " nvl(SUM(A.BASICBGT),0)   BASICBGT,				/*������*/										\n");
						sql.append( " nvl(SUM(A.ADDBGT),0)			ADDBGT,					/*�߰�����*/							\n");
						sql.append( " nvl(SUM(A.CHGABGT),0)    CHGABGT,				/*�׸�����*/									\n");
						sql.append( " nvl(SUM(A.CHGTBGT),0)		CHGTBGT,				/*�Ⱓ����*/								\n");
						sql.append( " nvl(SUM(A.DEPTBGT),0)		DEPTBGT,				/*�μ�����*/								\n");
						sql.append( " nvl(SUM(A.REALBGT),0)		REALBGT,				/*���࿹��*/								\n");
						sql.append( " nvl(SUM(A.RESULTS),0)		RESULTS,				/*����*/										\n");
						sql.append( " nvl(SUM(A.RESULTS),0)		BRESULTS,				/*����������*/							\n");
						sql.append( " nvl(SUM(A.RESULTS) +SUM(A.BRESULTS),0)  TOTRES				/*���������� + ����*/	\n");
						sql.append( " FROM ACCOUNT.BGTDTL A																					\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE = F.ATCODE 										\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.BGTDPT = C.CDCODE AND C.CMTYPE IN('0003') \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON A.SATCODE=E.CDCODE AND A.FSREFCD=E.CMTYPE		\n");
						sql.append( " LEFT JOIN ACCOUNT.BGTMST G ON A.FDCODE=G.FDCODE AND A.BGTYY=G.BGTYY AND A.BGTDIV=G.BGTDIV				\n");
						sql.append( "			 AND A.BGTDPT=G.BGTDPT AND A.ATCODE=G.ATCODE AND A.FSREFCD=G.FSREFCD AND A.SATCODE=G.SATCODE	\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																			\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'													\n");	//�����ڵ� 
						if(!str[1].equals("")) sql.append( " AND A.BGTYY   = '"+str[1]+"'													\n");	//����⵵ 
						if(!str[2].equals("")) sql.append( " AND A.BGTMM BETWEEN '"+str[2]+"' AND '"+str[3]+"'					\n");	//�����   
						if(!str[4].equals("")) sql.append( " AND A.BGTDIV  = '"+str[4]+"'													\n");	//���꺻�� 
						if(!str[5].equals("")) sql.append( " AND A.BGTDPT  = '"+str[5]+"'													\n");	//����μ� 
						if(!str[6].equals("")) sql.append( " AND F.ATKORNAM LIKE '"+str[6]+"%'											\n");	//������   
						if(!str[7].equals("")) sql.append( " AND A.ATCODE  = '"+str[7]+"'													\n");	//�����ڵ� 
						if(!str[8].equals("")) sql.append( " AND A.SATCODE = '"+str[8]+"'													\n");	//������   
						sql.append( " GROUP BY A.FDCODE,A.BGTYY,A.BGTMM,A.BGTDIV,A.BGTDPT,C.CDNAM,								\n");	
						sql.append( "          A.ATCODE,F.ATKORNAM,A.SATCODE,E.CDNAM															\n");	
						sql.append( " ORDER BY FDCODE,DEPTNM,BGTMM																								\n");
         
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