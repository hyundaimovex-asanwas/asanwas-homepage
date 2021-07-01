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
public class a050005_s05 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//����
				String  str2 = req.getParameter("v_str2");	//�⵵
				String  str3 = req.getParameter("v_str3");	//����Ⱓfrom
				String  str4 = req.getParameter("v_str4");	//����Ⱓfrom

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
          "DATADIV","VENDID","VENDSEQ","VENDIDVS","VENDNAME",
          "BSNSCND","BSNSKND","WINEGM","WINESM","BOOKNUM",
          "TAXATION","FILLER","SHTCNT","BLKCNT","REQAMT",
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

			          sql.append("\n SELECT                                           ");
			          sql.append("\n DATADIV,VENDID,VENDSEQ,VENDIDVS,VENDNAME,        ");
			          sql.append("\n BSNSCND,BSNSKND,WINEGM,WINESM,BOOKNUM,           ");
			          sql.append("\n TAXATION,TRIM(FILLER) FILLER,nvl(SHTCNT,0) SHTCNT,         ");
			          sql.append("\n nvl(BLKCNT,0) BLKCNT,nvl(REQAMT,0) REQAMT, ");
			          sql.append("\n nvl(VATAMT,0) VATAMT                          ");
			          sql.append("\n  FROM ACCOUNT.AVATRPT2                           ");
			          sql.append("\n WHERE FDCODE IS NOT NULL																														\n");
			          if(!str1.equals(""))  sql.append( "\n AND FDCODE = '"+str1+"'																\n");
			          if(!str2.equals(""))  sql.append( "\n AND ACCYY  = '"+str2+"'																\n");
			          if(!str3.equals(""))  sql.append( "\n AND ACCYYQT = '"+str3+"'															\n");

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