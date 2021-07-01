package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class hcdept_s9 extends HttpServlet {

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
				
				String str1 = req.getParameter("v_str1");
				String str2 = req.getParameter("v_str2");

				if (str1 == null) { str1 = ""; }
				if (str2 == null) { str2 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD","DEPTNM","DEPTNMK","DEPTNME","DEPTPRT",
																					"TREECD","FRDT","TODT","USEYN","REDTAXYN",
																					"LEVEL","DEPTGB"
																				};

				int[] intArrCN = new int[]{   5,  50,  70,  50,  4,
																	  	8,   8,   8,   1,  1,
																			1,   4
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	


					 //SELECT 해서 ORDER_NO 가져와와서 건별로 UPDATE 함.
					  String strTreecd ="";
						String strLevel="";
						String tempTreecd ="";

						StringBuffer sql0 = new StringBuffer();
						sql0.append(" SELECT TREECD, LEVEL   \n")
							  .append("   FROM PAYROLL.HCDEPT  \n")
                .append("  WHERE 1=1     \n")
							  .append("    AND CHGYM = ( SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )  \n")
					      .append( "   AND DEPTCD = '"+str1+"' "); 

						Statement stmt0 = null;
						ResultSet rs0 = null;
						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());
						            
						while (rs0.next())	{
							strTreecd= rs0.getString(1);
							strLevel= rs0.getString(2);
            }
						stmt0.close();
						rs0.close();

          if (strLevel.equals("1")) tempTreecd = strTreecd.substring(0,2);
					if (strLevel.equals("2")) tempTreecd = strTreecd.substring(0,2);
					if (strLevel.equals("3")) tempTreecd = strTreecd.substring(0,4);
					if (strLevel.equals("4")) tempTreecd = strTreecd.substring(0,6);
					if (strLevel.equals("5")) tempTreecd = strTreecd;



          int intcnt = 0;
          if(!str2.equals("")){
         
						Statement stmt10_0 = conn.createStatement();
						StringBuffer sql10_0 = new StringBuffer();
						sql10_0.append( " SELECT COUNT(*) CNT           ");
						sql10_0.append( "   FROM PAYROLL.HCPLEVEL       ");
						sql10_0.append( "    WHERE  EMPNO = '"+str2+"' " );

					//	logger.dbg.println(this,"sql10_0.toString():;"+sql10_0.toString());

						ResultSet rs10_0 = stmt10_0.executeQuery(sql10_0.toString()); 

						if(rs10_0.next()){
							 intcnt= rs10_0.getInt(1);
						}
						rs10_0.close();
						stmt10_0.close();
	
			    }

          //logger.dbg.println(this,"intcnt::"+intcnt);

          if(intcnt==0){

							 StringBuffer sql = new StringBuffer();
							sql.append( " SELECT  ");
							sql.append( " DEPTCD,rtrim(DEPTNM) as  DEPTNM, rtrim(DEPTNMK) as DEPTNMK, DEPTNME,DEPTPRT, ");
							sql.append( " TREECD,FRDT,TODT,USEYN,REDTAXYN, ");
							sql.append( " COALESCE(LEVEL,'9') LEVEL, DEPTGB ");
							sql.append( " FROM PAYROLL.HCDEPT ");
							sql.append( " WHERE USEYN='T' ");
							sql.append( " AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) ");
							
							if (strLevel.equals("1")) sql.append( " AND SUBSTR(TREECD,1,2)= '" + tempTreecd +"'  \n");
							if (strLevel.equals("2")) sql.append( " AND SUBSTR(TREECD,1,2)= '" + tempTreecd +"'  \n");
							if (strLevel.equals("3")) sql.append( " AND SUBSTR(TREECD,1,4)= '" + tempTreecd +"' \n");
							if (strLevel.equals("4")) sql.append( " AND SUBSTR(TREECD,1,6)= '" + tempTreecd +"'  \n");
							if (strLevel.equals("5")) sql.append( " AND TREECD= '" + tempTreecd +"'  \n");

							sql.append( " ORDER BY DEPTCD ");
							//logger.dbg.println(this,"sql11111111111:;"+sql.toString());
							stmt = conn.getGauceStatement(sql.toString());
	 		        stmt.executeQuery(dSet);

						  //logger.dbg.println(this,sql.toString());

				  }else{
             StringBuffer sql = new StringBuffer();
            sql.append( "  SELECT ");
						sql.append( "  A.DEPTCD, rtrim(A.DEPTNM) as  DEPTNM, rtrim(A.DEPTNMK) as DEPTNMK, ");
            sql.append( "  A.DEPTNME,A.DEPTPRT,  A.TREECD, A.FRDT,  A.TODT, A.USEYN, A.REDTAXYN, ");
            sql.append( "  COALESCE(LEVEL,'9') LEVEL,  A.DEPTGB ");
            sql.append( "  FROM PAYROLL.HCDEPT A ");
            sql.append( "  LEFT OUTER JOIN PAYROLL.HCPLEVEL B  ON SUBSTR(A.TREECD,1,6) = B.TREECD ");
            sql.append( "  WHERE USEYN='T' ");
            sql.append( "  AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) ");
            sql.append( "  AND EMPNO = '"+str2+"'  ");

            //logger.dbg.println(this,"sq22222222222222:;"+sql.toString());
            stmt = conn.getGauceStatement(sql.toString());
	 		      stmt.executeQuery(dSet);
					//  logger.dbg.println(this,sql.toString());
					}

					
				
/*********************************************************************************************/

					
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