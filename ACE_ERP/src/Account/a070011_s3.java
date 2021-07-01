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
public class a070011_s3 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//������    
				str[2] = req.getParameter("v_str3");	//�����ڵ�  
				str[3] = req.getParameter("v_str4");	//ó������  
				str[4] = req.getParameter("v_str5");	//����ó��    
				str[5] = req.getParameter("v_str6");	//����ó�ڵ�  
				str[6] = req.getParameter("v_str7");	//��������fr
				str[7] = req.getParameter("v_str8");	//��������to

				for(int i=0;i<=7;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ATCODE","BANCOD","BANNAM","FUNDDIV",
					"REFCODE2","CRAMT_1","DRAMT_2","JANAMT01","CRTAMT",
					"DRAMT0","DRAMT1","AMTSUM","RTNDATE","RTNTERM_N",
					"RTNTERM","RTNUNIT","RTNSEQ","RTNDIV","FSTDATE"
				}; 

				int[] intArrCN = new int[] { 
					 2,   7,   6,  66,  2,
					30,  15,  15,  15, 15,
					15,  15,  15,   8,  3,
					 3,   3,   3,   1,  8
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,   0,   0,   0,   0,
					 0,   0,   0,  -1,   0,
					 0,   0,   0,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) {
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																					\n");	
						sql.append( " RTRIM(A.FDCODE)				FDCODE,         /*�����ڵ�*/				\n");
						sql.append( " RTRIM(A.ATCODE)				ATCODE,         /*��������*/				\n");
						sql.append( " RTRIM(A.BANCOD)				BANCOD,         /*�����ڵ�*/				\n");
						sql.append( " RTRIM(D.CDNAM)				BANNAM,         /*�����*/						\n");
						sql.append( " RTRIM(A.FUNDDIV)			FUNDDIV,        /*�ڱݱ���*/					\n");
						sql.append( " RTRIM(C.REFCODE2)			REFCODE2,       /*���¹�ȣ*/				\n");
						sql.append( " nvl(A.CRAMT,0)			CRAMT_1,        /*���Աݾ�*/						\n");
						sql.append( " nvl(A.DRAMT,0)			DRAMT_2,        /*��ȯ�ݾ�*/						\n");
						sql.append( " nvl(A.CRAMT-A.DRAMT,0) JANAMT01,		/*��ȭ�ܾ�*/					\n");
						sql.append( " nvl(C.CRTAMT,0)		CRTAMT,         /*�ܾ� */								\n");
						sql.append( " nvl(C.DRAMT,0)			DRAMT0,         /*���� */							\n");
						sql.append( " nvl(C.DRAMT1,0)		DRAMT1,         /*���� */								\n");
						sql.append( " nvl(C.DRAMT+C.DRAMT1,0) AMTSUM,		/*��   */							\n");
						sql.append( " RTRIM(C.RTNDATE)			RTNDATE,        /*��ȯ����*/					\n");
						sql.append( " nvl(B.RTNTERM_N,0) RTNTERM_N,			/*��ġ�Ⱓ*/					\n");
						sql.append( " nvl(B.RTNTERM,0)		RTNTERM,				/*��ȯ�Ⱓ*/					\n");
						sql.append( " nvl(B.RTNUNIT,0)		RTNUNIT,				/*��ȯ�ֱ�*/					\n");
						sql.append( " nvl(B.RTNSEQ,0)		RTNSEQ,					/*��ȯȸ��*/				\n");
						sql.append( " RTRIM(B.RTNDIV)				RTNDIV,					/*��������*/			\n");
						sql.append( " RTRIM(B.FSTDATE)			FSTDATE					/*���ʻ�ȯ��*/	\n");
						sql.append( " FROM ACCOUNT.AFUNDLDG A													\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE=F.ATCODE					\n");
						sql.append( " LEFT JOIN ACCOUNT.ADBTRTN  B ON A.FDCODE=B.FDCODE					\n");
						sql.append( "     AND A.ATCODE=B.ATCODE AND A.FUNDDIV=B.FUNDDIV						\n");
						sql.append( "     AND A.REFCODE2=B.REFCODE2														\n");
						sql.append( " LEFT JOIN ACCOUNT.ADBTSCD  C ON A.FDCODE=C.FDCODE					\n");
						sql.append( "     AND A.ATCODE=C.ATCODE AND A.FUNDDIV=C.FUNDDIV						\n");
						sql.append( "     AND A.REFCODE2=C.REFCODE2														\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.BANCOD=D.CDCODE					\n");
						sql.append( "     AND D.CMTYPE='0022' --����															\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL 														\n");
						sql.append( " AND B.FDCODE=C.FDCODE  AND B.ATCODE=C.ATCODE							\n");
						sql.append( " AND B.FUNDDIV=C.FUNDDIV AND B.REFCODE2=C.REFCODE2					\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE='"+str[0]+"'					\n");	//�����ڵ�
						if(!str[1].equals("")) sql.append( " AND F.ATKORNAM LIKE '"+str[1]+"%'			\n");	//������
						if(!str[2].equals("")) sql.append( " AND A.ATCODE='"+str[2]+"'						\n");	//�����ڵ�
						if(!str[3].equals("")) sql.append( " AND A.STATDIV='"+str[3]+"'						\n");	//ó������
						if(!str[4].equals("")) sql.append( " AND D.CDNAM LIKE '"+str[4]+"%'				\n");	//����ó��
						if(!str[5].equals("")) sql.append( " AND A.BANCOD='"+str[5]+"'					\n");	//����ó�ڵ�
						if(!str[6].equals("")) sql.append( " AND A.STRDATE BETWEEN '"+str[6]+"'	AND '"+str[7]+"'	\n");	//��������
						sql.append( " ORDER BY REFCODE2																			\n");

						//System.out.println("# Query : \n" + sql);
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