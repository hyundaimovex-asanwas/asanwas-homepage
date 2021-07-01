package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p030006_s1 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		//GauceStatement stmt =null;
		Statement stmt = null;
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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//귀속년도

				for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{ "APPDT","CHKFLD","RECGUB","RECCOD","RECSEQ","DISKET"	};

				int[] intArrCN = new int[] {  4,	1,	1,	2,	6,	2000 }; 
				
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  0,	-1 }; 

				for (int i=0; i<strArrCN.length; i++) {
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT														\n");
						sql.append(" A.APPDT,													\n");
						sql.append(" A.CHKFLD,												\n");
						sql.append(" A.RECGUB,												\n");
						sql.append(" A.RECCOD,												\n");
						sql.append(" COALESCE(A.RECSEQ,0) RECSEQ,			\n");
						sql.append(" A.DISKET 												\n");
						sql.append(" FROM PAYROLL.YCDISKET A					\n");
						sql.append(" WHERE A.APPDT <> ''							\n");
						if (!str[0].equals("")) sql.append(" AND A.APPDT = '"+str[0]+"' \n");
						sql.append( " ORDER BY RECSEQ									\n");	
					//logger.dbg.println( this, sql.toString() );	
/*********************************************************************************************/

          stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery(sql.toString());

					String nstring = "";
					GauceDataRow row = null;

					String ntemp = "";
					//for (int a=0; a<82; a++) ntemp += "          "; //공백10*82 = 820
					for (int a=0; a<110; a++) ntemp += "          "; //공백10*110 =1100

					while (rs.next()) {
						byte [] bdata = new byte[0];
						nstring = "";
						nstring = rs.getString(6);
						nstring = nstring + ntemp;
						bdata = nstring.getBytes(); 
						//String strDesket = new String( bdata, 0, 820); //820byte 설정 
						String strDesket = new String( bdata, 0, 1100); //1100byte 설정 

						row = dSet.newDataRow();

						row.addColumnValue(rs.getString(1));  
						row.addColumnValue(rs.getString(2));	 
						row.addColumnValue(rs.getString(3));  
						row.addColumnValue(rs.getString(4));	
						row.addColumnValue(rs.getInt(5));  
						row.addColumnValue(new String(strDesket.getBytes("ksc5601"),"EUC-KR"));   //한글변환
                        //row.addColumnValue(new String(strDesket.getBytes("KSC5601"),"8859_1"));
						dSet.addDataRow(row);

					} //while

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