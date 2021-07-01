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
public class a200006_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//��������fr
				str[2] = req.getParameter("v_str3");	//��������to
				str[3] = req.getParameter("v_str4");	//�ŷ�ó��
				str[4] = req.getParameter("v_str5");	//�ŷ�ó�ڵ�

				for(int i=0;i<=4;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ENDDATE","VEND_CD","VEND_NM","REFCODE50",
					"DRAMT50","REFCODE60","DRAMT60"
				}; 

				int[] intArrCN = new int[] { 
					 2,   8,  13,  66,  30,
					15,	 30,  15
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					 0,  -1,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																														\n");
						sql.append( " MAX(X.FDCODE) FDCODE,MAX(X.ENDDATE) ENDDATE,											\n");
						sql.append( " MAX(X.VEND_CD) VEND_CD,MAX(X.VEND_NM) VEND_NM,										\n");
						sql.append( " MAX(X.REFCODE50) REFCODE50,																				\n");
						sql.append( " SUM(COALESCE(TO_NUMBER(X.DRAMT50),0))   DRAMT50,															\n");
						sql.append( " MAX(X.REFCODE60) REFCODE60,																				\n");
						sql.append( " SUM(COALESCE(TO_NUMBER(X.DRAMT60),0))   DRAMT60															\n");
						sql.append( " FROM (SELECT RTRIM(A.FDCODE) FDCODE,/*�����ڵ�*/									\n");
						sql.append( " 			RTRIM(A.ENDDATE)  ENDDATE,    /*��������*/									\n");
						sql.append( " 			RTRIM(A.VEND_CD)  VEND_CD,    /*�ŷ�ó*/										\n");
						sql.append( " 			RTRIM(C.CDNAM)    VEND_NM,    /*�ŷ�ó��*/									\n");
						sql.append( " CASE WHEN A.FUNDDIV='50' THEN RTRIM(A.REFCODE2) END AS REFCODE50,	\n");		/*��������-������ȣ*/
						sql.append( " CASE WHEN A.FUNDDIV='50' THEN RTRIM(A.DRAMT)    END AS DRAMT50,		\n");		/*��������-�ݾ�*/
						sql.append( " CASE WHEN A.FUNDDIV='60' THEN RTRIM(A.REFCODE2) END AS REFCODE60,	\n");		/*���޾���-������ȣ*/
						sql.append( " CASE WHEN A.FUNDDIV='60' THEN RTRIM(A.DRAMT)    END AS DRAMT60		\n");		/*���޾���-�ݾ�*/
						sql.append( " FROM ACCOUNT.AFUNDLDG A,																					\n");
						sql.append( " ACCOUNT.COMMDTIL B,ACCOUNT.COMMDTIL C															\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																				\n");
						sql.append( " 	AND A.BANCOD=B.CDCODE AND B.CMTYPE='0022'													\n");
						sql.append( " 	AND A.VEND_CD=C.CDCODE AND C.CMTYPE='0020'													\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'														\n");	//����
						if(!str[1].equals("")) sql.append( " AND A.ENDDATE BETWEEN '"+str[1]+"'	AND '"+str[2]+"'					\n");	//��������
						if(!str[3].equals("")) sql.append( " AND C.CDNAM LIKE '"+str[3]+"%'													\n");	//�ŷ�ó��
						if(!str[4].equals("")) sql.append( " AND A.VEND_CD='"+str[4]+"'														\n");	//�ŷ�ó�ڵ�
						sql.append( " GROUP BY A.FDCODE,A.ENDDATE,A.VEND_CD,C.CDNAM,A.FUNDDIV,A.REFCODE2,A.DRAMT	\n");
						sql.append( " )X																																\n");
						sql.append( " GROUP BY X.FDCODE,X.ENDDATE,X.VEND_CD,X.VEND_NM											\n");
						sql.append( " ORDER BY FDCODE,ENDDATE,VEND_NM																	\n");

						//System.out.println("# Query : \n" + sql);
						
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