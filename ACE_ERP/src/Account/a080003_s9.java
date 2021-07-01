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
public class a080003_s9 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//���α��� 
				str[2] = req.getParameter("v_str3");	//����⵵
				str[3] = req.getParameter("v_str4");	//�����fr  
				str[4] = req.getParameter("v_str5");	//�����fr
				str[5] = req.getParameter("v_str6");	//��û���� 
				str[6] = req.getParameter("v_str7");	//��û�μ�

				for(int i=0;i<=6;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK","BGTRQNO","FDCODE","BGTYY","BGTMM",
					"BGTDIV","BGTDPT","ATCODE","FSREFCD","SATCODE",
					"BGTRQST","ATKORNAM","SATNAM","DEPTNM",//"BGTRQSEQ",
					"BASICBGT","BGTRQAMT","CHGAMT","BRESULTS","RESULTS",
					"JANAMT"
				}; 

				int[] intArrCN = new int[] { 
				   1,  12,   2,   4,   2,
				   4,   4,   7,   4,   2,
				   1,  66,  40,  40,  // 2,
           15, 15,  15,  15,  15,
					15
				}; 
			
				int[] intArrCN2 = new int[]{ 
				  -1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  //-1,
					 0,   0,   0,   0,   0,
					 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT																																			 \n");
						sql.append( "   'F' AS CHK,                       /*����*/																 \n");
						sql.append( "   B.BGTRQNO,                        /*��û����ȣ*/													 \n");
						sql.append( "   A.FDCODE,                         /*����*/																 \n");
						sql.append( "   A.BGTYY,                          /*����⵵*/														 \n");
						sql.append( "   A.BGTMM AS BGTMM,                 /*�����*/															 \n");
						sql.append( "   A.BGTDIV,                         /*��û����*/														 \n");
						sql.append( "   A.BGTDPT,                         /*��û�μ�*/														 \n");
						sql.append( "   RTRIM(A.ATCODE)   ATCODE,         /*�����ڵ�*/														 \n");
						sql.append( "   RTRIM(A.FSREFCD)  FSREFCD,        /*�����׸�*/														 \n");
						sql.append( "   RTRIM(A.SATCODE)  SATCODE,        /*����*/																 \n");
						sql.append( "   RTRIM(B.BGTRQST)  BGTRQST,        /*���α���*/														 \n");
						sql.append( "   RTRIM(F.ATKORNAM) ATKORNAM,       /*���������*/													 \n");
						sql.append( "   RTRIM(E.CDNAM)    SATNAM,         /*�����*/															 \n");
						sql.append( "   RTRIM(G.CDNAM)    DEPTNM,         /*�μ���*/															 \n");
						sql.append( "   COALESCE(A.BASICBGT,0)   BASICBGT,						/*������*/									 \n");
						sql.append( "   COALESCE(K.BGTRQAMT,0)   BGTRQAMT,			       /*��û��*/									 \n");
						sql.append( "   COALESCE(A.BASICBGT-SUM(COALESCE(K.BGTRQAMT,0)),0) CHGAMT,/*������*/			 \n");
						sql.append( "   COALESCE(A.BRESULTS,0)   BRESULTS,						/*�������ܾ�*/						 \n");
						sql.append( "   COALESCE(A.RESULTS,0)    RESULTS,							/*����*/										 \n");
						sql.append( "   COALESCE(A.BRESULTS-A.RESULTS,0) JANAMT				/*�ܾ�*/										 \n");
						sql.append( " FROM ACCOUNT.BGTDTL A, ACCOUNT.ACTCODE F /*��ûDTL1*/												 \n");
						sql.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE   AND A.BGTYY=B.BGTYY      \n");
						sql.append( "       AND A.BGTDIV=B.BGTDIV  AND A.BGTDPT=B.BGTDPT													 \n");
						sql.append( "       AND A.ATCODE=B.ATCODE  AND A.FSREFCD=B.FSREFCD AND A.SATCODE=B.SATCODE \n");
						sql.append( " LEFT JOIN ACCOUNT.BGTRQDTL1 C ON B.FDCODE=C.FDCODE   AND B.BGTRQNO=C.BGTRQNO \n");
						sql.append( " LEFT JOIN (SELECT K.BGTTOMON,SUM(K.BGTRQAMT) BGTRQAMT,K.FDCODE,K.BGTRQNO     \n");
						sql.append( "						 FROM ACCOUNT.BGTRQDTL1 K																					 \n");
						sql.append( " GROUP BY K.BGTTOMON,K.FDCODE,K.BGTRQNO)																	     \n");
						sql.append( " K ON B.FDCODE=K.FDCODE AND B.BGTRQNO=K.BGTRQNO AND A.BGTMM=K.BGTTOMON				 \n");//��û��
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL  E ON A.SATCODE=E.CDCODE  AND E.CMTYPE='1022'     \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL  G ON A.BGTDPT=G.CDCODE   AND G.CMTYPE='0003'     \n");
						sql.append( " WHERE A.FDCODE IS NOT NULL  AND A.ATCODE=F.ATCODE                                  \n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE   = '"+str[0]+"'												 \n");	//�����ڵ�     
						if(!str[1].equals("")) sql.append( " AND B.BGTRQST  = '"+str[1]+"'												 \n");	//���α���     
						if(!str[2].equals("")) sql.append( " AND A.BGTYY    = '"+str[2]+"'												 \n");	//����⵵
						if(!str[3].equals("")) sql.append( " AND A.BGTMM BETWEEN '"+str[3]+"'	AND '"+str[4]+"'		 \n");	//�����fr~to
						if(!str[5].equals("")) sql.append( " AND C.BGTRQDIV = '"+str[5]+"'												 \n");	//��û���� 
						if(!str[6].equals("")) sql.append( " AND A.BGTDPT   = '"+str[6]+"'												 \n");	//��û�μ�     
						sql.append( " GROUP BY B.BGTRQNO,A.FDCODE,A.BGTYY,A.BGTMM,A.BGTDIV,A.BGTDPT,							 \n");
						sql.append( "          A.ATCODE,A.FSREFCD,A.SATCODE,B.BGTRQST,F.ATKORNAM,E.CDNAM,G.CDNAM	 \n");
						sql.append( "          ,A.BASICBGT,K.BGTRQAMT,A.BRESULTS,A.RESULTS												 \n");
						sql.append( " ORDER BY BGTMM,ATKORNAM,SATNAM,BGTRQNO																			 \n");

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