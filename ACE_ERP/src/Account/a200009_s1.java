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
public class a200009_s1 extends HttpServlet {
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
				String []  str	= new String [6];
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//�����ڵ�
				str[2] = req.getParameter("v_str3");	//�ڱݱ���   
				str[3] = req.getParameter("v_str4");	//�߻�����fr 
				str[4] = req.getParameter("v_str5");	//�߻�����to 
				str[5] = req.getParameter("v_str6");	//ó������   

				for(int i=0;i<=5;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE", "ATCODE", "FUNDDIV","REFCODE2","STRDATE",
					"ENDDATE","DRAMT",  "CRAMT",  "VEND_CD", "VENDNM",  "BANCOD", "BANNAM",
					"INRATE", "OUTRATE","DRFAMT", "CRFAMT",  "CURDIV",
					"EXRATE", "STATDIV","REMARK", "FSDAT",   "FSNBR",
					"FSSEQ",  "ACTDAT", "FSDAT1", "FSNBR1",  "FSSEQ1",
					"ACTDAT1","FSREFCD","FSREFVAL","UPDT",   "UPID",
					"JANAMT1","JANAMT2","ATDECR",  "FSREFCDNM", "FSREFVALNM"
				}; 

				int[] intArrCN = new int[] { 
					 2,   7,   2,  30,   8,
					 8,	 15,  15,  13,   40, 6, 40,   
					 5,	  5,  15,  15,	 3,   
					 6,   1, 132,   9,	 6,   
					 5,   8,   9,   6,	 5,   
					 8,   4,  20,   8,  10, 
					 15,  15,  1,   40, 40
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,   0,   0,  -1,  -1, -1,  -1,
					 2,   2,   0,   0,  -1,
					 2,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1, 
					 0,   0,  -1,  -1,  -1
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
						sql.append( " RTRIM(A.FDCODE)   FDCODE,     /*�����ڵ�*/				\n");
						sql.append( " RTRIM(A.ATCODE)   ATCODE,			/*��������*/				\n");
						sql.append( " RTRIM(A.FUNDDIV)  FUNDDIV,    /*�ڱݱ���*/				\n");
						sql.append( " RTRIM(A.REFCODE2) REFCODE2,   /*������ȣ*/				\n");
						sql.append( " RTRIM(A.STRDATE)  STRDATE,    /*�߻�����*/				\n");
						sql.append( " RTRIM(A.ENDDATE)  ENDDATE,    /*��������*/				\n");
						sql.append( " COALESCE(A.DRAMT,0) DRAMT,		/*�����ݾ�*/				\n");
						sql.append( " COALESCE(A.CRAMT,0) CRAMT,		/*�뺯�ݾ�*/				\n");
						sql.append( " RTRIM(A.VEND_CD)  VEND_CD,		/*�ŷ�ó*/					\n");
						sql.append( " RTRIM(C.VEND_NM)    VENDNM,     /*�ŷ�ó��*/					\n");
						sql.append( " RTRIM(A.BANCOD)   BANCOD,			/*�����ڵ�*/				\n");
						sql.append( " RTRIM(B.CDNAM)    BANNAM,     /*�����*/					\n");
						sql.append( " COALESCE(A.INRATE,0)  INRATE,/*��������*/				\n");
						sql.append( " COALESCE(A.OUTRATE,0) OUTRATE,/*��������*/				\n");
						sql.append( " COALESCE(A.DRFAMT,0)  DRFAMT,/*������ȭ*/				\n");
						sql.append( " COALESCE(A.CRFAMT,0)  CRFAMT,/*�뺯��ȭ*/				\n");
						sql.append( " RTRIM(A.CURDIV)				CURDIV,/*��ȭ����*/				\n");
						sql.append( " COALESCE(A.EXRATE,0)  EXRATE,/*ȯ��*/						\n");
						sql.append( " RTRIM(A.STATDIV)  STATDIV,		/*ó������*/				\n");
						sql.append( " RTRIM(A.REMARK)   REMARK,			/*����*/						\n");
						sql.append( " RTRIM(A.FSDAT)    FSDAT,			/*�߻���ǥ����*/		\n");
						sql.append( " RTRIM(A.FSNBR)    FSNBR,			/*�߻�������ȣ*/		\n");
						sql.append( " RTRIM(A.FSSEQ)		FSSEQ,			/*�߻��������ȣ*/	\n");
						sql.append( " RTRIM(A.ACTDAT)		ACTDAT,			/*�߻�ȸ������*/		\n");
						sql.append( " RTRIM(A.FSDAT1)		FSDAT1,			/*ó����ǥ����*/		\n");
						sql.append( " RTRIM(A.FSNBR1)		FSNBR1,			/*ó��������ȣ*/		\n");
						sql.append( " RTRIM(A.FSSEQ1)		FSSEQ1,			/*ó���������ȣ*/	\n");
						sql.append( " RTRIM(A.ACTDAT1)	ACTDAT1,		/*ó��ȸ������*/		\n");
						sql.append( " RTRIM(A.FSREFCD)	FSREFCD,				\n");
						sql.append( " RTRIM(A.FSREFVAL)	FSREFVAL,				\n");
						sql.append( " RTRIM(A.UPDT)		  UPDT,				/*��������*/				\n");
						sql.append( " RTRIM(A.UPID)		  UPID,				/*������*/					\n");
						sql.append( " CASE WHEN D.ATDECR ='1' THEN COALESCE(A.DRAMT,0) - COALESCE(A.CRAMT,0)              \n");
						sql.append( " 		 WHEN D.ATDECR ='2' THEN COALESCE(A.CRAMT,0) - COALESCE(A.DRAMT,0) END JANAMT1, \n");
						sql.append( " CASE WHEN D.ATDECR ='1' THEN COALESCE(A.DRFAMT,0) - COALESCE(A.CRFAMT,0)            \n");
						sql.append( " 		 WHEN D.ATDECR ='2' THEN COALESCE(A.CRFAMT,0) - COALESCE(A.DRFAMT,0) END JANAMT2, \n");
						sql.append( " D.ATDECR,E.CDNAM FSREFCDNM , F.CDNAM FSREFVALNM													\n"); 
						sql.append( " FROM ACCOUNT.AFUNDLDG A     											\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL B ON A.BANCOD=B.CDCODE AND B.CMTYPE='0022'   \n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VEND_CD=C.VEND_CD    \n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE D ON A.ATCODE = D.ATCODE  \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON A.FSREFCD=E.CDCODE AND E.CMTYPE='0050'   \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL F ON A.FSREFVAL=F.CDCODE AND F.CMTYPE=A.FSREFCD   \n");
						sql.append( " WHERE A.FDCODE IS NOT NULL															\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'	\n");	//����
						if(!str[1].equals("")) sql.append( " AND A.ATCODE='"+str[1]+"' \n");	//�ڱݱ���
						if(!str[2].equals("")) sql.append( " AND A.FUNDDIV='"+str[2]+"' \n");	//�ڱݱ���
						if(!str[3].equals("")&&!str[4].equals("")) sql.append( " AND A.STRDATE BETWEEN '"+str[3]+"'	AND '"+str[4]+"'\n");	//�߻�����
						if(!str[5].equals("")) sql.append( " AND A.STATDIV ='"+str[5]+"'			\n");	//ó������
						sql.append( " ORDER BY FDCODE,REFCODE2,STRDATE	\n");

						// logger.dbg.println(this,"toString::"+sql.toString());
						
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