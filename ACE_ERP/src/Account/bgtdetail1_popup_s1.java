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
public class bgtdetail1_popup_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//����⵵
				str[2] = req.getParameter("v_str3");	//����μ�
				str[3] = req.getParameter("v_str4");  //���������
				str[4] = req.getParameter("v_str5");	//�����ڵ�
				str[5] = req.getParameter("v_str6");	//�����
	
				for(int i=0;i<=5;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","BGTYY","BGTMM","BGTDIV","BGTDPT",
					"ATCODE","FSREFCD","SATCODE","BGTTYPE","BGTMACT",
					"INITMAN","INITBGT","CHGMAN","CHGBGT","BASICBGT",
					"ADDBGT","CHGABGT","CHGTBGT","REALBGT","RESULTS",
					"BRESULTS","APPROVAL","CHGAPPROV","REMARK","DEPTBGT",
					"ATCODE1","SATCODE1","RESULTS1"
				}; 

				int[] intArrCN = new int[] { 
					 2,   4,   2,   4,   4,   
					 7,		4,   2,   1,   2,
					 4,  15,   4,  15,  15,
					15,  15,  15,  15,  15,
					15,   1,   1,  40,  15,
					66,  40,  15
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
				   0,   0,   0,   0,   0,
					 0,   0,   0,   0,   0,
					 0,  -1,  -1,  -1,   0,
					-1,  -1,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
					if (!GauceReq.isBuilderRequest()) {
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																										\n");	
						sql.append( " 	RTRIM(A.FDCODE)     FDCODE,        /*�����ڵ�*/					\n");
						sql.append( " 	RTRIM(A.BGTYY)      BGTYY,				 /*����⵵*/					\n");
						sql.append( " 	RTRIM(A.BGTMM)      BGTMM,         /*�����*/						\n");
						sql.append( " 	RTRIM(A.BGTDIV)     BGTDIV,        /*���꺻��*/					\n");
						sql.append( " 	RTRIM(A.BGTDPT)     BGTDPT,        /*����μ�*/					\n");
						sql.append( " 	RTRIM(A.ATCODE)     ATCODE,        /*��������*/					\n");
						sql.append( " 	RTRIM(A.FSREFCD)    FSREFCD,       /*�����׸��ڵ�*/			\n");
						sql.append( " 	RTRIM(A.SATCODE)    SATCODE,       /*����*/				      \n");
						sql.append( " 	RTRIM(A.BGTTYPE)    BGTTYPE,       /*����Ÿ��*/					\n");
						sql.append( "	RTRIM(A.BGTMACT)    BGTMACT,       /*����Ÿ��*/         \n");
						sql.append( " 	COALESCE(A.INITMAN,0) INITMAN,     /*�����ο�*/					\n");
						sql.append( " 	COALESCE(A.INITBGT,0) INITBGT,			 /*��û��*/		  			\n");
						sql.append( " 	COALESCE(A.CHGMAN,0)  CHGMAN,        /*�����ο�*/					\n");
						sql.append( " 	COALESCE(A.CHGBGT,0)  CHGBGT,        /*������*/						\n");
						sql.append( " 	COALESCE(A.BASICBGT,0) BASICBGT,      /*������*/					\n");
						sql.append( " 	COALESCE(A.ADDBGT,0)  ADDBGT,        /*�߰�����*/					\n");
						sql.append( " 	COALESCE(A.CHGABGT,0) CHGABGT,       /*�׸�����*/					\n");
						sql.append( " 	COALESCE(A.CHGTBGT,0) CHGTBGT,       /*�Ⱓ����*/			    \n");
						sql.append( " 	COALESCE(A.REALBGT,0) REALBGT,       /*���࿹��*/					\n");
						sql.append( "	COALESCE(A.RESULTS,0) RESULTS,       /*����*/						  \n");
						sql.append( " 	COALESCE(A.BRESULTS,0) BRESULTS,      /*����������*/			\n");
						sql.append( " 	RTRIM(A.APPROVAL)   APPROVAL,        /*���α���*/					\n");
						sql.append( " 	RTRIM(A.CHGAPPROV)  CHGAPPROV,       /*����������α���*/	\n");
						sql.append( " 	RTRIM(A.REMARK)     REMARK,          /*����ٰ�*/				  \n");
						sql.append( " 	COALESCE(A.DEPTBGT,0)    DEPTBGT,        /*�μ�����*/					\n");
						sql.append( "	RTRIM(B.ATKORNAM)   ATCODE1,         /*��������*/         \n");
						sql.append( "   RTRIM(C.CDNAM)      SATCODE1,       /*�����ڵ��*/       \n");
						sql.append( "	COALESCE(A.REALBGT,0)-COALESCE(A.RESULTS,0)-COALESCE(A.BRESULTS,0)  RESULTS1  /*�ܾ�*/  \n");
						sql.append( " FROM ACCOUNT.BGTDTL A   /*��ûDTL1*/									  	\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE      \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.SATCODE = C.CDCODE AND A.FSREFCD = C.CMTYPE	\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																			\n");
						if(!str[0].equals(""))
							sql.append( " AND A.FDCODE  = '"+str[0]+"'				\n");	//�����ڵ�
						if(!str[1].equals(""))
							sql.append( " AND A.BGTYY = '"+str[1]+"'				\n");	//����⵵
						if(!str[2].equals(""))
							sql.append( " AND A.BGTDPT = '"+str[2]+"'				\n");	//����μ�
						if(!str[3].equals(""))
							sql.append( " AND B.ATKORNAM  LIKE '%"+str[3]+"%'		\n");	//������
						if(!str[4].equals(""))
							sql.append( " AND A.ATCODE = '"+str[4]+"'				\n");	//��������
						if(!str[5].equals(""))
							sql.append( " AND A.BGTMM  = '"+str[5]+"'				\n");	//�����

/*********************************************************************************************/
					//logger.dbg.println(this,sql.toString());
                    //System.out.println(sql.toString());   
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