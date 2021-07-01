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
public class commiface_s2 extends HttpServlet {
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
				String [] str = new String[5];
				str[0]= req.getParameter("v_str1");//지점
				str[1]= "";
				str[2]= req.getParameter("v_str3");//업무
				str[3]= req.getParameter("v_str4");//회계일자 fr
				str[4]= req.getParameter("v_str5");//회계일자 to
				
        for (int s=0;s<=4;s++){
					if(str[s]==null)str[s]="";	
        }
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FDCODE",   "FSDAT",  "FSNBR",    "FSSEQ",  "ATCODE",
					                                 "ATDECR",   "FSAMT" , "ACNNBR",   "ERCODE", "ERAMT",
				                                   "ERCRORAT", "REMARK" ,"GUBN",     "WRDT",   "WRID"
				}; 

      
				int[] intArrCN = new int[]{ 2, 9, 6, 5, 7,
					                          1,15, 9, 3,15,
				                            6,132,2, 8,7
					                       
				}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,
					                           -1, 0,-1,-1, 2,
					                            2,-1,-1,-1,-1
					                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
		
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT A.FDCODE,   A.FSDAT,  A.FSNBR,  A.FSSEQ,  COALESCE(A.ATCODE,'')ATCODE,  ");
					sql.append( "         COALESCE(A.ATDECR,'')ATDECR,   A.FSAMT,   COALESCE(A.ACNNBR,'')ACNNBR, COALESCE(A.ERCODE,'')ERCODE, COALESCE(A.ERAMT,0)ERAMT,   ");
					sql.append( "         COALESCE(A.ERCRORAT,0)ERCRORAT, A.REMARK, A.GUBN,   A.WRDT,   A.WRID     ");
					sql.append( "   FROM ACCOUNT.BFSLIPDTL A ");
					sql.append( "  WHERE A.FDCODE<>'' " );
					if (!str[0].equals("")) sql.append( " AND A.FDCODE='" + str[0] + "' "  );	
					if (!str[2].equals("")) sql.append( " AND SUBSTR(A.FSDAT,1,1)='" + str[2] + "' "  );	
					if (!str[3].equals("")&&!str[4].equals("")) sql.append( " AND SUBSTR(A.FSDAT,2,9) BETWEEN '" + str[3] + "' AND '" + str[4] + "'"  );			

/******************************************************************************************/

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