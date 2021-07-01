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
public class a080003_s4 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//��û����ȣ

				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE",  "BGTRQNO",  "BGTRQMON","BGTAMT",  "BGTADAMT",
					"AMTFROMB","AMTGIVETO","AMTFROMA","AMTGVTOB","DVTFRAMT",
					"DVTTOAMT","TOTBGTAMT","RESULTAMT"
				}; 

				int[] intArrCN = new int[] { 
					2,  12,   2,  15,  15,  
				 15, 	15,  15,  15,  15,  
				 15, 	15,  15
				}; 
			
				int[] intArrCN2 = new int[]{ 
				  -1,  -1,	-1,   0,   0,   
					 0,   0,   0,   0,   0,   
					 0,   0,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT MAX(X.FDCODE) FDCODE,															\n");		
						sql.append( " MAX(X.BGTRQNO) BGTRQNO,MAX(X.BGTRQMON) BGTRQMON,					\n");
						sql.append( " MAX(X.BGTAMT) BGTAMT,       MAX(X.BGTADAMT) BGTADAMT,			\n");
						sql.append( " MAX(X.AMTFROMB) AMTFROMB,   MAX(X.AMTGIVETO) AMTGIVETO,		\n");
						sql.append( " MAX(X.AMTFROMA) AMTFROMA,   MAX(X.AMTGVTOB) AMTGVTOB,			\n");
						sql.append( " MAX(X.DVTFRAMT) DVTFRAMT,   MAX(X.DVTTOAMT) DVTTOAMT,			\n");
						sql.append( " MAX(X.TOTBGTAMT) TOTBGTAMT, MAX(X.RESULTAMT) RESULTAMT		\n");
						sql.append( " FROM (SELECT																							\n");
						sql.append( "       RTRIM(A.FDCODE) FDCODE,             /*��������*/		\n");
						sql.append( "       RTRIM(A.BGTRQNO) BGTRQNO,           /*��û����ȣ*/	\n");
						sql.append( "       RTRIM(A.BGTRQMON) BGTRQMON,         /*�����*/			\n");
						sql.append( "       nvl(D.INITBGT,0) BGTAMT,        /*������*/				\n");
						sql.append( "       CASE WHEN B.BGTRQDIV='01' THEN											\n");
						sql.append( "       MAX(B.BGTRQAMT) ELSE 0 END AS BGTADAMT,							\n");
						sql.append( "       nvl(A.AMTFROMB,0)  AMTFROMB,   /*�����̿�*/			\n");
						sql.append( "       nvl(A.AMTGIVETO,0) AMTGIVETO,  /*�����̿�*/			\n");
						sql.append( "       nvl(A.AMTFROMA,0)  AMTFROMA,   /*��������*/			\n");
						sql.append( "       nvl(A.AMTGVTOB,0)  AMTGVTOB,   /*����������*/		\n");
						sql.append( "       nvl(A.DVTFRAMT,0)  DVTFRAMT,   /*����*/					\n");
						sql.append( "       nvl(A.DVTTOAMT,0)  DVTTOAMT,   /*������*/				\n");
						sql.append( "       nvl(A.TOTBGTAMT,0) TOTBGTAMT,  /*�ѿ���*/				\n");
						sql.append( "       nvl(A.RESULTAMT,0) RESULTAMT   /*����*/					\n");
						sql.append( " FROM ACCOUNT.BGTRQDTL3  A,ACCOUNT.BGTRQMST C							\n");
						sql.append( " LEFT JOIN ACCOUNT.BGTRQDTL1 B ON A.FDCODE=B.FDCODE AND A.BGTRQNO=B.BGTRQNO			\n");

						
						sql.append( " LEFT JOIN ACCOUNT.BGTRQDTL1 B ON A.FDCODE=B.FDCODE AND A.BGTRQNO=B.BGTRQNO			\n");
						sql.append( " LEFT JOIN ACCOUNT.BGTDTL D ON C.FDCODE=D.FDCODE   AND C.BGTYY=D.BGTYY						\n");
						sql.append( "					AND C.BGTDIV=D.BGTDIV  AND C.BGTDPT=D.BGTDPT														\n");
						sql.append( "					AND C.ATCODE=D.ATCODE  AND C.FSREFCD=D.FSREFCD AND C.SATCODE=D.SATCODE	\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																			\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'				\n");	/*�����ڵ�*/
						if(!str[1].equals("")) sql.append( " AND A.BGTRQNO = '"+str[1]+"'				\n");	/*��û����ȣ*/
						sql.append( " GROUP BY A.FDCODE,A.BGTRQNO,A.BGTRQMON,D.INITBGT,B.BGTRQDIV,A.AMTFROMB,	\n");
						sql.append( " A.AMTGIVETO,A.AMTFROMA,A.AMTGVTOB,A.DVTFRAMT,A.DVTTOAMT,A.TOTBGTAMT,A.RESULTAMT	\n");
						sql.append( " ) X																												\n");

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