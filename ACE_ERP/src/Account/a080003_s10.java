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
public class a080003_s10 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//�ۼ�����fr
				str[2] = req.getParameter("v_str3");	//�ۼ�����to
				str[3] = req.getParameter("v_str4");	//��û�μ�
				str[4] = req.getParameter("v_str5");	//��������
				str[5] = req.getParameter("v_str6");	//�����
				str[6] = req.getParameter("v_str7");  //��û������
				str[7] = req.getParameter("v_str8");  //�����

				for(int i=0;i<=7;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE", "BGTRQNO","BGTYY",  "BGTDIV",	 "BGTDPT",  "BGTDPTNM",
					"WRDT",   "BGTRQST","BGTRQDIV","BGTRQAMT","BGTRQSEQ","ATCODE",	"ATKORNAM","FSREFCD", 
					"SATCODE","CDNAM",	"BGTGBCD","BGTTYPE", "BGTMACT",
					"CHK"
				}; 

				int[] intArrCN = new int[] { 
					2,  12,   4,   4,   4,   15,
					8,   1,   2,  15,   2,   7,	 66,   4,     
					2,	40,   4,   1,   2,
					1
				}; 
			
				int[] intArrCN2 = new int[]{ 
				  -1,  -1,  -1,  -1,  -1, -1,
					-1,  -1,  -1,   0,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																					\n");
						sql.append( "			RTRIM(A.FDCODE)    FDCODE,        /*�����ڵ�*/					\n");
						sql.append( "			RTRIM(A.BGTRQNO)   BGTRQNO,       /*��û����ȣ*/			\n");
						sql.append( "			RTRIM(A.BGTYY)     BGTYY,         /*����⵵*/					\n");
						sql.append( "			RTRIM(A.BGTDIV)    BGTDIV,        /*���꺻��*/					\n");
						sql.append( "			RTRIM(A.BGTDPT)    BGTDPT,        /*��û�μ�*/					\n");
						sql.append( "			RTRIM(G.CDNAM)     BGTDPTNM,        /*��û�μ�*/				\n");						
						sql.append( "			RTRIM(A.WRDT)      WRDT,          /*�ۼ�����*/					\n");
						sql.append( "			RTRIM(K.BGTRQST)   BGTRQST,       /*��û������*/			\n");
						sql.append( "			RTRIM(K.BGTRQDIV)	 BGTRQDIV,      /*��û������*/      	\n");
						sql.append( "			COALESCE(K.BGTRQAMT,0)  BGTRQAMT,      /*��û���ݾ�*/\n");
						sql.append( "			RTRIM(K.BGTRQSEQ)	 BGTRQSEQ,      /*����*/					\n");
						sql.append( "			RTRIM(A.ATCODE)    ATCODE,        /*�����ڵ�*/					\n");
						sql.append( "			RTRIM(F.ATKORNAM)  ATKORNAM,      /*���������*/			\n");
						sql.append( "			RTRIM(A.FSREFCD)   FSREFCD,       /*�����׸��ڵ�*/			\n");
						sql.append( "			RTRIM(A.SATCODE)   SATCODE,       /*����*/						\n");
						sql.append( "			RTRIM(E.CDNAM)     CDNAM,         /*�����*/						\n");
						sql.append( "			RTRIM(A.BGTGBCD)   BGTGBCD,       /*����з�*/				\n");
						sql.append( " 		RTRIM(A.BGTTYPE)   BGTTYPE,       /*����Ÿ��*/						\n");
						sql.append( " 		RTRIM(A.BGTMACT)   BGTMACT,       /*����Ÿ��*/					\n");
						sql.append( " 		'F' AS CHK												/*����*/					\n");
						sql.append( " FROM ACCOUNT.BGTRQMST A													\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE  = F.ATCODE			\n");
						sql.append( " LEFT JOIN ACCOUNT.BGTRQDTL1 K ON A.FDCODE=K.FDCODE AND A.BGTRQNO=K.BGTRQNO	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON A.SATCODE=E.CDCODE AND A.FSREFCD=E.CMTYPE		\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL G ON A.BGTDPT=G.CDCODE AND G.CMTYPE = '0003'		\n");

						sql.append( " WHERE  1  = 1																			\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'							\n");	/*�����ڵ�*/
						if(!str[1].equals("")) sql.append( " AND A.WRDT BETWEEN '"+str[1]+"' AND '"+str[2]+"'		\n");	/*�ۼ�����*/
						if(!str[3].equals("")) sql.append( " AND A.BGTDPT  = '"+str[3]+"'							\n");	/*��û�μ�*/
						if(!str[4].equals("")) sql.append( " AND F.ATKORNAM LIKE '"+str[4]+"%' 				\n");	/*��������*/
						if(!str[5].equals("")) sql.append( " AND A.SATCODE LIKE '"+str[5]+"%' 					\n");	/*�����ڵ�*/
						if(!str[6].equals("")) sql.append( " AND K.BGTRQST = '"+str[6]+"'       					\n");
						if(!str[7].equals("")) sql.append( " AND A.EMPNO = '"+str[7]+"'  							\n"); //����ڻ��

						System.out.println("a080003_s10 \n" + sql.toString());
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