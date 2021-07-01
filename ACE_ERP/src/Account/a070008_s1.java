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
public class a070008_s1 extends HttpServlet {
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
		StringBuffer sql = new StringBuffer();

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
				String  str1	= req.getParameter("v_str1");    //지점코드  
				String  str2	= req.getParameter("v_str2");    //일자   
				String  str3	= req.getParameter("v_str3");    //구분(예금ㅡ,어음,보통예금)   

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				
				
				double v_num  = 0;
				v_num = Double.parseDouble(str2);
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE", "FSREFVAL", "FSAMT", "ACTDAT", "REMARK" ,"AMDIV",
																					"TAXDAT", "SGNDAT" }; 

				int[] intArrCN = new int[]{ 2, 20, 15, 8, 132 ,1,
																		8,  4 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 0, -1, -1, -1,
																		-1,  -1 };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					
					sql.append( " SELECT A.ATCODE as ATCODE, C.FSREFVAL as FSREFVAL, A.FSAMT as FSAMT, 		\n");
					sql.append( " B.ACTDAT as ACTDAT, A.REMARK as REMARK, 														\n");
					sql.append(" '"+str3+"' as AMDIV, D.TAXDAT as TAXDAT, 															\n");
					sql.append(" SUBSTR(B.SGNDAT,4,4) as SGNDAT  																	\n");
					sql.append(" FROM ACCOUNT.FSLIPDTL A 																				\n");					
					sql.append( " LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE=B.FDCODE   								\n");					
					sql.append( " 												AND A.FSDAT=B.FSDAT AND A.FSNBR=B.FSNBR  		\n");					
					sql.append( " LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE=C.FDCODE AND A.FSDAT=C.FSDAT	\n");					
					sql.append( "  											AND A.FSNBR=C.FSNBR AND A.FSSEQ=C.FSSEQ			\n");
					sql.append( " LEFT JOIN ACCOUNT.ATTAXMST D ON A.ACNNBR=D.TAXNBR 									\n");
					sql.append( " WHERE A.ATDECR='2' AND  C.FSREFCD='0020' AND 												\n");
					if(v_num >= 20061001) sql.append("  B.FSKND='6' AND 																\n");			
					if(str3.equals("A")) sql.append( " A.ATCODE IN('1110110','2100120','2100440') 								\n");
					else if(str3.equals("B")) sql.append( " A.ATCODE IN('1110110','2100440') 									\n");
					else if(str3.equals("D")) sql.append( " A.ATCODE IN('2100120') 													\n");
					sql.append( " AND A.FDCODE like '" + str1 + "'||'%'  AND B.ACTDAT='" + str2 + "' 							\n");
					sql.append( " AND B.FSSTAT='Y'  																							\n");
					sql.append( " ORDER BY ATCODE 																							\n");

					System.out.println("# a070008_s1 : \n" + sql.toString());
					//logger.dbg.println(this,sql.toString());

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
		  GauceRes.commit(sql.toString());
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}