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
public class a080003_s7 extends HttpServlet {
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
					"DIVNAME", "BGTTOMON", "FGNAM",  "SATNAM", "KBUNAM", 
					"REALBGT", "USEAMT","JANAMT", "BGTFRMON", "TGNAM","TATNAM",
					"SATNAM", "BUSNAM","BGTRQAMT",  "LASAMT", "FDCODE",
					"BGTYY" , "BGTDIV",   "BGTDPT","FSREFCD"
				}; 

				int[] intArrCN = new int[] { 
				  60,  2,  66, 66, 66,
				  15,  15, 15, 2,  66,  66,
				  66,  66, 15, 15, 2,
					4,   2,  4,  4
				}; 
			
				int[] intArrCN2 = new int[]{ 
				  -1,  -1,  -1,  -1,  -1,
				   0,   0,   0,  -1,  -1, -1,
				  -1,  -1,   0,	  0,  -1,
					-1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																	              \n");
						sql.append( "	RTRIM(J.CDNAM)     DIVNAME,         /*��û����*/      \n");
						sql.append( "	X.BGTTOMON        BGTTOMON,        /*����-��*/        \n");
						sql.append( " RTRIM(R.ATKORNAM)  FGNAM,          /*����-��������*/  \n");
						sql.append( " RTRIM(T.CDNAM)     SATNAM,         /*����-����*/      \n");
						sql.append( " RTRIM(P.CDNAM)     KBUNAM,         /*����-�μ�*/      \n");
						sql.append( " C.REALBGT          REALBGT,         /*����-������*/    \n");
						sql.append( " C.RESULTS + BRESULTS AS USEAMT,     /*����-����*/   \n");
						sql.append( "	C.REALBGT - C.RESULTS- C.BRESULTS AS JANAMT, /*����-�ܾ�*/ \n");
						sql.append( " X.BGTFRMON         BGTFRMON,         /*����-��*/        \n");
						sql.append( " RTRIM(S.ATKORNAM)  TGNAM,          /*����-��������*/  \n");
						sql.append( " RTRIM(Y.CDNAM)     TATNAM,         /*����-����*/      \n");
						sql.append( " RTRIM(Z.CDNAM)     BUSNAM,         /*����-�μ�*/      \n");
						sql.append( " X.BGTRQAMT         BGTRQAMT,       /*��û��*/         \n");
						sql.append( " C.REALBGT - C.RESULTS- C.BRESULTS + X.BGTRQAMT LASAMT, /*�����ܾ�*/   \n");
						sql.append( " X.FDCODE          FDCODE,		   									  	 \n");
						sql.append( " X.BGTYY           BGTYY,												  	 \n");
						sql.append( " X.BGTDIV          BGTDIV,	    									  	 \n");
						sql.append( " X.BGTDPT          BGTDPT,													   \n");
						sql.append( " X.FSREFCD					FSREFCD													     \n");
						sql.append( "		FROM						\n");
						sql.append( "		(								 \n");
						sql.append( "		SELECT A.FDCODE, A.BGTYY, A.BGTDIV, A.BGTDPT,A.ATCODE, 				\n");
						sql.append( "   	A.FSREFCD, A.SATCODE,																		\n");
						sql.append( "		B.BGTRQDIV, B.BGTRQAMT, B.BGTTOMON, B.BGTFRMON, B.DVTFRACT, 	\n");
						sql.append( "		B.DVTFRSATCD,  B.WHYRQNOTE,   B.BGTFRDEPT,   B.BGTRQST      		\n");
						sql.append( "		FROM ACCOUNT.BGTRQMST A, ACCOUNT.BGTRQDTL1 B    						\n");
						sql.append( "		WHERE A.FDCODE = B.FDCODE      \n");
						sql.append( "		AND A.BGTRQNO = B.BGTRQNO       \n");
						sql.append( "		AND B.FDCODE = '"+str[0]+"'  \n");
						sql.append( "		AND B.BGTRQNO = '"+str[1]+"'  \n");
						sql.append( "		) X                         \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL J ON X.BGTRQDIV=J.CDCODE AND J.CMTYPE='2150' --����   \n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE  R  ON X.ATCODE=R.ATCODE   --��������             \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL T ON X.SATCODE=T.CDCODE  AND T.CMTYPE=X.FSREFCD  --�������� \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL P ON X.BGTDPT=P.CDCODE   AND P.CMTYPE='0003' --�����μ�   \n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE  S ON X.DVTFRACT=S.ATCODE   --�������         \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL Y ON X.DVTFRSATCD=Y.CDCODE  AND Y.CMTYPE=X.FSREFCD  --���漼��   \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL Z ON X.BGTFRDEPT=Z.CDCODE   AND Z.CMTYPE='0003' --����μ�   \n");
						sql.append( " LEFT JOIN ACCOUNT.BGTDTL C ON C.FDCODE =X.FDCODE         \n");
						sql.append( " AND C.BGTYY=X.BGTYY        			\n");
						sql.append( " AND C.BGTMM=X.BGTTOMON      	\n");
						sql.append( " AND C.BGTDIV=X.BGTDIV      			\n"); 
						sql.append( " AND C.BGTDPT=X.BGTDPT      		\n"); 
						sql.append( " AND C.ATCODE=X.ATCODE        		\n");
						sql.append( " AND C.FSREFCD=X.FSREFCD        	\n");
						sql.append( " AND C.SATCODE=X.SATCODE       	\n");

						//logger.dbg.println(this,"sql::"+sql.toString());
						
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