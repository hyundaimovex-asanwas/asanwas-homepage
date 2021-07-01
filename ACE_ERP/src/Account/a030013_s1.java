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
public class a030013_s1 extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");    //기간 FROM
				String  str3	= req.getParameter("v_str3");    //기간 TO
				String  str4	= req.getParameter("v_str4");    //관리항목
				String  str5	= req.getParameter("v_str5");    //관리항목 FROM
				String  str6	= req.getParameter("v_str6");    //관리항목 TO
				String  str7	= req.getParameter("v_str7");    //계정과목

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",	"ATCODE",				
				                                                      "FSREFCD",  "FSREFVAL", "ATKORNAM", "FSREFNM" ,
																	 "BEVAL" ,"DETOT",	  "CRTOT",	  "SLPVAL"		 };
																	 
																	 
				int[] intArrCN = new int[]{ 2,  7,  
														   4,20, 66, 40,
														 13,13,13,13 }; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  
					                                          -1,  -1,  -1, -1,
															   0,   0,    0,   0  }; 
               
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;  
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
						//default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, 13,0 )); break; 
					} 
				}

				if (!GauceReq.isBuilderRequest()) {					
					String strdate="";
					String strdate2="";
					String strfrdt="";

					if (!str2.substring(4,8).equals("0101")){
						strfrdt= str2;
					    
					    //strfrdt= str2.substring(0,4)+"-"+ str2.substring(4,6)+"-"+ str2.substring(6,8);
						Statement stmt_10 = conn.createStatement();
						
						String sql_10 = "  SELECT TO_CHAR(TO_DATE( '"+strfrdt +"','YYYYMMDD')-1,'YYYY-MM-DD')  AS T_DATE "
																	+ "    FROM DUAL " ; 
      
						ResultSet rs_10 = stmt_10.executeQuery(sql_10); 
						
						if(rs_10.next()){
							strdate= rs_10.getString(1);
						}
						rs_10.close();
						
						strdate = strdate.substring(0,4)+ strdate.substring(5,7)+ strdate.substring(8,10);
					    strdate2 =strdate.substring(0,4);
					    
					}else{
						strdate = str2;
						strdate2 = strdate.substring(0,4);
					}
				
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT X.FDCODE, X.ATCODE,                                                                                                           \n" );
					sql.append( "        X.FSREFCD, X.FSREFVAL, X.ATKORNAM, X.CDNAM FSREFNM ,                                                     \n" );
					sql.append( "        SUM(X.BEVAL) BEVAL, SUM (X.DETOT) DETOT,   SUM(X.CRTOT) CRTOT,                                    \n" );
					sql.append( "        SUM(CASE WHEN X.ATDECR ='1'  THEN X.BEVAL + X.DETOT - X.CRTOT ELSE X.BEVAL+X.CRTOT - X.DETOT END) AS SLPVAL \n" );
					sql.append( "  FROM(                                                                                                                                                 \n" );
					sql.append( "  --전기이월                                                                                                                                           \n" );
					sql.append( " SELECT A.FDCODE, A.ACTDAT,  A.ATCODE,   A.COCODE,   A.DIVCD,                                                     \n" );
					sql.append( "        A.DEPTCD, A.FSREFCD, A.FSREFVAL, B.ATKORNAM, C.CDNAM , B.ATDECR,                                  \n" );
                    if (!str2.substring(4,8).equals("0101")){
					  sql.append( "       SUM(CASE WHEN A.ACTDAT >='"+strdate2+"0100'  AND A.ACTDAT  <= '"+strdate+"'    \n" );
					}else {
					  sql.append( "       SUM(CASE WHEN A.ACTDAT >='"+strdate2+"0100'  AND A.ACTDAT  < '"+strdate+"'     \n" );
					}
					sql.append( "                  THEN  CASE WHEN B.ATDECR ='1'  THEN A.DETOT - A.CRTOT                                              \n" );
					sql.append( "                   ELSE A.CRTOT - A.DETOT END  ELSE 0 END) AS BEVAL, 0 DETOT, 0 CRTOT, 0 SLPVAL       \n" );
					sql.append( "  FROM ACCOUNT.FSREFTOT A                                                                                                                \n" );
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE B ON B.ATCODE = A.ATCODE                                                                \n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL C ON A.FSREFVAL = C.CDCODE  AND C.CMTYPE= '"+str4+"'                 \n" );
					sql.append( "  WHERE A.FDCODE IS NOT NULL                                                                                                                           \n" );
					sql.append( "    AND (A.DETOT<>0 OR A.CRTOT<>0) \n" );
					 
					if(!str1.equals(""))sql.append( "  AND A.FDCODE ='"+str1+"'                                                                                            \n" );
					if (!str2.substring(4,8).equals("0101")){
						sql.append( "  AND A.ACTDAT <= '"+strdate+"'   \n" );         
					}else{
                        sql.append( "  AND A.ACTDAT < '"+strdate+"'    \n" );         
					}                                                      
					if(!str7.equals(""))sql.append( "  AND A.ATCODE ='"+str7+"'   \n" );    
					sql.append( "  AND A.FSREFCD = '"+str4+"'        \n" );
					if(!str5.equals("")&&!str6.equals(""))sql.append( "  AND A.FSREFVAL BETWEEN '"+str5+"' AND '"+str6+"'                           \n" );
                    sql.append( "  AND B.ATUSEYN='Y'                                                                                                                                 \n" );
					sql.append( "  GROUP BY A.FDCODE, A.FSREFVAL,A.ACTDAT,B.ATKORNAM,A.ATCODE,A.COCODE,A.DIVCD,A.DEPTCD,A.FSREFCD,C.CDNAM,B.ATDECR  \n" );
					
					sql.append( "                                                                                                                                                                  \n" );
					sql.append( "  UNION ALL                                                                                                                                                \n" );
					sql.append( "                                                                                                                                                                   \n" );
					sql.append( "  --일반                                                                                                                                                       \n" );
					sql.append( "  SELECT A.FDCODE, A.ACTDAT, A.ATCODE, A.COCODE, A.DIVCD,                                                               \n" );
					sql.append( "  A.DEPTCD, A.FSREFCD, A.FSREFVAL, B.ATKORNAM, C.CDNAM ,B.ATDECR,                                                \n" );
					sql.append( "  0 BEVAL,                                                                                                                                                   \n" );
					sql.append( "                                                                                                                                                                  \n" );
					sql.append( "  SUM(CASE WHEN A.ACTDAT >='"+str2+"' AND A.ACTDAT <= '"+str3+"' THEN A.DETOT ELSE 0 END) AS DETOT,                \n" );
					sql.append( "  SUM(CASE WHEN A.ACTDAT >='"+str2+"' AND A.ACTDAT <= '"+str3+"' THEN A.CRTOT ELSE 0 END) AS CRTOT,                \n" );
                    sql.append( "  SUM(CASE WHEN B.ATDECR ='1'  THEN A.DETOT - A.CRTOT ELSE A.CRTOT - A.DETOT END) AS SLPVAL                        \n" );
					sql.append( "                                                                                                                   \n" );
					sql.append( "  FROM ACCOUNT.FSREFTOT A                                                                                          \n" );
					sql.append( "                                                                                                                   \n" );
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE B ON B.ATCODE = A.ATCODE                                                               \n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL C ON A.FSREFVAL = C.CDCODE  AND C.CMTYPE= '"+str4+"'                                        \n" );
					sql.append( "  WHERE A.FDCODE IS NOT NULL                                                                                            \n" );
					sql.append( "    AND (A.DETOT<>0 OR A.CRTOT<>0) 									\n" );
					if(!str1.equals(""))sql.append( "  AND A.FDCODE ='"+str1+"'                                                                                             \n" );
					sql.append( "  AND A.ACTDAT BETWEEN '"+str2+"' AND '"+str3+"'                                                                 \n" );
					if(!str7.equals(""))sql.append( "  AND A.ATCODE ='"+str7+"'   																		\n" );    
					sql.append( "  AND A.FSREFCD = '"+str4+"'                                                                                           	\n" );
					if(!str5.equals("")&&!str6.equals(""))sql.append( "  AND A.FSREFVAL BETWEEN '"+str5+"' AND '"+str6+"'                                                                         \n" );
					sql.append( "  AND B.ATUSEYN='Y'                                                                                                			\n" );
					sql.append( "  GROUP BY A.FDCODE, A.FSREFVAL,A.ACTDAT,B.ATKORNAM,A.ATCODE,A.COCODE,A.DIVCD,A.DEPTCD,A.FSREFCD,C.CDNAM,B.ATDECR  \n" );
                   
                    sql.append( " ) X                                                                                                               						\n" );
				    sql.append( "  WHERE (X.BEVAL<>0 OR X.DETOT<>0 OR X.CRTOT<>0) 														\n" );
					sql.append( " GROUP BY X.FDCODE, X.FSREFVAL,X.ATKORNAM,X.ATCODE,X.FSREFCD,X.CDNAM                     \n" );
					
					sql.append( " ORDER BY X.FSREFVAL                   \n" );
					 
					//logger.dbg.println( this, sql.toString() );
					System.out.println(sql.toString());
					
					
/*********************************************************************************************/
                   
			       stmt = conn.getGauceStatement(sql.toString());
	 		       stmt.executeQuery(dSet);
	 		  
	 		     
                 /**
			  	 
				  Statement stmt_11 = conn.createStatement();
				   ResultSet rs_11 = stmt_11.executeQuery(sql.toString()); 
				   
				  while (rs_11.next()){
				  	
					GauceDataRow row = dSet.newDataRow();  // 레코드 생성
					row = dSet.newDataRow();
					
					 //dblbbb= rs_11.getDouble("BEVAL");
					 //s = String.valueOf(dblbbb);
					// System.out.println("dblbbb::"+dblbbb);
					// System.out.println("s::"+s);
					 
					row.addColumnValue(rs_11.getString(1)); //
					row.addColumnValue(rs_11.getString(2)); //
					row.addColumnValue(rs_11.getString(3)); //
					row.addColumnValue(rs_11.getString(4)); //
					row.addColumnValue(rs_11.getString(5)); //
					row.addColumnValue(rs_11.getString(6)); //
					row.addColumnValue(rs_11.getDouble(7)); //
					row.addColumnValue(rs_11.getDouble(8)); //
					row.addColumnValue(rs_11.getDouble(9)); //
					row.addColumnValue(rs_11.getDouble(10)); //
					
					dSet.addDataRow(row);
										 
				  }
				  
				  rs_11.close();
	 		        **/
	 		        
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