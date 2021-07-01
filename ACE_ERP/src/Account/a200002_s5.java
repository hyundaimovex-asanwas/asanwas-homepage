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
public class a200002_s5 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//�ε�����fr
				str[2] = req.getParameter("v_str3");	//�ε�����to
				str[3] = req.getParameter("v_str4");	//�ŷ�ó��  
				str[4] = req.getParameter("v_str5");	//�ŷ�ó�ڵ�
				str[5] = req.getParameter("v_str6");	//ó������

				for(int i=0;i<=5;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ATCODE","FUNDDIV","REFCODE2","STRDATE1",
					"RTNDATE","RTNAMT","DRAMT","STRDATE2","ENDDATE",
					"VEND_CD","VEND_NM"
				}; 

				int[] intArrCN = new int[] { 
					 2,   7,   2,  30,  8,
					 8,  15,  15,   8,  8,   
					13,  66
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,   0,   0,  -1,  -1,
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
						sql.append( " SELECT                                             	  \n");	
						sql.append( "  RTRIM(A.FDCODE)      FDCODE,     /*�����ڵ�*/      	\n");
						sql.append( "  RTRIM(A.ATCODE)      ATCODE,     /*��������*/      	\n");
						sql.append( "  RTRIM(A.FUNDDIV)     FUNDDIV,    /*�ڱݱ���*/      	\n");
						sql.append( "  RTRIM(A.REFCODE2)    REFCODE2,   /*������ȣ*/      	\n");
						sql.append( "  RTRIM(A.STRDATE)     STRDATE1,   /*�ε�����*/      	\n");
						sql.append( "  RTRIM(A.RTNDATE)     RTNDATE,    /*ȸ������*/      	\n");
						sql.append( "  COALESCE(A.RTNAMT,0) RTNAMT,		  /*ȸ���ݾ�*/        \n");
						sql.append( "  COALESCE(B.DRAMT,0)  DRAMT,      /*(����)�����ݾ�*/	\n");
						sql.append( "  RTRIM(B.STRDATE)     STRDATE2,   /*��������*/      	\n");
						sql.append( "  RTRIM(B.ENDDATE)     ENDDATE,    /*��������*/      	\n");
						sql.append( "  RTRIM(B.VEND_CD)     VEND_CD,    /*�ŷ�ó*/        	\n");
						sql.append( "  RTRIM(C.CDNAM)       VEND_NM     /*�ŷ�ó��*/      	\n");
						sql.append( "  FROM ACCOUNT.ABINBUD A                            	  \n");
						sql.append( "  LEFT JOIN ACCOUNT.AFUNDLDG B ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE	\n");
						sql.append( " 	                      AND A.FUNDDIV=B.FUNDDIV AND A.REFCODE2=B.REFCODE2	\n");
						sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL C ON B.VEND_CD=C.CDCODE AND C.CMTYPE='0020'		\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'									\n");	//����
						if(!str[1].equals("")) sql.append( " AND A.STRDATE BETWEEN '"+str[1]+"'	AND '"+str[2]+"'\n");	//�ε�����
						if(!str[3].equals("")) sql.append( " AND C.CDNAM LIKE '"+str[3]+"%'								\n");	//�ŷ�ó��
						if(!str[4].equals("")) sql.append( " AND B.VEND_CD='"+str[4]+"'									\n");	//�ŷ�ó�ڵ�
						if(!str[5].equals("")) sql.append( " AND B.STATDIV='"+str[5]+"'										\n");	//ó������
						sql.append( " ORDER BY STRDATE1,RTNDATE															\n");

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