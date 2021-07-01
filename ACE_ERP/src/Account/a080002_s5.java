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
public class a080002_s5 extends HttpServlet {
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
				str[2] = req.getParameter("v_str3");	//��û�μ�
				str[3] = req.getParameter("v_str4");	//��û����
				str[4] = req.getParameter("v_str5");	//�����

				for(int i=0;i<=4;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"BGTMM","ATCODE","ATKORNAM","SATNM","APPROVAL"
				}; 

				int[] intArrCN = new int[] { 
					 2,   7,  66,  40,   1
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1   
				}; 

				String arrmm01 = "";
				int cnt = str[4].length();
				cnt = cnt - 1;
				int cnt2 = cnt - 2;

				for(int i=0;i<=cnt;i++) {
					int aa = i + 1;
					if (str[4].substring(i,aa).equals(";") && i<=cnt2) {
						arrmm01 = arrmm01+"','";
					}else if(i==cnt){
						arrmm01 = arrmm01+"'";
					}else{
						if(i==0) {
							arrmm01 = "'"+arrmm01 + str[4].substring(i,aa);
						}else{
							if (str[4].substring(i,aa).equals(";")){
								arrmm01 = arrmm01 + "'";
							}else{
								arrmm01 = arrmm01 + str[4].substring(i,aa);
							}
						}
					}
				}

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT X.BGTMM BGTMM,X.ATCODE ATCODE,X.ATKORNAM ATKORNAM,X.CDNAM SATNM,X.APPROVAL		\n");	
						sql.append( " FROM (SELECT A.BGTMM,RTRIM(A.ATCODE) ATCODE, RTRIM(F.ATKORNAM) ATKORNAM,            	\n");
						sql.append( " RTRIM(S.CDNAM) CDNAM,A.APPROVAL APPROVAL  /*�����*/													\n");
						sql.append( " FROM ACCOUNT.BGTDTL A                                          															\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE = F.ATCODE														\n");

						sql.append( " LEFT JOIN ACCOUNT.BGTMST C ON A.FDCODE=C.FDCODE AND A.BGTYY=C.BGTYY /*�������MST*/	\n");
						sql.append( "       AND A.BGTDIV=C.BGTDIV   AND A.BGTDPT=C.BGTDPT  AND A.ATCODE=C.ATCODE          \n");
						sql.append( "       AND A.FSREFCD=C.FSREFCD AND A.SATCODE=C.SATCODE                              	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL S ON A.SATCODE=S.CDCODE AND A.FSREFCD=S.CMTYPE /*����*/ 	\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL	 AND A.APPROVAL ='Y'								\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'						\n");	//�����ڵ�
						if(!str[1].equals("")) sql.append( " AND A.BGTYY   = '"+str[1]+"'						\n");	//����⵵
						if(!str[2].equals("")) sql.append( " AND A.BGTDPT  = '"+str[2]+"'						\n");	//����μ�
						if(!str[3].equals("")) sql.append( " AND A.BGTDIV  = '"+str[3]+"'						\n");	//���꺻��
						if(!str[4].equals("")) sql.append( " AND A.BGTMM IN ("+arrmm01+")					\n");	//�����
						sql.append( " GROUP BY A.BGTMM,A.ATCODE,F.ATKORNAM,S.CDNAM,A.APPROVAL		  				\n");	
						sql.append( ") X																													\n");	
						sql.append( " GROUP BY X.BGTMM,X.ATCODE,X.ATKORNAM,X.CDNAM,X.APPROVAL						\n");	
						sql.append( " ORDER BY BGTMM,ATKORNAM																			\n");

						
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