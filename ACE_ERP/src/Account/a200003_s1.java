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
public class a200003_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//�ڱݱ���
				str[2] = req.getParameter("v_str3");	//��ǥ����fr
				str[3] = req.getParameter("v_str4");	//��ǥ����to

				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","FSDAT","REFCODE2","DRAMT","CRAMT",
					"STRDATE","ENDDATE","VEND_CD","VEND_NM","BANCOD",
					"BANNAM","REMARK"
				}; 

				int[] intArrCN = new int[] { 
					 2,   8,  30,  15,  15,
					 8,	  8,  13,  66,   6,   
					66, 132
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,   0,   0,
					-1,  -1,  -1,  -1,  -1, 
					-1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																						\n");
						sql.append( " RTRIM(A.FDCODE)			FDCODE,     /*�����ڵ�*/			\n");
						sql.append( " SUBSTR(A.FSDAT,2,8) FSDAT,			/*��ǥ����*/			\n");
						sql.append( " RTRIM(A.REFCODE2)		REFCODE2,   /*������ȣ*/			\n");
						sql.append( " RTRIM(A.DRAMT)			DRAMT,      /*�����ݾ�*/			\n");
						sql.append( " RTRIM(A.CRAMT)			CRAMT,      /*�뺯�ݾ�*/			\n");
						sql.append( " RTRIM(A.STRDATE)		STRDATE,    /*��������*/			\n");
						sql.append( " RTRIM(A.ENDDATE)		ENDDATE,    /*��������*/			\n");
						sql.append( " RTRIM(A.VEND_CD)		VEND_CD,    /*�ŷ�ó*/				\n");
						sql.append( " RTRIM(C.CDNAM)			VEND_NM,    /*�ŷ�ó��*/			\n");
						sql.append( " RTRIM(A.BANCOD)			BANCOD,     /*�����ڵ�*/			\n");
						sql.append( " RTRIM(B.CDNAM)			BANNAM,     /*�����*/				\n");
						sql.append( " RTRIM(A.REMARK)			REMARK      /*����*/					\n");
						sql.append( " FROM ACCOUNT.AFUNDLDG A,													\n");
						sql.append( " ACCOUNT.COMMDTIL B,ACCOUNT.COMMDTIL C							\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL															\n");
						sql.append( " 	AND A.BANCOD=B.CDCODE AND B.CMTYPE='0022'				\n");
						sql.append( " 	AND A.VEND_CD=C.CDCODE AND C.CMTYPE='0020'			\n");
						sql.append( " 	AND A.STATDIV='0'																\n"); //��ǥ����:����
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'	\n");	//����
						if(!str[1].equals("")) sql.append( " AND A.FUNDDIV='"+str[1]+"' \n");	//�ڱݱ���
						if(!str[2].equals("")) sql.append( " AND SUBSTR(A.FSDAT,2,8) BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//��ǥ����
						sql.append( " ORDER BY FDCODE,FSDAT,REFCODE2										\n");

						//System.out.println("a200003_s1: \n" + sql.toString()); 
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