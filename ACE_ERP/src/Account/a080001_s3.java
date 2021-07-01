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
public class a080001_s3 extends HttpServlet {
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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");	//부서코드
				str[1]	= req.getParameter("v_str2");	//본부 or 일반
				str[2]	= req.getParameter("v_str3");	//사용자 부서
				str[3]	= req.getParameter("v_str4");	//관리지원본부

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

                     
				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{ "BGTDIVCD","BGTDEPT","BGTNAM" }; 
				int[] intArrCN = new int[] {	 4,  4, 40 };			
				int[] intArrCN2 = new int[]{	-1, -1, -1 };
				for (int i=0; i<strArrCN.length; i++) { 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT DISTINCT RTRIM(A.GBCD) BGTDIVCD,	     							\n");
					sql.append( "				 RTRIM(A.CDCODE) BGTDEPT,  RTRIM(A.CDNAM) BGTNAM	\n");
					sql.append( " FROM ACCOUNT.COMMDTIL A														\n");
					sql.append( " WHERE A.CMTYPE='0003'		   														\n");				
					sql.append( "   AND (RTRIM(A.DSUDT) IS NULL) 								\n");	
					
					if(!str[3].equals("Y")) {
						sql.append( " AND A.GBCD IN (SELECT BGTDIVCD FROM PAYROLL.HCDEPT		\n");
						sql.append( "				  WHERE TREECD <> '99999999'				    			\n");
						sql.append( "				    AND DEPTCD IS NOT NULL AND USEYN='T'	 					\n");
						sql.append( "				    AND DEPTCD LIKE '"+str[0]+"%')							\n");
						sql.append( " AND A.CDCODE IS NOT NULL															\n");
					}
					
					if(str[1].equals("Y")) {	    //본부
						sql.append( " AND SUBSTR(A.CDCODE,3,2)='00'				\n");
					}else if(str[1].equals("N")) {	//그외
						sql.append( " AND SUBSTR(A.CDCODE,3,2)<>'00'			\n");					
					}        
                    if(!str[3].equals("Y")) {   
					sql.append( "  OR ( A.CMTYPE='0003' AND A.CDCODE = '1080')  \n");
                    sql.append( "  OR ( A.CMTYPE='0003' AND A.CDCODE = '1089')  \n");					  
                    } 

					if(!str[2].equals("")) {
						sql.append( " AND A.CDCODE IN (SELECT BGTDEPT FROM PAYROLL.HCDEPT		\n");
						sql.append( "			    	 WHERE TREECD <> '99999999'		        			\n");
						sql.append( "						   AND DEPTCD IS NOT NULL AND USEYN='T'		\n");
						sql.append( "						   AND DEPTCD='"+str[2]+"')								\n");						
					}
					                  
					sql.append( " ORDER BY BGTDEPT ");

					//System.out.println("a080001_s3: \n" + sql.toString());
					
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 		        stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try {stmt.close(); } catch (Exception e) {}
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