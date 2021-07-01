package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class tr00104_edi_2 extends HttpServlet {
 
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
        String [] str = new String[7];

				str[0] = GauceReq.getParameter("v_str0");   //������Ʈ ����
				str[1] = GauceReq.getParameter("v_str1");   //1.�ֹ�����, 2.��������
				str[2] = GauceReq.getParameter("v_str2");   //��������
				str[3] = GauceReq.getParameter("v_str3");   //���ۿ��� EDI_STS --''^��ü,'N'^������,S^������,Y^���ۿϷ�,A^������
				str[4] = GauceReq.getParameter("v_str4");   //�����Ա���
        //str[5] = GauceReq.getParameter("v_str5");   //�ֹ����� ING_STS
				//str[6] = GauceReq.getParameter("v_str6");   //�������� ING_STS2

				for (int s=0;s<=5;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"CHK",       "INGGB",      "EDI_STS",    "ING_STS", "ETD_DT",
					                                "ORDER_NO",  "CAR_SEQ_NO", "CARGO_TYPE", "CARGONM", "CUST_CD",
					                                "CUSTNM",    "SHIPPER",    "SHIPPERNM",  "LDCARGO", "LDCARGONM",
					                                "OFFCARGO",  "OFFCARGONM", "ARTC_CD",    "ARTC_NM", "ORDER_SEQ" ,
					                                "HL_EDI_STS", "ING_STS2",  "ING_STS3",   "ING_STS4" 
																				}; 

				int[] intArrCN = new int[] {	1, 30,  1,   1,   8,
					                           12, 12,  4,  30,  13, 
				                             50, 13, 50,  10, 100,
					                           10,100, 10, 100,   4,
					                            1,  1,  1,   1
																		}; 
			
				int[] intArrCN2 = new int[]{	0,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,  -1,
																		 -1,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1 
																		};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				//�ֹ���������
        if(str[1].equals("1")){

            sql.append(" SELECT 0 CHK, '�ֹ�����' INGGB,                                          \n")		 
 						   .append("        CASE WHEN IFNULL(Z.EDI_STS,'')='' THEN IFNULL(D.EDI_STS,'N')      \n")		 
							 .append("             ELSE IFNULL(Z.EDI_STS,'')    END EDI_STS,                    \n")		 
							 .append("        A.ING_STS,  D.ETD_DT, D.ORDER_NO, C.CAR_SEQ_NO,                   \n")		 
						   .append("        CASE WHEN C.ORDER_NO IS NULL OR RTRIM(C.ORDER_NO) = '' THEN '0002'\n")
							 .append("        		 ELSE RTRIM(A.CARGO_TYPE)                                     \n")
							 .append("        END CARGO_TYPE,                                                   \n")
							 .append("        '' AS CARGONM,	                                                  \n")
               .append("        A.CUST_CD,V.VEND_NM AS CUSTNM, A.SHIPPER, W.VEND_NM AS SHIPPERNM, \n")		 
							 .append("        D.LDCARGO,D.LDCARGONM,D.OFFCARGO,D.OFFCARGONM,                    \n")
							 .append("        D.ARTC_CD,D.ARTC_NM, D.ORDER_SEQ, Z.HL_EDI_STS, \n")		 
               .append("        D.ING_STS AS ING_STS2, C.ING_STS AS ING_STS3,B.ING_STS AS ING_STS4 \n")		 
							 .append("   FROM TRANSFER.LTORDERMST A, TRANSFER.LTORDERDTL D,                     \n")		 
							 .append("        TRANSFER.LTORDCAR C, TRANSFER.LTCARGOODS B,                       \n")		 
							 .append("        ACCOUNT.GCZM_VENDER V, ACCOUNT.GCZM_VENDER W                      \n")		 
  						 .append("        LEFT JOIN HDASAN_EDI.ETORDERMST Z ON Z.ORDER_NO = A.ORDER_NO      \n")		 
							 .append("  WHERE D.ORDER_NO = A.ORDER_NO                                           \n")		 
               .append("    AND B.CAR_SEQ_NO = C.CAR_SEQ_NO                                       \n")		 
							 .append("    AND B.ORDER_NO = D.ORDER_NO                                           \n")		 
               .append("    AND B.ORDER_SEQ = D.ORDER_SEQ                                         \n")		 
							 .append("    AND A.CUST_CD = V.VEND_CD                                             \n")		 
               .append("    AND A.SHIPPER = W.VEND_CD                                             \n")		 
               .append("    AND D.ORDER_STS = '0002'                                              \n")	
						   .append("    AND (A.ING_STS IS NULL OR C.ING_STS IS NULL OR (A.ING_STS<>'C' OR C.ING_STS<>'C')) \n");		 

						if(!str[0].equals("")) sql.append (" AND A.LINE_PART = '" +str[0] + "' \n");  
						if(!str[2].equals("")) sql.append (" AND A.ETD_DT = '" +str[2] + "'  \n");  

						if(str[3].equals("N")) sql.append (" AND (D.EDI_STS = '' OR D.EDI_STS IS NULL OR D.EDI_STS='N')   \n");  
						else if(!str[3].equals("")) sql.append (" AND Z.EDI_STS = '" +str[3] + "' \n");  
           // else if(str[3].equals("")) sql.append (" AND (IFNULL(D.EDI_STS,'') <> 'S' AND IFNULL(D.EDI_STS,'') <> 'R') \n"); 
						
						if(!str[4].equals("")) sql.append (" AND A.IN_OUT = '" +str[4] + "' \n");  
					  //if(!str[5].equals("")) sql.append (" AND D.ING_STS='"+str[5]+"' \n");  
						//if(!str[5].equals("")) sql.append (" AND A.ING_STS='"+str[5]+"' \n");  
						//if(!str[6].equals("")) sql.append (" AND C.ING_STS='"+str[6]+"' \n");  
            sql.append("  ORDER BY D.ORDER_NO, D.ORDER_SEQ, C.CAR_SEQ_NO                                        	\n");		 
						/**
            sql.append(" SELECT 0 CHK, '�ֹ�����' INGGB,  IFNULL(D.EDI_STS,'N')EDI_STS,  D.ING_STS,  D.ETD_DT,  	\n")		 
							 .append("        D.ORDER_NO, C.CAR_SEQ_NO,                                                       	\n")		 
						   .append("        CASE WHEN C.ORDER_NO IS NULL OR RTRIM(C.ORDER_NO) = '' THEN '0002'              	\n")
							 .append("        		 ELSE RTRIM(A.CARGO_TYPE)                                     	              \n")
							 .append("        END CARGO_TYPE,                                                    	              \n")
							 .append("        '' AS CARGONM,	                                                                  \n")
               .append("        A.CUST_CD,V.VEND_NM AS CUSTNM, A.SHIPPER, W.VEND_NM AS SHIPPERNM,                	\n")		 
							 .append("        D.LDCARGO,D.LDCARGONM,D.OFFCARGO,D.OFFCARGONM,                                   	\n")
							 .append("        D.ARTC_CD,D.ARTC_NM, D.ORDER_SEQ,Z.HL_EDI_STS                                    	\n")		 
							 .append("   FROM TRANSFER.LTORDERMST A, TRANSFER.LTORDERDTL D,                                    	\n")		 
							 .append("        TRANSFER.LTORDCAR C, TRANSFER.LTCARGOODS B,                                      	\n")		 
							 .append("        ACCOUNT.GCZM_VENDER V, ACCOUNT.GCZM_VENDER W                                     	\n")		 
  						 .append("        LEFT JOIN HDASAN_EDI.ETORDERMST Z ON Z.ORDER_NO = A.ORDER_NO                     	\n")		 
							 .append("  WHERE D.ORDER_NO = A.ORDER_NO                                                          	\n")		 
               .append("    AND B.CAR_SEQ_NO = C.CAR_SEQ_NO                                                      	\n")		 
							 .append("    AND B.ORDER_NO = D.ORDER_NO                                                          	\n")		 
               .append("    AND B.ORDER_SEQ = D.ORDER_SEQ                                                        	\n")		 
							 .append("    AND A.CUST_CD = V.VEND_CD                                                            	\n")		 
               .append("    AND A.SHIPPER = W.VEND_CD                                                            	\n")		 
               .append("    AND D.ORDER_STS = '0002'                                                             	\n");		 

						//.append("    AND (D.EDI_STS = '' OR D.EDI_STS IS NULL OR D.EDI_STS='N')                          	\n");		 
						if(!str[0].equals("")) sql.append (" AND A.LINE_PART = '" +str[0] + "' \n");  
						if(!str[2].equals("")) sql.append (" AND A.ETD_DT = '" +str[2] + "'  \n");  

						if(str[3].equals("N")) sql.append (" AND (D.EDI_STS = '' OR D.EDI_STS IS NULL OR D.EDI_STS='N')   \n");  
						else if(!str[3].equals("")) sql.append (" AND D.EDI_STS = '" +str[3] + "' \n");  
           // else if(str[3].equals("")) sql.append (" AND (IFNULL(D.EDI_STS,'') <> 'S' AND IFNULL(D.EDI_STS,'') <> 'R') \n"); 
						
						if(!str[4].equals("")) sql.append (" AND A.IN_OUT = '" +str[4] + "' \n");  
					  if(!str[5].equals("")) sql.append (" AND D.ING_STS='"+str[5]+"' \n");  
						**/
				}

        logger.dbg.println(this, ":::"+sql.toString());

				stmt = conn.getGauceStatement(sql.toString());
 				stmt.executeQuery(dSet);
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
				GauceRes.writeException("Sql",":",e.toString());
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