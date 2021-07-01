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
public class a041010_s1 extends HttpServlet {
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
				
				String []  str	= new String [22];
				str[0] = req.getParameter("v_str1");	//��꼭����
				str[1] = req.getParameter("v_str2");	//�����
				str[2] = req.getParameter("v_str3");	//��꼭�Ⱓ from
				str[3] = req.getParameter("v_str4");	//��꼭�Ⱓ to
				str[4] = req.getParameter("v_str5");	//�ŷ�ó�ڵ�
				str[5] = req.getParameter("v_str6");	//�ͼӱ���
				str[6] = req.getParameter("v_str7");	//�ΰ�������
				str[7] = req.getParameter("v_str8");	//���࿩��
				str[8] = req.getParameter("v_str9");	//��ǥ����
				str[9] = req.getParameter("v_str10");	//�ŷ�ó��
				str[10] = req.getParameter("v_str11");	//�����ڵ�
				str[11] = req.getParameter("v_str12");	//����ںμ�
				str[12] = req.getParameter("v_str13");	//�α��ξ��̵� üũ
				str[13] = req.getParameter("v_str14");	//���а�

				str[14] = req.getParameter("v_str15");	//���
				str[15] = req.getParameter("v_str16");	//�μ�
				str[16] = req.getParameter("v_str17");	//�����ڵ�
				str[17] = req.getParameter("v_str18");	//�����ڵ�
				str[18] = req.getParameter("v_str19");	//�ۼ��� ��� 
				str[19] = req.getParameter("v_str20");	//�����ڵ� 
				str[20] = req.getParameter("v_str21");	//eBill���� 
				str[21] = req.getParameter("v_str22");	//eBill����
				
				for (int s=0;s<=21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK","TAXNBR","COCODE","TAXIODIV","TAXDIV","TAXIODIVNM","TAXDIVNM",
					"TAXKND","TAXKNDNM","VEND_CD","VEND_NM","VEND_ID","TAXDAT",
					"TAXSUM","TAXVATAMT","TAXTOT","REMARK","TAXCDNBR",
					"TAXPRTYN","FSDAT","FSNBR","FSNUM","TAXCNT","TAXKIDIV",
					"VD_DIRECT","BSNS_CND","BSNS_KND","COID","COSANG","ADDNM","ADDNM2",
					"FSSTAT",	"FDCODE","DEPTCD","DEPTNM","TREECD",
					"EMPNO","EMPNMK","ATCODE","ATKORNAM","TAXNBR_R", "GBCD", "FDNAME",
                    "DTI_STATUS", "RETURN_CODE", "RETURN_DESCRIPTION", "SBDESCRIPTION",
                    "GUBUN","AMEND_CODE","AMEND_REMARK", "EXTCHK", "CREATION_DATE",
                    "CONVERSATION_ID","SUPBUY_TYPE","DIRECTION", "COSTCD", "COSTNM", 
                    "VEND_ID_LEN", "DUEDATE", "TAXSTS", "WRDT", "UPDT",
                    "SEQ",       "SB_REASON", "HIS_TAXSTS", "REAL_FILE",  "SYS_FILE", "REAL_FILE2",  "SYS_FILE2"
                    
				}; 			

