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
public class a070007_s8 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");    //지점코드  
				String  str2	= req.getParameter("v_str2");	 //실사일자
				

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				String  stryy0100 = str2.substring(0,4);
				stryy0100 = stryy0100+"0100";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "A01", "A02", "A03" ,"A04",  
						                          "B01", "B02", "B03" ,"B04", 
						                          "C01", "C02", "C03" ,"C04", 
						                          "D01", "D02", "D03" ,"D04",
						                          "E01", "E02", "E03" ,"E04",
						                          "ACDATE"  
				};

				int[] intArrCN = new int[]{ 15, 15,  15,  15, 
											15, 15,  15,  15,
											15, 15,  15,  15,
											15, 15,  15,  15,
											15, 15,  15,  15,
											8
				};
			
				int[] intArrCN2 = new int[]{ 0, 0,  0, 0,
											0, 0,  0, 0,
											0, 0,  0, 0,
											0, 0,  0, 0,
											0, 0,  0, 0,
											-1
						
				};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					String strAcdate_fr="";   //
					String strAcdate_to="";
					
					strAcdate_fr =str2; 
					strAcdate_to= str2;
									
					Statement stmt_10 = conn.createStatement();
					
					String sql_10 = " SELECT ACDATE, "
								  + "        CASE WHEN ACDATE ='"+str2+"' THEN AJDTFR ELSE '"+str2+"' END ACDATE_FR, " 
								  + "        CASE WHEN ACDATE ='"+str2+"' THEN AJDTTO ELSE '"+str2+"' END ACDATE_TO  " 
								  + "   FROM ACCOUNT.ACASHDTAJ  " 
								  + "  WHERE ACDATE ='"+str2+"'" ; 

					ResultSet rs_10 = stmt_10.executeQuery(sql_10); 
					
					if(rs_10.next()){
						strAcdate_fr= rs_10.getString(2);
						strAcdate_to= rs_10.getString(3);
					}
					
					
					StringBuffer sql = new StringBuffer();            
					sql.append( "  SELECT  SUM(X.A01)A01, SUM(X.A02)A02, SUM(X.A03)A03, SUM(X.A01)+SUM(X.A02)-SUM(X.A03) AS A04,                                                        \n");
					sql.append( "          SUM(X.B01)B01, SUM(X.B02)B02, SUM(X.B03)B03, SUM(X.B01)+SUM(X.B02)-SUM(X.B03) AS B04,                                                       \n");
					sql.append( "          SUM(X.C01)C01, SUM(X.C02)C02, SUM(X.C03)C03, SUM(X.C01)+SUM(X.C02)-SUM(X.C03) AS C04,                                                       \n");
					sql.append( "          SUM(X.D01)D01, SUM(X.D02)D02, SUM(X.D03)D03, SUM(X.D01)+SUM(X.D02)-SUM(X.D03) AS D04,                                                        \n");
					sql.append( "          SUM(X.E01)E01, SUM(X.E02)E02, SUM(X.E03)E03, SUM(X.E01)+SUM(X.E02)-SUM(X.E03) AS E04, '' AS ACDATE                                                        \n");
					sql.append( "     FROM (                                                                                                                                  \n");
					sql.append( "  	  SELECT                                                                                                                           \n");
					sql.append( "  		  SUM(CASE WHEN C.ACTDAT>='"+stryy0100+"' AND C.ACTDAT <'"+strAcdate_fr+"' THEN C.DETOT-C.CRTOT ELSE 0  END ) A01,                      \n");
					sql.append( "  		  SUM(CASE WHEN C.ACTDAT>='"+strAcdate_fr+"' AND C.ACTDAT <='"+strAcdate_to+"' THEN C.DETOT ELSE 0  END ) A02,                      \n");
					sql.append( "  		  SUM(CASE WHEN C.ACTDAT>='"+strAcdate_fr+"' AND C.ACTDAT <='"+strAcdate_to+"' THEN C.CRTOT ELSE 0  END ) A03,                      \n");
					sql.append( "  		  0 B01, 0 C01, 0 D01, 0 E01, 0 B02, 0 B03, 0 C02, 0 C03, 0 D02, 0 D03, 0 E02, 0 E03                                                 \n");
					sql.append( "  	     FROM ACCOUNT.TOTALBAL C                                        				                                   \n");
					sql.append( "  	    WHERE C.ATCODE IN ('1110110')                                   				                                   \n");
					sql.append( "  	      AND C.FDCODE = '"+str1+"'  											                   \n");
					sql.append( "  	      AND C.ACTDAT <= '"+strAcdate_to+"'                                                                                                   \n");
					sql.append( "  	                                                                                                                                   \n");
					sql.append( "  	 UNION ALL                                                                                                                         \n");
					sql.append( "  	 SELECT                                                                                                                            \n");
					sql.append( "  		--전기이월                                                                                                                 \n");
					sql.append( "  		0 A01, 0 A02, 0 A03,                                                                                                       \n");
					
					//2017.01.03 JYS 건수가 많지 않아서 그냥 20160100 부터 전기이월 조회 외화는 년이월 별도로 안함.
					//sql.append( "  		SUM(CASE WHEN CASHCD ='31' AND ACTDAT>='"+stryy0100+"' AND ACTDAT<'"+strAcdate_fr+"' THEN DEAMT - CRAMT ELSE 0 END) B01,                \n");
					//sql.append( "  		SUM(CASE WHEN CASHCD ='04' AND ACTDAT>='"+stryy0100+"' AND ACTDAT<'"+strAcdate_fr+"' THEN DEAMT - CRAMT ELSE 0 END) C01,                \n");
					//sql.append( "  		SUM(CASE WHEN CASHCD ='02' AND ACTDAT>='"+stryy0100+"' AND ACTDAT<'"+strAcdate_fr+"' THEN DEAMT - CRAMT ELSE 0 END) D01,                \n");
					
					sql.append( "  		SUM(CASE WHEN CASHCD ='31' AND ACTDAT>='20160100' AND ACTDAT<'"+strAcdate_fr+"' THEN DEAMT - CRAMT ELSE 0 END) B01,                \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='04' AND ACTDAT>='20160100' AND ACTDAT<'"+strAcdate_fr+"' THEN DEAMT - CRAMT ELSE 0 END) C01,                \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='02' AND ACTDAT>='20160100' AND ACTDAT<'"+strAcdate_fr+"' THEN DEAMT - CRAMT ELSE 0 END) D01,                \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='03' AND ACTDAT>='20160100' AND ACTDAT<'"+strAcdate_fr+"' THEN DEAMT - CRAMT ELSE 0 END) E01,                \n");
					
					
					sql.append( "  		--증감                                                                                                                     \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='31' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT >0 THEN DEAMT - CRAMT ELSE 0 END) B02,                  \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='31' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT <0 THEN CRAMT - DEAMT ELSE 0 END) B03,                  \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='04' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT >0 THEN DEAMT - CRAMT ELSE 0 END) C02,                  \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='04' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT <0 THEN CRAMT - DEAMT ELSE 0 END) C03,                  \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='02' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT >0 THEN DEAMT - CRAMT ELSE 0 END) D02,                  \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='02' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT <0 THEN CRAMT - DEAMT ELSE 0 END) D03,                   \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='03' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT >0 THEN DEAMT - CRAMT ELSE 0 END) E02,                  \n");
					sql.append( "  		SUM(CASE WHEN CASHCD ='03' AND ACTDAT>='"+strAcdate_fr+"' AND ACTDAT<='"+strAcdate_to+"' AND DEAMT - CRAMT <0 THEN CRAMT - DEAMT ELSE 0 END) E03                   \n");
					
					sql.append( "  	   FROM ACCOUNT.CASHHAND                                                                                                           \n");
					sql.append( "  	  WHERE FDCODE = '"+str1+"'                                                                                                         \n");
					sql.append( "  	    AND ACTDAT < ='"+strAcdate_to+"'                                                                                                       \n");
					sql.append( "  	) X                                                                                                                                \n");
					/*
					sql.append( "   FROM ACCOUNT.ACASHSUR B                                                                \n");
					sql.append( "   LEFT OUTER JOIN ACCOUNT.COMMDTIL A ON CDCODE=CASHUNIT   							   \n");
					sql.append( " WHERE CMTYPE='0055' 																	   \n");
					sql.append( "   AND A.DSUDT IS NULL											                           \n");	
					if (!str1.equals("")) sql.append( " AND FDCODE = '" + str1 + "' 									   \n");
					if (!str2.equals("")) sql.append( " AND ACDATE = '" + str2 + "'										   \n" );
					sql.append( " ORDER BY TO_NUMBER(A.PSEQ)                    									       \n");
				    */
					//logger.dbg.println(this,sql.toString());
					
                    //System.out.println("a070007_s8"+sql.toString());
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