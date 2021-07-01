package transfer;

import com.gauce.*;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import java.sql.*;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;


// class 이름은 화일명과 항상 동일해야 함.
public class dsProject_s01_jys extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		//ServiceLoader loader = new ServiceLoader(req, res);
		//GauceService service = null;
		//GauceContext context = null;
		//Logger logger = null;
		//GauceDBConnection conn = null;
		//GauceStatement stmt =null;
		
		//추가
		Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
		
		GauceDataSet dSet = null;	
		//GauceDataSet getDataSet=null;

		try {
			//service = loader.newService();
			//context = service.getContext();
			//logger = context.getLogger();

			//GauceRequest GauceReq = service.getGauceRequest();
	        //GauceResponse GauceRes = service.getGauceResponse();

			try {
				
				
				//String paramDEPTNO = req.getParameter("goods_cd");
				
	            GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
	            GauceOutputStream gos = ((HttpGauceResponse) res).getGauceOutputStream();
				
				//conn = service.getDBConnection();
	            //JNDI connection 호출 : import javax.naming.*; 필요
	            Context initContext = (Context) new InitialContext();
	        	DataSource ds = (DataSource) initContext.lookup("CforTransfer");
	        	conn = ds.getConnection();
	            //JNDI connection 호출
	            
				dSet = new GauceDataSet();
				
				gos.fragment(dSet);
				
/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				/*
				String  str1	= req.getParameter("v_str1");    //프로젝트
				if (str1==null || str1.equals("")) str1 = "";
				String  str2	= req.getParameter("v_str2");    //프로젝트명
				if (str2==null || str2.equals("")) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "LINE_PART","PROJECT","TR_PROJECT","PROJECT_NM","DETAIL_NM",
												  "CONT_NM","CONT_DT","CONT_OWN","CONT_AMT","CONT_PED",
											      "CONT_DESC","STAY_DIV","FOOD_DIV","TRANS_DIV","USE_STS",
												  "REMARK", "CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR",
												  "USE_PROJNM"
																				}; 
				int[] intArrCN	= new int[]{   4, 10, 10, 100, 200,
																		 100,  8, 50,  13,  16,
																		 100,  1,  1,   1,   1,
																		 100, 10, 10,  10,  10,
																		 200
																	 }; 
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																		  -1, -1, -1,  2, -1,
																		  -1, -1, -1, -1, -1,
																		  -1, -1, -1, -1, -1,
																			-1
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				*/
		
				//if (!GauceReq.isBuilderRequest()) {
				
					StringBuffer sql = new StringBuffer();

		
					/* 
					sql.append( " SELECT  LINE_PART, RTRIM(PROJECT) PROJECT, RTRIM(TR_PROJECT) TR_PROJECT, PROJECT_NM, RTRIM(DETAIL_NM) DETAIL_NM,   \n" )
					   .append( "		  RTRIM(CONT_NM) CONT_NM, CONT_DT, RTRIM(CONT_OWN) CONT_OWN, COALESCE(CONT_AMT,0) CONT_AMT, RTRIM(CONT_PED) CONT_PED,\n")
					   .append( "		  CONT_DESC, STAY_DIV, FOOD_DIV, TRANS_DIV, USE_STS, \n" )
					   .append( "		  REMARK, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR, CASE WHEN DETAIL_NM='' THEN PROJECT_NM WHEN DETAIL_NM IS NULL THEN PROJECT_NM ELSE DETAIL_NM END  USE_PROJNM \n" )
					   .append( "	FROM  TRANSFER.LTUNTCOD \n" )
					   .append( "  WHERE LINE_PART <> ''  \n");
					sql.append( "    AND LINE_PART = '0001' \n" );
					*/
					
					sql.append( " SELECT USERID, USERNM FROM TRANSFER.LTUSER  \n" );

					//if (!str1.equals("")) sql.append( " AND LINE_PART = '" + str1 + "' \n" );
					//if (!str2.equals("")) sql.append( " AND (PROJECT_NM LIKE '" + str2 + "%' OR DETAIL_NM LIKE '" + str2 + "%') \n" );
				
					//sql.append( "		AND USE_STS = 'Y' \n")
					//   .append( " ORDER BY DSP_SORT ");
										
					System.out.println("sql.toString()"+sql.toString());
					stmt = conn.createStatement();
					//stmt=conn.prepareCall(sql.toString());
					
					System.out.println("1");
					rs = stmt.executeQuery(sql.toString());
					//while(rs.next()) {
				    	//System.out.println(rs.getString("USERID"));   
				    	
			        //}

					
					/*
					ResultSetMetaData rsmd = rs.getMetaData();	
					String columnName[];
					columnName = new String[rsmd.getColumnCount()]; // 조회해온 컬럼 만큼 배열을 생성한다 
					
					
				    while(rs.next()) {
				    	   
				    	for (int i = 0; i < columnName.length; i++) {
							System.out.println("i::"+i+"::getColumnName::"+rsmd.getColumnName(i+1)); 
							columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
							System.out.println("i::"+i+"::columnName::"+columnName[i]); 
							
							dSet.put(columnName[i],rs.getString(columnName[i]),rsmd.getColumnDisplaySize(i+1));
						}
			        }
					
				    dSet.heap();
					
					*/
					
					
		            System.out.println("2");
		            
					//stmt.executeQuery(sql.toString());
					//rs = (ResultSet)stmt.getObject(2);	//커서 OUT param. 					
					
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!           
		            //gos.write(sales.common.SuperServlet.getDataSet(rs,dSet));
										
					//gos.write(dSet);
		            
		            //aa gaucedateset = new GauceDataSet. ;
		            		            
		            //SuperServlet outer = new SuperServlet();          
		            
		            gos.write(sales.common.SuperServlet.getDataSet(rs, dSet));
		            
		            rs.close();
		            stmt.close();
		            conn.close();
		            
		            System.out.println("3");
/*********************************************************************************************/

					//stmt = conn.getGauceStatement(sql.toString());
	 				//stmt.executeQuery(dSet);
				//}
			} catch(Exception e) {
		  	//logger.err.println(this,e);
		
		  
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
			}

		 // dSet.flush();
		  //GauceRes.commit();
		  //GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		} finally {
			//loader.restoreService(service);
  	}
	}
}