				int[] intArrCN = new int[] { 
					 1,  11,   2,   1,   4,  10, 40,
					 1,  40,  13,  60,  15,   8,
					15,  13,  15,  132,  16,
					 1,   9,   6,  15,   3,   1,
					12,  22,  22,  10,  66, 144,144,
					 1,   2,	 4,  50,   8,
					 7,  20,   7,  66,  11,  3, 20,
                    1,  5,   2000, 70,  1,  2, 100, 1, 20,
                    35, 2, 1,  6, 100,  
                    2,  8,  1, 8 , 8,
                    2, 100, 1, 50, 30 , 50, 30 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,  -1,
					 0,   0,   0,  -1,  -1,
					-1,  -1,  -1,  -1,   0,  -1,
					-1,  -1,  -1,  -1,  -1,  -1,-1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,  -1, -1,
					-1,  -1,  -1,  -1,  -1,  -1, -1, -1, -1,
					-1,  -1,  -1,  -1,  -1,   
					 0,  -1,  -1,  -1,  -1,
					 0,  -1,  -1,  -1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT																		\n");	
						sql.append( " 'F' AS CHK,											/*����*/					\n");
						sql.append( " RTRIM(A.TAXNBR) TAXNBR,								/*��꼭��ȣ*/				\n");
						sql.append( " A.COCODE,												/*������ڵ�*/				\n");
						sql.append( " A.TAXIODIV,											/*��꼭����*/				\n");
						sql.append( " A.TAXDIV,												/*�ͼӱ���*/				\n");
						sql.append( " CASE WHEN A.TAXIODIV ='A' THEN '����'	                /*���и�*/	            \n");
						sql.append( "      WHEN A.TAXIODIV ='B' THEN '����'					        	           	\n");
						sql.append( " END AS TAXIODIVNM,															\n");
						sql.append( " RTRIM(D.CDNAM) TAXDIVNM,							    /*�ͼӸ�*/				\n");
						sql.append( " A.TAXKND,												/*�ΰ�������*/				\n");
						sql.append( " RTRIM(C.CDNAM) TAXKNDNM,							    /*������*/				\n");
						sql.append( " RTRIM(A.VEND_CD) VEND_CD,							    /*�ŷ�ó�ڵ�*/				\n");
						sql.append( " RTRIM(B.VEND_NM) VEND_NM,							    /*�ŷ�ó��*/				\n");
						sql.append( " RTRIM(B.VEND_ID) VEND_ID,							    /*�ŷ�ó�����NO*/		    \n");
						sql.append( " A.TAXDAT,												/*��꼭����*/				\n");
						sql.append( " COALESCE(A.TAXSUM,0) TAXSUM,					        /*���ް���*/				\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT,		            /*�ΰ�����*/				\n");
						sql.append( " COALESCE(A.TAXTOT,0) TAXTOT,					        /*�հ�ݾ�*/				\n");
						sql.append( " RTRIM(A.REMARK) REMARK,								/*����*/					\n");
						sql.append( " RTRIM(A.TAXCDNBR) TAXCDNBR,						    /*�ſ�ī���ȣ*/			\n");
						sql.append( " A.TAXPRTYN,											/*���౸��*/				\n");
						sql.append( " A.FSDAT,												/*��ǥ����*/				\n");
						sql.append( " A.FSNBR,												/*��ǥ��ȣ*/				\n");
						sql.append( " G.SSDAT || G.SSNBR AS FSNUM,					        /*��ǥ��ȣ*/				\n");
						sql.append( " COALESCE(A.TAXCNT,0) TAXCNT,					        /*����Ƚ��*/				\n");
						sql.append( " A.TAXKIDIV,											/*���*/					\n");
						sql.append( " B.VD_DIRECT,											/*��ǥ��*/				\n");
						sql.append( " B.BSNS_CND,											/*����*/					\n");
						sql.append( " B.BSNS_KND,											/*����*/					\n");
						sql.append( " F.COID,												/*����ڹ�ȣ*/				\n");
						sql.append( " RTRIM(F.COSANG) COSANG,								/*��ȣ*/					\n");
						sql.append( " RTRIM(B.ADDRESS1)ADDNM,  RTRIM(B.ADDRESS2) ADDNM2,			             	\n");
						sql.append( " RTRIM(G.FSSTAT) FSSTAT,														\n");
						sql.append( " RTRIM(A.FDCODE) FDCODE,														\n");
						sql.append( " RTRIM(A.DEPTCD) DEPTCD,														\n");
						sql.append( " RTRIM(H.DEPTNM) DEPTNM,														\n");
						sql.append( " SUBSTR(H.TREECD,1,4) || '0000' AS TREECD,             /*����*/	   	            \n");
						sql.append( " RTRIM(A.EMPNO)  EMPNO,														\n");
                        sql.append( " RTRIM(Y.EMPNMK) EMPNMK,														\n");
						sql.append( " RTRIM(A.ATCODE) ATCODE,								/*�����ڵ�*/  			\n");
						sql.append( " RTRIM(K.ATKORNAM) ATKORNAM,						    /*������*/				\n");
						sql.append( " RTRIM(SUBSTR(A.TAXNBR,2,11)) TAXNBR_R,										\n");
						sql.append( " RTRIM(C.GBCD) GBCD, RTRIM(L.FDNAME) FDNAME,									\n");           
						sql.append( " X.DTI_STATUS,  X.RETURN_CODE, X.RETURN_DESCRIPTION, X.SBDESCRIPTION,          \n");
						sql.append( " A.GUBUN, A.AMEND_CODE, A.AMEND_REMARK, A.EXTCHK , Z.CREATION_DATE, 	        \n");
						sql.append( " A.CONVERSATION_ID, A.SUPBUY_TYPE, A.DIRECTION , A.COSTCD, K.CDNAM COSTNM ,    \n");
						sql.append( " LENGTH(B.VEND_ID) VEND_ID_LEN, A.DUEDATE, A.TAXSTS, A.WRDT, A.UPDT,           \n");
						sql.append( " XX.SEQ, XX.SB_REASON, XX.HIS_TAXSTS, A.REAL_FILE, A.SYS_FILE,A.REAL_FILE2, A.SYS_FILE2        \n");
						sql.append( " FROM ACCOUNT.ATTAXMST A																		\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE K ON A.ATCODE = K.ATCODE /*���ݰ�꼭MST*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD=B.VEND_CD /*�ŷ�ó�ڵ�*/	\n");
						if(str[0].equals("A")){
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.TAXKND=C.CDCODE AND C.CMTYPE ='0013' /*����-�ΰ�������*/ \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.TAXDIV=D.CDCODE AND D.CMTYPE ='0014' /*����-�ͼӱ���*/	 \n");
						}else if(str[0].equals("B")){
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.TAXKND=C.CDCODE AND C.CMTYPE ='0009' /*����-�ΰ�������*/ \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.TAXDIV=D.CDCODE AND D.CMTYPE ='1215' /*����-�ͼӱ���*/	 \n");
						}
						sql.append( " LEFT JOIN ACCOUNT.CARDCODE E ON A.TAXCDNBR=E.CANBR    /*ī�����*/		\n");
						sql.append( " LEFT JOIN ACCOUNT.COMPANY  F ON A.COCODE=F.COCODE				        \n");
						sql.append( " LEFT JOIN ACCOUNT.FSLIPMST G ON A.FDCODE=G.FDCODE AND A.FSDAT=G.FSDAT AND A.FSNBR=G.FSNBR		\n");	
						sql.append( " LEFT JOIN PAYROLL.HCDEPT   H ON A.DEPTCD=H.DEPTCD				        \n");	
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL J ON A.DEPTCD=J.CDCODE AND J.CMTYPE='2139' \n");
						sql.append( " LEFT JOIN PAYROLL.YIPERSON Y ON A.EMPNO=Y.EMPNO   \n");
						sql.append( " LEFT JOIN ACCOUNT.FIELDCODE L ON L.FDCODE=A.FDCODE   \n");
						sql.append( " LEFT JOIN HDASAN_EDI.XXSB_DTI_STATUS X ON A.CONVERSATION_ID = X.CONVERSATION_ID    \n");
						sql.append( " 										AND A.SUPBUY_TYPE = X.SUPBUY_TYPE            \n");
						sql.append( "                                       AND A.DIRECTION = X.DIRECTION                \n");
						sql.append( " LEFT JOIN HDASAN_EDI.XXSB_DTI_MAIN Z ON A.CONVERSATION_ID = Z.CONVERSATION_ID      \n");
						sql.append( " 									    AND A.SUPBUY_TYPE = Z.SUPBUY_TYPE            \n");
						sql.append( "                                       AND A.DIRECTION = Z.DIRECTION                \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL K ON A.COSTCD=K.CDCODE AND K.CMTYPE ='0030' /*����*/	 \n");
						sql.append( " LEFT JOIN ( SELECT TAXNBR, SEQ, SB_REASON , TAXSTS AS HIS_TAXSTS              	 \n");
						sql.append( " 	            FROM ACCOUNT.ATTAXHIS X1                                             \n");
						sql.append( " 	           WHERE SEQ = ( SELECT MAX(SEQ) FROM ACCOUNT.ATTAXHIS  WHERE X1.TAXNBR = TAXNBR ) \n");
						sql.append( " 	        ) XX ON XX.TAXNBR = A.TAXNBR AND XX.HIS_TAXSTS = A.TAXSTS                \n");
						sql.append( " WHERE A.TAXNBR IS NOT NULL														 \n");
						sql.append( "    AND A.TAXNBR LIKE 'H%'														     \n");						
						if(!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.TAXIODIV = '"+str[0]+"'			 \n");
						if(!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.COCODE   = '"+str[1]+"'		     \n");
						if(!str[2].equals(""))  sql.append( " AND A.TAXDAT BETWEEN '"+str[2]+"' AND '"+str[3]+"' 	     \n");
						if(!str[4].equals(""))  sql.append( " AND A.VEND_CD  = '"+str[4]+"'								 \n");
						if(!str[5].equals(""))  sql.append( " AND A.TAXDIV   = '"+str[5]+"'								 \n");
						if(!str[6].equals(""))  sql.append( " AND A.TAXKND   IN ('"+str[6]+"')  						    \n");
						if(!str[7].equals(""))  sql.append( " AND A.TAXPRTYN = '"+str[7]+"'									\n");
						if(str[8].equals("X")){ sql.append( " AND ( G.FSSTAT  IN ( 'C','R','N','B') OR G.FSSTAT IS NULL )	\n");
						}else{
							if(!str[8].equals(""))  sql.append( " AND G.FSSTAT   = '"+str[8]+"'	\n");
						}
						if(!str[9].equals(""))  sql.append( " AND B.VEND_NM LIKE '"+str[9]+"%'	\n");
						if(!str[10].equals("")) sql.append( " AND A.FDCODE  = '"+str[10]+"'		\n");
						if(!str[16].equals("")) sql.append( " AND A.AMEND_CODE  = '"+str[16]+"'	\n");
						if(!str[17].equals("")) sql.append( " AND A.GUBUN  = '"+str[17]+"'		\n");
						
						if(!str[13].equals("")&&!str[13].equals("1")){
							//���ο��ʵ带 �߰��ؾ���. 
							if(str[14].equals("")&&str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' )	\n");
							if(!str[14].equals("")&&!str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' OR A.EMPNO IN ('"+str[14]+"') OR A.DEPTCD IN ('"+str[15]+"'))	\n");
							if(!str[14].equals("")&&str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' OR A.EMPNO IN ('"+str[14]+"')) 	\n");
							if(str[14].equals("")&&!str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' OR A.DEPTCD IN ('"+str[15]+"'))	\n");
						}						
						//if(!str[18].equals("")) sql.append( " AND A.EMPNO  IN ( '"+str[18]+"')			\n");
						if(!str[19].equals("")) sql.append( " AND A.COSTCD  = '"+str[19]+"'		    	\n");
						if(!str[20].equals("")) sql.append( " AND A.EBILLGB = '"+str[20]+"'		    	\n");
						if(!str[21].equals("")) sql.append( " AND A.TAXSTS  = '"+str[21]+"'		    	\n");

						sql.append( " ORDER BY G.SSDAT,G.SSNBR,A.TAXNBR									\n");
						
						System.out.println("# Query : \n" + sql.toString());
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