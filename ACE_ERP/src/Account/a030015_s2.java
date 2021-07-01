package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a030015_s2 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
			  
			  String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//접수일자
				str[2]	= req.getParameter("v_str3");		//접수번호
				str[3]	= req.getParameter("v_str4");		//접수행번호
				str[4]	= req.getParameter("v_str5");		//계정
				str[5]	= req.getParameter("v_str6");		//거래처
				str[6]	= req.getParameter("v_str7");		//관리항목
				str[7]	= req.getParameter("v_str8");		//관리항목값

       
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
					                           2, 20, 40}; 
			
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
					
					
					sql.append( "  SELECT B.FSSTAT, A.FDCODE, A.BTSDAT, A.BTSNBR, C.ATCODE, H.ATKORNAM,   \n" );
					sql.append( "         CASE WHEN C.ATDECR='1' THEN COALESCE(A.BJDEAMT,0)               	\n" );
					sql.append( "              WHEN C.ATDECR='2' THEN 0 END CHAAMT,                       				\n" );
					sql.append( "         CASE WHEN C.ATDECR='1' THEN 0                                   					\n" );
					sql.append( "              WHEN C.ATDECR='2' THEN COALESCE(A.BJCRAMT,0) END DAEAMT,   \n" );
					sql.append( "         C.REMARK, D.FSREFVAL, G.VEND_NM VENDNM,                         \n" );
					sql.append( "         B.SSDAT||'-'||B.SSNBR  AS SSDATNBR ,                            \n" );
					sql.append( "         B.SSDAT, B.SSNBR, C.FSNUM,                                      \n" );
					if(!str[6].equals("")){
						sql.append( "         CASE WHEN B2.FSREFCD='"+str[6]+"' THEN B2.FSREFVAL END FSREFVAL, E.CDNAM FSREFNM \n" );
					}else{
						sql.append( "         F.FSREFVAL, J.CDNAM FSREFNM \n" );
					}
					sql.append( "    FROM ACCOUNT.BANJAEREL A                    \n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.BTSDAT= B.FSDAT AND A.BTSNBR = B.FSNBR    \n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPDTL C ON A.FDCODE = C.FDCODE AND A.BTSDAT= C.FSDAT                           \n" );
					sql.append( "    														AND A.BTSNBR = C.FSNBR  AND A.BTSSEQ = C.FSSEQ                          \n" );
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPREF D ON A.FDCODE = D.FDCODE AND A.BTSDAT= D.FSDAT                           \n" );
					sql.append( "    														AND A.BTSNBR = D.FSNBR  AND A.BTSSEQ = D.FSSEQ                          \n" );
					sql.append( "    														AND D.FSREFCD ='0020'                                                   \n" );
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER G ON D.FSREFVAL = G.VEND_CD                                           \n" );
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE H ON C.ATCODE = H.ATCODE                                                  \n" );
					sql.append( "    LEFT JOIN ACCOUNT.BANJAEMST F ON A.FDCODE = F.FDCODE  AND A.TSDAT= F.TSDAT                          \n" );
					sql.append( "    														 AND A.TSNBR = F.TSNBR   AND A.TSSEQ = F.TSSEQ                          \n" );
					sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL J  ON F.FSREFVAL = J.CDCODE AND F.FSREFCD = J.CMTYPE                     \n" );
					sql.append( "    WHERE  A.FDCODE IS NOT NULL                \n" );
					if(!str[0].equals(""))sql.append( "     AND  A.FDCODE ='"+str[0]+"'                \n" );
					if(!str[1].equals(""))sql.append( "     AND A.TSDAT ='"+str[1]+"'                 \n" );
					if(!str[2].equals(""))sql.append( "     AND A.TSNBR ='"+str[2]+"'                 \n" );
					if(!str[3].equals(""))sql.append( "     AND A.TSSEQ ='"+str[3]+"'                 \n" );
					if(!str[4].equals(""))sql.append( "     AND C.ATCODE ='"+str[4]+"'                \n" );
					if(!str[5].equals(""))sql.append( "     AND ( D.FSREFCD ='0020' AND D.FSREFVAL ='"+str[5]+"') \n" );

					//logger.dbg.println(this , sql.toString());
					//System.out.println("a030015_s2 : " + sql.toString());		
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