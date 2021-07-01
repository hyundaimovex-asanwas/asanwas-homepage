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
public class staxbill_popup_s2 extends HttpServlet {
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
				//������������ ���ǰ��� �Ѱܹ���
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//������ȣ(=��꼭��ȣ)
				str[2] = req.getParameter("v_str3");	//ȸ�豸��

				for(int i=0;i<=2;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);
	
	
				String[] strArrCN = new String[]{ 
					"TAXNBR","COCODE","DEPTCD","EMPNO","TAXIODIV",
					"TAXDIV","TAXKND","VEND_CD","TAXDAT","TAXSUM",
					"TAXVATAMT","TAXTOT","REMARK","TAXCDNBR",
					"ATCODE", "TAXPRTYN","TAXCNT",
					"LASTPRT","TAXTYPE","FSDAT","FSNBR", "TAXKIDIV",
					"WRDT","WRID","UPDT","UPID","FDCODE",
					"WORKTYPE",
					"ATKORNAM","ATDECR",
					"VD_DIRECT","BSNS_CND","BSNS_KND","VEND_ID","VEND_NM",
					"TAXKNDNM","TAXDIVNM","FSSTAT", "TAXNBR_R", "EMPNMK",
					"DEPTCD", "DEPTNM" 
				}; 

				int[] intArrCN = new int[] { 
					11,   2,   4,   7,   1,   
					 4,   1,   4,   8,  15,
					13,  15, 132,  16,
					 7,   1,   3,  
					 8,   1,   9,   6,   1,
					 8,	  7,   8,   7,   2,   
					 1,	 
					66,   1,  
					62,  62,  62,  15,  62,
					40,  40,   1,  12,  30,
					 4,  30 

				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,   0,	
					 0,   0,  -1,  -1,  
					-1,  -1,   0,   
					-1,	 -1,  -1,  -1,  -1,  
					-1,  -1,  -1,  -1,  -1,			
					-1,  
					-1,  -1,  
					-1,  -1,  -1,  -1, -1,
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
						sql.append( " SELECT                                               	\n");	
						sql.append( " RTRIM(X.TAXNBR) TAXNBR, X.COCODE, X.DEPTCD,X.EMPNO,X.TAXIODIV,   	\n");
						sql.append( " X.TAXDIV,X.TAXKND,RTRIM(X.VEND_CD) VEND_CD,X.TAXDAT,COALESCE(X.TAXSUM,0) TAXSUM,   	\n");
						sql.append( " COALESCE(X.TAXVATAMT,0) TAXVATAMT, COALESCE(X.TAXTOT,0) TAXTOT, RTRIM(X.REMARK) REMARK, RTRIM(X.TAXCDNBR) TAXCDNBR, \n");
						sql.append( " RTRIM(X.ATCODE) ATCODE, X.TAXPRTYN, COALESCE(X.TAXCNT,0) TAXCNT,    	\n");
						sql.append( " X.LASTPRT, X.TAXTYPE, X.FSDAT, X.FSNBR, X.TAXKIDIV,   	\n");
						sql.append( " X.WRDT, X.WRID, X.UPDT, X.UPID, X.FDCODE,      	\n");
						sql.append( " RTRIM(X.WORKTYPE) WORKTYPE   	\n");
						sql.append( " ,X.ATKORNAM, X.ATDECR      	\n");
						sql.append( " ,Z.VD_DIRECT, Z.BSNS_CND, Z.BSNS_KND, Z.VEND_ID,Z.VEND_NM,		\n");
						//sql.append( " --(RTRIM(Z.ADDRESS1) || ' ' || RTRIM(Z.ADDRESS2)) ADDNM,    	\n");
						sql.append( " RTRIM(Q.CDNAM) TAXKNDNM,  	\n");
						sql.append( " RTRIM(P.CDNAM) TAXDIVNM,   	\n");
						sql.append( " RTRIM(Y.FSSTAT) FSSTAT, RTRIM(SUBSTR(X.TAXNBR,2,11)) TAXNBR_R,     	\n");
						sql.append( " MAX(X.EMPNMK) EMPNMK, MAX(X.DEPTCD) DEPTCD, MAX(X.DEPTNM) DEPTNM     	\n");
						sql.append( " FROM         	\n");
						sql.append( " ( 	\n");

						sql.append( " SELECT     	\n");
						sql.append( " RTRIM(A.TAXNBR) TAXNBR, A.COCODE, A.DEPTCD,A.EMPNO,A.TAXIODIV,	     	\n");
						sql.append( " A.TAXDIV,A.TAXKND,RTRIM(A.VEND_CD) VEND_CD,A.TAXDAT,COALESCE(A.TAXSUM,0) TAXSUM,	   	\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT, COALESCE(A.TAXTOT,0) TAXTOT, RTRIM(A.REMARK) REMARK, RTRIM(A.TAXCDNBR) TAXCDNBR,  	\n");
						sql.append( " RTRIM(A.ATCODE) ATCODE, A.TAXPRTYN, COALESCE(A.TAXCNT,0) TAXCNT,   	\n");
						sql.append( " A.LASTPRT, A.TAXTYPE, A.FSDAT, A.FSNBR, A.TAXKIDIV,  	\n");
						sql.append( " A.WRDT, A.WRID, A.UPDT, A.UPID, A.FDCODE, RTRIM(A.WORKTYPE) WORKTYPE  	\n");
						sql.append( " ,RTRIM(F.ATKORNAM) ATKORNAM, RTRIM(F.ATDECR) ATDECR	\n");
						sql.append( " ,R.EMPNMK, L.DEPTNM    	\n");
						sql.append( " FROM ACCOUNT.ATTAXMST A, ACCOUNT.ACTCODE F         	\n");
						sql.append( " LEFT JOIN PAYROLL.HIPERSON R ON A.EMPNO=R.EMPNO   	\n");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT L ON L.DEPTCD=R.DEPTCD      	\n");
						sql.append( " WHERE A.TAXNBR <> '' AND A.ATCODE = F.ATCODE    	\n");
			if(!str[0].equals("")) sql.append( " AND A.FDCODE = '"+str[0]+"'			\n");
			if(!str[1].equals("")) sql.append( " AND A.TAXNBR LIKE '"+str[1]+"%'	\n");
			if(!str[2].equals("")) sql.append( " AND A.WORKTYPE = '"+str[2]+"'	\n");


						sql.append( " UNION ALL     	\n");
						sql.append( " SELECT     	\n");
						sql.append( " RTRIM(A.TAXNBR) TAXNBR, A.COCODE, A.DEPTCD,A.EMPNO,A.TAXIODIV,	     	\n");
						sql.append( " A.TAXDIV,A.TAXKND,RTRIM(A.VEND_CD) VEND_CD,A.TAXDAT,COALESCE(A.TAXSUM,0) TAXSUM,	   	\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT, COALESCE(A.TAXTOT,0) TAXTOT, RTRIM(A.REMARK) REMARK, RTRIM(A.TAXCDNBR) TAXCDNBR,  	\n");
						sql.append( " RTRIM(A.ATCODE) ATCODE, A.TAXPRTYN, COALESCE(A.TAXCNT,0) TAXCNT,   	\n");
						sql.append( " A.LASTPRT, A.TAXTYPE, A.FSDAT, A.FSNBR, A.TAXKIDIV,  	\n");
						sql.append( " A.WRDT, A.WRID, A.UPDT, A.UPID, A.FDCODE, RTRIM(A.WORKTYPE) WORKTYPE  	\n");
						sql.append( " ,RTRIM(F.ATKORNAM) ATKORNAM, RTRIM(F.ATDECR) ATDECR	\n");
						sql.append( " ,R.EMPNMK, L.DEPTNM    	\n");
						sql.append( " FROM ACCOUNT.ATTAXMST A, ACCOUNT.ACTCODE F         	\n");
						sql.append( " LEFT JOIN PAYROLL.T_HIPERSON R ON A.EMPNO=R.EMPNO  	\n");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT L ON L.DEPTCD=R.DEPTCD      	\n");
						sql.append( " WHERE A.TAXNBR <> '' AND A.ATCODE = F.ATCODE    	\n");
			if(!str[0].equals("")) sql.append( " AND A.FDCODE = '"+str[0]+"'			\n");
			if(!str[1].equals("")) sql.append( " AND A.TAXNBR LIKE '"+str[1]+"%'	\n");
			if(!str[2].equals("")) sql.append( " AND A.WORKTYPE = '"+str[2]+"'	\n");

						sql.append( " ORDER BY FDCODE,TAXNBR   	\n");
						sql.append( " ) X      	\n");

						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER Z ON X.VEND_CD=Z.VEND_CD        	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL Q ON X.TAXKND=Q.CDCODE AND Q.CMTYPE ='0013'  \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL P ON X.TAXDIV=P.CDCODE AND P.CMTYPE ='0014'  \n");
						//sql.append( " --LEFT JOIN ACCOUNT.CARDCODE E ON A.TAXCDNBR=E.CANBR				  	  \n");
						sql.append( " LEFT JOIN ACCOUNT.FSLIPMST Y ON X.FDCODE=Y.FDCODE AND X.FSDAT=Y.FSDAT AND X.FSNBR=Y.FSNBR	 \n");
						sql.append( " GROUP BY		\n");


						sql.append( " X.TAXNBR, X.COCODE, X.DEPTCD,X.EMPNO,X.TAXIODIV,	\n");
						sql.append( " X.TAXDIV,X.TAXKND, X.VEND_CD,X.TAXDAT, X.TAXSUM,	\n");
						sql.append( " X.TAXVATAMT, X.TAXTOT, X.REMARK, X.TAXCDNBR, X.ATCODE,	\n");
						sql.append( " X.TAXPRTYN, X.TAXCNT,		\n");
						sql.append( " X.LASTPRT, X.TAXTYPE, X.FSDAT, X.FSNBR, X.TAXKIDIV,		\n");
						sql.append( " X.WRDT, X.WRID, X.UPDT, X.UPID, X.FDCODE, X.WORKTYPE		\n");
						sql.append( " ,X.ATKORNAM, X.ATDECR 		\n");	
						sql.append( " ,Z.VD_DIRECT, Z.BSNS_CND, Z.BSNS_KND, Z.VEND_ID,Z.VEND_NM,		\n");	
						sql.append( " Q.CDNAM, P.CDNAM,		\n");	
						sql.append( " Y.FSSTAT		\n");	
						
/*						if(!str[0].equals("")) sql.append( " AND A.FDCODE = '"+str[0]+"'			\n");
						if(!str[1].equals("")) sql.append( " AND A.TAXNBR LIKE '"+str[1]+"%'	\n");
						if(!str[2].equals("")) sql.append( " AND A.WORKTYPE = '"+str[2]+"'	\n");
*/
//						sql.append( " ORDER BY FDCODE,TAXNBR	\n");


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