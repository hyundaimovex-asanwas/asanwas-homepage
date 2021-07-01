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
public class comtax_popup_s3 extends HttpServlet {
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
				String []  str	= new String [1];
				str[0] = req.getParameter("v_str1");	//��꼭��ȣ

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"TAXNBR","COCODE","TAXIODIV","TAXDIV","TAXDIVNM",
					"TAXKND","TAXKNDNM","CCCODE","VEND_NM","TAXDAT",
					"TAXSUM","TAXVATAMT","TAXTOT","REMARK","TAXCDNBR",
					"TAXPRTYN","FSDAT","FSNBR","TAXCNT","TAXKIDIV",
					"FDCODE",
					"WRDT","WRID","UPDT","UPID",
					"VD_DIRECT","BSNS_CND","BSNS_KND","ADDNM"
				}; 

				int[] intArrCN = new int[] { 
					10,   2,   1,   2,  40,
					 1,  40,  13,  32,   8,
					15,  13,  15,  40,  16,
					 1,   9,   6,   3,   1,
					 2,
					 8,   7,   8,   7,
					12,  22,  22, 144
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					 0,   0,   0,  -1,  -1,
					-1,  -1,  -1,   0,  -1,
					-1,
					-1,  -1,  -1,  -1,
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
						sql.append( " SELECT																								\n");	
						sql.append( " RTRIM(A.TAXNBR) TAXNBR,             /*��꼭��ȣ*/		\n");
						sql.append( " A.COCODE,                           /*������ڵ�*/		\n");
						sql.append( " RTRIM(A.TAXIODIV) TAXIODIV,         /*��꼭����*/		\n");
						sql.append( " RTRIM(A.TAXDIV) TAXDIV,             /*�ͼӱ���*/			\n");
						sql.append( " RTRIM(D.CDNAM) TAXDIVNM,            /*�ͼӸ�*/				\n");
						sql.append( " RTRIM(A.TAXKND) TAXKND,             /*��꼭����*/		\n");
						sql.append( " RTRIM(C.CDNAM) TAXKNDNM,            /*������*/				\n");
						sql.append( " RTRIM(A.CCCODE) CCCODE,             /*�ŷ�ó�ڵ�*/		\n");
						sql.append( " RTRIM(B.VEND_NM) VEND_NM,           /*�ŷ�ó��*/			\n");
						sql.append( " A.TAXDAT,                           /*��꼭����*/		\n");
						sql.append( " COALESCE(A.TAXSUM,0) TAXSUM,        /*���ް���*/			\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT,  /*�ΰ�����*/			\n");
						sql.append( " COALESCE(A.TAXTOT,0) TAXTOT,        /*�հ�ݾ�*/			\n");
						sql.append( " RTRIM(A.REMARK) REMARK,             /*����*/					\n");
						sql.append( " RTRIM(A.TAXCDNBR) TAXCDNBR,         /*�ſ�ī���ȣ*/	\n");
						sql.append( " A.TAXPRTYN,                         /*���౸��*/			\n");
						sql.append( " A.FSDAT,                            /*��ǥ����*/			\n");
						sql.append( " A.FSNBR,                            /*��ǥ��ȣ*/			\n");
						sql.append( " COALESCE(A.TAXCNT,0) TAXCNT,        /*����Ƚ��*/			\n");
						sql.append( " A.TAXKIDIV,                         /*���*/					\n");
						sql.append( " A.FDCODE,                           /*����*/					\n");
						sql.append( " A.WRDT,                             /*�۾�����*/			\n");
						sql.append( " A.WRID,                             /*�۾���*/				\n");
						sql.append( " A.UPDT,                             /*��������*/			\n");
						sql.append( " A.UPID,                             /*������*/				\n");
						sql.append( " B.VD_DIRECT,												/*��ǥ��*/				\n");
						sql.append( " B.BSNS_CND,													/*����*/					\n");
						sql.append( " B.BSNS_KND,													/*����*/					\n");
						sql.append( " RTRIM(B.ADDRESS1) || ' ' || RTRIM(B.ADDRESS2) ADDNM 	\n");
						sql.append( " FROM ACCOUNT.ATTAXMST A /*���ݰ�꼭MST*/							\n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.CCCODE=B.VEND_CD /*�ŷ�ó�ڵ�*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.TAXKND=C.CDCODE AND C.CMTYPE ='0013' /*����-��꼭����*/ \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.TAXDIV=D.CDCODE AND D.CMTYPE ='0014' /*����-�ͼӱ���*/	 \n");
						sql.append( " LEFT JOIN ACCOUNT.CARDCODE E ON A.TAXCDNBR=E.CANBR    /*ī�����*/		\n");
						sql.append( " WHERE A.TAXNBR = '"+str[0]+"'                          \n");
						sql.append( " ORDER BY TAXNBR,TAXDAT,TAXIODIV,TAXKND								\n");
						
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