package sales.sample;

import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
 
public class DevCodeGe extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
			select(req, res);
			
			
	}

	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		System.out.println("# Command : 조회");
		
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		ResultSet rs = null;
		ResultSetMetaData rsm = null;
		String query = "";			// SELECT절  변수 
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// Table
			String paramQuery = (String)req.getParameter("query");
			
			System.out.println(paramQuery);
		    
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds1);
					
					// 모든 사업장 얻어옴 
//					query   += "" 		
//							+ "\n\t" + "SELECT * FROM SALES." + tableName + " WHERE 1=1 "; 								
//					
//					query += whereQuery;
					query = paramQuery;
					
					// 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					rs = stmt.executeQuery(); 
					rsm = rs.getMetaData();
					
					int columnCount = rsm.getColumnCount(); // 컬럼 카운트 
				
					
					String str = "" 
							+ "\n" + "<comment id=\"__NSID__\"><object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style=\"width=300px; height:383px\" border=\"1\">" 
							+ "\n" + "	<param name=\"DataID\"		value=\"ds1\">" 
							+ "\n" + "	<param name=\"BorderStyle\"	value=\"0\">" 
							+ "\n" + "	<param name=\"Fillarea\"		value=\"true\">" 
							+ "\n" + "	<param name=\"ColSizing\"		value=\"true\">" 
							+ "\n" + "	<param name=\"IndWidth\"		value=\"0\">" 
							+ "\n" + "	<param name=\"editable\"		value=\"false\">" 
							+ "\n" + "	<param name=\"LineColor\"		value=\"#dddddd\">" 
							+ "\n" + "	<param name=\"Format\"		value=\"  "
							+ "\n" ;
					
					String bind = ""
						+ "\n" + "	<%  "
						+ "\n" + "	/*=============================================================================  "
						+ "\n" + "				Bind 선언"
						+ "\n" + "	=============================================================================*/  "
						+ "\n" + "	%>  "
						+ "\n" + "	<comment id=\"__NSID__\"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     "  
						+ "\n" + "		<param name=\"DataId\" value=\"ds1\">  "           
						+ "\n" + "		<param name=BindInfo	value=\"  " ;          
					
					String header= "";
					
					String col1 = "";
					String col2 = "";
								

					String bindColumnI = "";
					String bindColumnU = "";
					String bindColumnD = "";
					
					String inputBox = "";
					
					String insertColumn = "";
				
					String jspHeader = "";
					
					for (int i = 1; i <= columnCount ; i++ ) {
						
						// HEADER 생성
						if (rsm.getColumnTypeName(i).equals("VARCHAR")) {
							header += "\n" + "ds1.addDataColumn(new GauceDataColumn(\""+rsm.getColumnName(i).toLowerCase()+"\", 	GauceDataColumn.TB_STRING, "+rsm.getColumnDisplaySize(i)+"));";
							jspHeader += "+ " + "\""+ rsm.getColumnName(i)+":STRING,\"\n";
						} else if (rsm.getColumnTypeName(i).equals("NUMERIC")) {
							header += "\n" + "ds1.addDataColumn(new GauceDataColumn(\""+rsm.getColumnName(i).toLowerCase()+"\", 	GauceDataColumn.TB_NUMBER));";
							jspHeader +="+ " +  "\""+ rsm.getColumnName(i)+":INT,\"\n";
						} else {
							header += "\n" + "ds1.addDataColumn(new GauceDataColumn(\""+rsm.getColumnName(i).toLowerCase()+"\", 	GauceDataColumn.TB_STRING, "+rsm.getColumnDisplaySize(i)+"));";
							jspHeader +="+ " +  "\""+ rsm.getColumnName(i)+":STRING,\"\n";
						}
						str += "\n" + "		<C> name='"+rsm.getColumnName(i)+"'	ID='"+ rsm.getColumnName(i).toLowerCase()+"'	 align=left editlimit="+ rsm.getColumnDisplaySize(i) +" show=true</C>" ;
						
						bind += "\n" +"			<C>Col="+rsm.getColumnName(i).toLowerCase()+"		Ctrl="+rsm.getColumnName(i).toLowerCase()+"		Param=value </C>";
						
						col1 +="\n" +  "+ \""+ "\\" + "n"  + "\\" + "t" + "\"" + "+	" +"\"" + rsm.getColumnName(i).toLowerCase() + ",\""	;
						col2 +="\n" +  "+ \""+ "\\" + "n"  + "\\" + "t" + "\"" + "+	" +"\"" + rsm.getColumnName(i).toLowerCase() + " = ?,\""	;
						
						inputBox += "        &nbsp;&nbsp;<input type='text' id='"+rsm.getColumnName(i).toLowerCase()+"' name='"+rsm.getColumnName(i).toLowerCase()+"' value='' maxlength='"+rsm.getColumnDisplaySize(i)+"' size='"+rsm.getColumnDisplaySize(i)+"' class='textbox'>\n";
						
						if (rsm.getColumnName(i).indexOf("_") > 0) {
							insertColumn += "\nint colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1,rsm.getColumnName(i).indexOf("_")).toLowerCase()+ rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+1,rsm.getColumnName(i).indexOf("_")+2).toUpperCase() + rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+2).toLowerCase() +"  \t\t= ds1.indexOfColumn(\"" + rsm.getColumnName(i) + "\");";
							bindColumnI += "\n" + "stmt.bindColumn(iCnt++, colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1,rsm.getColumnName(i).indexOf("_")).toLowerCase()+ rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+1,rsm.getColumnName(i).indexOf("_")+2).toUpperCase() + rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+2).toLowerCase() +");";
							bindColumnU += "\n" + "stmt.bindColumn(uCnt++, colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1,rsm.getColumnName(i).indexOf("_")).toLowerCase()+ rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+1,rsm.getColumnName(i).indexOf("_")+2).toUpperCase() + rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+2).toLowerCase() +");";
							bindColumnD += "\n" + "stmt.bindColumn(dCnt++, colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1,rsm.getColumnName(i).indexOf("_")).toLowerCase()+ rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+1,rsm.getColumnName(i).indexOf("_")+2).toUpperCase() + rsm.getColumnName(i).substring(rsm.getColumnName(i).indexOf("_")+2).toLowerCase() +");";
						} else {	
							insertColumn += "\nint colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1).toLowerCase()+"  \t\t= ds1.indexOfColumn(\"" + rsm.getColumnName(i).toUpperCase() + "\");";
							bindColumnI += "\n" + "stmt.bindColumn(iCnt++, colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1).toLowerCase()+");";
							bindColumnU += "\n" + "stmt.bindColumn(uCnt++, colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1).toLowerCase()+");";
							bindColumnD += "\n" + "stmt.bindColumn(dCnt++, colNm_"+rsm.getColumnName(i).substring(0,1).toUpperCase()+rsm.getColumnName(i).substring(1).toLowerCase()+");";
						}
						System.out.println(rsm.getColumnName(i)); 
					}
					str += 	"\n"  + "	\">" + "\n" + 
					"</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>" ;
					bind += "\n" + "		\">" + "\n" +	
						"	</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>";
					
					bindColumnI += "\n";
					bindColumnU += "\n";
					bindColumnD += "\n";
					
					System.out.println("\n\n");
					System.out.println(str);
					System.out.println("\n\n");

					System.out.println("\n\n");
					System.out.println(bind);
					System.out.println("\n\n");

					System.out.println("\n\n");
					System.out.println(header);
					System.out.println("\n\n");
					
					System.out.println("\n\n");
					System.out.println(col1);
					System.out.println("\n\n");
					
					System.out.println("\n\n");
					System.out.println(col2);
					System.out.println("\n\n");
					
					System.out.println("\n\n");
					System.out.println(bindColumnI);
					System.out.println("\n\n");
					
					System.out.println("\n\n");
					System.out.println(bindColumnU);
					System.out.println("\n\n");
					
					System.out.println("\n\n");
					System.out.println(bindColumnD);
					System.out.println("\n\n");				
					
					System.out.println("\n\n");
					System.out.println(inputBox);
					System.out.println("\n\n");	
					
					System.out.println("\n\n");
					System.out.println(insertColumn);
					System.out.println("\n\n");	
					
					System.out.println("\n\n");
					System.out.println(jspHeader);
					System.out.println("\n\n");	
					
					stmt.close();
					break;
			}
		
		    
			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
			 gceRes.commit();
			 gceRes.close();
		
		}catch (Exception e) {
			e.printStackTrace();
			// Error Log 처리 요망 (log4j 사용여부)
		} finally {
			if (conn != null) {
				try {
					stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
					loader.restoreService(service);
				}
			}
		}
	}
	


}
