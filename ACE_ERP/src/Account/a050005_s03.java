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
public class a050005_s03 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//지점
				String  str2 = req.getParameter("v_str2");	//년도
				String  str3 = req.getParameter("v_str3");	//기수기간from
				String  str4 = req.getParameter("v_str4");	//기수기간from

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
          "DATADIV"  , "VENDID"  , "VENDSEQ" , "VENDIDVS" , "VENDNAME" ,
          "BSNSCND"  , "BSNSKND" , "WINEGM"  , "WINESM"   , "BOOKNUM"  ,
          "TAXATION" , "FILLER"  , "SHTCNT"  , "BLKCNT"   , "REQAMT"   ,
          "VATAMT"
        }; 

				int[] intArrCN  = new int[]{
          1  ,10 ,4  ,10 ,30 ,
          17 ,25 ,1  ,1  ,4  ,
          3  ,28 ,7  ,2  ,14 ,
          13
        }; 
			
				int[] intArrCN2 = new int[]{
          -1 ,-1 ,-1 ,-1 ,-1 ,
          -1 ,-1 ,-1 ,-1 ,-1 ,
          -1 ,-1 , 0 , 0 , 0 ,
           0
        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

			          sql.append("\n SELECT                                                 "); 
			          sql.append("\n   TRIM(DATADIV) DATADIV,TRIM(VENDID) VENDID,TRIM(VENDSEQ) VENDSEQ,TRIM(VENDIDVS) VENDIDVS,TRIM(VENDNAME) VENDNAME,            "); 
			          sql.append("\n   TRIM(BSNSCND) BSNSCND,TRIM(BSNSKND) BSNSKND,TRIM(WINEGM) WINEGM,TRIM(WINESM) WINESM,TRIM(BOOKNUM) BOOKNUM,               ");
			          sql.append("\n   TRIM(TAXATION) TAXATION,TRIM(FILLER) FILLER,nvl(SHTCNT,0) SHTCNT,             ");
			          sql.append("\n   nvl(BLKCNT,0) BLKCNT,nvl(REQAMT,0) REQAMT, nvl(VATAMT,0) VATAMT  ");
			          sql.append("\n  FROM ACCOUNT.AVATRPT1                                 ");
			          sql.append("\n WHERE FDCODE IS NOT NULL																														\n");
			          if(!str1.equals(""))  sql.append( "\n AND FDCODE  = '"+str1+"'															\n");
			          if(!str2.equals(""))  sql.append( "\n AND ACCYY   = '"+str2+"'															\n");
			          if(!str3.equals(""))  sql.append( "\n AND ACCYYQT = '"+str3+"'															\n");
					  sql.append("\n  AND LENGTH(TRIM(VENDIDVS))<>'13'							\n");
					

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