package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

//JNDI 관련 
import com.hmm.ejb.common.UtilDB;


// class 이름은 화일명과 항상 동일해야 함.
public class a040093_s1 extends HttpServlet {
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
		Connection conn = null;
		Statement stmt = null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      		GauceResponse GauceRes = service.getGauceResponse();

			try {
		
				//conn = UtilDB.getConnection("jdbc/hdvndus");		
				conn = UtilDB.getConnection("hdvndus");
				dSet = new GauceDataSet();
				
				//gger.dbg.println(this,"step3");

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				String   str1	= req.getParameter("v_str1"); //입금구분  1-계약금, 2-중도금, 3-잔금
				String   str2	= req.getParameter("v_str2"); //회차 
				String   str3	= req.getParameter("v_str3"); //등록구분  1-미등록, 2-등록 
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				int iparam2 = Integer.parseInt(str2);
	
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "CHK",
					                                                    "BS_ID",	        "BS_TAXKND",	"BS_DAT",	    "BS_AMT",	    "BS_TAXAMT",	
																		"BS_TOTAMT",	"BS_REMARK",	"BS_VENDID",	"BS_VENDNM",	"BS_DIRCNM",	
																		"BS_CND",	    "BS_KND",	    "BS_COMYN",	"BS_PNO1",	    "BS_PNO2",	
																		"BS_ADDR1",	"BS_ADDR2",	"BS_USE",	    "BS_STS",	    "BS_EMPNM",	
																		"BS_EMAIL",	    "BS_HPNO",	    "BS_TELNO",	"BS_INGB",	    "BS_SEQNO",	
																		"BS_DNO",	    "BS_HNO",	    "BS_TAXNO",	"BS_VENDCD",	"BS_PDTNM",	
																		"I_EMPNO",	    "I_DATE",	        "U_EMPNO",	    "U_DATE"
										
																	}; 

				int[] intArrCN = new int[]{    1, 
					                                        10,	   1,  8,	  15,	13,	
															15,	132,15,	  62,	62,
															62,	62,	1,	  10,	10,	
															132,  72,	1,	    1, 30,	
															30,	15, 15,	    1,  2,	
															4,	     4,  11,	  13,36,	
															10,	10, 10,	  10
					                    
																	}; 
			
				int[] intArrCN2 = new int[]{   -1,
					                                             0,	-1,	-1,	 0,	 0,	
																 0,	-1,	-1,	-1,	-1,	
																-1,	-1,	-1,	-1,	-1,	
																-1,	-1,	-1,	-1,	-1,	
																-1,	-1,	-1,	-1,	 0,	
																-1,	-1,	-1,	-1,	-1,	
																-1,	-1,	-1,	-1
														
															}; 
															
		
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
		
					sql.append( " SELECT 'F' CHK,  \n");
					sql.append( "              BS_ID,	            BS_TAXKND,	BS_DAT,	    BS_AMT,	        BS_TAXAMT,  		\n");
					sql.append( "              BS_TOTAMT,	BS_REMARK,	BS_VENDID,	BS_VENDNM,	BS_DIRCNM,   			\n");
					sql.append( "              BS_CND,	        BS_KND,	        BS_COMYN,	BS_PNO1,	    BS_PNO2,       	\n");
					sql.append( "              BS_ADDR1,	    BS_ADDR2,	    BS_USE,	    BS_STS,	        BS_EMPNM,    	\n");
					sql.append( "              BS_EMAIL,	    BS_HPNO,  	    BS_TELNO,	BS_INGB,  	    BS_SEQNO,	   			\n");
					sql.append( "              BS_DNO,	        BS_HNO,	        BS_TAXNO,	BS_VENDCD,	BS_PDTNM,    	\n");
					sql.append( "              I_EMPNO,	        I_DATE,	        U_EMPNO,	U_DATE                  						\n");
					sql.append( "   FROM hdas.TBS010                                                                               					\n");				
					sql.append( "   WHERE 1=1                                                                                                         	\n");
					if (!str1.equals("0")) sql.append( " AND BS_INGB = '"+str1+"' 																\n"); 
					if (iparam2!=0)        sql.append( " AND BS_SEQNO = "+iparam2+" 														\n"); 
					if (str3.equals("1")) sql.append( " AND (BS_STS='N') 																			\n"); 
					if (str3.equals("2")) sql.append( " AND (BS_STS='Y') 																			\n"); 
					
					//System.out.println("a040093_s1 : \n" + sql);
					//logger.dbg.println(this,sql.toString());
										
					stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery(sql.toString());
					GauceDataRow row =null;
					
					while(rs.next()){
						row = dSet.newDataRow();
																
						row.addColumnValue(rs.getString(1));   //     
						row.addColumnValue(rs.getDouble(2));	  //  
						row.addColumnValue(rs.getString(3));   //      
						row.addColumnValue(rs.getString(4));	  // 
						row.addColumnValue(rs.getDouble(5));   //      
						row.addColumnValue(rs.getDouble(6));	  // 
						
						row.addColumnValue(rs.getDouble(7));	  // 
						row.addColumnValue(rs.getString(8));   // 
						row.addColumnValue(rs.getString(9));   // 
						row.addColumnValue(rs.getString(10));   // 
						row.addColumnValue(rs.getString(11));   // 
						
						row.addColumnValue(rs.getString(12));   //
						row.addColumnValue(rs.getString(13));   //
						row.addColumnValue(rs.getString(14));   //
						row.addColumnValue(rs.getString(15));   //
						row.addColumnValue(rs.getString(16));   //
						
						row.addColumnValue(rs.getString(17));   //
						row.addColumnValue(rs.getString(18));   //
						row.addColumnValue(rs.getString(19));   //
						row.addColumnValue(rs.getString(20));   //
						row.addColumnValue(rs.getString(21));   //
												
						row.addColumnValue(rs.getString(22));   //
						row.addColumnValue(rs.getString(23));   //
						row.addColumnValue(rs.getString(24));   //
						row.addColumnValue(rs.getString(25));   //
						row.addColumnValue(rs.getInt(26));   //
						
						row.addColumnValue(rs.getString(27));   //
						row.addColumnValue(rs.getString(28));   //
						row.addColumnValue(rs.getString(29));   //
						row.addColumnValue(rs.getString(30));   //
						row.addColumnValue(rs.getString(31));   //
						
						row.addColumnValue(rs.getString(32));   //
						row.addColumnValue(rs.getString(33));   //
						row.addColumnValue(rs.getString(34));   //
						row.addColumnValue(rs.getString(35));   //					 
											
						dSet.addDataRow(row);
						
					}
					rs.close();
					stmt.close();
				
					//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/			
					//stmt = conn.getGauceStatement(sql.toString());
					//stmt.executeQuery(dSet);
					
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		    } finally {
				if (stmt != null) try { stmt.close();} catch (Exception e) {}
				if (conn != null) try { conn.close();} catch (Exception e) {}
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