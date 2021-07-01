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
public class a020003_s2 extends HttpServlet {
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
			  
				String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//����
				str[1]	= req.getParameter("v_str2");		//��������
				str[2]	= req.getParameter("v_str3");		//������ȣ
				str[3]	= req.getParameter("v_str4");		//�������ȣ
				str[4]	= req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str6");		//�ŷ�ó
				str[6]	= req.getParameter("v_str7");		//�����׸�
				str[7]	= req.getParameter("v_str8");		//�����׸�

       
				for (int s=0;s<=7;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FSSTAT",    "FDCODE",     "BTSDAT",   "BTSNBR",	  
					                                "ATCODE",    "ATKORNAM",   "CHAAMT",   "DAEAMT",	"REMARK", 
					                                "FSREFVAL",  "VENDNM" ,    "SSDATNBR", "SSDAT",   "SSNBR",
                                          "FSNUM",     "FSREFVAL",   "FSREFNM"
				                                 }; 

				int[] intArrCN = new int[]{  1, 2, 9, 6,
					                           7,66, 15,15,132,
					                           20,32,16, 9,  6,
					                           3, 20, 40}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1, -1,
					                           -1, -1, 0, 0, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
/*					
					sql.append( "  SELECT B.FSSTAT, A.FDCODE, A.BTSDAT, A.BTSNBR, C.ATCODE, H.ATKORNAM,   \n" );
					sql.append( "         CASE WHEN C.ATDECR='1' THEN COALESCE(A.BJDEAMT,0)               \n" );
					sql.append( "              WHEN C.ATDECR='2' THEN 0 END CHAAMT,                       \n" );
					sql.append( "         CASE WHEN C.ATDECR='1' THEN 0                                   \n" );
					sql.append( "              WHEN C.ATDECR='2' THEN COALESCE(A.BJCRAMT,0) END DAEAMT,   \n" );
					sql.append( "         C.REMARK, D.FSREFVAL, G.VEND_NM VENDNM,                         \n" );
					sql.append( "         B.SSDAT||'-'||B.SSNBR  AS SSDATNBR ,                            \n" );
					sql.append( "         B.SSDAT, B.SSNBR, C.FSNUM,                                      \n" );
					if(!str[6].equals("")){
						sql.append( "  CASE WHEN B2.FSREFCD='"+str[6]+"' THEN B2.FSREFVAL END FSREFVAL, E.CDNAM FSREFNM \n" );
					}else{
						sql.append( "  '' FSREFVAL, '' FSREFNM \n" );
					}
					sql.append( "    FROM ACCOUNT.BANJAEREL A, ACCOUNT.FSLIPMST B,                    \n" );
					sql.append( "         ACCOUNT.FSLIPDTL C,  ACCOUNT.FSLIPREF D                     \n" );
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER G ON D.FSREFVAL = G.VEND_CD        \n" );
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE H ON C.ATCODE = H.ATCODE               \n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPREF B2 ON A.FDCODE= B2.FDCODE         \n" );
					sql.append( "                                      AND A.BTSDAT = B2.FSDAT    \n" ); 
					sql.append( "                                      AND A.BTSNBR = B2.FSNBR    \n" );
					sql.append( "                                      AND A.BTSSEQ = B2.FSSEQ    \n" ); 
					if(!str[6].equals(""))sql.append( "                          AND B2.FSREFCD ='"+str[6]+"' \n" );
					if(!str[0].equals(""))sql.append( "                          AND A.FDCODE = '"+str[0]+"'  \n" ); 
					if(!str[1].equals(""))sql.append( "                          AND A.TSDAT ='"+str[1]+"' \n" );
					if(!str[2].equals(""))sql.append( "                          AND A.TSNBR ='"+str[2]+"' \n" ); 
					if(!str[3].equals(""))sql.append( "                          AND A.TSSEQ ='"+str[3]+"' \n" ); 
          			sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL E ON B2.FSREFVAL = E.CDCODE AND E.CMTYPE='"+str[6]+"'    \n" );
					sql.append( "   WHERE A.FDCODE = B.FDCODE                                         \n" );
					sql.append( "     AND A.BTSDAT= B.FSDAT                                           \n" );
					sql.append( "     AND A.BTSNBR = B.FSNBR                                          \n" );
					sql.append( "     AND A.FDCODE = C.FDCODE                                         \n" );
					sql.append( "     AND A.BTSDAT= C.FSDAT                                           \n" );
					sql.append( "     AND A.BTSNBR = C.FSNBR                                          \n" );
					sql.append( "     AND A.BTSSEQ = C.FSSEQ                                          \n" );
					sql.append( "     AND A.FDCODE = D.FDCODE                                         \n" );
					sql.append( "     AND A.BTSDAT= D.FSDAT                                           \n" );
					sql.append( "     AND A.BTSNBR = D.FSNBR                                          \n" );
					sql.append( "     AND A.BTSSEQ = D.FSSEQ                                          \n" );
					sql.append( "     AND D.FSREFCD ='0020'                                           \n" );
					
					if(!str[0].equals(""))sql.append( "     AND A.FDCODE ='"+str[0]+"'                \n" );
					if(!str[1].equals(""))sql.append( "     AND A.TSDAT ='"+str[1]+"'                 \n" );
					if(!str[2].equals(""))sql.append( "     AND A.TSNBR ='"+str[2]+"'                 \n" );
					if(!str[3].equals(""))sql.append( "     AND A.TSSEQ ='"+str[3]+"'                 \n" );
					if(!str[4].equals(""))sql.append( "     AND C.ATCODE ='"+str[4]+"'                \n" );
					if(!str[5].equals(""))sql.append( "     AND ( D.FSREFCD ='0020' AND D.FSREFVAL ='"+str[5]+"') \n" );
*/
					
					
					sql.append( "  SELECT B.FSSTAT, A.FDCODE, A.BTSDAT, A.BTSNBR, C.ATCODE, H.ATKORNAM,   \n" );
					sql.append( "         CASE WHEN C.ATDECR='1' THEN COALESCE(A.BJDEAMT,0)               \n" );
					sql.append( "              WHEN C.ATDECR='2' THEN 0 END CHAAMT,                       \n" );
					sql.append( "         CASE WHEN C.ATDECR='1' THEN 0                                   \n" );
					sql.append( "              WHEN C.ATDECR='2' THEN COALESCE(A.BJCRAMT,0) END DAEAMT,   \n" );
					sql.append( "         C.REMARK, D.FSREFVAL, G.VEND_NM VENDNM,                         \n" );
					sql.append( "         B.SSDAT||'-'||B.SSNBR  AS SSDATNBR ,                            \n" );
					sql.append( "         B.SSDAT, B.SSNBR, C.FSNUM,                                      \n" );
					if(!str[6].equals("")){
						sql.append( "  CASE WHEN B2.FSREFCD='"+str[6]+"' THEN B2.FSREFVAL END FSREFVAL, E.CDNAM FSREFNM \n" );
					}else{
						sql.append( "  '' FSREFVAL, '' FSREFNM \n" );
					}
					sql.append( "    FROM ACCOUNT.BANJAEREL A                   										\n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE        		\n" );
					sql.append( "     					AND A.BTSDAT= B.FSDAT                                           	\n" );
					sql.append( "     					AND A.BTSNBR = B.FSNBR                                          	\n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPDTL C ON A.FDCODE = C.FDCODE        		\n" );
					sql.append( "     					AND A.BTSDAT= C.FSDAT                                           	\n" );
					sql.append( "     					AND A.BTSNBR = C.FSNBR                                          	\n" );
					sql.append( "     					AND A.BTSSEQ = C.FSSEQ                                          \n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPREF D ON A.FDCODE = D.FDCODE         		\n" );
					sql.append( "     					AND A.BTSDAT= D.FSDAT                                           	\n" );
					sql.append( "    	 				AND A.BTSNBR = D.FSNBR                                          	\n" );
					sql.append( "     					AND A.BTSSEQ = D.FSSEQ                                          	\n" );
					sql.append( "     					AND D.FSREFCD ='0020'                                           	\n" );				
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER G ON D.FSREFVAL = G.VEND_CD   \n" );
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER G ON D.FSREFVAL = G.VEND_CD        \n" );
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE H ON C.ATCODE = H.ATCODE               \n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPREF B2 ON A.FDCODE= B2.FDCODE         \n" );
					sql.append( "                                      AND A.BTSDAT = B2.FSDAT    \n" ); 
					sql.append( "                                      AND A.BTSNBR = B2.FSNBR    \n" );
					sql.append( "                                      AND A.BTSSEQ = B2.FSSEQ    \n" ); 
					if(!str[6].equals(""))sql.append( "                          AND B2.FSREFCD ='"+str[6]+"' \n" );
					if(!str[0].equals(""))sql.append( "                          AND A.FDCODE = '"+str[0]+"'  \n" ); 
					if(!str[1].equals(""))sql.append( "                          AND A.TSDAT ='"+str[1]+"' \n" );
					if(!str[2].equals(""))sql.append( "                          AND A.TSNBR ='"+str[2]+"' \n" ); 
					if(!str[3].equals(""))sql.append( "                          AND A.TSSEQ ='"+str[3]+"' \n" ); 
          			sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL E ON B2.FSREFVAL = E.CDCODE AND E.CMTYPE='"+str[6]+"'    \n" );
					sql.append( "   WHERE 1 = 1                                         						\n" );
					if(!str[0].equals(""))sql.append( "     AND A.FDCODE ='"+str[0]+"'                \n" );
					if(!str[1].equals(""))sql.append( "     AND A.TSDAT ='"+str[1]+"'                 \n" );
					if(!str[2].equals(""))sql.append( "     AND A.TSNBR ='"+str[2]+"'                 \n" );
					if(!str[3].equals(""))sql.append( "     AND A.TSSEQ ='"+str[3]+"'                 \n" );
					if(!str[4].equals(""))sql.append( "     AND C.ATCODE ='"+str[4]+"'                \n" );
					if(!str[5].equals(""))sql.append( "     AND ( D.FSREFCD ='0020' AND D.FSREFVAL ='"+str[5]+"') \n" );
					
					//System.out.println("a020003_s2:\n"+sql.toString());
					//logger.dbg.println(this , sql.toString());
					
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